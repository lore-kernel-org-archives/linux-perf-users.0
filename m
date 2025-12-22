Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D6132B9BD
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416501; cv=none; b=YrVq1MZ6vwyAbbdOvuWvaeG0GYf1ey+ykQoDEgBPEHKv/M4AeN9+IJyi/YgiolPcFUGF73h+27n+hsIqUlKjmv+BVUfQSZfWtlB9CZU0yEcq0qVm1rHE+y9UWYEf9fw/h4UUoPGHyoM06nVx6HdbApUjoZVksgmCDQuFb7vuToU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416501; c=relaxed/simple;
	bh=xdhUjHRtxvw8BCDXCGf/XHbPNrOY6/jThaBJXsuN6Oo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X0JQJNV5MLeoy4zFlEdassEe4eOnnrRXOtcidW+JDeDUFwGOg04TRqNap3hVu3/6l29Ai0tv+5HP33qHJjGbVKmjhrvIguKviu6oTKk6SV43Arxlb+x6FSWs6Djio5mhlOgkkDcbW11skLUqstMM4A+cYdV5fDcyWHZxZeTF/g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=siWAE+V/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="siWAE+V/"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fbc544b09so3100080f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 07:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766416498; x=1767021298; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IHuJ8xIDoo5vqekEsW8kb8XOXUQ7JU8mQQu2ivsjyMg=;
        b=siWAE+V/v5GvaMEeqwEkt+HuWxoaR0iVPjhbdkP0Z4yfDqzcUcKUbCNSNALARLi6RD
         2OFRGoTwl3Pu5JkEez/yuUJpvESkircXWgDoNIHWyzZFc1h8JZLZn8GQRcE2KDRUbHnR
         tudON2pA2/vNXelpWTJ/5SXO3fcYoSN41r61cn8ZPX7W44r+sdf1pxxYjGKON3YnlAhN
         2zsU0hkqt3ebzJlkXBtWkOkSX/ho9EIXHrFVtMtti+vKyJ/oHsDpds6ppBwmmi/xPZpL
         2qYtBMPvtHL3nnjLkodSs390szRlUv+hXdJ16XnnNgjpKucNNiqP/qHnXxd2q50/KkNU
         2BuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766416498; x=1767021298;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IHuJ8xIDoo5vqekEsW8kb8XOXUQ7JU8mQQu2ivsjyMg=;
        b=gK4FoMqdTJF/8rmf9CVZ6EQIcT76EClolQLrhLENN/zq784cT7MZkPjVW1E+DZqFfu
         YjqzqfsPDMJ5q+UpfjoYxwIoi/MfTFmUoxFrb6o2vuJSluOG9pMOc/c2fo4evzr+NuoD
         3Ndh7/CbQrdNGimiMbRC8LMCMyuhYHnSj/5KBf6kRbWZfTfNIFVybHTPcLcQ2VPlTF9X
         OEGq9IvF/2sWo/qaI+xXP4I+Nr9CpUTYEAR6BdDzntApdvZ29/LzGen9HzNlpd2b8PNz
         V1Rt0TZHS6QDNs6DOOObnsPJPhGBNUe/tg/HfNbVi+QZhpa8onWmL3TMm6i//ga8NHsB
         /tJQ==
X-Gm-Message-State: AOJu0Yy9FKN+TSoDxlZBTbhksZhDXtNM16Kk5Rdi4L09u7hGNaUvFKP4
	us5aySjuVutKkfgj4S+62gE6JYk/pOblWqPM0MWWOxu2DAKgxCE6iodwu613FsgxPXQ=
X-Gm-Gg: AY/fxX61qKJoNkfMkVZ/o6+B6DP+UmhUQ/9yXIoEwXnf3R3PfDKHOeCgSgVWgY6Ghbr
	vowEiepWgLNOJ4FGE8xHowpfrbwDTU/wgQlo0VtBqGdyLn1tS/DK9oYd4rzGS+prxm4ee+HUgyt
	zrTRHAjbkdaXG1g0NQwzMa4zuQGbA/03qFK/ZfM5CWOWzrqcyggylkHUynhS4DiOanuJXaIPhHR
	MgAddeoTxYHjchzPyTNp74+hePmibdo40K5V86BJcZrMxCS46A6utmcZevXrtnSS9+ihdkivRVk
	MMPcsfR4kEKuq3S2SkGcHS93JI3820wd8KiMR05BeJ9eWiFVLLCHl15/8cu+GDU6MXyM7jH6dwF
	HERvLt5CETcY1IK4C8I3VT/b6BtGOrSRKVgJTSt3S0IQ2w4TMPx7G6m0rCeFRmrSXSlMlXtWhkt
	oZEh9AOGe4erPf5tR6CX90
X-Google-Smtp-Source: AGHT+IGRZvc9aknIZPTTtyXV/B0ua6X8t/YbFs3N1GKO4vbSwiO8gsbcX+wj/sriPf9bBic/0iVCfA==
X-Received: by 2002:a05:6000:2c01:b0:431:92e:1d44 with SMTP id ffacd0b85a97d-4324e4cbc63mr11599219f8f.20.1766416497736;
        Mon, 22 Dec 2025 07:14:57 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830fesm22750093f8f.20.2025.12.22.07.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 07:14:57 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 22 Dec 2025 15:14:35 +0000
Subject: [PATCH v4 10/14] perf cs-etm: Make a helper to find the Coresight
 evsel
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-james-perf-config-bits-v4-10-0608438186fc@linaro.org>
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
 Leo Yan <leo.yan@arm.com>, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

This pattern occurs a few times and we'll add another one later, so add
a helper function for it.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 50 +++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index c28208361d91..a49753f0d20f 100644
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
@@ -473,29 +486,21 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 
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
@@ -829,12 +834,11 @@ static int cs_etm_snapshot_start(struct auxtrace_record *itr)
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

