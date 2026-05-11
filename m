Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.162.73.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4974D2EEF;
	Mon, 11 May 2026 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.162.73.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778533790; cv=none; b=H4a+DmrH7W3Sq+7nSzumRT7M4yvXXVtP6oI0KtqSOCmSlpgSwWcWOxPBuhkNIN4dqWEWYqcbjHGJY3zcAXcmannBircML6YOOMmkSffInl28/S+x8ZTgkCDxM5GHFR8qhtvySoPTI4Sa+1zDYuUBmLUBa4KxZIv71YjE868sZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778533790; c=relaxed/simple;
	bh=m4oeVoi9yXydsdeVUgDf9ed2Xs1PWGferVIU387Scf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGApukmq+qZqNG9sF7BWAhNZI0N0J5t6U9aeyKaY9cnlZEEqut2wb6J6EjiXS6i7WDMjwpiyanBH8oJ91aKP57/z2xfDF2aBcG8jtJ93FmsGRrPfo0Rem6xts+0Bmytb+StKMYOb6jUfZvtxZkLFCV5rDCmjy16OgAg2j0U+ToQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=L4Tx/HMs; arc=none smtp.client-ip=35.162.73.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="L4Tx/HMs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778533789; x=1810069789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TZEkpYaV8znQ3xP6RcqHMvzTHuEHWppo4gEe37Xawpw=;
  b=L4Tx/HMsw8v6CDyf5Tc6IU0zw080TWRdXbRH62H4dS26LaK76fCVv9k7
   uTGGKnT09cvbAaKOSemG00iaiAab1y5Yc1yRGUEVgkw0MD94qCyPW/GBC
   i+uPsk9rNstNb5VN47KNsbAFxZove8ybfbnf7MnFOK3oY/PvSDc4KE25Q
   lkC5N0x3hNx2gDxroOPMlHBRyctHnKOkLHKvNX0v2l3zDFvAXBI1XB1XQ
   c7ex+vMUH1/Jz5BGGZpNDD8/R/x+hFS+VWp6H3YbZQOFjP1EaPJJDQNke
   DX/hCHSvBdPybH6NW/VC0kU+Jn3qPlDgkuY+7gmWb8sO8tw/OVB4RwBVC
   g==;
X-CSE-ConnectionGUID: /cVL3ocdQ+eex6TpEqtjuA==
X-CSE-MsgGUID: 04R2l2iSQj+ycRlsaE6V1w==
X-IronPort-AV: E=Sophos;i="6.23,229,1770595200"; 
   d="scan'208";a="19192945"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 21:09:46 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:26317]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.38:2525] with esmtp (Farcaster)
 id 615b8aea-6f92-4272-a246-4731c55e68e5; Mon, 11 May 2026 21:09:46 +0000 (UTC)
X-Farcaster-Flow-ID: 615b8aea-6f92-4272-a246-4731c55e68e5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 11 May 2026 21:09:46 +0000
Received: from dev-dsk-sauravsc-1a-8777b848.eu-west-1.amazon.com
 (172.19.118.34) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 11 May 2026
 21:09:44 +0000
From: Saurav Sachidanand <sauravsc@amazon.com>
To: Will Deacon <will@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Besar Wicaksono
	<bwicaksono@nvidia.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <aghayev@amazon.com>, <juew@amazon.com>,
	Saurav Sachidanand <sauravsc@amazon.com>
Subject: [PATCH 3/3] perf/arm_cspmu: nvidia: fix BDF calculation examples in PCIE PMU docs
Date: Mon, 11 May 2026 21:09:05 +0000
Message-ID: <20260511210905.91917-2-sauravsc@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511210905.91917-1-sauravsc@amazon.com>
References: <20260511210905.91917-1-sauravsc@amazon.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The BDF hex values in the documentation examples are inconsistent with
the stated formula (bus << 8) + (device << 3) + (function):

  - BDF 27:01.1: documented as 0x2781, correct value is 0x2709
    (0x27 << 8) + (0x01 << 3) + 0x1 = 0x2709
  - BDF 01:01.0: documented as 0x0180, correct value is 0x0108
    (0x01 << 8) + (0x01 << 3) + 0x0 = 0x0108

It appears (device << 7) was used instead of (device << 3) when
computing the example values.

Fixes: bf585ba14726 ("perf/arm_cspmu: nvidia: Add Tegra410 PCIE PMU")
Signed-off-by: Saurav Sachidanand <sauravsc@amazon.com>
---
 Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst b/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
index 0656223b61d47..24f0e801d7b80 100644
--- a/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
+++ b/Documentation/admin-guide/perf/nvidia-tegra410-pmu.rst
@@ -170,7 +170,7 @@ The list of event filters:
     devices in root port 0 to 3.
   * src_bdf: the BDF that will be monitored. This is a 16-bit value that
     follows formula: (bus << 8) + (device << 3) + (function). For example, the
-    value of BDF 27:01.1 is 0x2781.
+    value of BDF 27:01.1 is 0x2709.
   * src_bdf_en: enable the BDF filter. If this is set, the BDF filter value in
     "src_bdf" is used to filter the traffic.
 
@@ -215,7 +215,7 @@ Example usage:
 * Count event id 0x4 from BDF 01:01.0 of PCIE RC-4 on socket 0 targeting all
   destinations::
 
-    perf stat -a -e nvidia_pcie_pmu_0_rc_4/event=0x4,src_bdf=0x0180,src_bdf_en=0x1/
+    perf stat -a -e nvidia_pcie_pmu_0_rc_4/event=0x4,src_bdf=0x0108,src_bdf_en=0x1/
 
 .. _NVIDIA_T410_PCIE_PMU_RC_Mapping_Section:
 
-- 
2.47.3

