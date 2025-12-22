Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03902324B16
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416497; cv=none; b=meRl7bWoJTb6GYZ+LkFz/p1xuQnNgLxHeQayOfAnRYAn7XzDh+xdEgKAtAo85qQN3Cn4jOdbfarl+1/5Ny8HuOo6BOf0wzRlH1jrJ2TtEZtVsUZ8VI4felujYYcYmkQbAFIelYRLiEIWgGkpsMg0e2hnP5h0r17i5V722cpEp0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416497; c=relaxed/simple;
	bh=dtSxRObzl9Igu3Uf4jC/9ZgVZUFaci2xTk7imj99J5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dCunizxXfClhpiGxx7gE4/p69UFchfR+9vAF+ravrAWeZIiQwW8nhQYwTwQ/xCAyJ2+wo3clqm7P7ak8UGCu4TUHVn4wFddO8qE98YtdxMENS5XaCI0oz5jxjxlxPW3e42AZloid3dQqQBI4z4awOnc5uACI6aflkIWp8Mdi6fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MGaMR9uT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MGaMR9uT"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47a8195e515so28731225e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 07:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766416493; x=1767021293; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tc92yWKQZM+B64gHggXneBOLYCdgUjGdgIDlKi2hgGI=;
        b=MGaMR9uTwog9ZE2BgTOpDHeCG/mmVs9L5inxIpvHLrOa9HDFUfnbaeTWyd/EpIBkIv
         EboPBF/+HPu8/wo/wl4Oqu+wmLjRxs6bOoOzPxk0TueMB38Le6QXJObLJqr5OSAoZ4XL
         Ahq96e46NIOvoGYKaVDpwxXV4dHxVd1CblxYjFwAHhRBQOBUNZHN3Tlc4tILBvPczwXi
         XPuR5eJbz/ufwmlpLrP2EQiH56rNScrHEmQwl9dS5ZEbVP2FhV+0/LxaCIzStDM4nct5
         sCzcWbE8ZyBiRj1W1K1Xfeot7I8JNtKFIxXb4sUA+LCDIgLeCzX93fmr/qS+24uzsYPx
         kk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766416493; x=1767021293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tc92yWKQZM+B64gHggXneBOLYCdgUjGdgIDlKi2hgGI=;
        b=pLpC2a04v5epzoxV7c5tsD+fFwt2T4IcHxv4roU21ZAJy7m2iHwownWEbsqNLgSj/T
         +OSz5X7m0FjadGjnt4MegjgFkVvIKxwQT9LlN5CExCr3EsKMW+tkR7bOZdX5ITtpCj7T
         ZfCLJQR2oGnEXgMUQpQMwYKWKzRVTywWv4K/OnLqTdpfxmQxkwZuG8KnYodeLR+QZEy2
         v1aFmxglhU65HPaoVp6aEukQTEqtJU6vu5KDoYD7dWd+BNgFpyyd0roYLjmUg1HcFfEP
         ToJtkXjKzd4TYgvQ6ByeESS/hEtNetsctis7ScIdI4HrpqLmiwJU1Xa7n7O1sv3oe05h
         M52w==
X-Gm-Message-State: AOJu0YyYCGfkDjQnRfqLxKHfltL8Qpk0wk0DfzpP1/S3njUWB6YkqYPr
	2RPooC20shoyR/cVuoGrDui6zbgt8fu4aRWfVxy4ja1AA00u5MDYYwHZiitX1MvT+v4=
X-Gm-Gg: AY/fxX5ztnyykSWRKfwdfscYK16/UUWJ+IY/Qsf/LdbgaQJATOv5eKrKeWomsdcPP9U
	x5aIwVhbgq2GKttDFWU4378hrblSnpLJLtJAHi/k6cXeZAkitBuXbmBgR7kfNF++VNB43L63LQA
	bIRGSNuH8IpWR+wVZZMyvhi6dzNO2jSFjpftQ9DbE8KqHcB6s2OeKiF3xipZRNdQGmVuGgnjMhQ
	RUxK6fh07HVoH+7bs6WM5vln+L6Eu8BI4aNhaR4w9gPSP5bGCo31XsCp1CohkKNCfue2ipimP06
	TZNQixu9KKEMLt54y3dUGtwYQrmcv8s3x+AwhU9os6wvhFmyGFQXzqLbk0MMtfpweGyykhGerog
	uZW+16Wuj6ewtLP7OHKyz3wiBwM4wcnxcTBthjaKT1Rqp+Ydxo/24/jBFCKG0Mh1QQXdvlViwHY
	DNk+bhbIa+jC/ZpCuq4HIsmCLMICTA2uo=
X-Google-Smtp-Source: AGHT+IH+XDMQ3rlxuM0Gvuwq8tNBEur+OrwI+FlxYWbuxE83bWivfEIsy6eHbB5jrKNX77vHoZIFOQ==
X-Received: by 2002:a05:600c:348a:b0:46e:1a5e:211 with SMTP id 5b1f17b1804b1-47d1958a755mr124164345e9.21.1766416493331;
        Mon, 22 Dec 2025 07:14:53 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830fesm22750093f8f.20.2025.12.22.07.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 07:14:52 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 22 Dec 2025 15:14:31 +0000
Subject: [PATCH v4 06/14] perf evsel: apply evsel__set_config_if_unset() to
 all config fields
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-james-perf-config-bits-v4-6-0608438186fc@linaro.org>
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

Misleadingly, evsel__set_config_if_unset() only works with the config
field and not config1, config2, etc. This is fine at the moment because
all users of it happen to operate on bits that are in that config field.
Fix it before there are any new users of the function which operate on
bits in different config fields.

In theory it's also possible for a driver to move an existing bit to
another config field and this fixes that scenario too, although this
hasn't happened yet either.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/evsel.c | 37 ++++++++++++++++++++++++++++++++++---
 tools/perf/util/pmu.c   | 29 ++---------------------------
 tools/perf/util/pmu.h   | 27 +++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 30 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 354e28e94523..b863096ed568 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1330,8 +1330,39 @@ void evsel__set_config_if_unset(struct evsel *evsel, const char *config_name,
 				u64 val)
 {
 	u64 user_bits = 0, bits;
-	struct evsel_config_term *term = evsel__get_config_term(evsel,
-								USR_CHG_CONFIG);
+	struct evsel_config_term *term;
+	struct perf_pmu_format *format = pmu_find_format(&evsel->pmu->format,
+							 config_name);
+	__u64 *vp;
+
+	if (!format)
+		return;
+
+	switch (format->value) {
+	case PERF_PMU_FORMAT_VALUE_CONFIG:
+		term = evsel__get_config_term(evsel, USR_CHG_CONFIG);
+		vp = &evsel->core.attr.config;
+		break;
+	case PERF_PMU_FORMAT_VALUE_CONFIG1:
+		term = evsel__get_config_term(evsel, USR_CHG_CONFIG1);
+		vp = &evsel->core.attr.config1;
+		break;
+	case PERF_PMU_FORMAT_VALUE_CONFIG2:
+		term = evsel__get_config_term(evsel, USR_CHG_CONFIG2);
+		vp = &evsel->core.attr.config2;
+		break;
+	case PERF_PMU_FORMAT_VALUE_CONFIG3:
+		term = evsel__get_config_term(evsel, USR_CHG_CONFIG3);
+		vp = &evsel->core.attr.config3;
+		break;
+	case PERF_PMU_FORMAT_VALUE_CONFIG4:
+		term = evsel__get_config_term(evsel, USR_CHG_CONFIG4);
+		vp = &evsel->core.attr.config4;
+		break;
+	default:
+		pr_err("Unknown format value: %d\n", format->value);
+		return;
+	}
 
 	if (term)
 		user_bits = term->val.cfg_chg;
@@ -1343,7 +1374,7 @@ void evsel__set_config_if_unset(struct evsel *evsel, const char *config_name,
 		return;
 
 	/* Otherwise replace it */
-	pmu_format_value(&bits, val, &evsel->core.attr.config, /*zero=*/true);
+	pmu_format_value(&bits, val, vp, /*zero=*/true);
 }
 
 void __weak arch_evsel__set_sample_weight(struct evsel *evsel)
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 2fe92b4b6e02..dc5dab69151f 100644
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
 
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 7bf5b23d0ea1..7655d996090a 100644
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
@@ -255,6 +280,8 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 int perf_pmu__find_event(struct perf_pmu *pmu, const char *event, void *state, pmu_event_callback cb);
 
 void pmu_format_value(unsigned long *format, __u64 value, __u64 *v, bool zero);
+struct perf_pmu_format *pmu_find_format(const struct list_head *formats,
+					const char *name);
 void perf_pmu_format__set_value(void *format, int config, unsigned long *bits);
 bool perf_pmu__has_format(const struct perf_pmu *pmu, const char *name);
 int perf_pmu__for_each_format(struct perf_pmu *pmu, void *state, pmu_format_callback cb);

-- 
2.34.1

