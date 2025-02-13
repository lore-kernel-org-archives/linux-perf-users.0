Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFA122D781;
	Thu, 13 Feb 2025 23:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487625; cv=none; b=KZCMj5m9Ah7B2vKdD8Sdh9XE8/uOhq0kW0M52grLiYZtsRbMzmXe3dIsH/gDveHLFGctNH55FORMIWbrLe+03Tu7MZiky/0tM+qVJjnk3GnVx8wzKYF7WZd/oNLbWsOn9ZC1w5tFr85jl7AvTI/YoWwNwMKUl1wmVeGuUclrpBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487625; c=relaxed/simple;
	bh=UjjR7OdU1VMuMu0dk05ePpEpKY020R6nckVERK33lt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wgqgd7swF11V22h0vYR2nGqVvSOeaJ1ujh/UVZOkklm6ogWTq1+3A6SksIFgxUuXZpyj578TQ9BfUO3fRYK8u2veS6Citquxc1YYKXjzq23f+uxe9k8GxVgboGO56MvYJbJmZJKXSB7qeTJtF5gAODtxHL2860lIHFExxLhWZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnLfDSLJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnLfDSLJ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220c8eb195aso27246095ad.0;
        Thu, 13 Feb 2025 15:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739487623; x=1740092423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aTgCNo0b7SsW3yuyjGgod0qmPvKeo0A7oK4bUI9QpQ=;
        b=ZnLfDSLJUTrLTzO024/NrINjNLAin+idcfXYO8z0oyAxjezPdfN0BmyUrBglimLcg4
         mC6PVzasXuhX26ABywWwawPNUkxiL/8eRAoO7+NxSFROCTBRSLcLQvEhcM090hiud3tD
         s5/hdCAqfFrK9hvhpeg/R45D7TVhs9aTnv9hcKecpY8dbDpY8TGuUVzozbDQ4B4Q4NgT
         a41X7CGTcQzHT/J2TtW732D1A4OkZZfM741V101/HyQ1cvYsr4BDJqNk7NcruOfkSjQy
         8NHhAA71Lbl3Pkx/KoeMN5j0NZhmWearR8kDff0SqnaVic6tpCiO74vdUKSDFFu+BiFF
         UxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739487623; x=1740092423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aTgCNo0b7SsW3yuyjGgod0qmPvKeo0A7oK4bUI9QpQ=;
        b=jZ5yB3RrIT6xjxmWF8fSGuuEu9JMG6BheUsnCYbTRp1gtfvy9dMwY+IMK+v1ZaZo8N
         pvELC4htxtK39wxsO+EXUr9JPOZbS7SFbtUidC9oSTmblDVdAQxOdnt7UNv9nGUqqHsZ
         5mjJsqYBjK2mj1lfD7My+WTOBLSO0PjCmTmU40FzzrIfkTBWpnO3CEyP4XPm3Sbybcla
         hN0mimiIIccV3aO9eJZSJg5f3sAJ4M0OgkeciqEmqkqaLfaD24EjVic4H0I50Tfrl/6c
         n3yXitdreIyhv0vjq8tNt5XGQtdYrJqFLidLw8f6Y2b95m73FI0zkiFOpNYhs8X7keI4
         VLHA==
X-Forwarded-Encrypted: i=1; AJvYcCUeRQ4k5dx/SMJlTWLdJotoTlULOlFhMA5XVROaj6j+RvHcvS59WD8ZahM0tWLDMFdZhWjgxJIZwTvouyF2YGFTrQ==@vger.kernel.org, AJvYcCUgrpqlT9t1kLl43XFswcVhnVCmdBr2wbdbToJdKdVMoNGw4Q+0pqr+RwhqRP65ZgVbmgM+2OdoTPHfHaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygpyOD/hQWwYIh10PigF6yC+RnCNla3tf4xhFzllNbxrNip+uZ
	ya4/uYBqk6/HjawEYX3nCfBGTE0H5Al6UjfQh0+NYEPn5eQhR0Gw
X-Gm-Gg: ASbGncsJgNO0JqwPqp5rMBYB2E6ndHpLiFm9Gmih5lANJB91WRnZf1aPQA460d6B8IX
	tkrvcNXQzNDIhksJxW0rnmLx09MpPqtCD08BWmf+xOgmy8jCXIteV7ix2W2fVgDFDWJNsBWp6vR
	ugGlWkvUYUYURVWs3bJWi2N7JEobiVrabDIHuUgwVMnXXdzAzANXynKqy+m62lO5LC1T8Omnytx
	HjBymbSR2OMBa2os2hrpSccT/6MknyQvrE9zXnLdWfYg8E6f0SnX+8akl8KBMRJfNhXcbs8tbRq
	oYOfzu5Kvy7nHOzVXYK0B0pZ9Pvia0cXqialZAIA/646V0g=
X-Google-Smtp-Source: AGHT+IFr+vj96n7kaUSAg360rDSVM3RSUvO0RDfO4cwkPjYnQqKwJRbpt1kdSySImQrQuX5ER2YwMA==
X-Received: by 2002:a17:902:f64c:b0:21f:164d:93fe with SMTP id d9443c01a7336-220bbc8ba82mr175017795ad.53.1739487623151;
        Thu, 13 Feb 2025 15:00:23 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349210sm17641735ad.11.2025.02.13.15.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 15:00:22 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v15 07/10] perf script: Display off-cpu samples correctly
Date: Thu, 13 Feb 2025 15:00:06 -0800
Message-ID: <20250213230009.1450907-8-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250213230009.1450907-1-howardchu95@gmail.com>
References: <20250213230009.1450907-1-howardchu95@gmail.com>
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
index d797cec4f054..16b500b23417 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -670,7 +670,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
 
 		evlist__for_each_entry(session->evlist, evsel) {
 			not_pipe = true;
-			if (evsel__has_callchain(evsel)) {
+			if (evsel__has_callchain(evsel) || evsel__is_offcpu_event(evsel)) {
 				use_callchain = true;
 				break;
 			}
@@ -2274,7 +2274,7 @@ static void process_event(struct perf_script *script,
 	else if (PRINT_FIELD(BRSTACKOFF))
 		perf_sample__fprintf_brstackoff(sample, thread, evsel, fp);
 
-	if (evsel__is_bpf_output(evsel) && PRINT_FIELD(BPF_OUTPUT))
+	if (evsel__is_bpf_output(evsel) && !evsel__is_offcpu_event(evsel) && PRINT_FIELD(BPF_OUTPUT))
 		perf_sample__fprintf_bpf_output(sample, fp);
 	perf_sample__fprintf_insn(sample, evsel, attr, thread, machine, fp, al);
 
-- 
2.45.2

