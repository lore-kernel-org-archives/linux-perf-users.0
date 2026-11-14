Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794699451;
	b=DHppRlnPbLWngA/QmDBTz5qKf77LW/cOXY4LxOsGBoAntLmNHWOpi6Nc1G7FnB3ZhUoQ
	 D/PbechCVuV/45jifRmarCLO5k3R1xIwyNqRSLMKE/Wz7pwPUmPZPkqaSeNv0ABn6AlCw
	 ZD29NCuU/B+7qLwByqKygAXBoB2/V3pMGkgu3hy9UME4NKr13uZDGCI3a9AHmQ1hd3zay
	 9omnQxxcghb+XbswIL2HDTY7eZRw9ZbY9NytrOZQEnJl6DJthy5MhPa4jCK94LHXnkdQt
	 GW/hK/PpaAAS4Fi/l9aOWLPOQg/kYRTq8xj7S/GeSUWjUjPFEfPSnitdnB7GOPRcwfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794699451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=a/wS6Yxk7+tECj0s54STfUWVzey+C0tieK8m7kinAtY=;
	b=UgEevBTHryhat6RCuBKsvX1QMgvPdKJwnjYZ/XcijHTLxOxeo7m1w3r0xZfr0YA6ZA4q
	 rOJmV4IuipRMLQWuSiSktBTGCoqo+HYsSqggg5pavwFrkruw6OrWSVABdKhXdGhcJH5Ga
	 sl4ImiYBmv3bN5dMRLO1seAj8dz5QQGygnzweXHxNBzGsn8Nmd/Pp9c7EqSSpr35qfbch
	 n3sxq7lkeEwkIov3dIgvPBFJNbKrLfA/Ddqy7H6PSsr6Vga7cQq9acMuxxxnHsHpleQWn
	 9AP1UNU8ev/Mm90KP4sPueRC9Q//Q2PW+MYqL8UtdedCvpL5k/H5i9HMypouJ7ku9bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sGGj8G39;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32FA606A891
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 23:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E32FA606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sGGj8G39
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b68e59ab33so2476095b3a.2
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 15:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794699450; x=1795304250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a/wS6Yxk7+tECj0s54STfUWVzey+C0tieK8m7kinAtY=;
        b=sGGj8G399ZF31uILhnt5fqpBTS93oUlFlXCu9ne5PNel6hESS6eCg5Cx7fn3ZCBlFe
         oxdxc4STyzHOiUpheFiC2TsLQ/nQFezbJ1bVf98u+8/TdF8CZ4oolWnvdTaOjrpMgC9O
         mX+erfavcN+ALosfLrNvHxOUVX5hDGRCxrf2DYFN5vlwSqM6bz/bibjBYxVL4O9FO7Os
         kQqE/sTCymdhbLvav1w58eVJwr1Ak+cV4ilPGNYlgYUkVbt/72MvEq71q0AQ2uU5qKVQ
         bzJCsunwS+EYxAF4OdP66Q7clln3J7cD6t7FaUmp4sPiEadxRjJ7+PT1YCpvPhgNxRhs
         AWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794699450; x=1795304250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a/wS6Yxk7+tECj0s54STfUWVzey+C0tieK8m7kinAtY=;
        b=WElxSb3AMnf13QCVjYWcVRRGTfxoMu5qvHS5lx2J0jSXd6UjnclY/rdShjj3M44fli
         Ug2VZoLEc29i2x62isqCY/dqzfo13eru84Liky1UnAh5WYa6S8VMMG8mabKMbobl/JBw
         S7Btkkgk0wf4TPPd5SmewwzTKXV1oll8hguweX5LdsbtdjX95VplrtKIGhQO+WlyLABU
         nw2NeeRQ1hxSuyaB9D5x/wkHxXs+wyGMpRkvrrj2NK5d7LtyTmI0AaD8EF6phqWFU/5H
         Ch1+usfesRgCAx+n21hUeBr0r+job9iB04M0Pw+GHZtq9u3QuHxGK7MLhswQFgZBlt7j
         hW3A==
X-Forwarded-Encrypted: i=1; AL+hErEeU8h0tlJx5ngfEdGSoaTvKoYvpfSVQOoXC0wq2IYrUQWTXuxQAN4BAuBj1oUbepm70bbmr9kFQ8HuaGCNyPIH@vger.kernel.org
X-Gm-Message-State: APuU4Z94c4zGfBRC+wWVn0xkPOgW0X8nPhccFPzCopRpdNejwEzYuwLi
	BiTdrHQ6EZYuVvBtZAjZeBzAyxXC3iYPSOB0P7J2x1zuyLpq0GVRISvf
X-Gm-Gg: AYBFou2JGBxTvqRaqg+yzeoQ1mPMFlQlG5bjp9GAvlUCaGJ17ypw+cJYLhf7utp43dl
	ReaG53+zHd5XPDQMSysZixGAISKoBByq0GPkSbT3q2/xFCWgqnzplgTEYp9K+6e1ozMxRx0mpn8
	9TmBv+zDFRGJh94kBEYJtDe50F9HWq0lGt/iC/glt06WjYIASIrqj4ucCEpkEpzQnIIQNzmfs+G
	VltOk+l+c+0zVoyGBKjERRWSjy/4LCGsAzO27ssQ6LRhusVmVFxNTDySrAOm/6mcDAowA+QBbIp
	jiydylFGnubWYmfinfR/jX9R4AjgcpDPGuFG6ovTcLblkCWRcuDH/WOR/z8c9gBw6H3uf5XHwxK
	HmbJ9MoxiRW4JAhUkCq2RczvogEPqj5xhoV3fhAy0EnAGK/4CuzQ8H5ltmJPEg2eckM0lkT5ivf
	FAiNIvn3/wQ8exHamD+iYQwD/+ZQQFJgWBeWNCZGkvNabnm3tMlMJhYu1/tFJbM7RXW2xK2DpmG
	VIlvqOG/Yld+Aq9dKNnydY//3adVovcIKFHRsrZIa4ubWk+/rqFg0ySPM5JTgrUv2aV0ngQq1ZL
	IMma/8/9n/06LXGMUgKRhJ6dkZDiAeHE33szDxHnRdNlFwq9JsAPc5U4PJD1Mfr1wuyz2yh4PRv
	0HAl/Ek/quZ0PLr1LSk2cvmE4Z4n7DzOzVwWu6qRoUVyA8HXZ7MePz9zBRcqTBZojLW3cgDmCrv
	GbEw==
X-Received: by 2002:a05:6a00:2c95:b0:878:34d7:697b with SMTP id d2e1a72fcca58-8beb7d1cca2mr6147034b3a.41.1794699450161;
        Sat, 14 Nov 2026 15:37:30 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2d0f473sm2306372b3a.53.2026.11.14.15.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:37:28 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Radu Rendec <radu@rendec.net>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org
Subject: [PATCH v2 2/4] irqchip/ath79-misc: map the performance counter interrupt on demand
Date: Sat, 14 Nov 2026 15:37:16 -0800
Message-ID: <20261114233718.86520-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114233718.86520-1-rosenp@gmail.com>
References: <20261114233718.86520-1-rosenp@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MIPS perf code now asks for the counter overflow interrupt when the
first event is created, instead of from an early_initcall. Create the
mapping in get_c0_perfcount_int() then, instead of when the controller
is initialized, so that the controller no longer has to be ready before
the early initcalls.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/irqchip/irq-ath79-misc.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-ath79-misc.c b/drivers/irqchip/irq-ath79-misc.c
index 258b8e9a2d57..5cedea5234e0 100644
--- a/drivers/irqchip/irq-ath79-misc.c
+++ b/drivers/irqchip/irq-ath79-misc.c
@@ -23,11 +23,19 @@
 #define ATH79_MISC_IRQ_COUNT			32
 #define ATH79_MISC_PERF_IRQ			5
 
-static int ath79_perfcount_irq;
+static struct irq_domain *ath79_misc_domain;
 
+/* Called by the MIPS perf code when the first event is created. */
 int get_c0_perfcount_int(void)
 {
-	return ath79_perfcount_irq;
+	unsigned int irq;
+
+	if (!ath79_misc_domain)
+		return -1;
+
+	irq = irq_create_mapping(ath79_misc_domain, ATH79_MISC_PERF_IRQ);
+
+	return irq ? irq : -1;
 }
 EXPORT_SYMBOL_GPL(get_c0_perfcount_int);
 
@@ -121,8 +129,6 @@ static void __init ath79_misc_intc_domain_init(
 {
 	void __iomem *base = domain->host_data;
 
-	ath79_perfcount_irq = irq_create_mapping(domain, ATH79_MISC_PERF_IRQ);
-
 	/* Disable and clear all interrupts */
 	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_ENABLE);
 	__raw_writel(0, base + AR71XX_RESET_REG_MISC_INT_STATUS);
@@ -157,6 +163,7 @@ static int __init ath79_misc_intc_of_init(
 	}
 
 	ath79_misc_intc_domain_init(domain, irq);
+	ath79_misc_domain = domain;
 	return 0;
 }
 
-- 
2.56.1

