From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/40] perf annotate: Do not overwrite sample->period
Date: Wed, 26 Jul 2017 11:17:11 -0300
Message-ID: <20170726141730.30750-22-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Taeung Song <treeze.taeung@gmail.com>, Jiri Olsa <jolsa@redhat.com>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Taeung Song <treeze.taeung@gmail.com>

In fixing the --show-total-period option it was noticed that the value
of sample->period was being overwritten, fix it.

Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: fd36f3dd7933 ("perf hist: Pass struct sample to __hists__add_entry()")
Link: http://lkml.kernel.org/r/1500500215-16646-1-git-send-email-treeze.taeung@gmail.com
[ split from a larger patch, added the Fixes tag ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 96fe1a88c1e5..7e33278eff67 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -177,7 +177,6 @@ static int perf_evsel__add_sample(struct perf_evsel *evsel,
 	 */
 	process_branch_stack(sample->branch_stack, al, sample);
 
-	sample->period = 1;
 	sample->weight = 1;
 
 	he = hists__add_entry(hists, al, NULL, NULL, NULL, sample, true);
-- 
2.9.4
