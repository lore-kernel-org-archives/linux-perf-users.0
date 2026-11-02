Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621748;
	b=fpHFuSA1gA2WrMiEpw49w2iizBsIgvc26XkfGhMz0kIf4xtFQzFNfazO7BgZja9tAWI9
	 qMH9Jc+Eaxl44BX27YsVEJOWDwKEWFeE9SU8c5921F45irjwNO6etCTOEr+c8gWN+ZxF0
	 KQiB5ugjRUTy7u6Al0FK758nhnhdCVHvr+Luo0xUZbDnfqKX+Dq9f05JvUVzRmQeEOHiJ
	 wYBbCKUg0zhCSebGQ2Hxxed3PZx74RRgJFp1//6Xb32uC6r+VXJ8cK3MBZ5/hyflY9+d6
	 F4DfVBlcLNKNrPu0Z7DoaTGWZN+z2kTR0pxVinEUGHO3m95UVT6D6EfFv7ujgXIN62A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=L2B9ns5uTBuNRhpXpJp6nynxxt5/vvxu22eFQQ/6ykM=;
	b=3N3PzpGwCm9QwNOSpa9hoBO3drPEYIxFVAtzZsaSRywTKLR2l40Jx9dLS8Qf7VxaArus
	 40Nikbv2X1gu3yySbHINhNl1Ck64WuZzX7GHpfX2z7q0OS11RBqeRuTBJeUnYYPUuwATh
	 HgMEqElIAJfWLLtuqcaKb64YB5EBFqBzw6iv2KYIFOmI59hLFZL9rjKp/MBHRgBU+W0Bt
	 RQ6E7EzvjAUYbMASxeK+aPPpv8J7/7Jy8p+xDmnz6VZtnuwpHd1fYiGQnHyYOzN1m7efw
	 L1A6gsfE5/SqUZli6FEdEyQYV9uE7DLqCrAJwbXgOpOIPH8S1X24tzTqhr4XNh5YzhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=npdaxsTp;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D758260A2627
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D758260A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=npdaxsTp
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so25866895e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 04:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793621746; x=1794226546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L2B9ns5uTBuNRhpXpJp6nynxxt5/vvxu22eFQQ/6ykM=;
        b=npdaxsTptWNzh369WTt8pLs6s6TkKz+NhpSVCw77vsiC4AkCuJKFFckkZfUWRtY8LZ
         sa+Is7oX/Sc/unqlV8wGmYKDCntNnqqc/qmv3rWhafzV0ZsIqlqsmAZokUjhrCJT3jqn
         1kIAYAfkMTKr1/+/GCiBzfRkBBVQUNn2M1SjU9B5a/D4uQDgievMrTiIqHmszxQ+GhMZ
         3zqZSC4IXVijBxmG1f126ePlb8mgfnw+iNCc+g19wbnLZJ2wLrtuqq1c7Z5YF5QpQtT/
         dv6YwrOSciQ1hTfWe7Lt/yEKogwJTIsUCxaR6nL5bqEcnnCOkLNraHygqxVX6sPGwX+O
         i4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793621746; x=1794226546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L2B9ns5uTBuNRhpXpJp6nynxxt5/vvxu22eFQQ/6ykM=;
        b=gNkyFnB1+wuCowNal6Ai63uUrz2vplxZnyEOFywkJb5urHt2KyBEG5/Z8Ihg4H06gU
         i4hYrrBDIwU5ucPKo8DKh9sBHQIvbhDdiJ1QheNCdDn03UPu5k/tfN1c8LoJz95sJbfv
         2C93YUoVv+Jh3g9cM+tqjt+aCQAAbtyFKZ0CCc83yVvZ+BGK3OMOPjpd4P5poIMqb/0O
         bDcBMl/WaRU70DZCm6/DgXTMyTi/GcEOrYsSD+YWJWHbetV1uqsgh8bENV6wIZLbGOdQ
         QitY5v5Cbrnepr5j5/5SNGYBuVRkxnWkJEG3r23h7z9jNd04iTg9m/NHUQ0MOMyaTk7B
         H2Ig==
X-Forwarded-Encrypted: i=1; AKwUvBzjRa8nn1vXWlpFByTW9DsHHxu0zaA6508+/v70RyH3rFbFtYwXCHObEV7Kv654Yp1Ocwpg2YsSfBSN8tMv8yoY@vger.kernel.org
X-Gm-Message-State: AFq9FYK5rputL3lt+nu5Nko+n+9npMDRbwo8bg3qO/Lw05hSB7fnSI4+
	3sujwsqLRP/e5voqk/W3QusbYTyD21dobVpfPA73qt2GlJJUokb0VsGsQZI7ZBfBG8w=
X-Gm-Gg: AYBFou2pcl+X91zk47x2kpnhqqWETYdpxFRxC0P2ymaHhx0zpv4Fh5PGHbxDKhkMqS6
	oA/tWsz5AkgUZveyLMD+QIpN5WIt2qghyNth/rM7/4nR2qSF9C5+UUW7UBmugEIRSvKPkpywhn0
	5EYducYQUsWWFJYzUv2SDDLBS9ha7beazC1dxORgwLe2YEs94lbCL5q+P9uBL8ZQ6+4A62LvCum
	tNCE8n2/wuxYM4ZfPgQuKn2jydWR+dxHTujyEmJjvQrL/uyLpLS6F6u6zUOj9qSlKu0fuMxosdW
	uL56ALOpbxC+prI8WTjIypz/Yr+GR4d7F5TizN8b4zuyUkSNDdWn4WZpbVrdcBva359JOecZqs+
	dEdGABvZzCWQlNwmcLvOimQg6YcEwD12wD5G8M9qG7uX6ZEt8i81eW0PkuJgz0tpshMZgy9cj3s
	WmXz8k+JN8iw8P3EOs2dDALYD9S1YEm3Hhy2KdElFPR0GhRTXcfLluA2qq4pQusOxs2822bCjvx
	d+5gHZoUWcmIU28SScQnV0IQI4d11MYXMtMAWXQLnYwvaI+dO1PUq22UevFe0xGvRZ7u7Hc5CML
	Hl+HD3Oem+f/qYl5LSYPKS4oLOwk+KmH
X-Received: by 2002:a05:600c:8b01:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-4ac16fa4f73mr240104835e9.8.1793621746179;
        Mon, 02 Nov 2026 04:15:46 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm434974855e9.3.2026.11.02.04.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:15:45 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 02 Nov 2026 12:15:17 +0000
Subject: [PATCH v3 03/18] perf cs-etm: Turn on context packet timestamps in
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
Message-Id: <20261102-james-cs-unformatted-per-thread-fix-v3-3-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
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

