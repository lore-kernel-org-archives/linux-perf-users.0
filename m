Received: from panther.cherry.relay.mailchannels.net (panther.cherry.relay.mailchannels.net [23.83.223.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20EE41F5E9;
	Wed, 15 Jul 2026 19:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784142925; cv=none; b=JarIGhe+pc0jKVxDpAJtz4c26Tcg5kjPJTLWgcM+I+5a2DpIQ+FuOta0d/ScihlcFJgOqFivtHweP9QB0AcH58n+nVZRaOP0YtaSg8RaxMsYKi71D8pCaS3OkYnYgRZEN4Azmwcs7Xp5GWoWmolGe9jmsjyICGY6bNUzgt0zjE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784142925; c=relaxed/simple;
	bh=g83ky1zgvgplv3ssIDH2ql4iG7rAs7m1+JbvtBgqpPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nBtAsyjo9I4vyUK9Xb0qZn3vcZmTeoYqpLxqStZUPGUhWYPhHzLAI0fUqts0QfLZwNLKEckddwsJBJVYYM5o41GkRA0TqzGH/qNgewcCNxPzeZfC9N/apMEtAQWZ38oObKyd2QHIHSauVmdXFvn5gUcVVyriG9tSJRZ5P9aUdcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=p/Is63+/; arc=none smtp.client-ip=23.83.223.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="p/Is63+/"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 343B74023F2;
	Wed, 15 Jul 2026 19:15:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a240.dreamhost.com (trex-green-7.trex.outbound.svc.cluster.local [100.103.92.160])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BA071402E46;
	Wed, 15 Jul 2026 19:15:16 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Unite-Cooing: 7d4f45052c1a235b_1784142917032_1146611786
X-MC-Loop-Signature: 1784142917032:4129896670
X-MC-Ingress-Time: 1784142917032
Received: from pdx1-sub0-mail-a240.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.92.160 (trex/8.0.2);
	Wed, 15 Jul 2026 19:15:17 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a240.dreamhost.com (Postfix) with ESMTPSA id 4h0m8h0wKmz1049;
	Wed, 15 Jul 2026 12:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1784142916;
	bh=fUvUljDXiQTCHD5XN3TgNffnD76cOrXUbGkEXFw2yOQ=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=p/Is63+/l1pASaF4m4Z1c/OfvmyIkCMMu6/lZNj8c95QAlG4i3D1GbJ/HVQvX69zv
	 QUj3FdKWOLEULulVbV3Yu2L/v4nSyW08BeXTwfGVZhz4gXKJAUxlpj0GXAMxdtnt7U
	 Xu/ykbZO//E3K10vd1+Vb+dRaEci3yxp3ILr93W5e8gb0ZO3cS4FQ0nvF1NYcPDWbD
	 4DdJ8Zs6hn/25FXogQrq9ZSv9WHgCP7aderLOGxMe00k/DUxyoj+j5+rrsnaB66p82
	 7bTTQdhvFHhyN2T3LklrbXIWzFU81X2pOAifVg+z6det75vkxlkzKmOMChUe9DSbau
	 rykoISZjJ8jNg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jic23@kernel.org,
	will@kernel.org,
	mark.rutland@arm.com
Cc: harshal.t@samsung.com,
	icheng@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v4 1/3] perf/cxlpmu: Fix 64-bit write to 32-bit HDM filter register
Date: Wed, 15 Jul 2026 12:14:52 -0700
Message-Id: <20260715191454.459673-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260715191454.459673-1-dave@stgolabs.net>
References: <20260715191454.459673-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HDM decoder filter configuration register is 32 bits wide, but the
driver programs it with a 64-bit writeq(). The filter value never
exceeds 32 bits, so the upper half of the write is always zero and
lands in the adjacent Filter ID 1 (Channel/Rank/Bank) configuration
register at offset+4.

Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
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

