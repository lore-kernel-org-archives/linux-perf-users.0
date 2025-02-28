Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E220219FC
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 03:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740712681; cv=none; b=oqo1lj0tiqFLbImafIKpk2ncH24DWM/IAC4LHdM8An8+hiQjJvfodxyGx7v6r+Nv6RzV7dUGdnWX1Wo0d7/12K1PgyibBVkEj0bFnYRZUV1MxYS0/p0tnaZKa1wbQgRXeakbnVL0X2NBaAex0cNGadAoHyQ4bhtfnjehU5dkMxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740712681; c=relaxed/simple;
	bh=RuEXvmpiygzoED9NlkWiOzqSFdoUVyiQRUE+ECTuUsM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rSBbWi2Fu1CNRcB5Ul/XvjniqT+mxdCqXyrEP2YvbBO1U8QisT92Jpc4Xr8F74qqDi4cnAtdFUfBm3njnfm3eJIFmY37Uy8FjgwSTC9qsFE1XmetYPr/QAPt/1fvTqi/852O2vOmx835goYeohQb48q5od7i9LnYdppH+ANJEoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aHRVnh1A; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aHRVnh1A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=EPdmf
	90JuCymn+ahj95Uls4If8SijTx7xRJsPqDcGQM=; b=aHRVnh1AWOvjXyP3tfUux
	rzDZBoTbQFunSCbfnyaDy44RSyDQKLCAsU04HDno6IYNiilP1I64qBSf4YBTUR4k
	hfFVGoqFwaCdRhyxIeNSKBT6UibQ/5gjgHdiMNCGJ3CaqzsxD6RYhFSr8Q/0SWSJ
	I5WXdi6VUh9hDtbUMvHytI=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnj7i6KsFnM3VIPA--.9666S4;
	Fri, 28 Feb 2025 11:17:36 +0800 (CST)
From: Yuanjun Gong <ruc_gongyuanjun@163.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-perf-users@vger.kernel.org
Cc: Yuanjun Gong <ruc_gongyuanjun@163.com>
Subject: [PATCH 1/1] drivers/perf: Add check to ida_alloc()
Date: Fri, 28 Feb 2025 11:17:12 +0800
Message-Id: <20250228031712.3743224-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnj7i6KsFnM3VIPA--.9666S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrWkuw15JFy8CFyDJr1xGrg_yoWDZrbEk3
	9xuFyxWF15Gr1DKF1xJ34Syryakrn09FZ7XrnxKanavFy5Ww4jg3y8ArnxCwsrW3yxCF1D
	CayDCF43Cr47GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRWbyAJUUUUU==
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/1tbiJwcB5WfAnsVahQACsl

Check the return value of ida_alloc in case it fails.

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
---
 drivers/perf/fsl_imx9_ddr_perf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 843f163e6c33..143103331edc 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -790,6 +790,11 @@ static int ddr_perf_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pmu);
 
 	pmu->id = ida_alloc(&ddr_ida, GFP_KERNEL);
+	if (!pmu->id) {
+		ret = -ENOMEM;
+		goto ida_alloc_err;
+	}
+
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, DDR_PERF_DEV_NAME "%d", pmu->id);
 	if (!name) {
 		ret = -ENOMEM;
@@ -847,6 +852,7 @@ static int ddr_perf_probe(struct platform_device *pdev)
 cpuhp_state_err:
 format_string_err:
 	ida_free(&ddr_ida, pmu->id);
+ida_alloc_err:
 	dev_warn(&pdev->dev, "i.MX9 DDR Perf PMU failed (%d), disabled\n", ret);
 	return ret;
 }
-- 
2.25.1

