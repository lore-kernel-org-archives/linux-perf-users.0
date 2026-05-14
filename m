Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419D11C5F39;
	Thu, 14 May 2026 01:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720884; cv=none; b=hqsdEA0we/r4c43YOtjIOFVYMkNpLKYDFqDvz0/HVAnbXWmMlE/3700+tm8OIhqJ0aEGX8eLhH+AN+54Zzw2AakeQztUggSY7apmIwzdMeSF7B9l2d23DirAHJ3yCy5WjpllPLyjtf1SYYEzmoQExOGeJ24gxm+3Fv5qox+Lo0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720884; c=relaxed/simple;
	bh=7QPPQtW5VqHd/lpoCaot16Z6mZXfn/BerdKUR1HdOio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2nfX++FZfWndPfjhGSO3xyzkDrpBZWecSdRXE9Ck7cLfXMGFKrJ7VbHBEBnEMX9Ug8V7COD2RX9pJAJ8d5hFC/tK+M/v+QwyVHcpXhTPphlfnQ+/68NP5SSBkLGlzTLCbZtesX2nDc7v763VMa4nYcX52ONFq7ZJe3VUmKYjyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=nR7TXSAA; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="nR7TXSAA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778720883; x=1810256883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cW/OZQoqy4f/UkhCnx3pnnSjrSTqrJ/WVsrvI7KDwF0=;
  b=nR7TXSAANox9vzsMwXD5dZuwqx0fYnjpxvI6fCtUpQteer+0nKwSsdCH
   v0hQJJ0RYi6CyC+vPYKO9CzacMsJVUCETtt7kDZ70T2ZeTi4/tO7qMZhL
   yjRCSe5iEQK7+joUvwoEmxIWUXjW4WCDg2EWvVI9CGmimZNI7MfmBYXUq
   5H83klDz3ClypDuSVDVPP7Ve1KECjFm5XiHpuFSCJU4+/BPjPGsosUzI9
   rG2tE0PMs++vochOJn1vgbMzHltKexzLYr6L6uhF8Exg4SNZaLsaTEUmR
   D6xS15w7eIvupcRscqwvl/4aA2wH/gaq9kYDttWg9wekXFd7NzCYmCASO
   A==;
X-CSE-ConnectionGUID: MFGcm6D+QdSByVHlqNAcFg==
X-CSE-MsgGUID: ODrRSGTpQ7i8BvTXcwWNlA==
X-IronPort-AV: E=Sophos;i="6.23,233,1770595200"; 
   d="scan'208";a="19469806"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 01:08:00 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:29459]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.21:2525] with esmtp (Farcaster)
 id ef6c1e45-134f-4e23-bfcc-be8e3fe3fcf7; Thu, 14 May 2026 01:07:59 +0000 (UTC)
X-Farcaster-Flow-ID: ef6c1e45-134f-4e23-bfcc-be8e3fe3fcf7
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 14 May 2026 01:07:59 +0000
Received: from dev-dsk-sauravsc-1a-8777b848.eu-west-1.amazon.com
 (172.19.118.34) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 14 May 2026
 01:07:57 +0000
From: Saurav Sachidanand <sauravsc@amazon.com>
To: Will Deacon <will@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Besar Wicaksono
	<bwicaksono@nvidia.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, "Andi
 Shyti" <andi.shyti@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<aghayev@amazon.com>, <juew@amazon.com>, Saurav Sachidanand
	<sauravsc@amazon.com>
Subject: [PATCH 4/4] perf: nvidia_t410_c2c: handle PERF_EF_UPDATE in stop
Date: Thu, 14 May 2026 01:06:29 +0000
Message-ID: <20260514010629.76558-4-sauravsc@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260514010629.76558-1-sauravsc@amazon.com>
References: <20260514010629.76558-1-sauravsc@amazon.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

nv_c2c_pmu_stop() does not read the final counter value when called
with PERF_EF_UPDATE. The last counter delta is lost when perf core
removes the event.

Add the standard PMU stop pattern: bail out if already stopped, call
nv_c2c_pmu_event_update() when PERF_EF_UPDATE is requested, then mark
the event stopped.

Fixes: 2f89b7f78c50 ("perf: add NVIDIA Tegra410 C2C PMU")
Signed-off-by: Saurav Sachidanand <sauravsc@amazon.com>
---
 drivers/perf/nvidia_t410_c2c_pmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/perf/nvidia_t410_c2c_pmu.c b/drivers/perf/nvidia_t410_c2c_pmu.c
index 662fa1bc833a5..39d0e661e4c5c 100644
--- a/drivers/perf/nvidia_t410_c2c_pmu.c
+++ b/drivers/perf/nvidia_t410_c2c_pmu.c
@@ -394,6 +394,12 @@ static void nv_c2c_pmu_start(struct perf_event *event, int pmu_flags)
 
 static void nv_c2c_pmu_stop(struct perf_event *event, int pmu_flags)
 {
+	if (event->hw.state & PERF_HES_STOPPED)
+		return;
+
+	if (pmu_flags & PERF_EF_UPDATE)
+		nv_c2c_pmu_event_update(event);
+
 	event->hw.state |= PERF_HES_STOPPED;
 }
 
-- 
2.47.3

