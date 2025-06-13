Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BE519E7E2
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Jun 2025 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830060; cv=none; b=G3BdPnyM2NfdmPTQMlNaVt9tdgySmwt+SeMfQMTUqvYsSXkDNI5ldTnwVAVeiEZLzonYOc5JJ6dReFAACFV6ng0kzqqTugPXuYhkf22MmN6d7dUKs5ZWZkbZNfXOrxHUSwb2ejfCOQZfz+FZkhjr8VxJvvREAKVT3oSRu5q4Y+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830060; c=relaxed/simple;
	bh=3zpDOsfoCU797YKrwcbqMEq96zn5L0i02iwgoyawXYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jopn8aNUqQLXggQHrK4F63W86TlqQw5N8aAUNnKL7jZs9ECu0Xeh7U9sqKoBDcQ0USHmdKY4ZC5CeEFoZz2G1XkbKCWcCiekhO8vZ95DP1cfKKU1YD6WWRTdb2BXmhjwY6PVpMAiyFq/tVY+As3eWvkDpgZPy6Cg6ujBuZnLbsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23C791D6F;
	Fri, 13 Jun 2025 08:53:57 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C58CE3F59E;
	Fri, 13 Jun 2025 08:54:15 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 13 Jun 2025 16:53:34 +0100
Subject: [PATCH 01/12] drivers/perf: arm_spe: Store event reserved bits in
 driver data
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-1-6faecf0a8775@arm.com>
References: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-0-6faecf0a8775@arm.com>
In-Reply-To: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-0-6faecf0a8775@arm.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 James Clark <james.clark@linaro.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749830053; l=1674;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=3zpDOsfoCU797YKrwcbqMEq96zn5L0i02iwgoyawXYQ=;
 b=97ZnPdKtIQgns6OVgD9PMKequGgOsiTJqrK6AGHoqfaxA45iZ3uJsUTv1+WIifMSNu7XmNdgI
 gEQG5eMYMcsAJrOrr+iXCgS/scvk51LRfaDEb6sDVM9Yfzjh8bTie5A
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Store the reserved event bits in the driver structure. This cached value
avoids redundant calls to arm_spe_pmsevfr_res0() each time a profiling
session is created.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/perf/arm_spe_pmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 3efed8839a4ec5604eba242cb620327cd2a6a87d..be2ed326bb794d7e5dd1d6cfa89330753ced3ca5 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -77,6 +77,7 @@ struct arm_spe_pmu {
 	u16					pmsver;
 	u16					min_period;
 	u16					counter_sz;
+	u64					pmsevfr_res0;
 
 #define SPE_PMU_FEAT_FILT_EVT			(1UL << 0)
 #define SPE_PMU_FEAT_FILT_TYP			(1UL << 1)
@@ -722,10 +723,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
 	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
 		return -ENOENT;
 
-	if (arm_spe_event_to_pmsevfr(event) & arm_spe_pmsevfr_res0(spe_pmu->pmsver))
+	if (arm_spe_event_to_pmsevfr(event) & spe_pmu->pmsevfr_res0)
 		return -EOPNOTSUPP;
 
-	if (arm_spe_event_to_pmsnevfr(event) & arm_spe_pmsevfr_res0(spe_pmu->pmsver))
+	if (arm_spe_event_to_pmsnevfr(event) & spe_pmu->pmsevfr_res0)
 		return -EOPNOTSUPP;
 
 	if (attr->exclude_idle)
@@ -1103,6 +1104,8 @@ static void __arm_spe_pmu_dev_probe(void *info)
 		spe_pmu->counter_sz = 16;
 	}
 
+	spe_pmu->pmsevfr_res0 = arm_spe_pmsevfr_res0(spe_pmu->pmsver);
+
 	dev_info(dev,
 		 "probed SPEv1.%d for CPUs %*pbl [max_record_sz %u, align %u, features 0x%llx]\n",
 		 spe_pmu->pmsver - 1, cpumask_pr_args(&spe_pmu->supported_cpus),

-- 
2.34.1

