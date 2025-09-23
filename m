Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF0D31B12D
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 22:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666841; cv=none; b=QZghDy47qKZ1T5AIrr/37YCG3ZTfRpVnTuZLyISYjxwUZnKKE6wNla1T036TgEn//Gfdl6Rl9lEFh0QjDnsfaiWhBOnSXqJ4i+BqnD7Rlr/N8anLqlCAJzltC4LW+uBVvf2RHO5CpX4ylOemvDRqUEFUZV+VdulWrY0Wm7YNOhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666841; c=relaxed/simple;
	bh=lv+orrYEZfCCmS3CajyfSe+YtFwMzynEb1XCScLZ0M4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=UKEILwpk1JHNysRgMwVJ4phQ3CYJEtniTA28Kg5gUyVoyItZ5A7xq8wTqmncFpT+skl10YGeuePpuh82snF043PtfILeXgIVrWzOYAcsaSOQhHo0MM6QiYiY44luiOy0QqMPZ/y4fdhG8iYNtr6V7bfGPOeDjflUd3/l+UNdDgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S/hV4K0n; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/hV4K0n"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ec2211659so6291489a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 15:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666839; x=1759271639; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0IRX7WpoC8G1Z7bNmqvaEWKqeWN2XUOf87Rof+WADfg=;
        b=S/hV4K0n7sM6LYxghHC4DXNTmM3HsI1Pqx0VOCYvuRHidEhS6gTRtJldqNvmsWpukT
         0V/nIL8yHuip5bB6ztSFuCaIoFY7oYawo0K/k0yVWpa2q8hIH3qSwgMZ9NSOQQfnLqUE
         yz/wSgw3iwmtASAuGm3G0YdR3oU/8XllDmUzvMZai7aF+g2HXHz0np8hafwLpkKUXQlm
         gdqxh1htOdr/OXLK+bD2jt0aVmPQmmsw9XdPl0E9ULPWC8KvYS+mYjSgrJMx7NfyXySE
         03B0i9v127ndS0Seveqi6QCpcO4W/gb32cmJi1z80cNyTsMDffx5OHoGQYcqoB52s43I
         SLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666839; x=1759271639;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0IRX7WpoC8G1Z7bNmqvaEWKqeWN2XUOf87Rof+WADfg=;
        b=OORYLDbD/p2tTCheIrKVT/b/2+cgMPnv7LOeNOoBRba6y3dfxEKYXqxHG4btciR37N
         pdqOJeyqAtBh0NekBGDmQSBZXkOIXGZylrirHhoD3LloJSAYquP577YvqaEllSekuu7o
         jWhW5HA2bQpVsSVqSAOPcLsoz4R1v3tcsq0z5nAWxIGQJ1OmTMub/OwRsDvm/ahDjYfD
         cVzBWVbPEN3rgPU2zn0BnBEgRpxZ/HaaI6XQV5UwtykpZ99P/YkfjJ73zJ4JN6sjKfCj
         /9Kb014GUwU9gA88gAz03gmy1xZmojabObxHJB8pSE5qLhinrmSf1II/cQD70Lpq5jCS
         VgZA==
X-Forwarded-Encrypted: i=1; AJvYcCVb3ra0ANOaXvqwQsgO0ZwC47qiL391kE+EH7Kn7GkJC2C+WI5xXZw/H+1j6LHbf63YR7sp27ervoyBM0agg392@vger.kernel.org
X-Gm-Message-State: AOJu0YwW5eNAM7bloLgGN4mx2jaNQznw1lQjJOU+QoYRbztdMXU57XAG
	ozgVmQS6KiMbHksAcv7X6+Wa17ZDa8SHIdCzJn4Mg41W6DllWXEUSeIIQNwGgu2y8lwuOWK5Ibo
	pac6YbLiADA==
X-Google-Smtp-Source: AGHT+IFYItRqxTLqJ6zVJ0IyAoYR9T6X4UNxYzg5FOVMLrHtT1npSOxhldI3Jzp/xirB70IPx44qshtRCo/a
X-Received: from pjbsn16.prod.google.com ([2002:a17:90b:2e90:b0:32b:50cb:b92f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:53c8:b0:32b:df0e:928f
 with SMTP id 98e67ed59e1d1-332a9c1bb8emr4732879a91.37.1758666838868; Tue, 23
 Sep 2025 15:33:58 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:33:05 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-22-irogers@google.com>
Subject: [PATCH v6 21/28] perf evsel: Improvements to __evsel__match
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

Ensure both the perf_event_attr and alternate_hw_config are checked in
the match. Don't mask the config if the perf_event_attr isn't a
HARDWARE or HW_CACHE event. Add common early exit cases.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6a31f9699b49..8c60f79a76ca 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1863,16 +1863,19 @@ bool __evsel__match(const struct evsel *evsel, u32 type, u64 config)
 	u32 e_type = evsel->core.attr.type;
 	u64 e_config = evsel->core.attr.config;
 
-	if (e_type != type) {
-		return type == PERF_TYPE_HARDWARE && evsel->pmu && evsel->pmu->is_core &&
-			evsel->alternate_hw_config == config;
-	}
-
-	if ((type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE) &&
-	    perf_pmus__supports_extended_type())
+	if (e_type == type && e_config == config)
+		return true;
+	if (type != PERF_TYPE_HARDWARE && type != PERF_TYPE_HW_CACHE)
+		return false;
+	if ((e_type == PERF_TYPE_HARDWARE || e_type == PERF_TYPE_HW_CACHE) &&
+		perf_pmus__supports_extended_type())
 		e_config &= PERF_HW_EVENT_MASK;
-
-	return e_config == config;
+	if (e_type == type && e_config == config)
+		return true;
+	if (type == PERF_TYPE_HARDWARE && evsel->pmu && evsel->pmu->is_core &&
+	    evsel->alternate_hw_config == config)
+		return true;
+	return false;
 }
 
 int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
-- 
2.51.0.534.gc79095c0ca-goog

