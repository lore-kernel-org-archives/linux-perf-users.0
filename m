Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3538630EF92
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 02:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787538043; cv=none; b=AGe6j+R5sSZ/APhAUNIZqORjc9fn/vwdzllifd0Nu16n8360fFQ4ZebQmYaIgHd+nYxllcdVL7U1Vz4Y0kf2KxbEFqn2kMysD+XwkBpqRtzB+Gm1azdmAycoUQfIAkbnG9GPPN7HsTYB8jgCHQoeToKf/5RhMt9c628bTwXmy3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787538043; c=relaxed/simple;
	bh=pTsBIp44Zh1FrmMiQvMfehgKLSU0k4F1puuNVXnvO9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwgHMDNnBlU1P9IIazOptCJnscyCaZ8Agd0VKUR2M9sEE/nO5VvJZ9i+V7XVqXZ4GQY2ID+6sUbVAPjZYl+keznH9E9aFc8eShImCrSHdKhqxk8XdQfH5+FkZ8Bg6sTYwZ8FbDFrbUJn0tJMepvPGElRoD75rfzux5ZKnAlfwI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=fdYB9gzR; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fdYB9gzR"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-39266382df6so2281214a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Aug 2026 19:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787538040; x=1788142840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DMnbX9WNAYiy2tqr9slp35Bxhckluu2H+cH7KyGNMlE=;
        b=fdYB9gzRUUWPovVSu1RwJaiy0Yf78432m/HEtDeAU+pLuZhklWeKDL+jgqPoA+CdYS
         Ray2rPH+2jzy5N6bGVkiFIARZRYex5nKKyuIpeovcAVQ9I0iFI/bDlV+VZEtUPi/TqAt
         JAkscszMktGXZsMXpozYeX7v1h62fWQmcxByr2psrhXsxsmQl+BeSQHLIz/4WaJPiaoP
         hW0e1akAgWN3QubpFgliItwn0y4HaCmh2A+8/DXwLO/umsnCNuvkRhhPydqprP6pY2Ci
         v5Bic+IUsv26EdA9Xo14JI+QN9bqsE6Uj2sQmHhfYzRktnfF/GOP/8KwIX9fMRkuSOrS
         BFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787538040; x=1788142840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DMnbX9WNAYiy2tqr9slp35Bxhckluu2H+cH7KyGNMlE=;
        b=X+U+dXq6L0NI/aawWg+/5thOn+z6bjHYBKljRxRkW1kQckr8FruLL0HX0SUQcdjbvf
         zYiAs1b5VDv0GUVloOtnZucJ4vYIb+C5xQ9lLinBhfCwyAabkeeSveLy3QhVdzg+iLtn
         W9cQ8wzQlYN17ZdfaDALxsMjUOKbUNt2mK9MFQjwKkL4PecIT0CBrzVRei626rIF47S+
         LdKdRCtEYUStEOtjwQPFVBIlkX/blkeM78b4c0EmgN8y9jpi4SKnw96aLXQueSX01H00
         X2WEqL898WfNY6ZdQxMff/xBBfxoftawF6hRWf39M+AttsoNjoUmO1UMM+RnHiOPUElj
         2p5Q==
X-Forwarded-Encrypted: i=1; AHgh+RpBTdvs1JXcUPTjFSAx/APOXzC5KLNcg71/su5FBQ21DUvu7mcUDSpsKrcwj8W5PhDk9sUovswMoqveEyqy1MDM@vger.kernel.org
X-Gm-Message-State: AFuF++nAcKL+V6OBb2MVqj57SWbBeEoVt8vx0T9p46lAnccTUQmlxuXa
	4d3HZIWageIFANXNRowbUulFvEac97iqv1i8cLYpGDwKc41nqHNPCnpisK/Gfgh+1zU=
X-Gm-Gg: AR+sD10bkbz3+H2aZ4ihh9v1drBXNNQWchUzgxBTSszysCh0lynRzRcg5HQsnfAXj9r
	O6jCK7T2aUV+Ri1cQnojj2VMkOLeEW1okVxUt6rXa5xfX+mbHn6tT43mxq49q/goMWrD7ebhYIr
	CoSwc/pM+E1J6HxwG9jg/AJvpBX8jmfT6cGRn8xffbRE6bYURBSX97Nlt7d+i1Xx7PYCYOkXVXh
	WrZT0Srr5g9oBmRIofi42esLV8oZLZaZL+M1HaH/LlCMxMgkffE6e70qD+SaIFyqibNxtEBeuCx
	YGoMFIZ5qLaCDKrjS1eL7Ob1A1Mq4Zd2ob3dgexSov28alF4TlD3tZst8f5ixo1aW/YtSEwvdu7
	HHiyfqf1HxoZ1tRfQIp9FleRwV1DIjjsvjCSnsrCPDvtYcPj2wU+tvWli3EYMdydGbC9VJcvj5a
	cLR7EGpuMk1CEVD0kl3H83OawtpAu3mRi5u//LCfWMwh6JgOD7v9alnVIn1AMavIT6L6d7BvTX
X-Received: by 2002:a17:90b:3bc6:b0:393:194d:5366 with SMTP id 98e67ed59e1d1-395c354da4fmr41782461a91.10.1787538040293;
        Sun, 23 Aug 2026 19:20:40 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14186183c0esm31175869c88.12.2026.08.23.19.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 19:20:39 -0700 (PDT)
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
Subject: [PATCH v6 2/2] iommu/riscv: create a auxiliary device for HPM
Date: Sun, 23 Aug 2026 19:20:29 -0700
Message-ID: <20260824022034.3916570-3-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260824022034.3916570-1-zong.li@sifive.com>
References: <20260824022034.3916570-1-zong.li@sifive.com>
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

