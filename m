Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF25345724
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Feb 2026 06:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770532743; cv=none; b=RTm9IQAVjEmtBMzhKgjVZ38rhZG3IDC11+JJpAOAgnbL7FcgX0QpHZdcXSvLHokQCX1f0RAbmLwA+R88BFkrU//0FBVt71E6sZ0O27ZFCgiDaK9oUXFJwuxMgFtbLrdlTBT9juOO0PbRO7CFONORzJdfvZYbacy23o28GwcHXIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770532743; c=relaxed/simple;
	bh=wcc9KnVjKdcKm499FqDP7KbpPOAGrVGwzxwJ6V3VrBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDy0iB3nZWONUap7lCEeo0NzIZ8zFLkE4FLz3VpCFXbaoDoA9K/Eo7y2HFfqjjOShJXARSZu37eU1+aPfCk06oLmuuG9OuRyFXg+6gvNBYrO9CNMjJGFv11V9fPB0AQEys6rnjKmuKOS2nKM2AHtwhHafc/qVZIpmbMk+TRr9VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=CGoGWOH0; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CGoGWOH0"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1270ac5d3efso1444422c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 07 Feb 2026 22:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1770532743; x=1771137543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqJrVLmLyHXBLluZVvcfbrCnXHVEtGPNlw21Z5ct3vE=;
        b=CGoGWOH0EiU+ZgeTnwMu315guL0cjRUSouxxgje1gOxVOQITnmjwY7W8B+ORoHrcKC
         uJYIWapqNcRJkuq95SfvWTrARWdnRG5A1DWBbkLjsvjxaVD+t4XIRYxRCD51OL+Fa4jp
         1rQHIUq/Nde7AmHKtvYOetSX46oR1xIuxFFKoPR7WIZk5l0JbFMEN7m18ztM4Gx7N8d6
         K2ydaft7+QBk7KqX18flUcG049JwsXtacFeXKK15sQ0giBQOTsF9BGVDqGiscLB2oAQF
         NJvpdsQpfVoWsBe0WaJ+nw7zPhY9V2yFnwf4oPov4fAraYeJZmwueB+BPbTjb5d4oXF9
         ysGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770532743; x=1771137543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SqJrVLmLyHXBLluZVvcfbrCnXHVEtGPNlw21Z5ct3vE=;
        b=MEQPDUm5EP2Sq+ASEyouJhwK0WQv6ZcTl7/sW4oMHzM5j1W/y6m3/DYnJJ+Xi1x2Gp
         iTbRKNs/0LmFJxrjPtf6tvF8nJ5jbbhkI444KZIaKB7PR8kFuryvL/U3a7PMuhWkEfMx
         vbwWml1sMWSCBUFG4+uxK6PaCk0qG64TojVyYUYiw0xC19OHCq2g8wPyHrlKljf5powZ
         kmFqc/8R8sb5Ogr6f7+O9Xs1dpy7sZnE2XJGCqqutE9gwPmRISaUFvM+AatY9PuSCWs9
         dxScLsBxeyY6oziAxXFngFJvVURpNbm3kVRY0G4wE+diU/mOFvp5EP0hPNYdThbQO9lI
         P5Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWbD54Bf6H2CbZBXQ0mp9vZQ8XfUy1KqDj+1QN38oquUT38kOyG2goWT3MwpCifu9X3mtzZtNdtkaCl7MMfuyhB@vger.kernel.org
X-Gm-Message-State: AOJu0YzGXfWKD6da+L2Y4RIJ1y+gIrkxCXn5IYQ/gYC6sN3X8ywcS/by
	WAgEtbJn0k1rfvXnkzGRpmdwmyQcZp20e35VWnlGeTn7nJGMJD65pdIFYVWIvZXjI9I=
X-Gm-Gg: AZuq6aKhQtMACBww5inUJ/z46xdIvPGzWhJdnNF9jrXyrUXTZUpNWTrRrsNES6L/ITM
	xEF5UX6NFDzukq+Y9mmja76BpUfE77J6jMJPl5dj9FJnSqOc/57SwRTLItVb2ZaIQTkZj9IwAHn
	/ENt0C4JaqAhd1jPhaqHXc03vuWn5U6uYEtuZdlPtXZ3AZ5PCYyYybZpgvMHHVR5g8NDEEKO/+s
	V1fTG+Attk+jGHrNv2GdwVpbjxpXkwax4175ywwGfQM/sfyYq+kPOyKkZaX3/KxfYePHUc7ugk3
	1YSHvPtQOWu4V1CJqN34Z7qZvLpgvAYAc7eDNYywFxMjjmOPI6ig/ob7geTaJWE4Q+5X7e6qF8I
	1w9qKTyTPE0C+NUQLQIPu4/nhoBFsAaI4EPURVpzD15EcfP8gEmEPjYuPiCVzREdwHB8+5uC8Rz
	9vBeoAfNmON1zFUe+fjRLyfbE=
X-Received: by 2002:a05:7022:2527:b0:123:2d4f:ef1c with SMTP id a92af1059eb24-12703ff4c81mr3247994c88.26.1770532742709;
        Sat, 07 Feb 2026 22:39:02 -0800 (PST)
Received: from sw04.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1270c9ff2bcsm5114647c88.1.2026.02.07.22.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 22:39:00 -0800 (PST)
From: Zong Li <zong.li@sifive.com>
To: tjeznach@rivosinc.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	robh@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	mark.rutland@arm.com,
	conor+dt@kernel.org,
	krzk@kernel.org,
	guoyaxing@bosc.ac.cn,
	luxu.kernel@bytedance.com,
	lv.zheng@linux.spacemit.com,
	andrew.jones@oss.qualcomm.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Cc: Zong Li <zong.li@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 2/2] iommu/riscv: create a auxiliary device for HPM
Date: Sat,  7 Feb 2026 22:38:36 -0800
Message-ID: <20260208063848.3547817-3-zong.li@sifive.com>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <20260208063848.3547817-1-zong.li@sifive.com>
References: <20260208063848.3547817-1-zong.li@sifive.com>
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
 drivers/iommu/riscv/iommu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index d9429097a2b5..7cdb80d4343d 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -14,6 +14,7 @@
 
 #include <linux/acpi.h>
 #include <linux/acpi_rimt.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/compiler.h>
 #include <linux/crash_dump.h>
 #include <linux/init.h>
@@ -559,6 +560,22 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/*
+ * IOMMU Hardware performance monitor
+ */
+static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
+{
+	struct auxiliary_device *auxdev;
+
+	/* TODO: for custom event support, the modname should come from compatible */
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
@@ -1669,6 +1686,9 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto err_remove_sysfs;
 	}
 
+	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
+		riscv_iommu_hpm_enable(iommu);
+
 	return 0;
 
 err_remove_sysfs:
-- 
2.43.7

