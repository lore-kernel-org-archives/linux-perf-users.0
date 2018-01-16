From: changbin.du@intel.com
Subject: [PATCH v3 0/3] tracing: Fix the parser when processing strings w/ or w/o terminated '\0'
Date: Tue, 16 Jan 2018 17:02:27 +0800
Message-ID: <1516093350-12045-1-git-send-email-changbin.du@intel.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:39044 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbeAPJLR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 16 Jan 2018 04:11:17 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: rostedt@goodmis.org
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Changbin Du <changbin.du@intel.com>

From: Changbin Du <changbin.du@intel.com>

I found there are some problems in the tracing parser when I investiage the root
cause of issues mentioned in below patch.
https://patchwork.kernel.org/patch/10132953/

This serials can fix them.

v3: Polish commit msg from Steven Rostedt.
v2:
  - Drop 1 old patch and add a new one.
  - Stop parsing when '\0' found.

Changbin Du (3):
  tracing: detect the string termination character when parsing user
    input string
  tracing: clear parser->idx if parser gets nothing
  tracing: make sure the parsed string always terminates with '\0'

 kernel/trace/ftrace.c       |  2 --
 kernel/trace/trace.c        | 14 +++++++-------
 kernel/trace/trace_events.c |  2 --
 3 files changed, 7 insertions(+), 11 deletions(-)

-- 
2.7.4
