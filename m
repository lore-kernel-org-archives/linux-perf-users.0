From: yuzhoujian <ufo19890607@gmail.com>
Subject: [PATCH 0/4] perf script: Add script per-event-dump support
Date: Mon, 18 Sep 2017 13:55:18 +0800
Message-ID: <1505714122-39141-1-git-send-email-yuzhoujian@didichuxing.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36962 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbdIRFz7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Sep 2017 01:55:59 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

Introduce a new option to print trace output to files named by the
monitored events and update perf-script documentation accordingly.

Shown below is output of perf script command with the newly introduced
option.

        $perf record -e cycles -e context-switches -ag -- sleep 10
        $perf script --per-event-dump
        $ls /
        cycles.stacks context-switches.stacks

Without per-event-dump support, drawing flamegraphs for different events
is really hard. You can only monitor one event at a time for perf record.
Using this option, we can get the trace output files named by the monitored
events, and could draw flamegraphs according to the event's name.

yuzhoujian (4):
  Add a new element for the struct perf_tool, and add the
    --per-event-dump     option for perf script
  Makes all those related functions receive the FILE pointer
  Add the fp_selection_helper function to set the file pointer     for
    the related functions
  Replace printf with fprintf for all the output functions

 tools/perf/builtin-script.c | 451 +++++++++++++++++++++++++-------------------
 tools/perf/util/tool.h      |   1 +
 2 files changed, 253 insertions(+), 199 deletions(-)

-- 
1.8.3.1
