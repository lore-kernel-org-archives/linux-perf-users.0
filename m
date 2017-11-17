From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 48/83] perf script: Allow printing period for non freq mode groups
Date: Fri, 17 Nov 2017 17:15:26 -0300
Message-ID: <20171117201601.24110-49-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753413AbdKQUSx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:18:53 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Andi Kleen <ak@linux.intel.com>

When using leader sampling the values of the not sampled but counted
events are shown by perf script in "period".

Currently printing period is only allowed when the main event has a
period, that is it is in frequency mode.

This implies that we cannot dump the values of counted events when the
leader event is not in frequency mode.

Just remove the check that the period must be set on all events. It will
just be printed as 0 instead if it's not available.

This fixes the following:

  $ perf record -c 100000 -e '{cycles,branches}:S'
  $ perf script -F event,period

Further commentary by Jiri Olsa:

The period will be the value of configured period, not 0:

int perf_evsel__parse_sample(struct ...
  ...
  data->period = evsel->attr.sample_period;

  $ perf record -c 100000
  $ perf script -F event,period | head -3
  Failed to open /tmp/perf-2048.map, continuing without symbols
      100000 cycles:ppp:
      100000 cycles:ppp:

other than that I think we can remove that check, because we will have
always sane number in period

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20171109145528.23371-4-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 9b43bda45a41..ee7c7aaaae72 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -423,11 +423,6 @@ static int perf_evsel__check_attr(struct perf_evsel *evsel,
 					   PERF_OUTPUT_CPU, allow_user_set))
 		return -EINVAL;
 
-	if (PRINT_FIELD(PERIOD) &&
-		perf_evsel__check_stype(evsel, PERF_SAMPLE_PERIOD, "PERIOD",
-					PERF_OUTPUT_PERIOD))
-		return -EINVAL;
-
 	if (PRINT_FIELD(IREGS) &&
 		perf_evsel__check_stype(evsel, PERF_SAMPLE_REGS_INTR, "IREGS",
 					PERF_OUTPUT_IREGS))
-- 
2.13.6
