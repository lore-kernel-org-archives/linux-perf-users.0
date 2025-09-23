Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BE3315D4E
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666830; cv=none; b=pG+Z1COBSolcypl/VVrbNHgBSUvylZTIQmGbNTfvFdHMdBCYBUM2bKSjT6NBHl69tYHgqkqSEOxHPhYc5qjw3YYv9n1+Spbuxs2boRS38mKV+rsJ5TrrAFbyzrdwZAVxR1ykhMcuXe0I7g+WJMlDLV++F+87fAZg3ydFqkA8Vgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666830; c=relaxed/simple;
	bh=leffwGmca9/Uyf0CB9QUmGZNZruy/wn2a//pTjcSms8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ev1RRK217nn1EUC7sMXMX6O/t3ClkkiLYcBJ5wyxTSrEPUmB1CvdyuwSCH5iFJ92P930vxAwtFQID2MAeXRbPjakiWNjJGL847Oa03WY29MfzWk6Gg2axlrxRJ0Q9iZHEo9YpQ6hrsMrA+Oyr6QoEQs1S3QFblplbi/pxU1C9Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=25WLwaVd; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="25WLwaVd"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-3548519b6f2so306545fac.3
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 15:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666827; x=1759271627; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e1Y4y6zCTLXlY4E+9adeVkHim03GuNEJ4UhBVjyN7U8=;
        b=25WLwaVdPZty2wQkeD1lRUbPnI2epxPJLmI6i0BkB8/efhXpGlP7qyEoo84vRXVmeb
         l5JtFD7EfKBda6/4/sIAshTsgNj+PYW/5vVQOCnM+GfNttR28oeGtOc1ct4FQix6MfKk
         TbMaxgzVfCl6hvzRmBDQ7c5T+AdLdTEjyXHedQiJYHl72Zu8d7Hzfi8VucvQyygsueC9
         qYG4Met1+D5kNwDQJ+/R35wuAY4cHkOPInjusxpEv7C/gtLPjgOG0BH8IvFdaQqmsvvF
         W2y1+39Ry9h5ML5/dbXBSKs5J6XMvrxNyPYu7aLfHn8atznfafx2SNgX9c2wzu/nbVJ2
         HQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666827; x=1759271627;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1Y4y6zCTLXlY4E+9adeVkHim03GuNEJ4UhBVjyN7U8=;
        b=GUjW4uuIx9z4QdUDuT1jL8MS3xjLTdUr1hpNvYRIux2VULlHG7w4C7j2MD2l4wPvYU
         V7eqDFj8EAcXx85+dvbS0sPlZSa6jUCHH5NfBodvJtpm7j6kcvpteRvr42AwcDSaeuo/
         voDT1sY1TUMLXJQyYZtI3aBKtWTQqcSNb6e3QelUPx39YtGBazGCG3jv6UkbDEpzBK23
         wEk3ZYix2UpSJ8MkzLKUAF7UIlAPLhvBS5ZR3hYECMCY6y65mlCmKCMY+AqPjuGgG+Qs
         1Q6rxYViBGwliSj4Ew6J8bImuJBVzJwDTOgtuDMySfxGe0pytCp2OZrNgs75CzQBFjqL
         c9kA==
X-Forwarded-Encrypted: i=1; AJvYcCXf+tqxJRcFQNSlHFagNzo4proe5p5pDI/CMUzgFEX7KLUF4HiUOm3ShVz8IpgYl7LGWMh/b/ko3qQ5Y47yB/qT@vger.kernel.org
X-Gm-Message-State: AOJu0Yws4tgnycvnGQ2cqTOoZGRKT9zL5Imka830KnbB3ZseW2TyVWYC
	JmdzGl895gBQQPa1BgkZD0pa7gKD2nb19aamtWRhUFqW3UANx/r1hpcyk71RQinSj5iuRlpvIXd
	v5jyfkijZdQ==
X-Google-Smtp-Source: AGHT+IGHaTGxJazN5wHricWPUhCMjXef1S9WGsWMMZHmj/nBpRDmryV30ZWD+C+AdKs/BtPUc6IVifWEzgI7
X-Received: from oacwf1.prod.google.com ([2002:a05:6871:d601:b0:331:4705:d868])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:a7aa:b0:346:3bf9:def0
 with SMTP id 586e51a60fabf-34c77a55f4fmr2461405fac.19.1758666827592; Tue, 23
 Sep 2025 15:33:47 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:32:59 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-16-irogers@google.com>
Subject: [PATCH v6 15/28] perf print-events: Remove print_hwcache_events
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
Cc: Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Now legacy cache events are in json there's no need for a specific
printing routine. To support the previous filtered version use an
event glob of "legacy cache" which matches the topic of the json
events.

Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c      | 16 +++++++---
 tools/perf/util/print-events.c | 55 ----------------------------------
 tools/perf/util/print-events.h |  1 -
 3 files changed, 12 insertions(+), 60 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index caf42276bd0f..b6720ef3adf6 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -652,9 +652,18 @@ int cmd_list(int argc, const char **argv)
 			}
 			default_ps.pmu_glob = old_pmu_glob;
 		} else if (strcmp(argv[i], "cache") == 0 ||
-			 strcmp(argv[i], "hwcache") == 0)
-			print_hwcache_events(&print_cb, ps);
-		else if (strcmp(argv[i], "pmu") == 0) {
+			   strcmp(argv[i], "hwcache") == 0) {
+			char *old_event_glob = default_ps.event_glob;
+
+			default_ps.event_glob = strdup("legacy cache");
+			if (!default_ps.event_glob) {
+				ret = -1;
+				goto out;
+			}
+			perf_pmus__print_pmu_events(&print_cb, ps);
+			zfree(&default_ps.event_glob);
+			default_ps.event_glob = old_event_glob;
+		} else if (strcmp(argv[i], "pmu") == 0) {
 			default_ps.exclude_abi = true;
 			perf_pmus__print_pmu_events(&print_cb, ps);
 			default_ps.exclude_abi = false;
@@ -707,7 +716,6 @@ int cmd_list(int argc, const char **argv)
 			default_ps.event_glob = s;
 			print_symbol_events(&print_cb, ps, PERF_TYPE_HARDWARE,
 					event_symbols_hw, PERF_COUNT_HW_MAX);
-			print_hwcache_events(&print_cb, ps);
 			perf_pmus__print_pmu_events(&print_cb, ps);
 			print_sdt_events(&print_cb, ps);
 			default_ps.metrics = true;
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 4153124a9948..91a5d9c7882b 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -186,59 +186,6 @@ bool is_event_supported(u8 type, u64 config)
 	return ret;
 }
 
-int print_hwcache_events(const struct print_callbacks *print_cb, void *print_state)
-{
-	struct perf_pmu *pmu = NULL;
-	const char *event_type_descriptor = event_type_descriptors[PERF_TYPE_HW_CACHE];
-
-	/*
-	 * Only print core PMUs, skipping uncore for performance and
-	 * PERF_TYPE_SOFTWARE that can succeed in opening legacy cache evenst.
-	 */
-	while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
-		if (pmu->is_uncore || pmu->type == PERF_TYPE_SOFTWARE)
-			continue;
-
-		for (int type = 0; type < PERF_COUNT_HW_CACHE_MAX; type++) {
-			for (int op = 0; op < PERF_COUNT_HW_CACHE_OP_MAX; op++) {
-				/* skip invalid cache type */
-				if (!evsel__is_cache_op_valid(type, op))
-					continue;
-
-				for (int res = 0; res < PERF_COUNT_HW_CACHE_RESULT_MAX; res++) {
-					char name[64];
-					char alias_name[128];
-					__u64 config;
-					int ret;
-
-					__evsel__hw_cache_type_op_res_name(type, op, res,
-									name, sizeof(name));
-
-					ret = parse_events__decode_legacy_cache(name, pmu->type,
-										&config);
-					if (ret || !is_event_supported(PERF_TYPE_HW_CACHE, config))
-						continue;
-					snprintf(alias_name, sizeof(alias_name), "%s/%s/",
-						 pmu->name, name);
-					print_cb->print_event(print_state,
-							"cache",
-							pmu->name,
-							pmu->type,
-							name,
-							alias_name,
-							/*scale_unit=*/NULL,
-							/*deprecated=*/false,
-							event_type_descriptor,
-							/*desc=*/NULL,
-							/*long_desc=*/NULL,
-							/*encoding_desc=*/NULL);
-				}
-			}
-		}
-	}
-	return 0;
-}
-
 void print_symbol_events(const struct print_callbacks *print_cb, void *print_state,
 			 unsigned int type, const struct event_symbol *syms,
 			 unsigned int max)
@@ -434,8 +381,6 @@ void print_events(const struct print_callbacks *print_cb, void *print_state)
 	print_symbol_events(print_cb, print_state, PERF_TYPE_HARDWARE,
 			event_symbols_hw, PERF_COUNT_HW_MAX);
 
-	print_hwcache_events(print_cb, print_state);
-
 	perf_pmus__print_pmu_events(print_cb, print_state);
 
 	print_cb->print_event(print_state,
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index d6ba384f0c66..44e5dbd91400 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -32,7 +32,6 @@ struct print_callbacks {
 
 /** Print all events, the default when no options are specified. */
 void print_events(const struct print_callbacks *print_cb, void *print_state);
-int print_hwcache_events(const struct print_callbacks *print_cb, void *print_state);
 void print_sdt_events(const struct print_callbacks *print_cb, void *print_state);
 void print_symbol_events(const struct print_callbacks *print_cb, void *print_state,
 			 unsigned int type, const struct event_symbol *syms,
-- 
2.51.0.534.gc79095c0ca-goog

