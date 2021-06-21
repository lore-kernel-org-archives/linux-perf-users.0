Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13B5C48BC2
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 15:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 929AC6023F
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Jun 2021 15:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFUPHP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:07:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:58517 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbhFUPHP (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Jun 2021 11:07:15 -0400
IronPort-SDR: 9zhNhtmDqOyBWC10elTKKftcB2/MsJXTgscKyay60mQ5KGeYMGA/D1QFL3S3rOozBbfMOF4YHZ
 UL/3HaYI2mAg==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="193998805"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="193998805"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 08:04:57 -0700
IronPort-SDR: oJMUWTYdXZdDzNRHherZjRWKTvOh3SM0Dmy4qSukYbGc4963k6cOGzRUjwggJdI6pncEPbB9+k
 qZTJnLRULF0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="486519190"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2021 08:04:54 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 01/11] perf script: Move filter_cpu() earlier
Date:   Mon, 21 Jun 2021 18:05:04 +0300
Message-Id: <20210621150514.32159-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210621150514.32159-1-adrian.hunter@intel.com>
References: <20210621150514.32159-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Generally, it should be more efficient if filter_cpu() comes before
machine__resolve() because filter_cpu() is much less code than
machine__resolve().

Example:

 $ perf record --sample-cpu -- make -C tools/perf >/dev/null

Before:

 $ perf stat -- perf script -C 0 >/dev/null

  Performance counter stats for 'perf script -C 0':

            116.94 msec task-clock                #    0.992 CPUs utilized
                 2      context-switches          #   17.103 /sec
                 0      cpu-migrations            #    0.000 /sec
             8,187      page-faults               #   70.011 K/sec
       478,351,812      cycles                    #    4.091 GHz
       564,785,464      instructions              #    1.18  insn per cycle
       114,341,105      branches                  #  977.789 M/sec
         2,615,495      branch-misses             #    2.29% of all branches

       0.117840576 seconds time elapsed

       0.085040000 seconds user
       0.032396000 seconds sys

After:

 $ perf stat -- perf script -C 0 >/dev/null

  Performance counter stats for 'perf script -C 0':

            107.45 msec task-clock                #    0.992 CPUs utilized
                 3      context-switches          #   27.919 /sec
                 0      cpu-migrations            #    0.000 /sec
             7,964      page-faults               #   74.117 K/sec
       438,417,260      cycles                    #    4.080 GHz
       522,571,855      instructions              #    1.19  insn per cycle
       105,187,488      branches                  #  978.921 M/sec
         2,356,261      branch-misses             #    2.24% of all branches

       0.108282546 seconds time elapsed

       0.095935000 seconds user
       0.011991000 seconds sys

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-script.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 57488d60b64a..08a2b5d51018 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2191,6 +2191,9 @@ static int process_sample_event(struct perf_tool *tool,
 		return 0;
 	}
 
+	if (filter_cpu(sample))
+		return 0;
+
 	if (machine__resolve(machine, &al, sample) < 0) {
 		pr_err("problem processing %d event, skipping it.\n",
 		       event->header.type);
@@ -2200,9 +2203,6 @@ static int process_sample_event(struct perf_tool *tool,
 	if (al.filtered)
 		goto out_put;
 
-	if (filter_cpu(sample))
-		goto out_put;
-
 	if (scripting_ops) {
 		struct addr_location *addr_al_ptr = NULL;
 		struct addr_location addr_al;
-- 
2.17.1

