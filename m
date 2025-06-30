Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1940228FAB5
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297067; cv=none; b=jOw60Wt2lXyQ2DmIJSSXDTDf5svFBOnfW8m2E7Pinn8EYcew+fLL61Rg8SpAH66QNik7CzzUNPZmSb84dgrAU3Iqp3kYjAV4ucqwjoJJYwpirkTVtxB8aEE/EkRQ9gWz4QDu/TSpFxfa2vG/cPFawZK/a3UPQXTJUPzblcbvQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297067; c=relaxed/simple;
	bh=f/RF2xJpye65GImm51bgGpXhzYueNZrabRtuT1nfflw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=scSehgg03tnW7bwN30oF/rNa8KcWwis4WDClI01+Arid03LgHrQISgEIUEVfKd1mGm1S+2gJUDGYAzQ+W6EePHG5JsBFVCQFt6MV+o4ozY/558gRfBF9rxKzZjZlOHYH2fUiZHTibwi+ZfvVmwMCd0rcWGC6azo3W0PHtfZBLk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 959391AC1;
	Mon, 30 Jun 2025 08:24:09 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E80CC3F6A8;
	Mon, 30 Jun 2025 08:24:22 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 30 Jun 2025 16:23:39 +0100
Subject: [PATCH v2 07/13] perf arm_spe: Add "event_filter" entry in meta
 data
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-arm_spe_support_hitm_overhead_v1_public-v2-7-2e1afab313b9@arm.com>
References: <20250630-arm_spe_support_hitm_overhead_v1_public-v2-0-2e1afab313b9@arm.com>
In-Reply-To: <20250630-arm_spe_support_hitm_overhead_v1_public-v2-0-2e1afab313b9@arm.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 James Clark <james.clark@linaro.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 German Gomez <german.gomez@arm.com>, Ali Saidi <alisaidi@amazon.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751297044; l=2745;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=f/RF2xJpye65GImm51bgGpXhzYueNZrabRtuT1nfflw=;
 b=9sM5XHHVfbH4dlKtyO+z2i/pluE9Q+65bX0YrcFTrHKFovPxMa8SHg7fJsMGoZ9DIU6d4jWJk
 zxPvg/5HAoyD7vQOieIlm+E8IAmut8nEnuKHPoRa5MdzidPm+SGYysQ
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Add a new "event_filter" entry in the meta data and dump it in raw data
mode.

After:

  # perf script -D
  ...

  0 0 0x470 [0x1f0]: PERF_RECORD_AUXTRACE_INFO type: 4
    Header version     :2
    Header size        :4
    PMU type v2        :11
    CPU number         :8
      Magic            :0x1010101010101010
      CPU #            :0
      Num of params    :4
      MIDR             :0x410fd0f0
      PMU Type         :11
      Min Interval     :256
      Event Filter     :0xffff000003fefffe

  ...

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 5 +++++
 tools/perf/util/arm-spe.c            | 1 +
 tools/perf/util/arm-spe.h            | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 4f2833b62ff55f3fd1dff3f032d6e06528460939..258b5d7b57b1d100bf334ff468c13fb4be9ed78f 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -121,12 +121,17 @@ static int arm_spe_save_cpu_header(struct auxtrace_record *itr,
 		/* No Arm SPE PMU is found */
 		data[ARM_SPE_CPU_PMU_TYPE] = ULLONG_MAX;
 		data[ARM_SPE_CAP_MIN_IVAL] = 0;
+		data[ARM_SPE_CAP_EVENT_FILTER] = 0;
 	} else {
 		data[ARM_SPE_CPU_PMU_TYPE] = pmu->type;
 
 		if (perf_pmu__scan_file(pmu, "caps/min_interval", "%lu", &val) != 1)
 			val = 0;
 		data[ARM_SPE_CAP_MIN_IVAL] = val;
+
+		if (perf_pmu__scan_file(pmu, "caps/event_filter", "%lu", &val) != 1)
+			val = 0;
+		data[ARM_SPE_CAP_EVENT_FILTER] = val;
 	}
 
 	free(cpuid);
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index fec11322690ec156500335c86812f55b1bcfb4bb..ec6a81a497c54d2418b885008685f0f74e00500e 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -1535,6 +1535,7 @@ static const char * const metadata_per_cpu_fmts[] = {
 	[ARM_SPE_CPU_MIDR]		= "    MIDR             :0x%"PRIx64"\n",
 	[ARM_SPE_CPU_PMU_TYPE]		= "    PMU Type         :%"PRId64"\n",
 	[ARM_SPE_CAP_MIN_IVAL]		= "    Min Interval     :%"PRId64"\n",
+	[ARM_SPE_CAP_EVENT_FILTER]	= "    Event Filter     :0x%"PRIx64"\n",
 };
 
 static void arm_spe_print_info(struct arm_spe *spe, __u64 *arr)
diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
index 390679a4af2fb61419bc881b5dc43c01f1dd77d7..3966df1856d8234bb5fe580c3f128c4d238c6221 100644
--- a/tools/perf/util/arm-spe.h
+++ b/tools/perf/util/arm-spe.h
@@ -47,6 +47,8 @@ enum {
 	ARM_SPE_CPU_PMU_TYPE,
 	/* Minimal interval */
 	ARM_SPE_CAP_MIN_IVAL,
+	/* Event filter */
+	ARM_SPE_CAP_EVENT_FILTER,
 	ARM_SPE_CPU_PRIV_MAX,
 };
 

-- 
2.34.1

