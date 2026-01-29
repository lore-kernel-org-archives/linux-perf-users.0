Received: from sg-1-13.ptr.blmpb.com (sg-1-13.ptr.blmpb.com [118.26.132.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C033334A797
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Jan 2026 06:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769666950; cv=none; b=nZ9HkvU0AxzFzr30BHNUXMJAv7F/Je2jXyh12vmQDG3/ljN3fg+o2+cVJHe79nDl2u6+y486Ryd8F++rZRnuem6N3ljW4fT1lgnnUfKaepBqOWpKOEI1ken+yMubVdmLO2hzV7/KaFuUhglYyrORq+y9JmtzcrNy5ZUh4VtGIdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769666950; c=relaxed/simple;
	bh=sd4EJtlckNazdiPhOA1jDZNIC0nQlueyl/fL89wqEdg=;
	h=From:Mime-Version:To:Subject:Cc:In-Reply-To:Date:References:
	 Content-Type:Message-Id; b=kEPY1t4FBnKAGtW1P4txeHSrpSkJWOf2M3bQcX/mr82/7la9eeMVifPlH+/6tmbguttCnU7EBg5tPUkiE25hhtpiQXSBhSpmuigNN/yMTgoGvUQQMysAspM4msCNJHqAwlQH/8MK+6UrjOKd/UZumeGk4+xOnUDWz+cNfrDceeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com; spf=pass smtp.mailfrom=spacemit.com; dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b=fGnu3Yw5; arc=none smtp.client-ip=118.26.132.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacemit.com header.i=@spacemit.com header.b="fGnu3Yw5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2303021642; d=spacemit.com; t=1769666936; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=XKUcVjUQOQj6bDJdeOyr1SbwF7z1fYRZISkh0wI0lj0=;
 b=fGnu3Yw5i1UCIPWinY2YYj85lo3hYPFTbfE/xY0ss1RuMVVs1h0RPe0ZQ3rz+5yfxOfsMw
 wNyiodqVwhlnD22b1q0VdpVyjZ4QzZyofzzBDmldNvMlQKXuV140loRVbA+kZSMbtJGN/H
 YphWfumevBM6F2Ow2AdNdjCxl/C0VlCKztMbXYrDmwLocvzxQDpv6hEHCzFMcci2bZoG1V
 egO5lzyNEDC6NgzQSgs8blsJh2h3Z2eO5yYFC41RwB9fmJcjfQtLy3oDzJ3Zq8UP/vJBU3
 CK2kL7O7kphJQ6EEZhUyAeBxjaoFYgFZOsdMdYgNkEFoMXe4shqkQHMOD19dpg==
From: "Lv Zheng" <lv.zheng@spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0
X-Lms-Return-Path: <lba+2697af976+520e59+vger.kernel.org+lv.zheng@spacemit.com>
To: "Tomasz Jeznach" <tjeznach@rivosinc.com>, 
	"Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>, 
	"Robin Murphy" <robin.murphy@arm.com>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Conor Dooley" <conor+dt@kernel.org>, "Paul Walmsley" <pjw@kernel.org>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>
Subject: [PATCH v1.1 2/7] iommu/riscv: Fix WSI mode IRQ number handling
Received: from SurfaceBook2-B.localdomain ([122.224.183.70]) by smtp.feishu.cn with ESMTPS; Thu, 29 Jan 2026 14:08:53 +0800
X-Original-From: Lv Zheng <lv.zheng@spacemit.com>
Cc: "Jingyu Li" <joey.li@spacemit.com>, "Lv Zheng" <lv.zheng@spacemit.com>, 
	"Zhijian Chen" <zhijian@spacemit.com>, <iommu@lists.linux.dev>, 
	<linux-perf-users@vger.kernel.org>, <linux-riscv@lists.infradead.org>, 
	<spacemit@lists.linux.dev>, <devicetree@vger.kernel.org>
In-Reply-To: <cover.1769666438.git.lv.zheng@spacemit.com>
Date: Thu, 29 Jan 2026 14:08:50 +0800
Content-Transfer-Encoding: quoted-printable
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1769666438.git.lv.zheng@spacemit.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <a618207b8347945218c33a7f0300a28949c28693.1769666438.git.lv.zheng@spacemit.com>

From: Jingyu Li <joey.li@spacemit.com>

In WSI mode, ICVEC doesn't exist, thus reading it returns 0, which
causes IOMMU driver to fail to find IRQ numbers from device tree
IRQ arrary. The issue is fixed by applying icvec indexes of WSI IRQs.

Signed-off-by: Jingyu Li <joey.li@spacemit.com>
Signed-off-by: Lv Zheng <lv.zheng@spacemit.com>
---
 drivers/iommu/riscv/iommu.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index d9429097a2b5..26630979473b 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1593,11 +1593,26 @@ static int riscv_iommu_init_check(struct riscv_iomm=
u_device *iommu)
 		       FIELD_PREP(RISCV_IOMMU_ICVEC_PMIV, 3 % iommu->irqs_count);
 	riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_ICVEC, iommu->icvec);
 	iommu->icvec =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_ICVEC);
-	if (max(max(FIELD_GET(RISCV_IOMMU_ICVEC_CIV, iommu->icvec),
-		    FIELD_GET(RISCV_IOMMU_ICVEC_FIV, iommu->icvec)),
-		max(FIELD_GET(RISCV_IOMMU_ICVEC_PIV, iommu->icvec),
-		    FIELD_GET(RISCV_IOMMU_ICVEC_PMIV, iommu->icvec))) >=3D iommu->irqs_c=
ount)
-		return -EINVAL;
+	/*
+	 * In WSI mode, ICVEC may read as zero. Only validate if using MSI.
+	 * Check if FCTL.WSI is set to determine interrupt mode.
+	 */
+	if (!(iommu->fctl & RISCV_IOMMU_FCTL_WSI)) {
+		if (max(max(FIELD_GET(RISCV_IOMMU_ICVEC_CIV, iommu->icvec),
+			    FIELD_GET(RISCV_IOMMU_ICVEC_FIV, iommu->icvec)),
+			max(FIELD_GET(RISCV_IOMMU_ICVEC_PIV, iommu->icvec),
+			    FIELD_GET(RISCV_IOMMU_ICVEC_PMIV, iommu->icvec))) >=3D iommu->irqs_=
count)
+			return -EINVAL;
+	} else {
+		/*
+		 * WSI mode: ICVEC is not used. Set to identity mapping for
+		 * riscv_iommu_queue_vec() to work correctly.
+		 */
+		iommu->icvec =3D FIELD_PREP(RISCV_IOMMU_ICVEC_CIV, 0) |
+			       FIELD_PREP(RISCV_IOMMU_ICVEC_FIV, 1) |
+			       FIELD_PREP(RISCV_IOMMU_ICVEC_PIV, 2) |
+			       FIELD_PREP(RISCV_IOMMU_ICVEC_PMIV, 3);
+	}
=20
 	return 0;
 }
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
