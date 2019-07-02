From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/43] tools lib: Adopt skip_spaces() from the kernel sources
Date: Mon,  1 Jul 2019 23:25:56 -0300
Message-ID: <20190702022616.1259-24-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Same implementation, will be used to replace ad-hoc equivalent code in
tools/.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: André Goddard Rosa <andre.goddard@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-dig691cg9ripvoiprpidthw7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/string.h |  4 +++-
 tools/lib/string.c           | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
index 6c3e2cc274c5..cee239350a6b 100644
--- a/tools/include/linux/string.h
+++ b/tools/include/linux/string.h
@@ -29,4 +29,6 @@ static inline bool strstarts(const char *str, const char *prefix)
 	return strncmp(str, prefix, strlen(prefix)) == 0;
 }
 
-#endif /* _LINUX_STRING_H_ */
+extern char * __must_check skip_spaces(const char *);
+
+#endif /* _TOOLS_LINUX_STRING_H_ */
diff --git a/tools/lib/string.c b/tools/lib/string.c
index 93b3d4b6feac..50d400822bb3 100644
--- a/tools/lib/string.c
+++ b/tools/lib/string.c
@@ -17,6 +17,7 @@
 #include <string.h>
 #include <errno.h>
 #include <linux/string.h>
+#include <linux/ctype.h>
 #include <linux/compiler.h>
 
 /**
@@ -106,3 +107,16 @@ size_t __weak strlcpy(char *dest, const char *src, size_t size)
 	}
 	return ret;
 }
+
+/**
+ * skip_spaces - Removes leading whitespace from @str.
+ * @str: The string to be stripped.
+ *
+ * Returns a pointer to the first non-whitespace character in @str.
+ */
+char *skip_spaces(const char *str)
+{
+	while (isspace(*str))
+		++str;
+	return (char *)str;
+}
-- 
2.20.1
