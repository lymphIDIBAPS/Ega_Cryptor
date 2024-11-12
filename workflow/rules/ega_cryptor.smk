# Snakemake file

rule ega_cryptor:
    output:
        test = "finished.txt",
        # md5= "",
        # gpg= "",
        # gpg_md5= ""
    shell: 
        """
        echo java -jar {ega_cryptor_path} {input_path} {output_path}
        touch {output.test}
        """