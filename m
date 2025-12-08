Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF41E3176EF
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Dec 2025 14:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765203807; cv=none; b=m80tdJZh6GiBPK8akk+9ANrQIC74vQhwC4ae1jrG7nGwmi9nMOs+XP18VylbHxKzzs4Ic7SJwVZaOlSfV5NQeTsjMHN0HX8tEHGoSGujc1iu6pgdjQ6GQA79qPWvXOtJzCcmqPtaIXiopVEJSNImv08PCzR6hg/YmeBw9otz5lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765203807; c=relaxed/simple;
	bh=X/msMFwhX0wLMQ0DfyqjBDYpojeE6MPsUgOWEjzkTWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b3EV2pZ5eGm5+062w2QQgRr5yY98JpBf/R1ndnL1/CFVmX1AVkBzOMtbwl3ZbGTsV9Jgj0wEqBmBeQaQp7/mNKWvszWGueQ7xcyeG4HWZa/TcakrLg/MrKP/gIYuMs132W9pb89baZRcU+8qXkm47eL+kWl9vDkU10BpX00i8IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yj9g6pyu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yj9g6pyu"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477b91680f8so50577525e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Dec 2025 06:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765203804; x=1765808604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0SkqXfoDch2Crrep+7q41phmdji29dr3SE6FUuXCaY=;
        b=yj9g6pyuHgm6dFWlxsDa8sRnheIwzqeeL9OKCy6h8eWQVWXmNHxgmXb8SvHq/G5sUg
         +VYWriOzUci0lby5Jjl5G77YO/LOTDxkne0Q9xtN9OG9y5LpjWRhl9ujkldVP3fX/mK0
         9/XNVwxtN/yPQmhaCUonq3kYgroxMO2ihJuDeoDFPyKAvi5lInf7N6lyryJO++bUsGp+
         tGR95XaST8WF5fYTzJxNj2oDhUDf0Ib/Cu2CaOVVjZ2BBcfDOsZ+mIy5eDetEaxP7iwf
         IL/Zm9BAMw0D6FMbvlFnugHEqKv7s/yL6kJEMZ+ljriL2A9DNm4zHm4AKXMbaBUusYrW
         Tspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765203804; x=1765808604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y0SkqXfoDch2Crrep+7q41phmdji29dr3SE6FUuXCaY=;
        b=Jt+QiHZXXE8Vd7E0yNXP/02xv59EWS8mCOQJEMnWZzp6gFQhxGRBywtgJqJPBequKp
         FhjRJVANUCXCE+rMPsRnFsUOEUNuGLYVLD7aTkZzD7giUAvFmYgeYs+5tj+lIVkfiegQ
         4kfGLuHTDKHsxjbNw6Ms4vsV74eC8E67i8UxmW8qFIgSdpEyYwUTToW12gcoNkPTv95C
         KrXI8yXSlmmWcoynszIAnKkmW/tCHHZzbkoH1+JAxUvwQxS8qAITYuyYykoGzVKPCcTJ
         J5nAP5IMjkbpoWAuM59cfCtTY3zy+4HmukeEhmmwEjGQo0YNhBvEtSqGvoJZZ6m9CgTA
         CT4w==
X-Gm-Message-State: AOJu0YxLaB7NuZQgjCJ2EonHMuGXW5/OJ7XFJ+8zQbYRDipmead3c7Y2
	7y+aIBCO/3CNal1cUsrPPWGAnMHFNb0YdhjnOYENLp2/d8Xn9AiVtUGcVjCrljorOV0=
X-Gm-Gg: ASbGncs17ECTzybLhZ7AsRhZCLciE6RDQM49ENuAwOXHSm8xDbli7iOJ+qi1XWiuQHe
	cRge3VoqhF9mzkty0EMyOk7UnBJkJ8YGLWchlDNv3j5zz8bOt/0DTVMvm1TS96ry9gKquVMv8bm
	qfkwc4iGEelNTQePpv/qGofKLfWjg1at6kwQUdVVOd8jpYrRIxNlOWnMHwY1pz5xXxQzZ1q1szQ
	DJ2x/gg7F52HyZi9z/vRQleCvRoNJOCrGyNU7ttO+75+Hao7aGPtLb09hjbA2ER/0db8D9f19P3
	5KT1QaCMlxXu8d12vT3lUynKhkuKGCHwMjiEJeMUAJaYkVWrfS4i8/NBYDFZaZACO2Z6nkD6TIA
	OTULeAeumFxGNtAHCKar6ZsBhDpB6rMVgGsxOqddDl2KCnOEEX5n5lBM1QyEP8KpJxidm9F6Br0
	JAE0CcjRshuJgAK3VKPgp+
X-Google-Smtp-Source: AGHT+IHwhLKOnPQJeWTWX0qTh2VoeWymbnjL3OsZC8/GHM1ActCoWHWUVxRUFsk4tnHyrFVHMqEDIg==
X-Received: by 2002:a05:600c:3e8c:b0:475:d8b3:a9d5 with SMTP id 5b1f17b1804b1-47939dfa460mr81661905e9.10.1765203804015;
        Mon, 08 Dec 2025 06:23:24 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47930920e0dsm248561065e9.2.2025.12.08.06.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 06:23:23 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 08 Dec 2025 14:22:08 +0000
Subject: [PATCH v2 05/12] perf evsel: Add a helper to get the value of a
 config field
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-james-perf-config-bits-v2-5-4ac0281993b0@linaro.org>
References: <20251208-james-perf-config-bits-v2-0-4ac0281993b0@linaro.org>
In-Reply-To: <20251208-james-perf-config-bits-v2-0-4ac0281993b0@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>, 
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, leo.yan@arm.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

This will be used by aux PMUs to read an already written value for
configuring their events and for also testing.

Its helper pmu_format_unpack() does the opposite of the existing
pmu_format_value() so rename that one to pmu_format_pack() so it's clear
how they are related.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/evsel.h |  2 ++
 tools/perf/util/pmu.c   | 77 ++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 68 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index a08130ff2e47..092904a61ec7 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -575,6 +575,8 @@ void evsel__uniquify_counter(struct evsel *counter);
 	((((src) >> (pos)) & ((1ull << (size)) - 1)) << (63 - ((pos) + (size) - 1)))
 
 u64 evsel__bitfield_swap_branch_flags(u64 value);
+int evsel__get_config_val(struct perf_pmu *pmu, struct evsel *evsel,
+			  const char *config_name, u64 *val);
 void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 				const char *config_name, u64 val);
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 514cba91f5d9..ef7358ad1fb9 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -144,8 +144,8 @@ struct perf_pmu_format {
 };
 
 static int pmu_aliases_parse(struct perf_pmu *pmu);
-static void pmu_format_value(unsigned long *format, __u64 value, __u64 *v,
-			     bool zero);
+static void pmu_format_pack(unsigned long *format, __u64 value, __u64 *v,
+			    bool zero);
 static struct perf_pmu_format *pmu_find_format(const struct list_head *formats,
 					       const char *name);
 
@@ -1377,6 +1377,61 @@ bool evsel__is_aux_event(const struct evsel *evsel)
 	return pmu && pmu->auxtrace;
 }
 
+/*
+ * Unpacks a raw config[n] value using the sparse bitfield that defines a
+ * format attr. For example "config1:1,6-7,44" defines a 4 bit value across non
+ * contiguous bits and this function returns those 4 bits as a value.
+ */
+static u64 pmu_format_unpack(u64 format, u64 config_val)
+{
+	int val_bit = 0;
+	u64 res = 0;
+	int fmt_bit;
+
+	for_each_set_bit(fmt_bit, &format, PERF_PMU_FORMAT_BITS) {
+		if (test_bit(fmt_bit, &config_val))
+			res |= BIT_ULL(val_bit);
+
+		val_bit++;
+	}
+	return res;
+}
+
+int evsel__get_config_val(struct perf_pmu *pmu, struct evsel *evsel,
+			  const char *config_name, u64 *val)
+{
+	struct perf_pmu_format *format = pmu_find_format(&pmu->format, config_name);
+	u64 bits = perf_pmu__format_bits(pmu, config_name);
+
+	if (!format || !bits) {
+		pr_err("Unknown/empty format name: %s\n", config_name);
+		*val = 0;
+		return -EINVAL;
+	}
+
+	switch (format->value) {
+	case PERF_PMU_FORMAT_VALUE_CONFIG:
+		*val = pmu_format_unpack(bits, evsel->core.attr.config);
+		return 0;
+	case PERF_PMU_FORMAT_VALUE_CONFIG1:
+		*val = pmu_format_unpack(bits, evsel->core.attr.config1);
+		return 0;
+	case PERF_PMU_FORMAT_VALUE_CONFIG2:
+		*val = pmu_format_unpack(bits, evsel->core.attr.config2);
+		return 0;
+	case PERF_PMU_FORMAT_VALUE_CONFIG3:
+		*val = pmu_format_unpack(bits, evsel->core.attr.config3);
+		return 0;
+	case PERF_PMU_FORMAT_VALUE_CONFIG4:
+		*val = pmu_format_unpack(bits, evsel->core.attr.config4);
+		return 0;
+	default:
+		pr_err("Unknown format value: %d\n", format->value);
+		*val = 0;
+		return -EINVAL;
+	}
+}
+
 /*
  * Set @config_name to @val as long as the user hasn't already set or cleared it
  * by passing a config term on the command line.
@@ -1432,7 +1487,7 @@ void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
 		return;
 
 	/* Otherwise replace it */
-	pmu_format_value(&bits, val, vp, /*zero=*/true);
+	pmu_format_pack(&bits, val, vp, /*zero=*/true);
 }
 
 static struct perf_pmu_format *
@@ -1477,8 +1532,8 @@ int perf_pmu__format_type(struct perf_pmu *pmu, const char *name)
  * Sets value based on the format definition (format parameter)
  * and unformatted value (value parameter).
  */
-static void pmu_format_value(unsigned long *format, __u64 value, __u64 *v,
-			     bool zero)
+static void pmu_format_pack(unsigned long *format, __u64 value, __u64 *v,
+			    bool zero)
 {
 	unsigned long fbit, vbit;
 
@@ -1595,23 +1650,23 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 		switch (term->type_term) {
 		case PARSE_EVENTS__TERM_TYPE_CONFIG:
 			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
-			pmu_format_value(bits, term->val.num, &attr->config, zero);
+			pmu_format_pack(bits, term->val.num, &attr->config, zero);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_CONFIG1:
 			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
-			pmu_format_value(bits, term->val.num, &attr->config1, zero);
+			pmu_format_pack(bits, term->val.num, &attr->config1, zero);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_CONFIG2:
 			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
-			pmu_format_value(bits, term->val.num, &attr->config2, zero);
+			pmu_format_pack(bits, term->val.num, &attr->config2, zero);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_CONFIG3:
 			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
-			pmu_format_value(bits, term->val.num, &attr->config3, zero);
+			pmu_format_pack(bits, term->val.num, &attr->config3, zero);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_CONFIG4:
 			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
-			pmu_format_value(bits, term->val.num, &attr->config4, zero);
+			pmu_format_pack(bits, term->val.num, &attr->config4, zero);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
 			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
@@ -1749,7 +1804,7 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 		 */
 	}
 
-	pmu_format_value(format->bits, val, vp, zero);
+	pmu_format_pack(format->bits, val, vp, zero);
 	return 0;
 }
 

-- 
2.34.1

