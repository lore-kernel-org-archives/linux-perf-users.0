Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BC51509AB
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406268; cv=none; b=ExCOIz7xvLwQPdloEsMN8HsSWaGnbTsUs81JOwto8eX0DtyIKGD+Cun4OgffJ2zBIVEkN5OpiWbWoJbQYcij+KUYaNPxmKB6XgGqoo1h52baOLYfmn4uPHG9DlWkKKLZVxFUd8rDkpmPqPCk2cau9EqGn+ZTgB+jjgKR7L7D8m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406268; c=relaxed/simple;
	bh=1se6aKNgXrfE/bwxBoGKPuKfr93BcVFQoNAXV7qREtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E3ct8bYGAdQIrfIwOYFfIzqwDaSlYUzSsrIJ3RgB+QErupiRjw2wVgBIRmHo94PEVO/VCxem3AdRcZkHhTtTxLa4T9fJWRUKJLQblOIgOM9bO4yjFPHO+2n9JPCBXVs6wTLeaSKVFfFZKmk7IvDgAyP1eUyyUOd/h06lca+m1KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pYsKvHM3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYsKvHM3"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee301a06aso22895e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 07:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768406262; x=1769011062; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZbXl4NsAkDqXtfh1/waIfkR63u1IJoE9aVRzYhhT54g=;
        b=pYsKvHM3vStaJkFaFAJ0jZl08+LeDMa4IVb3X0Rf8f8LoxKm6dyEz3xXFN02ktAcus
         X5/ICfIlNeJuP8rjcuuNkDyPn5ZK/mNyC6DO0VQtlT6Y0Li+uEy9r6tL8cAkwErPNLZs
         f/l11IDVi7pCCFaZF/irOmKOc+XjQjpX7kAK+e/0cV/rILDQRIOdj4di7Q2sPG0DJdrT
         P7kZh6srJp2EkI5GS8vkYAj0dmje+xSCU0oM0ZOO+YSuf6AhMVYxu7qumUjRaeKhFwvi
         dgJ8ie91LA4uiTo3k9eyP6E4JIXs+4Nc8D5QbqhT+/8v6xQTu/E1hi+rtq05XrJwsTXm
         qIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406262; x=1769011062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZbXl4NsAkDqXtfh1/waIfkR63u1IJoE9aVRzYhhT54g=;
        b=GHPELhwSOVnkvi0JLao6Mpjz14Dih7bRFCZQKH7uEPRAK5NAVtbtO+QWblY5L/pEtQ
         XsXFQKJeebObrAnnIXOIKC85bM1+YYzw2ePEESIdZPWUKFiV0o0m9aSvFLvGzI0sGLux
         3hgkOmRYwKDDGjj7OKvpfkCRMWVdVRh2kwU9n2yxie0uakv4mBFOu00SPU5nIqompP8U
         aUtBRcUiQwBk3X0ohyF/9doWoCfo2qZ3Gf6852qKnQIoMwIx7cXsg3uY9Z75I8EXd4/y
         MMocnEd4GMc3evpfnkSvF/wXUfOPAc9ryoRowYw+XX/39qlruesKj62yktTMNSfglXyV
         dBAg==
X-Gm-Message-State: AOJu0YwJHQ4iIolzj53MSF+0g7AJClSEyzUWpfoTaNtdVGyOQu8iPKi+
	nUl4Zfl192Qg7AbyTGBJEVcXlvM+FuJFhk88PBWUJ42rV6tz2xB429XZDV8lNsaHnLM=
X-Gm-Gg: AY/fxX6Q7ww3cRfVBR8ThMdyiURefqB6oyubldOURY4G1rE1/pDWnGCW+GJ2h1pmp7Z
	ttUDNTN7IjGy0pJ7shZ4pggCsS3OXLraIwPSGgAhPULKmQwNXVmj2PEEXYGZaz1lDJva8k6qHFV
	k87zmmJ6DIPCYaMuwxwl0L/E0orxqP9qdz4IjxJPitYmkSHRW9LWv1UQW/VKdVASnlygFUyOCE8
	9TROO/k930jS1C4tylMMZyawsN8mozGs+XlylQ0GY1Ihwc7OyQ2xxJUx98KreBMs3jDMbD7qHSg
	Z9liU2G+ODX4I71vFY9LBnApVtkoYIxMjK72JmWlwNvdVYem5/1ifgMmaQ0zs4UsUJjxqlV+Zbv
	wFvNzn7F+YgLEf34vyGiq7Uf7qMK7hHnr3KqQTl3JGc77bFAJN8ioFbUZq7Zx3bD4prGMCzxPC7
	q/KnCewzDFD6P/+wk4vNyF
X-Received: by 2002:a05:600c:8b75:b0:477:af07:dd21 with SMTP id 5b1f17b1804b1-47ee338a5efmr42560995e9.25.1768406261716;
        Wed, 14 Jan 2026 07:57:41 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee85e8807sm7426475e9.16.2026.01.14.07.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:57:41 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 14 Jan 2026 15:57:16 +0000
Subject: [PATCH v5 04/14] perf evsel: Support sparse fields in
 evsel__set_config_if_unset()
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-james-perf-config-bits-v5-4-0ef97aaf1ac0@linaro.org>
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

Sparse config fields are technically supported although currently
unused. field_prep() only works for contiguous bitfields so replace it
with pmu_format_value().

pmu_format_value() also takes a bitmap rather than a u64 so replace
'u64 bits' with format->bits.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/evsel.c | 19 +++++++++++--------
 tools/perf/util/pmu.c   | 32 +++-----------------------------
 tools/perf/util/pmu.h   | 28 ++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 37 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 21878e9bd029..9ef94632106b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1322,25 +1322,28 @@ struct evsel_config_term *__evsel__get_config_term(struct evsel *evsel, enum evs
  * the bit pattern. It is shifted into position by this function, so to set
  * something to true, pass 1 for val rather than a pre shifted value.
  */
-#define field_prep(_mask, _val) (((_val) << (ffsll(_mask) - 1)) & (_mask))
 void evsel__set_config_if_unset(struct evsel *evsel, const char *config_name,
 				u64 val)
 {
-	u64 user_bits = 0, bits;
+	u64 user_bits = 0;
 	struct evsel_config_term *term = evsel__get_config_term(evsel, CFG_CHG);
+	struct perf_pmu_format *format = pmu_find_format(&evsel->pmu->format,
+							 config_name);
+	int fbit;
+
+	if (!format)
+		return;
 
 	if (term)
 		user_bits = term->val.cfg_chg;
 
-	bits = perf_pmu__format_bits(evsel->pmu, config_name);
-
 	/* Do nothing if the user changed the value */
-	if (bits & user_bits)
-		return;
+	for_each_set_bit(fbit, format->bits, PERF_PMU_FORMAT_BITS)
+		if ((1ULL << fbit) & user_bits)
+			return;
 
 	/* Otherwise replace it */
-	evsel->core.attr.config &= ~bits;
-	evsel->core.attr.config |= field_prep(bits, val);
+	pmu_format_value(format->bits, val, &evsel->core.attr.config, /*zero=*/true);
 }
 
 void __weak arch_evsel__set_sample_weight(struct evsel *evsel)
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e3a1f26213ec..7967d9159742 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -118,31 +118,6 @@ struct perf_pmu_alias {
 	bool info_loaded;
 };
 
-/**
- * struct perf_pmu_format - Values from a format file read from
- * <sysfs>/devices/cpu/format/ held in struct perf_pmu.
- *
- * For example, the contents of <sysfs>/devices/cpu/format/event may be
- * "config:0-7" and will be represented here as name="event",
- * value=PERF_PMU_FORMAT_VALUE_CONFIG and bits 0 to 7 will be set.
- */
-struct perf_pmu_format {
-	/** @list: Element on list within struct perf_pmu. */
-	struct list_head list;
-	/** @bits: Which config bits are set by this format value. */
-	DECLARE_BITMAP(bits, PERF_PMU_FORMAT_BITS);
-	/** @name: The modifier/file name. */
-	char *name;
-	/**
-	 * @value : Which config value the format relates to. Supported values
-	 * are from PERF_PMU_FORMAT_VALUE_CONFIG to
-	 * PERF_PMU_FORMAT_VALUE_CONFIG_END.
-	 */
-	u16 value;
-	/** @loaded: Has the contents been loaded/parsed. */
-	bool loaded;
-};
-
 static int pmu_aliases_parse(struct perf_pmu *pmu);
 
 static struct perf_pmu_format *perf_pmu__new_format(struct list_head *list, char *name)
@@ -1362,8 +1337,8 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
 	}
 }
 
-static struct perf_pmu_format *
-pmu_find_format(const struct list_head *formats, const char *name)
+struct perf_pmu_format *pmu_find_format(const struct list_head *formats,
+					const char *name)
 {
 	struct perf_pmu_format *format;
 
@@ -1404,8 +1379,7 @@ int perf_pmu__format_type(struct perf_pmu *pmu, const char *name)
  * Sets value based on the format definition (format parameter)
  * and unformatted value (value parameter).
  */
-static void pmu_format_value(unsigned long *format, __u64 value, __u64 *v,
-			     bool zero)
+void pmu_format_value(unsigned long *format, __u64 value, __u64 *v, bool zero)
 {
 	unsigned long fbit, vbit;
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 8f11bfe8ed6d..3a53e1882cf1 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -233,6 +233,31 @@ struct pmu_event_info {
 	bool deprecated;
 };
 
+/**
+ * struct perf_pmu_format - Values from a format file read from
+ * <sysfs>/devices/cpu/format/ held in struct perf_pmu.
+ *
+ * For example, the contents of <sysfs>/devices/cpu/format/event may be
+ * "config:0-7" and will be represented here as name="event",
+ * value=PERF_PMU_FORMAT_VALUE_CONFIG and bits 0 to 7 will be set.
+ */
+struct perf_pmu_format {
+	/** @list: Element on list within struct perf_pmu. */
+	struct list_head list;
+	/** @bits: Which config bits are set by this format value. */
+	DECLARE_BITMAP(bits, PERF_PMU_FORMAT_BITS);
+	/** @name: The modifier/file name. */
+	char *name;
+	/**
+	 * @value : Which config value the format relates to. Supported values
+	 * are from PERF_PMU_FORMAT_VALUE_CONFIG to
+	 * PERF_PMU_FORMAT_VALUE_CONFIG_END.
+	 */
+	u16 value;
+	/** @loaded: Has the contents been loaded/parsed. */
+	bool loaded;
+};
+
 typedef int (*pmu_event_callback)(void *state, struct pmu_event_info *info);
 typedef int (*pmu_format_callback)(void *state, const char *name, int config,
 				   const unsigned long *bits);
@@ -254,6 +279,9 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 			  u64 *alternate_hw_config, struct parse_events_error *err);
 int perf_pmu__find_event(struct perf_pmu *pmu, const char *event, void *state, pmu_event_callback cb);
 
+void pmu_format_value(unsigned long *format, __u64 value, __u64 *v, bool zero);
+struct perf_pmu_format *pmu_find_format(const struct list_head *formats,
+					const char *name);
 void perf_pmu_format__set_value(void *format, int config, unsigned long *bits);
 bool perf_pmu__has_format(const struct perf_pmu *pmu, const char *name);
 int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_callback cb);

-- 
2.34.1

