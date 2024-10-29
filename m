Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C511D20650F
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212678; cv=none; b=GzngKgb7tUNTtI7RZ12CFHlIq28k101u5gZ+yqNsNEUBccSfE267v60TuQE964crYp8FyVji3xKmLy8D+LArVMNAGWDAb1TZ147ZGvV3o5Lczs6oziUbS36+VscFTJXKriXslcVbqLSM0ZesHe2fzQPcM85JBMTZCPhgTTnghnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212678; c=relaxed/simple;
	bh=bEScwEWiqq2SyAs+udWbSB6iaFIYmaDXZrFvn7FMFCo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O83ETVOxhEAezTC1TWtLmGNvbkIGbPiUjvjY758EK2LD0Q5qSIGedYAgbYTd/fRKlWEeNAYDVZc4ihYDLCs37nhkRKoujd2EsBRhkq2wwYRCkvAe4+8Q8Vwgj0i/m9eDKxsTo1f3SU6BokiUOPTUfu0OXu4W9eEsTe8k2Ufrhj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cdPJ9WBx; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cdPJ9WBx"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f72c913aso7213055e87.1
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Oct 2024 07:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730212675; x=1730817475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fU7cyGBfooFNsBX8MqWStdGjWRAG+XFOSb3+XeN3B2Q=;
        b=cdPJ9WBx0PqTMS+crHar/VAoveTp7msAsYuSXvmSMQ8Q8bLKRmAAFVXCqVirWgMbGG
         SS+YnZVIVJmX2qrw8qAsnR3+sGTpyoHGL0ZOUYYQU8sCHpgDxUsguaCi83nEkwxBANAt
         ep2i7ZhKNghdP7ZUxNTN8pou98pyt/8j/7qkxIZg6NLxGRtELE8M9JPH5RuaCybt+UKR
         SkIBkRonHtyJ56NpGNAU90UUX1Sxxd10LENrOV/h/LCTDK+PZeHn9aq6vM/tuos89vwr
         xUR2zbvWy6MOVMRkM1qgWd0W53MluqjWQmwB6Q0cPwLiUkCq1xpEU3oPWjMtcmWvL9Oi
         pA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730212675; x=1730817475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fU7cyGBfooFNsBX8MqWStdGjWRAG+XFOSb3+XeN3B2Q=;
        b=cX2tNg1ZQIXtSPnnyJfqOuHcPCAsyUJhyrxvvVMVi8tpVIJYG/CAhDzwG6BjrnDEnC
         kaaBj4Oyt5VlVySC0vfqOJUzruXrsagjZ3fzlt6NFgyZBY/sjRjtlOo5LJwI3vp+t8W5
         B2QV7amJwcnQYnSCKqBANoG5lwGN2eqsC1TaZP/4FQMk7m3tehC0ALSlTLaQVPZGYZXP
         OpLnSyIBFaZXeHKizT8te1Yx3aSIXGvNIoObajjEmqmduFisrQcC0vq+FiOO6Fls7N0F
         5gFJEhlz7BleI5V4V19TmeKPaA7z0xOQi/JvjuhXFHWDKN30WxJKCmbMnRJS/n3hhj46
         VNVw==
X-Gm-Message-State: AOJu0Yx+jKLlYogVmVaix6Qmxr+ywrlOKMPKK9I/1X3N3OGUPMlUNoEw
	hnV2WfJ7NdycNlmFRdUkRb7sqbc0D5hLpTTnVCN1VUO8poerV3MUbOwKhTXwA9fRhxPecnYjKl9
	fc+k=
X-Google-Smtp-Source: AGHT+IGcubgmYg8gT6lXgSEjMqbjB74jbZ3p18R/hr4YQBD8lqBWu95UmeIvYZfd9U8KseVfDpuE2w==
X-Received: by 2002:a05:6512:3e1f:b0:539:eb82:d45b with SMTP id 2adb3069b0e04-53b34c41d5amr4316658e87.56.1730212674909;
        Tue, 29 Oct 2024 07:37:54 -0700 (PDT)
Received: from pop-os.. ([145.224.65.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431b437d362sm27554455e9.0.2024.10.29.07.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 07:37:54 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	leo.yan@arm.com
Cc: Ryan.Roberts@arm.com,
	Kiel.Friedt@arm.com,
	Julio.Suarez@arm.com,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf arm-spe: Use old behavior when opening old SPE files
Date: Tue, 29 Oct 2024 14:37:33 +0000
Message-Id: <20241029143734.291638-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the linked commit, we stopped interpreting data source if the
perf.data file doesn't have the new metadata version. This means that
perf c2c will show no samples in this case.

Keep the old behavior so old files can be opened, but also still show
the new warning that updating might improve the decoding.

Also re-write the warning to be more concise and specific to a user.

Fixes: ba5e7169e548 ("perf arm-spe: Use metadata to decide the data source feature")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/arm-spe.c | 50 +++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 856cc36f33d7..fb5ab8607b64 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -546,37 +546,35 @@ static bool arm_spe__is_common_ds_encoding(struct arm_spe_queue *speq)
 	u64 *metadata = NULL;
 	u64 midr = 0;
 
-	/*
-	 * Metadata version 1 doesn't contain any info for MIDR.
-	 * Simply return false in this case.
-	 */
+	/* Metadata version 1 assumes all CPUs are the same (old behavior) */
 	if (spe->metadata_ver == 1) {
-		pr_warning_once("The data file contains metadata version 1, "
-				"which is absent the info for data source. "
-				"Please upgrade the tool to record data.\n");
-		return false;
-	}
-
-	/* CPU ID is -1 for per-thread mode */
-	if (speq->cpu < 0) {
-		/*
-		 * On the heterogeneous system, due to CPU ID is -1,
-		 * cannot confirm the data source packet is supported.
-		 */
-		if (!spe->is_homogeneous)
-			return false;
+		const char *cpuid;
 
-		/* In homogeneous system, simply use CPU0's metadata */
-		if (spe->metadata)
-			metadata = spe->metadata[0];
+		pr_warning_once("Old SPE metadata, re-record to improve decode accuracy\n");
+		cpuid = perf_env__cpuid(spe->session->evlist->env);
+		midr = strtol(cpuid, NULL, 16);
 	} else {
-		metadata = arm_spe__get_metadata_by_cpu(spe, speq->cpu);
-	}
+		/* CPU ID is -1 for per-thread mode */
+		if (speq->cpu < 0) {
+			/*
+			 * On the heterogeneous system, due to CPU ID is -1,
+			 * cannot confirm the data source packet is supported.
+			 */
+			if (!spe->is_homogeneous)
+				return false;
+
+			/* In homogeneous system, simply use CPU0's metadata */
+			if (spe->metadata)
+				metadata = spe->metadata[0];
+		} else {
+			metadata = arm_spe__get_metadata_by_cpu(spe, speq->cpu);
+		}
 
-	if (!metadata)
-		return false;
+		if (!metadata)
+			return false;
 
-	midr = metadata[ARM_SPE_CPU_MIDR];
+		midr = metadata[ARM_SPE_CPU_MIDR];
+	}
 
 	is_in_cpu_list = is_midr_in_range_list(midr, common_ds_encoding_cpus);
 	if (is_in_cpu_list)
-- 
2.34.1

