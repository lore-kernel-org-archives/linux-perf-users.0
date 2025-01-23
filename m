Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041AE1C5D5F
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737618525; cv=none; b=e6D+miG1cDtyF2BGnKIP8U/Ov7D3XB1hftXGQIelNO/FCXF9H1Y8zuLtD/5/85cC7zpPBZthS44cV3zcZsXaFt7bJqRndnxmFdxoA7K6JWqgefqIc9CP/2/1OEupCTM47hW914fliEo8rIMN3hVopYoDDpdgMwBGvmMXI99BiJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737618525; c=relaxed/simple;
	bh=E0Qx9FZxwsUpuF7Q7TcIl3+sHLKgQHJqorw9hLI9+Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r5KiSQZnGpfBqvsSfuaHaTmJoJxWslUMMgXzCDwkI+obFKm/cEpc2OD+q8Bl5j2PWe8hWckYjl1xRS0w5+2X6J6vq6Fgcy2Eco7SNbmW3eeshZGxkg96aLpwZFJfEjShmU1Si3YbMcuBHPs+8GNDkZfgEcCen+V0+G63ItQ/w5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TezeUwNP; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TezeUwNP"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so955262a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jan 2025 23:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737618523; x=1738223323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=akq5KXNO6yQt2g32XEbXQyeThszQvcySRASydOxEc/Y=;
        b=TezeUwNPxfqABNy7Vix6ntqLoK9kVSfUH92oEkasW0FV5DEv3SCrkgQPGAb4k3smP+
         NobchlrX5Gwh1TgSl9p/1OiaG10pdLbuIXFdMd5qXtSyl8dy2L16x6st0wuSVcfcKxIw
         vIGAfamKPRro3+rJzxtnwdl+DsYlhVydkoot6k0AWWaFikH7+wwSgBTZndxPCcnEqihZ
         sOgklWGii1mvrjyk2Qk6B5pFty4xTliKYTIwWhlbmJGheTAaOncdqVuCLdHFEnMB6w0m
         yRjnxbTKCR7m7pYr52NpRVgR5vpiKizPKHpqBQ+76KX9nbB9BRNGdcN0WwthOVluu8mO
         bOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737618523; x=1738223323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akq5KXNO6yQt2g32XEbXQyeThszQvcySRASydOxEc/Y=;
        b=b42qqIyWWmsjhwAfnqY9wzdCbHzeUnElZhLg0w5XQ59w6VWZRmif+h4vM/UjZ6/bHT
         IJ2hlATIMqVmOc5lIQQCZsTx6nsu1NsUmUhZKkPa2MpgKbaa8tPwjijeBIedkxeosALg
         iOTjTc5/l+6bXxRabTlHJRKQ/kfeT9rhxpuSBSk7AdE3JrgWcQRCYGptXY2sRHY3Cgrv
         u9mLbLiaXK+bGV3iIztzJQicWZ6WChWNHQBtAfgBbr7V0LCYG0IR3P3hLwwH2rpWlbDy
         g/pWJDEBCnB89+ImeCTP0+5pb6zwXD/OCbyZLaUS/8MdAifCcuBWZWOX5s09XIRBntvA
         sWCg==
X-Forwarded-Encrypted: i=1; AJvYcCWOoAYQn+qBPppexuts/u7uVud2jVlfRCMJudnou7mcsZ615qtjH6ajmq/60yFRJYtsCNc2vais0iOwNoFTjy/X@vger.kernel.org
X-Gm-Message-State: AOJu0YwzSxj0TcBaPFcgXxCTrnAowAwxLLSGAH5A8wxP0+MpLjAD0aXO
	UZaidlAmi7TOxK5L6rZ+LxUi39DY2DDn/hXe/DeBUTWAB8WOlMabS/Z3QLTIt3I=
X-Gm-Gg: ASbGnctYxaZhi41rkLzQokJW4ZNYlgyFyRuDQu1NtlQCw8xE11X65l4mBWruG5addZ6
	lmjqWqer+sX/OTlTwwjHQZtEpyetdGRDOTkVRb3u0gpuATXb6oonfgIH8XtXkkQJeewsQH4rpVz
	1w+JkFQWW1xYUXIdDMA9WaPk78koZ9Mhwt2T0DeetVqWgYgtvbqoGgWek7vpSIC/wb8IwKST+Eo
	igWCsxGef87FxJ0qVdc2dnAUuu2VMm32AFYwJbDu7hcjcMwqcDMY1I8luJ3eN4odOCTBVKG7BuS
	TWdXsndHjnVYI+r00OrrnLgxFsNPRiXpFwn8PgY0uRg0J22L
X-Google-Smtp-Source: AGHT+IE9X53VOiUMKpFB+BSDlxPRom2fGPMvdfIAykyzXKLH2DYJqYIyh5IN0C8tYV+MtH6iQMWt8w==
X-Received: by 2002:a05:6a00:b4d:b0:71e:108e:9c16 with SMTP id d2e1a72fcca58-72daf9760cbmr36109849b3a.12.1737618521995;
        Wed, 22 Jan 2025 23:48:41 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([2408:8207:7820:2ed0:a46e:6310:4021:f441])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72daba4895csm12749090b3a.130.2025.01.22.23.48.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Jan 2025 23:48:41 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH] perf/dwc_pcie: fix duplicate pci_dev devices
Date: Thu, 23 Jan 2025 15:48:30 +0800
Message-Id: <20250123074830.90923-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
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
 drivers/perf/dwc_pcie_pmu.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index cccecae9823f..8b208f287a1f 100644
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
 
@@ -614,19 +612,32 @@ static struct notifier_block dwc_pcie_pmu_nb = {
 
 static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 {
-	struct pci_dev *pdev = plat_dev->dev.platform_data;
+	struct pci_dev *pdev = NULL;
 	struct dwc_pcie_pmu *pcie_pmu;
+	bool found = false;
 	char *name;
 	u32 sbdf;
 	u16 vsec;
 	int ret;
 
+	for_each_pci_dev(pdev) {
+		sbdf = (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(pdev->bus->number, pdev->devfn);
+		if (sbdf == plat_dev->id) {
+			found = true;
+			break;
+		}
+	}
+	if (!found) {
+		pr_err("The plat_dev->id does not match the sbdf");
+		return -ENODEV;
+	}
+
 	vsec = dwc_pcie_des_cap(pdev);
 	if (!vsec)
 		return -ENODEV;
 
 	sbdf = plat_dev->id;
-	name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", sbdf);
+	name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%d_pmu", sbdf);
 	if (!name)
 		return -ENOMEM;
 
@@ -640,7 +651,7 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 	pcie_pmu->on_cpu = -1;
 	pcie_pmu->pmu = (struct pmu){
 		.name		= name,
-		.parent		= &pdev->dev,
+		.parent		= &plat_dev->dev,
 		.module		= THIS_MODULE,
 		.attr_groups	= dwc_pcie_attr_groups,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
@@ -727,7 +738,7 @@ static int dwc_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_n
 
 static struct platform_driver dwc_pcie_pmu_driver = {
 	.probe = dwc_pcie_pmu_probe,
-	.driver = {.name = "dwc_pcie_pmu",},
+	.driver = {.name = "platform_dwc_pcie",},
 };
 
 static int __init dwc_pcie_pmu_init(void)
-- 
2.39.2

