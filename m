Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE9C250BE1
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Mar 2025 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191016; cv=none; b=kxJX+CdoOTj9EoSXB5obW3bYXlPN6iyWLufTqOY7doyqEbXuyhXFlEXDZLyBtNVkj9gLVISLNhtwMrj5+V6+dPfI7Ko3pYS00VL2cb/R0UIzlf/z6G+Phw3/DFlJi/7N7ie0S5Z49BF7Ax5fxGZK16C3VlqAxInUoKuK930MTOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191016; c=relaxed/simple;
	bh=WD/aaA7DsK9CrLikL5N54FoMMdL3W3pJ07qWf3/xuFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lXJKkXsokCVVaO3tMwPwTiOPzH+AwuLTbY2u7lHOcxzWwEo8biwRqrrMnhNcE7ClZcSHIl7AdW4iEssKUKD5EsVxgStq8Y+bs9SLC3w2r3gPH//Qp/0RBCOSk9G09dQK3+LOa0O5sVkcYjhK8iz1qf1NuXklSprJ1fOE3aPiG+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9C461007;
	Wed,  5 Mar 2025 08:10:27 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8FFFC3F5A1;
	Wed,  5 Mar 2025 08:10:13 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	bwicaksono@nvidia.com,
	ilkka@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/3] perf/arm_cspmu: Move register definitons to header
Date: Wed,  5 Mar 2025 16:10:06 +0000
Message-Id: <5a3c796560665b51cb63fec0d473afd8f8d0a836.1741190362.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1741190362.git.robin.murphy@arm.com>
References: <cover.1741190362.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implementations may occasionally want to refer to register offsets, so
for the sake of consistency move all of the register definitions to join
the PMIIDR fields in the private header where they can be shared. As an
example nicety, we can then define Ampere's imp-def filters in terms of
the architectural PMIMPDEF range rather than open-coded offsets.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm_cspmu/ampere_cspmu.c |  8 ++---
 drivers/perf/arm_cspmu/arm_cspmu.c    | 45 --------------------------
 drivers/perf/arm_cspmu/arm_cspmu.h    | 46 +++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 49 deletions(-)

diff --git a/drivers/perf/arm_cspmu/ampere_cspmu.c b/drivers/perf/arm_cspmu/ampere_cspmu.c
index f72f5689923c..31cc1a4ac9df 100644
--- a/drivers/perf/arm_cspmu/ampere_cspmu.c
+++ b/drivers/perf/arm_cspmu/ampere_cspmu.c
@@ -10,10 +10,10 @@
 
 #include "arm_cspmu.h"
 
-#define PMAUXR0		0xD80
-#define PMAUXR1		0xD84
-#define PMAUXR2		0xD88
-#define PMAUXR3		0xD8C
+#define PMAUXR0		PMIMPDEF
+#define PMAUXR1		(PMIMPDEF + 0x4)
+#define PMAUXR2		(PMIMPDEF + 0x8)
+#define PMAUXR3		(PMIMPDEF + 0xC)
 
 #define to_ampere_cspmu_ctx(cspmu)	((struct ampere_cspmu_ctx *)(cspmu->impl.ctx))
 
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 81e8b97e9353..769466d55bea 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -40,51 +40,6 @@
 	ARM_CSPMU_EXT_ATTR(_name, arm_cspmu_cpumask_show,	\
 				(unsigned long)_config)
 
-/*
- * CoreSight PMU Arch register offsets.
- */
-#define PMEVCNTR_LO					0x0
-#define PMEVCNTR_HI					0x4
-#define PMEVTYPER					0x400
-#define PMCCFILTR					0x47C
-#define PMEVFILTR					0xA00
-#define PMCNTENSET					0xC00
-#define PMCNTENCLR					0xC20
-#define PMINTENSET					0xC40
-#define PMINTENCLR					0xC60
-#define PMOVSCLR					0xC80
-#define PMOVSSET					0xCC0
-#define PMCFGR						0xE00
-#define PMCR						0xE04
-#define PMIIDR						0xE08
-
-/* PMCFGR register field */
-#define PMCFGR_NCG					GENMASK(31, 28)
-#define PMCFGR_HDBG					BIT(24)
-#define PMCFGR_TRO					BIT(23)
-#define PMCFGR_SS					BIT(22)
-#define PMCFGR_FZO					BIT(21)
-#define PMCFGR_MSI					BIT(20)
-#define PMCFGR_UEN					BIT(19)
-#define PMCFGR_NA					BIT(17)
-#define PMCFGR_EX					BIT(16)
-#define PMCFGR_CCD					BIT(15)
-#define PMCFGR_CC					BIT(14)
-#define PMCFGR_SIZE					GENMASK(13, 8)
-#define PMCFGR_N					GENMASK(7, 0)
-
-/* PMCR register field */
-#define PMCR_TRO					BIT(11)
-#define PMCR_HDBG					BIT(10)
-#define PMCR_FZO					BIT(9)
-#define PMCR_NA						BIT(8)
-#define PMCR_DP						BIT(5)
-#define PMCR_X						BIT(4)
-#define PMCR_D						BIT(3)
-#define PMCR_C						BIT(2)
-#define PMCR_P						BIT(1)
-#define PMCR_E						BIT(0)
-
 /* Each SET/CLR register supports up to 32 counters. */
 #define ARM_CSPMU_SET_CLR_COUNTER_SHIFT		5
 #define ARM_CSPMU_SET_CLR_COUNTER_NUM		\
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index 2621f3111148..576249e0deea 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -65,6 +65,52 @@
 /* The cycle counter, if implemented, is located at counter[31]. */
 #define ARM_CSPMU_CYCLE_CNTR_IDX	31
 
+/*
+ * CoreSight PMU Arch register offsets.
+ */
+#define PMEVCNTR_LO			0x0
+#define PMEVCNTR_HI			0x4
+#define PMEVTYPER			0x400
+#define PMCCFILTR			0x47C
+#define PMEVFILTR			0xA00
+#define PMCNTENSET			0xC00
+#define PMCNTENCLR			0xC20
+#define PMINTENSET			0xC40
+#define PMINTENCLR			0xC60
+#define PMOVSCLR			0xC80
+#define PMOVSSET			0xCC0
+#define PMIMPDEF			0xD80
+#define PMCFGR				0xE00
+#define PMCR				0xE04
+#define PMIIDR				0xE08
+
+/* PMCFGR register field */
+#define PMCFGR_NCG			GENMASK(31, 28)
+#define PMCFGR_HDBG			BIT(24)
+#define PMCFGR_TRO			BIT(23)
+#define PMCFGR_SS			BIT(22)
+#define PMCFGR_FZO			BIT(21)
+#define PMCFGR_MSI			BIT(20)
+#define PMCFGR_UEN			BIT(19)
+#define PMCFGR_NA			BIT(17)
+#define PMCFGR_EX			BIT(16)
+#define PMCFGR_CCD			BIT(15)
+#define PMCFGR_CC			BIT(14)
+#define PMCFGR_SIZE			GENMASK(13, 8)
+#define PMCFGR_N			GENMASK(7, 0)
+
+/* PMCR register field */
+#define PMCR_TRO			BIT(11)
+#define PMCR_HDBG			BIT(10)
+#define PMCR_FZO			BIT(9)
+#define PMCR_NA				BIT(8)
+#define PMCR_DP				BIT(5)
+#define PMCR_X				BIT(4)
+#define PMCR_D				BIT(3)
+#define PMCR_C				BIT(2)
+#define PMCR_P				BIT(1)
+#define PMCR_E				BIT(0)
+
 /* PMIIDR register field */
 #define ARM_CSPMU_PMIIDR_IMPLEMENTER	GENMASK(11, 0)
 #define ARM_CSPMU_PMIIDR_PRODUCTID	GENMASK(31, 20)
-- 
2.39.2.101.g768bb238c484.dirty

