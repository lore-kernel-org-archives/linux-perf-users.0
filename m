From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 37/69] perf trace: Introduce a strtoul() method for 'struct strarrays'
Date: Fri, 11 Oct 2019 17:05:27 -0300
Message-ID: <20191011200559.7156-38-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

And also for 'struct strarray', since its needed to implement
strarrays__strtoul(). This just traverses the entries and when finding a
match, returns (offset + index), i.e. the value associated with the
searched string.

E.g. "EFER" (MSR_EFER) returns:

  # grep -w EFER -B2 /tmp/build/perf/trace/beauty/generated/x86_arch_MSRs_array.c
  #define x86_64_specific_MSRs_offset 0xc0000080
  static const char *x86_64_specific_MSRs[] = {
	[0xc0000080 - x86_64_specific_MSRs_offset] = "EFER",
  #

  0xc0000080

This will be auto-attached to 'struct syscall_arg_fmt' entries
associated with strarrays as soon as we add a ->strarray and ->strarrays
to 'struct syscall_arg_fmt'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-r2hpaahf8lishyb1owko9vs1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 28 ++++++++++++++++++++++++++++
 tools/perf/trace/beauty/beauty.h |  5 +++++
 2 files changed, 33 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index faa5bf4a5a3a..50a1aeb997ae 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -477,6 +477,34 @@ size_t strarrays__scnprintf(struct strarrays *sas, char *bf, size_t size, const
 	return printed;
 }
 
+bool strarray__strtoul(struct strarray *sa, char *bf, size_t size, u64 *ret)
+{
+	int i;
+
+	for (i = 0; i < sa->nr_entries; ++i) {
+		if (sa->entries[i] && strncmp(sa->entries[i], bf, size) == 0 && sa->entries[i][size] == '\0') {
+			*ret = sa->offset + i;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+bool strarrays__strtoul(struct strarrays *sas, char *bf, size_t size, u64 *ret)
+{
+	int i;
+
+	for (i = 0; i < sas->nr_entries; ++i) {
+		struct strarray *sa = sas->entries[i];
+
+		if (strarray__strtoul(sa, bf, size, ret))
+			return true;
+	}
+
+	return false;
+}
+
 size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size,
 					struct syscall_arg *arg)
 {
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index aa3fac8bd1be..919ac4548bd8 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -5,6 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <sys/types.h>
+#include <stdbool.h>
 
 struct strarray {
 	u64	    offset;
@@ -29,6 +30,8 @@ struct strarray {
 size_t strarray__scnprintf(struct strarray *sa, char *bf, size_t size, const char *intfmt, bool show_prefix, int val);
 size_t strarray__scnprintf_flags(struct strarray *sa, char *bf, size_t size, bool show_prefix, unsigned long flags);
 
+bool strarray__strtoul(struct strarray *sa, char *bf, size_t size, u64 *ret);
+
 struct trace;
 struct thread;
 
@@ -51,6 +54,8 @@ struct strarrays {
 
 size_t strarrays__scnprintf(struct strarrays *sas, char *bf, size_t size, const char *intfmt, bool show_prefix, int val);
 
+bool strarrays__strtoul(struct strarrays *sas, char *bf, size_t size, u64 *ret);
+
 size_t pid__scnprintf_fd(struct trace *trace, pid_t pid, int fd, char *bf, size_t size);
 
 extern struct strarray strarray__socket_families;
-- 
2.21.0
