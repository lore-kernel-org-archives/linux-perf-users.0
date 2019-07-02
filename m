From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 17/43] perf kallsyms: Adopt hex2u64 from tools/perf/util/util.h
Date: Mon,  1 Jul 2019 23:25:50 -0300
Message-ID: <20190702022616.1259-18-acme@kernel.org>
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

Just removing more stuff from tools/perf/, this is mostly used in the
kallsyms parsing and in places in perf where kallsyms is involved, so we
get it for free there.

With this we reduce a bit more util.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-5mc1zg0jqdwgkn8c358kaba6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/symbol/kallsyms.c | 13 +++++++++++++
 tools/lib/symbol/kallsyms.h |  2 ++
 tools/perf/util/util.c      | 13 -------------
 tools/perf/util/util.h      |  1 -
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/tools/lib/symbol/kallsyms.c b/tools/lib/symbol/kallsyms.c
index 96d830545bbb..7501611abee4 100644
--- a/tools/lib/symbol/kallsyms.c
+++ b/tools/lib/symbol/kallsyms.c
@@ -16,6 +16,19 @@ bool kallsyms__is_function(char symbol_type)
 	return symbol_type == 'T' || symbol_type == 'W';
 }
 
+/*
+ * While we find nice hex chars, build a long_val.
+ * Return number of chars processed.
+ */
+int hex2u64(const char *ptr, u64 *long_val)
+{
+	char *p;
+
+	*long_val = strtoull(ptr, &p, 16);
+
+	return p - ptr;
+}
+
 int kallsyms__parse(const char *filename, void *arg,
 		    int (*process_symbol)(void *arg, const char *name,
 					  char type, u64 start))
diff --git a/tools/lib/symbol/kallsyms.h b/tools/lib/symbol/kallsyms.h
index 72ab9870454b..bd988f7b18d4 100644
--- a/tools/lib/symbol/kallsyms.h
+++ b/tools/lib/symbol/kallsyms.h
@@ -18,6 +18,8 @@ static inline u8 kallsyms2elf_binding(char type)
 	return isupper(type) ? STB_GLOBAL : STB_LOCAL;
 }
 
+int hex2u64(const char *ptr, u64 *long_val);
+
 u8 kallsyms2elf_type(char type);
 
 bool kallsyms__is_function(char symbol_type);
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index d388f80d8703..a61535cf1bca 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -434,19 +434,6 @@ size_t hex_width(u64 v)
 	return n;
 }
 
-/*
- * While we find nice hex chars, build a long_val.
- * Return number of chars processed.
- */
-int hex2u64(const char *ptr, u64 *long_val)
-{
-	char *p;
-
-	*long_val = strtoull(ptr, &p, 16);
-
-	return p - ptr;
-}
-
 int perf_event_paranoid(void)
 {
 	int value;
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 09c1b0f91f65..125e215dd3d8 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -43,7 +43,6 @@ ssize_t readn(int fd, void *buf, size_t n);
 ssize_t writen(int fd, const void *buf, size_t n);
 
 size_t hex_width(u64 v);
-int hex2u64(const char *ptr, u64 *val);
 
 extern unsigned int page_size;
 int __pure cacheline_size(void);
-- 
2.20.1
