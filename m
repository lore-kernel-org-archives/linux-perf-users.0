Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5451832FA2E
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234179; cv=none; b=Y7EGT1GrX9Hdk0SW5ty5HL4TXbygTFsyQW/44Xw6lRLl4m2N9h/WOb6EFyXmwAEwMKc0Pi+r0f3mfieM01gGmvzUGmF72J7SA+Bk3I3qoro8omgjtRWj0mDKbYgBD8CPltvWxZxU/FzBlaKVKB/zGBh8xej1NykcI6Z7+gU8Dm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234179; c=relaxed/simple;
	bh=4cZIFkW46IB/x5YXpPxXdJxnBup5CaAIGlCAGwvwZ0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKQBAxuVy/tDn0tfZsOGddkEjWSCB+BdvAsXxmjFfVyDbT2MPG3gfRpYfueupXTPW3uOHalKJO4k2P0oG7thzZAKQMar1pahKx2bKpX67JTDGB9mIA7HlhYNUEhTWq5JxikXpcBiBZavj6YTsEAp5LvKBQgGrlkaDQxtxGMB/ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIg3kVZf; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIg3kVZf"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cbee846deecso2326169a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 06:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787234177; x=1787838977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ne4vpn6S8dDIeQGKLcmrAac8qYrgoBlC4Ci88bD6Wpk=;
        b=dIg3kVZfiQ3nk941uh14z4ZKNudSP5zIYYnnZQTPjMKWBqrqtJUeZWy/iipWe+yKmk
         oEmjOVW1L+OnAIvEDLz7lg4LHon1CNKw16PO4qquj2Pp274aL1B6AVb0QkCAyH+YfuDS
         VeS1dsiEh+SsXu5HsXp1bDDGwwgoLahZsKu7uv70bIJD4v/1iWcdOo4NFCQ7K5Rc81oN
         XIvh/JiF31B9zCUdcPXZ9svVvS5XRPHqNVobHXAx/rV+njt1SrDzw1Gz9VIM9US2Lv5K
         P/OaJvxHN8c90Jh0l+PKOH5eo3Dy6yEGT2l5mfvjSfgIlli9cbju1XbVI7p+wY8Htl4I
         uL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787234177; x=1787838977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ne4vpn6S8dDIeQGKLcmrAac8qYrgoBlC4Ci88bD6Wpk=;
        b=AhDpHUk/xXb3pP6XjpojKP7Wm0U8a5sRHIoABasvZ92o5hoGq8Vo+a5x+JHYI8kpUW
         g7H2ITTGb8Wh7rwZQ8gO+HDTmqXVg1lRmeKV5p/EvBEIrK/Yg7uFNRFETb6jm5I8dDJd
         GZwCeh4kCdOc1EzfDa8UjRqgMSOQaQEaLhyvmRYf6Rr2sQnul51no5dPyKq6Y3yYXjwD
         jd4i8METV0ipykKIDe2Z88pUiF7VkIu4eWUbDjRpQ/JTxytSmKuMUs1Kfa1WV/oPxPfG
         WsDUTdu4PjO6acuhDVm9nc9ZoBNRXYNgjE9RRLkjbW/BjzTgsNQPkf+h7jSNz205qNu/
         OQhA==
X-Forwarded-Encrypted: i=1; AHgh+RqCe6f3XGQf5I9+YDCox1yaW/Jb4EyzYpNkELlXQAZUp337cZJC5QcNjUeuXv2V5DT73OZAZKEio2Wx9QXEw1Pt@vger.kernel.org
X-Gm-Message-State: AFuF++mMBrWlFxSF2Qwaa5kkin3H71Aq13/NWzfk+kDyRcNs35dSj9tY
	QaeDgkPLJiY6Lel0V8b5iOxGzkD2sEwdwRiSrHM97RMQgwL8gKeCeD+hxnQiyKWPVHg=
X-Gm-Gg: AR+sD131V/g06FtCQqOYH0VzCFeZ62N3uc92DOPd2du3bMbs0XbQXzAyKuQKERSaQpZ
	Gx+mFInUW1ZBnCRnLTxQGrcwMMAhhe7P6t1FVL85wvrjkocdWqwPjktJC0yBefuaFSf+Es0JAc1
	WcIxJTcF6vIPOOhw0TuwxpEr2sxFUUlkLB7IIuhdhVSp5A5jNA3sAvVivG7Mw3+2cqb708B3f6D
	hV1eYEf/hymtNBorn15Hjo9hItdLS30JKPcIq0TqywSuz3ZyWlbcmAHxflo4U3O4flpQBT8128H
	7w+aAJs76QOqVaqkvBhj1ndkNhf2kEq3NkL4jJhUAj/jGoK4Zqj6XZPxCCXC6Bgmzf3/Xfo3QL5
	Qjz49yZJRB/ylgAa0wuw6mSMmDoafDMzgwvjaKv7zPT9u2Kb4X851uH78N+k6k68OoPe0xhPKrP
	pBNA2hL2DVITbq0eRuhvf7Qn2HG6pphz+oGuo0+nBz7lfYHHlFkQaOVfRUnYlyQOKKUDCoKSbLV
	GywUxGT
X-Received: by 2002:a17:902:e551:b0:2ce:93a3:c168 with SMTP id d9443c01a7336-2d5fd7147cdmr238498905ad.7.1787234177379;
        Thu, 20 Aug 2026 06:56:17 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:85a4:b9cf:b578:4307])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e36e1e3sm7476405ad.44.2026.08.20.06.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 06:56:16 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Markus Elfring <Markus.Elfring@web.de>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH v2] perf/dwc_pcie: Fix PCI device reference leak in probe
Date: Thu, 20 Aug 2026 21:56:11 +0800
Message-ID: <20260820135611.3901886-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_get_domain_bus_and_slot() returns a referenced PCI device. When the
subsequent RAS DES capability lookup fails, dwc_pcie_pmu_probe() returns
-ENODEV without releasing that reference. Repeated failed probes can
therefore keep the PCI device allocated after removal.

Declare the looked-up device with __free(pci_dev_put), so the temporary
reference is released on every return path. Keeping the reference scoped
to the whole probe also covers all later uses of the device during
initialization.

This issue was found by a static analysis checker and confirmed by manual
source review.

Fixes: 7f35b429802a ("perf/dwc_pcie: fix duplicate pci_dev devices")
Suggested-by: Markus Elfring <Markus.Elfring@web.de>
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
Changes in v2:
- Manage the lookup reference with __free(pci_dev_put).
- Keep the reference scoped through the complete probe.

Link: https://lore.kernel.org/r/20260814133925.1385687-1-ruoyuw560@gmail.com/
---
 drivers/perf/dwc_pcie_pmu.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 5385401fa9cf6..0e69bd71c3e61 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -694,16 +694,16 @@ static struct notifier_block dwc_pcie_pmu_nb = {
 
 static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 {
-	struct pci_dev *pdev;
+	u32 sbdf = plat_dev->id;
+	struct pci_dev *pdev __free(pci_dev_put) =
+		pci_get_domain_bus_and_slot(sbdf >> 16,
+					    PCI_BUS_NUM(sbdf & 0xffff),
+					    sbdf & 0xff);
 	struct dwc_pcie_pmu *pcie_pmu;
 	char *name;
-	u32 sbdf;
 	u16 vsec;
 	int ret;
 
-	sbdf = plat_dev->id;
-	pdev = pci_get_domain_bus_and_slot(sbdf >> 16, PCI_BUS_NUM(sbdf & 0xffff),
-					   sbdf & 0xff);
 	if (!pdev) {
 		pr_err("No pdev found for the sbdf 0x%x\n", sbdf);
 		return -ENODEV;
@@ -713,7 +713,6 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 	if (!vsec)
 		return -ENODEV;
 
-	pci_dev_put(pdev);
 	name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", sbdf);
 	if (!name)
 		return -ENOMEM;
-- 
2.51.0

