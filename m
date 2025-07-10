Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619D52FCE1E
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 23:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752191888; cv=none; b=fqkKF8Oonl1D3JJLKMQLgWBOxFDRuXWiJim6zbNq1PxgsgTk9hrD85RioLTVfP0jigIf1VnDCuoedQojuLmYep6n2eKttxuT1oO+aafi7hW4A+e6vNhEbCTWCSu7eu3mJ583N8+KYMn7ogWHWBpe0bEIhEevuUUPfBvvpKYiEV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752191888; c=relaxed/simple;
	bh=WDFb8KRjkWtnIVv8Htut7znggZbaQvt3o8qYiqxrd2c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=gPaE3CveGJr4paE7RljH0IeYdzFYH53ZiPV1/owmjXwppTtusmkkFMOMyIiLekKF3Ivf/p/Z7YlCbb2Z1VUJH7g4PKaW6RUsT+q3xLOOMko7RxQzyI5kRO7ntSMe6PnBTriCo5eSHxDo4pbuwJrrW5pCxJUd87hnXtGtTI76mVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VD3lB09V; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VD3lB09V"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74943a7cd9aso2139980b3a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 16:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752191887; x=1752796687; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gj6H/6wWHWCvqxE/S+KSUU184sKn3KsUwpHe5HzrhKI=;
        b=VD3lB09VSge5NtefgbbNlUmmf3i/THUD+ioSeLi9bHlvj//fwCOCh99tE/iMb77gC+
         sXJOjOKfxVaKZ0F4/ArDhDIXvz5eTXiSp60LHQNDODUFqug2c9nYL0oM8ygweOf/uspY
         5Z/MEBmHrjUmtMpbU/ePm3atpmVU+nYkdITlRnsXs5pzX8T1mGonaZ+lRVH0EHEkNQsy
         UPNN7IHzlJNoF1TXeTWhaHdIv8PYiw7HOwwXRpeslKMOVov3neeeICrw0xhKECGGTkrl
         Ofm+qrgAs4Ir63DaJGEk0RU+0CazWVIMkFjUn8Y0xs0WVys5wLBqGdMNpr+1v0DcRw4r
         iOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752191887; x=1752796687;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gj6H/6wWHWCvqxE/S+KSUU184sKn3KsUwpHe5HzrhKI=;
        b=RvBjnoEb9v2crnMLlcO2v8gkywPGerXE1Oi7wWdYBt4C2z9GZKKdCWPNpdthRl9AP2
         EnGhpjZm4SVbF7lA97CZEmCQ9WPSEaknz8POE6N7K5BytKi70ZlbI+t6mn0iT0etsitp
         utxzVYl/ABCX68/BBfBYqzhyS5RDkgjD/9eYmRQNID1zMIYS/z7VnlRKvddPbhq4N6rq
         T6gnDF7AtFRtzXF7RscUiVQdfDysrAdY6/eFxCkdKpqf17Ps1A02LKsrWL3FhcdG2WdZ
         A5eZZLIO/ynnZQvNvMPxZZ2BG2+2VAwMnQvfvhAXjXntmJ2mHppcdyE9TJrbCrqxitM8
         uvwA==
X-Forwarded-Encrypted: i=1; AJvYcCV2vhSqpJNghnPbo4W11ilo42EfEji5fIMqpbRhm2sOzMqL9Ozp6W/DLUXdFMYnZs2z9w5X71TT45gNVnFVsE/s@vger.kernel.org
X-Gm-Message-State: AOJu0YztnuJoSzi/XHQ3AhSk+QVyBPnZBtcHL0gIH/pLkCfHlu5Z9R6e
	FM5GplLYCp7JAahvuh6qhuELxP9sa5xH00ZD4F29pod19bPohPQj6lCY66nLLEV1cYxVbtmu1xa
	EjY1BAb7dpw==
X-Google-Smtp-Source: AGHT+IEs/yItxbm6taj+eCmGLERMC7bDf7DS71yvAGt8hDabOwQeTErLrzGty+hMEyMjQmo1u5P4ankeaz0c
X-Received: from pgbfq9.prod.google.com ([2002:a05:6a02:2989:b0:b31:c791:5e4c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:33a9:b0:21f:419f:9019
 with SMTP id adf61e73a8af0-23137e8e44fmr1074550637.21.1752191886622; Thu, 10
 Jul 2025 16:58:06 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:57:27 -0700
In-Reply-To: <20250710235735.1089240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710235735.1089240-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710235735.1089240-7-irogers@google.com>
Subject: [PATCH v6 06/14] perf list: Skip ABI PMUs when printing pmu values
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Avoid printing tracepoint, legacy and software events when listing for
the pmu option. Add the PMU type to the print_event callbacks to ease
detection.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c      | 17 +++++++++++++----
 tools/perf/util/pfm.c          |  2 ++
 tools/perf/util/pmus.c         |  2 ++
 tools/perf/util/print-events.c |  5 +++++
 tools/perf/util/print-events.h |  2 +-
 5 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 3a4061d02f6c..caf42276bd0f 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -58,6 +58,8 @@ struct print_state {
 	bool metrics;
 	/** @metricgroups: Controls printing of metric and metric groups. */
 	bool metricgroups;
+	/** @exclude_abi: Exclude PMUs with types less than PERF_TYPE_MAX except PERF_TYPE_RAW. */
+	bool exclude_abi;
 	/** @last_topic: The last printed event topic. */
 	char *last_topic;
 	/** @last_metricgroups: The last printed metric group. */
@@ -113,7 +115,8 @@ static void wordwrap(FILE *fp, const char *s, int start, int max, int corr)
 	}
 }
 
-static void default_print_event(void *ps, const char *topic, const char *pmu_name,
+static void default_print_event(void *ps, const char *topic,
+				const char *pmu_name, u32 pmu_type,
 				const char *event_name, const char *event_alias,
 				const char *scale_unit __maybe_unused,
 				bool deprecated, const char *event_type_desc,
@@ -130,6 +133,9 @@ static void default_print_event(void *ps, const char *topic, const char *pmu_nam
 	if (print_state->pmu_glob && pmu_name && !strglobmatch(pmu_name, print_state->pmu_glob))
 		return;
 
+	if (print_state->exclude_abi && pmu_type < PERF_TYPE_MAX && pmu_type != PERF_TYPE_RAW)
+		return;
+
 	if (print_state->event_glob &&
 	    (!event_name || !strglobmatch(event_name, print_state->event_glob)) &&
 	    (!event_alias || !strglobmatch(event_alias, print_state->event_glob)) &&
@@ -354,7 +360,8 @@ static void fix_escape_fprintf(FILE *fp, struct strbuf *buf, const char *fmt, ..
 	fputs(buf->buf, fp);
 }
 
-static void json_print_event(void *ps, const char *topic, const char *pmu_name,
+static void json_print_event(void *ps, const char *topic,
+			     const char *pmu_name, u32 pmu_type __maybe_unused,
 			     const char *event_name, const char *event_alias,
 			     const char *scale_unit,
 			     bool deprecated, const char *event_type_desc,
@@ -647,9 +654,11 @@ int cmd_list(int argc, const char **argv)
 		} else if (strcmp(argv[i], "cache") == 0 ||
 			 strcmp(argv[i], "hwcache") == 0)
 			print_hwcache_events(&print_cb, ps);
-		else if (strcmp(argv[i], "pmu") == 0)
+		else if (strcmp(argv[i], "pmu") == 0) {
+			default_ps.exclude_abi = true;
 			perf_pmus__print_pmu_events(&print_cb, ps);
-		else if (strcmp(argv[i], "sdt") == 0)
+			default_ps.exclude_abi = false;
+		} else if (strcmp(argv[i], "sdt") == 0)
 			print_sdt_events(&print_cb, ps);
 		else if (strcmp(argv[i], "metric") == 0 || strcmp(argv[i], "metrics") == 0) {
 			default_ps.metricgroups = false;
diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index 0dacc133ed39..15fc3898ec83 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -234,6 +234,7 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
 
 	if (is_libpfm_event_supported(name, cpus, threads)) {
 		print_cb->print_event(print_state, topic, pinfo->name,
+				      /*pmu_type=*/PERF_TYPE_RAW,
 				      name, info->equiv,
 				      /*scale_unit=*/NULL,
 				      /*deprecated=*/NULL, "PFM event",
@@ -269,6 +270,7 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
 			print_cb->print_event(print_state,
 					topic,
 					pinfo->name,
+					/*pmu_type=*/PERF_TYPE_RAW,
 					name, /*alias=*/NULL,
 					/*scale_unit=*/NULL,
 					/*deprecated=*/NULL, "PFM event",
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 409b909cfa02..004f5f0c621f 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -645,6 +645,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 		print_cb->print_event(print_state,
 				aliases[j].topic,
 				aliases[j].pmu_name,
+				aliases[j].pmu->type,
 				aliases[j].name,
 				aliases[j].alias,
 				aliases[j].scale_unit,
@@ -749,6 +750,7 @@ void perf_pmus__print_raw_pmu_events(const struct print_callbacks *print_cb, voi
 		print_cb->print_event(print_state,
 				/*topic=*/NULL,
 				/*pmu_name=*/NULL,
+				pmu->type,
 				format_args.short_string.buf,
 				/*event_alias=*/NULL,
 				/*scale_unit=*/NULL,
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 3a5e5e7bae13..4153124a9948 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -121,6 +121,7 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 		print_cb->print_event(print_state,
 				/*topic=*/NULL,
 				/*pmu_name=*/NULL,
+				PERF_TYPE_TRACEPOINT,
 				evt_name ?: sdt_name->s,
 				/*event_alias=*/NULL,
 				/*deprecated=*/false,
@@ -222,6 +223,7 @@ int print_hwcache_events(const struct print_callbacks *print_cb, void *print_sta
 					print_cb->print_event(print_state,
 							"cache",
 							pmu->name,
+							pmu->type,
 							name,
 							alias_name,
 							/*scale_unit=*/NULL,
@@ -278,6 +280,7 @@ void print_symbol_events(const struct print_callbacks *print_cb, void *print_sta
 		print_cb->print_event(print_state,
 				/*topic=*/NULL,
 				/*pmu_name=*/NULL,
+				type,
 				nd->s,
 				alias,
 				/*scale_unit=*/NULL,
@@ -438,6 +441,7 @@ void print_events(const struct print_callbacks *print_cb, void *print_state)
 	print_cb->print_event(print_state,
 			/*topic=*/NULL,
 			/*pmu_name=*/NULL,
+			PERF_TYPE_RAW,
 			"rNNN",
 			/*event_alias=*/NULL,
 			/*scale_unit=*/NULL,
@@ -452,6 +456,7 @@ void print_events(const struct print_callbacks *print_cb, void *print_state)
 	print_cb->print_event(print_state,
 			/*topic=*/NULL,
 			/*pmu_name=*/NULL,
+			PERF_TYPE_BREAKPOINT,
 			"mem:<addr>[/len][:access]",
 			/*scale_unit=*/NULL,
 			/*event_alias=*/NULL,
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index 4d95b8257e23..d6ba384f0c66 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -12,7 +12,7 @@ struct print_callbacks {
 	void (*print_start)(void *print_state);
 	void (*print_end)(void *print_state);
 	void (*print_event)(void *print_state, const char *topic,
-			const char *pmu_name,
+			const char *pmu_name, u32 pmu_type,
 			const char *event_name, const char *event_alias,
 			const char *scale_unit,
 			bool deprecated, const char *event_type_desc,
-- 
2.50.0.727.gbf7dc18ff4-goog

