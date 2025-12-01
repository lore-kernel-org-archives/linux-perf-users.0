Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5666133506A
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 16:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607310; cv=none; b=iWEhRxFjDQu2L70I3oUlrxAiaNqL+guO1XL8QlEgD1C8kPAqPeNWHwXoV/1EJHmBQrmmTMzKumHkWxJIRzgmwiv1YAbTG51bdBvWJlIEBirIXLcztqa+1a4u5sYjb2WP3obZ5AopLBjfjRgZj40TIn1Py/cuTGXjBzfWWF0BbUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607310; c=relaxed/simple;
	bh=v7g+eJS8zgDENJl8497hl9tj8yvM2zLWTQWKh+fYsBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oc/rf/1OExJy+m68o4xkOai4DnsIAyunOgi5CT6MU3/6z+mUVX7J04UgcXp42APZVGzVMqDXvQWSg7Y1uq5xWFsv82jG3urRGemDqTBJW/HZpqdFlei0BckMgkX+xwVxsLVZGFLzgzYIFdpUGJ/8BfS7LdTe7ger7OiHWfNYF5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SjqqXan+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SjqqXan+"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so51874575e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 08:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764607307; x=1765212107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/5T6lo313puZ/SVQF0jyUpNeCSlBosPw8CY0HUbC1E=;
        b=SjqqXan+P6pFlwYry25L8gAPCxe1+uiAcwa1xNRikjUmyUPbS7MgpfDgC3bDtwJEqd
         D991bXuMk6B9Shl0HvYs5fgGF0Yrn1UzPXRhghb8zDj6ZBNM9HOqIG45Ng14BWrl3q5S
         WQbGmnm6ksSxXsbQWziAJirA2mPhYeqxdGeiSrNBHMxDjeob/GygB0EOmU9xJDAf3Xnc
         ok07wnJHwmzIoHX7kl9YV9MGA03fUO1Rw1KlP+yZsxCdaRFW8wjZ9uWgRAtJBR52Eo/O
         hy/sbeBh6u9Kwi17Py2ErgAZxpaE5c7M8JSCkmDV117WjtXID9rRrDHJh3Kf49QqrWCd
         H8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764607307; x=1765212107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T/5T6lo313puZ/SVQF0jyUpNeCSlBosPw8CY0HUbC1E=;
        b=sDJWjIm1NQZAJGiAQQSP75ms+jMfFkf7BvYnAHM+zmFHxuYeDx/lkEMcRkhtKBp0/x
         0SLwELo604qVfymjtlr+xf5TZQIxy0qz7t1ksI6YEi9nsPOjD77oytUAjrAS5wPraaXi
         YNcMkuG6TcTasOy0JpvL125tk3+8kxQOgGvMjJC/wN05dZUSaAEqF44G8XNh/rF0qnq/
         bnG7WyKY4OJQKYgD5bxGRxzZLSg8QMdF3KBf9l1DBjFqxEEaBWqEs+l1goxru/zbTAcu
         Gl++q6w/AGd5R4M7U4Otavzo6ZO02HaAcYqqlqJwSLiF8SHmlZzoJCrNUkuhfMJSEIiC
         Y1yg==
X-Gm-Message-State: AOJu0YwvlK2TJ/4ey2pqm3q58/zgq44Sj/DaUroFdVwSnRWNwoQM78cU
	wwlLhc2wyiT33rKGuJAyMd4QjZXUaNuOGgXw5XC8L++oYU2m+MztG4sLQE1pKIOWEN0=
X-Gm-Gg: ASbGncs9Bw7AzbbjJodUj27eg/6B0d0JDpHKtgoJh9Je3WNzaoFkNbQ2Z7ePKVoS4CX
	odA5zUksj4bkPTlpDnXtQo3+qGjTCzi54LCbjecu/Lj20pRo2x0PoqbJCyOeK8UZej6x9FgcCSB
	feuA69t3jRLpTUlz5nY5eCfcGinZg7oO7dVu0Ac9YglCtSreaOHCZcbl/9ZYuWcV6CO6J7q/OUU
	VVLh+H21ZMjZggwNi5kZ+ZPV3XZomuppIkfOoVA8jytMXlrjTS0w1lXyJH7945GR5iQgHmsi071
	K2m6OM3jG5nmCRKNOyEmrogqCwDtfHEqfIquc2ewX1bQtXeIpqW+JykWeYBFMKZiEMaClvQBKaL
	fBb99Yb0Hc0I2mVIcdOgvTkWN4VcBkRtKYBAk/LREIRkgwKD5w5w/u7fwQU1lWSXzIvRHiXnhaq
	RwDjjAgOHaa5wUAccgiqsN
X-Google-Smtp-Source: AGHT+IEE3voa2OXjkQohxBlLJHCO8n9F+sDfMVLCHbry/3Vx/3/QnGHskYaS+QvFk8/708DyHCFFKQ==
X-Received: by 2002:a05:600c:3587:b0:471:131f:85aa with SMTP id 5b1f17b1804b1-47904aecfd9mr268721295e9.13.1764607306655;
        Mon, 01 Dec 2025 08:41:46 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791164d4f3sm255901275e9.13.2025.12.01.08.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 08:41:46 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 01 Dec 2025 16:41:06 +0000
Subject: [PATCH 3/7] perf cs-etm: Make a helper to find the Coresight evsel
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-james-perf-config-bits-v1-3-22ecbbf8007c@linaro.org>
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

This pattern occurs a few times and we'll add another one later, so add
a helper function for it.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 50 +++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index ea891d12f8f4..22c6272e8c36 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -302,6 +302,19 @@ static int cs_etm_set_sink_attr(struct perf_pmu *pmu,
 	return 0;
 }
 
+static struct evsel *cs_etm_get_evsel(struct evlist *evlist,
+				      struct perf_pmu *cs_etm_pmu)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->core.attr.type == cs_etm_pmu->type)
+			return evsel;
+	}
+
+	return NULL;
+}
+
 static int cs_etm_recording_options(struct auxtrace_record *itr,
 				    struct evlist *evlist,
 				    struct record_opts *opts)
@@ -476,29 +489,21 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 
 static u64 cs_etm_get_config(struct auxtrace_record *itr)
 {
-	u64 config = 0;
 	struct cs_etm_recording *ptr =
 			container_of(itr, struct cs_etm_recording, itr);
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
 	struct evlist *evlist = ptr->evlist;
-	struct evsel *evsel;
+	struct evsel *evsel = cs_etm_get_evsel(evlist, cs_etm_pmu);
 
-	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->core.attr.type == cs_etm_pmu->type) {
-			/*
-			 * Variable perf_event_attr::config is assigned to
-			 * ETMv3/PTM.  The bit fields have been made to match
-			 * the ETMv3.5 ETRMCR register specification.  See the
-			 * PMU_FORMAT_ATTR() declarations in
-			 * drivers/hwtracing/coresight/coresight-perf.c for
-			 * details.
-			 */
-			config = evsel->core.attr.config;
-			break;
-		}
-	}
-
-	return config;
+	/*
+	 * Variable perf_event_attr::config is assigned to
+	 * ETMv3/PTM.  The bit fields have been made to match
+	 * the ETMv3.5 ETRMCR register specification.  See the
+	 * PMU_FORMAT_ATTR() declarations in
+	 * drivers/hwtracing/coresight/coresight-perf.c for
+	 * details.
+	 */
+	return evsel ? evsel->core.attr.config : 0;
 }
 
 #ifndef BIT
@@ -832,12 +837,11 @@ static int cs_etm_snapshot_start(struct auxtrace_record *itr)
 {
 	struct cs_etm_recording *ptr =
 			container_of(itr, struct cs_etm_recording, itr);
-	struct evsel *evsel;
+	struct evsel *evsel = cs_etm_get_evsel(ptr->evlist, ptr->cs_etm_pmu);
+
+	if (evsel)
+		return evsel__disable(evsel);
 
-	evlist__for_each_entry(ptr->evlist, evsel) {
-		if (evsel->core.attr.type == ptr->cs_etm_pmu->type)
-			return evsel__disable(evsel);
-	}
 	return -EINVAL;
 }
 

-- 
2.34.1

