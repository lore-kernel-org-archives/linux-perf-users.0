Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794523512;
	b=KxlHQfSu8ixlDQZoRJ4XULzUTZdjZpHmebzXA2rrnmkfdgpjnG82EtKQf7unGHV+fjdt
	 8GMs9gmZlJwOt8ENAktOhWXRH4V6RYIRSY16G9TJPfr8iYaX9Ay9kcmLjytydGpyIfRcp
	 IOlmMYSm+2hml2UtAjyM1sCFlUbeEa/BjSuAKfVG0ub0SGSeNlmLsOzussn79gbgV081H
	 46Co+5taXOy01BTxbKiF2C5yl8ZTBYNCu6l7I9I6jKYcZR7JzoCMG45/vbn8v3f9llk3w
	 /+tB7vaNg82fya8U4Es10c0/G3Spd7x2ag5NoRaKMZ34TtEttP99XhIiDH6CtgYrcoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=a/wS6Yxk7+tECj0s54STfUWVzey+C0tieK8m7kinAtY=;
	b=PUnhgdajNCh+tWI8GUbZN2XFIvLOAGatMyzOSBh6wBnvr2mAQcGGMU65/tM2vJBynRLp
	 I0TCU/sgekOKu10FcmuGoe6gSFzstGbUF00KuKG52hAh+2TVUfbmnMp6jl277VqLYyLjh
	 oGgGakftGAI03/dWsVs4jAHAoOYdWFj89k/wJUn/ilRJiTTgSw3NRK2rJT3JZR9ZODWa8
	 AGyRv2X1Aji+qhy+EymsyaBSRVmy2mkSK9Ml9QCgKA1fcTlYuD8fuceYIuItpOzyBMvys
	 7bgnqV+BkxxWyZGCIr7bC2KBVDJN5zeueddkgKBg4a/hIenmwywe7TTNmsd3HD79AFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=quIDXCH7;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED985606A8A2
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 22:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED985606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=quIDXCH7
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc147d86bebso166672a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 14:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794523511; x=1795128311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a/wS6Yxk7+tECj0s54STfUWVzey+C0tieK8m7kinAtY=;
        b=quIDXCH71r8kXBO4zdmT6LlbhiXdMtjp+QUt18lWxGcKuvXZl0oapAUh+5CbIZgcEM
         eza9piKdYYEMXGeQX1lAOkfvajpigt6BwFfJnhk5WQqSleQPoJ79KpXVeFnwCrpfqhm5
         87SyjImHW5l9njGveuPp0mszSohcMwz4FGBradmm6xHemQg6a3CYs2U0yDk1dpdbvjEg
         AAZhhd3QfurDN/KeTmh/vEGjoLTFPqwROznszY42kem+2D4touGKyC1KIcB94OzwjGAI
         FK6giG2TtiPTot7bWkFF71XJvy64c0wwPcyA8SrckymUwNa5ysC0P7+8qVXCKkDny5AQ
         wHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794523511; x=1795128311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a/wS6Yxk7+tECj0s54STfUWVzey+C0tieK8m7kinAtY=;
        b=Iv6mBX2ZgThOC21R0g5nIA9c33WcdWlFFjKWrPjnzy5AzzTVjl2z70H/+cs8hlDSZ/
         W2cnlWu8kZAoeksLiQGXPvLZ3m3IDszQhVxBc0ZxRpAjdPTSPp7nSVGtjuWF8tsc+/fu
         fvdliD8vD/xQffT9UdFF8tO815JDX9AAlNcBtgWxkYGM3TSd6TBsSQ6hl6i4cSXxuWXc
         UcJnvTfibbAv0gk8l/W9mQguMDsXYGOW2i9hZTRXGjIdifbDIiy5MDMpppBgD5oiVZAI
         ZduZoDzYuLb0OquDZ5FS4Ob78UnmOiSD+caUBDaPnRadIONNeepdZMTZ3UmpXWG0VKTT
         ePUg==
X-Forwarded-Encrypted: i=1; AL+hErHbcfNhLnLQaOVsl55tOnarm7FLSvjEl8kvfrs/ro52mJgmJl7li0eiF0oHw3xdkc2snHB8Z0uS8BmkJs8syNSy@vger.kernel.org
X-Gm-Message-State: APuU4Z9AMDJ811KOQ6eRdr427OW3btewpEuzY+0bit5EMIpv7BMuuLRe
	I0Qxk54sXyqw9Px5ymQ37iH+DrguesHUROhWW5B5fn6xtNeGYmNdJJb8
X-Gm-Gg: AYBFou3eaDRzPuXjvTHPrlLeXZntvTg0pwczM1DGc2Lftnby2yCl46VOIV+buqAJsCt
	Ga9dcmO+y+TtvFNcC+305aYYB85NBZ1oGL3jaP4XmjqJHCdgHsWFRpZPq3ClpPsLm9kl2j8ID+/
	aPRqs+dmoMVbBzBmPSG2ofgTBGdjWHtZrYb08it+zZqUE0AI/T3diNmb0/0+HE154gIcNirZpJs
	DiPhlZiBcGqPE4ou68+akvE6n20hoZ05OOdLc7WDI4/F2QGh4rUqeXNWpoC5kge34oR3SWNw+Ha
	0q9/P5L6CZows9y+LWieZ2RHsmH9koM0+mw5E1ovfofxXl/P+/clmGE3ynwMoDe+xPY2uERgczt
	HE8m4mp2DbCPigS3F4pcyzPOowaqZLu32ktFSY8UG5dYnFGMdYDQzQilBxDmBYFqXTLk1+XICkW
	OVvS7SWSBB6IGgBbScmZRcnqmbJqs3S39SU9a9rGKl6YWxAZE/D+iZLtOw/9qUFqKxo4I9uOCE+
	u3pBuJ6iJSauUz3O7YrhSau7IGpW097a1U5agmlF5eUttVmcIRNEO9Jkg3003xvdKZrQGVZE5R0
	+f/8kxPRQpTLTtbMSAOWRzXsbfI4KgK762D2Q1bBEX9DMF21R5cKq0IUBYWPkXQNV28XhtQRmtl
	rNGYxT+EvY5djDcmRxkuUfVZj/hZsolZg6W0ItTsHYHvkmIJUDG4f3PsFElZbBsyyqnVCWivhG6
	nK6yugYmQt+ArNee8j2/mMWx0=
X-Received: by 2002:a17:90b:4a84:b0:3ac:b6eb:e0de with SMTP id 98e67ed59e1d1-3b1b087c2f3mr285721a91.4.1794523510994;
        Thu, 12 Nov 2026 14:45:10 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3b708adsm37073a91.4.2026.11.12.14.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:45:10 -0800 (PST)
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
Subject: [PATCH 2/4] irqchip/ath79-misc: map the performance counter interrupt on demand
Date: Thu, 12 Nov 2026 14:44:43 -0800
Message-ID: <20261112224445.213324-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261112224445.213324-1-rosenp@gmail.com>
References: <20261112224445.213324-1-rosenp@gmail.com>
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

