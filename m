From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/23] tools headers uapi: Sync linux/fscrypt.h with the kernel sources
Date: Fri, 14 Feb 2020 16:10:48 -0300
Message-ID: <20200214191057.26266-15-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Eric Biggers <ebiggers@google.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the changes from:

  e933adde6f97 ("fscrypt: include <linux/ioctl.h> in UAPI header")
  93edd392cad7 ("fscrypt: support passing a keyring key to FS_IOC_ADD_ENCRYPTION_KEY")

That don't trigger any changes in tooling.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/fscrypt.h' differs from latest version at 'include/uapi/linux/fscrypt.h'
  diff -u tools/include/uapi/linux/fscrypt.h include/uapi/linux/fscrypt.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/fscrypt.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/fscrypt.h b/tools/include/uapi/linux/fscrypt.h
index 1beb174ad950..0d8a6f47711c 100644
--- a/tools/include/uapi/linux/fscrypt.h
+++ b/tools/include/uapi/linux/fscrypt.h
@@ -8,6 +8,7 @@
 #ifndef _UAPI_LINUX_FSCRYPT_H
 #define _UAPI_LINUX_FSCRYPT_H
 
+#include <linux/ioctl.h>
 #include <linux/types.h>
 
 /* Encryption policy flags */
@@ -109,11 +110,22 @@ struct fscrypt_key_specifier {
 	} u;
 };
 
+/*
+ * Payload of Linux keyring key of type "fscrypt-provisioning", referenced by
+ * fscrypt_add_key_arg::key_id as an alternative to fscrypt_add_key_arg::raw.
+ */
+struct fscrypt_provisioning_key_payload {
+	__u32 type;
+	__u32 __reserved;
+	__u8 raw[];
+};
+
 /* Struct passed to FS_IOC_ADD_ENCRYPTION_KEY */
 struct fscrypt_add_key_arg {
 	struct fscrypt_key_specifier key_spec;
 	__u32 raw_size;
-	__u32 __reserved[9];
+	__u32 key_id;
+	__u32 __reserved[8];
 	__u8 raw[];
 };
 
-- 
2.21.1
