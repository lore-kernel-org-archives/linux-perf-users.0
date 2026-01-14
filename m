Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2953A1E90
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406286; cv=none; b=Ma0x8D9AbORG2RMtJD4GlSHz9pnoFuvcRvPh8Fp6L21NO0TGBRF295RDnuQyzzIzVcDIKq81peONB6ITg4P5kXwbYcsb96lwMNKpwl2rk4ECJhnZsD6Smf0POQtkBthxNiJNdRFiUv0phj05bb6umWtGUvF8LWBZp+7mKs4CCn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406286; c=relaxed/simple;
	bh=qfRSou8Gjtk8a4ox+K4x5qRrVK3aLa89yRlL85yDPKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M+w6TgLUpOmV30ioDo0ta09hzjqVvwVwrwyXxi0qVeMQ3UyIUd7OwMxZzIqnD1saJLZGkQpl3LG5qc4b3UlyExUoRC2HNt2CUxSEqmljK/3luVC7PSlNlvDT6xwsxZVFxmQ2jwDJrpYOmMNlC+u8eiuQp8FetTAX5FLd2M3X5no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vhTHSKfr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vhTHSKfr"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so84362395e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jan 2026 07:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768406275; x=1769011075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jQ8W5nzp73oSPJlX5Jug7ze2sl2RQ53Mf0/SiitI2Y=;
        b=vhTHSKfrbpifs1jJvOhR32u8/UWoaS1EQTayJqLM9R0NYoVpL/KoSLLOAZj4HOGW4s
         VPbj36GJbaVohaA4jDQyP8tjZCaP7sqYKvBczYh8kfGzaiq8i0J217REeMLCn7YVdPWf
         W3ACmWSmLfdUCjD/vHID8KVCT4q2qSzE4KFsE2mgElOuQHIOvFj9mdkjyYNsdUOZ4DM4
         vdBF4K+8WsPSLAFf/DKvRIEYxYaAfyRQZpjeLkUIQEIHISKcVNEHB7f9golLVmC6z8vp
         /RbH5REgVis7Ns2n0ulOTjZeUi3PR+KqVBG+JcQD++vMqNwMmWR/0QGG/zB99bQ4TCAX
         hezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406275; x=1769011075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2jQ8W5nzp73oSPJlX5Jug7ze2sl2RQ53Mf0/SiitI2Y=;
        b=OnvpZLgN1S7WTNRd6hNDi+jhH70OSxSTxq9pZDWt5ck0DBVcRbgkPLDCvkNpHNlWNz
         qSs3qbcd6WJgdnx3jdbH2xg4c8ubQvgcd2mzzX9y2ZOaqT5Sqpvb+lxuhEq3vSaS641q
         XXlbmk4XcWr4D1bjjUloud/qAn0gAh9sItQNNJPe/15YKMmlIwFkpQJWwaJzjhsle/KC
         IoXJ0rUR+hFCtT3aoniuCRG92G7QMIC8Apo9VtUMjHGnxyEvErZCEYoDfLl+StHi75Rm
         8+9Z/Lj/gN3jk9A8HbvC7ppVvMad8n9Zg3Eryn+6kulAKCSPgGUz2dFbjOl6RQmfU8Ud
         w+iQ==
X-Gm-Message-State: AOJu0Yx1kuF9t97OFCL0V2Ap3Tv4VVAaJRtLO0gGwTdlYhMHX63YxWsl
	wijj6eOkKdL4N93IT8O6oeGfVj8yGes7TxR8HWolV8XJ3SImyJJnKYQsDif8wwmsDZA=
X-Gm-Gg: AY/fxX5VFNgXckeAEf6pJX5rpW6dr3SPtyDTiyckSo0oyqpcQkGtxiFmCDgCl/PpfmE
	xSzqdFDXeMUL1y9jRSNtHOvh4RfJsnsh4wdGGawRg8CpQ+4KvacP25WyBJn+H+WUe9MI+r17X2/
	F6WULqR9VAGMoMXBBjOO2L22Ilf8U4xhdftlLtc4lOhN3Sf2FvcELFqrhtp79n3qjG+bCPoB3ge
	fiYhVqGRUyX4CfuZ6SJqUWToZCQGuDCvFUBUcIStGZtqN1Dc6ZpuNTMHYmtfDAwYt3piDwajSnd
	8QFNVC25txJT8d9KMM+QqmpYzymTmV3LCKoKJdKuE0Tr0hTnUCPZ/qzpI0yGyVJhJHEglMbl7m3
	OwyLzK4LjOSwJaZ2sG/fN5fKSEVie55s9qadHxvg/dOJaDlKbzveIm/HoLijXsLL4+LGfNNa1Ji
	GTaUGhY1BENL8j2RMX4JCO
X-Received: by 2002:a05:600c:1c15:b0:47d:3ead:7439 with SMTP id 5b1f17b1804b1-47ee339e454mr33949925e9.37.1768406275018;
        Wed, 14 Jan 2026 07:57:55 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee85e8807sm7426475e9.16.2026.01.14.07.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:57:54 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 14 Jan 2026 15:57:26 +0000
Subject: [PATCH v5 14/14] perf arm-spe: Don't hard code config attribute
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-james-perf-config-bits-v5-14-0ef97aaf1ac0@linaro.org>
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

Use the config attribute that's published by the driver instead of
hard coding "attr.config".

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 51014f8bff97..17ced7bbbdda 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -256,7 +256,7 @@ static __u64 arm_spe_pmu__sample_period(const struct perf_pmu *arm_spe_pmu)
 
 static void arm_spe_setup_evsel(struct evsel *evsel, struct perf_cpu_map *cpus)
 {
-	u64 bit;
+	u64 pa_enable_bit;
 
 	evsel->core.attr.freq = 0;
 	evsel->core.attr.sample_period = arm_spe_pmu__sample_period(evsel->pmu);
@@ -288,9 +288,10 @@ static void arm_spe_setup_evsel(struct evsel *evsel, struct perf_cpu_map *cpus)
 	 * inform that the resulting output's SPE samples contain physical addresses
 	 * where applicable.
 	 */
-	bit = perf_pmu__format_bits(evsel->pmu, "pa_enable");
-	if (evsel->core.attr.config & bit)
-		evsel__set_sample_bit(evsel, PHYS_ADDR);
+
+	if (!evsel__get_config_val(evsel, "pa_enable", &pa_enable_bit))
+		if (pa_enable_bit)
+			evsel__set_sample_bit(evsel, PHYS_ADDR);
 }
 
 static int arm_spe_setup_aux_buffer(struct record_opts *opts)
@@ -397,6 +398,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
 	bool discard = false;
 	int err;
+	u64 discard_bit;
 
 	sper->evlist = evlist;
 
@@ -425,9 +427,8 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 	evlist__for_each_entry_safe(evlist, tmp, evsel) {
 		if (evsel__is_aux_event(evsel)) {
 			arm_spe_setup_evsel(evsel, cpus);
-			if (evsel->core.attr.config &
-			    perf_pmu__format_bits(evsel->pmu, "discard"))
-				discard = true;
+			if (!evsel__get_config_val(evsel, "discard", &discard_bit))
+				discard = !!discard_bit;
 		}
 	}
 

-- 
2.34.1

