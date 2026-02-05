Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF1737B415;
	Thu,  5 Feb 2026 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770282728; cv=none; b=el7acwrg1B6aTQ26bvXufOItHYeqGG+C6pRq+T/D7KY+a8QEi4Db0w5o1g2fgv4YkSdq612mWpBkgcAKoQh2y+qBtHkHl3s9NnwxbtBZoEfpAfQZMBJMeFgQ6GDJ/yCHL6jffNuMefdcwHXmLVpJXRbGFWdgw4Z2IXWZWe4mMTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770282728; c=relaxed/simple;
	bh=AnLCWgCQKViPgiA499L3uUMh/EI+B9GxvrlxUd5o2A8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k97lNU+OR2q1zPwWcAv6YpGq2sQxclxMd5AaJZQ6rnEwL237p7+mOTS39C4IoL67LMeT2YmnO0sIcrxPg9jnqZZ/Dp2/QVxzZXKZleFcazS9DeWllmhvDMyXyMIW2o/vRRTlWWehBn15UN1QrDWQfKU61pyEpyaIcibFkeCDrk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=jAOTaQ94; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="jAOTaQ94"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770282679;
	bh=L2p0zp+cQRAjJUUGC4NNjprxB33gstqyzL3bAeI2IYc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=jAOTaQ94Sz2UEztCHDh8CZNdqJR7MsIdwuH5a7t5hVWuhZVeWs5WF6Plv4Z4jRIMq
	 4qg6NmIMZ7Jqw0yrjJlw8Qz194+slu5pCxUO8TJ+VfwLsin+zFXqP923pxtt7kGUgT
	 iL1hBXI/rfcXy4rNyWXEB+4YMVJ2xE42Lsv0DNaQ=
X-QQ-mid: zesmtpgz6t1770282677t7c2d8e87
X-QQ-Originating-IP: nJ4iG/LXkJlcAVN6h3Sz33f3lai7g7YMNApnqp3xih4=
Received: from SurfaceBook2-B.localdomain ( [101.70.125.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 05 Feb 2026 17:11:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2526299659581257440
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
Subject: [PATCH v4 6/7] spacemit/t100: Add SpacemiT T100 IOATC HPM support
Date: Thu,  5 Feb 2026 17:11:12 +0800
Message-ID: <F99A0287EE9E1D75+845d79919af65974934a096fbf005adeccddc79b.1770281596.git.lv.zheng@linux.spacemit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770281596.git.lv.zheng@linux.spacemit.com>
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1770281596.git.lv.zheng@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NoFe3wCY3jEyeJmWEv3RoAARS7uQOuibBT0g/K7M6xLvtGFMVWvOcKz4
	QjaTaBvPpIqqHu+BzXHJDaLRxw5xqoYIQvTWnj1Ph6rLzsD616qKiQ4KdaHLeSmFwpcWusn
	LQNRY5ki1GLASiIeTCkQGAabVc4pqMp+z2syTjSw/HCDsiKR4aNw6N4rQpiIC5gpYyrIOsb
	T/spdSfFe+gYMOMBlGGiha8ubj5bg2GF5Jr9tA8XeLXYY92RmDBDip/pcL4U4EYXOvFf+6z
	nbMVKqLsl+qjnf2lxf87/9MlFAlYiVvG7LevvYhhOr6yRf9pkFIWcl2JgiGawTBcpv8C3/s
	OuiuBhxIzou9Loi47hhX68uvKAbMqEo/pRvLt1o+WRl419Xl2MIB2ytLggEESNJRHmYMP6X
	q3uuvfGibmWJMnozzQw53LiN3653sSAZkCrCZli1o9VS+FcWGB0GTCQN2OSZIhCELjbgegq
	0ktrq0mg6XY/UpMTKwPtZ5SvrPQVYMbtsRFMHWT80m7PXSwJETeuPAy8bgNcSVj+ZO0yCZN
	L9KXxZoj1bYQefg73vntoQBTIMtSxCeWeaMhKD5tPgZ4SwF0kkJwEZxXdcpRWFrsy7LFJfi
	J4bYODHCA1zEIgBvvFcgVjK1SI10OocjQN3Y2RHDJb5rAlUS8ApuLjIQjdgw1iQpCILEXq/
	6IX6uEUOmdIF2xpgBE719TPdckOU3EYPLZL4KguIACdvENxsN/hlEGcye5/BxrvQLs5rRPZ
	lchbdCMpb5Tts8G3Yyn0mj/uXRH2iXTUr3arSG2oD6+B4q2hawgCXhX3N/NVUlyf20ClmE+
	eOy2ZfjUbYHiJnR4iaTQposEVFqbL3+shXiOjLHY4GfyKNI7ReidkkC+Y84KPGOdGeiT5XV
	1iUmmu31vwMXnEZ1fHWSZ2QSJPDcpbBkmT/ML31v+co5G6CWL4BdIjODonwOCe3YWXiVGxA
	A5klZiRs/S9QsSr+helWLT7t2UxXBIn0olxSGy6CSaMOI9pzQlmcfw/kGOa1n/CxWlJtHBU
	1N0Uppqy4gBLgfppWJNaKT8zD9aVY1qe3MFCPmYBZKxpXMM2tqcLnze5LZDck=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

Adds IOATC discovery and HPM support for SpacemiT T100.

SpacemiT T100 supports distributed architecture which allows IOTLBs to be
cached in adjacent to the DMA masters. Such IOTLB controllers are called
as IOATCs. Adds distributed HPM support for IOATCs.

Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
Signed-off-by: Jingyu Li <joey.li@spacemit.com>
---
 drivers/iommu/riscv/iommu-bits.h     |  12 ++
 drivers/iommu/riscv/iommu-hpm.c      | 182 +++++++++++++++++++++++++--
 drivers/iommu/riscv/iommu-platform.c |   4 +-
 drivers/iommu/riscv/iommu.h          |   2 +-
 4 files changed, 188 insertions(+), 12 deletions(-)

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
index 6860714fb61e..4463416537a7 100644
--- a/drivers/iommu/riscv/iommu-hpm.c
+++ b/drivers/iommu/riscv/iommu-hpm.c
@@ -31,6 +31,77 @@ static atomic_t riscv_iommu_hpm_ids = ATOMIC_INIT(0);
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
+	int count, index;
+	int i, j;
+	u32 dtisr, state;
+	int irq, nr_ioats_irqs, nr_ioatc_irqs;
+
+	if (!of_device_is_compatible(dev->of_node, "spacemit,riscv-iommu"))
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
+			if (count < nr_ioatc_irqs &&
+			    index < MAX_RISCV_IOMMU_IOATC)
+				irq = iommu->irqs[count + nr_ioats_irqs];
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
@@ -599,6 +670,29 @@ static const struct attribute_group *riscv_iommu_hpm_attr_grps[] = {
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
@@ -700,7 +794,31 @@ static void riscv_iommu_hpm_reset(struct riscv_iommu_hpm *iommu_hpm)
 
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
@@ -744,6 +862,14 @@ static void riscv_iommu_hpm_set_standard_events(struct riscv_iommu_hpm *iommu_hp
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
@@ -756,16 +882,22 @@ static int riscv_iommu_hpm_register_unit(struct riscv_iommu_device *iommu,
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
@@ -797,9 +929,15 @@ static int riscv_iommu_hpm_register_unit(struct riscv_iommu_device *iommu,
 
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
 
@@ -902,7 +1040,9 @@ int riscv_iommu_add_hpm(struct riscv_iommu_device *iommu)
 {
 	struct device *dev = iommu->dev;
 	const char *identifier;
-	int irq, rc;
+	int irq, uid, rc, i;
+	struct riscv_iommu_ioatc_desc ioatcs[MAX_RISCV_IOMMU_IOATC];
+	int nr_ioatcs;
 
 	if (!FIELD_GET(RISCV_IOMMU_CAPABILITIES_HPM, iommu->caps)) {
 		dev_dbg(dev, "HPM: Not supported\n");
@@ -927,9 +1067,33 @@ int riscv_iommu_add_hpm(struct riscv_iommu_device *iommu)
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
+				 "HPM: Failed to register IOATC%u: %d\n",
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

