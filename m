Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FDA26563F
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511469; cv=none; b=H0G8FUFiOiEFxflldIMxe3t2oOVRw4ziHXnclMQ1zIhbA5HfxbED76iNGjgvEG72KtXyDuWrSYWDT146erZ8XLLsUI/j8dt7eZtKA7X2+zFS8R9NfGq1dwmDmvzbklsgbOXt8WVXhPgLT0/wBVNOhE+Gb+QGTaCl6zQ6VKloYOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511469; c=relaxed/simple;
	bh=WDFb8KRjkWtnIVv8Htut7znggZbaQvt3o8qYiqxrd2c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=W378MN7aWWb9LXoK/FiJEwAOj9fEOFQchxMwm/7G60bsJAxBsj86UrwnzO5GdV/LUs0zYvyudCdTB6/n1/NrkH93DNxwqMlUHEWCQOpARugrs7NrDcjYyAVi69c153WdCyNOnZNhYUkRVINBB5WuGZCeS+wNn2ixsP/yGiRKtC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0S5N0gvX; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0S5N0gvX"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2356ce66d7cso76214935ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Jul 2025 09:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752511467; x=1753116267; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gj6H/6wWHWCvqxE/S+KSUU184sKn3KsUwpHe5HzrhKI=;
        b=0S5N0gvX/Vm5aqR1BsEVTVCHTtpev2HkK6lIlllEtkkkBFN2TCFezi/uPHFAaDr3JA
         PV176H+ECckWpLA2RhPP6xkKA76VCNYZtcn8vqMhwXmyQua9RarveByZ20A0b+eQdubT
         5DaBIPmnEkiMo3kugiwz1xoRtWe1IQAN70I0vyePr7OtlCsxd2UBdoNIMHR5BocUdzhN
         yxQnJX0BGqA3ghkd1tN9RnBXAJ3eMariH8vVx8HrUTIF1ioDJCdkfzA9gJOhJoPUCvfJ
         DvHK9ob4zcBgLW1X72+HMM9Z7ryNe0p2FW0eWQyzQMtMHpKiHVBx5MJuCVoGKEljRBmP
         YxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752511467; x=1753116267;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gj6H/6wWHWCvqxE/S+KSUU184sKn3KsUwpHe5HzrhKI=;
        b=E64ESyebWCNlkSzAc3hrlnmIqMK9L5utfMDeXbmT86i/AOCVwjs11URo9exHuPlUWV
         zHUS0l6Ij9mwkoKkvbgKSkFmnkgH84MAi++nKQXjKJg/4jKD1H4M99CShC30CF3ls+CU
         2m4jNeYQQDWhxHmPxLJ2aQ6knWmBYniRHcS91wIP852iEESrdrdejkYDyGaRmK+Gm192
         UgiVxW8Ta02ximIKpMc93pgkyWypRAE2dffGBmuFafZhiWERatHD59rbkp/+yktSD6+P
         psRqfFS4x3dzj4W4GTY9W2HwzXHr6YMGjHN5mNFF3dY0o7729H5qUefN06Ui1ENnzU+Q
         kYSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFddcGyhptMm+2xdyIUa0ItGLGR0Vxo6wOr4iyODlQyGvAfJwm3tv0TXOJ/CHreL2YIyi216vZr0khZxKR5r5o@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb2cX8HKMRvSLoRC3zoXjhIvO1aEYuvO8+ETnPnm6PHr5Y5+r3
	iZlnp6vh2W2v9XLHoM2QjFKB58pKN3X+8IQvqvR6xOgew3Y2jvcDpnwfsGW+S6ZoF74EPK7sA83
	67qgIJEGd+A==
X-Google-Smtp-Source: AGHT+IHThaOZrwv7vNnjKKkw81fYMbm9wUwXPz7cKmEhuXFkBx/N0hqwMXNTYQXdJH17JJRVF0v9BYCDBmii
X-Received: from plkq5.prod.google.com ([2002:a17:902:edc5:b0:234:9673:1d13])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a2f:b0:23d:dd63:2cd9
 with SMTP id d9443c01a7336-23dee27dc17mr231875115ad.46.1752511467196; Mon, 14
 Jul 2025 09:44:27 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:43:55 -0700
In-Reply-To: <20250714164405.111477-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250714164405.111477-8-irogers@google.com>
Subject: [PATCH v7 07/16] perf list: Skip ABI PMUs when printing pmu values
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

