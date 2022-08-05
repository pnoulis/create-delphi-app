#!/bin/bash

read -p 'Type of app: [console, vcl, multi]: ' app_type
read -p 'Name: ' app_path

if [ ! -n "$app_type" ]; then
    echo -e "App type required! exiting..."
    exit 1
elif [ ! -n "$app_path" ]; then
    echo "App name required! exiting..."
elif [ -f "$app_path" ]; then
    echo -e "File exists!: $app_name exiting..."
    exit 1
elif [ -d "$app_path" ]; then
    echo -e "Directory exists!: $app_name exiting..."
    exit 1
fi

source ./delphi-templates.sh

abs_create_delphi_app_path="$(dirname "$(realpath "$0")")"
templates_dir="${abs_create_delphi_app_path}/templates"
abs_app_dir=`realpath "$app_path"`
app_name=`basename "$app_path"`
capitalize_app_name="$(echo "$app_name" | cut -c1 | tr [:lower:] [:upper:])$(echo "$app_name" | cut -c2-)"
build_dir="builds"
src_dir="src"
script_dir="scripts"

mkdir --parents "$abs_app_dir"/{src,scripts,lib,builds};
cd "$abs_app_dir"

# read templates and produce the requested project type
case "$app_type" in
    console)
        echo "its console"
        console_template_to_app "$app_name" "$capitalize_app_name" "$build_dir" \
                                "$src_dir" "$templates_dir/console-template"
        ;;
    vcl)
        template_to_app "$app_name" "$capitalize_app_name" "$build_dir" "$src_dir" \
                        "$templates_dir/vcl-template"
        ;;
    multi)
        echo "its multi"
        exit
        ;;
    *)
        echo "Unrecognized app type: $app_type ! exiting"
        exit
