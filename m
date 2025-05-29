Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A53928F52A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 11:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748518402; cv=none; b=OPS6Hdj0R5vT9wgx/X7SYMDmnXRhNJ9jH6MFwznnPI6iqD/az/NAbugH1M0JCMTOYQ80ySik102/UOkFDwDSnh62jMRPmqQ08qX+mZHwoAh+32rWJDnbD38TvxrPKymQQP7l0EDe3CbophobltAnMczalDlYRmHCLKex9693lLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748518402; c=relaxed/simple;
	bh=zvP1e+1MWcLi6dFHbap1BiJEf/Gwy+p9o8HThmnNJIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fACNnXH3/JMiUWh8xAw6R8b40kBNMLWrdXo50dO82b6U9wk5SZJa3REZ1bR54fzy/J7Pp/jPZIztj357EwSw89yQ+s/5qa1OcVmiqB+8W/eVq1HzSFFGuxc/BtpfBOvErdwQy6BCMcJGPyJLIFBA/u0SGbMHgQ5OO+Xt/VJNEk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wvVgcuA+; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wvVgcuA+"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450cd6b511cso5008035e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 04:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748518398; x=1749123198; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Q5mn8xtPi9u9sDm1H7ybxkZxNw4efqIccO1SNVExHM=;
        b=wvVgcuA+BdOAbJAq1FcDO4QE/WkBblcRUu7/mKb7FXqpc+zkCbUIoIAJEuRInY7FNc
         W5yI80pnk5kNbqos8HgaA/+U8wX4bEfDK8ttvmvABPINcOxOgOsedQuZkxxjNKUWuLmA
         AIDn3Ogi1YBNIN1I8YIYp2FaBPYwQeSFqamM2dG31ExILT2upE7hY9nKlz3yep8T8I2m
         Zp45j1wJ8ZfgvVeTP8nA9UfRPx0NHEe7r5N0dvh5aSOi5iDybU1QKbPBom08WGfZicV3
         Raw2RF5x5w6NSJbM1ynY2NI00V0A1wJzx3XQm0suw18zdW/x38F8z7CvRdfU4HcIMcu1
         BCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748518398; x=1749123198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Q5mn8xtPi9u9sDm1H7ybxkZxNw4efqIccO1SNVExHM=;
        b=sCaz+KdOt/re/Gn1BuyGRVA3obotTF8c3KNBlqXDRWkvJD688uSYu0BciYhbTnedPc
         Q6WmD0evbEOlbVC1T27U1MBsYXcwzYWF09yofrPOG+jBHmVFbGv5ouj+KZSp0KEesQQ9
         +zzN0kjpiWhJMr4HkuLvyjBi4xIPNsThxIjqHufVVDeYetZ0+rH/GKKjuf5hHYmag5mC
         ad9fL90kEjgPRuuMcRI+qL3VIy/dTgiQ+/4t2j0g4rYh+2Pv2fGd36ibKJ79BwTU/+1s
         Qcdtly+WmtBxMlEIkdd3q1H6NlutpPO0zrLJbjxC14TLAu3cnKvo3cUPFM5HIW1y2PiW
         hrEg==
X-Forwarded-Encrypted: i=1; AJvYcCU0wdVO5szV1hRTWkwiAywatlurz7htxpOHZiFFSWKhTs1IAuDTxtdxLFTlJw6jxLDV7vt3FQN4d71OJ9i1+oQt@vger.kernel.org
X-Gm-Message-State: AOJu0YwSGtRfKHQKJqr7rrHfOMuAT0DaSIUT+vMhPZ0idcpJwORy5qbI
	W3AyHdxm2RNZo+2DadH2Msc+JmDFPvl2eT29w1WeLdIyDP1p+yEFEIJa5Xo1bWuCIPlEQxquFYe
	fOmX0aHieOg==
X-Gm-Gg: ASbGncvO03t3MgMeJiGtZZFoMczSczFLVRedaNPVGjZXD+pzpuDFcFScVSEbJ813hk8
	6dfF1XSClRw9qGcNCtIcBgMCJS9G3MGTxMuKGPGl1PX8qDoq0k3/HAJLz1WSfmwn5jzP5HuFMcL
	bVFw6vhIs2f9lcIghZ38jbQPB/JZ1WE1Gk7zhoZDz37GYY1COPYl0K+xsdOYv044oFEfUCTQryg
	VieW3LYzPE5yG3qMLQMrEzjfSwvN0AfREKdVtXj0SNWNP0bGHPGDNdmhSVowPqxtVR3CDHjJDUS
	18CYJAkRMygu54OGdHIloAeyaaEzdYmhHJKZY1YZJ5Wkk0lrlsyLf0CC5J2OlCnTnywom4U=
X-Google-Smtp-Source: AGHT+IFacLMgy8Sgufz8crND9drSgOY6qRlCAWckmK5shHNZ9zSnAptuNxdT/H2WMCBvDy1/kfCobg==
X-Received: by 2002:a05:600c:1d8c:b0:43c:e478:889 with SMTP id 5b1f17b1804b1-4506b541d07mr59510265e9.0.1748518398270;
        Thu, 29 May 2025 04:33:18 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc3785bsm17443945e9.40.2025.05.29.04.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 04:33:17 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 29 May 2025 12:30:28 +0100
Subject: [PATCH v2 07/11] perf: Add perf_event_attr::config4
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-james-perf-feat_spe_eft-v2-7-a01a9baad06a@linaro.org>
References: <20250529-james-perf-feat_spe_eft-v2-0-a01a9baad06a@linaro.org>
In-Reply-To: <20250529-james-perf-feat_spe_eft-v2-0-a01a9baad06a@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, Leo Yan <leo.yan@arm.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Arm FEAT_SPE_FDS adds the ability to filter on the data source of a
packet using another 64-bits of event filtering control. As the existing
perf_event_attr::configN fields are all used up for SPE PMU, an
additional field is needed. Add a new 'config4' field.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 include/uapi/linux/perf_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 78a362b80027..0d0ed85ad8cb 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -382,6 +382,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER6			120	/* Add: aux_sample_size */
 #define PERF_ATTR_SIZE_VER7			128	/* Add: sig_data */
 #define PERF_ATTR_SIZE_VER8			136	/* Add: config3 */
+#define PERF_ATTR_SIZE_VER9			144	/* add: config4 */
 
 /*
  * 'struct perf_event_attr' contains various attributes that define
@@ -543,6 +544,7 @@ struct perf_event_attr {
 	__u64	sig_data;
 
 	__u64	config3; /* extension of config2 */
+	__u64	config4; /* extension of config3 */
 };
 
 /*

-- 
2.34.1

