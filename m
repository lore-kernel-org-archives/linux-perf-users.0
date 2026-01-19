Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A3B28CF4A
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2026 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817937; cv=none; b=ur4hWEx5ny7DAtRxqd5RaYY684cyLkIEtLKZU8IL/Kf7rxanZGZg5P2TNBN+hyISaYnWNp4zZBNSfHijk+f19shnYb3ib86H+t1IR4ilRYaapcEJgSCHL+Jw9aQ+0DPeo6tVd0R6Ngi2A/+c/suJnGkAh0ER43fCvcWWPzmWBM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817937; c=relaxed/simple;
	bh=1tLEjrX0DxwPR8iJljGId1dCNiDm6OtJc2dK61ClIak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GChEQRJ4EvRIEvlQMx+H23Wi33UgOzDmqR4e36+2il+Q0Ld82BcumkZd8HpXbbdsNjzwiPrr0a107CbNTdznPZeEOO3s+rKgxIlbfQZUPve9nga/QgnbTSJuGlUSrNn5CApO2lMKXNCmCbZbPtPY57Uyjw/rtm0/c1bIPcElzE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QL/BWI+c; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QL/BWI+c"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so3591880f8f.2
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2026 02:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768817932; x=1769422732; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pk+482C5QT64UqLIfTHE0exsRm+80jWHxmqcZbu6Fsg=;
        b=QL/BWI+cUTd8tTknrVILIuKgRaKCvEY+tMp/QsHFDvSQzq5ZH9TlmHi+CVzxvEopvy
         qt3BzG3JVa0BQVRrZg9ucemCYrOSCL6WavVRm3zbbYi0DCEdozhCAqp+JYUVJyVpVY+2
         wAq083GpeHQy1iKq8dVpriQpNT+AQHLLBx27QERbYoBw9bHmspzCT5ahRHwqxTuuGw4p
         g3jtzwOtwDVMrPcdviWjK+sZ7dLD13HfN8kaGRGtkSfhFtSkEA/XoNLlocFAbW7wbmLu
         ngSxRLvxjnijo6VQRX77NKfeK4kd2ZfhBwMzhjhNH0eYgZgMi4ymojv6dvMn3dkgmCQs
         FeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768817932; x=1769422732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pk+482C5QT64UqLIfTHE0exsRm+80jWHxmqcZbu6Fsg=;
        b=dZkTajbdeMYEdq5yoA+xxKlQFaTPRJTM6g2tkCFFDtuSbJYVhX3vVffa9m9B25oBaB
         fgh8bzir5EUAhlZdPeRcU2P+hU3R5jaxUmUk8wbS5gN1ji08nDHbBTQK8hXYn1EMgs9Z
         px3LsLpwjwBZigJge3ziSKtXce63C/WoOiH7N/YpJtitiFStaCIKN4n/OIgv1MVDFk6z
         PQ7e9FBFVMW+J4M12qL+vA/GHTyAYpYpBcJ6yZyVE8AihjBY8+QcC+vnIHDOUYLva9tI
         oLlxZHYxSLtXGVeV3ZYFqS6ZZp8TNf5THVlLDE8FOsU4ufqU5/0MDH0OfqEa5aTXb2fq
         5GkA==
X-Forwarded-Encrypted: i=1; AJvYcCWKcA6+LkkPvPZYutv79VDMKaiK2CszLZt/kx/owiAhAyNYSfRdu0xiT2pIRtT3RwiueQSpgfsNgT9IWx4jN4Go@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt4ThUGboZc+VucEGtZfy7ESE7dtygGwDRphK5F6jfKcClprEm
	aIAeBf3w9Ac55xkfF8SHD/S/gxGKyzjvwZkSC/UlMOhcAxf3VHJcfcEjmwmHN96BOD0=
X-Gm-Gg: AZuq6aLGsObKOHJQvhMYn6G0Hwm7eppcIx19xcXuRyzGl2Z4E6YoDuFCxcnP4KjRkyE
	rlJhSwX7qB1Jji2/ihvdQbNgtwrhCO6E52A24ejUTWOnLgyP/HMQXVDpFicvKFwOpZwuXRwTBit
	PvPgiW1LWLe/tHoguOT50msTwchOumaWoyH8CK2PUwpkG0N4yGZVqhs2fHFtGCPDuUEaCouzQW5
	/Zs4CsyZEFDBYiZGHqVNJRni8YhGdaVVsm22g4uVLhEBMZyj+cOrM7Gv1DuL4mkc2GKqOIyTtvC
	AvZ959diY+BgTDF2y9R+T1pQMK4z/5Mc5iQ3zN8fvfvA0j03QhOozmtnQT60oh0nFApbCBXcG3G
	gGldtO3UbsyF70An4LqeMJIIv9h9AZUes5kQl/2WBqah60XV2VQTcj/AheGFHfx3rj+OJPzgW89
	WPm1LPnvQ/vgMcx+peDag4
X-Received: by 2002:a5d:5c84:0:b0:432:aa5a:3916 with SMTP id ffacd0b85a97d-4356a0773b9mr14896581f8f.40.1768817931588;
        Mon, 19 Jan 2026 02:18:51 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e6cdsm23286150f8f.31.2026.01.19.02.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 02:18:51 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 19 Jan 2026 10:18:35 +0000
Subject: [PATCH v2 1/2] perf cs-etm: Fix decoding for sparse CPU maps
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-james-perf-coresight-cpu-map-segfault-v2-1-56b956a629ee@linaro.org>
References: <20260119-james-perf-coresight-cpu-map-segfault-v2-0-56b956a629ee@linaro.org>
In-Reply-To: <20260119-james-perf-coresight-cpu-map-segfault-v2-0-56b956a629ee@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Thomas Falcon <thomas.falcon@intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

The ETM decoder incorrectly assumed that auxtrace queue indices were
equivalent to CPU number. This assumption is used for inserting records
into the queue, and for fetching queues when given a CPU number. This
assumption held when Perf always opened a dummy event on every CPU, even
if the user provided a subset of CPUs on the commandline, resulting in
the indices aligning.

For example:

  # event : name = cs_etm//u, , id = { 2451, 2452 }, type = 11 (cs_etm), size = 136, config = 0x4010, { sample_period, samp>
  # event : name = dummy:u, , id = { 2453, 2454, 2455, 2456 }, type = 1 (PERF_TYPE_SOFTWARE), size = 136, config = 0x9 (PER>

  0 0 0x200 [0xd0]: PERF_RECORD_ID_INDEX nr: 6
  ... id: 2451  idx: 2  cpu: 2  tid: -1
  ... id: 2452  idx: 3  cpu: 3  tid: -1
  ... id: 2453  idx: 0  cpu: 0  tid: -1
  ... id: 2454  idx: 1  cpu: 1  tid: -1
  ... id: 2455  idx: 2  cpu: 2  tid: -1
  ... id: 2456  idx: 3  cpu: 3  tid: -1

Since commit 811082e4b668 ("perf parse-events: Support user CPUs mixed
with threads/processes") the dummy event no longer behaves in this way,
making the ETM event indices start from 0 on the first CPU recorded
regardless of its ID:

  # event : name = cs_etm//u, , id = { 771, 772 }, type = 11 (cs_etm), size = 144, config = 0x4010, { sample_period, sample>
  # event : name = dummy:u, , id = { 773, 774 }, type = 1 (PERF_TYPE_SOFTWARE), size = 144, config = 0x9 (PERF_COUNT_SW_DUM>

  0 0 0x200 [0x90]: PERF_RECORD_ID_INDEX nr: 4
  ... id: 771  idx: 0  cpu: 2  tid: -1
  ... id: 772  idx: 1  cpu: 3  tid: -1
  ... id: 773  idx: 0  cpu: 2  tid: -1
  ... id: 774  idx: 1  cpu: 3  tid: -1

This causes the following segfault when decoding:

  $ perf record -e cs_etm//u -C 2,3 -- true
  $ perf report

  perf: Segmentation fault
  -------- backtrace --------
  #0 0xaaaabf9fd020 in ui__signal_backtrace setup.c:110
  #1 0xffffab5c7930 in __kernel_rt_sigreturn [vdso][930]
  #2 0xaaaabfb68d30 in cs_etm_decoder__reset cs-etm-decoder.c:85
  #3 0xaaaabfb65930 in cs_etm__get_data_block cs-etm.c:2032
  #4 0xaaaabfb666fc in cs_etm__run_per_cpu_timeless_decoder cs-etm.c:2551
  #5 0xaaaabfb6692c in (cs_etm__process_timeless_queues cs-etm.c:2612
  #6 0xaaaabfb63390 in cs_etm__flush_events cs-etm.c:921
  #7 0xaaaabfb324c0 in auxtrace__flush_events auxtrace.c:2915
  #8 0xaaaabfaac378 in __perf_session__process_events session.c:2285
  #9 0xaaaabfaacc9c in perf_session__process_events session.c:2442
  #10 0xaaaabf8d3d90 in __cmd_report builtin-report.c:1085
  #11 0xaaaabf8d6944 in cmd_report builtin-report.c:1866
  #12 0xaaaabf95ebfc in run_builtin perf.c:351
  #13 0xaaaabf95eeb0 in handle_internal_command perf.c:404
  #14 0xaaaabf95f068 in run_argv perf.c:451
  #15 0xaaaabf95f390 in main perf.c:558
  #16 0xffffaab97400 in __libc_start_call_main libc_start_call_main.h:74
  #17 0xffffaab974d8 in __libc_start_main@@GLIBC_2.34 libc-start.c:128
  #18 0xaaaabf8aa8f0 in _start perf[7a8f0]

Fix it by inserting into the queues based on CPU number, rather than
using the index.

Fixes: 811082e4b668 ("perf parse-events: Support user CPUs mixed with threads/processes")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 25d56e0f1c07..12b55c2bc2ca 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -3086,7 +3086,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 
 	if (aux_offset >= auxtrace_event->offset &&
 	    aux_offset + aux_size <= auxtrace_event->offset + auxtrace_event->size) {
-		struct cs_etm_queue *etmq = etm->queues.queue_array[auxtrace_event->idx].priv;
+		struct cs_etm_queue *etmq = cs_etm__get_queue(etm, auxtrace_event->cpu);
 
 		/*
 		 * If this AUX event was inside this buffer somewhere, create a new auxtrace event
@@ -3095,6 +3095,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 		auxtrace_fragment.auxtrace = *auxtrace_event;
 		auxtrace_fragment.auxtrace.size = aux_size;
 		auxtrace_fragment.auxtrace.offset = aux_offset;
+		auxtrace_fragment.auxtrace.idx = etmq->queue_nr;
 		file_offset += aux_offset - auxtrace_event->offset + auxtrace_event->header.size;
 
 		pr_debug3("CS ETM: Queue buffer size: %#"PRI_lx64" offset: %#"PRI_lx64

-- 
2.34.1

