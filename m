Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CE630DD21
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Nov 2025 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763500436; cv=none; b=I7p6PhLKpYXTRoQQhYvS0Ihs4SyhAs8/sG1iPWsWWZ+AU2YyQ4YOQxK35lQ4JUT0uAqFoJ2+SyqJJBNSGqxya2XHWc8hGp+hdx2J1pQn5kN8eWuIpIRQ5UI2etS8QXWbcBjLnQXbD8GCihzrP7/kFRnITI4KKzkcXZnGLN1fXGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763500436; c=relaxed/simple;
	bh=fo0lBaCJ8TXTQqOuC1gBkqakdTjeMs11JfM9cjP6hW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ONyk0YMK2XEZBtYTu1HsCR4eVEKkUSHcjDebNyP4W0oz+lXkyp9mBlwOnWc7sQL9hkNLvMHIT6Vcmoo/NsSmUZbukRE779nzC6bq1layNzQ5wV42CYzMBfMMtGUqSRnpEb+8hAEjVtzNGAGd/OMqoFtSgNpZ1TRApeJOfgre9Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fglS7Pc8; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fglS7Pc8"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b6097ca315bso13510703a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Nov 2025 13:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763500434; x=1764105234; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aIy78jgPSEM3mVGd6NsXjCvGBSaI620v4P+4Y2lxS/o=;
        b=fglS7Pc8ALdtQJtWX3jcnUVcBa9HkHzTWigqs5kmNz/PezH14IPqeZz4ttUyZU9yjd
         n2dydAzg7s8Cmbv1lLu6gcZMRPru+83ey7HQbLf5aSWrIiRHcmKyiS02R7//TobhD335
         gXXCIzkwAbcxUqUnzIbSwIUdI2MesyS+9K7lYu9K6CCa2W5FTOiLGkV9lj1wQv5KO8tf
         j+j+UF1T0mc2hsaaDcGPTnJIEjtLf/zRxTwFQU4wqtMF2D4/4X+tG/jIDtTWBd5YB4kH
         2RqtlxtwPCGAYjYZOBERM6cEc+k+ioxdcGuUMqJz2d0k/9+cVJK089/ZcK7X2CKqB2CD
         lGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763500434; x=1764105234;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aIy78jgPSEM3mVGd6NsXjCvGBSaI620v4P+4Y2lxS/o=;
        b=lHk9Q8Nh9rERVw4L+NIanOda6Sgk6L4KHWr4AcJKp8BEbKfyWDpnkvDG8WdvcJ0HH1
         HfCd31J398bkjuTYBqT/1ccVRaIVsSqPOmPuRITPqhqLn1HrlZD7e/qLkBT2BROuUyEH
         mbp6fGWdhWyytwN0MKoNJqSRwRrvEgzNLyOysM+7LsLRjmNPStQW9Z6W2BZ4j7NBzOaN
         EtttB2g7cPWZXjwikk0IBH+4Mqs94stMfZqy9p9bx3f+rBYy5kmyYzIA+Noz45Z6q7uV
         Scq1/PPiwY++GsVrHL+AWamv4o++z2iHuNOfybfisnTSTHjE5me8cTlpkEI+Kid1xlxr
         SIRA==
X-Forwarded-Encrypted: i=1; AJvYcCVj5v0xxvVktW+xlX/FPg/iuVDysqcXGPjoNNj2AnqCTsdtE5T40jYZB78Rbh7cvMh4Q1iyAKP+H8lzp2WnzFMf@vger.kernel.org
X-Gm-Message-State: AOJu0YyD8fp0CiX7kjGherWTwdHeSx9b3jFx55oArKHM23HI4WdtANe0
	BMV1VvvqeoevyJTwSPfrpbUlO7ectPDplEqBWAAbiIUF5bdakcpnVLMQZUY8W+KbFiNBaeI6fqf
	/OQjQspN9mw==
X-Google-Smtp-Source: AGHT+IFoglpTPhHBQpx7ZM56yubi4+LYL6d9Q4jDCWS2Dl//TIZIFoBoOq//bqAg44uNADK+ncYr6Mmjtpzz
X-Received: from dybqf15.prod.google.com ([2002:a05:7301:648f:b0:2a4:6ffc:87c9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:152c:b0:2a4:3594:72ee
 with SMTP id 5a478bee46e88-2a4abb54770mr7416694eec.29.1763500434069; Tue, 18
 Nov 2025 13:13:54 -0800 (PST)
Date: Tue, 18 Nov 2025 13:13:24 -0800
In-Reply-To: <20251118211326.1840989-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251118211326.1840989-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251118211326.1840989-2-irogers@google.com>
Subject: [PATCH v5 1/3] perf stat: Read tool events last
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	James Clark <james.clark@linaro.org>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

When reading a metric like memory bandwidth on multiple sockets, the
additional sockets will be on CPUS > 0. Because of the affinity
reading, the counters are read on CPU 0 along with the time, then the
later sockets are read. This can lead to the later sockets having a
bandwidth larger than is possible for the period of time. To avoid
this move the reading of tool events to occur after all other events
are read.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 45 +++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index ca1c80c141b6..5c06e9b61821 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -366,7 +366,7 @@ static int read_counter_cpu(struct evsel *counter, int cpu_map_idx)
 	return 0;
 }
 
-static int read_affinity_counters(void)
+static int read_counters_with_affinity(void)
 {
 	struct evlist_cpu_iterator evlist_cpu_itr;
 	struct affinity saved_affinity, *affinity;
@@ -387,6 +387,9 @@ static int read_affinity_counters(void)
 		if (evsel__is_bpf(counter))
 			continue;
 
+		if (evsel__is_tool(counter))
+			continue;
+
 		if (!counter->err)
 			counter->err = read_counter_cpu(counter, evlist_cpu_itr.cpu_map_idx);
 	}
@@ -412,16 +415,46 @@ static int read_bpf_map_counters(void)
 	return 0;
 }
 
-static int read_counters(void)
+static int read_tool_counters(void)
 {
-	if (!stat_config.stop_read_counter) {
-		if (read_bpf_map_counters() ||
-		    read_affinity_counters())
-			return -1;
+	struct evsel *counter;
+
+	evlist__for_each_entry(evsel_list, counter) {
+		int idx;
+
+		if (!evsel__is_tool(counter))
+			continue;
+
+		perf_cpu_map__for_each_idx(idx, counter->core.cpus) {
+			if (!counter->err)
+				counter->err = read_counter_cpu(counter, idx);
+		}
 	}
 	return 0;
 }
 
+static int read_counters(void)
+{
+	int ret;
+
+	if (stat_config.stop_read_counter)
+		return 0;
+
+	// Read all BPF counters first.
+	ret = read_bpf_map_counters();
+	if (ret)
+		return ret;
+
+	// Read non-BPF and non-tool counters next.
+	ret = read_counters_with_affinity();
+	if (ret)
+		return ret;
+
+	// Read the tool counters last. This way the duration_time counter
+	// should always be greater than any other counter's enabled time.
+	return read_tool_counters();
+}
+
 static void process_counters(void)
 {
 	struct evsel *counter;
-- 
2.52.0.rc1.455.g30608eb744-goog

