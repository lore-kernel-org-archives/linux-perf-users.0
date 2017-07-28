From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/15] perf annotate: Do not overwrite perf_sample->weight
Date: Fri, 28 Jul 2017 17:00:10 -0300
Message-ID: <20170728200021.11389-5-acme@kernel.org>
References: <20170728200021.11389-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170728200021.11389-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Taeung Song <treeze.taeung@gmail.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When we parse an event we may get a value from the kernel in response to
PERF_SAMPLE_WEIGHT being set in perf_event_attr->sample_type, and if it
is not set, then perf_sample->weight will be set to zero, which should
be ok according to a discussion with Andi Kleen [1]:

1: https://lkml.kernel.org/r/20170724174637.GS3044@two.firstfloor.org

Acked-by: Andi Kleen <andi@firstfloor.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-8ev8ufk3lzmvgz37yg9nv3qz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 6db782dfce96..658c920d74b9 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -177,8 +177,6 @@ static int perf_evsel__add_sample(struct perf_evsel *evsel,
 	 */
 	process_branch_stack(sample->branch_stack, al, sample);
 
-	sample->weight = 1;
-
 	he = hists__add_entry(hists, al, NULL, NULL, NULL, sample, true);
 	if (he == NULL)
 		return -ENOMEM;
-- 
2.9.4
