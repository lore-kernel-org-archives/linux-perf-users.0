Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D040F1B85D6
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Feb 2025 10:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739011219; cv=none; b=WzsGUJU7aB5sYMefLodbTMQf1fInnQ8IZ2h0j49QH1QT0YwWEoQfRf7UjLMmdyadJVSSiJPJu5JNaM2AT1LFxl5x5L5LX/XiV3QTqgD8A/fYp0UOzz7CrexrvJ8qVpduHo3fO11K5KSArzhjV6qqF8XWaeJpMi25yLAPsmRrQG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739011219; c=relaxed/simple;
	bh=n03AzBOBWmT08Gaw2Fpnbf95ax4MQddkTuaxTNL3zP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bj3Bm1jrzdk1crQBGNM1woHvEPRcxjT8IAjr/Q/aAWm92ounZiP8JFuXd0eG+ldEvEHNr/KHW9Q9+qHkfIml6eojAoZBgxuJ0xARSXXiK2X98jS1moltiS3J3mDA+6AWxqXtORCgEfjeakJYrWPq1K3qEwvvhig2N+weZtb+sVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JboYmYA5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JboYmYA5"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f5660c2fdso27062145ad.2
        for <linux-perf-users@vger.kernel.org>; Sat, 08 Feb 2025 02:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739011217; x=1739616017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQGQvZxBQgd+2Ma/k6f6Q/GLYBdp+hkg2ZeYWxhonnA=;
        b=JboYmYA56F94fUshJ0HZ2gOFmCF0Wdw5txp0sj6ReP5FGnUPHbbIalHDpoefzrGMGx
         PWgcEr3c0qxPWd6Yg6B2YtAzgNm+Hyzp96YdXvv5G6CYr0ZNAylgvxCzYCC52c2Y4aw6
         cLUYudS54DSUsSnavOD2pICevDWj5VqKO1YbhVfj9z0R5PKUEkcV6ckr4Zshq8lbswDF
         udNZgfKRPPRfb3M0lIUQWWuaU8Vesfw/mQg3GOSr4Mru8pZ73tgy0kxDFq9mspIkwcBi
         gPbVzbZMa4/wPZsKjKjCrgfkAVLsPQsVDxrZ41fJYeT9UzGlc6lxLQXbQxR3hXMGay/t
         Li3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739011217; x=1739616017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQGQvZxBQgd+2Ma/k6f6Q/GLYBdp+hkg2ZeYWxhonnA=;
        b=UJuhhRGcs5JA37Y5EKmgvk/HUiuD1zTvhb8vCU4dz/diDAOvmF7tLSaSWU/41zCFKM
         3KTUAxkIsRXqxsDBnQfVBlUiYmASoA7ieWRu+Llqoq26SJY061Qmya6OhE0icNH9gbtl
         cjvqkGFEPC0i44gyf1IH64tR4brMpRw3DFKqPrtuid39JfaQa5BLdhLZG5vjVf788/aK
         kt89FUjPhg56QzGKxoAyrSBjMufwooF6YswhqWOnWKmEdVKfmSp6bUiC+XzvER0ocjue
         E5A+Dp6K5ZhBXJFXCDU+FCTttV2vCbi3CEG1zlaqCTWV2q/BvRLN4JDuUzYq3IU3lSFJ
         sC0w==
X-Forwarded-Encrypted: i=1; AJvYcCVFqDxio7kq/gHr9wcI5nRjp95MWbTAJBYU5WrwVrT+CAeUvL3PkqL5uF1o7JD3LY0k5/XKzfJPi8JjvaGPEUL1@vger.kernel.org
X-Gm-Message-State: AOJu0YwZpWJxkaFcB4dIFAbxYxD6uDvcTzlcyxLpD+gbcEPjdi4AoHCI
	MEgLbmAwAmIlBpX7QKJib9savyQklR4vPu3x0hE0uMU8gZAXbeR24rBsFr+vOsA=
X-Gm-Gg: ASbGnctUNtG5Q6o1aEKTyVk60LMKykUu4r898iZpWI3Xact+wIexRmqY6rPNwpOVvqQ
	X6jkuxQ2iTLc2mCtx0DcHvJ/lhm/Bw2YrfYAnEV3N7x1jfnyhBIsxdMPtxIlERpMDlrAb+VcWfl
	B6qTUCRZgDgIamzUF/tV1s0AOO4xaui5ER9Odl3Gb2KlgGzrZcxIohkAy/vuag34V1ElX6c6bjt
	zIEizn+xkXViXmsgq82YMcZMiEFAJ1WA/qkbPTJ+B8OXxad9uX6oknYKW/JLq+HQlWB/ZZXKpJ1
	JGrdaC6HzLn6IrNFxzxkNqkm5tWNn6ALjjjHLc1Ob9o2P7Yv/A==
X-Google-Smtp-Source: AGHT+IFwKZ4ENzUKalHf5+THzKNZ277YQzoHoj85tFF8ysZVymo0KlkXTEeb4xQMHVqxLg83ynp2eA==
X-Received: by 2002:a05:6a21:918b:b0:1ea:ddd1:2fcf with SMTP id adf61e73a8af0-1ee03a22bb9mr10999850637.4.1739011217015;
        Sat, 08 Feb 2025 02:40:17 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad5460b8d4bsm216325a12.11.2025.02.08.02.40.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Feb 2025 02:40:16 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v3 2/2] perf/dwc_pcie: fix duplicate pci_dev devices
Date: Sat,  8 Feb 2025 18:40:02 +0800
Message-Id: <20250208104002.60332-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250208104002.60332-1-cuiyunhui@bytedance.com>
References: <20250208104002.60332-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During platform_device_register, wrongly using struct device
pci_dev as platform_data caused a kmemdup copy of pci_dev. Worse
still, accessing the duplicated device leads to list corruption as its
mutex content (e.g., list, magic) remains the same as the original.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/perf/dwc_pcie_pmu.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 19fa2ba8dd67..4f6599e32bba 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -565,9 +565,7 @@ static int dwc_pcie_register_dev(struct pci_dev *pdev)
 	u32 sbdf;
 
 	sbdf = (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(pdev->bus->number, pdev->devfn);
-	plat_dev = platform_device_register_data(NULL, "dwc_pcie_pmu", sbdf,
-						 pdev, sizeof(*pdev));
-
+	plat_dev = platform_device_register_simple("platform_dwc_pcie", sbdf, NULL, 0);
 	if (IS_ERR(plat_dev))
 		return PTR_ERR(plat_dev);
 
@@ -616,18 +614,26 @@ static struct notifier_block dwc_pcie_pmu_nb = {
 
 static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 {
-	struct pci_dev *pdev = plat_dev->dev.platform_data;
+	struct pci_dev *pdev;
 	struct dwc_pcie_pmu *pcie_pmu;
 	char *name;
 	u32 sbdf;
 	u16 vsec;
 	int ret;
 
+	sbdf = plat_dev->id;
+	pdev = pci_get_domain_bus_and_slot(sbdf >> 16, PCI_BUS_NUM(sbdf & 0xffff),
+					   sbdf & 0xff);
+	if (!pdev) {
+		pr_err("No pdev found for the sbdf 0x%x\n", sbdf);
+		return -ENODEV;
+	}
+
 	vsec = dwc_pcie_des_cap(pdev);
 	if (!vsec)
 		return -ENODEV;
 
-	sbdf = plat_dev->id;
+	pci_dev_put(pdev);
 	name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", sbdf);
 	if (!name)
 		return -ENOMEM;
@@ -642,7 +648,7 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 	pcie_pmu->on_cpu = -1;
 	pcie_pmu->pmu = (struct pmu){
 		.name		= name,
-		.parent		= &pdev->dev,
+		.parent		= &plat_dev->dev,
 		.module		= THIS_MODULE,
 		.attr_groups	= dwc_pcie_attr_groups,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
@@ -729,7 +735,7 @@ static int dwc_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_n
 
 static struct platform_driver dwc_pcie_pmu_driver = {
 	.probe = dwc_pcie_pmu_probe,
-	.driver = {.name = "dwc_pcie_pmu",},
+	.driver = {.name = "platform_dwc_pcie",},
 };
 
 static void dwc_pcie_cleanup_devices(void)
-- 
2.39.2

