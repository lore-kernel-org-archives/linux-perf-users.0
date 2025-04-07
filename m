Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762CE2222D0
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 05:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744002101; cv=none; b=SHGv/yi4TiLyGcqR3/H3DdDhRmmywix++fCclep0FLlgXFZOHyCTGwrqy1iQ1JJE4U3QXi77N85Qtjtyqe31NIsSErLTQKFEnE0X1b9vu8OOKMG87hPDsKl6IPFiiy90w1vAoD8JkZV3cfkSn8YZS+2b0Jugq/bhLJ33Rm0CmMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744002101; c=relaxed/simple;
	bh=4/dJlTWkcf5FOf5+oh0Up7fh8r5QO82sMonPjvpz42s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=S15lX+SHUqvHFwjSgiO2Q2sM+ExD6cfs3SHaK7az0FyIbBvBdxNmmJ7qCa7iAqnU3i3Jmt9R8jQR/raHjjOaAXVDUxb2hbWsGboLtkkO0m2Rf6AF95SoWatL9JRmMNo9puCZgMm7lVVOVvjLaeWcHB6eovRlQV/xH0418NNTB0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2HyDl5o0; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2HyDl5o0"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff798e8c90so3546544a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Apr 2025 22:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744002100; x=1744606900; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AtCRHQR2grinPcYBxNOrxZNvf1a5RF1zR0pJL1Q63Gw=;
        b=2HyDl5o0K4GRDnDtVvjgF56pDV3nMhss75zm8m2xqL5vdDp82j6fBhoSqb5ppjSHAw
         AMwFZBcpOtiL0LBIOrT9M9wGGxpSWVVt1aTimsbmWiBynPAgp/MrCmgeCq5UUUI/dBrH
         2VQXNff6Z9GgYVKfh7WFbPPCYoiyNNuPP1NkmFJ8ejOTxiw7Xbp4PiJTLSguKHC0VPyp
         SBuanuhQh07JOweG2pSUGTTDvx9Gdy6CtwOtRE/iHaGg6QySXf0ARezh00c8xmhRV+EO
         aTNFies2yBk47ZLqpk/AdO6aW6w3JVEFef5w3a7XwhNdl3EnGxbQZTjUv+XT7iDM6jy1
         O8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744002100; x=1744606900;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AtCRHQR2grinPcYBxNOrxZNvf1a5RF1zR0pJL1Q63Gw=;
        b=GSFD09fTAdeoNkoK678bVyV2xCUwpN9YBII1iJYdH9axhugT/g2VGfJMGJBLxwC5qz
         Brk1Ocrogf4T4vUYsmq9dm/SDkt+rTDdGUJoQ2uWvpQdGt1PFlDZa8JS5178zwLVBHZI
         kWCdcvADYBm/E4kzpFHqWBjqK9Hhan6bnStm3g1xWAkUJO7mfK9vE/ibvHx4H1poQA4p
         H41ELHPNH135b2zcfEWbY+2nl00m0EzZtg+KYj3/tzC5NLZXpLURNKo3mYVNZ94GHq4F
         HzcNaAQVD2XXU/wTLsOIqHm4Yc6arVTUU+FiyNIDuYjt5GtfjPcyeZR0kDilZi39WvLE
         FYPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3U5pvhbs0gpXwKFbrMLIQnYA/K1sURlJeiqUvdAlLmMGH5IvEkYv9aYDPOSffdFB/PXVAM17wv6sgPlxwtTzp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4nk2wWeTzdk+X48tU7V9xab0pTsEvoCUdgz080XhqeQ32IrrK
	LMhMHV8v3rfVUiNiwLe1yuXMKJnw63SCBaMg80XU3pqToIWMVlZncytSbRsywmpLJpuFcs1y8mV
	qgWhf0w==
X-Google-Smtp-Source: AGHT+IEjajBXa+ImbR9+M7N6IJYR9vPfq9GEqRJ+O38SQ6pLjk2N6Ar0bQ675WJLx+x+Zi12lyBWB7Q29nuS
X-Received: from pjur7.prod.google.com ([2002:a17:90a:d407:b0:2fc:b544:749e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:224b:b0:2fe:a742:51b0
 with SMTP id 98e67ed59e1d1-306a4b86c9dmr11892592a91.31.1744002099857; Sun, 06
 Apr 2025 22:01:39 -0700 (PDT)
Date: Sun,  6 Apr 2025 22:01:01 -0700
In-Reply-To: <20250407050101.1389825-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407050101.1389825-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407050101.1389825-17-irogers@google.com>
Subject: [PATCH v2 16/16] perf record: Retirement latency cleanup in evsel__config
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Perf record will fail with retirement latency events as the open
doesn't do a perf_event_open system call. Use evsel__config to set up
such events for recording by removing the flag and enabling sample
weights - the sample weights containing the retirement latency.

Signed-off-by: Ian Rogers <irogers@google.com>
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
2.49.0.504.g3bcea36a83-goog

