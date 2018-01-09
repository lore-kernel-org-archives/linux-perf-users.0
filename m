From: changbin.du@intel.com
Subject: [PATCH 0/3] tracing: Fix the parser when processing strings w/ or w/o terminated '\0'
Date: Tue,  9 Jan 2018 17:55:45 +0800
Message-ID: <1515491748-25926-1-git-send-email-changbin.du@intel.com>
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
  tracing: make sure the parsed string always terminates with '\0'
  tracing: don't set parser->cont if it has reached the end of input
    buffer

 kernel/trace/trace.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

-- 
2.7.4
