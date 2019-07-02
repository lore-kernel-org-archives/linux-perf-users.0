From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 32/43] tools lib: Adopt strim() from the kernel
Date: Mon,  1 Jul 2019 23:26:05 -0300
Message-ID: <20190702022616.1259-33-acme@kernel.org>
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

Since we're working on moving stuff out of tools/perf/util/ to
tools/lib/, take the opportunity to adopt routines from the kernel that
are equivalent, so that tools/ code look more like the kernel.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: André Goddard Rosa <andre.goddard@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-zqy1zdu2ok17qvi0ytk8z13c@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/string.h |  2 ++
 tools/lib/string.c           | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
index cee239350a6b..e436f8037c87 100644
--- a/tools/include/linux/string.h
+++ b/tools/include/linux/string.h
@@ -31,4 +31,6 @@ static inline bool strstarts(const char *str, const char *prefix)
 
 extern char * __must_check skip_spaces(const char *);
 
+extern char *strim(char *);
+
 #endif /* _TOOLS_LINUX_STRING_H_ */
diff --git a/tools/lib/string.c b/tools/lib/string.c
index 50d400822bb3..80472e6b3829 100644
--- a/tools/lib/string.c
+++ b/tools/lib/string.c
@@ -120,3 +120,28 @@ char *skip_spaces(const char *str)
 		++str;
 	return (char *)str;
 }
+
+/**
+ * strim - Removes leading and trailing whitespace from @s.
+ * @s: The string to be stripped.
+ *
+ * Note that the first trailing whitespace is replaced with a %NUL-terminator
+ * in the given string @s. Returns a pointer to the first non-whitespace
+ * character in @s.
+ */
+char *strim(char *s)
+{
+	size_t size;
+	char *end;
+
+	size = strlen(s);
+	if (!size)
+		return s;
+
+	end = s + size - 1;
+	while (end >= s && isspace(*end))
+		end--;
+	*(end + 1) = '\0';
+
+	return skip_spaces(s);
+}
-- 
2.20.1
