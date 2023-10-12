Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3337637147
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Oct 2023 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uu8sZ+F+"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4691E4
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Oct 2023 10:56:57 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f61a639b9so19069697b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Oct 2023 10:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697133417; x=1697738217; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aOJDtrxPGTgwsjnVTtwsj44sT9bZCuzCaACKvoaEh5I=;
        b=uu8sZ+F+Tlg4lloNczA/cg6+IxTQbgIzQHZIYLY3rwP4eVXqslIBy/TAVdxpGi4UJn
         dAkWcneZURScCPozFeJZ4w48siXBKojyWFJLkoM1i1pvvtfS+b0wI4iFA0mDTbuimIIX
         nhngemULdCTo2aMY5FlzzXBX/CKGPUJ66s2IVorF4HX9X2s/sjMmGoI9CiXrLROUHXPI
         sait+vikVO1+4l35EoUndcAWPhPINosGlCNiQBTxnLcg1E2Wml8BhdO/+hrdolPOUzgc
         +ccGYS2jerWhtWIJ6ZO+WYtyxW0r7cRc+xeJuaFm3wA1l6XygMGf1Dhjs2GxVkbQVNzG
         8AAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697133417; x=1697738217;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOJDtrxPGTgwsjnVTtwsj44sT9bZCuzCaACKvoaEh5I=;
        b=p9xnWoEoM0RMk+ACD0LuaxIMkeO7fryrEXxyDP3Ss6t2vTrJbUHk4ZGuNo3YKRDQK5
         DXTxwMGMFgbFfT38WAZse4qPzOQlbB4a+atOtMH8P7J9g2Gh2IZjB/zFch2n3mNBbINp
         zNaNX8xY4NSl4Sp9nFNszfCW+QzmdqT/PdLONnDx05kx5Pe9RXrP/IYue6f4A1QIAOsx
         FqxvoA33oQer06CKJG9c3YH6FbdC2pDrlypPkpb+kyBZuqli1fYeIUohH7Pa5AQ0nx+G
         KFMW63wplhk6iGHASrii6jQrtADR8mXEXzhVwydwu8RVFExVvD3idD64VQLajOjfHoD0
         EFpw==
X-Gm-Message-State: AOJu0YzOxJzoDroGUs2tUOhEDnQjfKDWDDigZnsA1Mjf1ah+eVPKwxfo
	PDL+5A386nMbETmMalsz1FUdu+jEy7bP
X-Google-Smtp-Source: AGHT+IH5JBbJ4A+WWp75UpTSyPiqzorsBTCtiOASPPXAptT0Y20my3OuyidYczRdzVrU4qbmOcWk3C/NiTEZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6a89:babc:124b:e4e6])
 (user=irogers job=sendgmr) by 2002:a81:af27:0:b0:5a7:b54e:bfc1 with SMTP id
 n39-20020a81af27000000b005a7b54ebfc1mr231194ywh.10.1697133416964; Thu, 12 Oct
 2023 10:56:56 -0700 (PDT)
Date: Thu, 12 Oct 2023 10:56:41 -0700
In-Reply-To: <20231012175645.1849503-1-irogers@google.com>
Message-Id: <20231012175645.1849503-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231012175645.1849503-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Subject: [PATCH v2 3/7] perf arm-spe: Move PMU initialization from default
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
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
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
2.42.0.655.g421f12c284-goog

