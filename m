From: yuzhoujian <ufo19890607@gmail.com>
Subject: [PATCH v2 0/4] perf script: Add script per-event-dump support
Date: Tue, 26 Sep 2017 14:48:58 +0800
Message-ID: <1506408542-23564-1-git-send-email-yuzhoujian@didichuxing.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Introduce a new option to print trace output to files named by the 
monitored events and update perf-script documentation accordingly.

Shown below is output of perf script command with the newly introduced
option.

         $perf record -e cycles -e cs -ag -- sleep 10
         $perf script --per-event-dump
         $ls
         perf.data-script-dump-cycles.txt perf.data-script-dump-cs.txt

Without per-event-dump support, drawing flamegraphs for different events
would be a very troublesome thing. You can monitor only one event at a time 
if you want to get flamegraphs for different events. Using this option, you 
can get the trace output files named by the monitored events, and could draw 
flamegraphs according to the event's name.

yuzhoujian (4):
Patch 1: Add a new element for the struct perf_tool, and add the 
        --per-event-dump option for perf script.
Patch 2: Add fp argument to print functions.
Patch 3: Replace printf with fprintf for all print functions.
Patch 4: Make all print functions receive the fp argument, and opens a dump    
        file in process_event.

changes since v1: 
- Patch 1: Remove the set of script.tool.per_event_dump variable.
- Patch 2: Add the __maybe_unused attribute for the fp argument in the second patch.
- Patch 3: remove the fp_selection_helper function for setting the fp argument.
- Patch 2: split the original second patch(Makes all those related functions receive the FILE pointer) to two patches.
- Patch 4: modify the file name of per-event-dump to <ORIGINAL PERF DATA FILE NAME>-script-dump-<EVENT NAME>.txt

 tools/perf/builtin-script.c | 452 ++++++++++++++++++++++++--------------------
 tools/perf/util/tool.h      |   1 +
 2 files changed, 250 insertions(+), 203 deletions(-)

-- 
1.8.3.1
