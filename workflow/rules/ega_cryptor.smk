#### Snakemake Ega-Cryptor ####

# Load Configuration File
configfile: "config/configfile.yaml"

# Get values from configuration file
output_path = config["output"]

# Set the resources flag
def set_resource_value():
    flag = config["resources"]
    if flag == "full":
        return "f"  # Value for full
    elif flag == "medium":
        return "m"  # Value for medium
    elif flag == "low":
        return "l"  # Value for low
    else:
        raise ValueError(f"Invalid resources value in config file: {flag}")

rule ega_cryptor:
    output:
        test = (f'{output_path}/finished.txt'),
        # md5= "",
        # gpg= "",
        # gpg_md5= "",
    params:
        resource_flag = set_resource_value()
    conda:
        "../envs/ega_cryptor.yaml"
    shell: 
        """
        mkdir -p {output_path}
        java -jar {ega_cryptor_path} -i {input_path} -o {output_path} -{params.resource_flag}
        touch {output.test}
        """
# echo java -jar {ega_cryptor_path} {input_path} {output_path} -{params.resource_flag}