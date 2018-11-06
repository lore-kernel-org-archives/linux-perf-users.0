From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/18] perf top: Display the LBR stats in callchain entry
Date: Tue,  6 Nov 2018 09:06:03 -0300
Message-ID: <20181106120612.8262-10-acme@kernel.org>
References: <20181106120612.8262-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

'perf report' has supported the displaying of LBR stats (such as cycles,
predicted%) in callchain entry.

For example:

  $ perf report --branch-history --stdio

  --1.01%--intel_idle mwait.h:29
            intel_idle cpufeature.h:164 (cycles:5)
            intel_idle cpufeature.h:164 (predicted:76.4%)
            intel_idle mwait.h:102 (cycles:41)
            intel_idle current.h:15

While 'perf top' doesn't support that.

For example:

  $ perf top -a -b --call-graph branch

  -   13.86%     0.23%  [kernel]		[k] __x86_indirect_thunk_rax
     - 13.65% __x86_indirect_thunk_rax
        + 1.69% do_syscall_64
        + 1.68% do_select
        + 1.41% ktime_get
        + 0.70% __schedule
        + 0.62% do_sys_poll
          0.58% __x86_indirect_thunk_rax

Actually it's very easy to enable this feature in 'perf top'.

With this patch, the result is:

  $ perf top -a -b --call-graph branch

  $ -   13.58%     0.00%  [kernel]		[k] __x86_indirect_thunk_rax
     $ - 13.57% __x86_indirect_thunk_rax (predicted:93.9%)
        $ + 1.78% do_select (cycles:2)
        $ + 1.68% perf_pmu_disable.part.99 (cycles:1)
        $ + 1.45% ___sys_recvmsg (cycles:25)
        $ + 0.81% unix_stream_sendmsg (cycles:18)
        $ + 0.80% ktime_get (cycles:400)
          $ 0.58% pick_next_task_fair (cycles:47)
        $ + 0.56% i915_request_retire (cycles:2)
        $ + 0.52% do_sys_poll (cycles:4)

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1540983995-20462-1-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index b2838de13de0..aa0c73e57924 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1429,6 +1429,9 @@ int cmd_top(int argc, const char **argv)
 		}
 	}
 
+	if (opts->branch_stack && callchain_param.enabled)
+		symbol_conf.show_branchflag_count = true;
+
 	sort__mode = SORT_MODE__TOP;
 	/* display thread wants entries to be collapsed in a different tree */
 	perf_hpp_list.need_collapse = 1;
-- 
2.14.4
