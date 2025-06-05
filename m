Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640FD2147ED
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Jun 2025 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120607; cv=none; b=K9SV9vq8VQYgknIzleLpPAmfcizG/S/pfn/eswbTN+6KZ8J7JzS3id9QbIEq8P1nJ/T9Og6Hyk3pizdc+HyAUSC/lfqZatZfJvFGNT/6DgRPsGqV4WyC9qXkT7mwQYQnxzy3q+o4CI4DwVNET9Lp2oodVZlvPSHSfp1fzTwkuAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120607; c=relaxed/simple;
	bh=isf38v+uTebHr/0KouGZLHu/zXcyClycP3zhjgiVfZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mHLoEVcFRP8H6fs6TiqVfdns+QAzOS6AxoZHYVaWokyljlBRdJyab/geGOkghZDnGTfKZRPtkzSYVqbkrQ1GYaqPv6ym+YNLXeAkvcmwZjRLG+v04rD6Q22vQM825WMt7OApt4uHOga0egF7pgQ8sf9Inlp7mvurIg4WGaPZuHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eGsgTUNY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eGsgTUNY"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451e24dfe1aso6773415e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Jun 2025 03:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749120604; x=1749725404; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpkxTGRvQkor5ThWfPSfZfarMFvM1/zI/E944bIEcHE=;
        b=eGsgTUNY4P4xYxKNfpqtsNEVRXV4e6/ADyhy8XZhuxMDIJSI44yV7RmFgGbZS+LFxW
         m2m22yYJAjP8T4VHP1sjbThJ2XlQRGVkEU8xOHbbCUgnEz8jVipBh1sjTj9rvSoyu5xd
         K95GCe2GXMkvG+esfoxDgwoMsgRIhOM7UU63a3EkgusFQaj72f4VgcfIZOMu3VpGsDMx
         Rb72e8/VK9UFib2Hc9qwj1a9S8CNU4CH+gXDQzH2Fxmwi7Qf3r+t5eg6dH3ZDuj+zz1D
         FDDTmpQnJiFwm0j86SEssabhl+hDhIxczNwpikSeYSLFNjAj9hWHzhlryQUypaI+PXSH
         bjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749120604; x=1749725404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BpkxTGRvQkor5ThWfPSfZfarMFvM1/zI/E944bIEcHE=;
        b=SACTdAbwxSKudAzp57Z3arCN9m6CL3pX9WSXW1hYTuIAvmR1zFHZhZn6qWl4Y/DRQd
         iB0cA7oAyPNZRT+WRMz1oBGN6zrMNJg9Y9mCMhBgzW65OiegqZlWT+KQawTgOOHaUnxO
         A2bxGmtBgvNwADeAXqGLW0QMG5D1SGsZnEP+mHWksV169DnA/cwGBRQ/znWOVmwvauv6
         8eWbRGCXVVTyxCovjGCNp2D5082bJV3vOVB9bXONpLtZPoNWyiFIu0dVMu+IYk5cdbca
         m0yxl6OI6vFGBcbsce5wxCy6fKaC6Fu/llBI+Imyvfg3ml0fDnLcmMyKzTy5QShO/2Dt
         SaVw==
X-Forwarded-Encrypted: i=1; AJvYcCVKCQcm8YTcQicGvejQPhpsD7zjo+wZzJ/xFXWxlbIe0F4oDXHtlRsCKnnofNc0obCvFYsAP9JdO+ELlzbKMsEb@vger.kernel.org
X-Gm-Message-State: AOJu0YxJW/8m/hnyOTanQDEuFh+rUajwlFwSGRGkmqWP0Q+pVts5EorE
	l7XUsZbshRYwhMXVgsbuqRbh1FdgpcJBXdRy8ye73VRRpAtY7jIgBFLnChiVP38L/34=
X-Gm-Gg: ASbGncufYrvg2qGS3wAtAZa2HNrMKueO7iNaW0N4/odyt7YdNMG7qO5/+MBdAxd0dv7
	Izw28NxRDZ8PZ8VipNRbyRtPyY6wrmYMLxIKUaCyikCTonSk/xuCLUIup1WoCa7mnj/BqFLER91
	gRel6lWcsbOXIucGphhYJh/41d07x6Cwsk9e4QysIgAGZarIIpM5i9HRNjeaAC9XNN/3n9uN37d
	tBqJ+0yhozr8IZU7rGcwRwT7Gz4MZwWD3d02lmOXpnIS4wbPt7wsf8Cl07Aaf37mlv0mMfTAdZk
	kxDqJSEEaJK9xv2ne/Ytez8pAZOeAqiW5r9SgkJxEXlbyuhfRpGyBF8zzyIF
X-Google-Smtp-Source: AGHT+IGzwrshaRz6RzNc0J7tOxVdD9PJSTMnVH2Zjax7vPL/2HgFnaNJ3JtdmLcA1rgDpG5sbM8aDQ==
X-Received: by 2002:a05:600c:8b27:b0:450:d37d:3584 with SMTP id 5b1f17b1804b1-451f0f31013mr62452085e9.13.1749120603619;
        Thu, 05 Jun 2025 03:50:03 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f990cfe3sm20629965e9.23.2025.06.05.03.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 03:50:03 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 05 Jun 2025 11:48:59 +0100
Subject: [PATCH v3 01/10] arm64: sysreg: Add new PMSFCR_EL1 fields and
 PMSDSFR_EL1 register
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-james-perf-feat_spe_eft-v3-1-71b0c9f98093@linaro.org>
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

Add new fields and register that are introduced for the features
FEAT_SPE_EFT (extended filtering) and FEAT_SPE_FDS (data source
filtering).

Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/tools/sysreg | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 8a8cf6874298..2e897d8a4040 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2859,11 +2859,20 @@ Field	0	RND
 EndSysreg
 
 Sysreg	PMSFCR_EL1	3	0	9	9	4
-Res0	63:19
+Res0	63:53
+Field	52	SIMDm
+Field	51	FPm
+Field	50	STm
+Field	49	LDm
+Field	48	Bm
+Res0	47:21
+Field	20	SIMD
+Field	19	FP
 Field	18	ST
 Field	17	LD
 Field	16	B
-Res0	15:4
+Res0	15:5
+Field	4	FDS
 Field	3	FnE
 Field	2	FL
 Field	1	FT

-- 
2.34.1

