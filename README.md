# Bazzite AI

This project creates a customized Bazzite GDX image to support ROCm on AMD hardware.

## Support Package Manager Tools

- Snapcraft
- Flatpak
- Appimage
- Homebrew

## Contents

- `recipes/recipe.yml`: The BlueBuild recipe to create the customized image

## Image Preparation

The image can be built using BlueBuild:

```bash
bluebuild build
```

This will create a local container image `localhost/bazzite-ai:latest` that includes:
- Build tools needed for kernel modules

## Installation

To install the image, use the following command:

```bash
sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/todoworld/bazzite-ai:latest
```

After reboot, you'll have a version of Bazzite with the ROCm-compatible kernel.

## Verifying it works

### Kernel verification
To verify the system is using the correct kernel:
```bash
uname -r
```

### ROCm verification
To verify that ROCm works correctly:
```bash
/opt/rocm/bin/rocminfo
```

## Specific Problem Solved


## Changes Made

To enable full ROCm compatibility, the following adjustments were made:

### Added Packages

- snapd

### Removed Packages

-

Several stock kernel modules and third-party drivers were removed to simplify the image:

- **Kernel components**:

- **Device modules**: 


### Installed Packages

A custom  kernel and its modules were installed to replace the removed stock  components:

This ensures maximum compatibility with AMD GPUs using the ROCm stack.

### Additional Software

- Added Obs Studio

## ISO Creation

If you are building this on Fedora Atomic, you can generate an offline ISO following [these instructions](https://blue-build.org/docs/building-isos/).  
Note: Due to size constraints, ISOs cannot be freely hosted on GitHub; alternative hosting must be used for public distribution.

```bash
sudo bluebuild generate-iso --iso-name bazzite-ai.iso image ghcr.io/ihad168/bazzite-ai:latest
```

## Credits

This project is based on [Bazzite OS](https://github.com/ublue-os/bazzite).  
Special thanks to the Bazzite team for their original image.

---

Feel free to contribute to this project by forking, making pull requests, or providing feedback!
