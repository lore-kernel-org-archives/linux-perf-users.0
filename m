From: Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH] perf script: Initialize callchain_param.record_mode
Date: Thu, 13 Aug 2015 09:17:24 +0200
Message-ID: <20150813071724.GA21322@krava.brq.redhat.com>
References: <2045576.NEBzYG4lu7@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2045576.NEBzYG4lu7@agathebauer>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <mail@milianw.de>
Cc: Perf Users <linux-perf-users@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, David Ahern <dsahern@gmail.com>, Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Wed, Jul 22, 2015 at 08:48:40PM +0200, Milian Wolff wrote:
> Hey all,
> 
> I recorded a perf data file using
> 
> perf record --call-graph dwarf kwrite <some large file>
> 
> when I report it I see backtraces pointing to the user space code:
> 
> perf report --stdio -g graph --no-children
>     16.36%  kwrite           libKF5TextEditor.so.5.13.0     [.] 
> QArrayData::data                                                                                               
>                      |
>                      ---QArrayData::data
>                         |          
>                         |--15.46%-- QTypedArrayData<unsigned short>::data
> 
> but when I run perf script, I do not see _any_ backtraces into user space. 
> 
> perf script -F comm,tid,time,event,ip,sym,trace,period
> :4898  4898 17486.943365:          1 cycles: 
>                   25f83a native_write_msr_safe
>                   234f8a __intel_pmu_enable_all
>                   235010 intel_pmu_enable_all
>                   22e1ec x86_pmu_enable
>                   356fb7 perf_pmu_enable.part.53
>                   35824d perf_event_context_sched_in.isra.64
>                   358e0b perf_event_exec
>                   3e8c93 setup_new_exec
>                   439a9f load_elf_binary
>                   3e7f48 search_binary_handler
>                   3e89cf do_execveat_common.isra.15
>                   3e8e4a sys_execve
>                   78b895 return_from_execve
> 
> kwrite  4898 17486.943893:          1 cycles: 
> kwrite  4898 17486.944211:          1 cycles: 
> ...
> kwrite  4898 17486.953664:     461703 cycles: 
> kwrite  4898 17486.953838:     490150 cycles: 
>                   78d4c0 page_fault
> kwrite  4898 17486.954009:     516694 cycles: 
> ...
> kwrite  4898 17510.765568:     766937 cycles: 
>                   78979b down_write
>                   39bd82 unlink_file_vma
>                   3944d0 free_pgtables
>                   39eef6 exit_mmap
>                   275d45 mmput
>                   27b514 do_exit
>                   27bdfb do_group_exit
>                   27be84 [unknown]
>                   78b56e system_call
> 
> So it looks to me as if only kernel-space call stacks are unwound in perf 
> script. Is there a magic switch that I'm missing to get user-space stacks 
> unwound? Note I'm using perf 4.1.0 on a Linux 4.1.2 system.

hi,
right you are.. does attached patch help?

thanks,
jirka


---
Milian Wolff reported non functional DWARF unwind under perf
script. The reason is that perf script does not properly configure
callchain_param.record_mode, which is needed by unwind code.

Stealing the code from report and leaving the place for
more initialization code in a hope we could merge it with
report__setup_sample_type one day.

Reported-by: Milian Wolff <mail@milianw.de>
Link: http://lkml.kernel.org/n/tip-vtgxy0tv3gogvomyhc2c50rm@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-script.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 7b376d215e94..105332e950a9 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1561,6 +1561,22 @@ static int have_cmd(int argc, const char **argv)
 	return 0;
 }
 
+static void script__setup_sample_type(struct perf_script *script)
+{
+	struct perf_session *session = script->session;
+	u64 sample_type = perf_evlist__combined_sample_type(session->evlist);
+
+	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain) {
+		if ((sample_type & PERF_SAMPLE_REGS_USER) &&
+		    (sample_type & PERF_SAMPLE_STACK_USER))
+			callchain_param.record_mode = CALLCHAIN_DWARF;
+		else if (sample_type & PERF_SAMPLE_BRANCH_STACK)
+			callchain_param.record_mode = CALLCHAIN_LBR;
+		else
+			callchain_param.record_mode = CALLCHAIN_FP;
+	}
+}
+
 int cmd_script(int argc, const char **argv, const char *prefix __maybe_unused)
 {
 	bool show_full_info = false;
@@ -1849,6 +1865,7 @@ int cmd_script(int argc, const char **argv, const char *prefix __maybe_unused)
 		goto out_delete;
 
 	script.session = session;
+	script__setup_sample_type(&script);
 
 	session->itrace_synth_opts = &itrace_synth_opts;
 
-- 
2.4.3
