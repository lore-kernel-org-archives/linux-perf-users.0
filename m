Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB7F261B91;
	Wed,  4 Feb 2026 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196234; cv=none; b=nrmnESnkBvUS2nARBN7OC4vbnucGXuc235PiEnLxbBg3KicgXy2g2USG6r1R/hA5UssTpBWjKI3vV5AC4kC3U+QU4Xj/BSj0Y/l+iY1IiuTCb0ereU5k94lAVdJVrWk8iJIWh0Ffg1GfpxStS57tqikFboU9ag/4H5qEKSvSKv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196234; c=relaxed/simple;
	bh=xEj5OnUPUW1zLEALWJyydAZhc7YcleZPtXdQq+Pp/mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+gTeu27yCfxnKmE4LkjKjIDiyfCrcCmtk7InSyunNC09NhmDQlaler9N7HSn+HhLF7TYHMhJ5eIkWdun12Gxe4DROnBt8XCfq/5A5pnIOP0bWWhXRt1zoKlBCx8kamjJcLSrJ+0NCccx/g4t1A3XavDosqaxvrweboEZzWjzgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=cqLA37bH; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="cqLA37bH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770196189;
	bh=wNxFVp9SwMvu68DNaN3VMLIIc6agpHV/Ct38ND1D/3A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=cqLA37bH7H97elv2MUePBw+5hdA8QAASNoxOks5ZO7fWMqVKrfu2kn9G4a2qEqFs8
	 M0O1Zve+Wefu8ijRegYG6HPInYYN0BcV2kZQQGOgmpwDikCRcSf9CWPlZ5BuWymgi4
	 mrHUe8X0QEXVYaLii59dMBAjw/YSkCYomiU9X33c=
X-QQ-mid: esmtpsz16t1770196187t894d737f
X-QQ-Originating-IP: jEhtf8Ke1cWWElJJRD13VmQVHQDP6UBS657wrKtLB78=
Received: from SurfaceBook2-B.localdomain ( [101.70.125.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Feb 2026 17:09:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8407767476941021042
EX-QQ-RecipientCnt: 19
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
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Jingyu Li <joey.li@spacemit.com>,
	Lv Zheng <lv.zheng@linux.spacemit.com>,
	Zhijian Chen <zhijian@spacemit.com>,
	iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: [PATCH v3 7/8] spacemit/t100: Add SpacemiT T100 IOATC HPM support
Date: Wed,  4 Feb 2026 17:09:41 +0800
Message-ID: <0F510697F46C0563+ebb78dc4d13da9784d17f79c13580c177d187885.1770195980.git.lv.zheng@linux.spacemit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770195980.git.lv.zheng@linux.spacemit.com>
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1770195980.git.lv.zheng@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MyirvGjpKb1jy+lS5ECjAkDZbPyQJQax7YauOWG6gEUTK01g4k0duVtb
	gH2Ju9PD+dfBVuPiI0tWxmTFyavfBY/Z6vbjpn3lsv1vTLryD8Ht3ZKVY8DYDD1L7EaPBrg
	B4QPlHusfC8lBSvdkpBWWdxr08Y5yOElAlQCJ9otqMcWXzZ0i1j2YjyVAhyg6rLZE76xbJh
	r1q4wToWXB3U2zj2734jfhYStYwXFuWgMQv20ZTMOe+Bsl3SqES0h1ly43d/3zRQPJSMbyH
	9uGbyn9/yaqFd/2YF+2FwLxtirxZelNRhrQ6gsN0pJI0NuA+WP1GsoNzdONj+s4iYareIJU
	t22g4IvBk3tZRDCPvdbXIMueyh73SgT4PVmv3nJev13b8fO0tfZAZ9sgOxBzhOaL2s0Klff
	z2UQ1giKb5eUOl/5CpvElQILJ3QQ1Idw+na2JRwavJIYRVQTsDweLb4p5szIPA2hyTv7s0y
	blIifgGsnozPCfL/s3sccnmXWClRFMLqDPFfN+VGVxwqcu1n/FirfkgrSdW8VJaKA33Dc1d
	2FN6fewQG7ldATVdqeTX8Rd0DwPY1TspL9DejnK7fOYdfG9dadwcgmWR9/mgDX9DnbSNVom
	z2tgnYZP7XgLmDxm4JEY8hERFIZd2SzrWw+IP1acAThBnvWZlYLUGzp+BEcK5ptPvPC9E6q
	P6yRtcVWb3dPUyXVtfQMS8Y+9vbG/ztm6qnDPPCnTMB6/F5ahi6zKUmX2tTmcUW2HINtpm0
	H+FndJSYY9pPTCYLITTPeSH+MJ9t3XD7ZMuHwbu+7Zqem5DCyoSaHXvtJCj2m8Xi2lUGxGS
	P9koLuaAP7U4PKZ1du8Et3pEy3jSPAMrjB3F69zD9URKTFXj11cPJdFapaYkvfcrX9W8GME
	GoKmp15JOm/iBTRYEcYRd+kws2RIpEvVc6UVRckVKQf84t7FGm2jJwAPtVMFLXc4ZkP/Tss
	tn3Q0m74JxQ3l9V0IL4WIkcRsCzTK15xffi0tko94NB4pBpkIod36f+lPOOVCfnwSuWaSjb
	YPf+F0aIz+2uxHZ+F7ASTh92/Wplh07+4OfM8nby/fQ2Z1rvHO
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

Adds IOATC discovery and HPM support for SpacemiT T100.

SpacemiT T100 supports distributed architecture which allows IOTLBs to be
cached in adjacent to the DMA masters. Such IOTLB controllers are called
as IOATCs. Adds distributed HPM support for IOATCs.

Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
Signed-off-by: Jingyu Li <joey.li@spacemit.com>
---
 drivers/iommu/riscv/iommu-bits.h     |  12 ++
 drivers/iommu/riscv/iommu-hpm.c      | 178 +++++++++++++++++++++++++--
 drivers/iommu/riscv/iommu-platform.c |   4 +-
 drivers/iommu/riscv/iommu.h          |   2 +-
 4 files changed, 184 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
index cc6bea064d8f..dcf95a99c1d1 100644
--- a/drivers/iommu/riscv/iommu-bits.h
+++ b/drivers/iommu/riscv/iommu-bits.h
@@ -284,6 +284,18 @@ enum riscv_iommu_hpmevent_id {
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
+#define MAX_RISCV_IOMMU_IOATC		64
+#define RISCV_IOMMU_IOATC_BASE(_base, _idx) \
+	((void __iomem *)((u8 __iomem *)(_base) + ((_idx) + 1) * RISCV_IOMMU_REG_SIZE))
+
 /* 5.28 MSI Configuration table (32 * 64bits) */
 #define RISCV_IOMMU_REG_MSI_CFG_TBL	0x0300
 #define RISCV_IOMMU_REG_MSI_CFG_TBL_ADDR(_n) \
diff --git a/drivers/iommu/riscv/iommu-hpm.c b/drivers/iommu/riscv/iommu-hpm.c
index 4a739cb0887c..b027a6ced8b7 100644
--- a/drivers/iommu/riscv/iommu-hpm.c
+++ b/drivers/iommu/riscv/iommu-hpm.c
@@ -31,6 +31,73 @@ static atomic_t riscv_iommu_hpm_ids = ATOMIC_INIT(0);
 static int cpuhp_state_num = -1;
 static int cpuhp_refcnt;
 
+struct riscv_iommu_ioatc_desc {
+	u32 offset;
+	int irq;
+	u32 index;
+};
+
+struct riscv_iommu_unit_info {
+	const char *identifier;
+	const char *ioats;
+	const char *ioatc;
+};
+
+#define RISCV_IOMMU_HPM_UNIT_EXTRACTOR(vid, pid, ioats)	\
+	{ #vid","#pid, #vid"_"#ioats"_hpm", #vid"_ioatc_hpm", }
+
+struct riscv_iommu_unit_info riscv_iommu_hpm_units[] = {
+	RISCV_IOMMU_HPM_UNIT_EXTRACTOR(riscv, iommu, iommu),
+	RISCV_IOMMU_HPM_UNIT_EXTRACTOR(spacemit, riscv-iommu, ioats),
+};
+
+static int riscv_iommu_hpm_collect_ioatcs(struct riscv_iommu_device *iommu,
+					  struct riscv_iommu_ioatc_desc *descs,
+					  int max_desc)
+{
+	struct device *dev = iommu->dev;
+	struct device_node *np = dev->of_node;
+	int count, index;
+	int i, j;
+	u32 dtisr, state;
+	int nr_irqs, irq;
+
+	if (!descs || max_desc <= 0 || !np)
+		return 0;
+
+	if (iommu->irqs_count <= RISCV_IOMMU_INTR_COUNT)
+		nr_irqs = iommu->irqs_count - RISCV_IOMMU_INTR_COUNT;
+	else
+		nr_irqs = 0;
+
+	/* Automatically discover IOATCs by scanning DTISR registers and
+	 * assign IRQs.
+	 */
+	count = 0;
+	for (i = 0; i < 4 && count < max_desc; i++) {
+		dtisr = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_DTISR(i));
+		for (j = 0; j < 16 && count < max_desc; j++) {
+			index = i * 16 + j;
+			state = (dtisr & RISCV_IOMMU_DTI_STS_MASK(index)) >>
+				RISCV_IOMMU_DTI_STS_SHIFT(index);
+			if (state != RISCV_IOMMU_DTI_STS_IOATC)
+				continue;
+			descs[count].offset = (index + 1) *
+					      RISCV_IOMMU_REG_SIZE;
+			descs[count].index = index;
+			if (count < nr_irqs &&
+			    index < MAX_RISCV_IOMMU_IOATC)
+				irq = iommu->irqs[count + RISCV_IOMMU_INTR_COUNT];
+			else
+				irq = 0;
+			descs[count].irq = irq;
+			count++;
+		}
+	}
+
+	return count;
+}
+
 static inline void riscv_iommu_hpm_writel(struct riscv_iommu_hpm *hpm, u32 reg,
 					  u32 val)
 {
@@ -603,6 +670,29 @@ static const struct attribute_group *riscv_iommu_hpm_attr_grps[] = {
 	NULL
 };
 
+#define IOMMU_IOATC_EVENT_ATTR(_name, _id) \
+	PMU_EVENT_ATTR_ID(_name, riscv_iommu_hpm_event_show, _id)
+
+static struct attribute *riscv_iommu_ioatc_events[] = {
+	IOMMU_IOATC_EVENT_ATTR(untrans_rq, RISCV_IOMMU_HPMEVENT_URQ),
+	IOMMU_IOATC_EVENT_ATTR(trans_rq, RISCV_IOMMU_HPMEVENT_TRQ),
+	IOMMU_IOATC_EVENT_ATTR(tlb_mis, RISCV_IOMMU_HPMEVENT_TLB_MISS),
+	NULL
+};
+
+static const struct attribute_group riscv_iommu_ioatc_events_group = {
+	.name = "events",
+	.attrs = riscv_iommu_ioatc_events,
+};
+
+static const struct attribute_group *riscv_iommu_ioatc_attr_grps[] = {
+	&riscv_iommu_hpm_cpumask_group,
+	&riscv_iommu_ioatc_events_group,
+	&riscv_iommu_hpm_format_group,
+	&riscv_iommu_hpm_identifier_group,
+	NULL
+};
+
 static irqreturn_t riscv_iommu_hpm_handle_irq(int irq_num, void *data)
 {
 	struct riscv_iommu_hpm *iommu_hpm = data;
@@ -704,7 +794,31 @@ static void riscv_iommu_hpm_reset(struct riscv_iommu_hpm *iommu_hpm)
 
 static bool riscv_iommu_hpm_is_identifier_compat(const char *compat)
 {
-	return !strcmp(compat, "riscv,iommu");
+	int i;
+	struct riscv_iommu_unit_info *info;
+
+	for (i = 0; i < ARRAY_SIZE(riscv_iommu_hpm_units); i++) {
+		info = &riscv_iommu_hpm_units[i];
+		if (!strcmp(info->identifier, compat))
+			return true;
+	}
+	return false;
+}
+
+static const char *riscv_iommu_hpm_get_unit(const char *identifier,
+					    bool ioatc)
+{
+	int i;
+	struct riscv_iommu_unit_info *info;
+
+	if (identifier) {
+		for (i = 0; i < ARRAY_SIZE(riscv_iommu_hpm_units); i++) {
+			info = &riscv_iommu_hpm_units[i];
+			if (!strcmp(info->identifier, identifier))
+				return ioatc ? info->ioatc : info->ioats;
+		}
+	}
+	return "riscv_iommu_hpm";
 }
 
 static const char *riscv_iommu_hpm_get_identifier(struct device *dev)
@@ -748,6 +862,14 @@ static void riscv_iommu_hpm_set_standard_events(struct riscv_iommu_hpm *iommu_hp
 	set_bit(RISCV_IOMMU_HPMEVENT_G_WALKS, iommu_hpm->supported_events);
 }
 
+static void riscv_iommu_hpm_set_ioatc_events(struct riscv_iommu_hpm *iommu_hpm)
+{
+	/* SpacemiT T100 IOATC compatible HPM events */
+	set_bit(RISCV_IOMMU_HPMEVENT_URQ, iommu_hpm->supported_events);
+	set_bit(RISCV_IOMMU_HPMEVENT_TRQ, iommu_hpm->supported_events);
+	set_bit(RISCV_IOMMU_HPMEVENT_TLB_MISS, iommu_hpm->supported_events);
+}
+
 static void riscv_iommu_hpm_remove(void *data)
 {
 	struct riscv_iommu_hpm *iommu_hpm = data;
@@ -760,16 +882,22 @@ static int riscv_iommu_hpm_register_unit(struct riscv_iommu_device *iommu,
 					 u32 offset, int irq,
 					 const char *identifier,
 					 const struct attribute_group **attr_groups,
-					 const char *prefix)
+					 int index, int *puid)
 {
 	struct device *dev = iommu->dev;
-	const char *pmu_name;
+	const char *pmu_name, *prefix;
 	u32 val;
 	int err;
 	int unique_id;
 	void __iomem *base;
 
-	unique_id = atomic_fetch_inc(&riscv_iommu_hpm_ids);
+	if (index < 0) {
+		unique_id = atomic_fetch_inc(&riscv_iommu_hpm_ids);
+		*puid = unique_id;
+	} else
+		unique_id = *puid;
+	prefix = riscv_iommu_hpm_get_unit(identifier, index >= 0);
+
 	memset(iommu_hpm, 0, sizeof(*iommu_hpm));
 	iommu_hpm->iommu = iommu;
 	iommu_hpm->identifier = identifier;
@@ -801,9 +929,15 @@ static int riscv_iommu_hpm_register_unit(struct riscv_iommu_device *iommu,
 
 	riscv_iommu_hpm_reset(iommu_hpm);
 
-	riscv_iommu_hpm_set_standard_events(iommu_hpm);
-	pmu_name = devm_kasprintf(dev, GFP_KERNEL, "%s_%02x",
-				  prefix, (u8)unique_id);
+	if (index >= 0) {
+		riscv_iommu_hpm_set_ioatc_events(iommu_hpm);
+		pmu_name = devm_kasprintf(dev, GFP_KERNEL, "%s_%02x%02x",
+					  prefix, (u8)unique_id, (u8)index);
+	} else {
+		riscv_iommu_hpm_set_standard_events(iommu_hpm);
+		pmu_name = devm_kasprintf(dev, GFP_KERNEL, "%s_%02x",
+					  prefix, (u8)unique_id);
+	}
 	if (!pmu_name)
 		return -ENOMEM;
 
@@ -905,7 +1039,9 @@ int riscv_iommu_add_hpm(struct riscv_iommu_device *iommu)
 {
 	struct device *dev = iommu->dev;
 	const char *identifier;
-	int irq, rc;
+	int irq, uid, rc, i;
+	struct riscv_iommu_ioatc_desc ioatcs[MAX_RISCV_IOMMU_IOATC];
+	int nr_ioatcs;
 
 	if (!FIELD_GET(RISCV_IOMMU_CAPABILITIES_HPM, iommu->caps)) {
 		dev_dbg(dev, "HPM: Not supported\n");
@@ -930,9 +1066,33 @@ int riscv_iommu_add_hpm(struct riscv_iommu_device *iommu)
 	rc = riscv_iommu_hpm_register_unit(iommu, &iommu->hpm, 0, irq,
 					   identifier,
 					   riscv_iommu_hpm_attr_grps,
-					   "riscv_iommu_hpm");
+					   -1, &uid);
 	if (rc < 0)
 		goto err_module;
+
+	nr_ioatcs = riscv_iommu_hpm_collect_ioatcs(iommu, ioatcs,
+						   ARRAY_SIZE(ioatcs));
+	for (i = 0; i < nr_ioatcs; i++) {
+		struct riscv_iommu_hpm *extra;
+
+		extra = devm_kzalloc(dev, sizeof(*extra), GFP_KERNEL);
+		if (!extra)
+			continue;
+
+		rc = riscv_iommu_hpm_register_unit(iommu, extra,
+						   ioatcs[i].offset,
+						   ioatcs[i].irq,
+						   identifier,
+						   riscv_iommu_ioatc_attr_grps,
+						   ioatcs[i].index, &uid);
+		if (rc) {
+			dev_warn(dev,
+				 "HPM: Failed to register IOATC%u PMU: %d\n",
+				 ioatcs[i].index, rc);
+			continue;
+		}
+	}
+
 	return 0;
 
 err_module:
diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
index 684bc267ac30..ca8de9ec5266 100644
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
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 80e96fd7e164..c2f008d86d63 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -76,7 +76,7 @@ struct riscv_iommu_device {
 	u32 fctl;
 
 	/* available interrupt numbers, MSI or WSI */
-	unsigned int irqs[RISCV_IOMMU_INTR_COUNT];
+	unsigned int irqs[RISCV_IOMMU_INTR_COUNT + MAX_RISCV_IOMMU_IOATC];
 	unsigned int irqs_count;
 	unsigned int icvec;
 
-- 
2.43.0

