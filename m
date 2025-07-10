Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCF2303DE5
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752179140; cv=none; b=aDMtsEX/CakGiIJdplOOHdMmgpvu/XtcreZmtxgWWfDOpUcRVxrCbFGwxqcoyT7LvpuWqNAg3+eJ2OF8koP1CvXievCh82yR2r1j1XSyypuyuofkbcsDaNmlCloX3Sz6K8C+igJ0dcy+C9ckCa9+yiLUWl+2dWlqMHRYGhUoUOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752179140; c=relaxed/simple;
	bh=QBQ6rMMGrCCqcqpv0nGcMrSiGZpXq85vCuSs2bWMZ9U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Utb4v7CMKzv0TpRAkENDE5M/paT89q8mXPGq2sbVUDkHbbDb2DXFctxA9G48/NbXgGTUeurPGN1V5kLhRjbO3thcruogPILp74b81PpvgXm96rObdlg2BQ5PMnyze3+eFgggSKx07+rQc/aihkVjKr3akWf/3gx3RgqBAm+QM9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OAPDmd55; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OAPDmd55"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23507382e64so13810085ad.2
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jul 2025 13:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752179138; x=1752783938; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EP30FVHzqvLXJ2GVgWwMYde05oJPsW/Vmscvz9g3I8Q=;
        b=OAPDmd55/ELzovNVVrDPT+KQ54Y0O2dnNsf43Zd4rlZJUoLLL/o013BgYv7JKptigy
         +sMBdSAW2X8zjLGXLGi4W+ExhVJOCQsTTYDM3E3ZpHu4QL/mBqGjNw7BVt2wtPPNxsRT
         MX6Tz2XKA1DXp/2dfoUkaCi+nu7SxDVTVOoxCBVirFYGETPfIID5C0m/AonlWtEvtC2J
         IsnyH7S0gs9eOjHeHOIMlmxx1wUo/y2irWdyT50ZBtYSpuff/ZxFOWSerzn0ORLyv+jf
         S0kkRLBoAe120FnNuKvZfpKJvnRV8UZamGgxJ2ckUFuSVGr3oCgusGroDdWe0HJv2v9e
         oHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752179138; x=1752783938;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EP30FVHzqvLXJ2GVgWwMYde05oJPsW/Vmscvz9g3I8Q=;
        b=pk8N2/gioQcuCTyqR8LloXQWLXGifejEkSSDpOqifYFvefirb+jXuAyEZZ5UT77f/N
         1CRUFxG97kcXdbf8UtrmcW64bUKPmqcbI6H1saTz9PfkVxpamf6J+6Hfee6/X/77hU1V
         ewGVNLXUMXvHMVOvjXp6tj42k/lyIWyuCBJM40lJN+S33zT3Dy92BVIgMzfocCVEuuUM
         obHa/QzJKfZttAp3QvEsnWt9AUAQkG2ez6q32uhK491Mbj/Hc3mmaB8hV7/UHEsLDWDR
         tm412JqQzfWSZjqUxwqMEEZt3PvZlluw95S62N04wT3uxbjYjlyA90xr52opTgK+NuIW
         0QRg==
X-Forwarded-Encrypted: i=1; AJvYcCVyrWe6x0VqUppK52t20aJ89DYoPM30j5LAjVXD3LrX2df2/bUPhQEDLG4NziqvUSvgfsshUOD8+2Pa94yl9osG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz42PaPvChB4leIfBp8c5Dp8jODUaL03uQWd4sqygs4QtNtNg+k
	hiTR6XXsnP3Xj+PSz6I3XTvADOJEBFdQ+x4+95Qc1KXEpu/5N4BjSC0qEP1RCQnfsXHV7IgooHB
	Yw/NGJcr69w==
X-Google-Smtp-Source: AGHT+IFkYqyREbtIQSLbhz2UcEYkhDEn6YLjyav75c5U8o0BRcV3V2J2KJypDuFoK/YcyX7q/QxQUM0VeA/J
X-Received: from plbms15.prod.google.com ([2002:a17:903:acf:b0:22e:4a61:5545])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec4:b0:23c:8f4c:6658
 with SMTP id d9443c01a7336-23dee26d6d8mr4993875ad.25.1752179137825; Thu, 10
 Jul 2025 13:25:37 -0700 (PDT)
Date: Thu, 10 Jul 2025 13:24:53 -0700
In-Reply-To: <20250710202500.1959672-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250710202500.1959672-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250710202500.1959672-16-irogers@google.com>
Subject: [PATCH v5 08/14] perf list: Skip ABI PMUs when printing pmu values
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
 tools/perf/util/pmus.c         |  2 ++
 tools/perf/util/print-events.c |  5 +++++
 tools/perf/util/print-events.h |  2 +-
 4 files changed, 21 insertions(+), 5 deletions(-)

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

