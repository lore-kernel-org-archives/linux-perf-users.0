Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4E734AAFB
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 21:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414821; cv=none; b=Q/QcXiEPGcbT1oNOlEWrpr6K90OlZWYIEPcOIpggV4lhC83Jg83FtwhW8+lh2onrFRaICw5jFcCI+0x0xLBubyWPoIfFUK91t9WkxxigAmb7lj2WohTmezO+FG2fvAEMrOKSyacrQX3mKt13/PrKlbQo5wLttket5wC48CypiFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414821; c=relaxed/simple;
	bh=ewcMS/xGi/UwCsZGzNOiaW1vi4aPl9r+nl9p6g3ay8A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=BJQrL8ej5IBmQEr888v6l4yhLEql/MCdc/xylI58KRYlEF9aIzu40edmDB2p4Z77aZWW70upqc4NLxtUnFTeJf8Jf9mr1HnFZzbWpWz2sST5Zjv/q0kjWJLdwjifEMDeKqBLZLhMOQeMmPTLYGHxI8PD+HhAT+4Xa5EylElskA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XMASxh3R; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XMASxh3R"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-314f332e0d2so1468443fac.3
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 14:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756414817; x=1757019617; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BRvxEIefoog0P8yHWvO3QwxoLJzdPvYl5tRtY/10zis=;
        b=XMASxh3R41agf8Hdm2oHxsgq5mygyB0vUCkY8z1SYgzeZEw/q9k3q4vxXNCIM5Wt39
         QZA7GlUPCwkI+Yl1glGQF5jLM2ELfPh37kuX0v34sUDd/4Q024OpARRekLD7g0yR9ueA
         hmBTx5TzHeNaneEA3IzeKejk+SztUreQ3fVsTnh40V5kzsyy2CmAe+duISU9hRuGa8br
         YK2v/e7axbAP3vaSPAoBUIDHujyK+OGAnuzZwAWQjHiKg3+ihVWEhKzKGkKy/0xnosAq
         W5OA916PsX2xfiCkGW6zKT0DXQm/9sNk8nMDrdCSubW4XN9ADzxbT6nEwMmztCW3+gfy
         qZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414817; x=1757019617;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRvxEIefoog0P8yHWvO3QwxoLJzdPvYl5tRtY/10zis=;
        b=AhsCt9WUZC56pBotvZ255M1b4+tWxeh9X/ztC7oW8l7AHhMu8XUzQHRsEtPjZmknmp
         4OIrlnqTvmCtmm5W8apyXN/TL3zo/Zm+w4OiQA55YOElUn6S7KbQqjKHtiZZ9g9ED2Wp
         4zIraN359bLpvWvfoo12eUt4JaNb3MSSX0167RTNvpCt6jBot8SLaUCvcte+2v8T3zfX
         bL0rAwhAv2jFweBfX5vfTD8Yj3JQz23rM3Gfh8tt0jmq5AY7YyIM15KAi+EzdToV81AD
         MsEwF/oTVB2kvd+vI3k6SPgCKOoZJc6H8Nf1ZMsLf4KVVhkrzbuZlti1hR+vS/J2QZQZ
         WUKA==
X-Forwarded-Encrypted: i=1; AJvYcCWllYDxEN6vZXkokNmFPju2S3q3Qu/ahLIQMz6AvVUYCLiWWCp3tBe+J1rLe6fiFUBbmB1CZWRfU10jpVPnqLEj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8tbVE2skjDco8ZHUDtQeIyejajIo/eg3P0Oitg2Yn0A16+ksa
	1FIjcdAx6zq4CIY54B+sV3TSAeiNNi3/CRz6HYhBDyeUt+4sGQBHjuoA8ZSQHXha9eucCF1w9VE
	y5JwNS9VKgg==
X-Google-Smtp-Source: AGHT+IF5elBx9j0gIDME0lrI3ngVVAVG16Xz59lzFw8FQWCP0uAnTusbmutVDjyHe48VoueohMo6XPS9zOX9
X-Received: from oacse8.prod.google.com ([2002:a05:6871:5f08:b0:30b:b94b:3c5b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:56aa:b0:315:a68c:d919
 with SMTP id 586e51a60fabf-315a68cdc69mr1247717fac.51.1756414817367; Thu, 28
 Aug 2025 14:00:17 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:59:28 -0700
In-Reply-To: <20250828205930.4007284-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828205930.4007284-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250828205930.4007284-14-irogers@google.com>
Subject: [PATCH v3 13/15] perf print-events: Remove print_hwcache_events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

Now legacy cache events are in json there's no need for a specific
printing routine. To support the previous filtered version use an
event glob of "legacy cache" which matches the topic of the json
events.

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
2.51.0.318.gd7df087d1a-goog

