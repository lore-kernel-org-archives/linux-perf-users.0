From: changbin.du@intel.com
Subject: [PATCH v2 0/2] perf sched map: re-annotate shortname if thread comm changed
Date: Tue,  6 Mar 2018 11:37:35 +0800
Message-ID: <1520307457-23668-1-git-send-email-changbin.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, jolsa@redhat.com
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Changbin Du <changbin.du@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

v2:
  o add a patch to move thread::shortname to thread_runtime
  o add function perf_sched__process_comm() to process PERF_RECORD_COMM event.

Changbin Du (2):
  perf sched: move thread::shortname to thread_runtime
  perf sched map: re-annotate shortname if thread comm changed

 tools/perf/builtin-sched.c | 132 ++++++++++++++++++++++++++++++---------------
 tools/perf/util/thread.h   |   1 -
 2 files changed, 90 insertions(+), 43 deletions(-)

-- 
2.7.4
