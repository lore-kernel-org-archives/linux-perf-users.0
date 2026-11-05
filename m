Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879125;
	b=T8u69HY4O83nYQoNCHOd+GZM3uuyV0aDBpkciO+rkA+0e9HTjUWHHlvVLN5l8ZMfVPqF
	 WC1fIGSMvlrmenk0bOiKJOnJKDl0+PFGWh6TUSFSr3j93uqtKpd5vOneFvEA7exdSofqv
	 ho3p/vgzU/5mB/jMjm5Gj2+mPZc5oWACTk1d8XgsTYFtEr/sGG84rCLWHFpMtSsRukLwz
	 uh/EFcOVNwPMeLn1NZtXrdP8j5Uude5KHQtPVQJtjsG1DtNkUOEnZmoiZLaGtMBKt67Ti
	 8Ef/QrWNOKrKHbCYdyA/K3Wa2YEWGzEfeRdNrx6oFAAF61QXubyYlXaRD+3SVpz5jwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=gUWiFRM+jw/H+hBVieDnKYNLauqU39ebBR9r6EahKCk=;
	b=sNZZG5lx0lefY22SbESM3Kl9i0EhCAaT4Ru5Lc3iqI4Y9tsJpANqSW2IhP2KHCD6UyZY
	 307eWFvgQVUQ389ENSXaXhyxNkH6eulW/RjzQZCY+sDxFQVp4d+3tdqZLh0K1YxdL3flX
	 XNIBoejIAUq5NZU35a/gRw8xJsR7KC7d0Y9TZpNezvEWjHL6XGtY/x3w5ZVMT0mco1F+Y
	 i8YKUqQ+9+1yPNZS+zB0Q14Gbldor+XMZAFmTy+06EuP0LUtdZu+yww9rWxoTYcPlqHCU
	 X+rV4U76WKYrHHO7LmxAYp+wkAt1/wcdmoRhQ2ZGsTPHH/Kt9V5JzaWZHCbk/oY39DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=okCxWMd8;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B657C608362E
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 11:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B657C608362E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=okCxWMd8
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so16539805e9.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 03:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793879123; x=1794483923; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gUWiFRM+jw/H+hBVieDnKYNLauqU39ebBR9r6EahKCk=;
        b=okCxWMd8UfTSG2Fgtx3ehYOoeFtQhdiui/dxP9Ewf7dbpqvHLmtP6PHp8BdP2eo+Vb
         UQDkg7eHFPN2QQyBtL+QYVigs2Jgmb5w1HFRSN+Aha45rMnroRb0CSv3lwhY6Wb8ppf0
         jMJ1wq/cej5fII6HiEn1SVoKfI1j1M1uOa9aYhKupD9rk/g/Kf2qZ7UriCmD+idYtUmL
         Fo/cUUiw9wJmRyWQXgWYxxuJcM8pOjbIM0xSmJGD10IJ9EA/95E2oC0qh489wjKDuWqS
         aSMhqapZYVFgGolOvdAvBhYmxONRxhNzliVDyxs1HyMaJLms68TLquf3rQris1wqg7vQ
         v/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793879123; x=1794483923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gUWiFRM+jw/H+hBVieDnKYNLauqU39ebBR9r6EahKCk=;
        b=HY5hgxydAk6aQOAl2ckm6ZK9j6Qefj5wDgxTqMolUR5kwzYWQ4O5/gOwBmIgWk399a
         MWhyWlLVaw3nvyp1n3WVYfVAf+LPJyGGHicQ7LQHGsN4qAwSwKu+lzYCVVaTURRdvij/
         sTi9HO70R5TU7qvS1gb1xkB6Rp8Pkqg/vqqTyTQEOosrB6eQDsEiGcQryoTnvefcaIFJ
         qASrzyL1b1Pf6o6VPeIwrR0q7+7nabQc1O21Cx7zL4AKg21iQrdfghREa5eLUYVtwfm1
         cPRrm2mSHtmSbeEcoTifrYLznPDCYd1NkuadYfsuMJICpa180VqY5gjG7QbUHGig1Zy6
         tL5A==
X-Forwarded-Encrypted: i=1; AKwUvBxFPnA5CzZaw5r5aWea7kKm9BLnjJm41U73lk8SGTRVGCJbB+ebaivEt6m15EN7jyIeTknN+K4B62EXSghjMCWj@vger.kernel.org
X-Gm-Message-State: APuU4Z8SnLsTW/11UoH+MSy8TJ2WTaQFBxjAwnQxMFI4olP77H3FlP4f
	0SeSX5ATngAqEvLLVtL8RZ0FvOoGXH0vi5HkzjfDLuc8ECC8PzkrihON+7riFIM8dc0=
X-Gm-Gg: AYBFou3PBnqzrVUqXszm3IRGs8+Ts7SdBw0pl54Ol+N/esNF/EXtcOTBa54NknZllcU
	5m+3b9NdDZvQ56UKDTaxbJBPRer8W2T14/BM6ToXhNLdoRVTwL8lpr9r6Z04/KKe3Yp6X7Rfv2F
	AaQiankEPw4kNvTamwhNiSbbSwl7Pn0FRbAn6e367hqJtpRUA+o2VXiPR61N5M8RowTU0IiEpTO
	Hyaw6FpVbYdCkxdbovOCQ68MZ0qC4rwxz9b6HIiC4SL3QP6anAOgkXpoCt40qn4xljMP9IwjFgR
	ac+TeERV3DWV5LwdFcofGmR1X8vOFxKWmcmjnV6VEuJSp59ofQC/kGv+DRWrxYmmVDGy7d/+QbU
	dVf1+AO7h5Ype2ksbwai1uAr/FB6VECxYgVwgF0V/HvTjJsmphvAb4+YU+tjzF2UGGmHvlZ3V/R
	1XatfwKQaKtQYjP3dxcK010FZElf0vvtwIibnodZf1Bo2GjR+qXU3HtrrhNda3L8dgHutj0zDDn
	mImDK1Yzhc7MM0Uif1sn69tmi2pZAxyhTPLXxXIHTJEpbSJSPgbj9zgn0FiRjSE0n6HmA1fIrHe
	uzlNTZdIEDwj/4qgjBG65D/G8jbF7rBx
X-Received: by 2002:a05:600c:83c3:b0:4a9:18f4:925e with SMTP id 5b1f17b1804b1-4ac174711afmr401140925e9.18.1793879123196;
        Thu, 05 Nov 2026 03:45:23 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b571f46538sm56679525e9.5.2026.11.05.03.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:45:22 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Thu, 05 Nov 2026 11:44:51 +0000
Subject: [PATCH v4 03/19] perf cs-etm: Turn on context packet timestamps in
 per-thread mode
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-james-cs-unformatted-per-thread-fix-v4-3-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
To: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, John Garry <john.garry@linux.dev>
X-Mailer: b4 0.15.2

Practically this costs nothing and preempts future changes that will be
made to support decoding trace in order with Perf MMAP and JIT events.
It also helps keep samples in order when we add support for multiple
per-thread mode threads in the next commit.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index acfdb3f53821..47b4e386cc53 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -453,13 +453,26 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	 */
 	evsel__set_sample_bit(cs_etm_evsel, CPU);
 
-	/*
-	 * Also the case of per-cpu mmaps, need the contextID in order to be notified
-	 * when a context switch happened.
-	 */
 	if (!perf_cpu_map__is_any_cpu_or_is_empty(cpus)) {
+		/*
+		 * Timestamps are required to interleave samples from different
+		 * CPUs.
+		 */
 		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", 1);
+		/* Context IDs are required to associate trace to a process */
 		evsel__set_config_if_unset(cs_etm_evsel, "contextid", 1);
+	} else {
+		/*
+		 * Disable periodic timestamps but generate timestamps for trace
+		 * synchronization. Even in per-thread mode with a single
+		 * process we still need to correlate trace to a specific mmap
+		 * around execs, which can be done with only timestamps of trace
+		 * synchronization.
+		 *
+		 * Use MAX to support the kernel widening the field in the
+		 * future.
+		 */
+		evsel__set_config_if_unset(cs_etm_evsel, "timestamp", UINT64_MAX);
 	}
 
 	/*

-- 
2.43.0

