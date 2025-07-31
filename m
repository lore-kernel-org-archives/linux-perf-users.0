Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3850A2D23AD
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Jul 2025 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968433; cv=none; b=XeYpK3uZ/CKKZormh2ZlZwgKF+bHwhaOzCFdKGNJxxcmSp5wnCKRaygBWo2n5jki2gmqmRzTlzUPQYEfx1I/aYiVmpLDrw2I0AVIQLIHWvQ2J2Ut6n+aSEIjN2eZXVWZCdDi1iIrLNiIRFqNnIfuiQXeSxCDqmb3NmwEUZi3OE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968433; c=relaxed/simple;
	bh=8G2Gc1AR41WRF/sgOZ5wCNo1szmzkuiVOQPUd3E0w/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KBD+b40YNS1A+VU4eRnZE9742GLo1NWE0imQ/KHk0etqmOgJWoeiaBxiVAiQuqhjyAy6bl4YlZv2dI+6yY6Sjng5/ePIUW3SOr1RKWi7y6Im36daIRyfdtnOgSRLT1AkFRjY8/7FaNUC7H6yhocy+QqlzoeZ4AWI2tNSwN7i9AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B2EE2C42;
	Thu, 31 Jul 2025 06:27:03 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 763013F66E;
	Thu, 31 Jul 2025 06:27:09 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 31 Jul 2025 14:25:38 +0100
Subject: [PATCH v4 03/15] perf arm_spe: Correct setting remote access
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-3-58e5677a412b@arm.com>
References: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-0-58e5677a412b@arm.com>
In-Reply-To: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-0-58e5677a412b@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753968422; l=852;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=8G2Gc1AR41WRF/sgOZ5wCNo1szmzkuiVOQPUd3E0w/Q=;
 b=4dftCI7ux0w8fC8KXnV0SPITGBcf9O1nFJ7c14ynlYo30a7U1SHjMkxDlhycqLv7MFkUbqYjG
 0l4mr5S8zUMApvVwgmP00FyMBYHirqJj8zEsS1wuBTjYznQLelDeeGf
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Set the mem_remote field for a remote access to appropriately represent
the event.

Fixes: a89dbc9b988f ("perf arm-spe: Set sample's data source field")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 8942fa598a84fb70f8c66649395bfbedcd42d380..8ecf7142dcd8705c13c27e0cbacd69647dc4fd22 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -839,7 +839,7 @@ static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
 	}
 
 	if (record->type & ARM_SPE_REMOTE_ACCESS)
-		data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;
+		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
 }
 
 static bool arm_spe__synth_ds(struct arm_spe_queue *speq,

-- 
2.34.1

