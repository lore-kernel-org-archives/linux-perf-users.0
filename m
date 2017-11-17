From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/83] perf annotate: Remove struct source_line
Date: Fri, 17 Nov 2017 17:15:01 -0300
Message-ID: <20171117201601.24110-24-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161480AbdKQURe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:17:34 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Remove struct source_line*, no longer needed.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20171011150158.11895-23-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index f98acb2ad721..4fc805a271d2 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -126,19 +126,6 @@ struct cyc_hist {
 	u16	reset;
 };
 
-struct source_line_samples {
-	double		percent;
-	double		percent_sum;
-	u64		nr;
-};
-
-struct source_line {
-	struct rb_node	node;
-	char		*path;
-	int		nr_pcnt;
-	struct source_line_samples samples[1];
-};
-
 /** struct annotated_source - symbols with hits have this attached as in sannotation
  *
  * @histogram: Array of addr hit histograms per event being monitored
@@ -154,7 +141,6 @@ struct source_line {
  */
 struct annotated_source {
 	struct list_head   source;
-	struct source_line *lines;
 	int    		   nr_histograms;
 	size_t		   sizeof_sym_hist;
 	struct cyc_hist	   *cycles_hist;
-- 
2.13.6
