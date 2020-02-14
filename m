From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/23] perf trace: Resolve prctl's 'option' arg strings to numbers
Date: Fri, 14 Feb 2020 16:10:46 -0300
Message-ID: <20200214191057.26266-13-acme@kernel.org>
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

  # perf trace -e syscalls:sys_enter_prctl --filter="option==SET_NAME"
     0.000 Socket Thread/3860 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7fc50b9733e8)
     0.053 SSL Cert #78/3860 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7fc50b9733e8)
^C  #

If one uses '-v' with 'perf trace', we can see the filter it puts in
place:

  New filter for syscalls:sys_enter_prctl: (option==0xf) && (common_pid != 3859 && common_pid != 2757)

We still need to allow using plain '-e prctl' and have this turn into
creating a 'syscalls:sys_enter_prctl' event so that the filter can be
applied only to it as right now '-e prctl' ends up using the
'raw_syscalls:sys_enter/sys_exit'.

The end goal is to have something like:

  # perf trace -e prctl/option==SET_NAME/

And have that use tracepoint filters or eBPF ones.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 46a72ecac427..01d542007c8b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1065,7 +1065,9 @@ static struct syscall_fmt syscall_fmts[] = {
 	{ .name	    = "poll", .timeout = true, },
 	{ .name	    = "ppoll", .timeout = true, },
 	{ .name	    = "prctl",
-	  .arg = { [0] = { .scnprintf = SCA_PRCTL_OPTION, /* option */ },
+	  .arg = { [0] = { .scnprintf = SCA_PRCTL_OPTION, /* option */
+			   .strtoul   = STUL_STRARRAY,
+			   .parm      = &strarray__prctl_options, },
 		   [1] = { .scnprintf = SCA_PRCTL_ARG2, /* arg2 */ },
 		   [2] = { .scnprintf = SCA_PRCTL_ARG3, /* arg3 */ }, }, },
 	{ .name	    = "pread", .alias = "pread64", },
-- 
2.21.1
