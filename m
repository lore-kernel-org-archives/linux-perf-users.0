From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/15] tools headers UAPI: Sync linux/fscrypt.h with the kernel sources
Date: Tue, 14 Apr 2020 13:48:48 -0300
Message-ID: <20200414164854.26026-10-acme@kernel.org>
References: <20200414164854.26026-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200414164854.26026-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Eric Biggers <ebiggers@google.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the changes from:

  e98ad464750c ("fscrypt: add FS_IOC_GET_ENCRYPTION_NONCE ioctl")

That don't trigger any changes in tooling.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/fscrypt.h' differs from latest version at 'include/uapi/linux/fscrypt.h'
  diff -u tools/include/uapi/linux/fscrypt.h include/uapi/linux/fscrypt.h

In time we should come up with something like:

  $ tools/perf/trace/beauty/fsconfig.sh
  static const char *fsconfig_cmds[] = {
  	[0] = "SET_FLAG",
  	[1] = "SET_STRING",
  	[2] = "SET_BINARY",
  	[3] = "SET_PATH",
  	[4] = "SET_PATH_EMPTY",
  	[5] = "SET_FD",
  	[6] = "CMD_CREATE",
  	[7] = "CMD_RECONFIGURE",
  };
  $

And:

  $ tools/perf/trace/beauty/drm_ioctl.sh | head
  #ifndef DRM_COMMAND_BASE
  #define DRM_COMMAND_BASE                0x40
  #endif
  static const char *drm_ioctl_cmds[] = {
  	[0x00] = "VERSION",
  	[0x01] = "GET_UNIQUE",
  	[0x02] = "GET_MAGIC",
  	[0x03] = "IRQ_BUSID",
  	[0x04] = "GET_MAP",
  	[0x05] = "GET_CLIENT",
  $

For fscrypt's ioctls.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/fscrypt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/linux/fscrypt.h b/tools/include/uapi/linux/fscrypt.h
index 0d8a6f47711c..a10e3cdc2839 100644
--- a/tools/include/uapi/linux/fscrypt.h
+++ b/tools/include/uapi/linux/fscrypt.h
@@ -163,6 +163,7 @@ struct fscrypt_get_key_status_arg {
 #define FS_IOC_REMOVE_ENCRYPTION_KEY		_IOWR('f', 24, struct fscrypt_remove_key_arg)
 #define FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS	_IOWR('f', 25, struct fscrypt_remove_key_arg)
 #define FS_IOC_GET_ENCRYPTION_KEY_STATUS	_IOWR('f', 26, struct fscrypt_get_key_status_arg)
+#define FS_IOC_GET_ENCRYPTION_NONCE		_IOR('f', 27, __u8[16])
 
 /**********************************************************************/
 
-- 
2.21.1
