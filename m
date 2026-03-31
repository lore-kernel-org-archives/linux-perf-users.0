Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE4040626B
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970765; cv=none; b=lPT/j678qlIYePhQO+3moxZEUSBG/0FCIrt6kFhv/ST8W6Y9cMhBnlpZhA5fxAUR935wOPkrR+2vmcGvASPLb+a7Cb6JJF2Q7U2sQ7Z/OGBoUrWAbO2/UZ0tpCCXGQciUJR11V6KNXe/NdaoiG5kS1DUjO0Ix8mwqUN2ETrVyJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970765; c=relaxed/simple;
	bh=5lEWMzXasikcO31AENKqbC2O8hgoosi4MrR3O6h5qjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNOoGFU4pmv5vt5HtVft1rdcFAJ8xyIw9QBQW1mmvZASzn5l+lji95VOlASexNNSIbCM7yvIuFrL/xRcGNdVJmh/EPZaD/f8nVeMqyVn0PjyFl/oGsuJuZdAS+S7EUe2BGOig0ozkgEesiUPJCU+leypUTS86ZLPlxiXKAR1NVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=X0+BvwWG; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="X0+BvwWG"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-127380532eeso676987c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 08:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1774970763; x=1775575563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dz1Axq4Y+lq0ZDtoswb/uDlh80ImpylCPpWTk7UXK8M=;
        b=X0+BvwWG0p80dR9JBRWfrAQVCetEKmdHNm8xXXi9A9cW61uJkpeXkowoXtxrbPm9DY
         T5Fw+6ZYpGLucYw6Zq/cZp8sPS+bDtvA+p0wDdO0Ua9txyNgRgBOFOqef+gocnQyS0fR
         245Gm/48pycTeG3UE5FZ/3rSsQh254jCGgZwwvO8Le5HZYQbdqLXnmcG41jVaQ58tqHD
         jWM2MuaAvH6uWy5/SxGLxnPObVmNjbpzWHMnbeW2iAdeRdSNHGrDHVVVCQRaTGpEpqMv
         +0wud2F20FqbkysQ3DuNXlUTRHEORZnhba+ZIud84nSEpIWCHJSXCVDfI+IGfyn9sRUL
         FAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774970763; x=1775575563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dz1Axq4Y+lq0ZDtoswb/uDlh80ImpylCPpWTk7UXK8M=;
        b=ri6KSbq9shBZsTJITMt9Dxi2kNxXP34brkUOaVsN7oTAzvt9314lsaqte0JrPFErIa
         Q+aoHFL6GFzSaoAyrz1RGgJ0yRKg29VGIr8ZYyMM9nZ3zq57KZB3i8FgKIyx7w+0xdym
         0yzRu2drQESqiAZ1SM5OZa5xjBQk8aAU/XXkdp1sYc3WhnWeVESviakZBUFAr1ljOYB0
         UdD2pNqfPVeNqnaf4uB8gVrYEn3KrJox3wIPwwtYxBBHjSZtS7d4loatzT0WczJHh7Er
         gUii/dKRoanIORqz+y+iI9PHK/TFwORnq3lv6Vd1ZyG0691bIVkmypb2YzduUkYIpCNN
         YrGQ==
X-Gm-Message-State: AOJu0YxQ0K8ngusi3bReT7P9pAfErLTwpV2f348ZZlxEG78C4UW0knsL
	4iMlRSA/VR7zkYmqbxck1xd9sx3GlGomS+d8pEzdeWFBj1T1JFqq6S7qtoXjXJDhRnhRxD0G95b
	TT7XY+/+wlA==
X-Gm-Gg: ATEYQzx6S20fXNlEQ9Wzzgw+WiIsaN8X06KiUE0FVrrHBRJVVJmsZyUlTttWAHnn3BV
	PKkn9XvdQr/GvOie2ENasbScyFWUB7DDi9ckdvLu6gn7huwpELWOIlnpzQtdaFhuWVJGWpxxq5X
	wtUTny8lfJN1BKXWMTLe1fmXzhVDOdBhz9/CzmpRUsrPOzxb1MAhp2kAgW2BADMpIrmKC0N5gZ8
	pOL7TWULI2SqaY5g2VvQx93GlpVBtDCY3xzTNtzHpIqvpj65E7gTfv73aiR3/mSSuVGT5wsxdfF
	kiFr0xkdVC88k5xjoHIEsBKtB/WQfaLDr4mE3HCEUy/jBibACxYNrNoLGPXhuPjzcF873msV7/L
	MCSZGmAtBKpZndgonBiASJyLgirZvrYO0FOWMGG57VU10WBfF3ooqytihbtUR/1QkwPpdvghJgu
	kXQyZZbO25Y5YjFaYrxDrND0D8A1NDnC/9uw==
X-Received: by 2002:a05:7022:388a:b0:11b:1c7e:27d0 with SMTP id a92af1059eb24-12ab2752bbamr10827485c88.0.1774970762557;
        Tue, 31 Mar 2026 08:26:02 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:5f44:e3d:a8c5:d59])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab983f9f3sm15618113c88.10.2026.03.31.08.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:26:02 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/2] perf: Don't throttle based on NMI watchdog events
Date: Tue, 31 Mar 2026 08:25:50 -0700
Message-ID: <685061daed5b505ef604835b602e0202531f2315.1774969692.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1774969692.git.calvin@wbinvd.org>
References: <cover.1774969692.git.calvin@wbinvd.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The throttling logic in perf_sample_event_took() assumes the NMI is
running at the maximum allowed sample rate. While this makes sense most
of the time, it wildly overestimates the runtime of the NMI for the perf
hardware watchdog:

    # bpftrace -e 'kprobe:perf_sample_event_took { \
	    printf("%s: cpu=%02d time_taken=%dns\n", \
	    strftime("%H:%M:%S.%f", nsecs), cpu(), arg0); }'
    03:12:13.087003: cpu=00 time_taken=3190ns
    03:12:13.486789: cpu=01 time_taken=2918ns
    03:12:18.075288: cpu=03 time_taken=3308ns
    03:12:19.797207: cpu=02 time_taken=2581ns
    03:12:23.110317: cpu=00 time_taken=2823ns
    03:12:23.510308: cpu=01 time_taken=2943ns
    03:12:29.229348: cpu=03 time_taken=3669ns
    03:12:31.656306: cpu=02 time_taken=3262ns

The NMI for the watchdog runs for 2-4us every ten seconds, but the
math done in perf_sample_event_took() concludes it is running for
200-400ms every second!

When it is the only PMU event running, it can take minutes to hours of
samples from the watchdog for the moving average to accumulate to
something near the real mean, which causes the same little "litany" of
sample rate throttles to happen every time Linux boots with the perf
hardware watchdog enabled:

    perf: interrupt took too long (2526 > 2500), lowering kernel.perf_event_max_sample_rate to 79000
    perf: interrupt took too long (3177 > 3157), lowering kernel.perf_event_max_sample_rate to 62000
    perf: interrupt took too long (3979 > 3971), lowering kernel.perf_event_max_sample_rate to 50000
    perf: interrupt took too long (4983 > 4973), lowering kernel.perf_event_max_sample_rate to 40000

This serves no purpose: it doesn't actually affect the runtime of the
watchdog NMI at all. It confuses users, because it suggests their
machine is spinning its wheels in interrupts when it isn't.

Because the watchdog NMI is so infrequent, we can avoid throttling it by
making the throttling a two-step process: load and update a timestamp
whenever we think we need to throttle, and only actually proceed to
throttle if the last time that happened was less than one second ago.

This is inelegant, but it avoids touching the hot path and preserves
current throttling behavior for real PMU use, at the cost of delaying
the throttling by a single NMI.

Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 kernel/events/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 89b40e439717..0f7a7e912f55 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -623,6 +623,7 @@ core_initcall(init_events_core_sysctls);
  */
 #define NR_ACCUMULATED_SAMPLES 128
 static DEFINE_PER_CPU(u64, running_sample_length);
+static DEFINE_PER_CPU(u64, last_throttle_clock);
 
 static u64 __report_avg;
 static u64 __report_allowed;
@@ -643,6 +644,8 @@ void perf_sample_event_took(u64 sample_len_ns)
 	u64 max_len = READ_ONCE(perf_sample_allowed_ns);
 	u64 running_len;
 	u64 avg_len;
+	u64 delta;
+	u64 now;
 	u32 max;
 
 	if (max_len == 0)
@@ -663,6 +666,17 @@ void perf_sample_event_took(u64 sample_len_ns)
 	if (avg_len <= max_len)
 		return;
 
+	/*
+	 * Very infrequent events like the perf counter hard watchdog
+	 * can trigger spurious throttling: skip throttling if the prior
+	 * NMI got here more than one second before this NMI began.
+	 */
+	now = local_clock();
+	delta = now - __this_cpu_read(last_throttle_clock);
+	__this_cpu_write(last_throttle_clock, now);
+	if (delta - sample_len_ns > NSEC_PER_SEC)
+		return;
+
 	__report_avg = avg_len;
 	__report_allowed = max_len;
 
-- 
2.47.3

