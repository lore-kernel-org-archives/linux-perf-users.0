Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E9C31B81C
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553574; cv=none; b=S4LR4sVnIicR+9Hva37RUIbzLV6NRcqPVqF+gbOowDNy4/NyZ2uU8yiT4P7V6GoYmQo7wYFjoakVe77IsP+5H+AhPMX4iGSh+9eEZeb4xWi0XTvRURUs4PZomoE6E/ah4ehVSdGdzxOHjSxKlntV9TRjYgN9auYB1X+5DZSlAwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553574; c=relaxed/simple;
	bh=2k9PUMsZ7sr/50mD7OnNnMTOF48xX1ROwsUNkXp8J9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KaDzjxLBQPcgSpR1NPuw2BPOiKQLH466Sqvil5jvxRCKZ2qr1ohXE4ZRo6296qT1KpHIwroCjQwCeHG/8liqWGFoK4s/HtbkRKuIJenmKsmgUwOT3MazSiQgvE1eeHIn+UQzstwmjHoRkqFxBYBxjqVNKIvqcIgErkClL9n4bUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rLW5WyTq; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rLW5WyTq"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b735b89501fso177295566b.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 07:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765553571; x=1766158371; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfXl40fnB74AGQ/vJ3IYApuDFV3Ub/cQrhNchAtNkEM=;
        b=rLW5WyTqDGQUds0h7CCySL1m4jIh2LSXS8DsF0BCpQfSG0jKdkAdp8U9A/pMnrvv6x
         Rs4IA1XQ/nsAX2/ILH/Kgw/VmlFSdR/R8kvfctpgHciKnd4pZxd9DbkqKx3MRgjSRXz3
         ZwplKdrg9pgs1PetKFH14K3yIOzVkRN02aUz3qH49wuVeT8N2Vgm2+Ev04zTZFTveNW6
         8sMyhuJk71JAjr2NA0O7e/KYqDKi4v6w6MRGrW1fuvU/I1Kq63qeGve1nLC6oz7BUBdz
         V3aa29PYTndOd3bU4D/8n2GXSE7Aeay4VRH5N3XPqiLzt0L2m8aLXXfhpcLjd35VrY1H
         554Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765553571; x=1766158371;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FfXl40fnB74AGQ/vJ3IYApuDFV3Ub/cQrhNchAtNkEM=;
        b=PTpiblQEAuxN+ZVfK+ZD1eeGqIa6ArZMOECPViy6Cqgn+24tCmq0ZzRIPFAdoxEXoO
         erhOyWWnJGt0f/IksiGZi/ralT5JdwoDMroragILcKu1mby68vk1kISlQQ10IjnmpHfe
         V9XrIHHG3hgsbSjumwEOBQUBtrjWvNAzWFD2ciE9iZ+z6qngMe2WvAxWMjI/wnTvrvl6
         jDZpRExBn7xA6hR8ygULI64OOO8/AamiC/4a6nuLKwnWPvwRTg8qcdv/tfmn/kSPwRNC
         HgI0lWv5KYOEkR36vz15MpQ6Hrp+8X7Jn9fSTEP5DnaSA6f3EwdhbQ0hxXm3t5mCtFTu
         c6OA==
X-Gm-Message-State: AOJu0Yzr0UMHIZKJ5hTaE+SIxG5fZ8svp//E7Mjkr9h5yiLKf7P320KL
	Dd2sOqc2vSPNwYW/Rt6c/qdiHVvWxQn+0Fg+CIDjnsbzrVF42cXQtvywq3nVXjcttjg=
X-Gm-Gg: AY/fxX6clzPfzLM1DzMIbhCadmDBXWCBEbxUYJdOZ3ix2TFx/F0f/e1xb8jAUASTEUL
	90d6p/y73ZbRkU5o8SVKkmzE4kea48xl4vE9+MKu3xY6M6v2044G7mmw7CIcgZL3G/xNvXTt9D5
	nvsEufl2UQNnQMIngthf5ioPwg9c4O/kcMHu+x3A3ywcWLV+kd6U3Ihd2r/Vjbk6Un82QhoxFtS
	2P1Y/Tsz3/wnKApouL1YM6zCM9elhwz7bIGRKZJXExhk0OmAH1CULJghz/k+9OIaBJR7zlqmBWm
	3+IRlqxihfXcouVtNLie9j/01Vo+ACkB3SHYFnUGTTm4j6nUl+x5KddCRt+iZSUcg9pdr18ouF2
	OHPie86sotpDpq6kUcS9avBRUsknF2OCYnFhmJiu9A8WenTSitmfw/MMH1TOmmAC0h32+dXiS7S
	6qdDYmQW1Ie2NhjkApFHtK
X-Google-Smtp-Source: AGHT+IHTK60JzgqMoXpjzU7e1RoFVa6ExYTj3cwQgdkRaejKQS0ukfr1CN2Po78C7Fi34EABIQiNlQ==
X-Received: by 2002:a17:907:3c91:b0:b73:6b24:14a0 with SMTP id a640c23a62f3a-b7d236670demr231854966b.18.1765553570929;
        Fri, 12 Dec 2025 07:32:50 -0800 (PST)
Received: from e133063.arm.com ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498210ed32sm5433234a12.29.2025.12.12.07.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:32:50 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Fri, 12 Dec 2025 17:32:22 +0200
Subject: [PATCH v3 05/12] perf evsel: Add a helper to get the value of a
 config field
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-james-perf-config-bits-v3-5-aa36a4846776@linaro.org>
References: <20251212-james-perf-config-bits-v3-0-aa36a4846776@linaro.org>
In-Reply-To: <20251212-james-perf-config-bits-v3-0-aa36a4846776@linaro.org>
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
X-Mailer: b4 0.14.2

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
index a08130ff2e47a887b19f6c47bfa9f51e0c40d226..092904a61ec7afdc59253f9b78a9fe8b7cb5bfa7 100644
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
index 514cba91f5d99b399d2d6a1e350971660c54a9fc..ef7358ad1fb955f29f2e68b3d0ce711754e4d67c 100644
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

