Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC182F0044
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 23:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191534; cv=none; b=YSwwgGinPcqq+jWYpKns6wUnBrMBhzJFEo9yMqSQNZ2xsNNxAaRjrlly48T9Qsy8ak8vXk3aZE1L4GrZQJFZq3bVgbZ5hm00VK70G8YEBJLbDRSrs2RKRyHmZOeYxc1hjCmdS6fTZD9HA1iAryBtdSJbXOPZW1sKKhpSm87aIr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191534; c=relaxed/simple;
	bh=vOwZDvr9Vl8FEdFAuVf8wVoxDa4D0UfmaiOanE6AyxM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=c1Q32Kn/SUIl5vNPYgCW+bOO8H6wbVLKVhRPIMAaNVOzYYY6V09En/ydScj4VgUtAEvw3E4RKhZBrjvvR0cBF0ZqgflWpmpu1RPOt9f2JcEfpjBj/htQLrBDQ7ez2H291T4NHYQlgqu1kPNURwwT5E2kP+preTBG1BnTzYIVkM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KMF1siaN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KMF1siaN"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2369dd58602so15186795ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 16:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191532; x=1752796332; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P9BHuR06NtQbT/Ectw1+ZMQbL3vfn86FK+37sdptByE=;
        b=KMF1siaNhhRF6BdDNK6EvHL09zaSIDgSwhmCwdC3C8eDQafCCkys3ngL0Z9P/DL7Lw
         5Qct7U12U/Lb+VUPoXi3fP52bnVlg2Q0AgCIYqFmQleb3wPUDpr464HI8vS0B5DWwZUS
         +XlsGVXpReuxwqyHjmX8R/ERsYNBscjywKbtUVC/ofvDfVzsg+6XYC+bvqiwmQlJfZyd
         JoNDWuQGT3tU2hHUlhvmhwh/gPV1lgp2DDPG4lIc1gfY1DlRQfuFkSS+zjbuubgt12QW
         P83Qi7b9e/TSyINH1EenpavJyQTVL2f+Dss57bBvlUTOpNnLyRMADTnRPMk72ZcjOKox
         NFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191532; x=1752796332;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9BHuR06NtQbT/Ectw1+ZMQbL3vfn86FK+37sdptByE=;
        b=bQQT5iCyC8J3RLGhpF1ObyxVmM1MDsgpZm//ZUOTO54NEk/V4HAxeMbX8im+wZsoH6
         ZQBmua5MzAQPV81hX6dxeAiCx35QmqhH78GJwgAO3EfKbiicJmSlv+xf2J1VhEape5MD
         G1uUj3UBjbjJXDHHkiI8GJO6T35v+774xW+GwBdKPM6iR7oD3KzWmJ1aQOa7lZg8eltY
         iN1coYYg5gVd5ed4xBpE1jlejTFm2R3qYn6DcW00wuRHItypbdVmNQStUxro6N3AHauR
         W9fvddjRmXOWk9m4TMQEj5TU4numcd+EiNF9L1Y3MNwHUmEcO55AqCtLqG2itafiNGQO
         ndJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7hVq0F8wHaCUrJq/6L6NnbKYOxUb3dapDE+lRzQO0/dnBxM6GdP8dIY4lfVd0YXDUJVTKvDyUQIqxMVODMomo@vger.kernel.org
X-Gm-Message-State: AOJu0YzvruWXnnDz3400wZz7ROFFGirNxsuKERUGCAn9z1tRPBP5wpAB
	vE8voSF1b6M++ZNYKCwx5oa9xdyAOkHvumS2JCteYEZ/aaoS2bYUjgHyQLrloZCEHYTQHetPE3Z
	aVgG8EMpfGw==
X-Google-Smtp-Source: AGHT+IGKgTvhcIfECoRo0EwvPfvA3uvrF7VJo3TOsFhyG3H1BqHSXGgjm7Chs5YU2fkMuaqzSbhbCA8q9hBz
X-Received: from pgam26.prod.google.com ([2002:a05:6a02:2b5a:b0:b31:ebae:e100])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e548:b0:234:c86d:4572
 with SMTP id d9443c01a7336-23dee26deb3mr12625565ad.30.1752191532485; Thu, 10
 Jul 2025 16:52:12 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:51:23 -0700
In-Reply-To: <20250710235126.1086011-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235126.1086011-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235126.1086011-11-irogers@google.com>
Subject: [PATCH v2 10/13] perf python: Fix thread check in pyrf_evsel__read
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The CPU index is incorrectly checked rather than the thread index.

Fixes: 739621f65702 ("perf python: Add evsel read method")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 0821205b1aaa..4a3c2b4dd79f 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -910,7 +910,7 @@ static PyObject *pyrf_evsel__read(struct pyrf_evsel *pevsel,
 		return NULL;
 	}
 	thread_idx = perf_thread_map__idx(evsel->core.threads, thread);
-	if (cpu_idx < 0) {
+	if (thread_idx < 0) {
 		PyErr_Format(PyExc_TypeError, "Thread %d is not part of evsel's threads",
 			     thread);
 		return NULL;
-- 
2.50.0.727.gbf7dc18ff4-goog

