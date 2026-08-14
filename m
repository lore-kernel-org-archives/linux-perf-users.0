Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A1745FFB6
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786714774; cv=none; b=eHFp5PpEjJC8aiVnUGS2+ZH7otBZ7hhRqq4mUkKP7bjKmMNj3JVYww4K82rOmDkpHAYDVFLctSbfeZFNqwZdse45/numbyvY3aHrNGZGFru1M7MWKwY19CtxhtYBK+C+WKXJqm5pIysijU3TdvacAonehqxiTI8mTZF4K4MMrK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786714774; c=relaxed/simple;
	bh=lInajHjkw4Q8LcDb/Gghh8m3vt/7wxvz8fOnYTKBJHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e1DyH5qGfWhzu83RbmbKX5dqE2Z21bS5xbkAdCJvu7I5q2ejqnVm/V2Mi4mbvIBLcXaK1p9A/3UhKoj/bMgQeo7mQvbwt/R3WQAo+HP9mduhextQB11rXEOZrVK36I5Db5sS43jZUHWT4hGHzqOYP6qt3W+qq36h5AB1hD1Jl+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C71W79fL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C71W79fL"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cf52d15d88so10411015ad.2
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 06:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786714773; x=1787319573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=si0qdL0+WRVmcaDS3m3V+/d5WwTk85WNRswe6KdeyhE=;
        b=C71W79fLDG5CcAEAk0qPMNyjAIwaFSB7CqwyhXTcp8jHtKrr1IbFtB5Msmvxe9ZJIc
         /AZS+9VPb4Ma/bE/Fk9JzpKMdgXUJ6IGSe3zx+wORlTFq/4J5CRm8FPjkdkocF1dtnTA
         6gQrbx71mAoi8t27CO/txASCp3dE4nyOcB6EohWFEjJL5BJesPjfzk9yBVkeD5JeE3Tu
         VU+v29Xa3tXebr277ugXGyfV9fiE2kqpz2GQ3bL0g6OlPegLZWTLpUvWLGXt9LnrfT5w
         g82mE9/1Ns8iya0llyq8ZlbxWAE5/14ZEe4Icv+2WxHZnOygrE0NMnItl3o5suQGD9k3
         IA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786714773; x=1787319573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=si0qdL0+WRVmcaDS3m3V+/d5WwTk85WNRswe6KdeyhE=;
        b=Nm4SC6E9ddDoxjEPDS/LcUIIbXa1ldXHiiRT3srjqz4DvzhGmPCrehG879TiMHtX85
         XLpXZP1iq4gEbw8CkiwcUU6jGJFsYr44pwFJttKRWBNsfJ5XjD/PILtdWFv63ZjPk1Ex
         tY9mvRe1lc7/xVot/P9GZHGLoYqgFe5+4P/FLDdJB/HVT3WTexcJXeYpTXDA1UW+YT6R
         rcJv9+ztUtxXSMPoYcx4sszAADner5u+uOmgXNZ4nQDCa0WO5+ikpeAY2Mt7bSWguQHU
         FXzmRcffiQdgteO7eFkDkNbAyeYpPN7xGnKflRtJX/Ah2AvvUfp2H2r28DmqITDw1Rnd
         3VeA==
X-Forwarded-Encrypted: i=1; AHgh+RodWFBfdG3AUInwJcCMZDVLREtib7bYGoiEpVAruvjT8RFHihPzIXJh26Kq5m6qocWTx25+AOcw8CWvvIfXVX0Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzE2xjTLNKDeLwPONhmK1nFugq3wa5GY6nkxkTJnAHprkLiVa5x
	7gj5ZhW2X1Sti/nwIUSNgPoiwpvsyEEi0TIBTzqSLuQDtg4DblYLq412
X-Gm-Gg: AR+sD11MDZKSthHJrEnKj9v2TGB6UnYSy8NFOy/rweNe42dAOUa1RWpgQhjOgfYP9XK
	lie/maE9nEgaPQH3YJenmZKazM3FCtLqPh1G7B7tSL0HECcanB6HVBWh9sCi3pHvwpEgrNNK7sI
	I4xCuEJ3oHrmCjB26qhVVP5mgknsjYR7D6ilMioG1DKDrkBvS2l41R49RbxaVisUZsW5TIMQpze
	GDLOiZd+a6ZDnmNlbTBh9dZiurlWC4+f2T+VMR26SKl/y1LTb8eL/2OQtyc4cl9o11l8DEJba7C
	bf9DBj6ksE97J8dP00EAZwUJ5ccZJy7DEqtZpEqUfHC5EDl9r8ICNEDjUYcvg9wqw8Vgf2JCw0v
	z9ggOOaabInRz3q7E1DI9d3r05fJkrb9QrkFafQf1dBph+2fuNEzdZ919GF58O1S4Zgk+EMCUD0
	H6v/FG1eoXg5WF+sZeX1iAa96c5PNCsRxZ2XVPr/dO9aDL8c69jzEr4bRWP21h0i3LU0uNdLPy4
	nWoB/yZ
X-Received: by 2002:a17:90b:448c:b0:38e:6dd:a9ad with SMTP id 98e67ed59e1d1-3933b52354emr5655567a91.0.1786714772510;
        Fri, 14 Aug 2026 06:39:32 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:e9af:7c0e:be31:2c3f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eaca8e4fsm2767080a91.12.2026.08.14.06.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 06:39:32 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] perf/dwc_pcie: Fix PCI device reference leak in probe
Date: Fri, 14 Aug 2026 21:39:25 +0800
Message-ID: <20260814133925.1385687-1-ruoyuw560@gmail.com>
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

Move the existing pci_dev_put() immediately after capability discovery
so the temporary lookup reference is released on both success and
failure paths.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 7f35b429802a ("perf/dwc_pcie: fix duplicate pci_dev devices")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/perf/dwc_pcie_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 5385401fa9cf6..baa736fd9a6ef 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -710,10 +710,10 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 	}
 
 	vsec = dwc_pcie_des_cap(pdev);
+	pci_dev_put(pdev);
 	if (!vsec)
 		return -ENODEV;
 
-	pci_dev_put(pdev);
 	name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", sbdf);
 	if (!name)
 		return -ENOMEM;
-- 
2.51.0

