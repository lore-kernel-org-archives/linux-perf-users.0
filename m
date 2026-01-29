Received: from sg-1-23.ptr.blmpb.com (sg-1-23.ptr.blmpb.com [118.26.132.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE4D37757E
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Jan 2026 06:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769666976; cv=none; b=QAd8PuuV7vlFEvD8Z5szB5OlasHlRSop7o/VgQpJ7MMU1iDOnEZ4bR8gRWvWg0RUJoNivUrJQ6hUxVMn3ivrIIG1RtH2pR26VIau2knIUjAUliKmRdujkx6V8SHRKODundcamzrZA59NwcSdCQ652nYmoKX90mOiBiY/yX6PsWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769666976; c=relaxed/simple;
	bh=ame34v3QDEJt6sNYp0N81IgJpUEhk4J+e/D0tCMi9aE=;
	h=From:In-Reply-To:To:Cc:Subject:Date:References:Content-Type:
	 Message-Id:Mime-Version; b=O9AvCz8Lv4dMjafzn9XGVoiRTlY7cyunwSEwviraQ3JozEI0yLDB7AKtNlExAIYl4Igq3k2Qk3XSeH4AWScasaKDWzBU88kff/MqF2TkzuMYY24XzTjJoHC76VGvgP5Ky1mDSiPbzMouHkz4CNuKNzUkJAqWDpjqUXSUBS0M4qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com; spf=pass smtp.mailfrom=spacemit.com; dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b=mo0ZdkzH; arc=none smtp.client-ip=118.26.132.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b="mo0ZdkzH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303021642; d=spacemit.com; t=1769666968; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=fN+qdnRevCPtyecCCM4q5UaZqzoByBHEskLdtxlK7PY=;
 b=mo0ZdkzHWfs/WPWqXo3TeWtPoygMF5OHFR5jGyFqg+CE2IBRJZ2ogwE9yG4Vb2qpsdnX0V
 +0zzgqX/xYDDUTVWOHJQer5RpXs2iG/fKq/e3IX82rBI7wVZK3rh31gMwC+HPktrYvlMyT
 Pl9KPnLhALv6wbYxbDaCKbhci+1ajhgWEMHlvbwe/iqrJLbpTdXl+XPIqNx1oDkV+ZvY5o
 095dNaDP/dUOt5LRjPpDuBArwhazLUdwvTXavfPNaDFPh6ZZ5ZoGs+tFXwcSIK7Sojq6Z0
 ETjfq7Rs8HW7DGEZ6Foz6T6canVlo2Md+e+U5dOhhv+8jNuI4kqkL7HNn5Ar9g==
From: "Lv Zheng" <lv.zheng@spacemit.com>
In-Reply-To: <cover.1769666438.git.lv.zheng@spacemit.com>
To: "Tomasz Jeznach" <tjeznach@rivosinc.com>, 
	"Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>, 
	"Robin Murphy" <robin.murphy@arm.com>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, "Paul Walmsley" <pjw@kernel.org>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>
Cc: "Jingyu Li" <joey.li@spacemit.com>, "Lv Zheng" <lv.zheng@spacemit.com>, 
	"Zhijian Chen" <zhijian@spacemit.com>, <iommu@lists.linux.dev>, 
	<linux-perf-users@vger.kernel.org>, <linux-riscv@lists.infradead.org>, 
	<spacemit@lists.linux.dev>, <devicetree@vger.kernel.org>
Subject: [PATCH v1.1 5/7] spacemit/t100: Add vendor event support for RISC-V IOMMU HPM
X-Original-From: Lv Zheng <lv.zheng@spacemit.com>
Date: Thu, 29 Jan 2026 14:09:21 +0800
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1769666438.git.lv.zheng@spacemit.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Message-Id: <c6451de644e47fe37200aa7b945b5b2c29c863e4.1769666438.git.lv.zheng@spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from SurfaceBook2-B.localdomain ([122.224.183.70]) by smtp.feishu.cn with ESMTPS; Thu, 29 Jan 2026 14:09:24 +0800
X-Lms-Return-Path: <lba+2697af996+677ef7+vger.kernel.org+lv.zheng@spacemit.com>

Adds mechanism to allow vendor events to be registered via device tree.
This is useful to support SpacemiT T100 IOMMU where the maximum 128 event
IDs should be supported by T100 IOATS.

Signed-off-by: Lv Zheng <lv.zheng@spacemit.com>
Signed-off-by: Jingyu Li <joey.li@spacemit.com>
---
 drivers/iommu/riscv/iommu-bits.h |  2 +-
 drivers/iommu/riscv/iommu-hpm.c  | 94 +++++++++++++++++++++++++++++++-
 2 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-b=
its.h
index cc6bea064d8f..f1fbf3cc6ba5 100644
--- a/drivers/iommu/riscv/iommu-bits.h
+++ b/drivers/iommu/riscv/iommu-bits.h
@@ -251,7 +251,7 @@ enum riscv_iommu_hpmevent_id {
 	RISCV_IOMMU_HPMEVENT_PD_WALK    =3D 6,
 	RISCV_IOMMU_HPMEVENT_S_VS_WALKS =3D 7,
 	RISCV_IOMMU_HPMEVENT_G_WALKS    =3D 8,
-	RISCV_IOMMU_HPMEVENT_MAX        =3D 9
+	RISCV_IOMMU_HPMEVENT_MAX        =3D 128
 };
=20
 #define RISCV_IOMMU_HPMEVENT_CYCLES	RISCV_IOMMU_HPMEVENT_INVALID
diff --git a/drivers/iommu/riscv/iommu-hpm.c b/drivers/iommu/riscv/iommu-hp=
m.c
index 67827b4c1d26..b01d72dd056f 100644
--- a/drivers/iommu/riscv/iommu-hpm.c
+++ b/drivers/iommu/riscv/iommu-hpm.c
@@ -584,6 +584,81 @@ static void riscv_iommu_hpm_reset(struct riscv_iommu_h=
pm *iommu_hpm)
 	riscv_iommu_hpm_interrupt_clear(iommu_hpm);
 }
=20
+static int riscv_iommu_hpm_init_vendor_events(struct riscv_iommu_hpm *iomm=
u_hpm,
+					      struct attribute ***vendor_attrs)
+{
+	struct device *dev =3D iommu_hpm->iommu->dev;
+	struct device_node *np =3D dev->of_node;
+	struct perf_pmu_events_attr *vendor_event_attrs;
+	struct attribute **attrs;
+	const char *event_str;
+	int num_events, i, j;
+	char *event_copy, *colon, *event_name;
+	u32 event_id;
+
+	*vendor_attrs =3D NULL;
+
+	if (!np)
+		return 0;
+
+	num_events =3D of_property_count_strings(np, "vendor-hpm-events");
+	if (num_events <=3D 0)
+		return 0;
+
+	attrs =3D devm_kcalloc(dev, num_events + 1, sizeof(*attrs), GFP_KERNEL);
+	if (!attrs)
+		return -ENOMEM;
+	vendor_event_attrs =3D devm_kcalloc(dev, num_events,
+					  sizeof(*vendor_event_attrs),
+					  GFP_KERNEL);
+	if (!vendor_event_attrs)
+		return -ENOMEM;
+
+	/*
+	 * Parse vendor events from device tree.
+	 * Format: "event-name:0xNN" where NN is hex event ID
+	 */
+	j =3D 0;
+	for (i =3D 0; i < num_events; i++) {
+		if (of_property_read_string_index(np, "vendor,hpm-events",
+						  i, &event_str))
+			continue;
+
+		event_copy =3D devm_kstrdup(dev, event_str, GFP_KERNEL);
+		if (!event_copy) {
+			dev_warn(dev, "HPM: Failed to copy string for vendor event '%s'\n",
+				 event_str);
+			continue;
+		}
+		colon =3D strchr(event_copy, ':');
+		if (colon) {
+			*colon =3D '\0';
+			event_name =3D colon + 1;
+		} else
+			event_name =3D event_copy;
+		if (kstrtou32(event_copy, 0, &event_id))
+			continue;
+		if (event_id >=3D RISCV_IOMMU_HPMEVENT_MAX)
+			continue;
+
+		sysfs_attr_init(&vendor_event_attrs[j].attr.attr);
+		vendor_event_attrs[j].attr.attr.name =3D event_name;
+		vendor_event_attrs[j].attr.attr.mode =3D 0444;
+		vendor_event_attrs[j].attr.show =3D riscv_iommu_hpm_event_show;
+		vendor_event_attrs[j].id =3D event_id;
+		attrs[j] =3D &vendor_event_attrs[j].attr.attr;
+		set_bit(event_id, iommu_hpm->supported_events);
+		dev_info(dev, "HPM: Registered vendor event '%s' (0x%x)\n",
+			 event_name, event_id);
+		j++;
+	}
+
+	attrs[j] =3D NULL;
+	*vendor_attrs =3D attrs;
+
+	return j;
+}
+
 static void riscv_iommu_hpm_set_standard_events(struct riscv_iommu_hpm *io=
mmu_hpm)
 {
 	/* Cycles counter is always supported */
@@ -749,8 +824,10 @@ static void riscv_iommu_hpm_exit(void)
 int riscv_iommu_add_hpm(struct riscv_iommu_device *iommu)
 {
 	struct device *dev =3D iommu->dev;
+	struct attribute **vendor_attrs =3D NULL;
+	int num_vendor_events;
 	int irq;
-	int rc;
+	int rc, i;
=20
 	if (!FIELD_GET(RISCV_IOMMU_CAPABILITIES_HPM, iommu->caps)) {
 		dev_dbg(dev, "HPM: Not supported\n");
@@ -773,6 +850,21 @@ int riscv_iommu_add_hpm(struct riscv_iommu_device *iom=
mu)
 					   "riscv_iommu_hpm", -1);
 	if (rc < 0)
 		goto err_module;
+
+	num_vendor_events =3D riscv_iommu_hpm_init_vendor_events(&iommu->hpm,
+							       &vendor_attrs);
+	if (num_vendor_events > 0 && vendor_attrs) {
+		for (i =3D 0; i < num_vendor_events && vendor_attrs[i]; i++) {
+			rc =3D sysfs_add_file_to_group(&iommu->hpm.pmu.dev->kobj,
+						     vendor_attrs[i],
+						     "events");
+			if (rc)
+				dev_warn(dev,
+					 "HPM: Failed to create sysfs for vendor event '%s'\n",
+					 vendor_attrs[i]->name);
+		}
+	}
+
 	return 0;
=20
 err_module:
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
