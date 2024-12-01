FROM quay.io/jupyter/minimal-notebook:afe30f0c9ad8

# Ensure Conda is available and check its version
RUN conda --version || echo "Conda not found in the path"

# Install Python 3.11 and Mamba
RUN conda install -c conda-forge python=3.11 mamba -y

# Copy the lock file into the image
COPY conda-linux-64.lock /tmp/conda-linux-64.lock

# Install dependencies via mamba and clean up
RUN mamba install --file /tmp/conda-linux-64.lock -y \
    && mamba clean --all -y -f \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"
