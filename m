Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AFE410D16
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777484192; cv=none; b=EKdTTRO1wWzMbkz+6J5RNLTEH+Bm+Jfj6OdSyBEd6bMiE5ka5YYsqYt4fq28zQ14ZVMkrE1FFe/j27A5mT+eakJrpgIl+3d5VeTbRn59DpxtpPgn1A80PDFXlwUhuDHs7Z+ytiITinC/+DPZvQidxZGcZuFUm1h09s8IWXr8stc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777484192; c=relaxed/simple;
	bh=uwU4DYRhKwepclGtKTM4yCcHG3JfSXJYqKIVcGBiSgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZeldYTxcCY+qsyIq7Y7FGe3yNyrqzriT4C4rH8b9j7UAU1oMVGbwb+xRNfjog5TdLMruNHbt61P8+uk9tUr1/wgKt7jQrA30X2nYyEur+Qo/O9Blrdr8GbvklkTrrzu11eo87l0853qV8fL7YUqdWbKk/acAkgyiuLsWPmemjEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=b4w8g0eJ; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="b4w8g0eJ"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c15849aa2cso114115eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 10:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1777484190; x=1778088990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aO8WG8Socwj3Htukhg7X7ENz50SwDAgrsCID6h8CJjo=;
        b=b4w8g0eJImd0dZY3fyh7QW19+BjX2Wh/dZLKtGhtHdW+a6PmwYuRVsvI7TKiUSwFU6
         QegyEgwZmRgtobyewsQkZNrpz4OffV6QPxBKKQdPvBab96rT52NFBzqtxbtn4xkhizvd
         J4ysok7/UrBmOGFCnBvru/W6isbOax5VD33zsVMXjrpx31FEipHa+z+yflMBg+Q/NKQl
         i+S8nVPy5kUQ2lPEw71NnJwoJSBQ48HJAxlIkhfKikYRnHPlUZEoEF9O2NUufEgOzZ34
         SYtNOJufmtt+wLmlxGKuEyVDcbjdZB5kcMNoXzrkCrXM294iKM9oZILEW13AzxXc0zDM
         ldLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777484190; x=1778088990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aO8WG8Socwj3Htukhg7X7ENz50SwDAgrsCID6h8CJjo=;
        b=Qhh3iv9oRqoaQNiypA1GepLeZEWZ8mVga8gXrtCavQE5/6+buRhSJL26FO5BG6keBO
         bY9YPjuu2A2El7YvEDl47zNgwBOZHrYKhJLNFVcAmY/yKKgj8m0JGXWaG9nX/DHHzKJc
         mBS6J4rCmn1PdYXY7X0bdcWTL7P1YjDqfatXPqmuzNP+r+QHTvIC0+0NcDrTQD5TPebZ
         cLsxN1OckA+HPAIFk60vJCR/qJNB03IMDlNleSuwMeEoUGldB/Si2q7DLlhG/irt2H7v
         3G4ZgHq3H9Bl4jmIl6omVhBVMmfUMNnaahdc8epb/w21Oi9BmdIiSRLPXzHfetuvxDEa
         AWdQ==
X-Gm-Message-State: AOJu0YylgtzPPrH+pffcKOI/WiaHQru+9drIjTxqET/G0hMW2bAhyND5
	2eULZMfpifzIt/F8UgaFBWh5N/bcvnT7tj2BZjb/xMBw4Tc/uaEkMVS0vXs4TggpW9s=
X-Gm-Gg: AeBDievYHMcvJN8UzRuvDaoNznvZbv/sVo457ztmR8OIGmsxaBCPyXYWhQ3ANcqLr/7
	GxTxdQbzPPOZbOk00HvV/QfETKBv1T4xMWyooKSHFNk+ZK7K76jtRoYo47NbgEKHocfMv9ezof7
	ZRsN9WsKszTfKylGV6r+LqHSU7bXNNenKVphj8Gq1EbRTN+Sf7M6IKWaPD8d8T4aBVDwwzx5B8+
	Vep4pCG3G5UVcUdunkB2ea0DNbwDPkGq6jaH7LaMEjEJihjtHx3OX3Gi39dxgFxvCjWQYSFfYwa
	tPEVXc9wjc6Qwv67wCaPfGlwZ1XmLA4kFD2DZN7Xl+bzXd2h3mdu7ayQEifQCfgDhJbQRWFd54L
	cYfcgoDOWpfguuAJMOb8XdvU4BdiExReHvyzWeeAqEcmlbpTAkr1AH9QbCWyRp5ldOuTbkGSqQV
	rsj3/30mwibDPBj0mrg/djlfY+UJfRupee9hWM
X-Received: by 2002:a05:7300:7f9f:b0:2d4:94cc:eebb with SMTP id 5a478bee46e88-2ed0a0da75fmr3609047eec.13.1777484190139;
        Wed, 29 Apr 2026 10:36:30 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:eadf:43ff:5bad:d931])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1c09c6e3sm2899087eec.25.2026.04.29.10.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:36:29 -0700 (PDT)
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
	"H. Peter Anvin" <hpa@zytor.com>,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 2/2] perf: Don't throttle based on NMI watchdog events
Date: Wed, 29 Apr 2026 10:36:11 -0700
Message-ID: <33d87384aa5f96af76949d1399476779dd4f4fce.1777483573.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1777483573.git.calvin@wbinvd.org>
References: <cover.1777483573.git.calvin@wbinvd.org>
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
Changes in v2:
* Sashiko spotted that nesting NMIs could cause throttling to be skipped
  incorrectly. But its suggestions were terrible, ignore them and use
  __this_cpu_cmpxchg() to solve the problem instead.
* Sashiko notes that NMIs which last over one second firing on a period
  of greater than one second will also skip throttling: I don't believe
  that could ever actually happen, but this isn't a hot path, so I added
  a check that the current NMI took less than a second just to be sure.

 kernel/events/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6d1f8bad7e1c..c2a33cb194ce 100644
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
+	u64 last;
+	u64 now;
 	u32 max;
 
 	if (max_len == 0)
@@ -663,6 +666,19 @@ void perf_sample_event_took(u64 sample_len_ns)
 	if (avg_len <= max_len)
 		return;
 
+	/*
+	 * Very infrequent events like the perf counter hard watchdog
+	 * can trigger spurious throttling: skip throttling if the prior
+	 * NMI got here more than one second before this NMI began. But
+	 * never skip throttling if NMIs are nesting, or if any NMI runs
+	 * for longer than one second.
+	 */
+	now = local_clock();
+	last = __this_cpu_read(last_throttle_clock);
+	if (__this_cpu_cmpxchg(last_throttle_clock, last, now) == last &&
+	    now - last > NSEC_PER_SEC && sample_len_ns < NSEC_PER_SEC)
+		return;
+
 	__report_avg = avg_len;
 	__report_allowed = max_len;
 
-- 
2.47.3

