From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/23] perf beauty prctl: Export the 'options' strarray
Date: Fri, 14 Feb 2020 16:10:45 -0300
Message-ID: <20200214191057.26266-12-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Christian Brauner <christian.brauner@ubuntu.com>, Mike Christie <mchristi@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we can use it with strtoul, allowing string to number
conversions in filter expressions.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/beauty.h | 2 ++
 tools/perf/trace/beauty/prctl.c  | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 5a61043c2ff7..d6dfe68a7612 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -213,6 +213,8 @@ size_t syscall_arg__scnprintf_x86_arch_prctl_code(char *bf, size_t size, struct
 size_t syscall_arg__scnprintf_prctl_option(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_PRCTL_OPTION syscall_arg__scnprintf_prctl_option
 
+extern struct strarray strarray__prctl_options;
+
 size_t syscall_arg__scnprintf_prctl_arg2(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_PRCTL_ARG2 syscall_arg__scnprintf_prctl_arg2
 
diff --git a/tools/perf/trace/beauty/prctl.c b/tools/perf/trace/beauty/prctl.c
index ba2179abed00..6fe5ad5f5d3a 100644
--- a/tools/perf/trace/beauty/prctl.c
+++ b/tools/perf/trace/beauty/prctl.c
@@ -11,9 +11,10 @@
 
 #include "trace/beauty/generated/prctl_option_array.c"
 
+DEFINE_STRARRAY(prctl_options, "PR_");
+
 static size_t prctl__scnprintf_option(int option, char *bf, size_t size, bool show_prefix)
 {
-	static DEFINE_STRARRAY(prctl_options, "PR_");
 	return strarray__scnprintf(&strarray__prctl_options, bf, size, "%d", show_prefix, option);
 }
 
-- 
2.21.1
