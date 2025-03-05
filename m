Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DE7250BE1
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Mar 2025 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191018; cv=none; b=PRxlzcgUnePrwYoKj8VLEPv7ETl/GigPgudu1+uSgLncN0IsylDIv7o4se+fo0JpfcPehoCcyl7Nl5RBUq9uF2B8/VtK5Q8bbkXn3qZH6DBlEjYTgtSWYl7ZELUHQN+meplLEaUbTSr0A9TL10hDSV+ywgUBXwPG4aK30+mdU6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191018; c=relaxed/simple;
	bh=byX8p//Nb8GAIZt7uxJDZPnsDgSe16fw8KALHAh9H54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B3JJOjcSbcIl2/Q0Ihax207A4yc+HfOWiMcEQX6E8mEmwIDr4YByg/EltjnmchMraZ7ZUJNknf2nu9TarWAi2AfyDvMUX6W3Zll7Qhngh4K8jqveCOrFJ+JVI3AeLxzoY5cRdBxNlxGKvNRJkBnYAvtfSThiyam+KxuCjX5xUx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0FDA175D;
	Wed,  5 Mar 2025 08:10:29 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AEDAD3F5A1;
	Wed,  5 Mar 2025 08:10:15 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	bwicaksono@nvidia.com,
	ilkka@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 3/3] perf/arm_cspmu: Add PMEVFILT2R support
Date: Wed,  5 Mar 2025 16:10:08 +0000
Message-Id: <b11be3f23a72bc27088b115099c8fe865b70babc.1741190362.git.robin.murphy@arm.com>
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

Architecturally we have two filters for each regular event counter,
so add generic support for the second one too.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 7 +++++--
 drivers/perf/arm_cspmu/arm_cspmu.h | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 053bb7920df6..efa9b229e701 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -183,6 +183,7 @@ arm_cspmu_event_attr_is_visible(struct kobject *kobj,
 static struct attribute *arm_cspmu_format_attrs[] = {
 	ARM_CSPMU_FORMAT_EVENT_ATTR,
 	ARM_CSPMU_FORMAT_FILTER_ATTR,
+	ARM_CSPMU_FORMAT_FILTER2_ATTR,
 	NULL,
 };
 
@@ -767,9 +768,11 @@ static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
 				    const struct perf_event *event)
 {
 	u32 filter = event->attr.config1 & ARM_CSPMU_FILTER_MASK;
-	u32 offset = PMEVFILTR + (4 * hwc->idx);
+	u32 filter2 = event->attr.config2 & ARM_CSPMU_FILTER_MASK;
+	u32 offset = 4 * event->hw.idx;
 
-	writel(filter, cspmu->base0 + offset);
+	writel(filter, cspmu->base0 + PMEVFILTR + offset);
+	writel(filter2, cspmu->base0 + PMEVFILT2R + offset);
 }
 
 static void arm_cspmu_set_cc_filter(struct arm_cspmu *cspmu,
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index d59040d6a7e3..19684b76bd96 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -47,6 +47,8 @@
 /* Default filter format */
 #define ARM_CSPMU_FORMAT_FILTER_ATTR	\
 	ARM_CSPMU_FORMAT_ATTR(filter, "config1:0-31")
+#define ARM_CSPMU_FORMAT_FILTER2_ATTR	\
+	ARM_CSPMU_FORMAT_ATTR(filter2, "config2:0-31")
 
 /*
  * This is the default event number for cycle count, if supported, since the
@@ -72,6 +74,7 @@
 #define PMEVCNTR_HI			0x4
 #define PMEVTYPER			0x400
 #define PMCCFILTR			0x47C
+#define PMEVFILT2R			0x800
 #define PMEVFILTR			0xA00
 #define PMCNTENSET			0xC00
 #define PMCNTENCLR			0xC20
-- 
2.39.2.101.g768bb238c484.dirty

