Received: from dog.birch.relay.mailchannels.net (dog.birch.relay.mailchannels.net [23.83.209.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5BB86334;
	Mon, 13 Jul 2026 06:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923086; cv=none; b=TU3fK9TnwyP0nQoKU/FL/S/MQACXCKhT9EJ/7n/LZfvr9ztCf2SbXuHqBZYPNptg/FJZE9r8jzSHxNW9TjDPIeVjueYsbdpJNMpiO383IKuMSVUqJQMU7D8amf7WEXhNFErYjCpvgEOSBYVnP0P1XUdBprfbyJ+a3d1XN90wb+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923086; c=relaxed/simple;
	bh=kgQWWXMPI4aQ6tvIA16dVo8sJ8V0hAyTtpcVoqRqri4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cHWFdMznZYV7eNZLmtJ3qf2OWelFLcevoaVAWB70JWEUoTv8ybxpPttJH88FD4EhW4wb4JxHT1FLaIGDcA5JA+KkZ+QxXfXaW9Z2t52x2yrySzATmbd7SPA3aphuDw91y87q6qgvPspDr3bxOP8pYpcfjetd3+ZcU7PJz/caAcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=B8cZ0d6m; arc=none smtp.client-ip=23.83.209.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="B8cZ0d6m"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8426980269F;
	Mon, 13 Jul 2026 06:11:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a229.dreamhost.com (100-98-253-75.trex-nlb.outbound.svc.cluster.local [100.98.253.75])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id F2B1E802517;
	Mon, 13 Jul 2026 06:11:18 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Little-Supply: 51a7010d12a37275_1783923079407_3000629816
X-MC-Loop-Signature: 1783923079406:2023346899
X-MC-Ingress-Time: 1783923079406
Received: from pdx1-sub0-mail-a229.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.253.75 (trex/8.0.2);
	Mon, 13 Jul 2026 06:11:19 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a229.dreamhost.com (Postfix) with ESMTPSA id 4gzBs22yx7zTR;
	Sun, 12 Jul 2026 23:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1783923078;
	bh=cW/jso7Gtty1jbyT6UohhE0vX+8xQd1CbLQmaQoIFOc=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=B8cZ0d6m+EM1yjEeaM5oxaxurCaOoUzwddoVZVXiRuEdJs2C8lBGqYYIu6IcM/P7W
	 YSSkRd3P3P3ek5kDva/mK617Qn49BQErlxYGPs3QXJW5nkCqimk/3v7eLEaOEtvkoQ
	 p5nwFpqFFmzc07Sd4hZpUX0iKsgT1ZMfk4Eibu4wYXdz7CXaw++MCMFjvoY86NbwTX
	 w4reNgku0Wav3mADH2BmnyXA+qmqbXOKvIfTadHG/BpJM4IQTbtGnKOzJr4nJIv0E2
	 B+RSg+stB4sgPUlpKKZ1mrfTw2VzYVCdwpwzpxCP7MTl81f+8ykkex7fce/VR9NOCb
	 UwuWofxpX+FiQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com
Cc: harshal.t@samsung.com,
	icheng@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v3 1/3] perf/cxlpmu: Fix 64-bit write to 32-bit HDM filter register
Date: Sun, 12 Jul 2026 23:11:10 -0700
Message-Id: <20260713061112.105419-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260713061112.105419-1-dave@stgolabs.net>
References: <20260713061112.105419-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HDM decoder filter configuration register is 32 bits wide, but the
driver programs it with a 64-bit writeq(). The upper half of the write
is always zero and lands in the adjacent Filter ID 1 (Channel/Rank/Bank)
configuration register at offset+4.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/perf/cxl_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 68a54d97d2a8..39b46550a510 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -635,7 +635,7 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
 			cfg = cxl_pmu_config2_get_hdm_decoder(event);
 		else
 			cfg = GENMASK(31, 0); /* No filtering if 0xFFFF_FFFF */
-		writeq(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
+		writel(cfg, base + CXL_PMU_FILTER_CFG_REG(hwc->idx, 0));
 	}
 
 	cfg = readq(base + CXL_PMU_COUNTER_CFG_REG(hwc->idx));
-- 
2.39.5

