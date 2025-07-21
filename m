Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154F62DAFCE
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103124; cv=none; b=h00hOJ4/poCdy9+kXZNVD/2XITsG6TtmvjcTlPdaBodLxfdZE/1ODDaUSfSkBhK48MyXENvumhBzO4eVNKjN4jo99BP5chavhBHRUXHt9yJmFHSIRNU5y90Nx+7CDQaFIT/+bxGh8q4QPdgt0q2pzP6kpN2h35AZ5yeECUGlk88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103124; c=relaxed/simple;
	bh=3yjrpHkX+aMdTK90nxuOJyMh4ajXQ8n+rTYB1GAa/ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m000w5Z7mAmXMggbE5jj4ny70B8i3oU1OY2ZsM57sLPRJSUxQcSxh1QoETZzjO/9DycyxsTp/h53icVMRVtmVrp/mhrvZDlZUWdpLkA/eCP3+4R3qLjzZgrjzwG1Xrp6kIvDXdhzwtWngwAGi7AcV5ba5M2keRwINX1lI0L6KyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o+8ZXiqL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o+8ZXiqL"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45600581226so45096785e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 06:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753103120; x=1753707920; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45z9IaVf3DvIHNyRK9bNlm2YHb8XHVPseevdKZOW65I=;
        b=o+8ZXiqLRLXZX5M3emkvo3y3nwYFHiT+xAeP5lCWkA1tkX1lPvKNQXdoQDMx4UFoul
         U7kUGQoLkxAQnlrYz+9fPDuG5HQ0pC/z8GRfRSQEusmbwNPRyQO/AYGgdf8CyaBBlbzT
         0XcUOziZNR7fY83Jf2YLxfM2+tzYoYGY6e2J8teDjEYNxxkfVtTGa3cWfOwAeJOJpLFs
         F1eyfK3jzIyBLVb716H8s2+rz4D2b7sKijqKJCbKy1ooYWThtdxUbDen6bhnJLSuEmip
         1O+jekZKlJrehNe7G1RcsYpUR+IlOXHJyd/VorDjbdywo5BdzN4bdLmxaJxRSHDAUuYb
         zgBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753103120; x=1753707920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45z9IaVf3DvIHNyRK9bNlm2YHb8XHVPseevdKZOW65I=;
        b=NTIpE4D/HHrZ+uGUnQJCUWBETHhILcMCDxtjEzxzT01iTJ8ZOjeaWEMWcfl/Yug+Eb
         G+dOn0mEqsMYJEzYl1xbUJtwuqrXk/y8nRK1UWr6pc29z3eQPeltit9PLjE78Owv34FB
         +RHH5Qm3vTzmm5fyIPJxtRiM2/klT5U1qONpMtLqJ1XtkHAf/3J2EVvFpLgq/SsKSF+0
         8uPNAjeCdDFrNM1GCd1FCCDIWxaGWrUKXB6DGC/Uvgip+hB3sBc0Qr3ez1Nk3TuQxsL7
         PZQcRQc07KtKMH9FKVDp3wzAY/cum1odq6+sxKCApZQzydIOzeGU0Ry1c06Yaw5xa7B6
         2UnA==
X-Forwarded-Encrypted: i=1; AJvYcCXen2QW/liP2UG3c+e9WLHNdIXXwb439Je+ERUQNADCcuNOo32qJCrXxpHM94HfTOPxqK1VZo5Z7+ISYMRUI5nH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8y4LhFI+1tm56VtcyLGN39oBzX8X+aP34x3g4OF9wfiyCXSp7
	23fOszueBhHigkJG5BktfRsbIsFuojc+5MG3+kcbBXQ35TvaPRT7agq78a4AgLH+2a0=
X-Gm-Gg: ASbGncuOw4eo8dgT0zD0LsmcsyQvKJfF/fBVjUvrG9kx9sdnf8eh4W4g5oA+rEe2Veo
	O1ueuTUy0Tpznh9zYvEUEMbMM5yiRc6mFY6SIG0hAQvE4h4a+eVCwSjl5HKPnvbyX0wMUsdAVwC
	HZMw2kzigDZnQHwl1b84hpglME+8mslDhx43ls1trx+WVolGJXAy7vO3XWeu/nW2BCKZ8+OH2m4
	PzKcsUBHiZIa3YNqUFvSjlDahlBlr3mj/pm1Qj0Zwhuj0C90ehJQnAVnLSw4uJYDqKYzrPH3w8S
	rkjJbVRE2MsB9/QmHDgogTUqbjkMyH5zezTEChD5kSbeZk+hpP0HEsmvUdRTpRX/8iesjM467gq
	st62BPDePU66i+cT/vahBISd/1i0tYs4=
X-Google-Smtp-Source: AGHT+IHcC0WWzrKqr8+Igj35NnjWFuFj+8E1KaR+jWoua9xbcKUEBeLY4nnJZlnbhkk4+Th+Kwau9g==
X-Received: by 2002:a05:6000:4022:b0:3a5:300d:5e17 with SMTP id ffacd0b85a97d-3b60dd731c4mr16367288f8f.29.1753103120265;
        Mon, 21 Jul 2025 06:05:20 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c632sm10485077f8f.80.2025.07.21.06.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:05:19 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 21 Jul 2025 14:05:02 +0100
Subject: [PATCH v5 08/12] perf: Add perf_event_attr::config4
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-james-perf-feat_spe_eft-v5-8-a7bc533485a1@linaro.org>
References: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
In-Reply-To: <20250721-james-perf-feat_spe_eft-v5-0-a7bc533485a1@linaro.org>
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

