Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0407117D4
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Oct 2023 02:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gIt3Ep8w"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60100DB
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Oct 2023 19:13:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d852a6749bcso3569529276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Oct 2023 19:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696644833; x=1697249633; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pvm9pouxrmYpafgNbDUzq8jjG9nkQlQXFZB/wFYV4ZY=;
        b=gIt3Ep8wQrLm5/xI11pGeuKoRgXc+4+1ky3tENwptnfMrV8Dnhm3eUn1Neff+jr1ht
         nBrZOdSRuch7YtiJZveOIztjN0qXG2QNjG4D/2Tfg4Sd0asjIbseR0Oah4fLyeMSY48S
         YjBwRKLA297NCyCDHgpE6s8X7N/0ObtaPH37elx4oPFSpgPEUoHJXBX4LZnKt4wsx4On
         27bm+ZfEJoxBXe3SB7+49GKV8Zq+8mclPXthEw9fZa46wA3Vdu138lDMb8C0fs4OkOnj
         iXfNjPP8zqpIpu0nSJWP72ij6NxLspjEyzc5fxRiG2DySZRC5e09/vnediUEpzY2KV8B
         Ui+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696644833; x=1697249633;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pvm9pouxrmYpafgNbDUzq8jjG9nkQlQXFZB/wFYV4ZY=;
        b=Q5yJWV8DKyh87T1VYQuYI9FQAcRg7eswDm5pBzzQnXuzuGhay8C0EnXNcF8cIO0HmW
         dcdAagSzXBae14kL32g+MwWzMipsphf3MRmo7E+NHjfwMzRx6hY3vC3WOaEttNTY5eis
         +70ix1lwYWCf+WocKzGQTTplLOybqJOc1/U+swguVkqLcO//hAMI7x2Qip1Dli+2j1rN
         8MSq0W+LJpytfGwtHeevtq9cxlZg/G9nPDmiSteeLTy1yDLw+9rJSiwOaIGYUIUOQqrX
         uzVyho+dXhCLcGpFBykvnFX4LxpIi7sWLYumHIQknN/KBrjODjzxOX+tue6XtSc/TQvC
         DToQ==
X-Gm-Message-State: AOJu0YxZlnoO9H26oh3hMsOVJxY5R7TC6gnk3YgLeagd2Sq5EeNGGGjg
	yF859oPpJS/sIRM0eUPrSJ7m1QvqdIQX
X-Google-Smtp-Source: AGHT+IG/FCsfFR7DMO8ROGGKaKObepHsSbay/fgC+twT50YsCh2lPxyqOr65LGKvE49Mf12qsmL2OTWovX1b
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7031:b36b:6c77:bfd0])
 (user=irogers job=sendgmr) by 2002:a25:d313:0:b0:d7b:92d7:5629 with SMTP id
 e19-20020a25d313000000b00d7b92d75629mr166217ybf.8.1696644833466; Fri, 06 Oct
 2023 19:13:53 -0700 (PDT)
Date: Fri,  6 Oct 2023 19:13:22 -0700
In-Reply-To: <20231007021326.4156714-1-irogers@google.com>
Message-Id: <20231007021326.4156714-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231007021326.4156714-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v1 3/7] perf arm-spe: Move PMU initialization from default
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

Avoid setting PMU values in arm_spe_pmu_default_config, move to
perf_pmu__arch_init.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/arm/util/pmu.c       | 2 ++
 tools/perf/arch/arm64/util/arm-spe.c | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
index d55d2b15f2e6..f25f68f84a94 100644
--- a/tools/perf/arch/arm/util/pmu.c
+++ b/tools/perf/arch/arm/util/pmu.c
@@ -23,6 +23,8 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
 		pmu->default_config = cs_etm_get_default_config(pmu);
 #if defined(__aarch64__)
 	} else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
+		pmu->selectable = true;
+		pmu->is_uncore = false;
 		pmu->default_config = arm_spe_pmu_default_config(pmu);
 	} else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
 		pmu->selectable = true;
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 9cc3d6dcb849..08a76734ccd2 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -516,8 +516,5 @@ struct perf_event_attr
 		attr->sample_period = 4096;
 	}
 
-	arm_spe_pmu->selectable = true;
-	arm_spe_pmu->is_uncore = false;
-
 	return attr;
 }
-- 
2.42.0.609.gbb76f46606-goog

