Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C330B30216D;
	Thu, 14 May 2026 01:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720803; cv=none; b=bwAOtX756gRFx9uI4Vb30RVeJToghMy3ng3pL6wS7ao2THMN8IZl/2K+2ueasHtQiAw2YALippGjc2S0w3Xph2874/2FoTdS9lOlKuhokRSZxXbEcf59+LtHGZP6iJkH0sshSWE38OIL+REi8bkRATsE0k64U/2kN2wOV0JAUQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720803; c=relaxed/simple;
	bh=heQrYtHs+xSBYC2c4Ld1bSO9ASDm2pWUYqnAir/yAEg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TE93ebUfERFc2m5w2d7jViVdTJI2DSaNN9EWLZ6zNcNP4jO7/3jWrYZusknVc90Jnk7WfjgQxrtm85T1t45SOmmNc3EIeXXLetBR9174E1eJdmZlNQ8efM7dYRfkmhxupjvdLBa1tChcQ3JuNeQw/zENTFBH7l/WNKBzt20PydU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Cc8A0AwK; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Cc8A0AwK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778720802; x=1810256802;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3WSKMZ6pbPJH1DIZ+mtEEVPgrpweJMBlY9xPQY3jiKE=;
  b=Cc8A0AwKo+5ikLeAyci8tEDSw/FwhDiyd3wZ9jnGYS1HlhjYsyZB5zKF
   OELLRKCb+rS5IdjKIOo+Zp6GPgGdk0RdB8rOJjWopaMZQ6jxB6KmmCmXn
   B3T/AjBrX3PmAccd8sL2IYyC+r92S8sQDqgDZ6Ai93WEn8tb5/SlZp/q+
   vWpFi0Tcv3Hp3cU2CKn4vBPvw2NO262Dxg/DqjlNySaFKxun65O7jGS+I
   t1TI9lE0x0oY4gV7z7tERYYmDtfBxKsgk6bXUSeOXKsUrb1bf83R4POZv
   TAr9zTuV3QbULUGWQ6rXvT3Wz+oYmqddIoRNzGZ144NotyJsFu3EYy9qR
   A==;
X-CSE-ConnectionGUID: s32lekjVSKuk6Aviy4jPMg==
X-CSE-MsgGUID: xrCNtYbzSHG96HDzj86/rQ==
X-IronPort-AV: E=Sophos;i="6.23,233,1770595200"; 
   d="scan'208";a="19613318"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 01:06:39 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:11666]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.30:2525] with esmtp (Farcaster)
 id 1fb0d0e1-11e2-41a5-822f-cf704c043d46; Thu, 14 May 2026 01:06:39 +0000 (UTC)
X-Farcaster-Flow-ID: 1fb0d0e1-11e2-41a5-822f-cf704c043d46
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 14 May 2026 01:06:39 +0000
Received: from dev-dsk-sauravsc-1a-8777b848.eu-west-1.amazon.com
 (172.19.118.34) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 14 May 2026
 01:06:37 +0000
From: Saurav Sachidanand <sauravsc@amazon.com>
To: Will Deacon <will@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Besar Wicaksono
	<bwicaksono@nvidia.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, "Andi
 Shyti" <andi.shyti@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<aghayev@amazon.com>, <juew@amazon.com>, Saurav Sachidanand
	<sauravsc@amazon.com>
Subject: [PATCH 1/4] perf: nvidia_t410_cmem_latency: fix cpuhp state leak on init failure
Date: Thu, 14 May 2026 01:06:26 +0000
Message-ID: <20260514010629.76558-1-sauravsc@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC004.ant.amazon.com (10.13.139.229) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

If platform_driver_register() fails, the cpuhp multi-state registered
by cpuhp_setup_state_multi() is never cleaned up. Add
cpuhp_remove_multi_state() on the error path, mirroring the cleanup
in cmem_lat_pmu_exit().

Fixes: 429b7638b2df ("perf: add NVIDIA Tegra410 CPU Memory Latency PMU")
Signed-off-by: Saurav Sachidanand <sauravsc@amazon.com>
---
 drivers/perf/nvidia_t410_cmem_latency_pmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/nvidia_t410_cmem_latency_pmu.c b/drivers/perf/nvidia_t410_cmem_latency_pmu.c
index acb8f5571522c..e27bf31b2b366 100644
--- a/drivers/perf/nvidia_t410_cmem_latency_pmu.c
+++ b/drivers/perf/nvidia_t410_cmem_latency_pmu.c
@@ -719,7 +719,11 @@ static int __init cmem_lat_pmu_init(void)
 
 	cmem_lat_pmu_cpuhp_state = ret;
 
-	return platform_driver_register(&cmem_lat_pmu_driver);
+	ret = platform_driver_register(&cmem_lat_pmu_driver);
+	if (ret)
+		cpuhp_remove_multi_state(cmem_lat_pmu_cpuhp_state);
+
+	return ret;
 }
 
 static void __exit cmem_lat_pmu_exit(void)
-- 
2.47.3

