Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3691231352B
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Sep 2025 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691781; cv=none; b=TK/Os5p1x+0eN/ufhkypPPteYwhQdkcrVghczqtAHB8h4wEQV1EX9qgf22GXhJ6g590saQ/E6Xk6glqaoQYNtpD096FYZTWknynB2GN+thNGWBNjD1+zNLt2HOrahLZZhD2KEqP/dliWPiO4orinpr3gp7b45hog2mtmNi7rDXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691781; c=relaxed/simple;
	bh=B/9ePTi8sxuuKlUG38K+dU3DkACqi1L8KBK9hf+bQNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PqCKYFf96u/wo8HzbPE3WXLQkibE0eFrj4b4fP3TTE0DOCpvdMcEQYvMV45GbH8GQr2CbBJ0hxryEf7qTMQ2TYjn7MMmsdUxt1nYGJLi8KQP+XeOSIkCstitmx5RGmpe3Pk5PUYzCz7UD5dWAV+aI7ABh6+TztBJgyZQ4AOehzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4246B1515;
	Fri, 12 Sep 2025 08:42:51 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82D963F694;
	Fri, 12 Sep 2025 08:42:57 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 12 Sep 2025 16:42:13 +0100
Subject: [PATCH v5 08/14] perf arm_spe: Add "event_filter" entry in meta
 data
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-arm_spe_support_hitm_overhead_v1_public-v5-8-0800880da0a7@arm.com>
References: <20250912-arm_spe_support_hitm_overhead_v1_public-v5-0-0800880da0a7@arm.com>
In-Reply-To: <20250912-arm_spe_support_hitm_overhead_v1_public-v5-0-0800880da0a7@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757691759; l=2736;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=B/9ePTi8sxuuKlUG38K+dU3DkACqi1L8KBK9hf+bQNs=;
 b=/4VfGARmY0AHVKxdXytsqLExPvP7mCT7uGBiQxryLyjFeckOyPtjLSxpihGMp1LzGEJekPNn3
 f1vEAjm4dosDd6Sls9I2pcdOeWOrb1gqdBEAAViv1AVdQV2yQD6gUi8
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
      Event Filter     :0x3fe08fe

  ...

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 5 +++++
 tools/perf/util/arm-spe.c            | 1 +
 tools/perf/util/arm-spe.h            | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 4f2833b62ff55f3fd1dff3f032d6e06528460939..cac43cde7dbee94884938482d03989a2c69cb0b1 100644
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
+		if (perf_pmu__scan_file(pmu, "caps/event_filter", "%lx", &val) != 1)
+			val = 0;
+		data[ARM_SPE_CAP_EVENT_FILTER] = val;
 	}
 
 	free(cpuid);
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 38e6f8331f2790b9cd3bc94d5a18657d7e0f5e42..24968fc15693e4e6dcbe67dcdc85a261e0f701b7 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -1532,6 +1532,7 @@ static const char * const metadata_per_cpu_fmts[] = {
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

