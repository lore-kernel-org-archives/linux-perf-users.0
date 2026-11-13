Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558884;
	b=FvwajmlMklnkRtAkoDRShXgIPI8QDcVv5l5oazC4feUkZgaAhcq/H51EwOfRk55EvKsf
	 8r/k6cUkbNsV4F/OWhNY+WS1t4w4noouD+ssbycrx9Hhh28u421U4LRVoc/99BbxpnLNm
	 jXJ+bIiY0TD56czG1QTwjyMfyKiHJvI+zWzT2PtLlAiuIexvTnU3PGGsfMPyqB1+8yAvr
	 5kDLsbKKueqHPmmqrw5cpaTYx44N2cY4D/n5zPYZ0sdcNwbYZmSITCDSulp9VDVKYZq3W
	 YkMWTX8vsmD8OB5neXHzNwFnLBMSE5CIAzmZGi9BZs/mOAuDWuHgqjRqxfP2pIMkaeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558884;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=tqmxNmR9sdF/mCrxZwXbkrGr4U8K+GGx99H7vvL2bZc=;
	b=HK3NzN5PPFrf/wGhXSr5nOX+QAyTGckyOccXGP9oanDpZXm3mFYS1q7/gQSOI5BuBCuT
	 hMBGQqTi37auv3rPwKp8iXoeVrZdixq+mbLxJeAzNJ+roUliUKpAnlDo3vxQLUgzHI+Mg
	 Us/G+9v+ZS2k+CowTMQ+zYXt07WvEJMQ5AIi4RaXcoytxM9xQ5Ltmm5otnNyO4INa2cCg
	 wMiXfKiGc+xtxES8P0SiNmshpqXGlFXQsQXhWGa7cAzVv8l4+vtAAE5ZSlzeKtDMJyzI2
	 DLfxxOm7YegwIqKMcFQ0vy+Jqced2WZs+pXiNNxrKk2jVa44rfsJ7dth/Txt0Uurahg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Cj8URl5m;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C54606A88A;
	Fri, 13 Nov 2026 08:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68C54606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Cj8URl5m
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jQrCj0nxLz4yjSx;
	Fri, 13 Nov 2026 16:34:41 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794558881;
	bh=EeJgTp3gDNk3CHuo2TOVqLIjmK59AK/kiIZbXuxrLXg=;
	h=Date:From:To:Cc:Subject;
	b=Cj8URl5m94I/ndWuQmwwyYZkWkHp8erBql/yqJJbIhDewfd9d7gClig7bZLOEmsGG
	 tlLDTrEHUTBl6LBmiHTHHNzXMMMLv9G5tPLa1zHWPOkF2imAUu1UuyYcY0uc1c+dLj
	 hufj56JXi5qlcgFouso6HpVt8sdhQpjKVxX1w2D6CB8OD0FOa86jxOHr1iDugl1vIz
	 eNiV062BodjZqH6esYrBCViUW1q/GZdTBcSPMUF2E5PjjD7b+Pa+CD8Qa+/WfAtoDR
	 BVIk7LUPX3qND7lCrvVa+MpFIG2DZGiGjH1R+KXPxG9sCa39woC1sheKqNkLJPhVKk
	 n8ltGpB4jVFmA==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6AD8YRLU065935;
	Fri, 13 Nov 2026 16:34:27 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 13 Nov 2026 16:34:30 +0800 (CST)
X-Zmail-TransId: 2afb6af6cb967e2-719c9
X-Mailer: Zmail v1.0
Message-ID: <20261113163430071vxN-ZVM94Ib9cZ18HMyHa@zte.com.cn>
Date: Fri, 13 Nov 2026 16:34:30 +0800 (CST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <will@kernel.org>, <mark.rutland@arm.com>
Cc: <pawel.moll@arm.com>, <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhang.run@zte.com.cn>, <he.qifeng1@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBwZXJmL2FybS1jY246IFNldCB1cCB0aGUgRFQgYmFzZSBiZWZvcmUgcmVxdWVzdGluZyB0aGUgSVJR?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6AD8YRLU065935
X-TLS: YES
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 13 Nov 2026 16:34:41 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF6CBA1.000/4jQrCj0nxLz4yjSx

From: Qifeng He <he.qifeng1@zte.com.cn>

arm_ccn_probe() requests the CCN interrupt before arm_ccn_pmu_init()
has initialised ccn->dt.base.  The interrupt is level-triggered, so a
pending overflow (for example one left behind by a previous kernel
across kexec) is delivered as soon as devm_request_irq() unmasks it.
arm_ccn_pmu_overflow_handler() then dereferences the NULL dt->base:

  NULL pointer dereference at virtual address 0x198
  pc : arm_ccn_pmu_overflow_handler+0x20
  lr : arm_ccn_irq_handler+0x13c

Set up dt->base as soon as the CCN MN block is mapped, before the
interrupt can be requested.  The rest of the DT/PMU setup stays in
arm_ccn_pmu_init(); before the PMU is registered the handler only
needs dt->base and the zero-initialised pmu_counters array, so it is
safe to take the interrupt during that window.

Fixes: a33b0daab73a ("bus: ARM CCN PMU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Qifeng He <he.qifeng1@zte.com.cn>
Signed-off-by: Shengming Hu <hu.shengming@zte.com.cn>
---
 drivers/perf/arm-ccn.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 0c69165e0041..3cbdda843b59 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -1213,8 +1213,10 @@ static int arm_ccn_pmu_init(struct arm_ccn *ccn)
 	char *name;
 	int err;

-	/* Initialize DT subsystem */
-	ccn->dt.base = ccn->base + CCN_REGION_SIZE;
+	/*
+	 * Initialize the DT subsystem; dt.base was set up in
+	 * arm_ccn_probe() before the IRQ was requested.
+	 */
 	spin_lock_init(&ccn->dt.config_lock);
 	writel(CCN_DT_PMOVSR_CLR__MASK, ccn->dt.base + CCN_DT_PMOVSR_CLR);
 	writel(CCN_DT_CTL__DT_EN, ccn->dt.base + CCN_DT_CTL);
@@ -1463,6 +1465,14 @@ static int arm_ccn_probe(struct platform_device *pdev)
 	if (IS_ERR(ccn->base))
 		return PTR_ERR(ccn->base);

+	/*
+	 * The CCN interrupt is level-triggered and may already be pending,
+	 * e.g. an overflow left by a previous kernel across kexec.  The
+	 * handler can run as soon as devm_request_irq() below installs it,
+	 * and it dereferences dt->base, so set it up before that.
+	 */
+	ccn->dt.base = ccn->base + CCN_REGION_SIZE;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
-- 
2.25.1
