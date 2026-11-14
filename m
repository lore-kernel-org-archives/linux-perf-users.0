Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794699448;
	b=g1HJdQCCM5hDstdaiQPLiYxCtKAPGbJ3UQBC9q5u4P60HKdTfjgVOVNMR9T5M9CVNZ/9
	 D59p5W3F5Eb3kc8iqFO7/XLNkycE0xFM+eb3jSDp/TaB9IBMYrD90J/yTlDOT0oVvDsG9
	 W4a/gzfF+gA3EFRDMe6XpGKB7gP5SU7yx+XDd/wukOTwBmmzYvxajOYiDrT33r+gWNVnu
	 ucXfKNldaaN9pbBphTkLVqPRAu+GRg/JebyPC1AMpjKFbACdzRewmbs1hZ0M8OUJ50hIL
	 tZAWlYi0E1UHd7C6Zn8HuisJDtX9RDyKkfmwoBEHGdyZt+WcAtoPCgOpaIem4AJVSmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794699448;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/05SBYoZ3//tmYEVR+U9kWXjnHi+JJTkJcmENCb0oJo=;
	b=YXK2R8vOPB5a4lzjZkCzMdiPqYmMbHcQIyRYETB3QoHZjFg+AhcnT6aZXQvGhKLrPtMk
	 Pzqb2us43jiZcSg/sHTOVvNhdDxJvqrFhToAhpeO8/1JYcxr6iY1pfp+wpbEb1Rn0Krhq
	 3nrYGs8lipU4mGORBn3hA0kSLwy4K2EdvfneCADi8N6HUYeYbDTRFLxxKBVJ1XtPB28gf
	 8PHMnJEjoJ9uK2SDvZg9Hj/NZhz8mYU+jqu2ZW/pWsYlP9a9cEdVNU1al6/0SRhN1dyzY
	 JEhAQP4ZpQuUjPSKOkR5SLgQLMh114PtC2E9zI4FldY9Z4MDGr43BP7WiNBSm+xXR0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WIUBClTd;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8247E606A33F
	for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 23:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8247E606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WIUBClTd
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so835354a12.0
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 15:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794699448; x=1795304248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/05SBYoZ3//tmYEVR+U9kWXjnHi+JJTkJcmENCb0oJo=;
        b=WIUBClTdxSmsCjNFgZRykFI8qBlFs90zubMVLvHdAEPI0NnJmjEootK/nv4yun3Tup
         e6QBGb8VPaN3mi6fpFVVDaMLWPlObza3U2yXMqx+mXwu1a1GIIPPu0UnJiF9cnQKiO6r
         vxq3sgkSELHUUrf5NkER5QWnv2T424w7QC0V+/K3t8n7rZqnH9ftcbM8z0Ou7lkY+cCA
         uTmwWJ2UFakdP2BlLyfLHl8cKdk/7nBVcoHEckH33RGcu5OpDT1MVPvUVUZSfh3FcISq
         zRacdjJVZVmHWdVs6G3HUMWBHeiibmDY6iNZlJ463Ubo6Gvywxjlh3rzFgGlyL6DQv2Q
         oRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794699448; x=1795304248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/05SBYoZ3//tmYEVR+U9kWXjnHi+JJTkJcmENCb0oJo=;
        b=BVCvVtv/6qNascZSjNfnDOW1nYOb3er4KG97qNQNztgvHyP37obFXSeo/yRCXnLauk
         Um30fSxG5O0RCzXXjXydd7cVY4v6h6vW7cbnPWO1QAQD1540oilyT1cXRkJ9UySFRkcJ
         3UAUrZwpsVB5uaRliLbOTS/1lZD17LU/KWv4Mf0zrR5Xzv0CzdZ7TRKExccyNwaX+Z0K
         U/rQHEBWQlQlLCwBQa9w+abItoQzTIazTr+3tc4g1RjeHmHbdIxmyaA+BkmsyGWPW1tY
         WHgvsdxZm0Ye0msfDUfpsmkRs/7ssGzocxpJGnmXVg7D6STAZ6D3Q2xIxh4+eCay35N3
         ktvw==
X-Forwarded-Encrypted: i=1; AL+hErEMpCkqGNXdlDva1UxLLR3kQjsGT3fQW9E5reCTvwhEwQU0XdAR/zfn8DNhtAHHfJxGsmy/jIWL8k6mcJNumnJY@vger.kernel.org
X-Gm-Message-State: APuU4Z8voYHC2MvU0C0s6YEcSeYgm9A6CNAVTKZBXyyOYCaX4k6kuwJW
	hBPjakZv8WKhYuLxyfvdbCdwEWKGJXv45g+0b9I3LDtlb1CAXekOQqfAkAmnGQ==
X-Gm-Gg: AYBFou1H2iTVf+9Z6f4Lx0RaHGlmRdNMsTtru3xNP07jiG0y8RWSPiq8fsHJbI5p5YC
	/AxO4UszXNEHzqV1WfpIrOtHDNWbDNW8C/ag4BbobQ6WI7p2czNHxtuj+HXzz/38rXXJs4enmkp
	xCah5aVL6RZ8GiHA+h03DYve60tdF/wtHkp0Zdt0uZXlh9TyQ89Kk58JAyKNLXL78kL7NYIGvRi
	XgmdrM8OFLOJrGN4xz9A+8053n+oouP2qPFW1XxcFR/y59PQ97lK+o+zs1U9s6s13ngModl6Pra
	IfPqlV06BU7Dh8EjqKKj/wHCOIkdsCNmVA1j4Ap1QW25fgc/7gr+Cm6enPhzfWrT/aCMivoDW72
	DMRV4ZmVzlUgcbIu5kTpJ+Uc5uMtoPcooK+zL23TwHggTDfINMDMCY5kt66EdSjT9H8VrmEvGMg
	cajYwuWMLa5J02hZ4Ra93WAbwydvTGCbdshuPe5NLvBJqjf1plCFKDPzALKgR9x2eKBfpeNpb4x
	5axfcByOt2hvluz0ybI0NIWwbRpw/4Xbi6Jk/HuWV7WR5l2OaOONLzEzw/FabTwfXXAWUPsTFmd
	LdpQ0H90jILe0makNlnwgn0XZF3VPEE/MNB3grXvI0n0O5I4Loz3J17y5hRrrxihj9V0fFNyXEF
	PWqwu4We5qvwj9A9GaULngUQgZpB6HRWYWv9WKX1Bk1EodkolYHk/OwBLCIF2NGGD4At5/vWXLS
	9VWw==
X-Received: by 2002:a05:6a00:2346:b0:8a0:2914:5d27 with SMTP id d2e1a72fcca58-8beb714f59cmr6118058b3a.44.1794699447603;
        Sat, 14 Nov 2026 15:37:27 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2d0f473sm2306372b3a.53.2026.11.14.15.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:37:26 -0800 (PST)
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
Subject: [PATCH v2 1/4] MIPS: perf: look up the PMU interrupt when it is requested
Date: Sat, 14 Nov 2026 15:37:15 -0800
Message-ID: <20261114233718.86520-2-rosenp@gmail.com>
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

