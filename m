Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289EB3246FD
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553590; cv=none; b=K8M2+6pa51XxiN5PtpeIB5xG/LzYUr3dBRmZ9oirayrGcUoj5j/1TIegQ5aK7nO+yAbEhg4OBlrOgHeQRMpZsOx4QCe+AjpPj8E+QvBZsDaKTOUsqJFCnALqu90OgprXdR97FQxL+5Lv69LN8F8pyxZd3TKLsf4bH6lWlnECZVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553590; c=relaxed/simple;
	bh=+3Y3lcxZMqFLbNOWqAJ1uO9Sw58KGFuwnvIdXYYIXjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NeydwI8HPjtcmEyb090NydOCFANUVU2p0sKYO6OmDrdnTiHP01aliEkhOaEMvcKFarYhcdPr7LQOPHn4gjhrcLPsfosjcrAz8FwaEDzBKyjd/BTvB90P27A13XLMp0g0LrXVCCqQOrl3Nm+7FjgToScFOBtNHoLsa0BpXswbjuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lXjTv0nr; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lXjTv0nr"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b75c7cb722aso271486966b.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Dec 2025 07:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765553586; x=1766158386; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=40w1+RpiFWn7cLTaBFnZfKV4QslzhNGDu3cnJiEGNGY=;
        b=lXjTv0nrAbJPl9W3BvxIeEVMca+rsYwaijKtXfThOzay2EKojwvB3HihiRzMU1HwN7
         5Co2ACZgtieBQYy43tKg5bJ+XVFAiBCmDEMJx24daizO+n8mSqpmeU4vHcKdMS+2ug2Q
         6UNsn4IqXFUxB47yWHHiXi4DjynO5l3bX4MAHqMQuVp2OHROgd41p6rU/aDBFDSC0MIK
         1BC91E01Mb+X5VDrn+WWHEYK4FHMML5C2UVLYKT67J9mLBh8oMXn1UiOraLeqoVJays0
         hwGhad8bKnwJvx7qVI68C0DCJ841mMmRfZPtzozd7ZrhWXTlbO7CZvfQi8ZKJe1IStrJ
         s4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765553586; x=1766158386;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=40w1+RpiFWn7cLTaBFnZfKV4QslzhNGDu3cnJiEGNGY=;
        b=EvtnZR0HUsvfwYGCnqJhVDqgn2znGW3MOKtrLg4eWrL3opinjLCTPfx6e9FOsQx7Yh
         IT2YIb4eUiQXzwjqHhYZI5oYz9NbdxWU2RCXwPeyjLhHzjEeOxC3Xhflc2YzxqEYTFPy
         YRb/OktTKI91w4j1fbq9WRxrl1Y7i8rI6mmqxrKoiBs1Ufqb3VUn/6ylUAIo/HJ1pBTv
         VUul4MalXyo27DTGChSo16GbKKlAIRf4IQujKvuxW1s33fshaWI/ggq0/NtGUBGMQxKG
         UJVHb+u4O755FB5/wD/ADHPco3i61M5D0ZjvviU9XYR8SuVBDHi+NIhfM2cPU2zMLAqC
         gQXA==
X-Gm-Message-State: AOJu0YzNGxQE0qF3yanSPsmmxX5T0GWRI50nQLSxpMbWs90irqgh/BFf
	VMqtcB+7qLPvM5ah45uPiNcaZrMv5KtDGGIoMDnwycpOz0B2FzfyQMIrs0F7rMlHFl8=
X-Gm-Gg: AY/fxX43BR7NUezieawUWxyL3L3g1EY6fQgHyS7DikyqrbYuESERkS4kjfLWtzDKazp
	YS03zkx5iM3iFlMJoVFzVS+4d8rJOgxh24ZYPDLKZ+Eq8gxTC+p9T90YDmH/6yKP6iATC2ZvkVA
	x66oyVZSBY74gmAAOEsdrNLCsFoTSCJtjw99rizyK3Fxq4+erPy2HnpZVnGOAHBiTnBGnCqt/yK
	LBsonaJn15hfDO/E6uym8GeRsSJKgqbwp0BIgkgGyl5DdS5m5rgEQa7YTgxa/FuYhsZXexwBvk4
	X1p63YDcyBiKWkb52SdHTQLRK6gDinqBGANrj4UgQ8TWuzhysK7GMlT82Qm30fKNLiemOpgv9ru
	JY6Rn9RK9FKB540vC56PjaCMDFhVdEDM9b1FtcuiZnqh9un2QYbqpWddJkSvDw9EoTSjf/X4ZDl
	n+Feh9SOI+5qU9Ro+WXDbK
X-Google-Smtp-Source: AGHT+IGymdzTOhM5jbelcMXcQ4KMKi4yIZCo10XakrCUVGapuKUtwGCZXcqj0byfMgnvUtzZVv51aQ==
X-Received: by 2002:a17:907:1ca1:b0:b76:bfa9:5ae7 with SMTP id a640c23a62f3a-b7d236bcc17mr232174966b.29.1765553586158;
        Fri, 12 Dec 2025 07:33:06 -0800 (PST)
Received: from e133063.arm.com ([130.185.218.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6498210ed32sm5433234a12.29.2025.12.12.07.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:33:05 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Fri, 12 Dec 2025 17:32:29 +0200
Subject: [PATCH v3 12/12] perf arm-spe: Don't hard code config attribute
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-james-perf-config-bits-v3-12-aa36a4846776@linaro.org>
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
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.2

Use the config attribute that's published by the driver instead of
hard coding "attr.config".

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index d5ec1408d0aec7e0d39a2cae7ad73694950ab67b..6c3dc97fde308cf4a1f289fab5101ead2765b140 100644
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
+	if (!evsel__get_config_val(evsel->pmu, evsel, "pa_enable", &pa_enable_bit))
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
+			if (!evsel__get_config_val(evsel->pmu, evsel, "discard", &discard_bit))
+				discard = !!discard_bit;
 		}
 	}
 

-- 
2.34.1

