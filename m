From: changbin.du@intel.com
Subject: [PATCH v2 0/3] tracing: Fix the parser when processing strings w/ or w/o terminated '\0'
Date: Mon, 15 Jan 2018 19:41:11 +0800
Message-ID: <1516016474-5581-1-git-send-email-changbin.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rostedt@goodmis.org
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Changbin Du <changbin.du@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

I found there are some problems in the tracing parser when I investiage the root
cause of issues mentioned in below patch.
https://patchwork.kernel.org/patch/10132953/

This serials can fix them.

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
