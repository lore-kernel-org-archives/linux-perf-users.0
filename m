From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/41] perf trace: Introduce syscall_arg__scnprintf_strarray_flags
Date: Wed, 29 May 2019 10:35:39 -0300
Message-ID: <20190529133605.21118-16-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that one can just define a strarray and process it as a set of flags,
similar to syscall_arg__scnprintf_strarray() with plain arrays.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-nnt25wkpkow2w0yefhi6sb7q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 5 +++++
 tools/perf/trace/beauty/beauty.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 87b6dd3c33f5..16bb8c04c689 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -403,6 +403,11 @@ static size_t syscall_arg__scnprintf_strarray(char *bf, size_t size,
 
 #define SCA_STRARRAY syscall_arg__scnprintf_strarray
 
+size_t syscall_arg__scnprintf_strarray_flags(char *bf, size_t size, struct syscall_arg *arg)
+{
+	return strarray__scnprintf_flags(arg->parm, bf, size, arg->show_string_prefix, arg->val);
+}
+
 size_t strarrays__scnprintf(struct strarrays *sas, char *bf, size_t size, const char *intfmt, bool show_prefix, int val)
 {
 	size_t printed;
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 90c1ee708dc9..ad874e0beba5 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -108,6 +108,9 @@ struct syscall_arg {
 
 unsigned long syscall_arg__val(struct syscall_arg *arg, u8 idx);
 
+size_t syscall_arg__scnprintf_strarray_flags(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_STRARRAY_FLAGS syscall_arg__scnprintf_strarray_flags
+
 size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_STRARRAYS syscall_arg__scnprintf_strarrays
 
-- 
2.20.1
