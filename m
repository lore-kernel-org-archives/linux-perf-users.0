Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FE543B4BF
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 09:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513714; cv=none; b=eAHxTJlt87IwGSKe2L3y5OieLsJ+Wd8q8hNCxN3drnTMikcVG8rIYVUKYEvn4s4p5v3E77LWUotqZvYoxJBTM59Jk4YGle6idPjYjBLIinHwhN89GdweKTcv4NP5J3U3JCDrE/CVkSkm8rU9SaJOOHbS2BtvI6ie1JpH61ep8WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513714; c=relaxed/simple;
	bh=0OuilxAE+ThUNxpU1Gxpqy4nbLhkHMBngSRff/ONKc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsxW+xGAx+3eP3Baty/TXV/7NieYe0mkqmKbRyq0pX8MPb1zl6jQLDzeWDC5Z6NysE4dzOhClponhGQG/KZewBfpzkf+uyKzBt0IQ6IXFcqsf86HpOUhoxsioQsbSv6kGbTgXfegW697RQTKiQZOF3YkA7OBAzKxfstS2B7V3Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=S1I1gIcc; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="S1I1gIcc"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7ee37dc91f5so468737a34.3
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Sep 2026 02:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1788513704; x=1789118504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0jwxUNr7N+2l26FeCwq48z6QyCIJefuKV/bUVltiLUA=;
        b=S1I1gIccTBSuBhDto0sZBMTlYMa5po5GCVEPZ/maqXPNT4H/w9s+XdiWzRvLzchSXi
         ypjPhL1qEznbdMMJkVpJ5pVcGbeEGCcuCRa0XB2DAZ4V+JdwPDkn0SJ/Dd6AlaOf1q9k
         11jlVzOF1AbeRTnKwezjsnfMZ7s6nIDieIG7CGHvM+UiRFbbj8JtOFXX1UrtoEIypGrK
         j7Ij9dzg4YgrWGIgv4S65qDeS/H5rfpUNMq7X+ebXf8dw2+wkAeGMHOp6SIhbCT01hJz
         fXLqPzcTpOI661VKU6RB4aXnBoXS9XThW1K5mTgbTzwU3PVGtldiSwmSpDJOdiD0/mSl
         Ie4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788513704; x=1789118504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0jwxUNr7N+2l26FeCwq48z6QyCIJefuKV/bUVltiLUA=;
        b=ZTOxfX3IW1xjF45yz/tkbPPwDyCMvbA4WGNFkECs1l+QrF2+V229umGZ75ourLWrty
         hZ34aFXy+3qUKOXMqQ/gHlt5JBUtIrKLbN4rdIsVwaulUjEsZbenwF01w1G+vgyaPMwL
         O6o0Dafe8jtwWJE2SAF/VXOqKNasue6Vhtd/lWcyeQt770BOQvpWk84IKCSCUbJb0bCk
         iFmNyCfGl/AQg7qbD7IiZFYWm/UkTXD4h3ur0QPj0nVITxK4lyXsnC3UG+TlMieXq5D2
         XpC/4K9U1ZAdHFNef503J7iTht1csvM+Hh0t7Zz+wvnfUlJET7E97GIyfwRUTcaRjRi+
         K3gA==
X-Forwarded-Encrypted: i=1; AKwUvBxKiKhAkAKsJ1oXQbMI7sYk+0Ccift++m4qXMsYa6Z1M0EUWmm28UuQ9DaFrj5XsMYC7RvRxiua1kPXEPjWD56G@vger.kernel.org
X-Gm-Message-State: AFuF++n5BbTrGoXCXoI5f869GAHaw3CXz0P+jFThT6HXuOaJV6Q8NrdZ
	tD645pT6LTnIzcIyIbshJie8FBsners3DNZbpJ8SvZOK7b6DzD0pkhxQkfEjQKMoqJI=
X-Gm-Gg: AYBFou0p3FErHuWyqgrL9UCIdFVuvgQ+1kNFFrnGVXtWMvndyynn7040yGDnSUUgUCF
	OQ/Yb4XIAv0l9x8ktvo4GUB5n602mZp4tdq0tmU1L/O4aoTIPFMXQFilKRaS6JlUcDxKjrxaQTu
	nU6SnLFE/HTwPLJyiht/x4h+Pu+UpVlu62a4+XsCBzD8/J9/QdR7Pn6dH1EE5OKNTNrv6uVYmXj
	9hOlhcIXkTA6Bkq8o1OMOgBVnZGtvwBjFsuu6cYkY9bYG5Ryg3AmPB/QqMIU+9GdlU6ZVrBEuQq
	vI2DeQuakR5AWtuy/vDnn6/O2paVq8HeIeO/pW2KRW3Hj06tZF6rJa2bFnKsM7DilKIBy0K5EKU
	JLrgus+cYIWEjv3u4Evv6qAjRS9FQM3DuE8cQygNY4KkXOixNrxfOiMMh4deocDk7Ws9qIGIqko
	QhcUthbwTMI57dLHio8LRJVSZ4qf2S9/VPmgDMeJbSnxRhAekXgnL6nOG8quqX7xmwhqXl68hq
X-Received: by 2002:a05:6820:1c91:b0:6b1:2843:1312 with SMTP id 006d021491bc7-6b6f788e384mr2940609eaf.0.1788513704577;
        Fri, 04 Sep 2026 02:21:44 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432438497csm5275575c88.8.2026.09.04.02.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:21:42 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	mark.rutland@arm.com,
	andrew.jones@oss.qualcomm.com,
	guoren@kernel.org,
	david.laight.linux@gmail.com,
	zhangzhanpeng.jasper@bytedance.com,
	yang.yicong@picoheart.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v8 2/2] iommu/riscv: create a auxiliary device for HPM
Date: Fri,  4 Sep 2026 02:21:33 -0700
Message-ID: <20260904092136.113321-3-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260904092136.113321-1-zong.li@sifive.com>
References: <20260904092136.113321-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create an auxiliary device for HPM when the IOMMU supports a
hardware performance monitor.

Tested-by: Chen Pei <cp0613@linux.alibaba.com>
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Yicong Yang <yang.yicong@picoheart.com>
Suggested-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/Kconfig |  1 +
 drivers/iommu/riscv/iommu.c | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
index b86e5ab94183..8025bf0fb67f 100644
--- a/drivers/iommu/riscv/Kconfig
+++ b/drivers/iommu/riscv/Kconfig
@@ -10,6 +10,7 @@ config RISCV_IOMMU
 	select GENERIC_PT
 	select IOMMU_PT
 	select IOMMU_PT_RISCV64
+	select AUXILIARY_BUS
 	help
 	  Support for implementations of the RISC-V IOMMU architecture that
 	  complements the RISC-V MMU capabilities, providing similar address
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index cec3ddd7ab10..7f619971bb70 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -14,6 +14,7 @@
 
 #include <linux/acpi.h>
 #include <linux/acpi_rimt.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/compiler.h>
 #include <linux/crash_dump.h>
 #include <linux/init.h>
@@ -48,6 +49,9 @@
 static DEFINE_IDA(riscv_iommu_pscids);
 #define RISCV_IOMMU_MAX_PSCID		(BIT(20) - 1)
 
+/* IOMMU PMU auxiliary device id allocation namespace. */
+static DEFINE_IDA(riscv_iommu_pmu_ida);
+
 /* Device resource-managed allocations */
 struct riscv_iommu_devres {
 	void *addr;
@@ -565,6 +569,36 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/*
+ * IOMMU Hardware performance monitor
+ */
+static void riscv_iommu_pmu_id_free(void *data)
+{
+	ida_free(&riscv_iommu_pmu_ida, (unsigned long)data);
+}
+
+static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
+{
+	struct auxiliary_device *auxdev;
+	int id, ret;
+
+	id = ida_alloc(&riscv_iommu_pmu_ida, GFP_KERNEL);
+	if (id < 0)
+		return id;
+
+	ret = devm_add_action_or_reset(iommu->dev, riscv_iommu_pmu_id_free,
+				       (void *)(unsigned long)id);
+	if (ret)
+		return ret;
+
+	auxdev = __devm_auxiliary_device_create(iommu->dev, "riscv-iommu",
+						"pmu", iommu, id);
+	if (!auxdev)
+		return -ENODEV;
+
+	return 0;
+}
+
 /* Lookup and initialize device context info structure. */
 static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
 						 unsigned int devid)
@@ -1613,6 +1647,9 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto err_remove_sysfs;
 	}
 
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
+		riscv_iommu_hpm_enable(iommu);
+
 	return 0;
 
 err_remove_sysfs:
-- 
2.43.7

