From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 35/35] perf tools: Auto-complete for events with ':'
Date: Thu, 28 Dec 2017 11:30:27 -0300
Message-ID: <20171228143027.30547-36-acme@kernel.org>
References: <20171228143027.30547-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228143027.30547-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

It's a follow up patch for a previous patch "perf tool: Return all
events as auto-completions after comma".

With this patch, auto-completion can work well for events with a ':'.
For example:

  root@skl:/tmp# perf stat -e block:block_<TAB>
  block:block_bio_backmerge   block:block_rq_complete
  block:block_bio_bounce      block:block_rq_insert
  block:block_bio_complete    block:block_rq_issue
  block:block_bio_frontmerge  block:block_rq_remap
  block:block_bio_queue       block:block_rq_requeue
  block:block_bio_remap       block:block_sleeprq
  block:block_dirty_buffer    block:block_split
  block:block_getrq           block:block_touch_buffer
  block:block_plug            block:block_unplug

  root@skl:/tmp# perf stat -e block:block_rq_<TAB>
  block:block_rq_complete  block:block_rq_issue     block:block_rq_requeue
  block:block_rq_insert    block:block_rq_remap

  root@skl:/tmp# perf stat -e block:block_rq_complete<TAB>
  block:block_rq_complete

  root@skl:/tmp# perf stat -e block:block_rq_complete

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1513973758-19109-1-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf-completion.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/perf-completion.sh b/tools/perf/perf-completion.sh
index 90206413f4d7..fdf75d45efff 100644
--- a/tools/perf/perf-completion.sh
+++ b/tools/perf/perf-completion.sh
@@ -280,6 +280,11 @@ _perf()
 		export COMP_WORDBREAKS
 	fi
 
+	if [[ "$COMP_WORDBREAKS" == *:* ]]; then
+		COMP_WORDBREAKS="${COMP_WORDBREAKS/:/}"
+		export COMP_WORDBREAKS
+	fi
+
 	local cur words cword prev
 	if [ $preload_get_comp_words_by_ref = "true" ]; then
 		_get_comp_words_by_ref -n =:, cur words cword prev
-- 
2.13.6
