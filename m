From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 36/69] perf trace: Add a strtoul() method to 'struct syscall_arg_fmt'
Date: Fri, 11 Oct 2019 17:05:26 -0300
Message-ID: <20191011200559.7156-37-acme@kernel.org>
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

This will go from a string to a number, so that filter expressions can
be constructed with strings and then, before applying the tracepoint
filters (or eBPF, in the future) we can map those strings to numbers.

The first one will be for 'msr' tracepoint arguments, but real quickly
we will be able to reuse all strarrays for that.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-wgqq48agcgr95b8dmn6fygtr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2c1968061b4b..faa5bf4a5a3a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -86,8 +86,12 @@
 # define F_LINUX_SPECIFIC_BASE	1024
 #endif
 
+/*
+ * strtoul: Go from a string to a value, i.e. for msr: MSR_FS_BASE to 0xc0000100
+ */
 struct syscall_arg_fmt {
 	size_t	   (*scnprintf)(char *bf, size_t size, struct syscall_arg *arg);
+	bool	   (*strtoul)(char *bf, size_t size, struct syscall_arg *arg, u64 *val);
 	unsigned long (*mask_val)(struct syscall_arg *arg, unsigned long val);
 	void	   *parm;
 	const char *name;
@@ -1543,8 +1547,10 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
                } else {
 			struct syscall_arg_fmt *fmt = syscall_arg_fmt__find_by_name(field->name);
 
-			if (fmt)
+			if (fmt) {
 				arg->scnprintf = fmt->scnprintf;
+				arg->strtoul   = fmt->strtoul;
+			}
 		}
 	}
 
-- 
2.21.0
