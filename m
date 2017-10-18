From: Mengting Zhang <zhangmengting@huawei.com>
Subject: [PATCH] perf script: Add option to display guest samples in host
Date: Wed, 18 Oct 2017 15:09:54 +0800
Message-ID: <1508310594-51519-1-git-send-email-zhangmengting@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org, dsa@cumulusnetworks.com, wangnan0@huawei.com, huawei.libin@huawei.com, zhangmengting@huawei.com
List-Id: linux-perf-users.vger.kernel.org

By default, 'perf script' always exclude guest samples in host.
However, for some tracepoint events(e.g. sched_switch), the tracing
output lost sched_out samples for vcpu thread if 'perf script'
filter guest samples, which is confusing. Therefore, it'd be better
to display guest samples together with host samples.

Add '--show-guest-samples' option to display guest samples in host.

Without --show-guest-samples option,
         swapper     0 [008] 18479978.454475: sched:sched_switch: prev_comm=swapper/8 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/8:0 next_pid=7342 next_prio=120
     kworker/8:0  7342 [008] 18479978.454482: sched:sched_switch: prev_comm=kworker/8:0 prev_pid=7342 prev_prio=120 prev_state=S ==> next_comm=CPU 0/KVM next_pid=32396 next_prio=120
         swapper     0 [008] 18479979.230473: sched:sched_switch: prev_comm=swapper/8 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/8:0 next_pid=7342 next_prio=120
     kworker/8:0  7342 [008] 18479979.230478: sched:sched_switch: prev_comm=kworker/8:0 prev_pid=7342 prev_prio=120 prev_state=S ==> next_comm=CPU 0/KVM next_pid=32396 next_prio=120

With --show-guest-samples option,
         swapper     0 [008] 18479978.454475: sched:sched_switch: prev_comm=swapper/8 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/8:0 next_pid=7342 next_prio=120
     kworker/8:0  7342 [008] 18479978.454482: sched:sched_switch: prev_comm=kworker/8:0 prev_pid=7342 prev_prio=120 prev_state=S ==> next_comm=CPU 0/KVM next_pid=32396 next_prio=120
       CPU 0/KVM 32396 [008] 18479978.454516: sched:sched_switch: prev_comm=CPU 0/KVM prev_pid=32396 prev_prio=120 prev_state=S ==> next_comm=swapper/8 next_pid=0 next_prio=120
         swapper     0 [008] 18479979.230473: sched:sched_switch: prev_comm=swapper/8 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/8:0 next_pid=7342 next_prio=120
     kworker/8:0  7342 [008] 18479979.230478: sched:sched_switch: prev_comm=kworker/8:0 prev_pid=7342 prev_prio=120 prev_state=S ==> next_comm=CPU 0/KVM next_pid=32396 next_prio=120
       CPU 0/KVM 32396 [008] 18479979.230520: sched:sched_switch: prev_comm=CPU 0/KVM prev_pid=32396 prev_prio=120 prev_state=S ==> next_comm=swapper/8 next_pid=0 next_prio=120

Signed-off-by: Mengting Zhang <zhangmengting@huawei.com>
---
 tools/perf/Documentation/perf-script.txt | 3 +++
 tools/perf/builtin-script.c              | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 18dfcfa..85a080c 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -274,6 +274,9 @@ OPTIONS
 	Display context switch events i.e. events of type PERF_RECORD_SWITCH or
 	PERF_RECORD_SWITCH_CPU_WIDE.
 
+--show-guest-samples
+	Dispaly guest samples in host.
+
 --demangle::
 	Demangle symbol names to human readable form. It's enabled by default,
 	disable with --no-demangle.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 3d4c3b5..c34d241 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1340,6 +1340,7 @@ struct perf_script {
 	bool			show_switch_events;
 	bool			show_namespace_events;
 	bool			allocated;
+	bool			show_guest_samples;
 	struct cpu_map		*cpus;
 	struct thread_map	*threads;
 	int			name_width;
@@ -1557,7 +1558,7 @@ static int process_sample_event(struct perf_tool *tool,
 		return -1;
 	}
 
-	if (al.filtered)
+	if (al.filtered && (!scr->show_guest_samples || !(al.filtered & (1 << HIST_FILTER__GUEST))))
 		goto out_put;
 
 	if (cpu_list && !test_bit(sample->cpu, cpu_bitmap))
@@ -2771,6 +2772,8 @@ int cmd_script(int argc, const char **argv)
 		    "Show context switch events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-namespace-events", &script.show_namespace_events,
 		    "Show namespace events (if recorded)"),
+	OPT_BOOLEAN('\0', "show-guest-samples", &script.show_guest_samples,
+		    "Show guest samples (if recorded)"),
 	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
 	OPT_INTEGER(0, "max-blocks", &max_blocks,
 		    "Maximum number of code blocks to dump with brstackinsn"),
-- 
1.7.12.4
