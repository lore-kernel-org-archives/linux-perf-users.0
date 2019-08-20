From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/17] perf record: Enable LBR callstack capture jointly with thread stack
Date: Tue, 20 Aug 2019 16:27:24 -0300
Message-ID: <20190820192733.19180-9-acme@kernel.org>
References: <20190820192733.19180-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820192733.19180-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexey Budankov <alexey.budankov@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

Enable '-j stack' applicability together with '--call-graph dwarf'
option so thread stack data and LBR call stack could be captured
jointly:

  $ perf record -g --call-graph dwarf,1024 -j stack,u -- stack_test

Collected LBR call stack can be used to augment DWARF call stack
calculated from the raw thread stack data and to provide more
comprehensive call stack information for cases when collected SIZE is
not enough to cover complete thread stack.

Such cases are typical for workloads that allocate large arrays of data
on its threads stacks or the possible SIZE to collect can't be large
enough due to workload nature or system configuration and this is where
hardware captured LBR call stacks can provide missing stack frames.
Possible DWARF plus LBR call stacks consolidation algorithm description
follows.

With this patch set perf report command UI currently ignores collected
LBR call stack data and still provides DWARF based call stacks
information.

  ===========================================================================

  Overview:

   Legend:

   THS - thread stack
   CTX - thread register context
   SWS - software stack
   SSF - skipped stack frames
   PSS - Perf sample stack

   ip,sp,bp - HW registers values
   d        - allocated stack regions
   kip      - ip address in the kernel space
   K        - captured thread stack size

        THS

       -----
       |   |<-stack bottom
        ...
       |---|
       |ip4|
       |---|         PSS = SWS(THS(K))
       |   |
   --> |   |
   |   |d3 |                  user/
   |   |---|         user PSS kernel PSS
   |   |ip3|         ------   ------
   |   |---|         |SSF |   |SSF |
   |   |   |          ....     ....
   |   |   |         ------   ------
   |   |d2 |         | -1 |   | -1 |
       |---|   user  ------   ------
   K   |ip2|   CTX   |ip3 |   |ip3 |
       |---|         |----|   |----|
   |   |d1 |   ...   |ip2 | , |ip2 |
   |   |---|  |---|  |----|   |----|
   |   |ip1|  |bp0|  |ip1 |   |ip1 |
   |   |---|  |---|  |----|   |----|
   |   |   |  |ip0|->|ip0 |   |ip0 |<-user stack top
   |   |   |  |---|  ------   ------
   |   |   |<-|sp0|<-stack    |kip0|<-kernel stack bottom
   --> -----  -----   top     |----|
                              |kip1|
                              |----|
		              |kip2|
		              |----|
                               ....
			      |    |<-kernel stack top
                              ------

  Algorithm details:

   Legend:

   HWS - hardware stack
   K-SWS - kernel software stack

			 BRANCH
			 TABLE

		 HWS      ip   ip
			  from to
		 ------  -----------
		 |ip7`|  |ip7`|    |
		 |----|  |----|----|
		 |ip6`|  |ip6`|    |
	user PSS |----|  |----|----|
		 |ip5`|  |ip5`|    |
	------   |----|  |----|----|
	| -1 |   |ip4`|  |ip4`|    |
	------   |----|  |----|----|
	|ip3 |~~~|ip3`|  |ip3`|    |
	|----|   |----|  |----|----|
	|ip2 |~~~|ip2`|  |ip2`|    |
	|----| 	 |----|  |----|----|
	|ip1 |~~~|ip1`|  |ip1`|ip0`|
	|----| 	 |----|  -----------
	|ip0 |~~~|ip0`|<---------'
	------   ------

	1. if (sym(ipj) == sym(ipj`)), j=0-3 ===> user PSS
	2. ipj`                      , j=4-7 ===> user PSS

  Augmented PSS = A_SWS(SWS(THS(K)), HWS):

	         user/
       user PSS  kernel PSS

	------   ------
	|ip7`|   |ip7`|<-user PSS bottom
	|----|   |----|
	|ip6`|   |ip6`|
	|----|   |----|
    HWS	|ip5`|   |ip5`|
	|----|   |----|
	|ip4`|   |ip4`|
	------   ------
	|ip3 |   |ip3 |
	|----|   |----|
    SWS |ip2 |   |ip2 |
	|----|   |----|
	|ip1 |   |ip1 |
	|----|   |----|
	|ip0 |   |ip0 |<-user PSS top
	------   ------
		 |kip0|<-kernel PSS bottom
		 |----|
		 |kip1|
	   K-SWS |----|
		 |kip2|
		 |----|
		 |kip3|<-kernel PSS top
		 ------

                  APSS

Committer testing:

Before:

  # perf record -g --call-graph dwarf,1024 -j stack,u ls > /dev/null
  unknown branch filter stack, check man page

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

      -j, --branch-filter <branch filter mask>
                            branch stack filter modes
  # perf record -g --call-graph dwarf,1024 -j u ls > /dev/null
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.054 MB perf.data (12 samples) ]
  # perf evlist -v
  cycles: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|CALLCHAIN|PERIOD|BRANCH_STACK|REGS_USER|STACK_USER|DATA_SRC, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 3, mmap_data: 1, sample_id_all: 1, exclude_guest: 1, exclude_callchain_user: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, branch_sample_type: ANY, sample_regs_user: 0xff0fff, sample_stack_user: 1024
   #

After:

  # perf record -g --call-graph dwarf,1024 -j stack,u ls > /dev/null
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.044 MB perf.data (11 samples) ]
  [root@quaco ~]# perf evlist -v
  cycles: size: 112, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|CALLCHAIN|PERIOD|BRANCH_STACK|REGS_USER|STACK_USER|DATA_SRC, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, enable_on_exec: 1, task: 1, precise_ip: 3, mmap_data: 1, sample_id_all: 1, exclude_guest: 1, exclude_callchain_user: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, branch_sample_type: USER|CALL_STACK, sample_regs_user: 0xff0fff, sample_stack_user: 1024
  #

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/e9e00090-66fb-d2a4-c90f-1d12344f7788@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-branch-options.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/parse-branch-options.c b/tools/perf/util/parse-branch-options.c
index 726e8d9e8c54..4ed20c833d44 100644
--- a/tools/perf/util/parse-branch-options.c
+++ b/tools/perf/util/parse-branch-options.c
@@ -30,6 +30,7 @@ static const struct branch_mode branch_modes[] = {
 	BRANCH_OPT("ind_jmp", PERF_SAMPLE_BRANCH_IND_JUMP),
 	BRANCH_OPT("call", PERF_SAMPLE_BRANCH_CALL),
 	BRANCH_OPT("save_type", PERF_SAMPLE_BRANCH_TYPE_SAVE),
+	BRANCH_OPT("stack", PERF_SAMPLE_BRANCH_CALL_STACK),
 	BRANCH_END
 };
 
-- 
2.21.0
