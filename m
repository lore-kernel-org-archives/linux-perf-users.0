Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB3227C860
	for <linux-perf-users@vger.kernel.org>; Tue,  6 May 2025 11:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746531764; cv=none; b=UXGmzrOUcX3oUcUPeUfGxUqQ+7GpPI1G1rIR96MJWopO7A3E7ECHT18exNDA9JYpLRradYsYrYD2gW0gi2qLWiG5hbUFxz2OW7/BGdyVWw9wZosgh+THN3EvsqK059RDuEoiIBuescsITfkXbtlGfiFpAzRpU1LtRRbynz0CO+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746531764; c=relaxed/simple;
	bh=1Orlrzff9rVR0JZWyMg++jiq5IsyuYfqKzNJU/EyCi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R5izSzMfAiXyYM4Dns59Sj2XggCKy3UjnPgsiirq7U8VUXJhyE919puamFchDbbTLBrR0qquYCvnu1p6O6hvX0YYQMBGEvVKphj+3L9ng87LNNb7YteY78C8ebKr2zVzoRJxapODOmicHTd2o+egk8kkzFB1FvjcTb+srWeVPUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=naVGkR5w; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="naVGkR5w"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso3526782f8f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 06 May 2025 04:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746531760; x=1747136560; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIZcQ6bjIvx3LOuJqJtvWPXqPFlWznoYfJ+QWY9umw8=;
        b=naVGkR5wXITAX+DRXH0/HMatroPp4sFAvgLKQDW+YyMzQgomcYaXm134m/E45LwtUK
         4g1+g7CyG8dGp5hKm5spYNAhLDlagNf8X3ghRt2IxWKaHt4NvX/7k2ihTdu9L9crfoiF
         lcYCWwFGfZ8oMmHMRR0XneEMGWORapIk/nhvYylxBM0E/gmKmC3zUtq+rfsnO49nja5X
         rvrpbZq9iVRzcVgZtts+hAyvR6UOODQPZqiMwY4/15qmjvvtD88kvPNTY2EQo352vL0V
         2KATzbUInukqyBz1OXwMZapXIenpZ8fiiczwJ6kxgG0jSy5uyarvJEHJyhZInR26R9y4
         D85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746531760; x=1747136560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIZcQ6bjIvx3LOuJqJtvWPXqPFlWznoYfJ+QWY9umw8=;
        b=ZPVvfgIG09GEMWCWpIdnxoIpiuA1viEae/XBTBjbyo2DJ69Q2FXVwsD5NSwQ1faoZe
         a7/x+JHdUmap6Z+hD7Lp9gDmwOGKSvEYMzw72O9admZkBaVHAUzA8n0bKyHeyHZuomZn
         xA5A/MWDTCJ359jcjiFy5JYVNIYA+icfw5BOxCWMgbCXfJ5ed52RrElYSv0owxPxVdbz
         QvpKaezaQxQchYCd2DVrPemlhIviiDbVNMlNZ6yzuqy9gNn0DJiVHrWNOYGgKcqu3l7e
         qIXMVAu0ifRv4BKN+s+VczSYbyQiJVJJYL/wxfEXYpbGkXW4un1IoGD2MgzeiF7A5SsO
         ZvWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4gQ5DrXam/rgAOSGWgp/I13gA2/fQdScm/WeNdlqRtqBh7TkfzLOICgJ76MqLh+46UggKjN5xDA6B8tMprTns@vger.kernel.org
X-Gm-Message-State: AOJu0YwpXC1Uu34wI1ykDdqrSlA8sudwVB8b5BryCN+lhIdzginvwrzX
	0QOZgw/31HPQt6szemghYe9LRpvlZKF2G8rr0W+vhWzvGOdN3tGLYLZOy4KM7hQ=
X-Gm-Gg: ASbGnct2BoSLw6Y36XoWx8rdK+CmqXn1Gpg5KU/zuNhvv3JAZzeUpbGNZbNa9GCL7BM
	PNyaOoofHR66jEDYNrg7/ZQJ18+2B5igrM4sD5Uy/K2uA2k2I5u8OI3lY3Qepn/bkXg+EUg2Qi0
	cghVNqfv5lyebQsxr/jDUlhK3HgHsRuonXgk+ZjAOgqTvF+AJpjL3YDt7l4+hfE6hQx5AReHTZU
	ACZM36OSUJY85NjOHxG8+9rEjO31SysssLoxx6sAVZCXRIAb+d3SCMp4JC4UT671wr8iz7JfgpQ
	E0j7S521Kup40WlRrRfJqAMJhxyxFEsE5/svvM6OGf7IDg4=
X-Google-Smtp-Source: AGHT+IFOd1IsGOuUERaKBF17xqjJD9v+resYFgda6lTrrEteCoMMOKMSD17uDHezFeocGMqRKvBkWQ==
X-Received: by 2002:adf:e6c8:0:b0:3a0:b1de:1be0 with SMTP id ffacd0b85a97d-3a0b1de1dacmr1217177f8f.31.1746531760579;
        Tue, 06 May 2025 04:42:40 -0700 (PDT)
Received: from ho-tower-lan.lan ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae344esm13198473f8f.25.2025.05.06.04.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 04:42:40 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 06 May 2025 12:41:38 +0100
Subject: [PATCH 06/10] perf: Add perf_event_attr::config4
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-james-perf-feat_spe_eft-v1-6-dd480e8e4851@linaro.org>
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

Arm FEAT_SPE_FDS adds the ability to filter on the data source of a
packet using another 64-bits of event filtering control. As the existing
perf_event_attr::configN fields are all used up for SPE PMU, an
additional field is needed. Add a new 'config4' field.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 include/uapi/linux/perf_event.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 5fc753c23734..c7c2b1d4ad28 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
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

