From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 89/91] libsymbols kallsyms: Move hex2u64 out of header
Date: Wed,  6 May 2020 12:22:32 -0300
Message-ID: <20200506152234.21977-90-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ian Rogers <irogers@google.com>

hex2u64 is a helper that's out of place in kallsyms.h as not being
kallsyms related. Move from kallsyms.h to the only user.

Committer notes:

Move it out of tools/lib/symbol/kallsyms.c as well, as we had to leave
it there in the previous patch lest we break the build.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20200501221315.54715-4-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/symbol/kallsyms.c | 13 -------------
 tools/lib/symbol/kallsyms.h |  2 --
 tools/perf/util/symbol.c    | 14 ++++++++++++++
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/tools/lib/symbol/kallsyms.c b/tools/lib/symbol/kallsyms.c
index a5edc75c346c..e335ac2b9e19 100644
--- a/tools/lib/symbol/kallsyms.c
+++ b/tools/lib/symbol/kallsyms.c
@@ -11,19 +11,6 @@ u8 kallsyms2elf_type(char type)
 	return (type == 't' || type == 'w') ? STT_FUNC : STT_OBJECT;
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
 bool kallsyms__is_function(char symbol_type)
 {
 	symbol_type = toupper(symbol_type);
diff --git a/tools/lib/symbol/kallsyms.h b/tools/lib/symbol/kallsyms.h
index bd988f7b18d4..72ab9870454b 100644
--- a/tools/lib/symbol/kallsyms.h
+++ b/tools/lib/symbol/kallsyms.h
@@ -18,8 +18,6 @@ static inline u8 kallsyms2elf_binding(char type)
 	return isupper(type) ? STB_GLOBAL : STB_LOCAL;
 }
 
-int hex2u64(const char *ptr, u64 *long_val);
-
 u8 kallsyms2elf_type(char type);
 
 bool kallsyms__is_function(char symbol_type);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 8f4300492dc7..381da6b39f89 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -566,6 +566,20 @@ void dso__sort_by_name(struct dso *dso)
 	return symbols__sort_by_name(&dso->symbol_names, &dso->symbols);
 }
 
+/*
+ * While we find nice hex chars, build a long_val.
+ * Return number of chars processed.
+ */
+static int hex2u64(const char *ptr, u64 *long_val)
+{
+	char *p;
+
+	*long_val = strtoull(ptr, &p, 16);
+
+	return p - ptr;
+}
+
+
 int modules__parse(const char *filename, void *arg,
 		   int (*process_module)(void *arg, const char *name,
 					 u64 start, u64 size))
-- 
2.21.1
