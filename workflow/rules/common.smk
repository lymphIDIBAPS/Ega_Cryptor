#### Common Functions for Ega-Cryptor Application ####

# Set the resources flag
def set_resource_value():
    flag = config["resources"]
    if flag == "full":
        return "f"
    elif flag == "medium":
        return "m"
    elif flag == "low":
        return "l"  
    else:
        raise ValueError(f"Invalid resources value in config file: {flag}")