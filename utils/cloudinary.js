const cloudinary = require('cloudinary').v2;

cloudinary.config({
    cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
    api_key: process.env.CLOUDINARY_API_KEY,
    api_secret: process.env.CLOUDINARY_API_SECRET
});

async function uploadToCloudinary(buffer, folder, publicId) {
    return new Promise((resolve, reject) => {
        const stream = cloudinary.uploader.upload_stream(
            {
                folder,
                public_id: publicId,
                resource_type: 'image',
                overwrite: true
            },
            (error, result) => {
                if (error) reject(error);
                else resolve(result);
            }
        );
        stream.end(buffer);
    });
}

async function deleteFromCloudinary(url) {
    if (!url || !url.includes('res.cloudinary.com')) return;
    try {
        const urlWithoutExt = url.replace(/\.[^.]+$/, '');
        const match = urlWithoutExt.match(/\/image\/upload\/(?:v\d+\/)?(.+)/);
        if (match && match[1]) {
            await cloudinary.uploader.destroy(match[1]);
        }
    } catch (err) {
        console.error("Error deleting from Cloudinary:", err);
    }
}

module.exports = { uploadToCloudinary, deleteFromCloudinary };
