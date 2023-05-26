Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C208C77B7C
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 May 2023 21:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243917AbjEZVzV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 May 2023 17:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243916AbjEZVzB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 May 2023 17:55:01 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FD610D2
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 14:54:40 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5654c7f991bso30764967b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 14:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685138079; x=1687730079;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4G044dwOBhR5m2jaMfIZVfXdRdn6jhcUb1KB/kVg+Hc=;
        b=xFmXSnutuvwQaRPV6MvNc57aHCMlqOrcBz+anlNUSEj3MwpOSghgrADN0poHTOpjvl
         hWWbB5YXJ8lmFqKU7VsZjKZ62D72heYstI9VI9J25vvwCODF1sC4jRL61fQn6D0Y9SdI
         /SaYfb2vwVwzFCJEPnO/JJDb5X3ENTIE1xam1KOApN01araedqO6Pf1o5FGwkrY86+PG
         D/eVaI0/Jmgwd8/570KnC/O9pEaEQ8us4rny5IhdRtFT6pmhd85Z9VZ9xcT11ZxFSMmJ
         EPBnSWVA6pr+ZMJ9rccFJKeU2UaNcLpnY498nB2pHVnEA/bdSWjQBiiz3oIaJzz0uvgV
         4Eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685138079; x=1687730079;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4G044dwOBhR5m2jaMfIZVfXdRdn6jhcUb1KB/kVg+Hc=;
        b=VDqw0rS0qlFrQWF/sw81pR2dY7pEgrgRiYnE6io9l9x8nyuUmRAv4qjSy2k0YVUgzN
         tjpjYMi+OMk5uiFL18nRVkIkkIIzZPECf3IVACi06Bop21yIrhEK1iEvhueGlwCaF6ig
         6oQQfJVw1Mq/UxzyfVzlWLsAA9gR3C0q5Yf+VfVk3fibFSWIPBjnsjQ0VOFHZfsZI57D
         slVJ+0EWrfgUQBlAvircy8VLb0EiSR+1r0+wB7dQ30LkaFmNvqC08Rr4RKOYSfvBMRcb
         kIC8eUJfLHbU5QkKjtxJ5oS2HuBJZNSofXEeNpOAkSdRuRBh1uOkSBW6cfKshZG7Wz+f
         1GVw==
X-Gm-Message-State: AC+VfDxAzn81INcoWE/+vW9s4+FhFZxcelHEq66KXqlgudu5SK0hMBeu
        ylFhzZDGKyafuM2Yqx48VhsMB/Z5BSyX
X-Google-Smtp-Source: ACHHUZ5uHH81uEsfWXLMPgmeDcR/Pi44wMN/4hfHAU+pTAxpvx8n7c1uH67wCMUMU0MOfYOiju2EHAJuJsN6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:ae15:0:b0:55a:1488:b479 with SMTP id
 m21-20020a81ae15000000b0055a1488b479mr1842134ywh.1.1685138079209; Fri, 26 May
 2023 14:54:39 -0700 (PDT)
Date:   Fri, 26 May 2023 14:53:46 -0700
In-Reply-To: <20230526215410.2435674-1-irogers@google.com>
Message-Id: <20230526215410.2435674-12-irogers@google.com>
Mime-Version: 1.0
References: <20230526215410.2435674-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v4 11/35] perf target: Remove unused hybrid value
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

Previously this was used to modify CPU map propagation, but it is now
unnecessary as map propagation ensure core PMUs only have valid PMUs
in the CPU map from user requested CPUs.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-record.c | 2 --
 tools/perf/builtin-stat.c   | 1 -
 tools/perf/util/target.h    | 1 -
 3 files changed, 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ec0f2d5f189f..d152ab04a209 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -4204,8 +4204,6 @@ int cmd_record(int argc, const char **argv)
 		goto out;
 	}
 
-	rec->opts.target.hybrid = perf_pmu__has_hybrid();
-
 	if (callchain_param.enabled && callchain_param.record_mode == CALLCHAIN_FP)
 		arch__add_leaf_frame_record_opts(&rec->opts);
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index bc45cee3f77c..c70cb0990661 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2467,7 +2467,6 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 	}
 
-	target.hybrid = perf_pmu__has_hybrid();
 	if (evlist__create_maps(evsel_list, &target) < 0) {
 		if (target__has_task(&target)) {
 			pr_err("Problems finding threads of monitor\n");
diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index 880f1af7f6ad..d582cae8e105 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -17,7 +17,6 @@ struct target {
 	bool	     default_per_cpu;
 	bool	     per_thread;
 	bool	     use_bpf;
-	bool	     hybrid;
 	int	     initial_delay;
 	const char   *attr_map;
 };
-- 
2.41.0.rc0.172.g3f132b7071-goog

