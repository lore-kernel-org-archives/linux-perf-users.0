Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1514D340D81
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398788; cv=none; b=Vi38hX6uKVNaWjzLFRvMQk7Rd384WsI6i2WoN6ZV48IiqpAyX+SRjpq7RsrrgwVZjd8QD1SEXIHRdDZEfOQssPzHMRfcydExwZVjuNAmtFeIUImkGK0ASFGxoUN09oOd6NW4I8I+NLxb9haM4joBCf3+GJXtR2rQtMY9hHpWY4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398788; c=relaxed/simple;
	bh=zCHtipe3FFEhxU5sc7D2y2ZkMor+1wVxd4gniTZLH5I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=a3ElnKaLgUM3/5F3L5Ij8QUnqSyEJ+tsVN38alNzq18Ubroazx/X0HKzz67+L6C1HO2SSFs3+9g0XmkKUB9t/sOpG3GfAhrNbZimzohYRfDoWmuAkrc1rFrvxbiIXTtdQQMKoE2PWArg0dA90S+cpa3p7x9SF9HT2ip+B3EvrqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oVWudHVy; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oVWudHVy"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4c229e2a42so883032a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 09:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756398786; x=1757003586; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CFnyAfmB+YyepyVuM/OrsoORiE8FNGZTxzVIf9Uoa/c=;
        b=oVWudHVyMZtxjMNcRQwjCWgOZGkFz43Z+pX+khp6QwwU4AbU6pAxmdeos/a1YcmiWl
         Uga/b4C7hzKoCIA4oBYdhRzOe3YHYB7hTTkpkIYYsD6zeU3XoF6uQmkZI9HRFsbK9ekn
         njcC5RsOz+/GOTJ2xP6GXrBWpSBRcbgwbJUjwsa3PvjxWblD6Md1kGTIAANILVXQJHBe
         S53blcxuEKwNrdnlGAKivjnSmbG0QHkDJldSgtkDo/7T4KaP8GnFWPj/g0rtdWCYaKus
         J/lXu7lp4X0eenGr1aS9fG6uIXrukyGm2qNz5keyItWsCOwRgQmU2qssVADP6cUu84j3
         SrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398786; x=1757003586;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFnyAfmB+YyepyVuM/OrsoORiE8FNGZTxzVIf9Uoa/c=;
        b=WGU7DCLPftIjKeAmSzXVhj/SA7sPUewOQVnK9wrrF07cu1fBXWYcnRI1J5iQWiUsBI
         ZlVxYgqgCFnPa42iL2nAzm3/2P8pBDWdl4vHjd+6J1JfHElbAxGGx5LhupIEJ9ALcTfl
         +L7Z/9ZfvoseOagi02o3UEM97dw50w9BNTUJUNOzBOn2isSyl1PpGpDSce/pPyEigEw3
         6xxDtNr25QvW8Yzc6r1+YRyyF3LrhIKdL7HAnZ5f/Pz+buKztl/khjtahYz5xguM1sJC
         3Pp2FIHHntadh6nCndpqzFRg1bLon47w6cfxlE8CFXQgmpfwmFG25Y4bqcN2sj242P2h
         9o8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2fHtl3tD6DHlfRnvj3jlFRG0yLpOF6NXttmII0EynHuiyx5XT0w3cfu+oAmz5YjfgV8sl6xpeH0bP5+3v4ppO@vger.kernel.org
X-Gm-Message-State: AOJu0YyggKC9bvhSmTq5/GqDxZvpyqr5HBgq/nt7sFnQcpE0tC4KZiC0
	Yzp1L5sw8cumtOBZHuXzE2D/nQxVf3VDNtbRiY9fAcv/ybNyoTm12A5v4UjlzeCtS8URND66xu2
	c1YU/kkwl5g==
X-Google-Smtp-Source: AGHT+IEKrj2d08xhz8D4axefHuDfcTfQZ0SGLGj6KVrSNmMBHL43lGECBdpGfTJI89L77WbGEflqJaf6yb0D
X-Received: from pjyf12.prod.google.com ([2002:a17:90a:ec8c:b0:325:b894:3c4f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7344:b0:233:c703:d4bf
 with SMTP id adf61e73a8af0-24340b28476mr34136294637.19.1756398786385; Thu, 28
 Aug 2025 09:33:06 -0700 (PDT)
Date: Thu, 28 Aug 2025 09:32:23 -0700
In-Reply-To: <20250828163225.3839073-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828163225.3839073-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828163225.3839073-14-irogers@google.com>
Subject: [PATCH v2 13/15] perf print-events: Remove print_hwcache_events
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
2.51.0.268.g9569e192d0-goog

