Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCB936B15
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Oct 2023 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eidiCyWJ"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59969CF
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Oct 2023 10:56:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a5a16fa94so1041040276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Oct 2023 10:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697133414; x=1697738214; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1DriF+z0M9pYZTrNMVGeu8wBadZBaETJJrGU681YhYE=;
        b=eidiCyWJyMdTHyN/dnpxY2aFaJdKTx4Ui1y6UFfifpD97IYXS0xNa/HSDXgubwDsUp
         xjP80vN1oL+7rlj5DSteS4T3PP0Z0j+jfohKRZSn2FIGwOyZg1NHQ+5iFRxgHZMzMUwU
         o8/fSMvh0tPB3zj4WXMSwrr/nqi9VYfJA+EDA7scQxOPSbNh1/iH+TAb2OR9aoegabV0
         jWNpnGzldJfN+lDH6+jeuS0yYuJm5XgGjoOZv2O7DtUaOX+xmXq7AfER6ezGV8vN3CL/
         47w2Wzr5NzMhZauzlBi/V8SLEe11xvMyFuGARe/yK0jqS/K5A5ymUbuDliDtfw/lrifC
         kyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133414; x=1697738214;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1DriF+z0M9pYZTrNMVGeu8wBadZBaETJJrGU681YhYE=;
        b=SYAM93Gi8jDBeah5DMa9i7at8g5zXS4ajKn0Jj+E9K+DCecpAk+iRMLSB7c4WYOY1m
         46xF3as0ihNh/wOfs21EXnGVu+k8p7gBp/CKZ/Cnq9G1uM4aJwbUePg4LselKP/v81nr
         1VdvOje5IdeDDlEK2te0fWiPjDfOvTJMonWMO9dJIcDefLT42JpaTvtGHh2NrFLCO+PU
         M66UoXGTn6Pd2FtycNfU00oxsnoAhYQdV2ET6lPD6aCCl+OfFqWSiHtxyM4UqN5B6xpV
         M5Z+ZmglhRAGUexOQCHusYrAvu/jqEo4uChMm0QQsKpcinPXWlDFcJJ/+7r1lO7iRGAe
         MInQ==
X-Gm-Message-State: AOJu0YwnvLWmVpjHbYqj1zfIw83E8zoDS+ungNzPfRjsDeju8FcJnxRm
	s/CzhfY6OwFMqcLeP1fhg6nZ8U+aztzA
X-Google-Smtp-Source: AGHT+IGJCQpCnaU4yhScMgzooZf1Pu0cV0LujtmcYzTCrUTSiETa1IxmN2IjJZ1xKXFkuv+ORoIXpfr9G+J7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a89:babc:124b:e4e6])
 (user=irogers job=sendgmr) by 2002:a25:1682:0:b0:ca3:3341:6315 with SMTP id
 124-20020a251682000000b00ca333416315mr539810ybw.0.1697133414595; Thu, 12 Oct
 2023 10:56:54 -0700 (PDT)
Date: Thu, 12 Oct 2023 10:56:40 -0700
In-Reply-To: <20231012175645.1849503-1-irogers@google.com>
Message-Id: <20231012175645.1849503-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231012175645.1849503-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Subject: [PATCH v2 2/7] perf intel-pt: Move PMU initialization from default
 config code
From: Ian Rogers <irogers@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Avoid setting PMU values in intel_pt_pmu_default_config, move to
perf_pmu__arch_init.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 2 --
 tools/perf/arch/x86/util/pmu.c      | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index b923bca939d9..6d6cd8f9133c 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -267,8 +267,6 @@ intel_pt_pmu_default_config(struct perf_pmu *intel_pt_pmu)
 
 	attr->config = intel_pt_default_config(intel_pt_pmu);
 
-	intel_pt_pmu->selectable = true;
-
 	return attr;
 }
 
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 811e2377d2d5..949b3e2c67bd 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -22,6 +22,7 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 #ifdef HAVE_AUXTRACE_SUPPORT
 	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME)) {
 		pmu->auxtrace = true;
+		pmu->selectable = true;
 		pmu->default_config = intel_pt_pmu_default_config(pmu);
 	}
 	if (!strcmp(pmu->name, INTEL_BTS_PMU_NAME)) {
-- 
2.42.0.655.g421f12c284-goog

