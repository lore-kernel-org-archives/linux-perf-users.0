Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AF21389
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Oct 2023 02:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZCHYazk"
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403EEC5
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Oct 2023 19:13:49 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c6181dacf6so26192855ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Oct 2023 19:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696644829; x=1697249629; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i5RKZfGZL5ZN24K59cxhmD3rtiYGzQzY3XxKePQ3ZgM=;
        b=PZCHYazkJSBPB3vomDtueKCVn6riQXW3jReQ2aLLN2jN8Okt+M5tCvynD2bSOPt2oJ
         hyjvow9RXNGrVHl17EC4bV0M9NfQw200vLGJURYYEwFcFZbw7uRAnQvwMIBdgJZ1+xc9
         xNxQTy/yhti1NttJ0YBADgae4F74+i3gyWf3IIjLi0W+F7U0uHBny/bK8Ny+6hXRhzqT
         w1OjtJ/oqneDg6Lxzsb/CSqhKjTbeC1L6I71B589wYxTOqU8PrSdumNFG09mol5FeSwS
         Ddyu0/PaC7ktsyiAbpHrxz2lhEZZHA7iTcjMQro39K7nYKiQHyhYdVmpEaZ+VHcShmHq
         /wIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696644829; x=1697249629;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5RKZfGZL5ZN24K59cxhmD3rtiYGzQzY3XxKePQ3ZgM=;
        b=OV/CSbH/ThQcceDa6BNGcpWVAgE17suFY5v3MEoSEFBr/ZveZSHZj4cv6kEpLm6+By
         tvxVvVVB2the2GeC9cKIwjSw0niGfTJfOehcBQJsNPCzzo0dXVWpCEG0UKhCTXbtYFxH
         WqLOVz/trFhLETTImYBf49EcWNekDe5MsXxZHLw1jUXXUfLRR6aKYcLfsWwcJl99L9Bj
         4cGubF250KOY82a13GxoxJZstXaqgZ+lVXatKa89nHxrQQhOL7ZSZdneT9OJNyJFlHbi
         hUzDlR25O8lxUovQ5ORNbT+umPdz68KhwOEhQvZMBRBMQEb/1nHSmEz+Mshl2Gy5Ssr8
         leNw==
X-Gm-Message-State: AOJu0YyNTgzlrn2gLpDrILTgC5aHcP84QW6fr4ZADGp+GufoAaAufUuh
	9pZkaa5Wyg52PGNcYRAoxpZ45Yxh/Hys
X-Google-Smtp-Source: AGHT+IFEQHBXRzXKr3+91VRDR8irSgTTsHC729rDg2CcgCqsveTA/8HbK0apOoOyJBuf0flmH7tBJuB9l3t9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7031:b36b:6c77:bfd0])
 (user=irogers job=sendgmr) by 2002:a17:902:c949:b0:1c8:9a60:3885 with SMTP id
 i9-20020a170902c94900b001c89a603885mr17899pla.13.1696644827821; Fri, 06 Oct
 2023 19:13:47 -0700 (PDT)
Date: Fri,  6 Oct 2023 19:13:20 -0700
In-Reply-To: <20231007021326.4156714-1-irogers@google.com>
Message-Id: <20231007021326.4156714-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231007021326.4156714-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v1 1/7] perf pmu: Rename perf_pmu__get_default_config to perf_pmu__arch_init
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
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Assign default_config as part of the
init. perf_pmu__get_default_config was doing more than just getting
the default config and so this is intended to better align with the
code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm/util/pmu.c  |  8 +++-----
 tools/perf/arch/s390/util/pmu.c |  3 +--
 tools/perf/arch/x86/util/pmu.c  |  5 ++---
 tools/perf/util/pmu.c           | 14 +++++++-------
 tools/perf/util/pmu.h           |  2 +-
 5 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index a9623b128ece..d55d2b15f2e6 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -14,22 +14,20 @@
 #include "../../../util/pmu.h"
 #include "../../../util/cs-etm.h"
 
-struct perf_event_attr
-*perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
+void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 {
 #ifdef HAVE_AUXTRACE_SUPPORT
 	if (!strcmp(pmu->name, CORESIGHT_ETM_PMU_NAME)) {
 		/* add ETM default config here */
 		pmu->selectable = true;
-		return cs_etm_get_default_config(pmu);
+		pmu->default_config = cs_etm_get_default_config(pmu);
 #if defined(__aarch64__)
 	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
-		return arm_spe_pmu_default_config(pmu);
+		pmu->default_config = arm_spe_pmu_default_config(pmu);
 	} else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
 		pmu->selectable = true;
 #endif
 	}
 
 #endif
-	return NULL;
 }
diff --git a/tools/perf/arch/s390/util/pmu.c b/tools/perf/arch/s390/util/pmu.c
index 11f03f32e3fd..886c30e001fa 100644
--- a/tools/perf/arch/s390/util/pmu.c
+++ b/tools/perf/arch/s390/util/pmu.c
@@ -13,11 +13,10 @@
 #define	S390_PMUPAI_EXT		"pai_ext"
 #define	S390_PMUCPUM_CF		"cpum_cf"
 
-struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu)
+void perf_pmu__arch_init(struct perf_pmu *pmu)
 {
 	if (!strcmp(pmu->name, S390_PMUPAI_CRYPTO) ||
 	    !strcmp(pmu->name, S390_PMUPAI_EXT) ||
 	    !strcmp(pmu->name, S390_PMUCPUM_CF))
 		pmu->selectable = true;
-	return NULL;
 }
diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 8b53ca468a50..811e2377d2d5 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -17,19 +17,18 @@
 #include "../../../util/pmus.h"
 #include "env.h"
 
-struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
+void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 {
 #ifdef HAVE_AUXTRACE_SUPPORT
 	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME)) {
 		pmu->auxtrace = true;
-		return intel_pt_pmu_default_config(pmu);
+		pmu->default_config = intel_pt_pmu_default_config(pmu);
 	}
 	if (!strcmp(pmu->name, INTEL_BTS_PMU_NAME)) {
 		pmu->auxtrace = true;
 		pmu->selectable = true;
 	}
 #endif
-	return NULL;
 }
 
 int perf_pmus__num_mem_pmus(void)
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6b1b7f8f00fa..6e95b3d2c2e3 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -954,12 +954,6 @@ void pmu_add_sys_aliases(struct perf_pmu *pmu)
 	pmu_for_each_sys_event(pmu_add_sys_aliases_iter_fn, pmu);
 }
 
-struct perf_event_attr * __weak
-perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
-{
-	return NULL;
-}
-
 static char *pmu_find_alias_name(struct perf_pmu *pmu, int dirfd)
 {
 	FILE *file = perf_pmu__open_file_at(pmu, dirfd, "alias");
@@ -991,6 +985,12 @@ static int pmu_max_precise(int dirfd, struct perf_pmu *pmu)
 	return max_precise;
 }
 
+
+void __weak
+perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
+{
+}
+
 struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *name)
 {
 	struct perf_pmu *pmu;
@@ -1037,7 +1037,7 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	pmu_add_sys_aliases(pmu);
 	list_add_tail(&pmu->list, pmus);
 
-	pmu->default_config = perf_pmu__get_default_config(pmu);
+	perf_pmu__arch_init(pmu);
 
 	return pmu;
 err:
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 85190d058852..588c64e38d6b 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -233,7 +233,7 @@ bool perf_pmu__file_exists(struct perf_pmu *pmu, const char *name);
 
 int perf_pmu__test(void);
 
-struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu);
+void perf_pmu__arch_init(struct perf_pmu *pmu);
 void pmu_add_cpu_aliases_table(struct perf_pmu *pmu,
 			       const struct pmu_events_table *table);
 
-- 
2.42.0.609.gbb76f46606-goog

