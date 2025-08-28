Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEC6340DAC
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398791; cv=none; b=DQOgf/ZXExqjyNHaYHAbw5UDgxG1F7Ob6w9YLFDveaX9T+MpxIM4X0SkN2ueKnviq/fqocNbs7PQnAr6iHsGjXRGejJmG9RFrsL+owP7+8FDlgxWZtldEgqmdre885gMk/nBgcPkTrLSw5bwmfAb5uHqTZWeUM3LPJXKF6mQ2gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398791; c=relaxed/simple;
	bh=FUxG6cTWF12Hj0nv8KuHcpKTAC4CW5R8HCg4j0tzjbQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=eTGs0DAdh8OewiZlCuy/s8ohJysynULzwUWTAR+4Y+qJicAjTRnfI/iee/WtFLpU8vsHCkcQ23f3upRU49/TxDeBe9k+VCYyQBVlG7eO9nrEAWERLyJJLeLe1ScSD9dBTnLEyuRxMND9KqoJAzhIDUOX9EXApTUfQVI//1KpLs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EXqRv+hr; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EXqRv+hr"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-771e2f5b5dcso1674273b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 09:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756398788; x=1757003588; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1IB4MOkKNDWBoUFq+jVJUw2qQwNqyy7t1cwtRJaDTCo=;
        b=EXqRv+hrYs9Y45+jBK1tMcXsGp3/nNyy/u24Q4cAdwhH3T1qREYpW4N+nNkHTw9wye
         a0LJDFiGllOaffHucnr+3TbFdNxhLS2burlomcIkx0pwM+H+aQ/2FrJS9YdiT5dOJ30L
         X1ev3hsHR+AQPyQbh9ofvv8uphXBJTtaNaUTOTJP4Mh2PtTyg9PoqVw1rXCmM0A0JBKj
         w3d6/S74IKrxbKCQVDCN2gYMWYtmZ9m5fvPGTpMAX392769okaPklTwGTz4Is67dxszn
         WlaxGVFrzmgXLryDsWRGcmVUo8wu00WpeuEMhazqKcMeXD4OxqUEBajRoa7BpUZKnHFo
         fa/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398788; x=1757003588;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IB4MOkKNDWBoUFq+jVJUw2qQwNqyy7t1cwtRJaDTCo=;
        b=a2rXGt8xBtjn/wJSR72YkyC5TR2g1EobdcZa922wvuMXs/tlsb8/xPV/9aL3B9Eqc/
         TB7zk/z3JiOHH1xC86DTrfTs1BRpmOfmsrNwhwX/Pz/PU1fXW39kF6s9iJLI059usFHR
         jRWtr1VmCJ96UYRrwP7ZerSJiBnEOf06P+XXAfzI9lq5dUa2bkuZImMMqCzpBaoWdEE8
         huLaOS1dHuCCM2SkNaD012ah4C/3LjSHIZhe4A1buC8v2mqXpl1pPfjdTiLQJkCuhOs4
         mDolRGGxxTFOvlC0rIily+qQ6oS2hssXey05CnVSR9K0Yd2wTxrL5+6c1sHOPuDINAOQ
         0wsw==
X-Forwarded-Encrypted: i=1; AJvYcCUN4MLJLSwk4/WsUVfzT7baPF5RyACgEqiwlzH9ArGI8W4TjsDO/+Hq2h/Ih9/PlHWTw8zhw+2TOv/bulkVkUWh@vger.kernel.org
X-Gm-Message-State: AOJu0YzmUsq5Wqm1kcw1jzWv98z33NeTc60vzF+Ge9d7Pwh8zH4RxLKI
	nSYWazFfpYawg9GUoMw/EUkCkcckMKs1LgG4v/osj2MmbpuTMPK84Z6LxNS5LLJPPZ6FHFynHn3
	UQ0QXiFGNAA==
X-Google-Smtp-Source: AGHT+IE29tOEleJ9hHWj2Gu3Jo6dku12N/ADGsnW8i7sIo93hLP9oXtlt5I1ALNdpAFwryQJWXA/KoLjab4e
X-Received: from pfbjo20.prod.google.com ([2002:a05:6a00:9094:b0:771:e6da:3861])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3988:b0:76b:f8ee:4eaa
 with SMTP id d2e1a72fcca58-7702f9f150amr30099368b3a.9.1756398788238; Thu, 28
 Aug 2025 09:33:08 -0700 (PDT)
Date: Thu, 28 Aug 2025 09:32:24 -0700
In-Reply-To: <20250828163225.3839073-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828163225.3839073-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828163225.3839073-15-irogers@google.com>
Subject: [PATCH v2 14/15] perf print-events: Remove print_symbol_events
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

Now legacy hardware events are in json there's no need for a specific
printing routine that previously served for both hardware and software
events. The associated event_symbols_hw is also removed. To support
the previous filtered version use an event glob of "legacy hardware"
which matches the topic of the json events.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c      | 18 +++++++----
 tools/perf/util/parse-events.c | 43 -------------------------
 tools/perf/util/parse-events.h |  1 -
 tools/perf/util/print-events.c | 57 ----------------------------------
 tools/perf/util/print-events.h |  3 --
 5 files changed, 12 insertions(+), 110 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index b6720ef3adf6..16400366f827 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -633,10 +633,18 @@ int cmd_list(int argc, const char **argv)
 			zfree(&default_ps.pmu_glob);
 			default_ps.pmu_glob = old_pmu_glob;
 		} else if (strcmp(argv[i], "hw") == 0 ||
-			 strcmp(argv[i], "hardware") == 0)
-			print_symbol_events(&print_cb, ps, PERF_TYPE_HARDWARE,
-					event_symbols_hw, PERF_COUNT_HW_MAX);
-		else if (strcmp(argv[i], "sw") == 0 ||
+			   strcmp(argv[i], "hardware") == 0) {
+			char *old_event_glob = default_ps.event_glob;
+
+			default_ps.event_glob = strdup("legacy hardware");
+			if (!default_ps.event_glob) {
+				ret = -1;
+				goto out;
+			}
+			perf_pmus__print_pmu_events(&print_cb, ps);
+			zfree(&default_ps.event_glob);
+			default_ps.event_glob = old_event_glob;
+		} else if (strcmp(argv[i], "sw") == 0 ||
 			 strcmp(argv[i], "software") == 0) {
 			char *old_pmu_glob = default_ps.pmu_glob;
 			static const char * const sw_globs[] = { "software", "tool" };
@@ -714,8 +722,6 @@ int cmd_list(int argc, const char **argv)
 				continue;
 			}
 			default_ps.event_glob = s;
-			print_symbol_events(&print_cb, ps, PERF_TYPE_HARDWARE,
-					event_symbols_hw, PERF_COUNT_HW_MAX);
 			perf_pmus__print_pmu_events(&print_cb, ps);
 			print_sdt_events(&print_cb, ps);
 			default_ps.metrics = true;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index be3e86e7b157..72cc59cfc46d 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -42,49 +42,6 @@ static int parse_events_terms__copy(const struct parse_events_terms *src,
 				    struct parse_events_terms *dest);
 static int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct strbuf *sb);
 
-const struct event_symbol event_symbols_hw[PERF_COUNT_HW_MAX] = {
-	[PERF_COUNT_HW_CPU_CYCLES] = {
-		.symbol = "cpu-cycles",
-		.alias  = "cycles",
-	},
-	[PERF_COUNT_HW_INSTRUCTIONS] = {
-		.symbol = "instructions",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_CACHE_REFERENCES] = {
-		.symbol = "cache-references",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_CACHE_MISSES] = {
-		.symbol = "cache-misses",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = {
-		.symbol = "branch-instructions",
-		.alias  = "branches",
-	},
-	[PERF_COUNT_HW_BRANCH_MISSES] = {
-		.symbol = "branch-misses",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_BUS_CYCLES] = {
-		.symbol = "bus-cycles",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = {
-		.symbol = "stalled-cycles-frontend",
-		.alias  = "idle-cycles-frontend",
-	},
-	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] = {
-		.symbol = "stalled-cycles-backend",
-		.alias  = "idle-cycles-backend",
-	},
-	[PERF_COUNT_HW_REF_CPU_CYCLES] = {
-		.symbol = "ref-cycles",
-		.alias  = "",
-	},
-};
-
 static const char *const event_types[] = {
 	[PERF_TYPE_HARDWARE]	= "hardware",
 	[PERF_TYPE_SOFTWARE]	= "software",
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index a64f0741cb4b..32bde974c9f5 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -264,7 +264,6 @@ struct event_symbol {
 	const char	*symbol;
 	const char	*alias;
 };
-extern const struct event_symbol event_symbols_hw[];
 
 char *parse_events_formats_error_string(char *additional_terms);
 
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 91a5d9c7882b..8f3ed83853a9 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -186,60 +186,6 @@ bool is_event_supported(u8 type, u64 config)
 	return ret;
 }
 
-void print_symbol_events(const struct print_callbacks *print_cb, void *print_state,
-			 unsigned int type, const struct event_symbol *syms,
-			 unsigned int max)
-{
-	struct strlist *evt_name_list = strlist__new(NULL, NULL);
-	struct str_node *nd;
-
-	if (!evt_name_list) {
-		pr_debug("Failed to allocate new strlist for symbol events\n");
-		return;
-	}
-	for (unsigned int i = 0; i < max; i++) {
-		/*
-		 * New attr.config still not supported here, the latest
-		 * example was PERF_COUNT_SW_CGROUP_SWITCHES
-		 */
-		if (syms[i].symbol == NULL)
-			continue;
-
-		if (!is_event_supported(type, i))
-			continue;
-
-		if (strlen(syms[i].alias)) {
-			char name[MAX_NAME_LEN];
-
-			snprintf(name, MAX_NAME_LEN, "%s OR %s", syms[i].symbol, syms[i].alias);
-			strlist__add(evt_name_list, name);
-		} else
-			strlist__add(evt_name_list, syms[i].symbol);
-	}
-
-	strlist__for_each_entry(nd, evt_name_list) {
-		char *alias = strstr(nd->s, " OR ");
-
-		if (alias) {
-			*alias = '\0';
-			alias += 4;
-		}
-		print_cb->print_event(print_state,
-				/*topic=*/NULL,
-				/*pmu_name=*/NULL,
-				type,
-				nd->s,
-				alias,
-				/*scale_unit=*/NULL,
-				/*deprecated=*/false,
-				event_type_descriptors[type],
-				/*desc=*/NULL,
-				/*long_desc=*/NULL,
-				/*encoding_desc=*/NULL);
-	}
-	strlist__delete(evt_name_list);
-}
-
 /** struct mep - RB-tree node for building printing information. */
 struct mep {
 	/** nd - RB-tree element. */
@@ -378,9 +324,6 @@ void metricgroup__print(const struct print_callbacks *print_cb, void *print_stat
  */
 void print_events(const struct print_callbacks *print_cb, void *print_state)
 {
-	print_symbol_events(print_cb, print_state, PERF_TYPE_HARDWARE,
-			event_symbols_hw, PERF_COUNT_HW_MAX);
-
 	perf_pmus__print_pmu_events(print_cb, print_state);
 
 	print_cb->print_event(print_state,
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index 44e5dbd91400..eabba5d4a1fd 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -33,9 +33,6 @@ struct print_callbacks {
 /** Print all events, the default when no options are specified. */
 void print_events(const struct print_callbacks *print_cb, void *print_state);
 void print_sdt_events(const struct print_callbacks *print_cb, void *print_state);
-void print_symbol_events(const struct print_callbacks *print_cb, void *print_state,
-			 unsigned int type, const struct event_symbol *syms,
-			 unsigned int max);
 void metricgroup__print(const struct print_callbacks *print_cb, void *print_state);
 bool is_event_supported(u8 type, u64 config);
 
-- 
2.51.0.268.g9569e192d0-goog

