Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D8D3A1A29
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406273; cv=none; b=uvTU+OdsePInw7KryuI8meqkU/RswaIi111QeK/ov1iUpi7AssyOVRhPeUqoXqGP5zeL0HUeyeWjZAcUwjkIgxOSW4cLXtM0cuGDlXzcTlQUL401WxOT2FD3b9XKYGOAEkFYZwJC+yOqqpy3dI5tKUvzs1TEVWstOVXNRX3aT2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406273; c=relaxed/simple;
	bh=bFg7g/rn24qLdzh570J873Kf0e3eYeBHP3QCYLVZR+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qmG4YPT3mGJRuRHXUCAitUeiQAj7bfqVyQrmGBXql/+2wCIaJ6MBBLtnvy6YxcDf8PC9b8Khvsw8nOs44yyUVpgKtmPZhnd2/YvcI0n28Krxporpz74ENeCaAhGci/oXFitXl8y1NMz6vcvqyHhWG9i6j5zTjbQJLlf+gstpVfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x6H5CLCx; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x6H5CLCx"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47a95efd2ceso74762005e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 07:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768406266; x=1769011066; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmYihNLb0KLD+tzX8PoHToNOa0/csgr96GD3/RY6Ics=;
        b=x6H5CLCxt8gx3FQoYWwBm8/ImKpbtsXbRPiNsQwzfP281br+bWun++8VIMsa825uZi
         LDwSX/6RBn23K8dh3bcfEM+kWgpsHJf403krS9FZHetc9Mc4A+HOT9GSaF2GQ2mjdGOb
         /jK63BDqLHutKlYgEFrrFK2oJq0NXl3TPM2t6LGmo6XHjIRWgoXh+1Vp48MVlhx2R9Vd
         Vrcy4jHodkzEYHYzf62UxYrCYU4yfM1oe3onguEe+vBcUIM7/KxYOgHzyNHMx5aeqS21
         1MHzb6MkGmbnSEpSzFQjVk016YtcaE3WZuifOTD2slpid+vQV2wBJt/14r12aH2to2zd
         XGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406266; x=1769011066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OmYihNLb0KLD+tzX8PoHToNOa0/csgr96GD3/RY6Ics=;
        b=FDxvQEGRjhc1mRdMZW7SxHYbaYvryVFtwtb/GeYHZFegjZ3WZhrVbIhl+SBLL4UXvj
         8XqLClDAzJ/jK+Sm6Zfm/209issDKtuIHlvtHsF7Kkt5urQgAnINN/5CEGivLQXoS3LP
         K5HTsnEWhf5oGOPRpCGNXP95H20q2lhDi+rexkQBnepxowyh5JCIJCgTAZUYKjRsmqGo
         SJ+xuAmIuwYOvbsBWQWdUAvcmIxsePUTQAknoOqhpV48wa6OmCB5VJrLH/9NsF30gbF2
         imKz/qjVJuKikmj6fZXYOL+n2rU08k2BBuNClT6T7uEMqbGRVHT5W6Dsdc3H5bh+KB3v
         zfTQ==
X-Gm-Message-State: AOJu0Yz1tc2BY6l4nm5ODoOwihvwAK3/JvqJndDmbJru2f++s8Kvl6Vt
	vS2ex1mYQGh2YNDPZouFBjjchNUkhEiA9DnNE2PitR0KqOzR7aehNcXV79Q8TRlB/+k=
X-Gm-Gg: AY/fxX54h9SImByKF7rNm9KFrmtAL5LUtnENXvkPquNNAs9FVTnRcWJLC91U5UVnX3k
	7sJx3FZJZyadx+Re/kH8XzHrrg1ShB5bZE/cmZjmAZ29/Dk4EejRL9EsEIG3AmfYhtSFB3yZ1oQ
	E/3BeIU2JLR4btkHS6UgQAyiYqrJBLrOijVclzifXqiAGvm8KCxUWCPtQdOD/EfOzL37kgcquy2
	e5CayCBB1Me0mKycT3wdCaKUzrzB8xlWwBwjAPI1U5Nn9UkXLuZ0QgvaUfblzL3OuMZ9KyM3HV+
	XtHdENYu59wN7PG0n2SPXZRdD6ZUWhdCy7V7I90ekvk6AQz8e+HbKL+q/c3OMqNjbsXhKJv7g1r
	LUOvucZ589Xb8SZNkEzj/geghLian5dw7dzuQ97B+YyXd4gHg6Q3Iu+/iuS6ab2pRf91r5UU5NZ
	KfKpk3gsyXsUdYQxkuT1/X
X-Received: by 2002:a05:600c:4f0b:b0:477:c71:1fc1 with SMTP id 5b1f17b1804b1-47ee4819f30mr30484755e9.19.1768406266018;
        Wed, 14 Jan 2026 07:57:46 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee85e8807sm7426475e9.16.2026.01.14.07.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:57:45 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 14 Jan 2026 15:57:19 +0000
Subject: [PATCH v5 07/14] perf evsel: Add a helper to get the value of a
 config field
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-james-perf-config-bits-v5-7-0ef97aaf1ac0@linaro.org>
References: <20260114-james-perf-config-bits-v5-0-0ef97aaf1ac0@linaro.org>
In-Reply-To: <20260114-james-perf-config-bits-v5-0-0ef97aaf1ac0@linaro.org>
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
 tools/perf/util/evsel.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/evsel.h |  2 ++
 tools/perf/util/pmu.c   | 35 ++++++++++++++++++++++++++++-------
 tools/perf/util/pmu.h   |  4 +++-
 4 files changed, 74 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3162bfc0ccfe..ec74dce3211c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1378,7 +1378,47 @@ void evsel__set_config_if_unset(struct evsel *evsel, const char *config_name,
 			return;
 
 	/* Otherwise replace it */
-	pmu_format_value(format->bits, val, vp, /*zero=*/true);
+	perf_pmu__format_pack(format->bits, val, vp, /*zero=*/true);
+}
+
+
+int evsel__get_config_val(const struct evsel *evsel, const char *config_name,
+			  u64 *val)
+{
+	struct perf_pmu_format *format = pmu_find_format(&evsel->pmu->format, config_name);
+
+	if (!format || bitmap_empty(format->bits, PERF_PMU_FORMAT_BITS)) {
+		pr_err("Unknown/empty format name: %s\n", config_name);
+		*val = 0;
+		return -EINVAL;
+	}
+
+	switch (format->value) {
+	case PERF_PMU_FORMAT_VALUE_CONFIG:
+		*val = perf_pmu__format_unpack(format->bits,
+					       evsel->core.attr.config);
+		return 0;
+	case PERF_PMU_FORMAT_VALUE_CONFIG1:
+		*val = perf_pmu__format_unpack(format->bits,
+					       evsel->core.attr.config1);
+		return 0;
+	case PERF_PMU_FORMAT_VALUE_CONFIG2:
+		*val = perf_pmu__format_unpack(format->bits,
+					       evsel->core.attr.config2);
+		return 0;
+	case PERF_PMU_FORMAT_VALUE_CONFIG3:
+		*val = perf_pmu__format_unpack(format->bits,
+					       evsel->core.attr.config3);
+		return 0;
+	case PERF_PMU_FORMAT_VALUE_CONFIG4:
+		*val = perf_pmu__format_unpack(format->bits,
+					       evsel->core.attr.config4);
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
index dc5dab69151f..bb399a47d2b4 100644
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
+u64 perf_pmu__format_unpack(unsigned long *format, u64 config_val)
+{
+	int val_bit = 0;
+	u64 res = 0;
+	int fmt_bit;
+
+	for_each_set_bit(fmt_bit, format, PERF_PMU_FORMAT_BITS) {
+		if (config_val & (1ULL << fmt_bit))
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
index 7655d996090a..7ef90b54a149 100644
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
+u64 perf_pmu__format_unpack(unsigned long *format, u64 config_val);
 
 bool is_pmu_core(const char *name);
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu);

-- 
2.34.1

