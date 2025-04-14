Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAED29291A
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652549; cv=none; b=oZzcg1N8wv7xGIN8LNzbyJsjq5z2sOLZiJO3Kh5viyFqa7YzOB7cB5DepwUlezQLPplPcH3CU9MjPFSpAGctNQTpTOtw1C8uQ/3NO7tqcGkTelLoYy3+zxsyTkeM8EAHxPuqomfIRoo0wM898s0NshLPyQp3eF23XSQ8mAnfQzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652549; c=relaxed/simple;
	bh=SomKEZjiqnP411eTa4RWzo05FrdFH31Ut1NNYLapab0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ujgUqNWFUp+ymFZ9HAjquRTKInCHZkyD4y0xdQC5RRP2IbQ+jtWzby5OI/hsZXnvHc7Sgd6UfVLn+BYF93Sz97JRHcqCqUjI3IXaWOyefLG6KUQMo6nGeyrEe+BAGBsuuP8qAxCY/tbTaibIZvfPcjPSZc0O7eqRNLtOdtv0ljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q8ByRYu/; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q8ByRYu/"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3054210ce06so6124238a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 10:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744652547; x=1745257347; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=272QWo3N2/8KrEceZ3Y5V9F3EMqW3wkjRAZ/C8l8AXw=;
        b=Q8ByRYu/GyN3qm1uj2L6QTGrVdUP+WIyeM2J90C6uEsFKqo8Omz3cL1XUJwWScr40n
         p4YKzbHZ3j6QJePcngS6WVM4OBpzgTsY/I4HmnyT90SGePg0X8eAKv0qrknX9Hiuut2o
         dC/qWypLVhilMcFdcdrpquRuiJ8FDO4k4e2Rik3BamA+0GYGrqFmTvDX0edhPUcKupj7
         P4w6L7BPflFrNJfh9o3Hg0QW9XX5R7Bz6bWKqgWQKXuTZIx3SS0rrkN29Da3zGsEymMN
         A77CszdwUT693YBTRIuSek8HVLtJPg3lhunum7k/Q8eGemXIzmeqnfIgsNfRmlFEIKki
         6kzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744652547; x=1745257347;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=272QWo3N2/8KrEceZ3Y5V9F3EMqW3wkjRAZ/C8l8AXw=;
        b=nEJcSv/ueDXtMZ6tz0zDCNBZXDCTU3DNH71pFpz8uUbLqv2pH7j4jTbSHSq2by3BGE
         8+rCGFvicWbDTnU9w7BAZajZUnXf0JsSudU075+cmp3cGkVTYSruILYwSDh0No8VCcfD
         uF8ixL8gHlmlRDSn00MbSsRVUI+gyG+Lacj9pGjgojYCU+ITVEo8qwaCvdHq2TmIqJ3c
         NqtxELpDBLYdckmOroCRUBLtn71wOk5H+KYog8OYEhJADXv2kPtjEsEbN29ackqTcpZI
         rxnZNGPN2W8qrrpHd9QuthaUQppgC4LxKKIkykLVynWjpQuLlHNEeaymGDImRnN2yBpA
         7rhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRTtBA0EdnMTfsRvmea5mZ2r/L2/1BTJh2o5kWDgYrs0wUGp6kVl/OtF2YWpDzrRoeMqUxyA0qk9fpkaPSqvUV@vger.kernel.org
X-Gm-Message-State: AOJu0YwDclXqjXHT/rvvqvmhLmK6kkY7ny9cSAfvf8kgAnnBWTT2dT7n
	T1/xDdhaB5ld2aWpyRw2lg6bNP+Ak6o2GtCSqlFrrCFYCJcfv9uDFAR5hspPjuFBCMAxHXueIuK
	z3MmWzQ==
X-Google-Smtp-Source: AGHT+IHKQXzYZsPd1emW5mymOx2ih0yymDwCa7QOwk9ye4CQI309sFEd4KkK0iKEkR0PdlCtKrtXkduqPk5D
X-Received: from pji15.prod.google.com ([2002:a17:90b:3fcf:b0:2fa:1803:2f9f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:58eb:b0:2fa:1851:a023
 with SMTP id 98e67ed59e1d1-30823784865mr20250837a91.35.1744652547187; Mon, 14
 Apr 2025 10:42:27 -0700 (PDT)
Date: Mon, 14 Apr 2025 10:41:34 -0700
In-Reply-To: <20250414174134.3095492-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414174134.3095492-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250414174134.3095492-17-irogers@google.com>
Subject: [PATCH v5 16/16] perf record: Retirement latency cleanup in evsel__config
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, 
	"=?UTF-8?q?Andreas=20F=C3=A4rber?=" <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Perf record will fail with retirement latency events as the open
doesn't do a perf_event_open system call. Use evsel__config to set up
such events for recording by removing the flag and enabling sample
weights - the sample weights containing the retirement latency.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Weilin Wang <weilin.wang@intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/evsel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 661a07cbdb25..6a84893e3c58 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1440,9 +1440,10 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 		attr->branch_sample_type = opts->branch_stack;
 	}
 
-	if (opts->sample_weight)
+	if (opts->sample_weight || evsel->retire_lat) {
 		arch_evsel__set_sample_weight(evsel);
-
+		evsel->retire_lat = false;
+	}
 	attr->task     = track;
 	attr->mmap     = track;
 	attr->mmap2    = track && !perf_missing_features.mmap2;
-- 
2.49.0.604.gff1f9ca942-goog

