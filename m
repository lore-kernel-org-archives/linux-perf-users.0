Received: from sg-1-18.ptr.blmpb.com (sg-1-18.ptr.blmpb.com [118.26.132.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945237756C
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Jan 2026 06:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769666992; cv=none; b=UIVkn3py/S/p/43tPIK3HrPiYuztx+gJ8Ahrd5ee5lq8J9Gq7VGcIJxgC06KqaOsJnbS8hxA6rXPJrqbqy9+bIRK+zexwOteI8mLRHFhTY7rFpQl4IO702cBSR4uiCzzalxF9C895mgITy4yDzPtDS590SXV/UyicIXUwgrJcnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769666992; c=relaxed/simple;
	bh=DQngXeEPxr6O3D+VwGLsgasd3foV9ofWHpa9l/e6nrE=;
	h=Content-Type:Cc:Subject:Date:Mime-Version:Message-Id:References:
	 To:From:In-Reply-To; b=Do4u24zklo/+hVhApN8h/RiiWVNZtkbhSFs/d9Yi2wLc718hOOZE0+INJqUKrY7dEqH2jwSghqNTH3Wd6bOO/I5ayZInIPqNMy6Z1KKPMkY9OUeh4tYTmDdN9P7BGxotE+SApcDfQJUicg0kE9+g8exIzjxTjnDhtYAle0rOdjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com; spf=pass smtp.mailfrom=spacemit.com; dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b=Hgtc3J2w; arc=none smtp.client-ip=118.26.132.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b="Hgtc3J2w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303021642; d=spacemit.com; t=1769666983; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=xPIRlMwggDtMQrQNc1BFI2a5l+k5jLJExfhPbWAqPoc=;
 b=Hgtc3J2wpgVp/vRzoIWCtlp1K09jpvzrs1pc1JGcnlpf5+0NkfaM7uvpPIUzB/rKx+Wkn6
 OuU7H/JhKtiReXdI9V8ygzAFCo3tSd1aerUTmxlZoaIJ5JyNQ1uP1iiIgCFBldO2P9JbuX
 MFtboSPz83cj050ggwMJAb46c/+7463Fdn4QD1+5PQKIYFqk6AZzYosFQIJKPGm3mErSLh
 V5RWWbwyj1HpCpD+4nV0xtzD0MZxet9BTR+dFyxuvpHhQPagbPzGe1Lk/htsnKL4vMzs/6
 XKIOH0D6fXTUSubNjqsi/ciyVcL4rx6qPCIkse5t7w9zu/eHmeQeHI1wVKd9tA==
Content-Type: text/plain; charset=UTF-8
Cc: "Jingyu Li" <joey.li@spacemit.com>, "Lv Zheng" <lv.zheng@spacemit.com>, 
	"Zhijian Chen" <zhijian@spacemit.com>, <iommu@lists.linux.dev>, 
	<linux-perf-users@vger.kernel.org>, <linux-riscv@lists.infradead.org>, 
	<spacemit@lists.linux.dev>, <devicetree@vger.kernel.org>
Subject: [PATCH v1.1 7/7] spacemit/t100: Add SpacemiT T100 IOATC HPM support
Date: Thu, 29 Jan 2026 14:09:37 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <f8112a0e017dc5dde2053303dfeecf756177b48b.1769666438.git.lv.zheng@spacemit.com>
X-Mailer: git-send-email 2.43.0
Received: from SurfaceBook2-B.localdomain ([122.224.183.70]) by smtp.feishu.cn with ESMTPS; Thu, 29 Jan 2026 14:09:40 +0800
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1769666438.git.lv.zheng@spacemit.com>
X-Original-From: Lv Zheng <lv.zheng@spacemit.com>
X-Lms-Return-Path: <lba+2697af9a5+7da765+vger.kernel.org+lv.zheng@spacemit.com>
To: "Tomasz Jeznach" <tjeznach@rivosinc.com>, 
	"Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>, 
	"Robin Murphy" <robin.murphy@arm.com>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, "Paul Walmsley" <pjw@kernel.org>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>
From: "Lv Zheng" <lv.zheng@spacemit.com>
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cover.1769666438.git.lv.zheng@spacemit.com>

Adds IOATC discovery and HPM support for SpacemiT T100.

SpacemiT T100 supports distributed architecture which allows IOTLBs to be
cached in adjacent to the DMA masters. Such IOTLBs controllers are called
as IOATC, this patch adds distributed HPM support for IOATCs.

Signed-off-by: Lv Zheng <lv.zheng@spacemit.com>
Signed-off-by: Jingyu Li <joey.li@spacemit.com>
---
 drivers/iommu/riscv/iommu-bits.h     |  12 ++
 drivers/iommu/riscv/iommu-hpm.c      | 173 ++++++++++++++++++++++++++-
 drivers/iommu/riscv/iommu-platform.c |   4 +-
 drivers/iommu/riscv/iommu.h          |   2 +-
 4 files changed, 184 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-b=
its.h
index f1fbf3cc6ba5..4dae9f378169 100644
--- a/drivers/iommu/riscv/iommu-bits.h
+++ b/drivers/iommu/riscv/iommu-bits.h
@@ -284,6 +284,18 @@ enum riscv_iommu_hpmevent_id {
 #define RISCV_IOMMU_ICVEC_PMIV		GENMASK_ULL(11, 8)
 #define RISCV_IOMMU_ICVEC_PIV		GENMASK_ULL(15, 12)
=20
+/* 5.28 Distributed translation interface status register (dtisr0-3) (4 * =
32-bits) */
+#define RISCV_IOMMU_REG_DTISR_BASE	0x02B0
+#define RISCV_IOMMU_REG_DTISR(_n)	(RISCV_IOMMU_REG_DTISR_BASE + ((_n) * 0x=
04))
+#define RISCV_IOMMU_DTI_STS_SHIFT(_n)	(((_n) % 16) * 2)
+#define RISCV_IOMMU_DTI_STS_MASK(_n)	(0x3 << RISCV_IOMMU_DTI_STS_SHIFT(_n)=
)
+#define RISCV_IOMMU_DTI_STS_NONE	0x0
+#define RISCV_IOMMU_DTI_STS_TBU_IOATC	0x1
+
+#define MAX_RISCV_IOMMU_IOATC		64
+#define RISCV_IOMMU_IOATC_BASE(_base, _idx) \
+	((void __iomem *)((u8 __iomem *)(_base) + ((_idx) + 1) * RISCV_IOMMU_REG_=
SIZE))
+
 /* 5.28 MSI Configuration table (32 * 64bits) */
 #define RISCV_IOMMU_REG_MSI_CFG_TBL	0x0300
 #define RISCV_IOMMU_REG_MSI_CFG_TBL_ADDR(_n) \
diff --git a/drivers/iommu/riscv/iommu-hpm.c b/drivers/iommu/riscv/iommu-hp=
m.c
index 23e1afc262ea..b97afddea6b3 100644
--- a/drivers/iommu/riscv/iommu-hpm.c
+++ b/drivers/iommu/riscv/iommu-hpm.c
@@ -7,6 +7,7 @@
  *                 Lv Zheng <lv.zheng@spacemit.com>
  */
=20
+#include <linux/platform_device.h>
 #include "iommu.h"
=20
 #define to_iommu_hpm(p) (container_of(p, struct riscv_iommu_hpm, pmu))
@@ -31,6 +32,94 @@ static atomic_t riscv_iommu_hpm_ids =3D ATOMIC_INIT(0);
 static int cpuhp_state_num =3D -1;
 static int cpuhp_refcnt;
=20
+struct riscv_iommu_ioatc_desc {
+	u32 offset;
+	int irq;
+	u32 index;
+};
+
+static int riscv_iommu_hpm_collect_ioatcs(struct riscv_iommu_device *iommu=
,
+					  struct riscv_iommu_ioatc_desc *descs,
+					  int max_desc)
+{
+	struct device *dev =3D iommu->dev;
+	struct device_node *np =3D dev->of_node;
+	struct platform_device *pdev =3D to_platform_device(dev);
+	int count =3D 0;
+	int i;
+	int *ioatc_irqs =3D NULL;
+
+	if (!descs || max_desc <=3D 0)
+		return 0;
+
+	if (np) {
+		int names_count =3D of_property_count_strings(np, "interrupt-names");
+		const char *name;
+		int irq_idx;
+		u32 ioatc_idx;
+
+		ioatc_irqs =3D kcalloc(MAX_RISCV_IOMMU_IOATC, sizeof(int), GFP_KERNEL);
+		if (!ioatc_irqs)
+			goto discover;
+
+		for (i =3D 0; i < names_count; i++) {
+			if (of_property_read_string_index(np, "interrupt-names",
+							  i, &name))
+				continue;
+
+			if (!strstr(name, "ioatc") || !strstr(name, "hpm"))
+				continue;
+
+			if (sscanf(name, "ioatc%u-hpm", &ioatc_idx) !=3D 1)
+				continue;
+
+			if (ioatc_idx >=3D MAX_RISCV_IOMMU_IOATC)
+				continue;
+
+			if (i < iommu->irqs_count) {
+				irq_idx =3D iommu->irqs[i];
+				ioatc_irqs[ioatc_idx] =3D irq_idx;
+			} else {
+				irq_idx =3D platform_get_irq(pdev, i);
+				if (irq_idx < 0)
+					ioatc_irqs[ioatc_idx] =3D 0;
+				else
+					ioatc_irqs[ioatc_idx] =3D irq_idx;
+			}
+		}
+	}
+
+discover:
+	/* Automatically discover IOATCs by scanning DTISR registers */
+	for (i =3D 0; i < 4 && count < max_desc; i++) {
+		u32 dtisr =3D riscv_iommu_readl(iommu, RISCV_IOMMU_REG_DTISR(i));
+		int j;
+
+		for (j =3D 0; j < 16 && count < max_desc; j++) {
+			u32 idx =3D i * 16 + j;
+			u32 state;
+
+			state =3D (dtisr & RISCV_IOMMU_DTI_STS_MASK(idx)) >>
+				RISCV_IOMMU_DTI_STS_SHIFT(idx);
+			if (state =3D=3D RISCV_IOMMU_DTI_STS_TBU_IOATC) {
+				descs[count].offset =3D (idx + 1) * RISCV_IOMMU_REG_SIZE;
+				descs[count].index =3D idx;
+
+				if (ioatc_irqs && idx < MAX_RISCV_IOMMU_IOATC &&
+				    ioatc_irqs[idx] > 0)
+					descs[count].irq =3D ioatc_irqs[idx];
+				else
+					descs[count].irq =3D 0;
+				count++;
+			}
+		}
+	}
+
+	kfree(ioatc_irqs);
+
+	return count;
+}
+
 static inline void riscv_iommu_hpm_writel(struct riscv_iommu_hpm *hpm, u32=
 reg,
 					  u32 val)
 {
@@ -558,6 +647,43 @@ static const struct attribute_group *riscv_iommu_hpm_a=
ttr_grps[] =3D {
 	NULL
 };
=20
+#define IOMMU_IOATC_EVENT_ATTR(_name, _id) \
+	PMU_EVENT_ATTR_ID(ioatc_##_name, riscv_iommu_hpm_event_show, _id)
+
+static struct attribute *riscv_iommu_ioatc_events[] =3D {
+	IOMMU_IOATC_EVENT_ATTR(untranslated_requests, 1),
+	IOMMU_IOATC_EVENT_ATTR(translated_requests, 2),
+	IOMMU_IOATC_EVENT_ATTR(tlb_miss, 4),
+	IOMMU_IOATC_EVENT_ATTR(translation_requests, 21),
+	IOMMU_IOATC_EVENT_ATTR(translations_issued, 24),
+	IOMMU_IOATC_EVENT_ATTR(transactions_unissued_slot_drain, 25),
+	IOMMU_IOATC_EVENT_ATTR(transactions_unissued_token_drain, 26),
+	IOMMU_IOATC_EVENT_ATTR(write_transactions_unissued_wb_full, 27),
+	IOMMU_IOATC_EVENT_ATTR(write_transactions_using_wb, 28),
+	IOMMU_IOATC_EVENT_ATTR(write_transactions_not_using_wb, 29),
+	IOMMU_IOATC_EVENT_ATTR(makeinvalid_downgrades, 30),
+	IOMMU_IOATC_EVENT_ATTR(stash_fails, 31),
+	IOMMU_IOATC_EVENT_ATTR(mtlb_lookups, 56),
+	IOMMU_IOATC_EVENT_ATTR(mtlb_misses, 57),
+	IOMMU_IOATC_EVENT_ATTR(utlb_lookups, 58),
+	IOMMU_IOATC_EVENT_ATTR(utlb_misses, 59),
+	IOMMU_IOATC_EVENT_ATTR(mtlb_reads, 65),
+	IOMMU_IOATC_EVENT_ATTR(mtlb_errors, 108),
+	NULL
+};
+
+static const struct attribute_group riscv_iommu_ioatc_events_group =3D {
+	.name =3D "events",
+	.attrs =3D riscv_iommu_ioatc_events,
+};
+
+static const struct attribute_group *riscv_iommu_ioatc_attr_grps[] =3D {
+	&riscv_iommu_hpm_cpumask_group,
+	&riscv_iommu_ioatc_events_group,
+	&riscv_iommu_hpm_format_group,
+	NULL
+};
+
 static irqreturn_t riscv_iommu_hpm_handle_irq(int irq_num, void *data)
 {
 	struct riscv_iommu_hpm *iommu_hpm =3D data;
@@ -748,6 +874,18 @@ static void riscv_iommu_hpm_set_standard_events(struct=
 riscv_iommu_hpm *iommu_hp
 	set_bit(RISCV_IOMMU_HPMEVENT_G_WALKS, iommu_hpm->supported_events);
 }
=20
+static void riscv_iommu_hpm_set_ioatc_events(struct riscv_iommu_hpm *iommu=
_hpm)
+{
+	static const unsigned int ioatc_event_ids[] =3D {
+		1, 2, 4, 21, 24, 25, 26, 27, 28, 29, 30, 31,
+		56, 57, 58, 59, 65, 108,
+	};
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(ioatc_event_ids); i++)
+		set_bit(ioatc_event_ids[i], iommu_hpm->supported_events);
+}
+
 static void riscv_iommu_hpm_remove(void *data)
 {
 	struct riscv_iommu_hpm *iommu_hpm =3D data;
@@ -758,7 +896,7 @@ static void riscv_iommu_hpm_remove(void *data)
 static int riscv_iommu_hpm_register_unit(struct riscv_iommu_device *iommu,
 					 struct riscv_iommu_hpm *iommu_hpm,
 					 u32 offset, int irq,
-					 bool global_filter,
+					 bool global_filter, bool ioatc,
 					 const struct attribute_group **attr_groups,
 					 const char *prefix, int index)
 {
@@ -797,7 +935,10 @@ static int riscv_iommu_hpm_register_unit(struct riscv_=
iommu_device *iommu,
 	iommu_hpm->on_cpu =3D raw_smp_processor_id();
 	iommu_hpm->irq =3D irq;
=20
-	riscv_iommu_hpm_set_standard_events(iommu_hpm);
+	if (ioatc)
+		riscv_iommu_hpm_set_ioatc_events(iommu_hpm);
+	else
+		riscv_iommu_hpm_set_standard_events(iommu_hpm);
 	riscv_iommu_hpm_reset(iommu_hpm);
=20
 	if (index >=3D 0)
@@ -902,8 +1043,9 @@ static void riscv_iommu_hpm_exit(void)
 int riscv_iommu_add_hpm(struct riscv_iommu_device *iommu)
 {
 	struct device *dev =3D iommu->dev;
+	struct riscv_iommu_ioatc_desc ioatcs[MAX_RISCV_IOMMU_IOATC];
 	struct attribute **vendor_attrs =3D NULL;
-	int num_vendor_events;
+	int ioatc_count, num_vendor_events;
 	int irq;
 	int rc, i;
=20
@@ -924,7 +1066,7 @@ int riscv_iommu_add_hpm(struct riscv_iommu_device *iom=
mu)
 		return rc;
=20
 	rc =3D riscv_iommu_hpm_register_unit(iommu, &iommu->hpm,
-					   0, irq, true,
+					   0, irq, true, false,
 					   riscv_iommu_hpm_attr_grps,
 					   "riscv_iommu_hpm", -1);
 	if (rc < 0)
@@ -944,6 +1086,29 @@ int riscv_iommu_add_hpm(struct riscv_iommu_device *io=
mmu)
 		}
 	}
=20
+	ioatc_count =3D riscv_iommu_hpm_collect_ioatcs(iommu, ioatcs,
+						     ARRAY_SIZE(ioatcs));
+	for (i =3D 0; i < ioatc_count; i++) {
+		struct riscv_iommu_hpm *extra;
+
+		extra =3D devm_kzalloc(dev, sizeof(*extra), GFP_KERNEL);
+		if (!extra)
+			continue;
+
+		rc =3D riscv_iommu_hpm_register_unit(iommu, extra,
+						   ioatcs[i].offset,
+						   ioatcs[i].irq,
+						   true, true,
+						   riscv_iommu_ioatc_attr_grps,
+						   "riscv_iommu_ioatc",
+						   ioatcs[i].index);
+		if (rc) {
+			dev_warn(dev,
+				 "HPM: Failed to register IOATC%u PMU: %d\n",
+				 ioatcs[i].index, rc);
+		}
+	}
+
 	return 0;
=20
 err_module:
diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iom=
mu-platform.c
index 684bc267ac30..ca8de9ec5266 100644
--- a/drivers/iommu/riscv/iommu-platform.c
+++ b/drivers/iommu/riscv/iommu-platform.c
@@ -75,8 +75,8 @@ static int riscv_iommu_platform_probe(struct platform_dev=
ice *pdev)
 	if (iommu->irqs_count <=3D 0)
 		return dev_err_probe(dev, -ENODEV,
 				     "no IRQ resources provided\n");
-	if (iommu->irqs_count > RISCV_IOMMU_INTR_COUNT)
-		iommu->irqs_count =3D RISCV_IOMMU_INTR_COUNT;
+	if (iommu->irqs_count > RISCV_IOMMU_INTR_COUNT + MAX_RISCV_IOMMU_IOATC)
+		iommu->irqs_count =3D RISCV_IOMMU_INTR_COUNT + MAX_RISCV_IOMMU_IOATC;
=20
 	igs =3D FIELD_GET(RISCV_IOMMU_CAPABILITIES_IGS, iommu->caps);
 	switch (igs) {
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 5ebf4e85962e..b1905e54bd0b 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -75,7 +75,7 @@ struct riscv_iommu_device {
 	u32 fctl;
=20
 	/* available interrupt numbers, MSI or WSI */
-	unsigned int irqs[RISCV_IOMMU_INTR_COUNT];
+	unsigned int irqs[RISCV_IOMMU_INTR_COUNT + MAX_RISCV_IOMMU_IOATC];
 	unsigned int irqs_count;
 	unsigned int icvec;
=20
--=20
2.43.0

This message and any attachment are confidential and may be privileged or o=
therwise protected from disclosure. If you are not an intended recipient of=
 this message, please delete it and any attachment from your system and not=
ify the sender immediately by reply e-mail. Unintended recipients should no=
t use, copy, disclose or take any action based on this message or any infor=
mation contained in this message. Emails cannot be guaranteed to be secure =
or error free as they can be intercepted, amended, lost or destroyed, and y=
ou should take full responsibility for security checking.=20
=20
=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E4=BB=BB=E4=BD=95=E9=99=84=E4=
=BB=B6=E5=85=B7=E6=9C=89=E4=BF=9D=E5=AF=86=E6=80=A7=E8=B4=A8=EF=BC=8C=E5=B9=
=B6=E5=8F=AF=E8=83=BD=E5=8F=97=E5=85=B6=E4=BB=96=E4=BF=9D=E6=8A=A4=E6=88=96=
=E4=B8=8D=E5=85=81=E8=AE=B8=E8=A2=AB=E6=8A=AB=E9=9C=B2=E7=BB=99=E7=AC=AC=E4=
=B8=89=E6=96=B9=E3=80=82=E5=A6=82=E9=98=81=E4=B8=8B=E8=AF=AF=E6=94=B6=E5=88=
=B0=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E6=95=AC=E8=AF=B7=E7=AB=8B=E5=8D=B3=
=E4=BB=A5=E5=9B=9E=E5=A4=8D=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E7=9A=84=E6=
=96=B9=E5=BC=8F=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=8C=E5=B9=
=B6=E5=B0=86=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E4=BB=BB=E4=BD=95=
=E9=99=84=E4=BB=B6=E4=BB=8E=E9=98=81=E4=B8=8B=E7=B3=BB=E7=BB=9F=E4=B8=AD=E4=
=BA=88=E4=BB=A5=E5=88=A0=E9=99=A4=E3=80=82=E5=A6=82=E9=98=81=E4=B8=8B=E5=B9=
=B6=E9=9D=9E=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=86=99=E6=98=8E=E4=B9=8B=E6=94=B6=
=E4=BB=B6=E4=BA=BA=EF=BC=8C=E6=95=AC=E8=AF=B7=E5=88=87=E5=8B=BF=E4=BD=BF=E7=
=94=A8=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81=E6=8A=AB=E9=9C=B2=E6=9C=AC=E9=82=
=AE=E4=BB=B6=E6=88=96=E5=85=B6=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=EF=BC=8C=
=E4=BA=A6=E8=AF=B7=E5=88=87=E5=8B=BF=E4=BE=9D=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=
=88=96=E5=85=B6=E4=BB=BB=E4=BD=95=E5=86=85=E5=AE=B9=E8=80=8C=E9=87=87=E5=8F=
=96=E4=BB=BB=E4=BD=95=E8=A1=8C=E5=8A=A8=E3=80=82=E7=94=B5=E5=AD=90=E9=82=AE=
=E4=BB=B6=E6=97=A0=E6=B3=95=E4=BF=9D=E8=AF=81=E6=98=AF=E4=B8=80=E7=A7=8D=E5=
=AE=89=E5=85=A8=E5=92=8C=E4=B8=8D=E4=BC=9A=E5=87=BA=E7=8E=B0=E4=BB=BB=E4=BD=
=95=E5=B7=AE=E9=94=99=E7=9A=84=E9=80=9A=E4=BF=A1=E6=96=B9=E5=BC=8F=EF=BC=8C=
=E5=8F=AF=E8=83=BD=E4=BC=9A=E8=A2=AB=E6=8B=A6=E6=88=AA=E3=80=81=E4=BF=AE=E6=
=94=B9=E3=80=81=E4=B8=A2=E5=A4=B1=E6=88=96=E6=8D=9F=E5=9D=8F=EF=BC=8C=E6=94=
=B6=E4=BB=B6=E4=BA=BA=E9=9C=80=E8=87=AA=E8=A1=8C=E8=B4=9F=E8=B4=A3=E5=81=9A=
=E5=A5=BD=E5=AE=89=E5=85=A8=E6=A3=80=E6=9F=A5=E3=80=82
