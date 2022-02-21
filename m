Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD23C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Feb 2022 17:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbiBURS0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Feb 2022 12:18:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381611AbiBURSB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Feb 2022 12:18:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9C53275EB;
        Mon, 21 Feb 2022 09:17:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A586F1042;
        Mon, 21 Feb 2022 09:17:20 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3CA1E3F70D;
        Mon, 21 Feb 2022 09:17:19 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf script: Fix error when printing 'weight' field
Date:   Mon, 21 Feb 2022 17:17:06 +0000
Message-Id: <20220221171707.62960-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

In SPE traces the 'weight' field can't be printed in perf-script because
the 'dummy:u' event doesn't have the WEIGHT attribute set.

Use evsel__do_check_stype(..) to check this field, as it's done with
other fields such as "phys_addr".

Before:

$ perf record -e arm_spe_0// -- sleep 1
$ perf script -F event,ip,weight
Samples for 'dummy:u' event do not have WEIGHT attribute set. Cannot print 'weight' field.

After:

$ perf script -F event,ip,weight
   l1d-access:               12 ffffaf629d4cb320
   tlb-access:               12 ffffaf629d4cb320
       memory:               12 ffffaf629d4cb320

Fixes: b0fde9c6e291 ("perf arm-spe: Add SPE total latency as PERF_SAMPLE_WEIGHT")
Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 9e032343f..6ce581067 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -463,7 +463,7 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 		return -EINVAL;
 
 	if (PRINT_FIELD(WEIGHT) &&
-	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT_TYPE, "WEIGHT", PERF_OUTPUT_WEIGHT))
+	    evsel__do_check_stype(evsel, PERF_SAMPLE_WEIGHT_TYPE, "WEIGHT", PERF_OUTPUT_WEIGHT, allow_user_set))
 		return -EINVAL;
 
 	if (PRINT_FIELD(SYM) &&
-- 
2.25.1

