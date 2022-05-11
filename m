Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D03EC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 May 2022 21:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348067AbiEKVPj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 11 May 2022 17:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348066AbiEKVPf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 11 May 2022 17:15:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E2E2297D1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 May 2022 14:15:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v64-20020a25abc6000000b0064a22f2a1e7so2925788ybi.17
        for <linux-perf-users@vger.kernel.org>; Wed, 11 May 2022 14:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GOl/dDyiic3CHN6RpwyPiPKb1wU0VPhBRck28P7ZCHk=;
        b=kzk7n6/Ux8w6Q7p+lVKpurlLg4loE3fRbaAJQsK8SoczAzxQ+T4aTpgw9yoLRIoOKG
         RJG2I41HbbMYcGUQ5B7ScmXAOS/3coPyTDkaG48KYyz6NjdfeibUFsF74pfsnmzH1+lG
         gaqnEUIJxweJVYJ181xcSdFxcGpvAiM1ez3iRpTVtqArIE5IXHwuFvuT2miNv4ogIm22
         +N6nb5jK9fXcXZ+FoFE4Y+fpsO/BbDpDIbgzN8cQsUblTXTVx6TbISDmSPdSYJzSr7h9
         Ke8+2Vxr9HBI8+G+zAzJpodqLkGyEr6VJV7Kr6ngk8jGtE9hkf4rNUqtEvn56pza0c8O
         WVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GOl/dDyiic3CHN6RpwyPiPKb1wU0VPhBRck28P7ZCHk=;
        b=ntTc0tkATJsng0DAMZ+WSPOsPtKV+3PYroHZjU1qQzj1Ex9WqVTB2jexNd27p8zpMX
         McxBao9KfWo7iBl6zexslaYClooGj8/QdWdnChAuTLKchFt+NCLe6mGIvsTJdMMm9GJl
         JZAE8MmvkQmglPA3mGEPHAYeB8tkLirX5bFk/YwTSjBERYMfw+o+6hadiljkM2NU/rqa
         aGhR/67jxXOVoPxeXlQW55A6ghYNX8aojp0hHIdNgjiALgvN1Ko/9qygsOGlO90eQIjd
         xLy22VvrdNG1Zx/teJeEgLKVP6c+GY057YDfSeJEmPoAFGyaz6Uq5zO+6OdYHZdPF3mD
         ETzQ==
X-Gm-Message-State: AOAM530/nUku9LR9ydCx4AKtrtKRezQzXU34mzTJU7LbfV8Btmf8vAOy
        6IHkmwgH2iWz5CH3szPYJMQwj/FkSe5D
X-Google-Smtp-Source: ABdhPJyoqro8S0Ed4YjfQ1udYJK0lU53Cjn5f7G/UpvgJpoCAse+sptoQwIh+xpmoPM5MGsChn3BDN8nIxe1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:5993:294b:7b62:54cb])
 (user=irogers job=sendgmr) by 2002:a81:578a:0:b0:2f8:ec0e:2205 with SMTP id
 l132-20020a81578a000000b002f8ec0e2205mr25750235ywb.408.1652303732927; Wed, 11
 May 2022 14:15:32 -0700 (PDT)
Date:   Wed, 11 May 2022 14:15:20 -0700
In-Reply-To: <20220511211526.1021908-1-irogers@google.com>
Message-Id: <20220511211526.1021908-2-irogers@google.com>
Mime-Version: 1.0
References: <20220511211526.1021908-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH v2 1/7] perf jevents: Append PMU description later
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

