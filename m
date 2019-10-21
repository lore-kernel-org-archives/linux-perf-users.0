From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 52/57] libbeauty: Introduce syscall_arg__strtoul_strarrays()
Date: Mon, 21 Oct 2019 10:38:29 -0300
Message-ID: <20191021133834.25998-53-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To allow going from string to integer for 'struct strarrays'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-b1ia3xzcy72hv0u4m168fcd0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 5 +++++
 tools/perf/trace/beauty/beauty.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0e7fc7cc42d9..265ea876f00b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -540,6 +540,11 @@ bool syscall_arg__strtoul_strarray(char *bf, size_t size, struct syscall_arg *ar
 	return strarray__strtoul(arg->parm, bf, size, ret);
 }
 
+bool syscall_arg__strtoul_strarrays(char *bf, size_t size, struct syscall_arg *arg, u64 *ret)
+{
+	return strarrays__strtoul(arg->parm, bf, size, ret);
+}
+
 size_t syscall_arg__scnprintf_strarray_flags(char *bf, size_t size, struct syscall_arg *arg)
 {
 	return strarray__scnprintf_flags(arg->parm, bf, size, arg->show_string_prefix, arg->val);
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 1b8a30e5dcf9..10801660a71f 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -125,6 +125,9 @@ size_t syscall_arg__scnprintf_strarray_flags(char *bf, size_t size, struct sysca
 bool syscall_arg__strtoul_strarray(char *bf, size_t size, struct syscall_arg *arg, u64 *ret);
 #define STUL_STRARRAY syscall_arg__strtoul_strarray
 
+bool syscall_arg__strtoul_strarrays(char *bf, size_t size, struct syscall_arg *arg, u64 *ret);
+#define STUL_STRARRAYS syscall_arg__strtoul_strarrays
+
 size_t syscall_arg__scnprintf_x86_irq_vectors(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_X86_IRQ_VECTORS syscall_arg__scnprintf_x86_irq_vectors
 
-- 
2.21.0
