Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB1343DA3E;
	Sat, 28 Feb 2026 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290036; cv=none; b=BaHjoe7zpGvn/2YtFBOaCRcHBO0u55eAJEMqKhBghCqqf598Zfg/A5gQq9zPLFR3JGuAv8QKPWN+/5e0QQMbXTjRe7SsrbPMtdotILQ9SyqtZ68f2+DA+qpKw/20+XLopHO++SLOTQxuj16JN+zgLGOIeNFVMhkI5BwKZ2U5uHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290036; c=relaxed/simple;
	bh=EQvkTCMLkJtPAlSbis8SzbcqDnIZa+dfFOonC1ntmPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6Yj3WmP0jAyxSIHiXyrqiFwZniAFfhzLlwivsFVdHd2JRWEFkUuTuYj5zuc+UDkolkQ1ti9+RMjSgm7SJcswJzPbtI+TpPmpDvczbHs4BFiD5XZ3HOKyus9rL2UZFU/Xnp+pZ/mW5VXNAOAnxVQs9xYIyOencVHaowWlIIWwOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=euAEnLfh; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="euAEnLfh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1772289919;
	bh=yOxXPAZ860TZFdcVWU1J2MnJnut1yaALwmPzJ9AGbwQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=euAEnLfhmgTcWKdfWs4dFIpq9NE2jp47DPGxHkjVT/HOnnrDddaI2Bc4cERjutx22
	 x9W3NXW3KGrz6Fco9ZKrvSTRfAyx+4fa41LDha6VVPGmMDZ4mbGGdL/w3QzuVPJ6mg
	 QINQmV6A+Qy85JdeOSUfrsjmsSDYp2zTyWOdYpTA=
X-QQ-mid: esmtpgz16t1772289917tba247742
X-QQ-Originating-IP: fjmleJzQ8tZlpEdLnFR4tWVf0dBULQWXhn1c7XZm8ic=
Received: from SurfaceBook2-B.localdomain ( [183.193.112.19])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 28 Feb 2026 22:45:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6367620818006765051
EX-QQ-RecipientCnt: 33
From: Lv Zheng <lv.zheng@linux.spacemit.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Yixun Lan <dlan@kernel.org>
Cc: Jingyu Li <joey.li@spacemit.com>,
	Lv Zheng <lv.zheng@linux.spacemit.com>,
	Zong Li <zong.li@sifive.com>,
	Yaxing Guo <guoyaxing@bosc.ac.cn>,
	Zhijian Chen <zhijian@spacemit.com>,
	iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/8] iommu/riscv: Add SpacemiT T100 IOATC HPM support
Date: Sat, 28 Feb 2026 22:45:08 +0800
Message-ID: <5A0B289754F26E1F+94635e48c8e661abefcdeec3271f680c641a14d8.1772289741.git.lv.zheng@linux.spacemit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772289741.git.lv.zheng@linux.spacemit.com>
References: <cover.1772289741.git.lv.zheng@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: ML8hOghqQD+0T0ztYTTMi1QhP8RF3BSJdSrDAOnTgaiY9PXfB8Rx0cY9
	TZAeSB73XtedEFU3xQkmagtWA2ZDGAnRnlizXqt18t/OIMWENlAAdNGyHPzRTl/QxJlnT49
	1uX0JKygZNWok8dO0gCHZjn4qKVPTm0Y0q0AtboYecAvVkQo4sNRVoAh+c9IvpQIimotT+R
	azjUPu7jo8au5z3C87Qrmed80BTju0EBsIWE6Y0d3bvmbsXZcLm5QoFru9Vd5TzkDpS/0bo
	Vql2KsrLdjlaHAlwDyj2E7mI+g6JrgCoDvjTSl4RV33eNVkJRgalDWFNWW2MgQcljnh8lF/
	qFsn1JdC/yXYTywC1U6N0eVUuEfiKDIz6vl26kiTI844HnopfNbKX+pf9GY1y18+3Y2GvZR
	j396+AoWnQY2k2xWDfV0ul/v33qjtFdnD6fD74UGUa4aVC9WBeCbgMV+ZIdb9h1T0FbjtW2
	4hsf+uX782HB9OCErOPbttEWiu3sz02DHwrMlAGhVzFknRfVf9jUBE33KpLlsDaBf+5Ge3E
	z7l/izLpqQRWUtsrUfv/HnaxgVOQguff5u+OIpph9kXumeCY3E/GwCTcacAt/NrjLgR6ndD
	CM1h6NFQdpOJkNO7EtoiCnjude+zcGDBmkQ/65J98++C5m4vA2O+MU89bY0kH1TCZHETMN1
	gJb5rN2IjvaEMdfTSSXK+4dpa9UNj9nu687nezRj6Hh2yNGWrB11ohZu71OjqNo9T9yFk7M
	q+w0qvXExfe/Fyp7iRmmyEfjQTqDwEFgH44RrK6PWWvaJM31QB7Tf411Rb+bhX0Mc0poLeq
	LLR+zsmvPDszZWG+Aqn0LC+V+3aAPAVqYwlZVumzpTWKoerJ+KrAAtauttZCU+FmX8Q6E4h
	kbZBzWgsAouLXlzEBevIkwWz9ZHA/okVtCR2gN0PRa/H9x4FELEr0OPZ3NRwZM2WHPpOIDK
	wdr4pPYAYbmKrD4MPVUjjl/6kYype3vvu7RGHyoBTTkb/hasCWUznFoXX2r7bnVnNl2TUzN
	mQAaPVa6m8bneHc5ukyqjTDLP9h53j47oht0fBmyBi0tSIUoYtY46grgOkRLKJ3yGGRm/E8
	6qB3v91VSUX
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Add IOATC discovery and HPM support for SpacemiT T100.

SpacemiT T100 supports distributed architecture which allows IOTLBs to be
cached in adjacent to the DMA masters. Such IOTLB controllers are called
as IOATCs. Adds distributed HPM support for IOATCs.

Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
Signed-off-by: Jingyu Li <joey.li@spacemit.com>
---
 drivers/iommu/riscv/iommu-bits.h     |  12 +++
 drivers/iommu/riscv/iommu-platform.c |   4 +-
 drivers/iommu/riscv/iommu.c          | 107 ++++++++++++++++++++++++++-
 drivers/iommu/riscv/iommu.h          |   2 +-
 drivers/perf/riscv_iommu_hpm.c       |  48 +++++++++++-
 include/linux/riscv_iommu.h          |   6 +-
 6 files changed, 171 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
index 98daf0e1a306..c8536c64ef42 100644
--- a/drivers/iommu/riscv/iommu-bits.h
+++ b/drivers/iommu/riscv/iommu-bits.h
@@ -278,6 +278,14 @@ enum riscv_iommu_hpmevent_id {
 #define RISCV_IOMMU_ICVEC_PMIV		GENMASK_ULL(11, 8)
 #define RISCV_IOMMU_ICVEC_PIV		GENMASK_ULL(15, 12)
 
+/* 5.28 Distributed translation interface status register (dtisr0-3) (4 * 32-bits) */
+#define RISCV_IOMMU_REG_DTISR_BASE	0x02B0
+#define RISCV_IOMMU_REG_DTISR(_n)	(RISCV_IOMMU_REG_DTISR_BASE + ((_n) * 0x04))
+#define RISCV_IOMMU_DTI_STS_SHIFT(_n)	(((_n) % 16) * 2)
+#define RISCV_IOMMU_DTI_STS_MASK(_n)	(0x3 << RISCV_IOMMU_DTI_STS_SHIFT(_n))
+#define RISCV_IOMMU_DTI_STS_NONE	0x0
+#define RISCV_IOMMU_DTI_STS_IOATC	0x1
+
 /* 5.28 MSI Configuration table (32 * 64bits) */
 #define RISCV_IOMMU_REG_MSI_CFG_TBL	0x0300
 #define RISCV_IOMMU_REG_MSI_CFG_TBL_ADDR(_n) \
@@ -292,6 +300,10 @@ enum riscv_iommu_hpmevent_id {
 
 #define RISCV_IOMMU_REG_SIZE	0x1000
 
+/* SpacemiT IOMMU IOATC registers */
+#define MAX_RISCV_IOMMU_IOATC		64
+#define RISCV_IOMMU_IOATC_BASE(_idx)	(((_idx) + 1) * RISCV_IOMMU_REG_SIZE)
+
 /*
  * Chapter 2: Data structures
  */
diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
index e8e52bca8856..469b8bfd2151 100644
--- a/drivers/iommu/riscv/iommu-platform.c
+++ b/drivers/iommu/riscv/iommu-platform.c
@@ -75,8 +75,8 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
 	if (iommu->irqs_count <= 0)
 		return dev_err_probe(dev, -ENODEV,
 				     "no IRQ resources provided\n");
-	if (iommu->irqs_count > RISCV_IOMMU_INTR_COUNT)
-		iommu->irqs_count = RISCV_IOMMU_INTR_COUNT;
+	if (iommu->irqs_count > RISCV_IOMMU_INTR_COUNT + MAX_RISCV_IOMMU_IOATC)
+		iommu->irqs_count = RISCV_IOMMU_INTR_COUNT + MAX_RISCV_IOMMU_IOATC;
 
 	igs = FIELD_GET(RISCV_IOMMU_CAPABILITIES_IGS, iommu->caps);
 	switch (igs) {
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 21ff7e50d115..e10011493228 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -55,9 +55,21 @@ struct riscv_iommu_devres {
 	void *addr;
 };
 
+static unsigned int riscv_iommu_reg_ipsr(struct riscv_iommu_subdev *subdev)
+{
+	struct riscv_iommu_hpm_info *info = subdev->info;
+	unsigned int offset;
+
+	if (info && info->is_ioatc)
+		offset = RISCV_IOMMU_IOATC_BASE(info->index);
+	else
+		offset = 0;
+	return offset + RISCV_IOMMU_REG_IPSR;
+}
+
 bool riscv_iommu_pmip_status(struct riscv_iommu_subdev *subdev)
 {
-	u32 ipsr = riscv_iommu_readl(subdev->iommu, RISCV_IOMMU_REG_IPSR);
+	u32 ipsr = riscv_iommu_readl(subdev->iommu, riscv_iommu_reg_ipsr(subdev));
 
 	return !!(ipsr & RISCV_IOMMU_IPSR_PMIP);
 }
@@ -65,7 +77,7 @@ EXPORT_SYMBOL_GPL(riscv_iommu_pmip_status);
 
 void riscv_iommu_clear_pmip(struct riscv_iommu_subdev *subdev)
 {
-	riscv_iommu_writel(subdev->iommu, RISCV_IOMMU_REG_IPSR,
+	riscv_iommu_writel(subdev->iommu, riscv_iommu_reg_ipsr(subdev),
 			   RISCV_IOMMU_IPSR_PMIP);
 }
 EXPORT_SYMBOL_GPL(riscv_iommu_clear_pmip);
@@ -1710,6 +1722,7 @@ static void riscv_iommu_enumerate_hpm(struct riscv_iommu_device *iommu)
 		return;
 
 	hpm_info->irq = irq;
+	hpm_info->is_ioatc = false;
 
 	params = (struct riscv_iommu_subdev_params) {
 		.name = "riscv_iommu_hpm",
@@ -1731,6 +1744,95 @@ static void riscv_iommu_enumerate_hpm(struct riscv_iommu_device *iommu)
 	}
 }
 
+struct riscv_iommu_ioatc_desc {
+	int irq;
+	u32 index;
+};
+
+static int riscv_iommu_collect_ioatcs(struct riscv_iommu_device *iommu,
+				      struct riscv_iommu_ioatc_desc *descs,
+				      int max_desc)
+{
+	struct device *dev = iommu->dev;
+	int count, index, i, j;
+	u32 dtisr, state;
+	int nr_ioats_irqs, nr_ioatc_irqs;
+
+	if (!of_device_is_compatible(dev->of_node, "spacemit,t100"))
+		return 0;
+
+	if (iommu->fctl & RISCV_IOMMU_FCTL_WSI)
+		nr_ioats_irqs = 1;
+	else
+		nr_ioats_irqs = RISCV_IOMMU_INTR_COUNT;
+
+	if (iommu->irqs_count > nr_ioats_irqs)
+		nr_ioatc_irqs = iommu->irqs_count - nr_ioats_irqs;
+	else
+		nr_ioatc_irqs = 0;
+
+	count = 0;
+	for (i = 0; i < 4 && count < max_desc; i++) {
+		dtisr = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_DTISR(i));
+		for (j = 0; j < 16 && count < max_desc; j++) {
+			index = i * 16 + j;
+			state = (dtisr & RISCV_IOMMU_DTI_STS_MASK(index)) >>
+				RISCV_IOMMU_DTI_STS_SHIFT(index);
+			if (state != RISCV_IOMMU_DTI_STS_IOATC)
+				continue;
+			descs[count].index = index;
+			if (count < nr_ioatc_irqs && index < MAX_RISCV_IOMMU_IOATC)
+				descs[count].irq = iommu->irqs[count + nr_ioats_irqs];
+			else
+				descs[count].irq = 0;
+			count++;
+		}
+	}
+	return count;
+}
+
+static void riscv_iommu_enumerate_ioatc(struct riscv_iommu_device *iommu)
+{
+	struct riscv_iommu_ioatc_desc ioatcs[MAX_RISCV_IOMMU_IOATC];
+	struct riscv_iommu_hpm_info *ioatc_info;
+	struct riscv_iommu_subdev_params params;
+	void __iomem *base;
+	int nr_ioatcs, i, ret;
+
+	nr_ioatcs = riscv_iommu_collect_ioatcs(iommu, ioatcs, ARRAY_SIZE(ioatcs));
+	if (nr_ioatcs <= 0)
+		return;
+
+	for (i = 0; i < nr_ioatcs; i++) {
+		if (ioatcs[i].irq <= 0)
+			continue;
+
+		ioatc_info = kzalloc(sizeof(*ioatc_info), GFP_KERNEL);
+		if (!ioatc_info)
+			continue;
+
+		ioatc_info->irq = ioatcs[i].irq;
+		ioatc_info->index = ioatcs[i].index;
+		ioatc_info->global_filter = true;
+		ioatc_info->is_ioatc = true;
+
+		base = iommu->reg + RISCV_IOMMU_IOATC_BASE(ioatcs[i].index);
+
+		params = (struct riscv_iommu_subdev_params) {
+			.name = "spacemit_ioatc_hpm",
+			.info = ioatc_info,
+			.base = base + RISCV_IOMMU_REG_IOCOUNTOVF,
+		};
+
+		ret = riscv_iommu_subdev_add(iommu, &params);
+		if (ret) {
+			kfree(ioatc_info);
+			dev_warn(iommu->dev, "Failed to add IOATC%u: %d\n",
+				 ioatcs[i].index, ret);
+		}
+	}
+}
+
 /**
  * riscv_iommu_subdev_setup - Enumerate auxiliary bus subdevices
  *
@@ -1743,6 +1845,7 @@ static void riscv_iommu_enumerate_hpm(struct riscv_iommu_device *iommu)
 void riscv_iommu_subdev_setup(struct riscv_iommu_device *iommu)
 {
 	riscv_iommu_enumerate_hpm(iommu);
+	riscv_iommu_enumerate_ioatc(iommu);
 }
 
 /**
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 1296625488ef..f1bb682dd478 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -51,7 +51,7 @@ struct riscv_iommu_device {
 	u32 fctl;
 
 	/* available interrupt numbers, MSI or WSI */
-	unsigned int irqs[RISCV_IOMMU_INTR_COUNT];
+	unsigned int irqs[RISCV_IOMMU_INTR_COUNT + MAX_RISCV_IOMMU_IOATC];
 	unsigned int irqs_count;
 	unsigned int icvec;
 
diff --git a/drivers/perf/riscv_iommu_hpm.c b/drivers/perf/riscv_iommu_hpm.c
index efa65caef0dc..b166b3cb6d4f 100644
--- a/drivers/perf/riscv_iommu_hpm.c
+++ b/drivers/perf/riscv_iommu_hpm.c
@@ -681,6 +681,31 @@ static const struct attribute_group *riscv_iommu_hpm_attr_grps[] = {
 	NULL
 };
 
+#define IOMMU_IOATC_EVENT_ATTR(_name, _id) \
+	PMU_EVENT_ATTR_ID(_name, riscv_iommu_hpm_event_show, _id)
+
+static struct attribute *riscv_iommu_hpm_ioatc_events[] = {
+	IOMMU_IOATC_EVENT_ATTR(cycles, RISCV_IOMMU_HPMEVENT_CYCLES),
+	IOMMU_IOATC_EVENT_ATTR(untrans_rq, RISCV_IOMMU_HPMEVENT_URQ),
+	IOMMU_IOATC_EVENT_ATTR(trans_rq, RISCV_IOMMU_HPMEVENT_TRQ),
+	IOMMU_IOATC_EVENT_ATTR(tlb_mis, RISCV_IOMMU_HPMEVENT_TLB_MISS),
+	NULL
+};
+
+static const struct attribute_group riscv_iommu_hpm_ioatc_events_group = {
+	.name = "events",
+	.attrs = riscv_iommu_hpm_ioatc_events,
+	.is_visible = riscv_iommu_hpm_event_is_visible,
+};
+
+static const struct attribute_group *riscv_iommu_hpm_ioatc_attr_grps[] = {
+	&riscv_iommu_hpm_cpumask_group,
+	&riscv_iommu_hpm_ioatc_events_group,
+	&riscv_iommu_hpm_format_group,
+	&riscv_iommu_hpm_vendor_group,
+	NULL
+};
+
 static irqreturn_t riscv_iommu_hpm_handle_irq(int irq_num, void *data)
 {
 	struct riscv_iommu_hpm *hpm = data;
@@ -826,6 +851,15 @@ static void riscv_iommu_hpm_set_standard_events(struct riscv_iommu_hpm *hpm)
 	set_bit(RISCV_IOMMU_HPMEVENT_G_WALKS, hpm->supported_events);
 }
 
+static void riscv_iommu_hpm_set_ioatc_events(struct riscv_iommu_hpm *hpm)
+{
+	/* SpacemiT T100 IOATC: subset of events (URQ, TRQ, TLB_MISS) */
+	set_bit(RISCV_IOMMU_HPMEVENT_CYCLES, hpm->supported_events);
+	set_bit(RISCV_IOMMU_HPMEVENT_URQ, hpm->supported_events);
+	set_bit(RISCV_IOMMU_HPMEVENT_TRQ, hpm->supported_events);
+	set_bit(RISCV_IOMMU_HPMEVENT_TLB_MISS, hpm->supported_events);
+}
+
 static int riscv_iommu_hpm_probe(struct auxiliary_device *auxdev,
 				 const struct auxiliary_device_id *id)
 {
@@ -834,6 +868,8 @@ static int riscv_iommu_hpm_probe(struct auxiliary_device *auxdev,
 	struct device *dev = &auxdev->dev;
 	struct riscv_iommu_hpm_info *info;
 	const char *hpm_name;
+	const struct attribute_group **attr_grps;
+	bool is_ioatc;
 	u32 val;
 	int err;
 
@@ -858,6 +894,7 @@ static int riscv_iommu_hpm_probe(struct auxiliary_device *auxdev,
 	hpm->on_cpu = raw_smp_processor_id();
 	hpm->irq = info->irq;
 	hpm->global_filter = info->global_filter;
+	is_ioatc = info->is_ioatc;
 
 	bitmap_zero(hpm->used_counters, RISCV_IOMMU_HPMCOUNTER_MAX);
 	bitmap_zero(hpm->supported_events, RISCV_IOMMU_HPMEVENT_MAX);
@@ -869,7 +906,13 @@ static int riscv_iommu_hpm_probe(struct auxiliary_device *auxdev,
 		return -ENODEV;
 
 	riscv_iommu_hpm_reset(hpm);
-	riscv_iommu_hpm_set_standard_events(hpm);
+	if (is_ioatc)
+		riscv_iommu_hpm_set_ioatc_events(hpm);
+	else
+		riscv_iommu_hpm_set_standard_events(hpm);
+
+	attr_grps = is_ioatc ? riscv_iommu_hpm_ioatc_attr_grps :
+			       riscv_iommu_hpm_attr_grps;
 
 	hpm_name = devm_kstrdup(dev, dev_name(dev), GFP_KERNEL);
 	if (!hpm_name)
@@ -893,7 +936,7 @@ static int riscv_iommu_hpm_probe(struct auxiliary_device *auxdev,
 		.start = riscv_iommu_hpm_event_start,
 		.stop = riscv_iommu_hpm_event_stop,
 		.read = riscv_iommu_hpm_event_update,
-		.attr_groups = riscv_iommu_hpm_attr_grps,
+		.attr_groups = attr_grps,
 		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
@@ -931,6 +974,7 @@ static void riscv_iommu_hpm_remove(struct auxiliary_device *auxdev)
 static const struct auxiliary_device_id riscv_iommu_hpm_ids[] = {
 	{ .name = "iommu.riscv_iommu_hpm" },
 	{ .name = "iommu.spacemit_ioats_hpm" },
+	{ .name = "iommu.spacemit_ioatc_hpm" },
 	{}
 };
 MODULE_DEVICE_TABLE(auxiliary, riscv_iommu_hpm_ids);
diff --git a/include/linux/riscv_iommu.h b/include/linux/riscv_iommu.h
index 6af592dfaa00..71a961731c22 100644
--- a/include/linux/riscv_iommu.h
+++ b/include/linux/riscv_iommu.h
@@ -34,13 +34,17 @@ struct riscv_iommu_subdev {
 };
 
 /**
- * struct riscv_iommu_hpm_info - HPM info for IOATS (main IOMMU HPM)
+ * struct riscv_iommu_hpm_info - HPM info for IOATS and IOATC
  * @irq: interrupt number
  * @global_filter: true if single global filter
+ * @is_ioatc: false for IOATS, true for IOATC
+ * @index: DTISR index for IOATC (0-63), 0 for IOATS
  */
 struct riscv_iommu_hpm_info {
 	unsigned int irq;
 	bool global_filter;
+	bool is_ioatc;
+	u8 index;
 };
 
 /**
-- 
2.43.0

