Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0F0C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 May 2022 07:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242458AbiEKHBq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 11 May 2022 03:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242446AbiEKHBp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 11 May 2022 03:01:45 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59465E17D
        for <linux-perf-users@vger.kernel.org>; Wed, 11 May 2022 00:01:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a6-20020a056902056600b0064b3d5c324eso327485ybt.5
        for <linux-perf-users@vger.kernel.org>; Wed, 11 May 2022 00:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GOl/dDyiic3CHN6RpwyPiPKb1wU0VPhBRck28P7ZCHk=;
        b=EnHwC10qwtnV6pxqRJcYnJ49YxvO7SNM936gaY/vUD9nwsdn7XuxHwNK64iZ+h+Fix
         h3I+btR3DZSQ8xyOxoxGB6qWSKczhaCoFnjdHBtUxuju4nkgOyLypfaTl6AzAjGypQMI
         CCIitXJUvLQc8FBX3I1njZS2zgHo0zG9ze2tgKP+0lHT2wTJJmaCX1IDzPyHTL5kSHyi
         1Hmykb+40ppEPYOwmJwY6kJNOC0ibZZ+6b6gXfPAhMCyHJjsmpmMsKPBZkfj0y2wiFYJ
         ORhKqKt7xxIfuToMv4ERtBOfxqzWVg89x8ABummQWCwjzgxE1dYcPvbdyN4L+EcO/SPL
         kdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GOl/dDyiic3CHN6RpwyPiPKb1wU0VPhBRck28P7ZCHk=;
        b=ww5Ged87OLlQ278nlXJ5hnwTvUX4X6D92ygfEyYlUqQH8bZZl+mzUCo+nTlqYMlsa5
         zHmV4OKShxTQLi4m4l9vJxHzcWIX2uZUEmZiERRgLNZ0SrnX034Gu/o9EaTZokz3Gxph
         ccUzRi+AYIGd/3FP/k2lX6xae+UeqCLHk6Rdysz6+nICeRYz/B8sJlyfjYABEXn3sX9O
         GQpBFhIG1/bMLeLAIzWvLM5E3yI+yrJ1rD7zbo3zlBaqHGV09SpukvygYF2VrSZY1hzO
         lvpy5dqMTbGEFsJPvh0t+BAlY/1zh0qfpaKkS+kg3ouAfaMZEPfCOO221+gC1+DFuT2p
         iMUQ==
X-Gm-Message-State: AOAM5339JO+CJaTZTx8LgKDA6E68mW0WLk6cVm99zsK+n1bFoEeccm/W
        zqSRMcFKvoQv6B+SQ4w4+Bo/vQmrg9hs
X-Google-Smtp-Source: ABdhPJz6DgNH2KUDVEqruh6QTuP3eHV+0C65QhAonB7KFFGCDZ9k68xvIzb57Q2CYcotHaOjeHpkPVu6UIAq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:b6c9:16a6:f912:39d5])
 (user=irogers job=sendgmr) by 2002:a25:acd2:0:b0:645:d5c8:b837 with SMTP id
 x18-20020a25acd2000000b00645d5c8b837mr21754737ybd.481.1652252499791; Wed, 11
 May 2022 00:01:39 -0700 (PDT)
Date:   Wed, 11 May 2022 00:01:27 -0700
In-Reply-To: <20220511070133.710721-1-irogers@google.com>
Message-Id: <20220511070133.710721-2-irogers@google.com>
Mime-Version: 1.0
References: <20220511070133.710721-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 1/7] perf jevents: Append PMU description later
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Append the PMU information from "Unit" to the description later. This
avoids a problem when "Unit" appears early in a json event and the
information prepends the description rather than being the expected
suffix.

Update the pmu-events test so that expectations now match the improved
output.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.c | 8 +++++---
 tools/perf/tests/pmu-events.c   | 6 +++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 159d9eab6e79..e1f7c7afd435 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -652,9 +652,6 @@ static int json_events(const char *fn,
 					for (s = je.pmu; *s; s++)
 						*s = tolower(*s);
 				}
-				addfield(map, &je.desc, ". ", "Unit: ", NULL);
-				addfield(map, &je.desc, "", je.pmu, NULL);
-				addfield(map, &je.desc, "", " ", NULL);
 			} else if (json_streq(map, field, "Filter")) {
 				addfield(map, &filter, "", "", val);
 			} else if (json_streq(map, field, "ScaleUnit")) {
@@ -697,6 +694,11 @@ static int json_events(const char *fn,
 			addfield(map, &je.desc, " ", extra_desc, NULL);
 		if (je.long_desc && extra_desc)
 			addfield(map, &je.long_desc, " ", extra_desc, NULL);
+		if (je.pmu) {
+			addfield(map, &je.desc, ". ", "Unit: ", NULL);
+			addfield(map, &je.desc, "", je.pmu, NULL);
+			addfield(map, &je.desc, "", " ", NULL);
+		}
 		if (filter)
 			addfield(map, &event, ",", filter, NULL);
 		if (msr != NULL)
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 299a215eb54c..b74c6ef59e51 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -133,7 +133,7 @@ static const struct perf_pmu_test_event unc_cbo_xsnp_response_miss_eviction = {
 	.event = {
 		.name = "unc_cbo_xsnp_response.miss_eviction",
 		.event = "umask=0x81,event=0x22",
-		.desc = "Unit: uncore_cbox A cross-core snoop resulted from L3 Eviction which misses in some processor core",
+		.desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core. Unit: uncore_cbox ",
 		.topic = "uncore",
 		.long_desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core",
 		.pmu = "uncore_cbox",
@@ -147,7 +147,7 @@ static const struct perf_pmu_test_event uncore_hyphen = {
 	.event = {
 		.name = "event-hyphen",
 		.event = "umask=0x00,event=0xe0",
-		.desc = "Unit: uncore_cbox UNC_CBO_HYPHEN",
+		.desc = "UNC_CBO_HYPHEN. Unit: uncore_cbox ",
 		.topic = "uncore",
 		.long_desc = "UNC_CBO_HYPHEN",
 		.pmu = "uncore_cbox",
@@ -161,7 +161,7 @@ static const struct perf_pmu_test_event uncore_two_hyph = {
 	.event = {
 		.name = "event-two-hyph",
 		.event = "umask=0x00,event=0xc0",
-		.desc = "Unit: uncore_cbox UNC_CBO_TWO_HYPH",
+		.desc = "UNC_CBO_TWO_HYPH. Unit: uncore_cbox ",
 		.topic = "uncore",
 		.long_desc = "UNC_CBO_TWO_HYPH",
 		.pmu = "uncore_cbox",
-- 
2.36.0.512.ge40c2bad7a-goog

