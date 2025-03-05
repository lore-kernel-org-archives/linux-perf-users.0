Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EC71FBEBB
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Mar 2025 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163866; cv=none; b=oO6dDe0Tk9ea2J3UkbUQsJZ6YBjU641GR2LyVZxgkM4KtytV1q55ZNYPNBSR4yIqGace1zbje0exu0tUbciwVzsoWQCZT6NoNxEQKjnJItQ+vP7eEuT0ZhE0Q/wQUq2u/m0cqFnuiNf8s7y5f1EXRTkW/t9QH4QX/uppexExPDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163866; c=relaxed/simple;
	bh=73CMqsI6ltiMfKo0zTZ1MhsK65vAj0Xl5SpZcfSLe0A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=lgpfaJQst97WazUG3Hz0ED4+JOK/46xHRatoZRxAy8dceJkfrqCglIMh4W4poYf+CUYajyikm852j5Kr/MAUuSJ+tkHTDSNBMMwrFNuxE2W9EcZpbESImKrVQO5iap926ZBkLgaLp/8awUfXoCwvnWtwD2Rj7v2fUDqksjHd2TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MTkfb6PA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MTkfb6PA"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2f816a85facso12586932a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Mar 2025 00:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741163864; x=1741768664; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PJkJvluSeMo+ZlVM2pBzVPrtGuT6ee/lxX/BgXG/RPU=;
        b=MTkfb6PAGyoOw5HIfKg+L9sTAdonq0veg4BPZtE0RaA9xufZiP2O0RtiNS4WUdLdHL
         03exFFJTIKSMSmQRBMidkFZq9u1ZxpOQmBLd6DT57K6yXOHKuWUtMVYOQRn0YqcTg6jp
         cX7pBOiC1n+Af1hJtcQaWyMzwuR8Gcl79D/zWcw+7edFuk5L6bjIhd5L6N2QInPXmIUe
         xvBtQdfHDWCfdxxrGCFYO2qV7uefTG9Bp+Nk4849JcNDJGI+gC10BFgb902DMatNrO/i
         lhXp0aPSkQeJYL64TqmcsF+z08YlIMc4RytRN0ScGNV1+p3Med4WCcQ/E4jotpfdPVsi
         2Z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741163864; x=1741768664;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJkJvluSeMo+ZlVM2pBzVPrtGuT6ee/lxX/BgXG/RPU=;
        b=Rr4dIzHSaRJcnTrct2p3YNaPG7R7vqHCRiDUnx1d/Gu0HfiRKbxEVAGZK2BGaV/K1v
         Y8eQ/ZvMB03GmBPSQMGrc2Zscia/dj6P+AcOJ7/xzA3tSWgYOqZAITcpKo++YfT4MDMQ
         a7yPelQ2HbkQi33YVbUCPeIEjespANB5paWaz/JOkr0R35kP+H9XxgmJs83Ha26o9JjD
         n6zOO6a8bj5hKWFjXhotbaXZSMzb69CxpiTSRGe/2OYJZdzFcm16UVaLg5pRxK8x1wmY
         XbjUJqqKr1GxXRvSmwUlXNFxVM3VaMGStiYSEXkI8mwa7cHk8cM3ushj+Bsr06zbzUAJ
         RAcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQOQFyz/kdFCCucHYek4hh79z8P08V8OBbNLZ1fBzo9solePa9SAMWS4mKCytu6bXBgaop6aowSY9AiPuKtWDg@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe7rQIiHCtR/yvWvZNepPRrn/4QOb7KBerDSxg7uG0EVuFc7DB
	DwPTUdI0icl6NILzXXFARtnXLP479wAQmaCODf2tEEjRwlPimyrSEQdhIyBxJyyN1Ak/yxuFyML
	OY+6mqQ==
X-Google-Smtp-Source: AGHT+IEbhvK9ygphggwmJAJicPUO7+jCcx3u0uxRXF2xn4YkspBI7W1oR14RUfHie2v62lo7kEtjfm8zMkaY
X-Received: from pgc21.prod.google.com ([2002:a05:6a02:2f95:b0:ad5:45a5:644c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1583:b0:1f3:3da7:e7dc
 with SMTP id adf61e73a8af0-1f349480fe7mr4389277637.9.1741163863807; Wed, 05
 Mar 2025 00:37:43 -0800 (PST)
Date: Wed,  5 Mar 2025 00:37:34 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250305083735.393333-1-irogers@google.com>
Subject: [PATCH v1 1/2] perf tools: Improve handling of hybrid PMUs in perf_event_attr__fprintf
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Andi Kleen <ak@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Support the PMU name from the legacy hardware and hw_cache PMU
extended types.  Remove some macros and make variables more intention
revealing, rather than just being called "value".

Before:
```
$ perf stat -vv -e instructions true
...
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             136
  config                           0xa00000001
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 181636  cpu -1  group_fd -1  flags 0x8 = 5
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             136
  config                           0x400000001
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 181636  cpu -1  group_fd -1  flags 0x8 = 6
...
```

After:
```
$ perf stat -vv -e instructions true
...
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             136
  config                           0xa00000001 (cpu_atom/PERF_COUNT_HW_INSTRUCTIONS/)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 181724  cpu -1  group_fd -1  flags 0x8 = 5
------------------------------------------------------------
perf_event_attr:
  type                             0 (PERF_TYPE_HARDWARE)
  size                             136
  config                           0x400000001 (cpu_core/PERF_COUNT_HW_INSTRUCTIONS/)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
------------------------------------------------------------
sys_perf_event_open: pid 181724  cpu -1  group_fd -1  flags 0x8 = 6
...
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/perf_event_attr_fprintf.c | 124 +++++++++++++---------
 1 file changed, 75 insertions(+), 49 deletions(-)

diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index c7f3543b9921..66b666d9ce64 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -79,24 +79,22 @@ static void __p_read_format(char *buf, size_t size, u64 value)
 #define ENUM_ID_TO_STR_CASE(x) case x: return (#x);
 static const char *stringify_perf_type_id(struct perf_pmu *pmu, u32 type)
 {
-	if (pmu)
-		return pmu->name;
-
 	switch (type) {
 	ENUM_ID_TO_STR_CASE(PERF_TYPE_HARDWARE)
 	ENUM_ID_TO_STR_CASE(PERF_TYPE_SOFTWARE)
 	ENUM_ID_TO_STR_CASE(PERF_TYPE_TRACEPOINT)
 	ENUM_ID_TO_STR_CASE(PERF_TYPE_HW_CACHE)
-	ENUM_ID_TO_STR_CASE(PERF_TYPE_RAW)
 	ENUM_ID_TO_STR_CASE(PERF_TYPE_BREAKPOINT)
+	case PERF_TYPE_RAW:
+		return pmu ? pmu->name : "PERF_TYPE_RAW";
 	default:
-		return NULL;
+		return pmu ? pmu->name : NULL;
 	}
 }
 
 static const char *stringify_perf_hw_id(u64 value)
 {
-	switch (value) {
+	switch (value & PERF_HW_EVENT_MASK) {
 	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CPU_CYCLES)
 	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_INSTRUCTIONS)
 	ENUM_ID_TO_STR_CASE(PERF_COUNT_HW_CACHE_REFERENCES)
@@ -169,79 +167,100 @@ static const char *stringify_perf_sw_id(u64 value)
 }
 #undef ENUM_ID_TO_STR_CASE
 
-#define PRINT_ID(_s, _f)					\
-do {								\
-	const char *__s = _s;					\
-	if (__s == NULL)					\
-		snprintf(buf, size, _f, value);			\
-	else							\
-		snprintf(buf, size, _f" (%s)", value, __s);	\
-} while (0)
-#define print_id_unsigned(_s)	PRINT_ID(_s, "%"PRIu64)
-#define print_id_hex(_s)	PRINT_ID(_s, "%#"PRIx64)
+static void print_id_unsigned(char *buf, size_t size, u64 value, const char *s)
+{
+	if (s == NULL)
+		snprintf(buf, size, "%"PRIu64, value);
+	else
+		snprintf(buf, size, "%"PRIu64" (%s)", value, s);
+}
+
+static void print_id_hex(char *buf, size_t size, u64 value, const char *s)
+{
+	if (s == NULL)
+		snprintf(buf, size, "%#"PRIx64, value);
+	else
+		snprintf(buf, size, "%#"PRIx64" (%s)", value, s);
+}
 
-static void __p_type_id(struct perf_pmu *pmu, char *buf, size_t size, u64 value)
+static void __p_type_id(char *buf, size_t size, struct perf_pmu *pmu, u32 type)
 {
-	print_id_unsigned(stringify_perf_type_id(pmu, value));
+	print_id_unsigned(buf, size, type, stringify_perf_type_id(pmu, type));
 }
 
-static void __p_config_hw_id(char *buf, size_t size, u64 value)
+static void __p_config_hw_id(char *buf, size_t size, struct perf_pmu *pmu, u64 config)
 {
-	print_id_hex(stringify_perf_hw_id(value));
+	const char *name = stringify_perf_hw_id(config);
+
+	if (name == NULL) {
+		if (pmu == NULL) {
+			snprintf(buf, size, "%#"PRIx64, config);
+		} else {
+			snprintf(buf, size, "%#"PRIx64" (%s/config=%#"PRIx64"/)", config, pmu->name,
+				 config);
+		}
+	} else {
+		if (pmu == NULL)
+			snprintf(buf, size, "%#"PRIx64" (%s)", config, name);
+		else
+			snprintf(buf, size, "%#"PRIx64" (%s/%s/)", config, pmu->name, name);
+	}
 }
 
-static void __p_config_sw_id(char *buf, size_t size, u64 value)
+static void __p_config_sw_id(char *buf, size_t size, u64 id)
 {
-	print_id_hex(stringify_perf_sw_id(value));
+	print_id_hex(buf, size, id, stringify_perf_sw_id(id));
 }
 
-static void __p_config_hw_cache_id(char *buf, size_t size, u64 value)
+static void __p_config_hw_cache_id(char *buf, size_t size, struct perf_pmu *pmu, u64 config)
 {
-	const char *hw_cache_str = stringify_perf_hw_cache_id(value & 0xff);
+	const char *hw_cache_str = stringify_perf_hw_cache_id(config & 0xff);
 	const char *hw_cache_op_str =
-		stringify_perf_hw_cache_op_id((value & 0xff00) >> 8);
+		stringify_perf_hw_cache_op_id((config & 0xff00) >> 8);
 	const char *hw_cache_op_result_str =
-		stringify_perf_hw_cache_op_result_id((value & 0xff0000) >> 16);
-
-	if (hw_cache_str == NULL || hw_cache_op_str == NULL ||
-	    hw_cache_op_result_str == NULL) {
-		snprintf(buf, size, "%#"PRIx64, value);
+		stringify_perf_hw_cache_op_result_id((config & 0xff0000) >> 16);
+
+	if (hw_cache_str == NULL || hw_cache_op_str == NULL || hw_cache_op_result_str == NULL) {
+		if (pmu == NULL) {
+			snprintf(buf, size, "%#"PRIx64, config);
+		} else {
+			snprintf(buf, size, "%#"PRIx64" (%s/config=%#"PRIx64"/)", config, pmu->name,
+				 config);
+		}
 	} else {
-		snprintf(buf, size, "%#"PRIx64" (%s | %s | %s)", value,
-			 hw_cache_op_result_str, hw_cache_op_str, hw_cache_str);
+		if (pmu == NULL) {
+			snprintf(buf, size, "%#"PRIx64" (%s | %s | %s)", config,
+				 hw_cache_op_result_str, hw_cache_op_str, hw_cache_str);
+		} else {
+			snprintf(buf, size, "%#"PRIx64" (%s/%s | %s | %s/)", config, pmu->name,
+				 hw_cache_op_result_str, hw_cache_op_str, hw_cache_str);
+		}
 	}
 }
 
-static void __p_config_tracepoint_id(char *buf, size_t size, u64 value)
+static void __p_config_tracepoint_id(char *buf, size_t size, u64 id)
 {
-	char *str = tracepoint_id_to_name(value);
+	char *str = tracepoint_id_to_name(id);
 
-	print_id_hex(str);
+	print_id_hex(buf, size, id, str);
 	free(str);
 }
 
-static void __p_config_id(struct perf_pmu *pmu, char *buf, size_t size, u32 type, u64 value)
+static void __p_config_id(struct perf_pmu *pmu, char *buf, size_t size, u32 type, u64 config)
 {
-	const char *name = perf_pmu__name_from_config(pmu, value);
-
-	if (name) {
-		print_id_hex(name);
-		return;
-	}
 	switch (type) {
 	case PERF_TYPE_HARDWARE:
-		return __p_config_hw_id(buf, size, value);
+		return __p_config_hw_id(buf, size, pmu, config);
 	case PERF_TYPE_SOFTWARE:
-		return __p_config_sw_id(buf, size, value);
+		return __p_config_sw_id(buf, size, config);
 	case PERF_TYPE_HW_CACHE:
-		return __p_config_hw_cache_id(buf, size, value);
+		return __p_config_hw_cache_id(buf, size, pmu, config);
 	case PERF_TYPE_TRACEPOINT:
-		return __p_config_tracepoint_id(buf, size, value);
+		return __p_config_tracepoint_id(buf, size, config);
 	case PERF_TYPE_RAW:
 	case PERF_TYPE_BREAKPOINT:
 	default:
-		snprintf(buf, size, "%#"PRIx64, value);
-		return;
+		return print_id_hex(buf, size, config, perf_pmu__name_from_config(pmu, config));
 	}
 }
 
@@ -253,7 +272,7 @@ static void __p_config_id(struct perf_pmu *pmu, char *buf, size_t size, u32 type
 #define p_sample_type(val)	__p_sample_type(buf, BUF_SIZE, val)
 #define p_branch_sample_type(val) __p_branch_sample_type(buf, BUF_SIZE, val)
 #define p_read_format(val)	__p_read_format(buf, BUF_SIZE, val)
-#define p_type_id(val)		__p_type_id(pmu, buf, BUF_SIZE, val)
+#define p_type_id(val)		__p_type_id(buf, BUF_SIZE, pmu, val)
 #define p_config_id(val)	__p_config_id(pmu, buf, BUF_SIZE, attr->type, val)
 
 #define PRINT_ATTRn(_n, _f, _p, _a)			\
@@ -273,6 +292,13 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 	char buf[BUF_SIZE];
 	int ret = 0;
 
+	if (!pmu && (attr->type == PERF_TYPE_HARDWARE || attr->type == PERF_TYPE_HW_CACHE)) {
+		u32 extended_type = attr->config >> PERF_PMU_TYPE_SHIFT;
+
+		if (extended_type)
+			pmu = perf_pmus__find_by_type(extended_type);
+	}
+
 	PRINT_ATTRn("type", type, p_type_id, true);
 	PRINT_ATTRf(size, p_unsigned);
 	PRINT_ATTRn("config", config, p_config_id, true);
-- 
2.48.1.711.g2feabab25a-goog

