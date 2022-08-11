Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC95FC19F2D
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Aug 2022 06:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbiHKG0y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Aug 2022 02:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbiHKG0X (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Aug 2022 02:26:23 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B15F6068F
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Aug 2022 23:26:11 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id l64so16391692pge.0
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Aug 2022 23:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=2BjSb17Xo+YW8LG40iOqmFrwUMRlbFx/Kcx9RnLyLS4=;
        b=hcICa0z1OMm5qm9hJR0Y9mqXD+y7Ore41LW0ePfj1QxfQ2Kl1GnDsa7IVBC4hVHZSD
         SbQPVjbAUI+V097ZrQ3Hn+q5741GszYzDEBo+NS6sh50ISdCE7uBLm22ba6/xztQUKY1
         X3LTbey8f9wOPtfxh5aee4pWt6EW9va46uiJDEvUoIBgJX2HSGTBB9mt1pixXRfw3fmA
         +ohbYjcXVg/Oi/l3H3Nwv2eqa5FeSg3aeKiX5qun0BCfhZQXaIlyFJeHQSjqsV3fba8z
         ymYAuU6m3o1DdenuaeU3wTFxQ1goyLuXnZyQBLs24Skupd1LGTiyzCc9Ni6nuHnzzT+s
         iAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=2BjSb17Xo+YW8LG40iOqmFrwUMRlbFx/Kcx9RnLyLS4=;
        b=SajXklMl3mj5AV8FY56f9B4b2LFzTcxD2KZEsBXDUb/LTkhmkEaLk+f4uBsFeRYGb8
         zQvXV8XRlwQxWng56rrqp/PB8azs2L6ISrCuQwB58VonYaaadRQSHepQfj6L/PW+HNlg
         nOB8Px4kWXNpHM9FLyPjpGTYCBoJE4WOCjQ1ADRnBlZ4ImXkt9hoXytNZkQrOxQ0oosM
         uMVSaY5ISfwFKsMRhldmVxb9dyubbhLZRlh1oBmbMrMuy0pZFMtN+0d8LLqMtgfM39LW
         H5Z8L/N6AriULbEcSoizG9VUAA16mUug4KGKwmkHV77vD3ITLuOT5/6mE7hgZCJp//3B
         X2cA==
X-Gm-Message-State: ACgBeo1wj7vYmAprQULvzbPJJ/wN2ydAegvhusN/IrPxsZOomI21m0x+
        Sv/fuCWsb6Ti1iAbYPhGq9nkwA==
X-Google-Smtp-Source: AA6agR761+qNleysosWB22AkEG5qMY4yybGJ1hxKKOzgEQpLJwZjmsbIHyfXgP9lVeuJE8lfJFG6Kw==
X-Received: by 2002:a05:6a00:1908:b0:525:5dad:cb1c with SMTP id y8-20020a056a00190800b005255dadcb1cmr30415553pfi.47.1660199170702;
        Wed, 10 Aug 2022 23:26:10 -0700 (PDT)
Received: from leoy-yangtze.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090a55cc00b001f506009036sm2766926pjm.49.2022.08.10.23.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 23:26:10 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ian Rogers <irogers@google.com>, Like Xu <likexu@tencent.com>,
        German Gomez <german.gomez@arm.com>,
        Timothy Hayes <timothy.hayes@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 12/15] perf c2c: Refactor display string
Date:   Thu, 11 Aug 2022 14:24:48 +0800
Message-Id: <20220811062451.435810-13-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220811062451.435810-1-leo.yan@linaro.org>
References: <20220811062451.435810-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The display type is shown by combination the display string array and a
suffix string "HITMs", which is not friendly to extend display for other
sorting type (e.g. extension for peer operations).

This patch moves the suffix string "HITMs" into display string array for
HITM types, so it can allow us to not necessarily to output string
"HITMs" for new incoming display type.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Ian Rogers <irogers@google.com>
Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 49a9b8480b41..8b7c1fd35380 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -122,9 +122,9 @@ enum {
 };
 
 static const char *display_str[DISPLAY_MAX] = {
-	[DISPLAY_LCL_HITM] = "Local",
-	[DISPLAY_RMT_HITM] = "Remote",
-	[DISPLAY_TOT_HITM] = "Total",
+	[DISPLAY_LCL_HITM] = "Local HITMs",
+	[DISPLAY_RMT_HITM] = "Remote HITMs",
+	[DISPLAY_TOT_HITM] = "Total HITMs",
 };
 
 static const struct option c2c_options[] = {
@@ -2489,7 +2489,7 @@ static void print_c2c_info(FILE *out, struct perf_session *session)
 		fprintf(out, "%-36s: %s\n", first ? "  Events" : "", evsel__name(evsel));
 		first = false;
 	}
-	fprintf(out, "  Cachelines sort on                : %s HITMs\n",
+	fprintf(out, "  Cachelines sort on                : %s\n",
 		display_str[c2c.display]);
 	fprintf(out, "  Cacheline data grouping           : %s\n", c2c.cl_sort);
 }
@@ -2646,7 +2646,7 @@ static int perf_c2c_browser__title(struct hist_browser *browser,
 {
 	scnprintf(bf, size,
 		  "Shared Data Cache Line Table     "
-		  "(%lu entries, sorted on %s HITMs)",
+		  "(%lu entries, sorted on %s)",
 		  browser->nr_non_filtered_entries,
 		  display_str[c2c.display]);
 	return 0;
-- 
2.34.1

