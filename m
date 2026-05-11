Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13179386557;
	Mon, 11 May 2026 21:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778533763; cv=none; b=G1AUe6cn1lVyqvyXvzm0teVOGGM7gYuE2fyJtGmFFnHq3EkbWG54gHD2tJOf/nJb4YPtQD0Y/lFwou5bL7mY3G/cU5NNqx6e4S1bRW/LwRkvzbs3y6sx+WNIdC5763ocfV95ldliodR195wbanuQ2HZV4rIzQkhjlmCh7Ep90qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778533763; c=relaxed/simple;
	bh=v5MvYDkeO68us6SvucH+i6b4uW8WAGgftEUcPM9JZ3E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H/7ocv9aKuLnqJoYX+hMKeGiw5JYf6Ja+tGGNFYgfjnnVDJt7aFCUm+RlXhWuT8vgvX33D9q4Do1yWJozu1Ji+3Ztuomw6uMeP0UF87L1VzHsILL2piUBn191G9JjMKKsRrDuRixVAHJRlK5zb2Lukiz82aCnFPNfR9NjgSx1BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=O4fZ4Etr; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="O4fZ4Etr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778533762; x=1810069762;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gmBNcFXL4SEZ0SStYLpRW1m4H7oxUGUfa1bhU/oNHVk=;
  b=O4fZ4EtrZBqK6OLQDBDJjnknriBuUgcCD1XL+hqRLWyaeApRM0f8vISQ
   x4WfPE24B4R8k7KOdJT4bNtMwlOUbi4eDm2m69MAdg7W6f4dUszCNS81D
   zNAw6RJZ2PolOYTpK5yLlkPrz9Gqt8/luvp5dccHtkggP7IaXMNGXR97K
   qJhwNkn+0eQLKmfYMdLTUioFZo9XjiD/IpNCX7x/kOMx+/rPkHdaOWq8C
   Cxmi86oKjj2Q10mH1gY2EIMsnFb3vd5r/Hm6/VvbmFccNimH8EuF1wlnO
   S1g0dGIKscNT9OXOgly6pLPh7ttsvISP3FtACJ7V11WTWcnmJzhMm7eGM
   w==;
X-CSE-ConnectionGUID: 0zVo/EuXTmWAseOu5UCThQ==
X-CSE-MsgGUID: 8gfJTadJQ9OgyYyQ9whUCw==
X-IronPort-AV: E=Sophos;i="6.23,229,1770595200"; 
   d="scan'208";a="18904877"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 21:09:19 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:19334]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.175:2525] with esmtp (Farcaster)
 id 57478e7e-fe0b-4b36-a475-490afc8c63da; Mon, 11 May 2026 21:09:19 +0000 (UTC)
X-Farcaster-Flow-ID: 57478e7e-fe0b-4b36-a475-490afc8c63da
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 11 May 2026 21:09:19 +0000
Received: from dev-dsk-sauravsc-1a-8777b848.eu-west-1.amazon.com
 (172.19.118.34) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 11 May 2026
 21:09:17 +0000
From: Saurav Sachidanand <sauravsc@amazon.com>
To: Will Deacon <will@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Besar Wicaksono
	<bwicaksono@nvidia.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <aghayev@amazon.com>, <juew@amazon.com>,
	Saurav Sachidanand <sauravsc@amazon.com>
Subject: [PATCH 2/3] perf/arm_cspmu: nvidia: handle empty resource list in PCIE-TGT init
Date: Mon, 11 May 2026 21:09:04 +0000
Message-ID: <20260511210905.91917-1-sauravsc@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

When acpi_dev_get_memory_resources() returns success but the resource
list is empty (rentry is NULL), addr_filter_reg remains NULL from
devm_kzalloc. Since IS_ERR(NULL) is false, the function proceeds
without error and later dereferences the NULL pointer in
pcie_tgt_pmu_config_addr_filter().

Set addr_filter_reg to ERR_PTR(-ENODEV) when the resource list is
empty so the existing IS_ERR check catches it.

Fixes: 3dd73022306b ("perf/arm_cspmu: nvidia: Add Tegra410 PCIE-TGT PMU")
Signed-off-by: Saurav Sachidanand <sauravsc@amazon.com>
---
 drivers/perf/arm_cspmu/nvidia_cspmu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
index bac83e424d6dc..bae722e263e91 100644
--- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
+++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
@@ -555,14 +555,16 @@ static int pcie_tgt_init_data(struct arm_cspmu *cspmu)
 
 	rentry = list_first_entry_or_null(
 		&resource_list, struct resource_entry, node);
-	if (rentry) {
+	if (rentry)
 		data->addr_filter_reg = devm_ioremap_resource(dev, rentry->res);
-		ret = 0;
-	}
+	else
+		data->addr_filter_reg = ERR_PTR(-ENODEV);
 
 	if (IS_ERR(data->addr_filter_reg)) {
 		dev_err(dev, "failed to get address filter resource\n");
 		ret = PTR_ERR(data->addr_filter_reg);
+	} else {
+		ret = 0;
 	}
 
 	acpi_dev_free_resource_list(&resource_list);
-- 
2.47.3

