Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC292E3B1C
	for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757873513; cv=none; b=nOLjg4dBkbW+IYpiFgmKFFaqeqQsVZv7tYtzjCEl91jvULXNt0ybZPf/iCrjYn/VN8k0uVqKDCw15At3dmMsg3PK1DevjxnRrQDgO5XlRmNu6Zs9WXTHWmkd2hS3icK6NRT0iYe7voUsro95wDrg7X7iuxarz87QBkXrFBlfH5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757873513; c=relaxed/simple;
	bh=bNFs3gMIgxoqf6hBXj84KhUVYT1SFmJpH1pCOP0owiA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rrTqoqKMDMWpTHErNFsSYY1eqIqD6bttmeSKh3+X6xT1WzAHh/R2EBV+O7cRMQpsw6XB7SYAMQSEaJM39K6/qB0FPZgktWVDBpktSnS3e4t7PDbzVkH/MQAVLk2AdlsWYz3Xnq4QYd0HQ3tIqzJT3h1qAfRbnqjpo5iCj3dDhNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=05vhDGBl; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="05vhDGBl"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-25bdf8126ceso65023565ad.3
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 11:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757873512; x=1758478312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Klb80fEENL8pVEMhMAnIuH4GDaM7qR6wTc+wKss2Iw=;
        b=05vhDGBl379l1d5xhiz21TsGA5ZK/+piLM+fUY6k2XJC0N4Flg3MXXjnTh2PPJoTCr
         q4xEHfdUX8nmapfMJuS8DAUjafCRw2lullqKdxNrlOr86EXe/XyoqOE545jqIQOhK+K7
         aok4ZtYa8RmqgVR4KjbeNb6M3JKXHZ6FKd8ef/uhRZ0Xfg5S4ejOVqdm5/V4WtxLS92U
         Tkib+Ic2TpDKsQPC3yT+083jr24wlz3yNM1vmV1I9o/TO6652MIPt3NAQKJhJg94v+r3
         qe0BUrGgP0sqc6vESu52VcS3bD5A+xWFhTMDxYO2CV4TuRx9byqm3cyLFA1WXY+pD/85
         S6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757873512; x=1758478312;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Klb80fEENL8pVEMhMAnIuH4GDaM7qR6wTc+wKss2Iw=;
        b=B+zDCb5HIL+dfc1sb59N7pvBgddwhmMwKcsfsD5GJJsiOW4MpzXTT0kUgvm63XEeDs
         TmU9MHC3kKH+ms5EqctvestZIoVPQi1ebTrNmcPXDB5wCg56F2BileQIHpafxQB7y2y0
         QqY7V5NJ13O1ISmSr8LebSU7SVeUkUUUxDTkMQiqmoqHV0J0wCzPraLB6wYT1FOBFk0Z
         w0Bf5apWownGToTUg1ZgQzIFHFLz+H0yQzoo+5KymzafeR27o3AAvPeEcs8L9V9sMT/C
         Igu+jgC95dvg/ya9vdLS6AxshIBgi+6elXUijA5c/9mK/9nmK5mKplWDaovviHZd8GPd
         rXmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVAeO8sXVIyOueBMiHje6j6o/Fm1axlatyirPkNLwo0gnfpHva5LPeMTmcR89DRKOausAh8ngsKS9Id6BeWIIr@vger.kernel.org
X-Gm-Message-State: AOJu0YyKwGVe4a1IQM10djHSE8uUHwp6QxoyqXsk9ToZFUEXVHBA2+vo
	20iRFSmPHuLlfzy8jKhvqObqUHm6cLKdhCPwvUcgi5vEVI5dvuMQQ36CKslbcbI5g41ipImEuAL
	J0yN9tu0dbw==
X-Google-Smtp-Source: AGHT+IFVeWpSbIKRiD2dNm8Ku7yumklYHE6LjgI9aHF2YzPASyliEv1Z1A2YYTBv3apv23AU4pGBiLH6bgKW
X-Received: from plbms5.prod.google.com ([2002:a17:903:ac5:b0:24c:a620:9750])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3888:b0:248:9e56:e806
 with SMTP id d9443c01a7336-25d24100ebemr120751025ad.12.1757873511624; Sun, 14
 Sep 2025 11:11:51 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:11:13 -0700
In-Reply-To: <20250914181121.1952748-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914181121.1952748-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914181121.1952748-14-irogers@google.com>
Subject: [PATCH v4 13/21] perf print-events: Remove print_hwcache_events
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
Cc: Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Now legacy cache events are in json there's no need for a specific
printing routine. To support the previous filtered version use an
event glob of "legacy cache" which matches the topic of the json
events.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
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
2.51.0.384.g4c02a37b29-goog

