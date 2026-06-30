Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906282BD02A
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2026 08:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808723; cv=none; b=HRAz+0qIc9aXBhmhWWaKpO7Lbu/tcEg03jTi0iDPuDhPwvCvKcbnGYxuNvnnscDGj0sw0J4pP4mzaqpnrNSCIuaQ6xO1lXJglTOcQG0JKKXXoYZ0rFLS800btY4JysEwIENlF/7IpZElGwhHYOPHi+fXUzhkwk2jdw7FWiZ8QsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808723; c=relaxed/simple;
	bh=UxWopZEaQm0aPm59atwtT4/L/v4FLHyW4ZpGbmFDrLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dh5aRgGaiQba+qYi336qw/yUlQ44USxSdMfUuhHTC/yLgFWupYZd0+Clj7W1BKnSiR6T9zw1UDrezEWciEOsLsZeokxg0aZrlB1GL1hAhp/xO9LpSOONm6jjkHAG/7Lwez2x6HMLK0ui8R8GRc1esYC/+hu/beHjSO60SKe/+ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=GS4VEK/A; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GS4VEK/A"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-139f71a5201so403636c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2026 01:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1782808722; x=1783413522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOC0O5L8yCrTPyUO6WSb6ea4HWyqtXRV/3bmbz0pQTM=;
        b=GS4VEK/A/3yhIdPlNguPBuSkg6xIiXvsZ/bCWep6Z9DyvfV32CSWDvdtDlsOH+J+Wa
         QY50Fq5oJRfe6mgYYAwUd+KH1eHworsy2w5jw78SP/84QjyomtK0tn3Uf1gYlLMXX5MY
         zz+uyUgu2LCqFI3ffe5xpVQtyYt6fWhL6mwcCIb6l1DNRUX+VnctpwlIJ9ykCrhiVJJl
         5PS9Kq9meXW/yxLGk6mkujD01vg7Nya5mSoUwCevhwf+0ACUrs1ZggcMrq6W56X1fycR
         YZUMDIgTE3s/H6GHaFpI6IDqx0pFhs28/E5tc4jcpXjWVfT9PEn6TAh3ncFcDJM5W9IX
         6F1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782808722; x=1783413522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NOC0O5L8yCrTPyUO6WSb6ea4HWyqtXRV/3bmbz0pQTM=;
        b=X6HY8Fw+8/jdsehBl2zePYLeT6ujuiN49stTHLNPGwrTbFPGZUtAO8eZWrFwNL6oJx
         tL7rbMh/3ecqC/QOT6JmqOts2RfLwo+xbITpW9yUmZ8q2enpDNtZqb2MrfV7H13y+tgq
         E8uIyGzJyXjWKzwbC5ZMcxMFtiWGkmlyl60UNTfN32ezAlLmMHgGMc5CbOYdlJhDme/z
         G7z2TxIQE33SuHeWad1xII3R/VUVwICM4pI5ssxsaqqRbb2necwe0a90ilDWPBBbW0zZ
         1IiegAKDDMOK1aHMuY7Wv7K5U5VTmehKCt+qvscRn/Wwwsgam5WEV0c2jnq/YmEeJMj9
         jAoQ==
X-Forwarded-Encrypted: i=1; AHgh+RojEGxpJoaVvmJYM+n91A0C8kTAbCSSolBr0ds9GknciS7/bnvA8uwDDazChl/ZyVh/52U/15VQf907yq9WW8P0@vger.kernel.org
X-Gm-Message-State: AOJu0YzrnmBtCpqWHz+QSuXHk3RWipbziwQnSRFZXI+WldfOxizfinGz
	fr1iogaPAh2HxQBwgZ8IVdtp0BqH0D7Yq+4Q44j8g1bJOzBFL2eqis0H8NI5zokQhFs=
X-Gm-Gg: AfdE7cnEwuoDsodqFM3f4ekNUDAx5DMznlLxsC3V4kMd5eBvrFw3VtGEEX9VbibVy/3
	ax0HOX7J1mMgg/WZP6aLyRsreOsXwhZ2M7cGicFTi+jEtKhLzmS0fzTFhb5E1x9n3hLiYCbgK5x
	VKTUWEFb7LKRWAim3knxIAupCU3okGWNQTnKLgRmdGv33usebQn0Rsh0zR0gnBv57WRD9J7XJvS
	z88ykVnHPDFrD73+BYCj2NwcIVTNRAz5fe1D3WXHulVgByp2ViBEiq2fe76KpHGkXKYw1aPPUAx
	LwZEf61m7g8Up2Hgwb198RMbX2tOeJox6/ElahbfErWyr2u/FyyQu4JIa/k0lndVa8+mQ8trbtJ
	pClHC6NkwQJXxiO8Ro9k/ZZ2QU124B11d6vJduIqZY5eaup0th81Wsq294bIBrZSqQodZ+Aqr5A
	dg51pOogUtWQCLfSDLHWUeqX0jJVR9LHq2aGc=
X-Received: by 2002:a05:7301:2a27:b0:30c:ab96:7304 with SMTP id 5a478bee46e88-30eea0b83b6mr831847eec.20.1782808721684;
        Tue, 30 Jun 2026 01:38:41 -0700 (PDT)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2f5aeb0sm6756444eec.3.2026.06.30.01.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 01:38:41 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: tjeznach@rivosinc.com,
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
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 2/2] iommu/riscv: create a auxiliary device for HPM
Date: Tue, 30 Jun 2026 01:38:07 -0700
Message-ID: <20260630083833.1275837-3-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260630083833.1275837-1-zong.li@sifive.com>
References: <20260630083833.1275837-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create an auxiliary device for HPM when the IOMMU supports a
hardware performance monitor.

Suggested-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index cec3ddd7ab10..36ad4aa81465 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -14,6 +14,7 @@
 
 #include <linux/acpi.h>
 #include <linux/acpi_rimt.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/compiler.h>
 #include <linux/crash_dump.h>
 #include <linux/init.h>
@@ -565,6 +566,21 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/*
+ * IOMMU Hardware performance monitor
+ */
+static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
+{
+	struct auxiliary_device *auxdev;
+
+	auxdev = __devm_auxiliary_device_create(iommu->dev, KBUILD_MODNAME,
+						"pmu", iommu, 0);
+	if (!auxdev)
+		return -ENODEV;
+
+	return 0;
+}
+
 /* Lookup and initialize device context info structure. */
 static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
 						 unsigned int devid)
@@ -1613,6 +1629,9 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto err_remove_sysfs;
 	}
 
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
+		riscv_iommu_hpm_enable(iommu);
+
 	return 0;
 
 err_remove_sysfs:
-- 
2.43.7

