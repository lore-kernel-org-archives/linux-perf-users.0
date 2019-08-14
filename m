From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/28] perf hists: Do not link a pair if already linked
Date: Wed, 14 Aug 2019 15:40:31 -0300
Message-ID: <20190814184051.3125-9-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When we have multiple events in a group we link hist_entries in the
non-leader evsel hists to the one in the leader that points to the same
sorting criteria, in hists__match().

For 'perf report' we do this just once and then print the results, but
for 'perf top' we need to look if this was already done in the previous
refresh of the screen, so check for that and don't try to link again.

This is part of having 'perf top' using the hists browser for showing
multiple events in multiple columns.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-iwvb37rgb7upswhruwpcdnhw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 4297f56b1e05..d923a5bb7b48 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2453,7 +2453,7 @@ void hists__match(struct hists *leader, struct hists *other)
 		pos  = rb_entry(nd, struct hist_entry, rb_node_in);
 		pair = hists__find_entry(other, pos);
 
-		if (pair)
+		if (pair && list_empty(&pair->pairs.node))
 			hist_entry__add_pair(pair, pos);
 	}
 }
-- 
2.21.0
