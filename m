Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50896161328
	for <linux-perf-users@vger.kernel.org>; Fri, 10 May 2024 05:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715319495; cv=none; b=YtbQOFY4Crz/VgfxVkAushgPOw7JrwkeJ8sD5hAoIXUzSj7RYV8VKUm+dFaNY8GnfI66Fi48B5VerPP6NIGp9rymcV60JFLCIQSQ1YH4gAd1nxRL/O8HlU/j8NqgdZedDMzwvLMzZLK1vvsMu6xnT8yQK6/3v64/iSkFqeGFGsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715319495; c=relaxed/simple;
	bh=vw95n4rn5vnmJbH7gGbwuIcX3seEX/vyVpcGLsRC0No=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JAlgD+IwZpgGUBhn9z+fqVMWr//t93aV5mdCIbT3PCKror7ikdIq34QLdiWuxv1vnnKmCPRpOYi5MlF5gDk59RqTH18P1RJgGOS9E+rbsF++4GtS5Ve8EbA6H2rFblDnpCRbV5Ja1ryN8Z0a8Vt7gzGETWXqefHsDFNHCNfbnIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4JTSuiMJ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4JTSuiMJ"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be621bd84so27318477b3.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 May 2024 22:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715319493; x=1715924293; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z8mUHoTTwTNDR6VMgnmgQcaPuyAY5QRbZWhXDi0dIfE=;
        b=4JTSuiMJLVY8bHFBZZoTCM9E7syHvTDgq9MDftf/n+P0XVdFSuWNdonxzacEkOVNd6
         ZDQlROgcvIvxPm/FTqUbBsEOsaDJqGr5ytD5b7kYWo0xoGGcLMtr9hi29pjQVRYCnJH2
         In27JKn3VZAAbo0Plw8dfBOT/GBKJUPHcKG3DtMqU1Ass+e4Rn15CY08JibAPTGIgLHj
         OBSMS5ElcN9NyuQ/fPoc+4oh5/2jwBO+4J/HpjnexnBBxUCLLjgErC6/Uho/7QJRWKI8
         HR4DnN9+xKXND0xa8Dx21iKz/B+sfQRRu1lYpCZX5kAmxkakTpnybl8/suD35MgAGfc3
         AVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715319493; x=1715924293;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8mUHoTTwTNDR6VMgnmgQcaPuyAY5QRbZWhXDi0dIfE=;
        b=uHfeXm1cWICrwE2RII7ikOhviLgN0PSVOufCAtQRi7OCgcVagyjFXaY0UStgKX+7oe
         n0KYAdg0x4QTdMYdcN1tkxY2DkjPBvO03Fe+g8uV7YtJ909GMfQf/HOBBftIPoZG4O9j
         fxtsIvfmCgVoQQ8edVlPsq6kUSYcnhHaQeKowUf319K/iktQ79K8p9akIGqy49tqHwzK
         FSayzl+/CsLYsJeEWozqf81QYkP2GqEKncE8gZmpyJZ9Y0dyd/3X6o8qJj6quyryghMu
         3huP8jTLHfueW4289Hftb+Q+1YKksQNIV3UjiJcpvjOux8yL+qLplYc+XsOlf4tCDF0t
         e5fw==
X-Forwarded-Encrypted: i=1; AJvYcCUlGeyXCjxlcuTCeoxU/+Wu0Xg1nJMapDy3dCnStSSngdFEf1HTzqAJOnHHCRttSqbczubGKHpVZOdASuT/AX+N5wavJ43YLUj3pDOz5lQ/mQ==
X-Gm-Message-State: AOJu0YyQ6JRyOOyPPSBbOjsTUS3BnKJyLfLzlZIj9RT+OSQcTBDzDx2I
	CaOfwBC2LlLau1F+TRQK67Ls7akzYDAC/CTpDYFpmHyn1zn2mNI27POoeBajFec7eGwgLnshbRf
	n7NTp8A==
X-Google-Smtp-Source: AGHT+IEuORGK6XeqhS3knqXzuXQaKfa5sKPSvjks/Ef2jBveYaz1Jn8BtFQlW24dzkX+bRKresX4hrFHlWLd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:79ed:c375:51e3:ed39])
 (user=irogers job=sendgmr) by 2002:a05:690c:6010:b0:618:876d:b87d with SMTP
 id 00721157ae682-622b013431emr3642737b3.5.1715319493366; Thu, 09 May 2024
 22:38:13 -0700 (PDT)
Date: Thu,  9 May 2024 22:37:04 -0700
In-Reply-To: <20240510053705.2462258-1-irogers@google.com>
Message-Id: <20240510053705.2462258-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510053705.2462258-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Subject: [PATCH v3 4/5] perf evsel x86: Make evsel__has_perf_metrics work for
 legacy events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, Yang Jihong <yangjihong@bytedance.com>, 
	Ze Gao <zegao2021@gmail.com>, Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Kaige Ye <ye@kaige.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Use PMU interface to better detect core PMU for legacy events. Look
for slots event on core PMU if it is appropriate for the event.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/evsel.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 090d0f371891..1eaae8819c5e 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -21,7 +21,8 @@ void arch_evsel__set_sample_weight(struct evsel *evsel)
 /* Check whether the evsel's PMU supports the perf metrics */
 bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
 {
-	const char *pmu_name = evsel->pmu_name ? evsel->pmu_name : "cpu";
+	struct perf_pmu *pmu;
+	u32 type = evsel->core.attr.type;
 
 	/*
 	 * The PERF_TYPE_RAW type is the core PMU type, e.g., "cpu" PMU
@@ -31,11 +32,31 @@ bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
 	 * Checking both the PERF_TYPE_RAW type and the slots event
 	 * should be good enough to detect the perf metrics feature.
 	 */
-	if ((evsel->core.attr.type == PERF_TYPE_RAW) &&
-	    perf_pmus__have_event(pmu_name, "slots"))
-		return true;
+again:
+	switch (type) {
+	case PERF_TYPE_HARDWARE:
+	case PERF_TYPE_HW_CACHE:
+		type = evsel->core.attr.config >> PERF_PMU_TYPE_SHIFT;
+		if (type)
+			goto again;
+		break;
+	case PERF_TYPE_RAW:
+		break;
+	default:
+		return false;
+	}
+
+	pmu = evsel->pmu;
+	if (pmu == &perf_pmu__fake)
+		pmu = NULL;
 
-	return false;
+	if (!pmu) {
+		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
+			if (pmu->type == PERF_TYPE_RAW)
+				break;
+		}
+	}
+	return pmu && perf_pmu__have_event(pmu, "slots");
 }
 
 bool arch_evsel__must_be_in_group(const struct evsel *evsel)
-- 
2.45.0.118.g7fe29c98d7-goog

