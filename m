Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3971B4158
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Feb 2025 10:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739011215; cv=none; b=Wek3QQ3Ldizti/GhHNOo994KBMTD+ErEKxUEvsE4tSLKYgcUJG+fUnH68RkJLn+ktfoFCW/L2wgiM43mH8VfFivkMkLHJdtR4fE//pN5w1+V12oHzqJ71qOH6+PdLiq5Ja8hARHGH2cRRacGnfyx6hkAd2AGRMTMhmhejq9gYA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739011215; c=relaxed/simple;
	bh=eiRKbq2vepIQ7vYQL3IVoywHrok/Z1eF+aDZknLuwYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dk+OshlqWK34C+ioMG2W660/SI2MMUXlNeAKiocxi9zOagTgu3f6O8hT6H6RGTyIMFXFIp/LfcczB7R2ZjiZzsjsHa+S/IPG0ngLdEupWPzuW+6mQ3qlM4fLMNJqSjbYUd6FIZXzFWzNoDPBNKr6SvdEYfDfDfkpUw8f5fUkQrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=go/gZIii; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="go/gZIii"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21ddab8800bso41461495ad.3
        for <linux-perf-users@vger.kernel.org>; Sat, 08 Feb 2025 02:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739011214; x=1739616014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juzMyLx5J28dogWl0dvZjIex3AlV6esdHMv6/KGnTD4=;
        b=go/gZIii2rGuVZxzTCCC4fCOOHTtI10Hm/8ng1WeJt84+Zb6eT0JhF5EYL7q9ObOPj
         yEbEoUqZTpNwLl3GbEqAss704Jx2b2Yyj8C/gckmISEN77Jca+Z3jXUtKY19tyslRJZG
         A72z3/pQ1iLjSTMfLT5XGsceASo3pesq6BswOeLjMLkcBsONQDZlJFlHgk+GUQkAooAA
         vdcZkkXSPMFvlnpwTfR9j1Kcp0RehZwE62mQvzAp8NVopOGjo5WNh0tsSXvT4fIdlIzg
         y/91C6CFgkbyewVRhUDx+o29kL2iAtYFeMK9SRpnrLNd4IiWO3opeAGH/QyhmJyZQuEb
         hB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739011214; x=1739616014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juzMyLx5J28dogWl0dvZjIex3AlV6esdHMv6/KGnTD4=;
        b=gvIRNiAFF82RvYzptbd7btW3sFKWDmuZ3SRSZ/uOjmttoaaQKDXLRzebETJhN0gBt+
         odrBs693N8KbwxOdrHiA/j9RfKXdRe0+O2CBcLtMPYJYRUfSYGaJo8SNhm0vspuieebO
         IWm/fagwBP6vw3MgHS7hT96fHXO92/m8BIDjGXMQMonHUWHyNEr3Ndvk09JRB7H1aF0y
         IcCmE0BXCHUfJDtSCWSTmTiw95HF0sKbq1QwTMiTvpIRaEBGLtTnCXBYIxMLmAl5YP98
         EX3cLQwP9rS2L+Z99EdG5x/4CBc/VwPtPUiK1RMPTU6Uw9Fa4fU/0wszpqwRAaa3ufIb
         RYqg==
X-Forwarded-Encrypted: i=1; AJvYcCVYJeadIWGJ4suYsprsvaf8bEjw9R9K9B2I2Sf1mYRU0reUarzszBiYsZfbkWeS6ZcIIKptNF00KNlK5pMsstPK@vger.kernel.org
X-Gm-Message-State: AOJu0YxK0wVSmYrjBgtvmGWNzZIWJq7wmh2g2JCA3GM+eddGRGbo41J5
	CELW8hpjWdMj6h0CtNvqq7jsE9w0ZrOnE0PeDAXeb/OX5ce7Pz9PfeHeUKVj+Lk=
X-Gm-Gg: ASbGncskQ9lebQGb3E5yfFXU05fy+r1PU2IeRxaijCND9ZFFmpp/heKjuuUTicWS8RK
	nxg+m5nfv8Qij4qvf+J6GzYMT6smJqUm9drwbJ2745dy35xU0ZYe5LV45Z8eHFRjAmQbSVCaS6O
	ylbyQ1x4CJegU/ZJFo9xBaolUFYRPqROuk/4vly0uj2NbAcE9FYbXsLtDUL7xx4EKnvuuWwz9p0
	p+qG+3sUL9KwEO3EZ5AEHxVrILfomyCTG8tAF1ZqJdeLGz//HtPZpiZJwQhG1Lhm0YtlYjBKA2G
	KbnQcH9+Jxbnt+5VWwCvr34X9AT0tLQLPFhlmNpLtDJXagePJQ==
X-Google-Smtp-Source: AGHT+IFNmb13ZbZg6r1svxx+lR3YmmJ7/TTTWvUWZuHu1+y5DbctWyFT6u0lXzmMcuDYGTINuAWpuA==
X-Received: by 2002:a05:6a20:d706:b0:1e0:ca1c:8581 with SMTP id adf61e73a8af0-1ee03a8dbb8mr12390695637.21.1739011213669;
        Sat, 08 Feb 2025 02:40:13 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad5460b8d4bsm216325a12.11.2025.02.08.02.40.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Feb 2025 02:40:13 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v3 1/2] perf/dwc_pcie: fix some unreleased resources
Date: Sat,  8 Feb 2025 18:40:01 +0800
Message-Id: <20250208104002.60332-2-cuiyunhui@bytedance.com>
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

Release leaked resources, such as plat_dev and dev_info.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/perf/dwc_pcie_pmu.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index cccecae9823f..19fa2ba8dd67 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -572,8 +572,10 @@ static int dwc_pcie_register_dev(struct pci_dev *pdev)
 		return PTR_ERR(plat_dev);
 
 	dev_info = kzalloc(sizeof(*dev_info), GFP_KERNEL);
-	if (!dev_info)
+	if (!dev_info) {
+		platform_device_unregister(plat_dev);
 		return -ENOMEM;
+	}
 
 	/* Cache platform device to handle pci device hotplug */
 	dev_info->plat_dev = plat_dev;
@@ -730,6 +732,15 @@ static struct platform_driver dwc_pcie_pmu_driver = {
 	.driver = {.name = "dwc_pcie_pmu",},
 };
 
+static void dwc_pcie_cleanup_devices(void)
+{
+	struct dwc_pcie_dev_info *dev_info, *tmp;
+
+	list_for_each_entry_safe(dev_info, tmp, &dwc_pcie_dev_info_head, dev_node) {
+		dwc_pcie_unregister_dev(dev_info);
+	}
+}
+
 static int __init dwc_pcie_pmu_init(void)
 {
 	struct pci_dev *pdev = NULL;
@@ -742,7 +753,7 @@ static int __init dwc_pcie_pmu_init(void)
 		ret = dwc_pcie_register_dev(pdev);
 		if (ret) {
 			pci_dev_put(pdev);
-			return ret;
+			goto err_cleanup;
 		}
 	}
 
@@ -751,35 +762,35 @@ static int __init dwc_pcie_pmu_init(void)
 				      dwc_pcie_pmu_online_cpu,
 				      dwc_pcie_pmu_offline_cpu);
 	if (ret < 0)
-		return ret;
+		goto err_cleanup;
 
 	dwc_pcie_pmu_hp_state = ret;
 
 	ret = platform_driver_register(&dwc_pcie_pmu_driver);
 	if (ret)
-		goto platform_driver_register_err;
+		goto err_remove_cpuhp;
 
 	ret = bus_register_notifier(&pci_bus_type, &dwc_pcie_pmu_nb);
 	if (ret)
-		goto platform_driver_register_err;
+		goto err_unregister_driver;
 	notify = true;
 
 	return 0;
 
-platform_driver_register_err:
+err_unregister_driver:
+	platform_driver_unregister(&dwc_pcie_pmu_driver);
+err_remove_cpuhp:
 	cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
-
+err_cleanup:
+	dwc_pcie_cleanup_devices();
 	return ret;
 }
 
 static void __exit dwc_pcie_pmu_exit(void)
 {
-	struct dwc_pcie_dev_info *dev_info, *tmp;
-
 	if (notify)
 		bus_unregister_notifier(&pci_bus_type, &dwc_pcie_pmu_nb);
-	list_for_each_entry_safe(dev_info, tmp, &dwc_pcie_dev_info_head, dev_node)
-		dwc_pcie_unregister_dev(dev_info);
+	dwc_pcie_cleanup_devices();
 	platform_driver_unregister(&dwc_pcie_pmu_driver);
 	cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
 }
-- 
2.39.2

