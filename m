From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/28] tools include uapi: Update linux/fs.h copy
Date: Wed, 31 Oct 2018 13:44:55 -0300
Message-ID: <20181031164508.4784-16-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Herbert Xu <herbert@gondor.apana.org.au>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To silence this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/fs.h' differs from latest version at 'include/uapi/linux/fs.h'
  diff -u tools/include/uapi/linux/fs.h include/uapi/linux/fs.h

Due to just two comments added by:

  Fixes: 578bdaabd015 ("crypto: speck - remove Speck")

So nothing that entails changes in tools/, that so far uses fs.h to
generate the mount and umount syscalls 'flags' argument integer->string
tables with:

  $ tools/perf/trace/beauty/mount_flags.sh
  static const char *mount_flags[] = {
	[4096 ? (ilog2(4096) + 1) : 0] = "BIND",
<SNIP>
	[30 + 1] = "ACTIVE",
	[31 + 1] = "NOUSER",
  };
  $
  # trace -e mount,umount mount --bind /proc /mnt
     1.228 ( 2.581 ms): mount/1068 mount(dev_name: /mnt, dir_name: 0x55f011c354a0, type: 0x55f011c38170, flags: BIND) = 0
  # trace -e mount,umount umount /proc /mnt
  umount: /proc: target is busy.
     1.587 ( 0.010 ms): umount/1070 umount2(name: /proc) = -1 EBUSY Device or resource busy
     1.799 (12.660 ms): umount/1070 umount2(name: /mnt) = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Link: https://lkml.kernel.org/n/tip-c00bqzclscgah26z2g5zxm73@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index 73e01918f996..a441ea1bfe6d 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -279,8 +279,8 @@ struct fsxattr {
 #define FS_ENCRYPTION_MODE_AES_256_CTS		4
 #define FS_ENCRYPTION_MODE_AES_128_CBC		5
 #define FS_ENCRYPTION_MODE_AES_128_CTS		6
-#define FS_ENCRYPTION_MODE_SPECK128_256_XTS	7
-#define FS_ENCRYPTION_MODE_SPECK128_256_CTS	8
+#define FS_ENCRYPTION_MODE_SPECK128_256_XTS	7 /* Removed, do not use. */
+#define FS_ENCRYPTION_MODE_SPECK128_256_CTS	8 /* Removed, do not use. */
 
 struct fscrypt_policy {
 	__u8 version;
-- 
2.14.4
