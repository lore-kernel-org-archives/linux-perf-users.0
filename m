From: Ian Rogers <irogers@google.com>
Subject: [PATCH v2 4/7] perf metricgroup: Order event groups by size
Date: Wed, 20 May 2020 11:20:08 -0700
Message-ID: <20200520182011.32236-5-irogers@google.com>
References: <20200520182011.32236-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200520182011.32236-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>, Andrii Nakryiko <andriin@fb.com>, Kajol Jain <kjain@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, Kim Phillips <kim.phillips@amd.com>, Paul Clarke <pc@us.ibm.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, Vince Weaver <vincent.weaver@maine.edu>, Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org

When adding event groups to the group list, insert them in size order.
This performs an insertion sort on the group list. By placing the
largest groups at the front of the group list it is possible to see if a
larger group contains the same events as a later group. This can make
the later group redundant - it can reuse the events from the large group.
A later patch will add this sharing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index dca433520b92..bac63524d12f 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -508,7 +508,21 @@ static int __metricgroup__add_metric(struct list_head *group_list,
 		return -EINVAL;
 	}
 
-	list_add_tail(&eg->nd, group_list);
+	if (list_empty(group_list))
+		list_add(&eg->nd, group_list);
+	else {
+		struct list_head *pos;
+
+		/* Place the largest groups at the front. */
+		list_for_each_prev(pos, group_list) {
+			struct egroup *old = list_entry(pos, struct egroup, nd);
+
+			if (hashmap__size(&eg->pctx.ids) <=
+			    hashmap__size(&old->pctx.ids))
+				break;
+		}
+		list_add(&eg->nd, pos);
+	}
 
 	return 0;
 }
-- 
2.26.2.761.g0e0b3e54be-goog
