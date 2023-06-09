

# WordPress Backup Script

This script is designed to backup your WordPress folder and database and transfer them to S3.

## Prerequisites

- [s3cmd](https://s3tools.org/s3cmd) installed on your server
- An S3 account with access key and secret key
- A bucket created in your S3 account

## Installation

1. Clone this repository to your server.
2. Open the `backup.sh` file in a text editor.
3. Replace the variables with your own values:
   - `S3_ACCOUNT_ENDPOINT`: Your S3 account endpoint
   - `S3_ACCOUNT_SECRET_KEY`: Your S3 account secret key
   - `S3_ACCOUNT_ACCESS_KEY`: Your S3 account access key
   - `S3_BUCKET_NAME`: Your S3 bucket name
   - `DB_HOST`: Your database host
   - `DB_NAME`: Your database name
   - `DB_USERNAME`: Your database username
   - `DB_PASSWORD`: Your database password
   - `WP_FOLDER`: The path to your WordPress folder
4. Save the file.

## Usage

1. Open a terminal window.
2. Navigate to the directory where you saved the script.
3. Run the following command:

```
./backup.sh
```

The script will backup your WordPress folder and database and transfer them to S3.

## License

This script is released under the [MIT License](https://opensource.org/licenses/MIT).

Please let me know if you have any questions or if there's anything else I can help you with!
