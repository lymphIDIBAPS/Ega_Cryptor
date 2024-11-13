# Snakemake file

# Load Configuration File
configfile: "config/configfile.yaml"

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
        raise ValueError("Invalid resources value in config file")

rule ega_cryptor:
    output:
        test = "finished.txt",
        # md5= "",
        # gpg= "",
        # gpg_md5= "",
    params:
        resource_flag = set_resource_value()
    shell: 
        """
        echo java -jar {ega_cryptor_path} {input_path} {output_path} -{params.resource_flag}
        touch {output.test}
        """