Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9712A33C533
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752803; cv=none; b=TptuLUSpaUKrPgVwkHfPgxgHw9XxgtOyEDkghwgzWMTv9oH+C3TdcFDH6g4havcTe8ifdgyERkja8fBEQqfrdT3wWDLis52qyHBYvLwkq0PEAfMVzvAcpP0myTB/iZaDJ12i5/3FedhKpF4xYlupgrobNbOxDUm55fiITegl0T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752803; c=relaxed/simple;
	bh=3yjrpHkX+aMdTK90nxuOJyMh4ajXQ8n+rTYB1GAa/ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CLH2jLs/YvEzSs/uYQHgLooZ9IIwFP6izeB4FXLZ8pDVq7/Derd7/QDzhX8Ki+8OScZAT5J//bhQJ26nt/ES3T8Vai3jdWCGz2RDzr5PJybVOIGpzpk/F2v3Ry3pNK2xS8uMa56MZkFQ0S0kMJPYgg+PhG8f0JrWUo5hRxxQPXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NuyVbyMP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NuyVbyMP"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47710acf715so20237815e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 08:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761752800; x=1762357600; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45z9IaVf3DvIHNyRK9bNlm2YHb8XHVPseevdKZOW65I=;
        b=NuyVbyMPFvRKCK0qEuY+x4O8NN1L75AsJl29v/pjW21LKD8/4Z3tQqXgnfhBMiFBZs
         MZwD4G9Z3zXL81sfA2DFWn8Y+qZTut4WfIWsS0lRGETv5oM+8RwoaEn2mRjj7M1NIYp7
         3yVAY9KiBsP2N43p8fkA0FHiz8U53A7JfTb9WUbnk6o33jr40fTQOUfYtR56ucFUz+/k
         untPNtn7lQbA3FJFqVkLm9HpuFQl/q0m1DETmhxf6SfGeIbJSmrbBaYwWgOQcEW/qu4e
         G2Et1uNW36oE9Q5oRQPqAz+XBqyqgz/T0ILqjI2/tDDZMPHmOPGswq+tf75NDZ0Cj+J8
         glQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752800; x=1762357600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45z9IaVf3DvIHNyRK9bNlm2YHb8XHVPseevdKZOW65I=;
        b=XaHlbMYgkE7JXJOtnf61Z+zIwzy7gzvx+iHOstmpMi9q5KlUoO9FLckWVsh8yFetpv
         iiUXBizg4Ogx2wQW+kjSKA0Fg82oV8Zj4/KyKXH/Et+7M+ovwDz/rYI2I6ShbO6yCKVO
         rYAfvd3ei3WvjeQZkAYdngTvYuzJWqc9Ff5qD9oDjz/ZU1smSKZczS4VZDYCzkL76oaO
         Tw0aG0dlsdqQELr7NFB1Xx/66WeMFk8Nevn0Z2irQ4286ElnovG15HP1lPf+yHyuyswB
         LPGxINFRyTu7Lgm6c2CyoeATptK1vesYn6/9AUA1UUSKmYrZEXmkNQmGv7t0sjDxT2wG
         UOmA==
X-Forwarded-Encrypted: i=1; AJvYcCVdBvhL004Go5R/q3La/GuD/ZBbkLlYpsREF5tDFHD/XDqMOXfrZY8Ca9tklERAYcWn/rAE95bXHIObH8adxrNA@vger.kernel.org
X-Gm-Message-State: AOJu0YxEamssjqY9SpLemPx0/TbRZrB1WjCrAIVP0Fln6UlS8syngZFe
	POhm+nHHiaBDJI+FQhx2fiQYzNeKEn9uyVBdVca90B94dxKL2vqFuYlOpubLYhQuExw=
X-Gm-Gg: ASbGncvSeBPEKNexaizMFDWOJffo9mxB44GhN/jKQhhqshfqGJ17skrIyM/S9h6sUhJ
	3nbkk/GPNxc3JlaVYir2FYQ62qKVQziJXOFzsmqQjDgK558rG+WYVFzoig2IIdoi/3t6qLhyoQS
	kZ95uFg6sRVCVueieCK7gGNnS+k8WRWib/Ih3lTkmQJYaFN4pj1wFmc78ENBaUHOi+7Y7pmJUTU
	l5huz/wPXJejhH1+AT8vHSWp671Y3eWtmgc29fb/RmDiCfnOMyMYeqlkwDUiaF5F1KkhGizMV76
	k0UPYZYq7s7C+9EtqfsdnHSz/t/W/8hLxO0EImNFg0gJtBQhPhXNBsEt2Blk+XL0fKhxSvH/9mr
	WrLvNH/k4glDALTUOYmDPgyF1a7P2bdpmAPBgwpXAuirbri+twPtXmG7d9thw3/7HwfSuUBpxCM
	U56LJEYWRRYg==
X-Google-Smtp-Source: AGHT+IFr7xoJyrWL0httFE1U9OU6ySb/0qu1huluXCe0kPZLPOso65sDtiDjLwsED64lDMpKMdKhUQ==
X-Received: by 2002:a05:600c:8484:b0:46e:442c:f5e1 with SMTP id 5b1f17b1804b1-4771e24b0a5mr30445885e9.35.1761752799881;
        Wed, 29 Oct 2025 08:46:39 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3b9994sm53745535e9.16.2025.10.29.08.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:46:39 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 29 Oct 2025 15:46:01 +0000
Subject: [PATCH v9 1/5] perf: Add perf_event_attr::config4
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-james-perf-feat_spe_eft-v9-1-d22536b9cf94@linaro.org>
References: <20251029-james-perf-feat_spe_eft-v9-0-d22536b9cf94@linaro.org>
In-Reply-To: <20251029-james-perf-feat_spe_eft-v9-0-d22536b9cf94@linaro.org>
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
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Arm FEAT_SPE_FDS adds the ability to filter on the data source of a
packet using another 64-bits of event filtering control. As the existing
perf_event_attr::configN fields are all used up for SPE PMU, an
additional field is needed. Add a new 'config4' field.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Ian Rogers <irogers@google.com>
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

