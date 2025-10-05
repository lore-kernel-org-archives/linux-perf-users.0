Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12B7296BC9
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Oct 2025 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688708; cv=none; b=MULCixfJKU6c25d6nWYZeHfTkdbeH098Pssh6nYAK6ieTthdVBZkKFg0VschjYL2/lPxoPNDP8nMsHqeDHYgrrSuMHeCnXJGVHOCK5F5e24zhDkkG5Dn8J3FBUALFkVxPWn/lNViO0rOd9X/zpiUPKrjslIXoKqURj9zCUcny0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688708; c=relaxed/simple;
	bh=mTa9Y6WeAtvn9d7+2/fGkIrChVhZ8EITp0NfUwLgqMo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iKgE6EieVHFXNGgr4C6e3iws8e/E1HkrfelDkb9LuupKDiLlIIAxwYU199PeCDxlT7AlZvymvcUNyIdKhkcd5+yTeZfm5h/2gMwI4LxOJcHwMy/27SjKBxngEwgFTdmpG/czjBcgriBN6Q/q5wPVP8gCUJTd8zMhbtw17aD35R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=grb4oJK7; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="grb4oJK7"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b55283ff3fcso2861049a12.3
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Oct 2025 11:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688705; x=1760293505; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=chaVjHV6gVx+9hgVDtyapkRgzRP2tTAbbR4GER7wzJI=;
        b=grb4oJK7N37ILKHfMaY19tE+B8seYGaAGfm9VmG23Gn06fVqUC0JBqoxDwxTChBiwq
         X7Y3RO83+B2ToCNCAkPgdK0ZkyoKb/WSWe/HmzJxJW3jcRBmA96Bfz6cjRRsC/62A6Cj
         Ym4j/j5E4fu/po4im06c8oCfz8XrC/iLslI0vz6hPGHyU6N65HWBOan7NTt2Z4eCPJDi
         95/HDOj6xP2C1mTpU2deoD0TWqbfUOr3k03bV70ha6fwSFRQFKJ6N2AhGTZi0wO2oZlH
         YKiP6bsMVUFHb2C7dRpvj8vYTTRx1tcWhSAKZUtgAk25RtroMtP0qCAhUT3dkKWPMMVY
         EsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688705; x=1760293505;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chaVjHV6gVx+9hgVDtyapkRgzRP2tTAbbR4GER7wzJI=;
        b=dkFQ4sIAn4cr18uuMQOrJUYTSUdBx4BNRohu9twuCzrAp2Yf4O1+CzPZ1+ozwP6Kq2
         qPrapP29pO/YC0E4drCW144uYStnxshIo6qn3roVL/TC+8IIHmfKvzkr1dY8t+KQCTwe
         FV2ADWFjWTDEhXsG1szalkd53AWijgnNw7LHowaMw0YtB7fdl4Xnqz+TEZi2Ngb9EgX6
         d4/7h15IaU/3XMueX0d4LDrea4QW4K+kNXuxrV47z85pDTDZHpwqgswPUxAzx7/awZWL
         0J76mhZ4PR/U8Lw8my7+Y1/xGZ3UiMIwnYHw6Pts3Q7gqKNd1YM2ubKh0f7m/0ZJxwZX
         DDmA==
X-Forwarded-Encrypted: i=1; AJvYcCXR7RFrzSJwqAxTWnuEwmf3XSMcg06j5R4GeK9Nvh6D2iOmL5i73FqSKr33/oepMKJmbCMxUT/DVOivrxcwABfA@vger.kernel.org
X-Gm-Message-State: AOJu0YxqP4BRRnEnL+b7Q5JG2at9Ws7ZDh6Pic5Qjgm/RA+veH51aY0m
	2OCWkFs3FZVmtDzLMti2/QRz5XEPpWb0tcWkxPIeNBX+2iA9dg2Amobs6mgT/gReYd+p8V4DVuF
	Vb7yJpGxv8Q==
X-Google-Smtp-Source: AGHT+IFsXoq2ezUEImVo+oEMTghrVDKCqLlfb4CwpegA+7f1Z+jJxzblg3WCU59+Hl9dvIRpIkmv7jzFN1sL
X-Received: from pjbhk16.prod.google.com ([2002:a17:90b:2250:b0:32d:dbd4:5cf3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33d2:b0:32d:fcd8:1a9
 with SMTP id 98e67ed59e1d1-339c279f4cemr9375874a91.32.1759688705025; Sun, 05
 Oct 2025 11:25:05 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:17 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-15-irogers@google.com>
Subject: [PATCH v7 14/27] perf print-events: Remove print_hwcache_events
From: Ian Rogers <irogers@google.com>
To: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Ian Rogers <irogers@google.com>, Thomas Richter <tmricht@linux.ibm.com>
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
2.51.0.618.g983fd99d29-goog

