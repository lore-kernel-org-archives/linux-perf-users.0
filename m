Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38449C77B7C
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 May 2023 07:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjE0HZ5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 27 May 2023 03:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjE0HZd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 27 May 2023 03:25:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EBC1B3
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:24:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565a336caa0so37972437b3.1
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172226; x=1687764226;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WOjxsGu2+B4s1nXlsSxqdUIWzY+WQ/eQBroudZlXVAc=;
        b=AVnwhtM1wdpkw3CJ7HsX0RDZfTFX/pEkwAGAWCV7/hRHJ4J0yOIPWqyAASLL2u73nJ
         gvyyx59B6uXL0+qMegAG0kP2a+YryTO3t8gAgMk1bLtR1P0qiQHYXnGCumb5aE/r6N1R
         gvDgFF2ewevrUOYMsevNyB0Tk9kiPlLAgR+OCj0a+tSWlrrACoMDIJJ9+dodIL4NFhoY
         3iXdpNTIpJf8A/fRTcMZ+IkH6GI7IqPHR4pkmexQsr+YFiSl+32WwrsDcEMAe5Bi+nAI
         d7AJprG6Kg7DgYmQdJj7T097SICzCCIGuYWOixj2YyYo3ZmP7INFzSW9oJ2T4jG7AQQK
         Vcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172226; x=1687764226;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOjxsGu2+B4s1nXlsSxqdUIWzY+WQ/eQBroudZlXVAc=;
        b=Oa7sv2iso4jdWPCS855B1HVwxWdQM63j90KzcKTZxCaUAsdlxPoAxeGKeGQK5kMt3E
         CRiP9BUpDu+PDb3oTxgpMo/cbALtyB8efbfR7bzofD2G9Xav9Azm+Ei4BIsaie8EyAMs
         a262uAYeSUXfUsZKGlqc39Y3JEZlLgVB0tMeq7Q7Tc9ySyNmEC9ztLkqs2DXFfxBWFkm
         DVP3Dz7hthbFGZfa0tz3GDH752E5wF29GyzVVTkNzPxSSjTt6uv1ZYYdWIWVYEhDTc7t
         qkjNWJDarPYMNCgOZ2DYG/cwkFr82Zv2cdVwV250uMiRE3F+Wfx4Ptr5YfbklgBfBOUl
         Djtg==
X-Gm-Message-State: AC+VfDz6awM6B2dEbmt325xFFro124oU/nwtsZo47Z6E6TERy6puQVAU
        gOGAT4uCy1y4k8E26oegtL4XUBRWXSQI
X-Google-Smtp-Source: ACHHUZ5/i16LNalMfBwII3JCx4rf904hDS6a04mrt2BehMZqCpV2KLS1sxrn8ww6hAtmUEqPo7knz1Y1KKfb
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:d84a:0:b0:562:837:122f with SMTP id
 n10-20020a81d84a000000b005620837122fmr2559264ywl.9.1685172226092; Sat, 27 May
 2023 00:23:46 -0700 (PDT)
Date:   Sat, 27 May 2023 00:22:07 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-32-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 31/34] perf pmus: Ensure all PMUs are read for find_by_type
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf_pmus__find_by_type may be called for something like a raw event,
in which case the PMU isn't guaranteed to have been looked up. Add a
second check to make sure all PMUs are loaded.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/pmus.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 2c512345191d..6ecccb5ad03e 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -142,7 +142,7 @@ static void pmu_read_sysfs(bool core_only)
 	}
 }
 
-struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
+static struct perf_pmu *__perf_pmus__find_by_type(unsigned int type)
 {
 	struct perf_pmu *pmu;
 
@@ -150,6 +150,7 @@ struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
 		if (pmu->type == type)
 			return pmu;
 	}
+
 	list_for_each_entry(pmu, &other_pmus, list) {
 		if (pmu->type == type)
 			return pmu;
@@ -157,6 +158,18 @@ struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
 	return NULL;
 }
 
+struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
+{
+	struct perf_pmu *pmu = __perf_pmus__find_by_type(type);
+
+	if (pmu || read_sysfs_all_pmus)
+		return pmu;
+
+	pmu_read_sysfs(/*core_only=*/false);
+	pmu = __perf_pmus__find_by_type(type);
+	return pmu;
+}
+
 /*
  * pmu iterator: If pmu is NULL, we start at the begin, otherwise return the
  * next pmu. Returns NULL on end.
-- 
2.41.0.rc0.172.g3f132b7071-goog

