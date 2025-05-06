Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EC927D762
	for <linux-perf-users@vger.kernel.org>; Tue,  6 May 2025 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746531767; cv=none; b=A/PqhLVK3FI/9F1nCg7PTwGIJ1l6HAz4T2kDdf2Xl8DzU1OjDMtuC2TCuB8WBq7ENTEGS3ILZ+Kvr01s7LJOVzMHuMGb8xQShiXXkM6iVDmhdV09RMmFA1ljPgxP+S7HyBcKkvNIshkRBGYDfWf/aV/BcNU11xF0QHIYg6RlUk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746531767; c=relaxed/simple;
	bh=8OmkHkCGDObescNOkagm9A47Swwu3NytmSXnqZHoHGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hq+Lw9Icy1vNY1KJdlK56VVQFOXBSPDiYgvurXzfMlfQ5YkopdnMNHFm95KlJWGhpwsCRdmi0MJvZQ9vgtCKSpu0mQsyPCZCF9jXwP/r5J43T1k8Ru7J/KrWbk3ziMld8dVR1pvinhPerwg/Bq7fXuvdjJ9VoRT0wIxySSyeHY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TBuZ8Uyx; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TBuZ8Uyx"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso5935439f8f.0
        for <linux-perf-users@vger.kernel.org>; Tue, 06 May 2025 04:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746531763; x=1747136563; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfK4D8WXXHfk2zwldWwUzY+IJqnsgpS7YeB5hPDSAiU=;
        b=TBuZ8Uyx7arDpv7h3pSq+sMHhJoH3aHoOUQBmrp5wr3IuvoGb41tap7KUYcTALTu0e
         s4V4FC2vY2xDFHpRulSYfIlB+Xc26fq1soeNjaIzofgGCipD+1xwIatkDJJ/aA+FdxsX
         GpLZmbTheiYMtZy+WiY5CYqlYJFEM+Y1yJtygAgV7vgTBBZ6ny+Vk7h00hlmbFlI6sQU
         ETZDe/cXBdDEQ4XlsFqlIdiYVSRlh6fXsNDqoeNRLcfIXKkY1PLMH3HKWYXd+/a7JIkm
         nCuCTLfHFNHPXrKa93wM9hsCkMVd2vL8OTgFOlGuliGxkIvJUkJw1bk2XcXsuNTIF5qB
         +Wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746531763; x=1747136563;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfK4D8WXXHfk2zwldWwUzY+IJqnsgpS7YeB5hPDSAiU=;
        b=NuJKBElHroYilhsec61uQRYYXwvjgN8rvtJ1QvIUcjaLScOqcovxfFaXaFVV7++I9H
         bYskDvhn/WVVGvJU8ZNI+QYWyn7wS97O665TN9wBJUN0j/32F1zQH2nAZ/Zo4l0kB4yT
         hIFwhOYTUywxYJ5bMU7xumiPl/nVXg3BWfbB/X25PL24qc063Cb8oB40HDzT0aH3jaCG
         Q6uLjG5OcoFVsMRB7uvdRzkK99RUFt6rh9qn4iZIR1tHG799oyfBlDWIPf23s3EoNDRL
         /tYS1QvsEzq3RClvmBT7uvMnLUsteYl7SxJAaldyHPGiMIv61FUbvWNQBdP2Ymmgdehd
         LM1w==
X-Forwarded-Encrypted: i=1; AJvYcCVxvJ7lxNT99jR8PQ2lETA9lTKfc1qhfDvoB/G4362aSrtW23aUe5SxiaO7kXWar7tU1kDg+yBQqNgOeDaKvdZ9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/SRRiYor/xXfujjehFrcIa9+kk7nosy1JnK4OFEKRlfVl+T5h
	/MrfjpBV4JufxnAUiG1zVHQU0MRYQoaSIBTuZnFsT0iepEXmQev62GLg+vkPovI=
X-Gm-Gg: ASbGncv8Sz+psRes8V3JOeCLYowZeE/aZ9R0MDvES8fLorOqkqNkCZBgYUJJXExKYbW
	Epy22bzarEGsNmNpW4xZ5rp45fJFuACd7mG8ohzdQKI2pETXI7SpVCVF0QYPfbfIWoyNmkfTvlf
	fXL314B/ZNTGPWL0NOAX/IHe4B6OOcKx+YA8teNtdnEXvReyRnBCih3GbgStqeF30NlPhUI42Ji
	H899aNuXs/SqsT6WPdhXIha7OdYxW4MiyCXLY3UjyNbmB7BbfsqTFzJWVdwTvxg0FBJE3d9/9Pb
	KjsCR3kR4a+/ZeFSDUU9BFf4BEsLRlQ0PpuVMH81Pjhk0PzY1ZP4eZpLcQ==
X-Google-Smtp-Source: AGHT+IFxzoHVTs85nB/2QCYX1+sgmEItPPt1ggabHpBdb5kgred/4/pK2CDSumpwJgEYOUOvr/4oog==
X-Received: by 2002:a05:6000:2407:b0:3a0:82d1:f3c2 with SMTP id ffacd0b85a97d-3a0ac0cb13fmr2410966f8f.10.1746531763203;
        Tue, 06 May 2025 04:42:43 -0700 (PDT)
Received: from ho-tower-lan.lan ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae344esm13198473f8f.25.2025.05.06.04.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 04:42:42 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 06 May 2025 12:41:40 +0100
Subject: [PATCH 08/10] tools headers UAPI: Sync linux/perf_event.h with the
 kernel sources
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-james-perf-feat_spe_eft-v1-8-dd480e8e4851@linaro.org>
References: <20250506-james-perf-feat_spe_eft-v1-0-dd480e8e4851@linaro.org>
In-Reply-To: <20250506-james-perf-feat_spe_eft-v1-0-dd480e8e4851@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, leo.yan@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev
X-Mailer: b4 0.14.0

To pickup config4 changes.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/include/uapi/linux/perf_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 5fc753c23734..c7c2b1d4ad28 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -379,6 +379,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
 #define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
+#define PERF_ATTR_SIZE_VER9	144	/* add: config4 */
 
 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -533,6 +534,7 @@ struct perf_event_attr {
 	__u64	sig_data;
 
 	__u64	config3; /* extension of config2 */
+	__u64	config4; /* extension of config3 */
 };
 
 /*

-- 
2.34.1

