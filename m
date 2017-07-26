From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/40] tools lib: Update copy of strtobool from the kernel sources
Date: Wed, 26 Jul 2017 11:17:06 -0300
Message-ID: <20170726141730.30750-17-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Kees Cook <keescook@chromium.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Getting support for "on", "off" introduced in a81a5a17d44b ("lib: add
"on"/"off" support to kstrtobool") and making it check for NULL,
introduced in ef951599074b ("lib: move strtobool() to kstrtobool()").

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Kees Cook <keescook@chromium.org>
Link: http://lkml.kernel.org/n/tip-mu8ghin4rklacmmubzwv8td7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/string.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/lib/string.c b/tools/lib/string.c
index bd239bc1d557..a4246f14ded1 100644
--- a/tools/lib/string.c
+++ b/tools/lib/string.c
@@ -39,27 +39,45 @@ void *memdup(const void *src, size_t len)
  * @s: input string
  * @res: result
  *
- * This routine returns 0 iff the first character is one of 'Yy1Nn0'.
- * Otherwise it will return -EINVAL.  Value pointed to by res is
- * updated upon finding a match.
+ * This routine returns 0 iff the first character is one of 'Yy1Nn0', or
+ * [oO][NnFf] for "on" and "off". Otherwise it will return -EINVAL.  Value
+ * pointed to by res is updated upon finding a match.
  */
 int strtobool(const char *s, bool *res)
 {
+	if (!s)
+		return -EINVAL;
+
 	switch (s[0]) {
 	case 'y':
 	case 'Y':
 	case '1':
 		*res = true;
-		break;
+		return 0;
 	case 'n':
 	case 'N':
 	case '0':
 		*res = false;
-		break;
+		return 0;
+	case 'o':
+	case 'O':
+		switch (s[1]) {
+		case 'n':
+		case 'N':
+			*res = true;
+			return 0;
+		case 'f':
+		case 'F':
+			*res = false;
+			return 0;
+		default:
+			break;
+		}
 	default:
-		return -EINVAL;
+		break;
 	}
-	return 0;
+
+	return -EINVAL;
 }
 
 /**
-- 
2.9.4
