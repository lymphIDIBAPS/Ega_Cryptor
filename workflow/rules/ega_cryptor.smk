#### Snakemake Ega-Cryptor ####


# Load Configuration File
configfile: "config/configfile.yaml"


# Get values from configuration file
output_path = config["output"]


# Load common functions
include: "../rules/common.smk"


rule ega_cryptor:
    output:
        finish_file=(f"{output_path}/finished.txt"),
    params:
        resource_flag=set_resource_value(),
        output_path=output_path,
        ega_cryptor_path=ega_cryptor_path,
        input_path=input_path,
    log:
        error="logs/ega_cryptor/error.log",
        stdr="logs/ega_cryptor/stdr.log",
    conda:
        "../envs/ega_cryptor.yaml"
    envmodules:
        "java/12.0.2",
    shell:
        """
        mkdir -p {params.output_path}
        java -jar {params.ega_cryptor_path} -i {params.input_path} -o {params.output_path} -{params.resource_flag} > {log.stdr} 2> {log.error}
        touch {output.finish_file}
        """
