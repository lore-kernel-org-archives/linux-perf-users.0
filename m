From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 39/83] perf evsel: Enable type checking for perf_evsel_config_term types
Date: Fri, 17 Nov 2017 17:15:17 -0300
Message-ID: <20171117201601.24110-40-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161736AbdKQUSZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:18:25 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Andi Kleen <ak@linux.intel.com>

Use a typed enum for the perf_evsel_config_term type enum.  This allows
gcc to do much stronger type checks, and also check for missing case
statements.

I removed the unused _MAX member from the number.

It found one missing case. I'm not sure it's a real problem, so I just
turned it into a BUG_ON for now.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20171020202755.21410-1-andi@firstfloor.org
[ Renamed the enum name to term_type as per jolsa's request ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 2 ++
 tools/perf/util/evsel.h | 5 ++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index bfde6a7a80f2..4376cdfaea49 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -779,6 +779,8 @@ static void apply_config_terms(struct perf_evsel *evsel,
 		case PERF_EVSEL__CONFIG_TERM_OVERWRITE:
 			attr->write_backward = term->val.overwrite ? 1 : 0;
 			break;
+		case PERF_EVSEL__CONFIG_TERM_DRV_CFG:
+			BUG_ON(1);
 		default:
 			break;
 		}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 157f49e8a772..0688880227e1 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -38,7 +38,7 @@ struct cgroup_sel;
  * It is allocated within event parsing and attached to
  * perf_evsel::config_terms list head.
 */
-enum {
+enum term_type {
 	PERF_EVSEL__CONFIG_TERM_PERIOD,
 	PERF_EVSEL__CONFIG_TERM_FREQ,
 	PERF_EVSEL__CONFIG_TERM_TIME,
@@ -49,12 +49,11 @@ enum {
 	PERF_EVSEL__CONFIG_TERM_OVERWRITE,
 	PERF_EVSEL__CONFIG_TERM_DRV_CFG,
 	PERF_EVSEL__CONFIG_TERM_BRANCH,
-	PERF_EVSEL__CONFIG_TERM_MAX,
 };
 
 struct perf_evsel_config_term {
 	struct list_head	list;
-	int	type;
+	enum term_type	type;
 	union {
 		u64	period;
 		u64	freq;
-- 
2.13.6
