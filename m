Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EAA2D2494
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762977205; cv=none; b=Wa/a0fqGCKWBP2k0rSlvrPaUINqo7TSCJn45SEpkY2ij8YNo38MopTpiAIqndGsawcDkiG+SajWUovuM4j9aInU1qUn8L9GbBOao1LdURTX7/9NVPJTAJDCmHnt3FSOVDpa9NI5j+VH3B82ezLPCiyjpsoY4hiPkTUGvZ1RZGT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762977205; c=relaxed/simple;
	bh=D2qFWI5rI9XWj2yv5NMBGr9wzwRjSjUkpoKM6NrqaBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=dFKCpNvCx9p27gpt4USoefZYokRfWcq3c6eL6Dgg9j5FReTcFHqzh8oPEpRBMnv/ZauLC1ORyRtRPIWjzMXJ40fb0h23xC8Cq5kFLHuq/feYUJy9uzLh6espv685v35c41k6NmeY2f1PDfyu/wLs8MMI4h8Jh3LrOJmy4CmLa2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n2MBwKOQ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n2MBwKOQ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29809acd049so59135ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 11:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762977203; x=1763582003; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ohw+LfkBQ7p0CYFFLUG3dUA11yOfDumKvPxiRgcLzqs=;
        b=n2MBwKOQuRfoga8yfU4j1nrMsf7BEnEaMuC5McPjHK+qdCosenEHhUXH2FHN0znjEo
         0scfCvoBl0cvTVR2ZoU0LqB3WxtgWKrVa4eo5qWeRQ0mFWquiGkC6XejJ7d4nNlTzUgN
         M3fL7t+nY94hxKgMQ72C50lFO7OGrxLTtB1Gi3X8EZI+EjUwgbLFLaqKLnGyN6nGDI/v
         HC9/8dBk1M33wH4IJKfN4QQ8IIVEy1MSkjwDkF12CIwnqKAbyNJkYCfPmjrNBZLRAT+E
         o77CeSoy5TvOIK1J+UYw1ZFbtmxak4gK4tMVP3CQyMh9x7ASuzQwjwNtnFXqrczdGxym
         GHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762977203; x=1763582003;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ohw+LfkBQ7p0CYFFLUG3dUA11yOfDumKvPxiRgcLzqs=;
        b=XUYS1okyGlCY275QKG4ADBAwg9Z+2TQ+x/a0viZGHidIKHbYAfJcdsd7ph6bn/hP9D
         cHpUX01Vh/FTl2j+8fpxAhpT+HBRfxBSY+yZBONFVcP+D4FY1NsyLHPwUrItBSc1wnah
         trTEi+skylwZRgc6tP0e/M7g/5+fiSRR4xygYBIV5ZyX3v5RR4Ut+zpIhgHHKe6GPVAH
         uSdJKtMp/PCHpB97dFPBvKwjt2MHOs2QqJzCW8yqLQ0GLjpFHo5hdLYiCwEIcDYbLeIC
         LC46O2VMhRg3Th3qXu8tGyNQUKICfA2BMIFEfH32j1+YHtquE7ZykTgDJGqjmytD/2+x
         WC4g==
X-Forwarded-Encrypted: i=1; AJvYcCXWQnFeThRxQHoTsR7/PwoRAS20usOjl8DSb1ak8kZvY4paTthnZ22LNJUXPEpI6jhnXwBcyULAvPzwXwYQBl7y@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ+SH1qndlZbQ3GUIX5ZUhhm8O+U9Gkfl+f2td3vrLfLK6CLsZ
	Cv04o4ostA2KMlblwnjYC4TCHII8wFJEwpZ9NkDvjEi1uAu0oz7Dv6TDBUMyumUQIbokwck7CIp
	pC3OP2Zjtyw==
X-Google-Smtp-Source: AGHT+IHsLG9tsjG12ghzU+324EEnValmEaNnP/kKoA2IYFkuZTbb8uoThhf/fUIjBEdNGu9yPxQmWhM83Gun
X-Received: from dyoy40.prod.google.com ([2002:a05:7300:3728:b0:2a4:7751:c312])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f68a:b0:298:33c9:eda2
 with SMTP id d9443c01a7336-2984edaaee2mr50098365ad.33.1762977203460; Wed, 12
 Nov 2025 11:53:23 -0800 (PST)
Date: Wed, 12 Nov 2025 11:53:10 -0800
In-Reply-To: <20251112195311.1673981-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112195311.1673981-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112195311.1673981-4-irogers@google.com>
Subject: [PATCH v2 3/4] perf test: Don't fail if user rdpmc returns 0 when disabled
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In certain hypervisor set ups the value 0 may be returned but this is
only erroneous if the user rdpmc isn't disabled.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/mmap-basic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 3c89d3001887..3313c236104e 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -322,7 +322,7 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
 		}
 
 		perf_evsel__read(evsel, 0, 0, &counts);
-		if (counts.val == 0) {
+		if (rdpmc_supported && counts.val == 0) {
 			pr_err("User space counter reading for PMU %s [Failed read]\n", pmu->name);
 			ret = TEST_FAIL;
 			goto cleanup;
-- 
2.51.2.1041.gc1ab5b90ca-goog

