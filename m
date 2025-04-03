Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30006266F1A
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Apr 2025 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743709438; cv=none; b=i4LVHl1IyHtS7mgH00rP9+gKU2kk+KYfH1faagz6ik3AqSwMmQ9FuTrny7WoLQYgtpqQD8JYwDxzCsgJMHFqJjzQqxxVmoTd5kkcfdw++2S7/o5hMvhprYEYq9ma0mzkj60e8YcVSyEGOqBxYJUmiCic8oI0QtdpjKMlR6YA2zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743709438; c=relaxed/simple;
	bh=QIZAAAk/MdLupLUpiD23XMSohaw76ST55IymoNR7/t4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=DMDaCBlQ431QzXTpVDsNp/Isgo/pe25ds+J/Uz5ynXmmapr6lYLzFVb1Jv9O/b1JIZpyWD1SiRML5nC98r3LEWydWx77blRPlGVaTF9mFyKCElLgsLnNkCpjYS+4FymiIHZ5AdqSv/JxRaQlJiKiRQV0ylJajuXREvisv7TUXRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G0vx7jiJ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G0vx7jiJ"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af91ea9e884so724324a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Apr 2025 12:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743709436; x=1744314236; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/yB/Gn9tHctPRNXn6w3PLBCiw087uLsUcXZZ/fWypWo=;
        b=G0vx7jiJiykxIrcG7OROFFpA/z+3PPqoWOXbx3UfH1PLGPxtTCpw0DD+/NYE8WDEqZ
         Odu73KISAhpSyPgnIla384+aEDeU4x1THx+MGRWUSb9Trn6lC1mfWnWVT9Slwbsrdx7T
         s3nrMnb8gRPEYHZgdhK9FarXRMrWU03nhq7uyWefT+B/6HqQLLVriR2U4gddLc0fiPhF
         LlBURa29d2qlO1hNzBb7xF9zWj+B7YEBmO1Cu4//mFeP5vezgJe5tipic7Nq1OipGtfx
         AkwtZZl6zpl3t/1KCue/fMdyGIY6bRjXyvaoeJLmAcV81JwGhAA7cjegL0aGYNaTVqOa
         J/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743709436; x=1744314236;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/yB/Gn9tHctPRNXn6w3PLBCiw087uLsUcXZZ/fWypWo=;
        b=wKcpinEy0/Z3oiw8Gmb53A2n4aYVZjwtPKqvxwBGf2tsu5BbMVK1rKHB9DVQcGOstl
         2C0ciQhal35XcsfV6L+qUMR6k1kOp2st007y+kM7AV/ElXjFy0LyB9ct6osq2BqyUP3l
         ga2yFGTUnzASr6K6/ggyZxV1jhcZhF30SmWp+WedyW48aCNXQgzDXJsxxOebGZLwcdDF
         mPri54mlg9bUnasKRPLAV9lLd4AGDdckKZUv9nXnjJNu3nBjw97xTjRjMaQigxMooaJU
         L20XpfH8nPzJv2fnoqxF3+N3ues41o8Hy8WDPp4nOmRE0qvIB+RyJ7QrVDZjYbZOGWV8
         kvCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEHVlqpv8r7mgSKSJSjYV2h+hZxDFRWJLMhXlEFeL9vrOvRBC0nOFK+ipGqjYvX3EdboiFAsBZ64D7f8IyI0gN@vger.kernel.org
X-Gm-Message-State: AOJu0YwdCS+xTMPvhKtlVc58Y/DV/8Rr5WYQVZz32+WC1+i3koH5ou+O
	x+u20lKNx9LQX+EbatQf+62D+ywuCfE3LfV6wiVJuECK0bdiuxdeaL0yoFuK/0FqfgrYcfINYM7
	B+Ydtdw==
X-Google-Smtp-Source: AGHT+IHPrUcrSNE9tHepYVbX0KrHTiLPITA768YB/Ndnpp5L3XAiSB2Op4yPgZ2vCjpVSVdiYY4nuFOZlI6t
X-Received: from pjbpq18.prod.google.com ([2002:a17:90b:3d92:b0:2f8:49ad:406c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5247:b0:2ff:556f:bf9
 with SMTP id 98e67ed59e1d1-306a4e62893mr773485a91.4.1743709436490; Thu, 03
 Apr 2025 12:43:56 -0700 (PDT)
Date: Thu,  3 Apr 2025 12:43:35 -0700
In-Reply-To: <20250403194337.40202-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250403194337.40202-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250403194337.40202-3-irogers@google.com>
Subject: [PATCH v6 2/4] perf stat: Use counter cpumask to skip zero values
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	James Clark <james.clark@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a counter is 0 it may or may not be skipped. For uncore counters
it is common they are only valid on 1 logical CPU and all other CPUs
should be skipped. The PMU's cpumask was used for the skip
calculation, but that cpumask may not reflect user
overrides. Similarly a counter on a core PMU may explicitly not
request a CPU be gathered. If the counter on this CPU's value is 0
then the counter should be skipped as it wasn't requested. Switch from
using the PMU cpumask to that associated with the evsel to support
these cases.

Avoid potential crash with --per-thread mode where config->aggr_get_id
is NULL. Add some examples for the tool event 0 counter skipping.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e852ac0d9847..4afe963c6a93 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1022,8 +1022,16 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
 		return true;
 
 	/*
-	 * Many tool events are only gathered on the first index, skip other
-	 * zero values.
+	 * In per-thread mode the aggr_map and aggr_get_id functions may be
+	 * NULL, assume all 0 values should be output in that case.
+	 */
+	if (!config->aggr_map || !config->aggr_get_id)
+		return false;
+
+	/*
+	 * Tool events may be gathered on all logical CPUs, for example
+	 * system_time, but for many the first index is the only one used, for
+	 * example num_cores. Don't skip for the first index.
 	 */
 	if (evsel__is_tool(counter)) {
 		struct aggr_cpu_id own_id =
@@ -1031,15 +1039,12 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
 
 		return !aggr_cpu_id__equal(id, &own_id);
 	}
-
 	/*
-	 * Skip value 0 when it's an uncore event and the given aggr id
-	 * does not belong to the PMU cpumask.
+	 * Skip value 0 when the counter's cpumask doesn't match the given aggr
+	 * id.
 	 */
-	if (!counter->pmu || !counter->pmu->is_uncore)
-		return false;
 
-	perf_cpu_map__for_each_cpu(cpu, idx, counter->pmu->cpus) {
+	perf_cpu_map__for_each_cpu(cpu, idx, counter->core.cpus) {
 		struct aggr_cpu_id own_id = config->aggr_get_id(config, cpu);
 
 		if (aggr_cpu_id__equal(id, &own_id))
-- 
2.49.0.504.g3bcea36a83-goog

