Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CC8C25B4E
	for <linux-perf-users@archiver.kernel.org>; Sun, 22 Jan 2023 12:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjAVMVH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 22 Jan 2023 07:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjAVMVH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 22 Jan 2023 07:21:07 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FE24ECF;
        Sun, 22 Jan 2023 04:21:05 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 81EA11BF205;
        Sun, 22 Jan 2023 12:21:00 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Diederik de Haas <didi.debian@cknow.org>,
        linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS
        SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
Subject: [PATCH v2] perf: Various spelling fixes
Date:   Sun, 22 Jan 2023 13:20:32 +0100
Message-Id: <20230122122034.48020-1-didi.debian@cknow.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fix various spelling errors as reported by Debian's lintian tool.

"amount of times" -> "number of times"
ocurrence -> occurrence
upto -> up to

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 tools/perf/Documentation/perf-bench.txt | 2 +-
 tools/perf/builtin-bench.c              | 2 +-
 tools/perf/builtin-script.c             | 2 +-
 tools/perf/util/evswitch.h              | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-bench.txt b/tools/perf/Documentation/perf-bench.txt
index a0529c7fa5ef..f04f0eaded98 100644
--- a/tools/perf/Documentation/perf-bench.txt
+++ b/tools/perf/Documentation/perf-bench.txt
@@ -18,7 +18,7 @@ COMMON OPTIONS
 --------------
 -r::
 --repeat=::
-Specify amount of times to repeat the run (default 10).
+Specify number of times to repeat the run (default 10).
 
 -f::
 --format=::
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 334ab897aae3..bd4fd94a2ce0 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -150,7 +150,7 @@ unsigned int bench_repeat = 10; /* default number of times to repeat the run */
 
 static const struct option bench_options[] = {
 	OPT_STRING('f', "format", &bench_format_str, "default|simple", "Specify the output formatting style"),
-	OPT_UINTEGER('r', "repeat",  &bench_repeat,   "Specify amount of times to repeat the run"),
+	OPT_UINTEGER('r', "repeat",  &bench_repeat,   "Specify number of times to repeat the run"),
 	OPT_END()
 };
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 69394ac0a20d..8901acdd7f5b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1301,7 +1301,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
 		goto out;
 
 	/*
-	 * Print final block upto sample
+	 * Print final block up to sample
 	 *
 	 * Due to pipeline delays the LBRs might be missing a branch
 	 * or two, which can result in very large or negative blocks
diff --git a/tools/perf/util/evswitch.h b/tools/perf/util/evswitch.h
index fd30460b6218..8ffdbe526d98 100644
--- a/tools/perf/util/evswitch.h
+++ b/tools/perf/util/evswitch.h
@@ -22,9 +22,9 @@ bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel);
 
 #define OPTS_EVSWITCH(evswitch)								  \
 	OPT_STRING(0, "switch-on", &(evswitch)->on_name,				  \
-		   "event", "Consider events after the ocurrence of this event"),	  \
+		   "event", "Consider events after the occurrence of this event"),	  \
 	OPT_STRING(0, "switch-off", &(evswitch)->off_name,				  \
-		   "event", "Stop considering events after the ocurrence of this event"), \
+		   "event", "Stop considering events after the occurrence of this event"), \
 	OPT_BOOLEAN(0, "show-on-off-events", &(evswitch)->show_on_off_events,		  \
 		    "Show the on/off switch events, used with --switch-on and --switch-off")
 
-- 
2.39.0

