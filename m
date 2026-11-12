Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794523511;
	b=hJmmj89fkcaWW3aPpKZAHbxvBUMxfUKz/MA6MKInY1HFcWz8vBTPoWjPriP1SlY5OHOI
	 Uc6DqKs4LO/HhzAHwPAGWcFrrWOOoP/BJC8FjjgJ0JujJzqoKPSHpErxt5/y19/7j7R7I
	 kM8VYY7sEoyj/c7HxcGBkvcf2yWXnxbZMsmdhn3G6dOKrI4uh4OzFV1zG9XE8I0Pe1sTR
	 /Jj+o1YXIPdUbeZP+QTY3zqehrlS7NOCitcHximu9oc+Iaw2164XD4PpQrMjlmaNDF4nO
	 VeAMtWeNq3itaO6mMvNotuQj180HMMlWzErOlfhQj3qlGijByYqn295+kDW+CgZ/EKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/05SBYoZ3//tmYEVR+U9kWXjnHi+JJTkJcmENCb0oJo=;
	b=zB4KIpElf6XGBHoZICpw86kD+vvnw0EnqiiDbPLFEVpcn7PAm9CkZypDjzttbfT/gyb2
	 QMSSti7sxi98+kJ/fgqMgsA5JpbORJL3eW6FxSec1lwuOhRHcy7FyMtCBJnSI8wvIvjit
	 AhvTv8jAjph+9QkWESX4/CowAH7zHQpj3/KfItAEjJKpOO4QPvG31UkN1HjQFD8q08qKG
	 XnUGJYDsffJD6mOa57oYrrA7MHmcMCrcXfZu7z8M/x/zAbTIkWeyk25+4rddOlsCl7Q3D
	 flBXR8wZwoIkz8xenTCeD47sGomF0TAlfZ2zpuy2ZAg5iMUwagbcKTJI50Bo0nB48bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="NwXqQ/rX";
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46984606A886
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 22:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46984606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NwXqQ/rX
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so353907a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 14:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794523509; x=1795128309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/05SBYoZ3//tmYEVR+U9kWXjnHi+JJTkJcmENCb0oJo=;
        b=NwXqQ/rXiLJqLEAXQgQVUH9RWV8PsTXIFsGtPcd9sOiN9fPGAhvdoAUe8KiWy7wOZw
         PV9zzkGuX+aNjarAexQz31FkLIAPvytSFd/4T3Y30dFKluBuVdWDWLSEPbfaUXHr9r0C
         xaXD8rAUoCoCQiREV4OYzPG0sL8C9EwgF79ttpEUTxGMw292c2vzipsSScsPF/Aahc5V
         TM+5Tk1kIO9Z99whwa/O8OJdtP3IfMdGBjss23H23PHk/Ns2mKa23dzhvHCT+ZZy9mu1
         YfpqicM4CLW4ZgcL5hW9D4ZAERn8e9ycLifBL8GmUTA/lyK5tjb/tVMgCpQxQIdouTKd
         kT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794523509; x=1795128309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/05SBYoZ3//tmYEVR+U9kWXjnHi+JJTkJcmENCb0oJo=;
        b=Vd16kSqcTPCA+T00Je2o2Wvfa3PinyZVcPk2QmZr5C/nDJI90GO4BmKXB0PmUVfxas
         RnY9ppf3GHhkMqHUz26vOhLZ/sG2Rxio2OXIp/XjtEgH7wSsvi2vQO+ymJ+eeJQOfAik
         TZzqbUNlHuDMRiLLagd66IM/wM3LZvLC9ua+CrbiGtkEQ/Qb+gfG1N9rV1lRobYGIiCS
         WmDp+XqRknV4o1UxxjjCDQw5jcXwbjYFW4ZY7xU+jcHCSRGysZl9r0ozTL5AbEO4Y/tF
         gvNl+m55dyq/RzJLOjyK29k1Nw2LQa9QrEtdRgRp8iU8iNhmCnTEr7jpiKxa7tYXMlDh
         OPzw==
X-Forwarded-Encrypted: i=1; AL+hErHqVsLFnAkdCWfjJu6wHmu6qmydhzI5l8di48sggRDiidKJlTV5yBTQOvoPUumjHp0fXAfAHqZFmpyrF24QdEwg@vger.kernel.org
X-Gm-Message-State: APuU4Z8CBhb+gzFMhsJCOkLRpTiIS4QL+dPpOIldlkI/SlraTCO4TCQn
	h47I2mWektNPWqL0mtTU1Rm00OWWh9JApQiYHzUyAM8BwCzeYyyFYskI
X-Gm-Gg: AYBFou0jK0crHEHqN3DVxJkrs1priL9OZl1WpZyzOld8ZCWvWdYqBZC2QDB8CvFcUvz
	5PuGQZxyHj4I1kF4qpoOEqQNh06MLn46aTBQiZqkCUG1G5sOGujneSybTGMddOEH3OwzXdqH6ZA
	S8jTbuTvaVyz9xkPHEhn2GpaXinJVJi6GxFb6wfXa/gKaLr40V+lYZsHxMzVmbBVHfcn+NkXBZt
	c/MXDm0U909H8tRQjxKp5FzLL7YF2GLcm7yCg1WwCCjPsOk/RUoyPqEvsjrsLA+1ZSdCbH3nDbH
	QYKR+8CglQbjKk+BcIFFY5IetcCF4sOkWQ/8+xxwiQ4drfIQhzIfgR8N3ABfNKaQc/2waEb7+21
	EmRrojZQ8TaAH+9X7FUDp6QHi1ssGsgKrl6zbV32e9VHKCU/12hDZzcCIwxVAIzluncJwxmsDXS
	oXcheGHUhDOXJgarOOlMF/f1YVyNPeaNejJ7iFB99nX2JMAJpF6tYezbRr/gH7oKiuvUW0Diu9C
	EWGPftJXrSLKpwBOs3mVDLKq9yD9KCnCFTR0RgduupJOK6vC7yTBSRCuud/wTnRgeQFoQExz+Do
	hmUFnAy3dAI2nDzn49kcAes1y/6QKU5oRjHJHJUQM7GbJY/vCkbygLBd7UaF0EKfJbmLOCcYNrB
	y4QdJeCX170UK2qNdE8TQxyAucTuu60DT7BUO+HE/J11taiIMlmcPpqOr8v6VgDuMtZJjpvV+3L
	Apxw==
X-Received: by 2002:a17:90b:4f82:b0:3a4:f8da:2478 with SMTP id 98e67ed59e1d1-3b1b09fd889mr441375a91.29.1794523509368;
        Thu, 12 Nov 2026 14:45:09 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3b708adsm37073a91.4.2026.11.12.14.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:45:08 -0800 (PST)
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
Subject: [PATCH 1/4] MIPS: perf: look up the PMU interrupt when it is requested
Date: Thu, 12 Nov 2026 14:44:42 -0800
Message-ID: <20261112224445.213324-2-rosenp@gmail.com>
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

init_hw_perf_events() is an early_initcall and asks the platform for
the counter overflow interrupt through get_c0_perfcount_int(). On
ath79, that interrupt goes through the MISC interrupt controller, so
the controller has to be initialized from IRQCHIP_DECLARE before the
early initcalls, even though nothing else needs it that early.

The interrupt is only requested when the first event is created. Look
it up then, so that it can come from an interrupt controller probed as
a platform driver. The boot message no longer prints the interrupt.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 arch/mips/kernel/perf_event_mipsxx.c | 30 +++++++++++++++++-----------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 196a070349b0..4d660952e643 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -589,10 +589,25 @@ static atomic_t active_events = ATOMIC_INIT(0);
 static DEFINE_MUTEX(pmu_reserve_mutex);
 static int (*save_perf_irq)(void);
 
+/*
+ * The interrupt is looked up when the first event is created, not when the
+ * PMU is registered: on some platforms, the interrupt controller that the
+ * counter overflow is wired to is only probed after the early initcalls.
+ */
+static int mipspmu_find_irq(void)
+{
+	if (get_c0_perfcount_int)
+		return get_c0_perfcount_int();
+	if (cp0_perfcount_irq >= 0)
+		return MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
+	return -1;
+}
+
 static int mipspmu_get_irq(void)
 {
 	int err;
 
+	mipspmu.irq = mipspmu_find_irq();
 	if (mipspmu.irq >= 0) {
 		/* Request my own irq handler. */
 		err = request_irq(mipspmu.irq, mipsxx_pmu_handle_irq,
@@ -1889,7 +1904,7 @@ static const struct mips_perf_event *octeon_pmu_map_raw_event(u64 config)
 static int __init
 init_hw_perf_events(void)
 {
-	int counters, irq, pmu_type;
+	int counters, pmu_type;
 
 	pr_info("Performance counters: ");
 
@@ -1904,13 +1919,6 @@ init_hw_perf_events(void)
 		counters = counters_total_to_per_cpu(counters);
 #endif
 
-	if (get_c0_perfcount_int)
-		irq = get_c0_perfcount_int();
-	else if (cp0_perfcount_irq >= 0)
-		irq = MIPS_CPU_IRQ_BASE + cp0_perfcount_irq;
-	else
-		irq = -1;
-
 	mipspmu.map_raw_event = mipsxx_pmu_map_raw_event;
 
 	switch (current_cpu_type()) {
@@ -2017,7 +2025,6 @@ init_hw_perf_events(void)
 	}
 
 	mipspmu.num_counters = counters;
-	mipspmu.irq = irq;
 
 	if (read_c0_perfctrl0() & MIPS_PERFCTRL_W) {
 		if (get_loongson3_pmu_type() == LOONGSON_PMU_TYPE2) {
@@ -2044,9 +2051,8 @@ init_hw_perf_events(void)
 
 	on_each_cpu(reset_counters, (void *)(long)counters, 1);
 
-	pr_cont("%s PMU enabled, %d %d-bit counters available to each "
-		"CPU, irq %d%s\n", mipspmu.name, counters, counter_bits, irq,
-		irq < 0 ? " (share with timer interrupt)" : "");
+	pr_cont("%s PMU enabled, %d %d-bit counters available to each CPU\n",
+		mipspmu.name, counters, counter_bits);
 
 	perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
 
-- 
2.56.1

