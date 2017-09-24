From: yuzhoujian <ufo19890607@gmail.com>
Subject: [PATCH v2 0/4] perf script: Add script per-event-dump support
Date: Sun, 24 Sep 2017 19:12:23 +0800
Message-ID: <1506251547-35909-1-git-send-email-yuzhoujian@didichuxing.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35388 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbdIXLMx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 24 Sep 2017 07:12:53 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

Introduce a new option to print trace output to files named by the
monitored events and update perf-script documentation accordingly.

 Shown below is output of perf script command with the newly introduced
 option.

         $perf record -e cycles -e cs -ag -- sleep 10
         $perf script --per-event-dump
         $ls /
         perf.data-script-dump-cycles.txt perf.data-script-dump-cs.txt

 Without per-event-dump support, drawing flamegraphs for different events
 is really hard. You can only monitor one event at a time for perf record.
 Using this option, we can get the trace output files named by the monitored
 events, and could draw flamegraphs according to the event's name.

yuzhoujian (4):
  Add a new element for the struct perf_tool, and add the
    --per-event-dump option for perf script
  Add fp argument to print functions
  Replace printf with fprintf for all print functions
  Make all print functions receive the fp argument, and opens a dump    
    file in process_event.

changes in v2:
	- remove the set of script.tool.per_event_dump variable.
	- add the __maybe_unused attribute for the fp argument in the second patch.
	- remove the fp_selection_helper function for setting the fp argument.
	- split the original second patch(Makes all those related functions receive the FILE pointer) to two patches.
	- modify the file name of per-event-dump to <ORIGINAL PERF DATA FILE NAME>-script-dump-<EVENT NAME>.txt

 tools/perf/builtin-script.c | 452 ++++++++++++++++++++++++--------------------
 tools/perf/util/tool.h      |   1 +
 2 files changed, 250 insertions(+), 203 deletions(-)

-- 
1.8.3.1
