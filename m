Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2528E1F2C55;
	Wed, 11 Dec 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954437; cv=none; b=XBRC3pp6ZkNY3iw8uyC4Zbh4y//ooVSxDoqD+FSp2sXofgQZrAhaBmMEFMPB5lvhxngHNzKQyHVg/2Il6z+erJivt0Qc9WLwyB7ndwXp6UjYm5tn8o99MZzJ+Sv5wFg8sO69nKbno4R2SeATbanOBShVIFpGM2+IxYcWr1D1Pdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954437; c=relaxed/simple;
	bh=jPBZDIKyif/LhOPbutvjTXCG2gTELlQErVsQ7/V8AdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3eMmMQAXGmTVkaLWIa1AVyDHb+FZVudet9ZBG34xd4DlPGj6cL53mpt8sEalrHhl2B1X6IS70r+BQRzDVBOpRRsCj7PxOf3vDXN0I8lY65reTnbJczwHwAv4VGOmdiU29MTUwwaw2zIVAdQVoxmbwbAJFZhW35swFD5R4JYNtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bg9Pm2MW; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bg9Pm2MW"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e56750bb0dso5223846a91.0;
        Wed, 11 Dec 2024 14:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733954435; x=1734559235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=La5gJeu6ZE78YNZ93RwabxKj07+dQVqjVUHs1YuCsfc=;
        b=bg9Pm2MWZQzgrU4XfE1AiwslREggTKsTujo6SwnrRWSOTqHvYnDBhcPBSyA0i9Z4VS
         7JtlS/HZVj8vIMaeCTlnJANI0WDcYj6luGZtHomz2HB3Gb2+Meqwf/MSe20v/FGxvZrq
         9BwSnr5CafCVRqavYFPAHxeH70TD5IrUNqY5oz32O2+t47Hl2aW4uQH3pchqhQmoGJrJ
         H5IhuvgdLtEAAyWB9r6/LFfFlXDHuFNMN+w87OvNBmm93thaJlZ9ynC6zuxLugpX/sNN
         sFoSH9/gjU6+Kne9Lk05BBwYw3k+JQi/UmnhyJub2H6H7R2xOZ/mIQsRrkXzMyIXHh7q
         /0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733954435; x=1734559235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=La5gJeu6ZE78YNZ93RwabxKj07+dQVqjVUHs1YuCsfc=;
        b=xFK/H7BBJ6kEwwSlucZHkxUdZBa9WXIJWhdw2rqrCGbBMuOD1qSKCbn2rgwWEui2DM
         R92ZWaJM3Cy21svk99xSGtm7FnexRke7XU/E4V9Y7XbtUbdYWiGuiTTeda9qYjX/b38F
         8aAvL82kp44N/aaOjwaruZWQa45IVHtkGLX3g2EvJR60gDFqvQLAh4SeWvgt3qr/fJsB
         fQgMR1QtoiT80qVnMMxIOcJvT0DW3mgfLsUbcPoFdSqXd4QsD64u7+43MyKQaaEWFCOY
         y0OuGWLx1wh8K10BQeDsLxF3T27GvgqFu77+lYWl44ZmApNX+UktFBpYoRJin1qfVGGr
         Myow==
X-Forwarded-Encrypted: i=1; AJvYcCW8VYcTShgamSJttuLDXLTXsq8MmGSGCkfm3cqBfUH9yD9P9mo5PE90ef240q7tdICMxOQBuWRaRAyHmOtzY0pXTA==@vger.kernel.org, AJvYcCXLlR+gJYUeltXyFt7go8NcJXSUmbpjwvnQ9Xm6XY+I7CUHKYb3HKmPpob6c37Ecp2UdqgLCBgQVAQnH4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXDX/bA8jsdKeo+ZS1YV9ukyET5JP52ZxtQnoTTXw8sVzm4Ya8
	35MP43wZnZR+Agqjwh28t9bSSkaWLEbJJWTRWwXPkhtP7ACLUT1A
X-Gm-Gg: ASbGncuVsYPe42r1KrrEfHFKZagtdG1QswerYLElk4Tv/wouEhkVZHkB616wjf7hFhI
	2j2Cl8APPameLOyw5Md0IAqEH1FL2BIfEAmokZr4YFC6mfVs40RuKM1rhOikRmQSv9liUJiutBb
	z1heb1ajFTeQ8pbkmwdWcu332zrKDseiJdbR+f9IINrLD0D9wTwTQajSUER68qT3h96sX97wtLC
	7SWWTfmdYzl6YKVGv/hNAgSKORhF1HV5guVn+eEDw6Y4vj3nRkU4myVVEsnF1TWh9z0V7MSfIHt
	b+VFCPfxJA==
X-Google-Smtp-Source: AGHT+IEgI5PfKlxqpWLad+waN66KbwEob3o1cEWdplgMrEhXiiRaFLYkAWy9yffzog/K41IbAFhuAA==
X-Received: by 2002:a17:90b:51c9:b0:2ee:4b8f:a5b1 with SMTP id 98e67ed59e1d1-2f128031e61mr7132275a91.24.1733954435430;
        Wed, 11 Dec 2024 14:00:35 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2700cccasm13912665a91.22.2024.12.11.14.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 14:00:35 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v10 07/10] perf script: Display off-cpu samples correctly
Date: Wed, 11 Dec 2024 14:00:11 -0800
Message-ID: <20241211220014.931479-8-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211220014.931479-1-howardchu95@gmail.com>
References: <20241211220014.931479-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

No PERF_SAMPLE_CALLCHAIN in sample_type, but I need perf script to
display a callchain, have to specify manually.

Also, prefer displaying a callchain:

 gvfs-afc-volume    2267 [001] 3829232.955656: 1001115340 offcpu-time:
            77f05292603f __pselect+0xbf (/usr/lib/x86_64-linux-gnu/libc.so.6)
            77f052a1801c [unknown] (/usr/lib/x86_64-linux-gnu/libusbmuxd-2.0.so.6.0.0)
            77f052a18d45 [unknown] (/usr/lib/x86_64-linux-gnu/libusbmuxd-2.0.so.6.0.0)
            77f05289ca94 start_thread+0x384 (/usr/lib/x86_64-linux-gnu/libc.so.6)
            77f052929c3c clone3+0x2c (/usr/lib/x86_64-linux-gnu/libc.so.6)

to a raw binary BPF output:

BPF output: 0000: dd 08 00 00 db 08 00 00  <DD>...<DB>...
	  0008: cc ce ab 3b 00 00 00 00  <CC>Ϋ;....
	  0010: 06 00 00 00 00 00 00 00  ........
	  0018: 00 fe ff ff ff ff ff ff  .<FE><FF><FF><FF><FF><FF><FF>
	  0020: 3f 60 92 52 f0 77 00 00  ?`.R<F0>w..
	  0028: 1c 80 a1 52 f0 77 00 00  ..<A1>R<F0>w..
	  0030: 45 8d a1 52 f0 77 00 00  E.<A1>R<F0>w..
	  0038: 94 ca 89 52 f0 77 00 00  .<CA>.R<F0>w..
	  0040: 3c 9c 92 52 f0 77 00 00  <..R<F0>w..
	  0048: 00 00 00 00 00 00 00 00  ........
	  0050: 00 00 00 00              ....

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-9-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index aad607b8918f..87b2cedc1cbc 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -662,7 +662,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
 
 		evlist__for_each_entry(session->evlist, evsel) {
 			not_pipe = true;
-			if (evsel__has_callchain(evsel)) {
+			if (evsel__has_callchain(evsel) || evsel__is_offcpu_event(evsel)) {
 				use_callchain = true;
 				break;
 			}
@@ -2358,7 +2358,7 @@ static void process_event(struct perf_script *script,
 	else if (PRINT_FIELD(BRSTACKOFF))
 		perf_sample__fprintf_brstackoff(sample, thread, attr, fp);
 
-	if (evsel__is_bpf_output(evsel) && PRINT_FIELD(BPF_OUTPUT))
+	if (evsel__is_bpf_output(evsel) && !evsel__is_offcpu_event(evsel) && PRINT_FIELD(BPF_OUTPUT))
 		perf_sample__fprintf_bpf_output(sample, fp);
 	perf_sample__fprintf_insn(sample, evsel, attr, thread, machine, fp, al);
 
-- 
2.43.0

