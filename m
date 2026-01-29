Received: from sg-1-18.ptr.blmpb.com (sg-1-18.ptr.blmpb.com [118.26.132.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C62B37757E
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Jan 2026 06:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769666982; cv=none; b=Fh3l/Qi3EFBnANJQsnFAQazubm9cvbO+YyetQ18D5kd2ZGOLyTSKOlQ7ysi8MS6nNF8+auulEjeHTkhzbwi040sz1tBWKRT788Uh7Jujeal/JdjI87B2TvZCdx1WQnr4Jzfsh5utrzjT7Cku3dll9IaAh6iq7Sz4IZ/Qorf6+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769666982; c=relaxed/simple;
	bh=MxampTpM2PIEfl8aic41WXAWJp4Fj8FaFgYEG5yvIis=;
	h=To:Cc:Subject:Mime-Version:In-Reply-To:From:Message-Id:Date:
	 References:Content-Type; b=DS6x9rJbJjEc8hTGIw9SJJZcHTQwqW5rMCXvgB2KShe70AkBNcXwIvFLWkCDTqqUJsnRHihi7zSALPa+OdnSaiI5xkbYQayzUf8sd2KroetR1mIx2IFi/Xpgd5kkEsq/0wF1tBFURdblCYSHuxG2RzX8DUrpIvKMYjmq8ADOVaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com; spf=pass smtp.mailfrom=spacemit.com; dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b=iHx0ANFe; arc=none smtp.client-ip=118.26.132.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b="iHx0ANFe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303021642; d=spacemit.com; t=1769666975; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=cYwJ5QHGXb4rv8mSVvEKEO95SjJi0rkrbs1wIAwcnvQ=;
 b=iHx0ANFeWweBxxiI+lQDBvD+kqSYwjNiGehZ2cQYAUrhUlOTiKjRnoPSgfqCu5p888Wjye
 IbrwJiBwW/TyWU4MAfKyghq4ls0i9YrOYTgA+PrnEFNuF/SnPi19y92wKY4DN45K2pJNl9
 PW1z4ANodebRDTPq+dkcKUJGRjhINIZjmDjLxBnaTUqi3N228SYHl0JAwI8iDOefN+i5WU
 fJMS/wvqUqV9TNpsJyvoiFlSdtbs7dm0yHDa03figxYjP+IjVjX3pfU8cGL0h23gtbpjgD
 YbsjS1M2wXoihj6LnvxqaFkpJ+2o7VM1fsqpkRyaoiULqKxMEzNuW7eQw/yyvA==
To: "Tomasz Jeznach" <tjeznach@rivosinc.com>, 
	"Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>, 
	"Robin Murphy" <robin.murphy@arm.com>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, "Paul Walmsley" <pjw@kernel.org>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>
X-Lms-Return-Path: <lba+2697af99d+201c9b+vger.kernel.org+lv.zheng@spacemit.com>
Cc: "Jingyu Li" <joey.li@spacemit.com>, "Lv Zheng" <lv.zheng@spacemit.com>, 
	"Zhijian Chen" <zhijian@spacemit.com>, <iommu@lists.linux.dev>, 
	<linux-perf-users@vger.kernel.org>, <linux-riscv@lists.infradead.org>, 
	<spacemit@lists.linux.dev>, <devicetree@vger.kernel.org>
Subject: [PATCH v1.1 6/7] spacemit/t100: Add global filter support for RISC-V IOMMU HPM
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <cover.1769666438.git.lv.zheng@spacemit.com>
From: "Lv Zheng" <lv.zheng@spacemit.com>
Message-Id: <5e4244a43486394349c23bcde9f3a0364a42cff6.1769666438.git.lv.zheng@spacemit.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Jan 2026 14:09:29 +0800
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1769666438.git.lv.zheng@spacemit.com>
X-Original-From: Lv Zheng <lv.zheng@spacemit.com>
Received: from SurfaceBook2-B.localdomain ([122.224.183.70]) by smtp.feishu.cn with ESMTPS; Thu, 29 Jan 2026 14:09:32 +0800
Content-Type: text/plain; charset=UTF-8

Introduces global filter support for RISC-V IOMMU HPM. The global filter
can be seen in SpacemiT T100 which only supports single filter to be
applied to all event counters. This silicon design can save the number of
the event bus signals.

Signed-off-by: Lv Zheng <lv.zheng@spacemit.com>
Signed-off-by: Jingyu Li <joey.li@spacemit.com>
---
 drivers/iommu/riscv/iommu-hpm.c | 93 ++++++++++++++++++++++++++++++---
 drivers/iommu/riscv/iommu.h     |  1 +
 2 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-hpm.c b/drivers/iommu/riscv/iommu-hp=
m.c
index b01d72dd056f..23e1afc262ea 100644
--- a/drivers/iommu/riscv/iommu-hpm.c
+++ b/drivers/iommu/riscv/iommu-hpm.c
@@ -134,6 +134,49 @@ static inline void riscv_iommu_hpm_interrupt_clear(str=
uct riscv_iommu_hpm *hpm)
 	riscv_iommu_hpm_writel(hpm, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPSR_PMIP);
 }
=20
+static bool riscv_iommu_hpm_check_global_filter(struct perf_event *curr,
+						struct perf_event *new)
+{
+	u32 curr_pid_pscid, curr_did_gscid, curr_pv_pscv;
+	u32 curr_dv_gscv, curr_idt, curr_dmask;
+	u32 new_pid_pscid, new_did_gscid, new_pv_pscv;
+	u32 new_dv_gscv, new_idt, new_dmask;
+
+	curr_pid_pscid =3D get_filter_pid_pscid(curr);
+	curr_did_gscid =3D get_filter_did_gscid(curr);
+	curr_pv_pscv =3D get_filter_pv_pscv(curr);
+	curr_dv_gscv =3D get_filter_dv_gscv(curr);
+	curr_idt =3D get_filter_idt(curr);
+	curr_dmask =3D get_filter_dmask(curr);
+
+	new_pid_pscid =3D get_filter_pid_pscid(new);
+	new_did_gscid =3D get_filter_did_gscid(new);
+	new_pv_pscv =3D get_filter_pv_pscv(new);
+	new_dv_gscv =3D get_filter_dv_gscv(new);
+	new_idt =3D get_filter_idt(new);
+	new_dmask =3D get_filter_dmask(new);
+
+	return (curr_pid_pscid =3D=3D new_pid_pscid &&
+		curr_did_gscid =3D=3D new_did_gscid &&
+		curr_pv_pscv =3D=3D new_pv_pscv &&
+		curr_dv_gscv =3D=3D new_dv_gscv &&
+		curr_idt =3D=3D new_idt &&
+		curr_dmask =3D=3D new_dmask);
+}
+
+static bool riscv_iommu_hpm_events_compatible(struct perf_event *curr,
+					      struct perf_event *new)
+{
+	if (new->pmu !=3D curr->pmu)
+		return false;
+
+	if (to_iommu_hpm(new->pmu)->global_filter &&
+	    !riscv_iommu_hpm_check_global_filter(curr, new))
+		return false;
+
+	return true;
+}
+
 static void riscv_iommu_hpm_event_update(struct perf_event *event)
 {
 	struct hw_perf_event *hwc =3D &event->hw;
@@ -246,9 +289,10 @@ static void riscv_iommu_hpm_set_event_filter(struct pe=
rf_event *event, int idx,
 			       RISCV_IOMMU_REG_IOHPMEVT(idx), event_cfg);
 }
=20
-static void riscv_iommu_hpm_apply_event_filter(struct riscv_iommu_hpm *iom=
mu_hpm,
-					       struct perf_event *event, int idx)
+static int riscv_iommu_hpm_apply_event_filter(struct riscv_iommu_hpm *iomm=
u_hpm,
+					      struct perf_event *event, int idx)
 {
+	unsigned int cur_idx, num_ctrs =3D iommu_hpm->num_counters;
 	u32 pid_pscid, did_gscid, pv_pscv, dv_gscv, idt, dmask;
=20
 	pid_pscid =3D get_filter_pid_pscid(event);
@@ -258,14 +302,36 @@ static void riscv_iommu_hpm_apply_event_filter(struct=
 riscv_iommu_hpm *iommu_hpm
 	idt =3D get_filter_idt(event);
 	dmask =3D get_filter_dmask(event);
=20
+	if (iommu_hpm->global_filter) {
+		cur_idx =3D find_first_bit(iommu_hpm->used_counters, num_ctrs - 1);
+		if (cur_idx =3D=3D num_ctrs - 1) {
+			/* First event, set the global filter */
+			riscv_iommu_hpm_set_event_filter(event, 0, pid_pscid,
+							 did_gscid,
+							 pv_pscv, dv_gscv, idt, dmask);
+		} else {
+			/* Check if the new event's filter is compatible with
+			 * the global filter
+			 */
+			if (!riscv_iommu_hpm_check_global_filter(iommu_hpm->events[cur_idx + 1]=
,
+								 event)) {
+				dev_dbg(iommu_hpm->pmu.dev,
+					"HPM: Filter incompatible with global filter\n");
+				return -EAGAIN;
+			}
+		}
+		return 0;
+	}
+
 	riscv_iommu_hpm_set_event_filter(event, idx, pid_pscid, did_gscid,
 					 pv_pscv, dv_gscv, idt, dmask);
+	return 0;
 }
=20
 static int riscv_iommu_hpm_get_event_idx(struct riscv_iommu_hpm *iommu_hpm=
,
 					 struct perf_event *event)
 {
-	int idx;
+	int idx, err;
 	unsigned int num_ctrs =3D iommu_hpm->num_counters;
 	u16 event_id =3D get_event(event);
=20
@@ -287,7 +353,10 @@ static int riscv_iommu_hpm_get_event_idx(struct riscv_=
iommu_hpm *iommu_hpm,
 		return -EAGAIN;
 	}
=20
-	riscv_iommu_hpm_apply_event_filter(iommu_hpm, event, idx);
+	err =3D riscv_iommu_hpm_apply_event_filter(iommu_hpm, event, idx);
+	if (err)
+		return err;
+
 	set_bit(idx, iommu_hpm->used_counters);
=20
 	return idx;
@@ -363,6 +432,8 @@ static int riscv_iommu_hpm_event_init(struct perf_event=
 *event)
 	}
=20
 	if (!is_software_event(event->group_leader)) {
+		if (!riscv_iommu_hpm_events_compatible(event->group_leader, event))
+			return -EINVAL;
 		if (++group_num_events > iommu_hpm->num_counters)
 			return -EINVAL;
 	}
@@ -370,6 +441,8 @@ static int riscv_iommu_hpm_event_init(struct perf_event=
 *event)
 	for_each_sibling_event(sibling, event->group_leader) {
 		if (is_software_event(sibling))
 			continue;
+		if (!riscv_iommu_hpm_events_compatible(sibling, event))
+			return -EINVAL;
 		if (++group_num_events > iommu_hpm->num_counters)
 			return -EINVAL;
 	}
@@ -685,6 +758,7 @@ static void riscv_iommu_hpm_remove(void *data)
 static int riscv_iommu_hpm_register_unit(struct riscv_iommu_device *iommu,
 					 struct riscv_iommu_hpm *iommu_hpm,
 					 u32 offset, int irq,
+					 bool global_filter,
 					 const struct attribute_group **attr_groups,
 					 const char *prefix, int index)
 {
@@ -709,6 +783,8 @@ static int riscv_iommu_hpm_register_unit(struct riscv_i=
ommu_device *iommu,
 	iommu_hpm->base =3D base;
 	bitmap_zero(iommu_hpm->used_counters, RISCV_IOMMU_HPMCOUNTER_MAX);
 	bitmap_zero(iommu_hpm->supported_events, RISCV_IOMMU_HPMEVENT_MAX);
+	iommu_hpm->global_filter =3D of_property_read_bool(dev->of_node,
+							 "global-filter");
=20
 	riscv_iommu_hpm_writel(iommu_hpm,
 			       RISCV_IOMMU_REG_IOCOUNTINH, 0xFFFFFFFF);
@@ -775,8 +851,10 @@ static int riscv_iommu_hpm_register_unit(struct riscv_=
iommu_device *iommu,
 	if (err)
 		goto err_cpuhp;
=20
-	dev_info(dev, "HPM: Registered %s (%d counters, IRQ %d)\n",
-		 pmu_name, iommu_hpm->num_counters, iommu_hpm->irq);
+	dev_info(dev, "HPM: Registered %s (%d counters, IRQ %d, %s filter)\n",
+		 pmu_name, iommu_hpm->num_counters,
+		 iommu_hpm->irq,
+		 iommu_hpm->global_filter ? "global" : "per-counter");
 	return 0;
=20
 err_cpuhp:
@@ -845,7 +923,8 @@ int riscv_iommu_add_hpm(struct riscv_iommu_device *iomm=
u)
 	if (rc < 0)
 		return rc;
=20
-	rc =3D riscv_iommu_hpm_register_unit(iommu, &iommu->hpm, 0, irq,
+	rc =3D riscv_iommu_hpm_register_unit(iommu, &iommu->hpm,
+					   0, irq, true,
 					   riscv_iommu_hpm_attr_grps,
 					   "riscv_iommu_hpm", -1);
 	if (rc < 0)
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 0ad9f5cad4de..5ebf4e85962e 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -41,6 +41,7 @@ struct riscv_iommu_hpm {
 	int irq;
 	int on_cpu;
 	struct hlist_node node;
+	bool global_filter;
 	/*
 	 * Layout of events:
 	 * 0       -> HPMCYCLES
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
