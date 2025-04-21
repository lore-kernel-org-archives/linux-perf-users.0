Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B263D21B9E7
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Apr 2025 21:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745272713; cv=none; b=sZS6rAL6lbf2MQtDOrsAJKmuCkaQ9OqAlQDDKoKXzOdoLeb6IL2lCrKrcTqtUM32PVg3a4HgDdalrAFjYFXrmBvq+9C9vJ9b4n2ISlC+7tLnTfjI6YB+yzvQfDpEf+xlHwS/aWZpfAvZoaXvzFIb3/CSjm/eWWJBRPj7QAw+Iw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745272713; c=relaxed/simple;
	bh=nMgu5glmK3F7QNbIg1QfyS3VbDIbwgjVcwChkm+gctQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=En4V6mjL3puhYifGLJtWI9YFCyt7Uo6gVrkkQB2tZYS9iv/2ht5FOB7vjMIs2zoFh1nO7JkcL+lmSd3QNyPE/VrlUSNUNhU898btVxF8xRW0yM5ehBGwA0CQlNOmJjyL5cK3+5RvEV2u1P+Eft4Wl4KXMiGyOIRLBvenk/3Q+gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M6uXK9wq; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M6uXK9wq"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2254bdd4982so67585585ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Apr 2025 14:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745272711; x=1745877511; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EcpcuD7anqMhhZmchi1Jj15ct5OGdKXSmJ/UTKESh3w=;
        b=M6uXK9wqqNfx8zKsUY4mjCLKP5aUKmT/hawDTTKj3/diZcsikN1kXlUFxHLKNsrNr6
         kk6rF5zWUZzDZIl7vCbSASDNtOu5xqmQWgRCQamKnLLyDEhaEbmLrc+lS785ZyFIHQ14
         42mYE7AFg2VLJ+RuJiqzSnf0fgkujYp9Fve7WTs5OMmMyO41jjoi4IIJjbwGehaGMKpR
         tuFPfNoYZzeR+TTvO2ikWACA6yHYBhlxWvxeWhSA3Ft2nXIgBgg1rIG4SjJ4Z7tOjyz0
         L5JJ3SiyYHQ5RxqRTJEWjjgBMdpb/7Pigh/x6XkMJ+3J5TI7x5Qvkvms3q9fErVF1S3H
         wYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745272711; x=1745877511;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcpcuD7anqMhhZmchi1Jj15ct5OGdKXSmJ/UTKESh3w=;
        b=wTeXgXRwwhW85GNSW+34xlJuL6YNB/PTIdtYH7Qo2T1qyc1QA+3bVPxpm0mlCE4AW6
         dFa6+miaMQ4Ggk+js8WENhNWDF8t79YLi+/D2GAvuxPbeGtLiE5KZjtamy4IwSFy+hb1
         ACvyreENIgCQ8BBEBGzrREHiTFXxacLMRwPBkJ6ovHVNdhNEIkUTrf1U5ox6l1uj0EkI
         IZ3k5/RPQYZS1dFJERkQyfVxOGAcuS+wEc35h7W17SB2Dljf1CwEAzNwWEBuroxJme5i
         Tu5ilBflWJFXiq9M3OKds2L0rZ5kSPV4wz91Qe5oChNvIpQFEK4QGhUAJcNbywKEp/Nl
         qqOw==
X-Forwarded-Encrypted: i=1; AJvYcCUpZajajSSfPrTzXpF40N94zls2tfVAqt+Vbf7Id0rQIW6djuYPBeY7PgUhuLso1OYWrhCE/RxwUbuhRpA2PYsi@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4N47/EYGdPr6VM5QPkPxAP+5TZXDAcq7DurkhZ/zHrEqDR3aG
	Spu4s7x9fOMeM5kFEmK2w7ju6/22yBdAC/bmwMBFnMA1i7O35GFrsxhno3qY2dP+H6whbOYBlNP
	B
X-Google-Smtp-Source: AGHT+IHXIs/Ogd7Xy1uFo5InHHYWM0p69glnRQCeqAR959OOyLerqEP0Pnb8KTz0VXSe5vCiUYWbcDZdU/s=
X-Received: from plsr14.prod.google.com ([2002:a17:902:be0e:b0:223:8233:a96c])
 (user=yabinc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce84:b0:224:24d3:6103
 with SMTP id d9443c01a7336-22c5361988bmr204811505ad.35.1745272711001; Mon, 21
 Apr 2025 14:58:31 -0700 (PDT)
Date: Mon, 21 Apr 2025 14:58:18 -0700
In-Reply-To: <20250421215818.3800081-1-yabinc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250421215818.3800081-1-yabinc@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250421215818.3800081-3-yabinc@google.com>
Subject: [PATCH 2/2] coresight: etm-perf: Add AUX_NON_CONTIGUOUS_PAGES to
 cs_etm PMU
From: Yabin Cui <yabinc@google.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

The cs_etm PMU, regardless of the underlying trace sink (ETF, ETR or
TRBE), doesn't require contiguous pages for its AUX buffer.

This patch adds the PERF_PMU_CAP_AUX_NON_CONTIGUOUS_PAGES capability
to the cs_etm PMU. This allows the kernel to allocate non-contiguous
pages for the AUX buffer, reducing memory fragmentation when using
cs_etm.

Signed-off-by: Yabin Cui <yabinc@google.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f4cccd68e625..c98646eca7f8 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -899,7 +899,8 @@ int __init etm_perf_init(void)
 	int ret;
 
 	etm_pmu.capabilities		= (PERF_PMU_CAP_EXCLUSIVE |
-					   PERF_PMU_CAP_ITRACE);
+					   PERF_PMU_CAP_ITRACE |
+					   PERF_PMU_CAP_AUX_NON_CONTIGUOUS_PAGES);
 
 	etm_pmu.attr_groups		= etm_pmu_attr_groups;
 	etm_pmu.task_ctx_nr		= perf_sw_context;
-- 
2.49.0.805.g082f7c87e0-goog

