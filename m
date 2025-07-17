Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033D324110F
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752786177; cv=none; b=Dr5U1VZ79ktThY4U360l9Z+hl2UOJ8xUe2wF4oZqjYUnB76KchCTGw1WPx/HSC77Lep++P8hEhcfLjqRdrRrWgBBNGw/QKGxCb+Le/LrE7cY5QHRTuJYDJjvoU+R392ZOrJ+svtayPMhAX8ebFXZsYEn3uf+O6J6dTaPYL73yqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752786177; c=relaxed/simple;
	bh=9zUQeTccp3718gUxjT/0ylX/P1DJl6kmckROyxaibeY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=K8Hm3jtSLGETY+sZxvXlSEAaHxhZQFo5dkCuALocCHVMmubewa4oqgFyBsm1wAWFpM28gfqDigvOYeaZ2wePr7YmF3Wt4v3JvH7F04onqkDMK6Xnn69hyJiF0GVzNyyHdKYQ2uNP4dqrnTaEK0KdBg0LjY2wvFZvTprT7yuZNAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S/R0KDpt; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/R0KDpt"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2d9e7fbfedaso1609044fac.3
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Jul 2025 14:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752786175; x=1753390975; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJ/d8adwiFNGcK/vA7cpk18Ivr6shkjwDMIS9Lqkdas=;
        b=S/R0KDptUsOmZ7WfpcmNg6SG639Zq1aIYEjSdATDuM80IIHgOez39KCoXFmSQ98u8T
         wZ7xqcgJ7LOUSYqEHTR+yL3hF25ZC0LXI+YvdAiCDLKtshY/iIyot/WwsTRjSF1U/T7+
         xbLYYGaHG/WWjD+fEOzesZYmWlWstuIuZrLK4AfVt5J6D8+gsvhC0m/NC8XTvvslDdfH
         qGMuv3zho/RUAOeAM94xz73LBJLrs/hKp9J/xzhMjRCtY3WVf0tUPBrQQRaODjLqCsxn
         qlsu46Lq1Dc5Dd30UKc7b7rDC+dAYqJziDbyb18JEse8kSrsWpb+4DxwMWzd0W0W+a01
         +J9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752786175; x=1753390975;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gJ/d8adwiFNGcK/vA7cpk18Ivr6shkjwDMIS9Lqkdas=;
        b=bFoOZmJBgc0MncZHT0sIB7dd02Y6MSutV27XLdQTlMLIJwDkStZtsaXMH1N6SWfooB
         O8cnQMaYaoNy0O/ZrYfPbkA99eyKK1EadSzHLvCtTu4ov/kD8+VaMGFdn7uKp26LVo9U
         n+1OyFtj88e4rSAELKcKBrKTTMNpXMpecRb6b1F8gverINIbTciRc5MheuXH4z0RERru
         HCso0hqqRY/caj11Nd/Ai28CGRPrDO26LuOzSWpakEB8fh4W5np1uFnWC4C0puz0DdOm
         UfzN03EgH6BYWbbb36vT3+mlij9ltbVfHrDAmYtLQzbo8/bbwdSYXWVWOIf0a8frU0WE
         heJA==
X-Forwarded-Encrypted: i=1; AJvYcCU+KUlyvDUc/yMdJ+Ghm6QMVYyYnUxsxFm6u4cmcS+PpMO6Fk1jJFtsKoz8nl8RJV6xtBxFRNC6yN51Q2gz3Ndj@vger.kernel.org
X-Gm-Message-State: AOJu0YywwwUhV8pG8jh24N/pug+CCrCUyyvbJ8IRy9eJDdHajyK6UPQL
	S8Cw2IMyePS47eNdUYFLeX3dglX5VH5XhGCua708tGGnyhNuGaK7e0xYAapqJxicD/i6wGND4uF
	3IxRZzPuO6Q==
X-Google-Smtp-Source: AGHT+IFQrdkpOXC1FDEwFmziGHAaQ0FWIYgGoq1nF194P7haGyxFG4Dt7+N/y2IceE5nPHxNl0Pw1Ki0bHrG
X-Received: from oabdu25.prod.google.com ([2002:a05:6870:3a19:b0:2ff:b181:6d0c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:828:b0:2da:843d:e530
 with SMTP id 586e51a60fabf-2ffb22019a1mr6167320fac.2.1752786175170; Thu, 17
 Jul 2025 14:02:55 -0700 (PDT)
Date: Thu, 17 Jul 2025 14:02:30 -0700
In-Reply-To: <20250717210233.1143622-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250717210233.1143622-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250717210233.1143622-10-irogers@google.com>
Subject: [PATCH v2 09/12] perf pmus: Factor perf_pmus__find_by_attr out of evsel__find_pmu
From: Ian Rogers <irogers@google.com>
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Blake Jones <blakejones@google.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Song Liu <song@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow a PMU to be found by a perf_event_attr, useful when creating
evsels.

Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 29 +++++++++++++++++------------
 tools/perf/util/pmus.h |  2 ++
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 409b909cfa02..9137bb9036ed 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -814,24 +814,18 @@ bool perf_pmus__supports_extended_type(void)
 	return perf_pmus__do_support_extended_type;
 }
 
-struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
+struct perf_pmu *perf_pmus__find_by_attr(const struct perf_event_attr *attr)
 {
-	struct perf_pmu *pmu = evsel->pmu;
-	bool legacy_core_type;
-
-	if (pmu)
-		return pmu;
+	struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
+	u32 type = attr->type;
+	bool legacy_core_type = type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE;
 
-	pmu = perf_pmus__find_by_type(evsel->core.attr.type);
-	legacy_core_type =
-		evsel->core.attr.type == PERF_TYPE_HARDWARE ||
-		evsel->core.attr.type == PERF_TYPE_HW_CACHE;
 	if (!pmu && legacy_core_type && perf_pmus__supports_extended_type()) {
-		u32 type = evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
+		type = attr->config >> PERF_PMU_TYPE_SHIFT;
 
 		pmu = perf_pmus__find_by_type(type);
 	}
-	if (!pmu && (legacy_core_type || evsel->core.attr.type == PERF_TYPE_RAW)) {
+	if (!pmu && (legacy_core_type || type == PERF_TYPE_RAW)) {
 		/*
 		 * For legacy events, if there was no extended type info then
 		 * assume the PMU is the first core PMU.
@@ -842,6 +836,17 @@ struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
 		 */
 		pmu = perf_pmus__find_core_pmu();
 	}
+	return pmu;
+}
+
+struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
+{
+	struct perf_pmu *pmu = evsel->pmu;
+
+	if (pmu)
+		return pmu;
+
+	pmu = perf_pmus__find_by_attr(&evsel->core.attr);
 	((struct evsel *)evsel)->pmu = pmu;
 	return pmu;
 }
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index 86842ee5f539..7cb36863711a 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -5,6 +5,7 @@
 #include <stdbool.h>
 #include <stddef.h>
 
+struct perf_event_attr;
 struct perf_pmu;
 struct print_callbacks;
 
@@ -16,6 +17,7 @@ void perf_pmus__destroy(void);
 
 struct perf_pmu *perf_pmus__find(const char *name);
 struct perf_pmu *perf_pmus__find_by_type(unsigned int type);
+struct perf_pmu *perf_pmus__find_by_attr(const struct perf_event_attr *attr);
 
 struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
-- 
2.50.0.727.gbf7dc18ff4-goog

