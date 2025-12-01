Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7F23358C8
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607311; cv=none; b=TrPPDzWXATmwAaCtZ7KK1xhpkJp4Pcyr2ltR8yR55rVpCxZ3Rt27i4kOQhoWwd8I8ZTsQgqpXbbV7c0lYtqP4Hgk2M/5roWmE2RTdbcbpbRZcdXgBHsJ9iZJCvR3xltw/7CEj/atAc0p+Vl0AKnc4MKAdnn+4h/hkbA6Q92VjWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607311; c=relaxed/simple;
	bh=SLaYdEHzakF3Enk+K7jxOiLbeMI4gzx9C/7lLRmhoNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nvYdG/lqOtJ9MxOCgiIf1zkEu22uu6B23hC6fMlqJ8h7D9LzotrEfC192mKw06O/qbH9fCh1NGPOl1G6K1fUPNGMmWn5w8zYPASpOmx918PjCKb1TDhSttVGPyjuGrNqqpZz1ordImjlWwtFLRtkh4C4w3z6QM3UuHlQK4YWinM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oHx9GypC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oHx9GypC"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so40473175e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 08:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764607308; x=1765212108; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zABew4dqD3IbbU1tyEn5D3f43+dljvZpz0Ak8Px/2GQ=;
        b=oHx9GypCoLmeOj6LIKUPjtJWrIB/4TU0QXWpk3PAhBo1RyX2VnxABhTekpiOKYVDQz
         UR+U3vnRuXBU2fBpges4cva9KFWnJD6++L3eHBfp4KtvElIvPPr0YfxXn03fWfMsfNnU
         ++TA8qiAa4hNV/J/58ftq8SLu201wYikiwXCSM97RRnjl8HewpA4PS583HdP1QiSrYsP
         hLZDzF9x9V8x993nDNcvyxkmUFZxyHdMI1hHW0aZDQPCud5RmgvXzBVwvLGqBXHV99dX
         3Ve5xeCyu/ARWWNCHpxQY0Jrq8b0hmecTQsvmubO4NgUCsdjf7tOsW2PtHw6ItVhQ38A
         qbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764607308; x=1765212108;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zABew4dqD3IbbU1tyEn5D3f43+dljvZpz0Ak8Px/2GQ=;
        b=vR/hROlPg2AXWfbzQPY0hdB2yvMrMObcSyfIh1a0UHiaitkMBwwgWHLtxoFaiz9y+R
         Z5G2/GucE7Wk5xU9ya4iNyEQfRpqLDDWjZgRiX4qQB8ssOyV+6BgOImLR35P/tj5BFyM
         tJ7JPHKyJe1ZOKHXI8QfwQKpSNYRfJWRjTw8irEThSvRi0FhzfY/XcHr3plwwnjjrNw3
         sM/6t0e4aszB6hXt/NtMe0M4EgZPAIXRnnloipO4O06JHf1pgZhufzGfhf2KFjDEPei0
         LPVzoAPNnepbtsxA0uWuuwb7NIw/YoKGaTA/PDDxhXWmOjnRyErrScQWIIlelVVQYCJ1
         0YzA==
X-Gm-Message-State: AOJu0YyQoNewCQNnZz1sikO5UJC+IGgg7F+AkVrTFnZHGrpleoCQH/XS
	5n+Pg3BhM65rDvbppL22jUGH3zt9eJPuR0vRN70+MYNYAPMQw6HOMreMyXyrqd0UDIo=
X-Gm-Gg: ASbGncvqeXk2UjRIz2mk32UEqfvB0ZX6iB/hKm7xJFHKz7F0p5aq395m9EaiWAni9+L
	0G9O9/NooY+RGyoLe5ZylkpdOJmaHFD66s7pg7ujRktJzOxNOj0DBVI466aC9OqLLefgTPz+ZFO
	3FhCYWahVm2hmh/F1KebrUQ7eN1tzX4oAkcHeoK9GVhCXhbH6iKtOK4sFjKMO3inb7Iagg0fDgF
	tgOcfkxaITPJa00IUVkdtcPC2FrTfZuceAosJyqN3W2wV0ThiqrNgzuYcpcCpTtqV4EVwindJtP
	5C5IM07sFBEwNOyPHzzxuHyOwcUXIudCy38hhnC5cX6H7sBkUP3eClKpr9f7sVvN+QB6IVU9WcC
	qzIynttpZz8aE+Oi/ZrTnl4vDR7tlE19dyLfBEpw4fFUtXuxqiJPYfKcfz/wJwsTIVsotSUsKcs
	ieQk3aS/BB4HOWMakVmio2jyoj8YFlDDs=
X-Google-Smtp-Source: AGHT+IH4qlSHOHlP9FoC3pEYptApY3iIhEO5qtBZvowYnB5XerIVCpLZUtOXG+kLqnlpOo12ry8aAw==
X-Received: by 2002:a05:600c:4685:b0:477:5b0a:e616 with SMTP id 5b1f17b1804b1-47904acaf28mr248918075e9.5.1764607307979;
        Mon, 01 Dec 2025 08:41:47 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791164d4f3sm255901275e9.13.2025.12.01.08.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 08:41:47 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 01 Dec 2025 16:41:07 +0000
Subject: [PATCH 4/7] perf cs-etm: Don't use hard coded config bits when
 setting up ETMCR
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-james-perf-config-bits-v1-4-22ecbbf8007c@linaro.org>
References: <20251201-james-perf-config-bits-v1-0-22ecbbf8007c@linaro.org>
In-Reply-To: <20251201-james-perf-config-bits-v1-0-22ecbbf8007c@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Perf only looks at attr.config when determining what was programmed into
ETMCR. These bits could theoretically be in any of the config fields.
Add a generic helper to find the value of any named format field in any
config field and then use it to get the attributes relevant to ETMCR.

The kernel will also stop publishing the ETMCR register bits in a header
[1] so preempt that by defining them here.

[1]: https://lore.kernel.org/linux-arm-kernel/20251128-james-cs-syncfreq-v8-10-4d319764cc58@linaro.org/
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 35 ++++++++++++++++++++++++++++++++++-
 tools/perf/util/evsel.h           |  2 ++
 tools/perf/util/pmu.c             | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 22c6272e8c36..414cafb21c98 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -68,6 +68,12 @@ static const char * const metadata_ete_ro[] = {
 
 enum cs_etm_version { CS_NOT_PRESENT, CS_ETMV3, CS_ETMV4, CS_ETE };
 
+
+/* ETMv3 ETMCR register bits */
+#define ETMCR_CYC_ACC		BIT(12)
+#define ETMCR_TIMESTAMP_EN	BIT(28)
+#define ETMCR_RETURN_STACK	BIT(29)
+
 static bool cs_etm_is_ete(struct perf_pmu *cs_etm_pmu, struct perf_cpu cpu);
 static int cs_etm_get_ro(struct perf_pmu *pmu, struct perf_cpu cpu, const char *path, __u64 *val);
 static bool cs_etm_pmu_path_exists(struct perf_pmu *pmu, struct perf_cpu cpu, const char *path);
@@ -487,6 +493,33 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	return err;
 }
 
+static u64 cs_etm_guess_etmcr(struct auxtrace_record *itr)
+{
+	struct cs_etm_recording *ptr =
+		container_of(itr, struct cs_etm_recording, itr);
+	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
+	struct evsel *evsel = cs_etm_get_evsel(ptr->evlist, cs_etm_pmu);
+	u64 etmcr = 0;
+	u64 val;
+
+	if (!evsel)
+		return 0;
+
+	/*
+	 * Roughly guess what the kernel programmed into ETMCR based on
+	 * what options the event was opened with. This doesn't have to be
+	 * complete or 100% accurate, not all bits used by OpenCSD anyway.
+	 */
+	if (!evsel__get_config_val(cs_etm_pmu, evsel, "cycacc", &val) && val)
+		etmcr |= ETMCR_CYC_ACC;
+	if (!evsel__get_config_val(cs_etm_pmu, evsel, "timestamp", &val) && val)
+		etmcr |= ETMCR_TIMESTAMP_EN;
+	if (!evsel__get_config_val(cs_etm_pmu, evsel, "retstack", &val) && val)
+		etmcr |= ETMCR_RETURN_STACK;
+
+	return etmcr;
+}
+
 static u64 cs_etm_get_config(struct auxtrace_record *itr)
 {
 	struct cs_etm_recording *ptr =
@@ -746,7 +779,7 @@ static void cs_etm_get_metadata(struct perf_cpu cpu, u32 *offset,
 	case CS_ETMV3:
 		magic = __perf_cs_etmv3_magic;
 		/* Get configuration register */
-		info->priv[*offset + CS_ETM_ETMCR] = cs_etm_get_config(itr);
+		info->priv[*offset + CS_ETM_ETMCR] = cs_etm_guess_etmcr(itr);
 		/* traceID set to legacy value in case new perf running on old system */
 		info->priv[*offset + CS_ETM_ETMTRACEIDR] = cs_etm_get_legacy_trace_id(cpu);
 		/* Get read-only information from sysFS */
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 3ae4ac8f9a37..1c567cc70a82 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -574,6 +574,8 @@ void evsel__uniquify_counter(struct evsel *counter);
 	((((src) >> (pos)) & ((1ull << (size)) - 1)) << (63 - ((pos) + (size) - 1)))
 
 u64 evsel__bitfield_swap_branch_flags(u64 value);
+int evsel__get_config_val(struct perf_pmu *pmu, struct evsel *evsel,
+			  const char *config_name, u64 *val);
 void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 				const char *config_name, u64 val);
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index c8968cddc0a9..5501b0230097 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1384,6 +1384,39 @@ pmu_find_format(const struct list_head *formats, const char *name)
 	return NULL;
 }
 
+int evsel__get_config_val(struct perf_pmu *pmu, struct evsel *evsel,
+			  const char *config_name, u64 *val)
+{
+	struct perf_pmu_format *format = pmu_find_format(&pmu->format, config_name);
+	u64 bits = perf_pmu__format_bits(pmu, config_name);
+
+	if (!format || !bits) {
+		pr_err("Unknown/empty format name: %s\n", config_name);
+		return -EINVAL;
+	}
+
+	switch (format->value) {
+	case PERF_PMU_FORMAT_VALUE_CONFIG:
+		*val = FIELD_GET(bits, evsel->core.attr.config);
+		return 0;
+	case PERF_PMU_FORMAT_VALUE_CONFIG1:
+		*val = FIELD_GET(bits, evsel->core.attr.config1);
+		return 0;
+	case PERF_PMU_FORMAT_VALUE_CONFIG2:
+		*val = FIELD_GET(bits, evsel->core.attr.config2);
+		return 0;
+	case PERF_PMU_FORMAT_VALUE_CONFIG3:
+		*val = FIELD_GET(bits, evsel->core.attr.config3);
+		return 0;
+	case PERF_PMU_FORMAT_VALUE_CONFIG4:
+		*val = FIELD_GET(bits, evsel->core.attr.config4);
+		return 0;
+	default:
+		pr_err("Unknown format value: %d\n", format->value);
+		return -EINVAL;
+	}
+}
+
 /*
  * Set @config_name to @val as long as the user hasn't already set or cleared it
  * by passing a config term on the command line.

-- 
2.34.1

