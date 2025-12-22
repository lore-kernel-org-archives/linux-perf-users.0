Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C8C322B70
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416494; cv=none; b=j+LW0jTVV2UNevevMkZbr/yVOPxiauDBZYHf1QnNgxHF+M4VRj8oy11dvOQzMjotDeMB9bQfjJBn05+Z7jVZ0HPyjm33jOPQeN6/Z5IsQFCKWzpQ8A2dpt9gGPq3g50wX2xsnlT5UjlZS1heWA/WwuqLhFV0JI8sfnEiuSHoXtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416494; c=relaxed/simple;
	bh=Jc9rERJ1aa9uPXcRf+vQny2CNy2GLYq2wwN414Q1Kbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GoxB3O/LFt5CMsINusF5lyK6Pq5uQ79e2VwUFeJvDDv3b6dalox47VuU6QXmH314zBGMBMsKbrzepGZJq6xDLntxXano0DCGLN2JDFZSy0+AG64XQ7Q7t5K4z1hpB0pZ9gvekEkkgovUWkFY1Xq9OKs+DsQLWsIaPraOqSnGfOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fcUs5sZU; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fcUs5sZU"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa4so3308783f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 07:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766416490; x=1767021290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LcmTvJXahQwVxWMEArSL10u6PwPhpeVpWDjIQEb7L7Y=;
        b=fcUs5sZUPq2wgHGzHdaeRSq4yF1KE7V6tJgu3lUMSd9ieZ9OYbb8nJyRQcoEDo1RtN
         eV0ecvYuizeEm8L/Ygl/k9r1BKF+4UGgRTQKiqiX2E1clvkL3MN0yKoJxSMKdkPQogCW
         C46qCdoRqWGtRupm1mQDErTB2ffaZpzVbN41uwfoZlvTzxtHBBcoKvcS5F2FHZVxeDz3
         VpEBjGRlqrhWu3ENbnrNTMv7pucCSi+Gq41GjeZ4y/11IKHtFFOQkv4nb7l2HfBeBdoV
         YVpo76+qN5/n9YtECjwwGu1WtEBCSnmCAgJLW6QmE+WTNsUFHUYgjzigpOtKQag5ARJW
         kwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766416490; x=1767021290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LcmTvJXahQwVxWMEArSL10u6PwPhpeVpWDjIQEb7L7Y=;
        b=lnhDTIwWsk2i4upmYhI8AfCi+sUgdT8S55VfvV7yv4v1K/ZUgT/DqH+Ndbj1vY3EER
         q0Ok46+xpW38ZcdMvCI7YPD2aXZCVYjXu+3wCEvs+M4/dVLgjuE4LytbPzsH0FQ1/qow
         7/cB55BAgd6sJ8byUUbZ3i+8tROFabx+USM5EGWuis+EK3HSnC7oeNBaxOgHj03AwvFG
         NXWHjqw81inHasAU03oLT3l9l3N74R3CvlqvTdfN5/ksDoOfv4Ztq+y4EA0QqKkIgR/w
         2/mXJPRTTY2Zj57vXCe+lJfROER0yf2mFMTFVkQs46HKH8tZ6U6ojusY/AYlP4eHiiSd
         qYew==
X-Gm-Message-State: AOJu0YwdysBd73LPELe9lNy07hXtVBFcIyh0XZCoRHwih1oNJIYLpSZG
	3iNZzoFK/vE7gYY7KjIf9yesXNoyFjLU+ybhJPgY5IkTkHlXPFVan0b9o153SuWExvQ=
X-Gm-Gg: AY/fxX717ruPZHBMCEYiDs/aTJN+U/K21f9br8XvfUlFG2AbceYTH/jKSfqbxzyMXfq
	oxKEQ6Ut8nZs5zx9dQTnCZUtYfFnrjlCn3oPAd1hMKx3wM2Cg6a1E7eUBsVxRR2jMpm/Dczk4rJ
	b9gksbWnuFlZbXGP+1oxgH188Xllcu2f7MWpskzpW4HX3Qzo2/IDromv3vmhmHB+W/nNnh1g5A8
	VRdjsc+X3HyhfOob6S4SNMpC4PxRBUZdGBNwwGvxjE06yyHJeFK9C9PtujdKmZFYvZK/pqGq091
	R8iRiexagf88Oow7herWVWxVVtl48MMdbIhKZ50mRDVy9tXp+TkKBCGKbw4cLZB7UXcwqe82xlU
	YBBlcWP6eMqqdShf9IDx4Lbvk7EqFfvEymvIEv/O/lxzwd/G8Qp3kEigUl0f9TPg+lU/sB5yCMV
	cGaic2Xo5soTYmXnMPwqXr8k/v9ouaA4A=
X-Google-Smtp-Source: AGHT+IH4/L5Fd2bdzY3Fz+9C/VnJ0iwvm8BOZw7bzpSdKuWzvPUtGRSH0pZWBQVoeSUMScAftQbCdA==
X-Received: by 2002:a05:6000:609:b0:430:f7bc:4cf1 with SMTP id ffacd0b85a97d-4324e4d50f7mr14023332f8f.26.1766416490049;
        Mon, 22 Dec 2025 07:14:50 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830fesm22750093f8f.20.2025.12.22.07.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 07:14:49 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 22 Dec 2025 15:14:28 +0000
Subject: [PATCH v4 03/14] perf evsel: Move evsel__* functions to evsel.c
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-james-perf-config-bits-v4-3-0608438186fc@linaro.org>
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

At least one of these were put here to avoid a Python binding linking
issue which is no longer present. Put them back in their correct
location to avoid confusion about which file to add a new evsel__*
function to later.

Link: https://lore.kernel.org/all/ZEbAS2yx2fguW60w@kernel.org/
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/evsel.c | 40 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.c   | 40 ----------------------------------------
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ec6552a6f667..21878e9bd029 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1314,6 +1314,35 @@ struct evsel_config_term *__evsel__get_config_term(struct evsel *evsel, enum evs
 	return found_term;
 }
 
+/*
+ * Set @config_name to @val as long as the user hasn't already set or cleared it
+ * by passing a config term on the command line.
+ *
+ * @val is the value to put into the bits specified by @config_name rather than
+ * the bit pattern. It is shifted into position by this function, so to set
+ * something to true, pass 1 for val rather than a pre shifted value.
+ */
+#define field_prep(_mask, _val) (((_val) << (ffsll(_mask) - 1)) & (_mask))
+void evsel__set_config_if_unset(struct evsel *evsel, const char *config_name,
+				u64 val)
+{
+	u64 user_bits = 0, bits;
+	struct evsel_config_term *term = evsel__get_config_term(evsel, CFG_CHG);
+
+	if (term)
+		user_bits = term->val.cfg_chg;
+
+	bits = perf_pmu__format_bits(evsel->pmu, config_name);
+
+	/* Do nothing if the user changed the value */
+	if (bits & user_bits)
+		return;
+
+	/* Otherwise replace it */
+	evsel->core.attr.config &= ~bits;
+	evsel->core.attr.config |= field_prep(bits, val);
+}
+
 void __weak arch_evsel__set_sample_weight(struct evsel *evsel)
 {
 	evsel__set_sample_bit(evsel, WEIGHT);
@@ -4098,6 +4127,17 @@ void evsel__set_leader(struct evsel *evsel, struct evsel *leader)
 	evsel->core.leader = &leader->core;
 }
 
+bool evsel__is_aux_event(const struct evsel *evsel)
+{
+	struct perf_pmu *pmu;
+
+	if (evsel->needs_auxtrace_mmap)
+		return true;
+
+	pmu = evsel__find_pmu(evsel);
+	return pmu && pmu->auxtrace;
+}
+
 int evsel__source_count(const struct evsel *evsel)
 {
 	struct evsel *pos;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index e87c12946d71..e3a1f26213ec 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1362,46 +1362,6 @@ void perf_pmu__warn_invalid_formats(struct perf_pmu *pmu)
 	}
 }
 
-bool evsel__is_aux_event(const struct evsel *evsel)
-{
-	struct perf_pmu *pmu;
-
-	if (evsel->needs_auxtrace_mmap)
-		return true;
-
-	pmu = evsel__find_pmu(evsel);
-	return pmu && pmu->auxtrace;
-}
-
-/*
- * Set @config_name to @val as long as the user hasn't already set or cleared it
- * by passing a config term on the command line.
- *
- * @val is the value to put into the bits specified by @config_name rather than
- * the bit pattern. It is shifted into position by this function, so to set
- * something to true, pass 1 for val rather than a pre shifted value.
- */
-#define field_prep(_mask, _val) (((_val) << (ffsll(_mask) - 1)) & (_mask))
-void evsel__set_config_if_unset(struct evsel *evsel, const char *config_name,
-				u64 val)
-{
-	u64 user_bits = 0, bits;
-	struct evsel_config_term *term = evsel__get_config_term(evsel, CFG_CHG);
-
-	if (term)
-		user_bits = term->val.cfg_chg;
-
-	bits = perf_pmu__format_bits(evsel->pmu, config_name);
-
-	/* Do nothing if the user changed the value */
-	if (bits & user_bits)
-		return;
-
-	/* Otherwise replace it */
-	evsel->core.attr.config &= ~bits;
-	evsel->core.attr.config |= field_prep(bits, val);
-}
-
 static struct perf_pmu_format *
 pmu_find_format(const struct list_head *formats, const char *name)
 {

-- 
2.34.1

