Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E002B3A0EBC
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406281; cv=none; b=j3qRGyd6XSUU53aQFMccXBXZFp9luqdBtvdz9GWXiIKLP/4DPXI9yaeQ4sfYMPvlmXF570bXdwP+PpoHCM3MA6yyPaIAC+Aru4Drrc2hE/3BNnmYLLCrPpomI0lUeZ7q7JrlR1LVs5o/iPcsXwvAomBigIeMVwsFU/BNVwYjQHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406281; c=relaxed/simple;
	bh=xdhUjHRtxvw8BCDXCGf/XHbPNrOY6/jThaBJXsuN6Oo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jdaH+MURSjqaNZ1x2lSd+boeUJ5k0mYxS3G+ZBNjoHqhCMYah/DuLrKg3JFwLS/m55/0U+8xND5IKVxyjUbenPxcqtBJod+m/E5RuKaa2kszVKEX0ZAosXtDaIl5gVJrGgAnR4rgLxHvViXUjlOey54R4+pE7klVIh9QJLsvtW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xSdcg2eH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xSdcg2eH"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so29845e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 07:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768406270; x=1769011070; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IHuJ8xIDoo5vqekEsW8kb8XOXUQ7JU8mQQu2ivsjyMg=;
        b=xSdcg2eHhCutz9reuhtnBgNDNVr34PByifVoIrIKoqLiJlfur/GHzgnP1dYiVO014D
         rQgqbK8yY5tOAEg2BFIDYmenmVeSf0kGfcPcUmNTnIimFyKfMSUueNy2AwNxJubbiCug
         mXl8mYZCgGXt+GY+0MdWd8+ZEMsPAB3Ay3ClwxNzMpjq+TQn6sLPi7G4W2bE/iu5D75b
         YIBoCg1JnRkX1jI9OxWZMvPYXDmFBNPtaua7lsP2ulXr7hYPhBZ+oPGXPVU1l8Xyt8LV
         BgAZ/CrY66sqnBEg3hoyt9RrDds1mcrm8tH5YywuocGEjf1qwhAhF3CqhTZYAMgcRvV5
         fg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406270; x=1769011070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IHuJ8xIDoo5vqekEsW8kb8XOXUQ7JU8mQQu2ivsjyMg=;
        b=KPEN4pFH4WuZemExaAttPTPo9auL/toRQbtG/kQIlBUE5rraDC4u06KKsyVesq6Z/k
         cvppWDDoqQzA8kyMuevKteCOhPBHOKpcZZjaSDnaELYXym2HWs01wUZokSzUP1oY2dKx
         mEJqmfq1xSP8BbCMRgsP9eALVX+U3C3SicR+5viTdtjnM7fLqtXyxt1RxsfopOTMEzz3
         GFpcziu+s96mnyFx4u5z3KeW+GCYslXWo/x2AiCWvw86kCtknKBgPrXY4MASlkAaAIvA
         cFQ75mY9niZzsAmQtJHRnEoBTfgMvvZspKBUKE+w0OnS61t2B7nyDAnAxgLTO1mzVY+O
         S3lw==
X-Gm-Message-State: AOJu0YwCPZJoFIpsHqLlRcpnURKItaCSFg3gQydz+1AVnUN7qoohdiQQ
	xrqZ+zge4TY4+IM9jx0I5Lgoaq7k2O4ZezIQclPV1OXO1EfM2PJ5Z+pl+GbuJ7UALXU=
X-Gm-Gg: AY/fxX4pX2WYc6pjhPGX3GXjJoSl+cEXbIyH5CYYnIAFA0FR4sJUByFHXhcWLrnN6wR
	1EUaQNqjvBtzjoVdtTRshAiIN5HK+fLSB+/IEdhqS2Ke1Cjwc+IGCDF3pQt0Mrafh8FZnTeHsLP
	9MPEmE0rth6JmASsFdZLYFgQboYI6pNXicN/JbCLzK/NIG7nq+SMSHqvIQ4ba2resM3PKXAJ8mQ
	ntlLqru+qDdB9R5ULnyMQ4rpp2Ze4rmquYnE6Q91ysoITdTBA0VSxBTK10GQZvL8/AVWgu3eNAl
	83DycYmIuXAEmvMUc/eMIfONI2Zn7ZnsGlSqhnYSIJ7JcDz98f725GWcRI1QrLGZqjAq6sHUhv3
	pkhsX0M8m9ApHyWQyZ4/XVqwsguGEdjL2zLH7B6F4jRfgIitf2TL+AUMMsTlNm3Ox1OkvfVNljA
	i4mpheLKxOqYebkO7Epm8k
X-Received: by 2002:a05:600c:8b0a:b0:47a:7fd0:9f01 with SMTP id 5b1f17b1804b1-47ee3356c0amr37970915e9.16.1768406270036;
        Wed, 14 Jan 2026 07:57:50 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee85e8807sm7426475e9.16.2026.01.14.07.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:57:49 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 14 Jan 2026 15:57:22 +0000
Subject: [PATCH v5 10/14] perf cs-etm: Make a helper to find the Coresight
 evsel
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-james-perf-config-bits-v5-10-0ef97aaf1ac0@linaro.org>
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

