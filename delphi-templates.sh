#!/bin/bash

# TODO does not deal with whitespace
function unixToDosPath() {
    case "$1" in
        bash)
            echo "$2" | sed 's/\//\\/g'
            ;;
        awk)
            echo "$2" | sed 's/\//\\\\/g'
            ;;
        *)
            echo "Unrecognized 1st argument unixToDosPath: $1"
            exit
            ;;
    esac
}

# what:
# These functions read in a source template to produce
# the appropirate equivalent target file for the app that
# is to be created by replacing keys in the templates
#!/bin/bash

function dproj_template_to_app() {
    awk -v app_uuid="$1" \
        -v app_name="$2" \
        -v form_name="$3" \
        -v exe_basename="$4" \
        -v rel_dpr_path="$(unixToDosPath 'awk' "$5")" \
        -v rel_pas_path="$(unixToDosPath 'awk' "$6")" \
        -v rel_build_targets="$(unixToDosPath 'awk' "$7")" \
        -v rel_exe_path="$(unixToDosPath 'awk' "$8/${4}")" \
        '{gsub("~app_uuid~", app_uuid)}
        {gsub("~rel_dpr_path~", rel_dpr_path)}
        {gsub("~app_name~", app_name)}
        {gsub("~rel_build_targets~", rel_build_targets)}
        {gsub("~rel_pas_path~", rel_pas_path)}
        {gsub("~form_name~", form_name)}
        {gsub("~rel_dpr_path~", rel_dpr_path)}
        {gsub("~rel_exe_path~", rel_exe_path)}
        {gsub("~exe_basename~", exe_basename)}
        {print $0}' "${9}/template.dproj" > "${10}"
}


# params:
# app_name(1)
function dpr_template_to_app() {
    awk -v app_name="$1" \
        -v form_name="$2" \
        -v pas_basename="$3" \
        -v rel_pas_path=$(unixToDosPath 'awk' "$4") \
        '{gsub("~app_name~", app_name)}
         {gsub("~pas_basename~", pas_basename)}
         {gsub("~rel_pas_path~", rel_pas_path)}
         {gsub("~form_name~", form_name)}
         {print $0}' "${5}/template.dpr" > "$6"
}


# params:
# form_name(1) pas_basename(2)
function pas_template_to_app() {
    awk -v form_name="$1" \
        -v pas_basename="$2" \
        '{gsub("~pas_basename~", pas_basename)}
         {gsub("~form_name~", form_name)}
         {print $0}' "${3}/template.pas" > "$4"
}

function dfm_template_to_app() {
    awk -v form_name="$1" \
        '{gsub("~form_name~", form_name)}
        {print $0}' "${2}/template.dfm" > "$3"
}

# params:
# app_name(1) capitalize_app_name(2) build_dir(3) src_dir(4) templates_dir(5)
function template_to_app() {
    app_uuid="$(uuidgen)"
    app_name="$1"
    form_name="frm${2}"
    exe_basename="${1}.exe"
    pas_basename="unt${2}"
    rel_dproj_path="${1}.dproj"
    rel_dpr_path="${1}.dpr"
    rel_pas_path="${4}/unt${2}.pas"
    rel_dfm_path="${4}/unt${2}.dfm"
    rel_build_targets="${build_dir}/\$\(Platform\)/\$\(Config\)"
    rel_exe_path="${build_dir}/\$\(Platform\)/\$\(Config\)"

    dproj_template_to_app "$app_uuid" "$app_name" "$form_name" \
                               "$exe_basename" "$rel_dpr_path" \
                               "$rel_pas_path" "$rel_build_targets" \
                               "$rel_exe_path" "$5" "$rel_dproj_path"

    dpr_template_to_app "$app_name" "$form_name" "$pas_basename" \
                        "$rel_pas_path" "$5" "$rel_dpr_path"

    pas_template_to_app "$form_name" "$pas_basename" "$5" "$rel_pas_path"
    dfm_template_to_app "$form_name" "$5" "$rel_dfm_path"
}


function dproj_console_template_to_app() {
    awk -v app_uuid="$1" \
        -v app_name="$2" \
        -v exe_basename="$3" \
        -v rel_dpr_path="$(unixToDosPath 'awk' "$4")" \
        -v rel_pas_path="$(unixToDosPath 'awk' "$5")" \
        -v rel_build_targets="$(unixToDosPath 'awk' "$6")" \
        -v rel_exe_path="$(unixToDosPath 'awk' "$8/${3}")" \
        '{gsub("~app_uuid~", app_uuid)}
        {gsub("~rel_dpr_path~", rel_dpr_path)}
        {gsub("~app_name~", app_name)}
        {gsub("~rel_build_targets~", rel_build_targets)}
        {gsub("~rel_pas_path~", rel_pas_path)}
        {gsub("~rel_dpr_path~", rel_dpr_path)}
        {gsub("~rel_exe_path~", rel_exe_path)}
        {gsub("~exe_basename~", exe_basename)}
        {print $0}' "${8}/template.dproj" > "$9"
}


# params:
# app_name(1)
function dpr_console_template_to_app() {
    awk -v app_name="$1" \
        -v pas_basename="$2" \
        -v rel_pas_path=$(unixToDosPath 'awk' "$3") \
        '{gsub("~app_name~", app_name)}
         {gsub("~pas_basename~", pas_basename)}
         {gsub("~rel_pas_path~", rel_pas_path)}
         {print $0}' "${4}/template.dpr" > "$5"
}


# params:
# form_name(1) pas_basename(2)
function pas_console_template_to_app() {
    awk -v pas_basename="$1" \
        '{gsub("~pas_basename~", pas_basename)}
         {print $0}' "${2}/template.pas" > "$3"
}


# params:
# @app_name(1)
# @capitalize_app_name(2)
# @build_dir(3)
# @src_dir(4)
# @templates_dir(5)
function console_template_to_app() {
    app_uuid="$(uuidgen)"
    app_name="$1"
    exe_basename="${1}.exe"
    pas_basename="unt${2}"
    rel_dproj_path="${1}.dproj"
    rel_dpr_path="${1}.dpr"
    rel_pas_path="${4}/unt${2}.pas"
    rel_build_targets="${build_dir}/\$\(Platform\)/\$\(Config\)"
    rel_exe_path="${build_dir}/\$\(Platform\)/\$\(Config\)"

    dproj_console_template_to_app "$app_uuid" "$app_name" "$exe_basename" \
                                  "$rel_dpr_path" "$rel_pas_path" "$rel_build_targets" \
                                  "$rel_exe_path" "$5" "$rel_dproj_path"

    dpr_console_template_to_app "$app_name" "$pas_basename" "$rel_pas_path" \
                                "$5" "$rel_dpr_path"

    pas_console_template_to_app "$pas_basename" "$5" "$rel_pas_path"
}
