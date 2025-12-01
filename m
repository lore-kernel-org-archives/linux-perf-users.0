Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EA028B7D7
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764630564; cv=none; b=Q46XytlaXdbT0oPRs3X5+NemNl04TtEfah/2lAXxtpR3pYsW9RyMSHHqhHQ5UmZVv6aOavuvmrfrL4U9dRsGmX1GiTg6oCv4JlHnKnsZMgApe6ftzZovNKhbX33PgaPiXCY4y3/PKwABvmhOsu05zKf1Lc2o79YWX3nhfG2GWnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764630564; c=relaxed/simple;
	bh=2obp0BhhqLlIKo9Gf+Zxxt9mfxdRteUvCTiXMnPh9s8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DcVgwMuOfISmVA38DezOdcGi8ao0krMKZeZhpUvHmTqPQAfjklEHsxj9WuHUh/lzRfYPyUUWpKgSxtAAGiBfNR41PA0VdKEMPkrvJymrbcNXehRiNvjDy4JgQ1ZUm9hFpkMxE6zWTO/0R/0Yw6VrfkJlhFR2f9vTocO7cs4B1uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gTQAZ2tb; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gTQAZ2tb"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-ba265ee0e34so4437585a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 15:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764630562; x=1765235362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p6G0xtuWimuDHuVGryY5GUxMGjGPU6lBjP6Ej48pwDQ=;
        b=gTQAZ2tbumTZYiZ5am+prkUjJsEDJaqxbwYainOohKYivyVhtY9mmCrU/8Bm2Kr1BB
         alj1DBrDWUmPeMw9jrJYp3l6eE/Ljy1mBzSuJbFwq7CdzdUxQ05ePSZF/4q5YSFv/6Ma
         kWwB8dWkiph6Pj0qxegwthWcTrJKwXNMWMBbXZNW8fq10gZu1bQdFOOPaazubgqs/Un0
         qWtnq89cE9+JxnPVdPVg8QURp4MjlaEIAFoSKPBOefgcqBQ5GHLqL/6r7klCzFusw8Un
         b9d8Q7bLtnW2nkOBL70D52yHeHwBblwwVM2O1HI9LPl1RK8hlm855JyRN8JXH6jQm8vn
         vQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764630562; x=1765235362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6G0xtuWimuDHuVGryY5GUxMGjGPU6lBjP6Ej48pwDQ=;
        b=GnNvRDst0M5u6TXPOGsGLTQ+DOBbyi8iCZEh0FMlxOrS6fdV820T88KvHKchXFbvxH
         CHJEjIV6oQJz3Tn1mRVOGVJoce9iySXb6R+bCnap732rPLzI8NVT0+bepPDZ+TVGlNFx
         UG0WoCn5YUEKV8Eo5y+5XKHRvJxOVGPvYU4ubm4+6WpQzBDpNNH09Z9hXAkBQXZDmArh
         FwLRUShJK4omvqkYbfq6PYLgvv+qc1+60cY9SJujjjK0BseRefr27G5XIFEOI4RFHGP4
         dak1GOamGh2hYYxwzm8teauM0WXfg8c0gyzKZXnVKZOIdO/cOA414xMaTm1lGPYnA06P
         u1uw==
X-Forwarded-Encrypted: i=1; AJvYcCUKBSEXdWNlgvnEaIruVcw1KqorOiz5jXp1q69WNWxWNMiKX3bqGiFfi7CTxt3mmGDSA9UnM0FdlLX8WlwaInn4@vger.kernel.org
X-Gm-Message-State: AOJu0YxlYA1FkhkY8EqsJZbfVvoAYOTGD++ieC1aN/P+4blwelDKl66a
	UjKYzTbcBa0C2HZeCqBqBOY+rwMcREcLVovP4Pyj+QQcu6tGHiGeloHJJ4wx3MLLVprNnc/s1xs
	GA6g/bD09lg==
X-Google-Smtp-Source: AGHT+IF62B+VBMVDw2KKLtGlXfuecsoKZsIUsv5pBFnfU/y2mRIk8gjx+pWScidNcs1MiW1F4rSwvnP6TLbS
X-Received: from dlbcf14.prod.google.com ([2002:a05:7022:458e:b0:11b:1966:8735])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:221f:b0:11d:c22e:a131
 with SMTP id a92af1059eb24-11dc22ea170mr13595822c88.3.1764630562140; Mon, 01
 Dec 2025 15:09:22 -0800 (PST)
Date: Mon,  1 Dec 2025 15:09:02 -0800
In-Reply-To: <20251201230904.290733-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251201230904.290733-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251201230904.290733-2-irogers@google.com>
Subject: [PATCH v1 2/4] libperf cpumap: Fix perf_cpu_map__max for an
 empty/NULL map
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Passing an empty map to perf_cpu_map__max triggered a SEGV. Explicitly
test for the empty map.

Reported-by: Ingo Molnar <mingo@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/aSwt7yzFjVJCEmVp@gmail.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 7e88417ba84d..4160e7d2e120 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -368,10 +368,12 @@ struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map)
 		.cpu = -1
 	};
 
-	// cpu_map__trim_new() qsort()s it, cpu_map__default_new() sorts it as well.
-	return __perf_cpu_map__nr(map) > 0
-		? __perf_cpu_map__cpu(map, __perf_cpu_map__nr(map) - 1)
-		: result;
+	if (!map)
+		return result;
+
+	// The CPUs are always sorted and nr is always > 0 as 0 length map is
+	// encoded as NULL.
+	return __perf_cpu_map__cpu(map, __perf_cpu_map__nr(map) - 1);
 }
 
 /** Is 'b' a subset of 'a'. */
-- 
2.52.0.158.g65b55ccf14-goog

