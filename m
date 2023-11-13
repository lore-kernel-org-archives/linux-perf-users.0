Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB0C1CA90;
	Mon, 13 Nov 2023 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A3BE49CB;
	Mon, 13 Nov 2023 03:26:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC2711007;
	Mon, 13 Nov 2023 03:26:41 -0800 (PST)
Received: from e127643.arm.com (unknown [10.57.71.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D16533F6C4;
	Mon, 13 Nov 2023 03:25:53 -0800 (PST)
From: James Clark <james.clark@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	suzuki.poulose@arm.com,
	will@kernel.org,
	mark.rutland@arm.com
Cc: James Clark <james.clark@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] arm64: perf: Include threshold control fields in PMEVTYPER mask
Date: Mon, 13 Nov 2023 11:25:04 +0000
Message-Id: <20231113112507.917107-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113112507.917107-1-james.clark@arm.com>
References: <20231113112507.917107-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FEAT_PMUv3_TH (Armv8.8) adds two new fields to PMEVTYPER, so include
them in the mask. These aren't writable on 32 bit kernels as they are in
the high part of the register, so only include them for arm64.

It would be difficult to do this statically in the asm header files for
each platform without resulting in circular includes or #ifdefs inline
in the code. For that reason the ARMV8_PMU_EVTYPE_MASK definition has
been removed and the mask is constructed programmatically.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/perf/arm_pmuv3.c       | 9 ++++++++-
 include/linux/perf/arm_pmuv3.h | 3 ++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 6ca7be05229c..1d40d794f5e4 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -555,8 +555,15 @@ static void armv8pmu_write_counter(struct perf_event *event, u64 value)
 static inline void armv8pmu_write_evtype(int idx, u32 val)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
+	unsigned long mask = ARMV8_PMU_EVTYPE_EVENT |
+			     ARMV8_PMU_INCLUDE_EL2 |
+			     ARMV8_PMU_EXCLUDE_EL0 |
+			     ARMV8_PMU_EXCLUDE_EL1;
 
-	val &= ARMV8_PMU_EVTYPE_MASK;
+	if (IS_ENABLED(CONFIG_ARM64))
+		mask |= ARMV8_PMU_EVTYPE_TC | ARMV8_PMU_EVTYPE_TH;
+
+	val &= mask;
 	write_pmevtypern(counter, val);
 }
 
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index 9c226adf938a..ddd1fec86739 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -228,7 +228,8 @@
 /*
  * PMXEVTYPER: Event selection reg
  */
-#define ARMV8_PMU_EVTYPE_MASK	0xc800ffff	/* Mask for writable bits */
+#define ARMV8_PMU_EVTYPE_TH	GENMASK(43, 32)
+#define ARMV8_PMU_EVTYPE_TC	GENMASK(63, 61)
 #define ARMV8_PMU_EVTYPE_EVENT	0xffff		/* Mask for EVENT bits */
 
 /*
-- 
2.34.1

