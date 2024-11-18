#### Common Functions for Ega-Cryptor Application ####


# Set the resources flag
def set_resource_value():
    try:
        return {"full": "f", "medium": "m", "low": "l"}[config["resources"]]
    except KeyError:
        raise ValueError(
            f"Invalid resources value in config file: {config['resources']}"
        )
