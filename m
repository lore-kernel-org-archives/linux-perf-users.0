Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B580D31C58E
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553583; cv=none; b=nZ2T6NkFci+zCpGXC24RInwAslZr+3ru3jR6RgP+e85CcjaI0+dJgncGAXuKtfuBK8WcZyMnApvbLxyu6dZ31ZqcLhXkoLeHM2W470h8G9baNXYkikzmE/T5wDrkk8YaneEP5bptvE/aISswqGq0mMelLPbhWvHMrlicmu4h/HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553583; c=relaxed/simple;
	bh=qgsdekHEBzAXO5lvPU9/5A8O0g5IS9B8puKwIYnrP+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JrngbEWl4fQolrTaAdF0nbF1MqiSVlqaOuA+zRg/5XySf1SIrE3DK3JujAorc0pBN/HceXK89hQD9B/R0al/qx0RSybjO8tb22EdGySPbRcu2SODAA/S/Vsk1hKAaK9AO+JDT0gw9gdh9Fd+CRCdo1G+qsGGCcKLqImvOcEFZng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WMfGxlpv; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMfGxlpv"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so2383806a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 07:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765553579; x=1766158379; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OERRRk3y48q4ktL/F5cCy8Sn/Ar6UF3zQz2qyOlFtzY=;
        b=WMfGxlpv4NSrFdg8VlcRpJmKAaijZk6lLy32by5ebZa2MmursnmhLVya136ZGxSP+f
         8yTC/zRTyijTKZKeGLmxDVdct5sZeSvEZCU1kgs7LGWFXpN3J25lFUYw9G1oZE178p2x
         HXgwMpiWcASjLyV1VHc7Ui8KFUVuYqCghc7RR+krbus8Lc4FtxdLfErOrXoJIWSl+6Ok
         lD5U9ahCpOoEftNsHBe9dFl1KLB6d7VSjFQ4TQpJ1vE9xfEnEB6E8yCrrkq9onliADcH
         yCLIKClPMb+zUtrN90FG9DKXmbdom0t24nHSvIAahmRkNcZF2tTYdjtXo3dZt16uI8dF
         etQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765553579; x=1766158379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OERRRk3y48q4ktL/F5cCy8Sn/Ar6UF3zQz2qyOlFtzY=;
        b=qQ5mQABv11fl4PkqhyME/ChXxuWO2cFcAE/A0WIfDppAr5rQCrWvMzbU7xkfwRxz1q
         2DxXHUqsPAjVGc2qurVe2t847ROSYAYXxr9pQWn7ZiiznUdGIiCfhbFes1ZrSKVwcSsF
         pBJjRophTZC8Mbbxj5CTCIVE8nBY1EtHRmzuRnxK1hQHq/3zcentC5mTr9flogg32OMk
         zyowPOFgkWZM8nXhuCBoVO86mQ9bjbMYvzrHsBNp9dG9ObVZy5n93zG+jD10gBTxx6s1
         GO1HXrP745Ku+kHBa3bbuc/67vvTzial5m6BXxkwNHfSXUAJ7ctj6GK9InM9tHxn9h/F
         qLVA==
X-Gm-Message-State: AOJu0YyG9A4DRnMeCc8b12ew6eVRyY0UNEC626HovqZw3sHTXxhbcClZ
	cMNMiMQAbe/8fVezslWG1T8gQaYT8csZDDxsgePnBE2gULhPk8IjK7JInsapwSAH15I=
X-Gm-Gg: AY/fxX4mjtvGjbP6bYVENZSXlzAE7lZtQNVftNIFfJ8aVKBHTvQuzioguXxCo3IZTZ5
	P8gsaFUkswQ3zR7eSSVuGtgbc9HI9FDmloKS41wDaZpTYOrn3C+/EqpzUfRsuF16LZbtwhC7pi5
	2qDeS+Axf/qdYQXaagdSSPszlHIasccJVgO2yjsvB96jBwQjxZRs14jkr65AfAzIOy5ZNe0L4Xh
	7mbluaZLIgd7hRfV8LcOe6WS4EScv3DGUusLswcNbjvSyT+fkC6BX3hQoU6ilXWXoRzvGplOEdU
	Nf3NEm3FxaI9/562xhrsIVzy6X9W5rtDg7CZcoLEFx629bbkLSEUDc6E6mO2xB/CE5FcdAK4xMK
	FDk9kVZY0rbch7KjCB1J72JKx3EbWkeM0K8zJZDPeN68h9G6BWrCOPRRO1edWZcdDOnWzbWPDyF
	Wlmd+7MDHcjO3ynY3GvF5J
X-Google-Smtp-Source: AGHT+IGKOsI6qPk5daX8P1jxmI9pL8L+QcZ2sUXB0l9hmBt0/lTf0xmqKtrLbY0Q9t9jSG5KaAnb6w==
X-Received: by 2002:a05:6402:35ce:b0:63c:3c63:75ed with SMTP id 4fb4d7f45d1cf-6499b1c6ab0mr2342038a12.22.1765553578761;
        Fri, 12 Dec 2025 07:32:58 -0800 (PST)
Received: from e133063.arm.com ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498210ed32sm5433234a12.29.2025.12.12.07.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:32:58 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Fri, 12 Dec 2025 17:32:25 +0200
Subject: [PATCH v3 08/12] perf cs-etm: Make a helper to find the Coresight
 evsel
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-james-perf-config-bits-v3-8-aa36a4846776@linaro.org>
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
 James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2

This pattern occurs a few times and we'll add another one later, so add
a helper function for it.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 50 +++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index ea891d12f8f40beebf8dee1d3db71cad701f5666..22c6272e8c367e5671809771b841c5babe2d5282 100644
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

