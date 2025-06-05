Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DB32475CE
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Jun 2025 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120614; cv=none; b=ZNC1gwxWrEcsrZUK9Xid/ZpiklDv1OpuJaoVbScCJZTUlFSmqOp0kZqqsWlXpMfqwR3YWmdDqPk9hE0fW6ur2xYfYuZlNoEOscEvehCRIYPhCfOVPIDs8DW78NT/mSMaFSrQcJv4RZTTkxMhJxKh3KKTZXIJWzssXSs7nZDbJGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120614; c=relaxed/simple;
	bh=luIKfiwgtXeAFEj50ve3W9I2lyEw3hMNW0iXhyMCu40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IcV1Tdud+WoFRpb2eVTLqPsiEtcmfWCkjVOyaFeNOCo7yViMkpQD0mqzhMZfv51i8F820mc5eNM4Y/WWUtybpYolBhRBFdxp+hDwKDpkMZyQ8dmhaOIpqdFTDAt5Ezc1/P377maA5gx3CW2JfpKj974FdebVEluRe3wFaT1BQMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bm1uz5sT; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bm1uz5sT"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a36efcadb8so685154f8f.0
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Jun 2025 03:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749120611; x=1749725411; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9Rue6bPIg/trhgv/sEGIp6PJe+iLR+ZUbz2D5vC1ck=;
        b=bm1uz5sTq5EtoddzpljyGMCVBbC8YHEXXfgxedMh6EoEUnpmCJY52Tvch0iBi7H2kD
         Th5876eqIO8iv6P+uYzhV4wZXF2f3wUDBqXXE8ExzkA4U2PUo1nUfukEsOTS4whH3khD
         wCx9XSoMrV074tRvOwjNgREfbDYPehTCRnD8Nu65gSOmHq3kyLjlmI+zcC+6KPq03ZZG
         4UZj+DmtO7y7YjWKxdhetq4IwTVUBtfdWk1ZMHNyedeoPR1MhiVFdfYPmESBNJQJmfFl
         BEGleil1/7EaXr867vVzgKO1xOPdf+qZr1+lmE/BHBLl4CPyNSvOGtUUx+YOdhJZoPVU
         DVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749120611; x=1749725411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9Rue6bPIg/trhgv/sEGIp6PJe+iLR+ZUbz2D5vC1ck=;
        b=PGW6rYofgAyrY+6URV0AdtyGhYNZbBrXeabIaGVufTFaLVlUED0HNuGxtb1ocw628Z
         802diiXbvtZlB60K7pjzEllk7k48nafkW4/dSgblkw3Bfer2Y32NT8Um3JyMv8qeljOU
         7pK2j186OnImY0F+4EjMqc8Bbb4n7K4uZMJmTLvsjqNMqesccz5kj5cOANXXMDDqsdQg
         3EVyRhymQKlBbo+ThIG/16qOG2XE9OjarPYsMw452aNREWMq1FCu0PYBKIa2S3J6Pa4A
         lwOrbI7J6VLBavT0WvqiLGT8LoAIiZMq4C9SWZLmWswSpkhEfAIKsNeazQs4/w2CJIFZ
         TdUA==
X-Forwarded-Encrypted: i=1; AJvYcCX7xcVIadyLjCeuIsufQmXQkl5LDusYmLyYK5mAOnPMOvf/IQPxkH1VvNLV7NAXdakaaF4k/a04+2hig9OmiD5A@vger.kernel.org
X-Gm-Message-State: AOJu0YyZzqNdcEc1+N1kQA+6Mrdhx87HJebWx/Y0WJ2hGQ0Uf6zLJQlA
	udtpMwU72cHgVjLJdUrFGsqz8ef4RvBWMOdcDseNxaZAIA/mzOWHTuWF8zc9xVmw9iA=
X-Gm-Gg: ASbGncsviqPAgunYrV5sgT6rBlvMj1pdGCZ88Jew9SVMlKgSIIZLcP+8hi8WBCcXO7m
	szYbHPmcJdDogi1RKi4aeInIGXT4niF0Vq8KtD6ik5ezQamePcrsSBb6BjCocAFlfOjPX+Hjl3W
	7t+sOo+gU9D+MKTr6om2GTcWazRlJrW4XD8MKn83svL/EbC9zj05EMgukBfSsDI0GUQrXgY0flK
	faZZnsH6CFztNjKJ8uvMTqh9+FkKjgJjm5e+MJZflIoYBh6+6j3jksHK/qKJb1ZFn1/KU8XA4ee
	V5x70DHzg7NzMFyxJea0qGxLn9QmB3wmQHvjqbsqHNi1y1JBpBJvj5NMcMde
X-Google-Smtp-Source: AGHT+IGgu16RRFx+Y09hUhjKjxwfPfRayhA9cKQUsDuzGVsP3y8rnAFwlUH2ULqYWuFyxL3gPk8m4w==
X-Received: by 2002:a05:6000:2389:b0:3a4:deb9:8964 with SMTP id ffacd0b85a97d-3a51d91f899mr5503049f8f.17.1749120610702;
        Thu, 05 Jun 2025 03:50:10 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f990cfe3sm20629965e9.23.2025.06.05.03.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 03:50:10 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 05 Jun 2025 11:49:04 +0100
Subject: [PATCH v3 06/10] perf: Add perf_event_attr::config4
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-james-perf-feat_spe_eft-v3-6-71b0c9f98093@linaro.org>
References: <20250605-james-perf-feat_spe_eft-v3-0-71b0c9f98093@linaro.org>
In-Reply-To: <20250605-james-perf-feat_spe_eft-v3-0-71b0c9f98093@linaro.org>
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
 Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com
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

