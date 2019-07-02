From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 35/43] tools lib: Adopt strreplace() from the kernel
Date: Mon,  1 Jul 2019 23:26:08 -0300
Message-ID: <20190702022616.1259-36-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We'll use it to further reduce the size of tools/perf/util/string.c,
replacing the strxfrchar() equivalent function we have there.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-x3r61ikjrso1buygxwke8id3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/string.h |  2 ++
 tools/lib/string.c           | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
index e436f8037c87..a76d4df10435 100644
--- a/tools/include/linux/string.h
+++ b/tools/include/linux/string.h
@@ -19,6 +19,8 @@ extern size_t strlcpy(char *dest, const char *src, size_t size);
 
 char *str_error_r(int errnum, char *buf, size_t buflen);
 
+char *strreplace(char *s, char old, char new);
+
 /**
  * strstarts - does @str start with @prefix?
  * @str: string to examine
diff --git a/tools/lib/string.c b/tools/lib/string.c
index 80472e6b3829..f2ae1b87c719 100644
--- a/tools/lib/string.c
+++ b/tools/lib/string.c
@@ -145,3 +145,19 @@ char *strim(char *s)
 
 	return skip_spaces(s);
 }
+
+/**
+ * strreplace - Replace all occurrences of character in string.
+ * @s: The string to operate on.
+ * @old: The character being replaced.
+ * @new: The character @old is replaced with.
+ *
+ * Returns pointer to the nul byte at the end of @s.
+ */
+char *strreplace(char *s, char old, char new)
+{
+	for (; *s; ++s)
+		if (*s == old)
+			*s = new;
+	return s;
+}
-- 
2.20.1
