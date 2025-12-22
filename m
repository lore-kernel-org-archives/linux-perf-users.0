Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9998232D7F7
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416505; cv=none; b=otsPEKFXhoDEpd8crj+w/AUmIU9e8yZE/5YTFjbNizABXKEmcGCbX/RdZitaos+81wHNQJN2X7R2Rk8ynGV8UScycWcQyMoBApyC9AxS2X2DWdvZCS11zwV9oK9j8rxYOx6CE4PgHaotoJM8EscB/7gO6awzxz/80XdXyY9X1c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416505; c=relaxed/simple;
	bh=qfRSou8Gjtk8a4ox+K4x5qRrVK3aLa89yRlL85yDPKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m8qMFt58XRYZWMBVmJel/2/+Njkg26wa7wDNi/nfvHqkJjrOXiIJ9RVlTB/8mq2zz7jelti75oWPyGhITWVjZ82U4FzrcTG5C9YO0B1aid/VyAGR5duBM8I4BLWRnc4hVweCDDLDInP6FJLCgExhwkolhNHM8tUVuePJBlid+Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kc2GUwWL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kc2GUwWL"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-430fbb6012bso3195173f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 07:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766416502; x=1767021302; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jQ8W5nzp73oSPJlX5Jug7ze2sl2RQ53Mf0/SiitI2Y=;
        b=kc2GUwWLXZYOjYQ76X4inM8w3ZOmIxmQX9cVKFLkweq/Eb/t54vobLaPw19FVbyvwZ
         LdsXK+GrZfi8LltCFAoyPOGcwKnS3BGVJZq6SGppvoHGOzHX7W+upgNM9e9UsZswdpMS
         INcVEa8VKcbMFzqfD44BYLFqfZcrtU/Vp3bSXcWXoF5MbFeuiGQoePR0PQcl46geBcUu
         Nim5aNslJlD8aPE2exkcWpdFKp8QN13+rHFqN24npDy/vhaVs1hIFQBWktaYabfRDRv4
         kS0lKRiwAovwSgAAh61XAtUiF9wS7DXUIOKVXzDjc/ENyXiivM38dAXB6Qc4pr/fXEkg
         sYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766416502; x=1767021302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2jQ8W5nzp73oSPJlX5Jug7ze2sl2RQ53Mf0/SiitI2Y=;
        b=CmnhKNj5PRTxSSY0wcbH+Bqh9HHafLf+1EdT0I9q8TWL9+p4VYa16+adHvgVVRluQq
         l6aRq9d217D9plDk8sHHCCQ6qfobAFHSD9JZ/yScs9H/4KP1z1Jz+mxmpB/Ngmk009NB
         /z9zcJMJtdrA0RbOdGfqQP/iLYdE9rh2TJmDKjhj1jx7bUsOefppmw/edUOUedVi59yr
         TQsoO3RnSxEUye2rYEKg3/hC2i7y4OmI/w6H6t/Mnu7fIUNOhAO1S+dsVsVW/g5bi3I/
         TmHLPbGKxfUnXbdlLb4LobXJrqj89wECQfPAIT2q9Jkz2AX9eidbwBjDVZ3+jNMnimzL
         qhZQ==
X-Gm-Message-State: AOJu0Yzfdj3G5/GL2M5wAYXt6PwE/d59nMRXpXI7caBnaOnag08adaY1
	3jCwogqcGEVWFPLVPFPPXkMxfWjOIdHrWCLCS4C17PtuAHMu1v0toZn1FIIJIpBOMbc=
X-Gm-Gg: AY/fxX5HlxPHB3xr/WB4H9pkCRjX0CZiRlbGGnBL8OBQX8LZPA3JTP9SeVo2Cz0gd51
	oKxdYIi/FWddTlPdo8oIoywQ29hUPSvws4YCjDbK2hN0c3ToBr6Xr0SmA7goF6WGsdmW5czg+PQ
	eBgakc7ReBnjfAVWAX3iEtORVVWtLj2pXLTUw/O0++imeraKT37kAXwGLNnaVFzrA3tZL9LYV2A
	Kv0PPgLSmIINCGKHKP3XB8IUo1bM043f1s1uzRkFr+KeDcc67dQeXh29gmmHyY+iFVijHNVM3IH
	wbpr4Oz8w86r+vArB0zcWGWK7RUxMRpN74X1yFHBzbRw1HmrBe1weBHKu6NRUu9IXUqHQhnRCRi
	/1WA0wK8UcVGwuOkLnQ7GNeRz/ANaxGJhP8FN3YkugkIRJONkNTkOvzR9QdUb/YhligHHC1uaKI
	VMyLBGJlqNGYujjl83VwTt
X-Google-Smtp-Source: AGHT+IGVW2AQoFnt+YQeUkk1+45K7c9zrckQIjMupb2A7/EyJF6AN1n+ruma4tqVGKfvSqChhpvFvg==
X-Received: by 2002:a05:6000:22c9:b0:430:f72e:c998 with SMTP id ffacd0b85a97d-4324e51081bmr14459005f8f.51.1766416502023;
        Mon, 22 Dec 2025 07:15:02 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830fesm22750093f8f.20.2025.12.22.07.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 07:15:01 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 22 Dec 2025 15:14:39 +0000
Subject: [PATCH v4 14/14] perf arm-spe: Don't hard code config attribute
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-james-perf-config-bits-v4-14-0608438186fc@linaro.org>
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

