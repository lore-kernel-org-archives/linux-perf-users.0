Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33A53033C0;
	Thu, 14 May 2026 01:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720830; cv=none; b=skfsu0F7/VEiWmw9qO0UTHsTM996eXwF/WGjEbrb3rI8O6KHrFETN5iReyVNY4mH1Z0SjYvMFe87/94BcBSS7AED8gFlHAMiOZbJU/uxCRXCtN50JZkPDO7UuKu5BeP2IRhmxiVI1ktGZH4rLbow9PEt51ZxjiJbgE8ZlKAagmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720830; c=relaxed/simple;
	bh=hT79CkZNPWKl8hPdx0A69qTA1cJXmiCV6y9A57SQ0RY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YP8/4QztLmAGFetCjur3hLp1zlT+8okRuem47eQo53VTGUONrSlfXDlrNjIpPqNRJW2W/Z81J9mUgpOMgY33abtoCowGinc+FYb66aO5zLj0f4msrSXqpkC1JyoDOZBFBibRAUT0x88kLoqr4lzHfQIk7Bo+IuLQUP62OzjhiXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=FUxK0EMz; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="FUxK0EMz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778720828; x=1810256828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IX9QoEpvNrJh3pICcnXV5Cre6fGb3z528F+I+RL9AAw=;
  b=FUxK0EMzhcHCmG/ZVF87vaMJ2mcNF+BUZ8UDITSW0r+xf1k2wqU2Svrn
   jpEbdzyse7HpANj0CKxLgzt+uiQAXJHVoyv2jc0/MdpuIcQSGLEQUjDlz
   QCoR5J802gg/OlpsvvltOqMqqKDNUwWWzII5Eu9HLoCMozgBPgVzZhLox
   9GFtmPRwTnApvpFqpZvOAdUxGvyL9EnGtXLcI75G+DSCAkpYkR7iladsv
   uZ6YRiKuIRj34OhjoWQj9GXMMgVZoQV88H91TUPC46YVOoF6OX7p3KqTt
   VQGNpzcq4It/Qd7xIht1zS6eaHXzuBblb9eFkAqBzG5A40avQQPqA+uit
   g==;
X-CSE-ConnectionGUID: Q+vuMa4lQkenMuqKP10BBw==
X-CSE-MsgGUID: wT/z70YOSDe7pCEb6o/Ppw==
X-IronPort-AV: E=Sophos;i="6.23,233,1770595200"; 
   d="scan'208";a="19601021"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 01:07:05 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:29624]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.132:2525] with esmtp (Farcaster)
 id b0abbfae-dd58-4306-a7ca-a01338682a74; Thu, 14 May 2026 01:07:05 +0000 (UTC)
X-Farcaster-Flow-ID: b0abbfae-dd58-4306-a7ca-a01338682a74
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 14 May 2026 01:07:04 +0000
Received: from dev-dsk-sauravsc-1a-8777b848.eu-west-1.amazon.com
 (172.19.118.34) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 14 May 2026
 01:07:02 +0000
From: Saurav Sachidanand <sauravsc@amazon.com>
To: Will Deacon <will@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Besar Wicaksono
	<bwicaksono@nvidia.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, "Andi
 Shyti" <andi.shyti@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<aghayev@amazon.com>, <juew@amazon.com>, Saurav Sachidanand
	<sauravsc@amazon.com>
Subject: [PATCH 2/4] perf: nvidia_t410_cmem_latency: handle PERF_EF_UPDATE in stop
Date: Thu, 14 May 2026 01:06:27 +0000
Message-ID: <20260514010629.76558-2-sauravsc@amazon.com>
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
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

cmem_lat_pmu_stop() does not read the final counter value when called
with PERF_EF_UPDATE. When perf core calls pmu->del() -> pmu->stop()
with PERF_EF_UPDATE, the last counter delta is lost because the event
is marked stopped without reading hardware.

Add the standard PMU stop pattern: bail out if already stopped, call
the event update function when PERF_EF_UPDATE is requested, then mark
the event stopped.

Fixes: 429b7638b2df ("perf: add NVIDIA Tegra410 CPU Memory Latency PMU")
Signed-off-by: Saurav Sachidanand <sauravsc@amazon.com>
---
 drivers/perf/nvidia_t410_cmem_latency_pmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/perf/nvidia_t410_cmem_latency_pmu.c b/drivers/perf/nvidia_t410_cmem_latency_pmu.c
index e27bf31b2b366..c7fa54c7a7c9e 100644
--- a/drivers/perf/nvidia_t410_cmem_latency_pmu.c
+++ b/drivers/perf/nvidia_t410_cmem_latency_pmu.c
@@ -303,6 +303,12 @@ static void cmem_lat_pmu_start(struct perf_event *event, int pmu_flags)
 
 static void cmem_lat_pmu_stop(struct perf_event *event, int pmu_flags)
 {
+	if (event->hw.state & PERF_HES_STOPPED)
+		return;
+
+	if (pmu_flags & PERF_EF_UPDATE)
+		cmem_lat_pmu_event_update(event);
+
 	event->hw.state |= PERF_HES_STOPPED;
 }
 
-- 
2.47.3

