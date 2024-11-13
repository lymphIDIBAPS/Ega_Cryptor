#### Snakemake Ega-Cryptor ####

# Load Configuration File
configfile: "config/configfile.yaml"

# Get values from configuration file
output_path = config["output"]

# Load common functions
include: "../rules/common.smk"

rule ega_cryptor:
    output:
        finish_file = (f'{output_path}/finished.txt'),
    params:
        resource_flag = set_resource_value()
    conda:
        "../envs/ega_cryptor.yaml"
    envmodules:
        "java/12.0.2"
    shell: 
        """
        mkdir -p {output_path}
        java -jar {ega_cryptor_path} -i {input_path} -o {output_path} -{params.resource_flag}
        touch {output.finish_file}
        """