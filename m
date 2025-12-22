Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B18D328253
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 15:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416498; cv=none; b=XZU65Zp/XcR8esk2UEqSadMoCb3yYXKYyi5/HU/yDeMPtvRreNJ6A24fQeoiUl+1Ucjuf7QGWRtbcqH7bqUpGRObLvAHIM3Wf0VHhul/XOa8Xa1Gfc10MtfdGC/FKgE18SiByE2957Vy/pz19GryMOVHsZc9AxRTD8RO44NLwgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416498; c=relaxed/simple;
	bh=M/zr80Oeo+sGWSF+YKiiItZy+uMJytYOw7BVT1B9KWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IU59tRcoehtdMhasZppdgDv71P47OhhyVfkKoyXpOKpsmHgd9MJG+O2uL5EQcXIEtQrUnga84XPaxM5Gfpwl82dekKs/K1c9RMVpLqNUS71EhfHMp+31InSnnlY95oTCCfzu+WcJ/MMWOolt23IwjRPnwMTLi4C1exh5qeWTCts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iG0aQ5Gk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iG0aQ5Gk"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so3050179f8f.3
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 07:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766416494; x=1767021294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dusq4givPs/+MmVLybQAr0PfVhdx73n3zpPLiMfCBqA=;
        b=iG0aQ5GkuCJSnTZy4dK3ZKUaz5u3bnd5l2+r7vlh4zBoOZnLr5U0/7wMPZjlM5XSaB
         MeY69w4r5BgeXx0Yno60Zvj6cjVyfEYHqy3rDc7FPERnnN9SpLXcgmCqsb+GiPldXnkf
         mp0dODM37AKRoAJzIJxPd09VvtxzYrbaA6l2A03ieo3geSjcG2IuXjjc7cc0kKjRJiQi
         77x4X8g1wHu4oLY0gA/V+xZ340BoWorB0eUcdbI0hwJ0V2dgFkxWyuhpWdwpc5DF7qxb
         HVq+xw3kFfRsxLDsxGBRgn7xWraM9JlgwmL7qvDXJbmubtfD4LXdNG3O7lCupLf6FlNd
         8BmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766416494; x=1767021294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dusq4givPs/+MmVLybQAr0PfVhdx73n3zpPLiMfCBqA=;
        b=DT3SJp957XXqpU7TEXg6gdM2guAxwMo+wqiOhZJwkJw9MIWX/w9ayzusvTKbs3Ihr2
         fPROHCktUGs8fCvvc0ADgbqFOvEDMd75dV5wbkMeeXx8c7Mydm3xiEeayGsnPlje6z3N
         Wn9RrBdw9gTAkghUOnmqy5em9Vz06DF3sy8G/mb43gkqtWuldaX1FzhJ0nX6wcVrmIb8
         Tt9LYc/6IFjJOcPzqgrtt7oNTqoBmgvDe+61CaUKP1sECvk+VzZXJ35KLUQNBH9RQcOB
         WKTo++54PbWzCUobUAObIeaXmaVYKKv/lR4MYDvYC+7nOPwQxPqdhWtlCDmbF3wEKs+e
         KRCg==
X-Gm-Message-State: AOJu0YxsANSzjHbnyefTfCK5yJKO/Mf43Pk2fQEAEQKJ8zUy8anPRfJD
	uz1lVRjkpJWk9gZqmji3M7O/JgdKI70TfJWigQ4+VYXapZgevFkb7mMSdNq0C0P3iNs=
X-Gm-Gg: AY/fxX53/yTmLdHPWca61Di6WkEMz3rhGIjtb6H/wW252NqrkJEs2N9d4KZBk7YARYs
	IhgencpWo1wia7cmJqPBxGeZkds2SU5/1gkG53Qa1ePLHWP5EpHOChvl2IYVZjca22GGFWeETEg
	1skchXnhRv4slJ/V6Fugy5BEPC0CbsZjLOXdv1mhzSk1vkOKPHma+hn1k0HWwRTNvuCtYDlopuw
	0bIPcqrSUeG2k44fdARWYd/qQBPm8twEJ0XnvYPGLMSAzFOM7j1jc2MKIjr3BESo+Ti4PieXjLy
	WgFE1KWQyDHfOWjEGRxmYN6ARE5uxW9O71TTupVXWruRzHwyhzjA2A5zBcb4I4k4ALnbuq05rUw
	7MgkuhsVJxFAAq9cEt7GM4W3tCE1mtUf4L2/ynWFxi92lHs96bQOmsLTzMv63sczE9Z+nMJd7Dr
	xMkOx8XG/UN1muw4AsMLGj
X-Google-Smtp-Source: AGHT+IH25mEFFoPaM1cwim0haHxibCkaTMRRATJLhfsMoJuUgN3vVuqjq2nokfYWDZpCL4mdVJFaag==
X-Received: by 2002:a05:6000:26d2:b0:430:fc5a:40ac with SMTP id ffacd0b85a97d-4324e70413emr14627279f8f.54.1766416494435;
        Mon, 22 Dec 2025 07:14:54 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830fesm22750093f8f.20.2025.12.22.07.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 07:14:54 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 22 Dec 2025 15:14:32 +0000
Subject: [PATCH v4 07/14] perf evsel: Add a helper to get the value of a
 config field
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-james-perf-config-bits-v4-7-0608438186fc@linaro.org>
References: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>
In-Reply-To: <20251222-james-perf-config-bits-v4-0-0608438186fc@linaro.org>
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

This will be used by aux PMUs to read an already written value for
configuring their events and for also testing.

Its helper perf_pmu__format_unpack() does the opposite of the existing
pmu_format_value() so rename that one to perf_pmu__format_pack() so it's
clear how they are related.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/evsel.c | 38 +++++++++++++++++++++++++++++++++++++-
 tools/perf/util/evsel.h |  2 ++
 tools/perf/util/pmu.c   | 35 ++++++++++++++++++++++++++++-------
 tools/perf/util/pmu.h   |  4 +++-
 4 files changed, 70 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b863096ed568..703a6f73d468 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1374,7 +1374,43 @@ void evsel__set_config_if_unset(struct evsel *evsel, const char *config_name,
 		return;
 
 	/* Otherwise replace it */
-	pmu_format_value(&bits, val, vp, /*zero=*/true);
+	perf_pmu__format_pack(&bits, val, vp, /*zero=*/true);
+}
+
+
+int evsel__get_config_val(const struct evsel *evsel, const char *config_name,
+			  u64 *val)
+{
+	struct perf_pmu_format *format = pmu_find_format(&evsel->pmu->format, config_name);
+	u64 bits = perf_pmu__format_bits(evsel->pmu, config_name);
+
+	if (!format || !bits) {
+		pr_err("Unknown/empty format name: %s\n", config_name);
+		*val = 0;
+		return -EINVAL;
+	}
+
+	switch (format->value) {
+	case PERF_PMU_FORMAT_VALUE_CONFIG:
+		*val = perf_pmu__format_unpack(bits, evsel->core.attr.config);
+		return 0;
+	case PERF_PMU_FORMAT_VALUE_CONFIG1:
+		*val = perf_pmu__format_unpack(bits, evsel->core.attr.config1);
+		return 0;
+	case PERF_PMU_FORMAT_VALUE_CONFIG2:
+		*val = perf_pmu__format_unpack(bits, evsel->core.attr.config2);
+		return 0;
+	case PERF_PMU_FORMAT_VALUE_CONFIG3:
+		*val = perf_pmu__format_unpack(bits, evsel->core.attr.config3);
+		return 0;
+	case PERF_PMU_FORMAT_VALUE_CONFIG4:
+		*val = perf_pmu__format_unpack(bits, evsel->core.attr.config4);
+		return 0;
+	default:
+		pr_err("Unknown format value: %d\n", format->value);
+		*val = 0;
+		return -EINVAL;
+	}
 }
 
 void __weak arch_evsel__set_sample_weight(struct evsel *evsel)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 2cf87bc67df7..95c4bd0f0f2e 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -575,6 +575,8 @@ void evsel__uniquify_counter(struct evsel *counter);
 	((((src) >> (pos)) & ((1ull << (size)) - 1)) << (63 - ((pos) + (size) - 1)))
 
 u64 evsel__bitfield_swap_branch_flags(u64 value);
+int evsel__get_config_val(const struct evsel *evsel, const char *config_name,
+			  u64 *val);
 void evsel__set_config_if_unset(struct evsel *evsel, const char *config_name,
 				u64 val);
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index dc5dab69151f..626c7307c8a3 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1337,6 +1337,26 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
 	}
 }
 
+/*
+ * Unpacks a raw config[n] value using the sparse bitfield that defines a
+ * format attr. For example "config1:1,6-7,44" defines a 4 bit value across non
+ * contiguous bits and this function returns those 4 bits as a value.
+ */
+u64 perf_pmu__format_unpack(u64 format, u64 config_val)
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
 struct perf_pmu_format *pmu_find_format(const struct list_head *formats,
 					const char *name)
 {
@@ -1379,7 +1399,8 @@ int perf_pmu__format_type(const struct perf_pmu *pmu, const char *name)
  * Sets value based on the format definition (format parameter)
  * and unformatted value (value parameter).
  */
-void pmu_format_value(unsigned long *format, __u64 value, __u64 *v, bool zero)
+void perf_pmu__format_pack(unsigned long *format, __u64 value, __u64 *v,
+			   bool zero)
 {
 	unsigned long fbit, vbit;
 
@@ -1496,23 +1517,23 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 		switch (term->type_term) {
 		case PARSE_EVENTS__TERM_TYPE_CONFIG:
 			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
-			pmu_format_value(bits, term->val.num, &attr->config, zero);
+			perf_pmu__format_pack(bits, term->val.num, &attr->config, zero);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_CONFIG1:
 			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
-			pmu_format_value(bits, term->val.num, &attr->config1, zero);
+			perf_pmu__format_pack(bits, term->val.num, &attr->config1, zero);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_CONFIG2:
 			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
-			pmu_format_value(bits, term->val.num, &attr->config2, zero);
+			perf_pmu__format_pack(bits, term->val.num, &attr->config2, zero);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_CONFIG3:
 			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
-			pmu_format_value(bits, term->val.num, &attr->config3, zero);
+			perf_pmu__format_pack(bits, term->val.num, &attr->config3, zero);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_CONFIG4:
 			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
-			pmu_format_value(bits, term->val.num, &attr->config4, zero);
+			perf_pmu__format_pack(bits, term->val.num, &attr->config4, zero);
 			break;
 		case PARSE_EVENTS__TERM_TYPE_LEGACY_HARDWARE_CONFIG:
 			assert(term->type_val == PARSE_EVENTS__TERM_TYPE_NUM);
@@ -1650,7 +1671,7 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 		 */
 	}
 
-	pmu_format_value(format->bits, val, vp, zero);
+	perf_pmu__format_pack(format->bits, val, vp, zero);
 	return 0;
 }
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 7655d996090a..a1255b3a8f91 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -279,12 +279,14 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 			  u64 *alternate_hw_config, struct parse_events_error *err);
 int perf_pmu__find_event(struct perf_pmu *pmu, const char *event, void *state, pmu_event_callback cb);
 
-void pmu_format_value(unsigned long *format, __u64 value, __u64 *v, bool zero);
+void perf_pmu__format_pack(unsigned long *format, __u64 value, __u64 *v,
+			   bool zero);
 struct perf_pmu_format *pmu_find_format(const struct list_head *formats,
 					const char *name);
 void perf_pmu_format__set_value(void *format, int config, unsigned long *bits);
 bool perf_pmu__has_format(const struct perf_pmu *pmu, const char *name);
 int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_callback cb);
+u64 perf_pmu__format_unpack(u64 format, u64 config_val);
 
 bool is_pmu_core(const char *name);
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu);

-- 
2.34.1

