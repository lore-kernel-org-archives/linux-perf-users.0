Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0157220F33
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 03:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749613576; cv=none; b=lIhlZ1D9F/cmG6P1GsoLVpvUxPEJcCGRmx/uCT8QTwUE9DcPHJSza501Im/wdEoCW9X0uqc/u+V9pf3isPGTS8qWvg4W2ofPT7XHv9nVmCPkL5Zf79kdoSC+U9VOqbqB00qGCwCcGfE0io8ds7O7AiNwZkbvXL+r0LtZP8TS+1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749613576; c=relaxed/simple;
	bh=w75vlGAuULUigeQ7NC12gcNLDLfy5b2P2WGmKrqlzfY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=St/JtquajAgnrCKqwY6+4vJfhGGj0HOgZUTKj2eYigaGQ0zbHv01V1pgHmOE0JDHVH69q9vZdwSNAM9Muo8YYx56C1RZyoE8R16TlqfEMAZGVnmGupjHyufgDC99qGvLhJj+dhypBNy3y7TeEx5HkqDAorsdkAjMJTXmIVp2yf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q0YTNOGD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q0YTNOGD"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311b6d25278so6006266a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Jun 2025 20:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749613574; x=1750218374; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxsdjkb4V6FP85dTNyusFArFxiD/4CkT/SqFYLClDmU=;
        b=q0YTNOGDDVW6rmNn78qZp63uem8ORbhS9Crxnu0POcsZ02R1RpynYs3gKeJbfnprrd
         iVyHdayGgGiQGl4IEbX6gTlahKfTXPQYYD4S/QN6wp3iBFCpryyzp+Nb+MRO8UjLmdy7
         frq+tKT0ymE01CsaNZ+UJhaDQywOAnc4WxwOnt7eB9MUXWZ04NqePUGsLWUbOFSrDUPD
         1TeF7wZmvnBlToALLqZiVLcGjDPxnD8qd98YHKPAcHiLQ/b5GRhUWgTsJX4vbfGgQMd8
         +AktydaLcGFRGyh5Jshi9kR1HN5YEWGDRzBFERgdYnZKRHpDnN8c+32DYJBUtjiDBZ0Q
         pMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749613574; x=1750218374;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxsdjkb4V6FP85dTNyusFArFxiD/4CkT/SqFYLClDmU=;
        b=fUZELhY4IEmXoQ0qo13rLf8ma+8zTOFy6mi+4ZJKQSCBf4ukdaEsC2MSp69NcoOM/I
         Ph3zuB/KI69R/BuJxLaEpewvT00XmmLfm2k5lF9N959fYxcQiqesqttfZHh7Q3t8HjIU
         MxFvOhgk330RgQ5tpKc9p1/Oeqw9yZ1DiBJoxTTaQC3gGpSPZrkuIdPWqroYwC6LtnM6
         lx3UxbIEcSMu/eZDuzCf8LtZFNrpZgWfr44wr6Cp52HDThlvjPli/N0RLil0KAyWVOlq
         Qh+upvQLq5XoxewRMdlwIrhTiJyggwT5BJjdqfbkbwaNPzTHF1RvNGVnBfRDyYQGCsIM
         VMfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZRcJKdZ3aXxCXll9BmZq7VIbNNkStxik1iV18sad9YNEkO8Lec6S9ihIoFmqdN5bCspjGBx3rFKagkWvGjst3@vger.kernel.org
X-Gm-Message-State: AOJu0YyDTqpu/MUvCqFkOVWtCuld+Q8doNQcyg1BASm9PKaS+RJQz2YX
	ZbN9wjI8xDV1mcrGWZpK+r/ZJ4iKRH/tNJzN+Ro+M1esxzK1Gm35nzM6DHxZ4ktK7M8i5ia2W4+
	FniYH9AuBtA==
X-Google-Smtp-Source: AGHT+IHy4rfVWxQiAA7ASCsBC0UfOxJoftPgGXIPfBQsa/ehNK5d58bHZdO5A8eT6J4CH5WlgLX5RP+Jn7m1
X-Received: from pjbta5.prod.google.com ([2002:a17:90b:4ec5:b0:311:8076:14f1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5206:b0:311:e4ff:1810
 with SMTP id 98e67ed59e1d1-313af11d9bfmr2549755a91.3.1749613574030; Tue, 10
 Jun 2025 20:46:14 -0700 (PDT)
Date: Tue, 10 Jun 2025 20:45:16 -0700
In-Reply-To: <20250611034529.508842-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611034529.508842-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Message-ID: <20250611034529.508842-3-irogers@google.com>
Subject: [PATCH v1 02/15] perf parse-events: Minor tidy up of event_type helper
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Andi Kleen <ak@linux.intel.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add missing breakpoint and raw types. Avoid a switch, just use a
lookup array. Switch the type to unsigned to avoid checking negative
values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 31 +++++++++++++------------------
 tools/perf/util/parse-events.h |  2 +-
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 7f34e602fc08..9dd0216cfae4 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -135,26 +135,21 @@ const struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
 	},
 };
 
-const char *event_type(int type)
-{
-	switch (type) {
-	case PERF_TYPE_HARDWARE:
-		return "hardware";
-
-	case PERF_TYPE_SOFTWARE:
-		return "software";
-
-	case PERF_TYPE_TRACEPOINT:
-		return "tracepoint";
-
-	case PERF_TYPE_HW_CACHE:
-		return "hardware-cache";
+static const char *const event_types[] = {
+	[PERF_TYPE_HARDWARE]	= "hardware",
+	[PERF_TYPE_SOFTWARE]	= "software",
+	[PERF_TYPE_TRACEPOINT]	= "tracepoint",
+	[PERF_TYPE_HW_CACHE]	= "hardware-cache",
+	[PERF_TYPE_RAW]		= "raw",
+	[PERF_TYPE_BREAKPOINT]	= "breakpoint",
+};
 
-	default:
-		break;
-	}
+const char *event_type(size_t type)
+{
+	if (type >= PERF_TYPE_MAX)
+		return "unknown";
 
-	return "unknown";
+	return event_types[type];
 }
 
 static char *get_config_str(const struct parse_events_terms *head_terms,
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 1c20ed0879aa..b47bf2810112 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -21,7 +21,7 @@ struct option;
 struct perf_pmu;
 struct strbuf;
 
-const char *event_type(int type);
+const char *event_type(size_t type);
 
 /* Arguments encoded in opt->value. */
 struct parse_events_option_args {
-- 
2.50.0.rc0.642.g800a2b2222-goog

