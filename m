Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55EB28F94E
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 11:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748518400; cv=none; b=lta0Twc5o0cis76gmPjYW5CcSLKXU9ljwJH8FToShFuNdTlD65GUJcNMtYt6BMjhYC0zd3TenSeKmp0Z4mFWZZwvyVpsp9RUrbcue42twt1UQs9ySjl2Qx8AmsKhRI8zoi+7zi9qEAVhoIoICFESbKBM4rbRKBsBuG5ZJhVevMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748518400; c=relaxed/simple;
	bh=3Nke7IrlZt1dIQrrtJZ35wZYJcBpZtgeyy0gHEfYDMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ojilvbmegevuNEgJsJc9ZgmEB8iMkBBd1RdiXzonewcsL3hZaIqecIL9HG4YpiRWty11IG9cynktRi5JmLIvcd+Q0dxePn8ssJDjbk8jXWBQ7friDA9UliEW4e1zEieg01PwfS/dlRSMQ7lucJOk6rm5MA58AblrhY/fTUr5vKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KnaaY6Tj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KnaaY6Tj"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-450ce671a08so5204665e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 04:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748518397; x=1749123197; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Nc8ucW60XE4Jn3cBqaPeV8SZm/My/nwOffHN5F4rVM=;
        b=KnaaY6TjR4AICoV2JJrqWG1W0pSC7v+0G8uQtLOhKzoHGidv8xYyDbaIE3NV6ecKIJ
         PIShn1HZ3xXuN5wcngBBy1IqHnBfgyh5iLEpHgz7s/rt5l2Ee3un8kdFSWP7B8R94b8G
         6bkChmSgAgI2Bjzc2/vIOLFvuVcezzx4q4ROlhLkPoWMdxABPA3cMi8f//BXKidjVbmS
         6ciRDuKwzqGkzpDfYKaAGpS0FggZw0jZKAEsE83h/fyyJSrsY+P9xFTC0DRBZgRjIth+
         CfLrKQeyGFHjf45N+X0BkbjHFuvxIZSD6vEBo8XyQ24CGgdUk4ciBpUbWmf+Qv+62Id4
         /69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748518397; x=1749123197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Nc8ucW60XE4Jn3cBqaPeV8SZm/My/nwOffHN5F4rVM=;
        b=J5FN6QmzbFeiBkWx0GaONvcV713l60/d5XODL1TcTSAjALEzFbmMQTN8xa3mhFHrFK
         6RRaVxnR6DlSapN8Hfl3D1i/zsE23N4BumVxiCkm9hyiiHkcSDbPL3nguv77MrClvCse
         YEK2vao9ilOsooTxYqtyAYdrDxiUI80rr6uNVTUjkMLzukiB42A2lPfH4lTJJf/oIIrK
         wBK1K+s3+TTQzFG+b6jq5QZnNr1O1lnab+QR1OZYYbzRK4G8MFdAjsd8/r+R0Bpcfblq
         eJWwX4mSif0YzxNWuDXy+o/hwWCKZPVWZgt636EN8wxJfdZVhHbRlwzhR6amUs2AO0ZT
         MvZg==
X-Forwarded-Encrypted: i=1; AJvYcCUCskHsLfi425lVIPItIdAWJY5aqZgWtYdJsKsdGABtkqaAy+RLjGcX3E66yUpeL7X+FOBndMC7Dn1nYBr0pSuq@vger.kernel.org
X-Gm-Message-State: AOJu0YxlX6pk+YM/9eOENULuezwzBsJnIWI7VNJil1kAaq6afq55JRfO
	R+1QOb78HLb4fmMOzoLPXLKtAU8HmQiOd52CcjunlvBZDdA9jHK/vK1bmAbZomYOmvhFCowYgHG
	WQExF0LNQ4w==
X-Gm-Gg: ASbGncuCsTKhQrla0YZGa+EP0JITZnSKbRwA3ypk0ulpFsabgfvsJYF8EDVAKrZr8GA
	rTRhYFA3Gn5G7OLzoGn1Ao9gZB5VDYJTjgMywf0yY3o0opPNZvBWdsyWLUJ/6sk9LSU5ohWHMNb
	/jQfkmCFK2GHVWzfdKoV/KXaL0qhEuSYqHLgWDMzeLNwT9/qsMjrNQkT2QzNhF8Eif401t2i9OA
	4jGjAnPnoRR3lXFSVpRZ4Ms3uM6696c4AIQ84/qp/3jod57hqNeOUlBKPCcJOFoU7WmKA/XQLm9
	oc9fYICZCRogFOP4CfqScodbcmoy6HCLAtUF1Ru37juW305JePPd43AUGbY9
X-Google-Smtp-Source: AGHT+IEKUlq+VjysuU7OFlzmN9WWwVOAQRlwZk1C8MZ05ufCqPWjkB/S4hXmEcNWVtw0X6JufGjbcw==
X-Received: by 2002:a05:600c:621b:b0:43c:fffc:786c with SMTP id 5b1f17b1804b1-44fafbf883dmr95464645e9.19.1748518396915;
        Thu, 29 May 2025 04:33:16 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc3785bsm17443945e9.40.2025.05.29.04.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 04:33:16 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 29 May 2025 12:30:27 +0100
Subject: [PATCH v2 06/11] KVM: arm64: Add trap configs for PMSDSFR_EL1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-james-perf-feat_spe_eft-v2-6-a01a9baad06a@linaro.org>
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
 kvmarm@lists.linux.dev, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

SPE data source filtering (SPE_FEAT_FDS) adds a new register
PMSDSFR_EL1, add the trap configs for it.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/kvm/emulate-nested.c | 1 +
 arch/arm64/kvm/sys_regs.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/kvm/emulate-nested.c b/arch/arm64/kvm/emulate-nested.c
index 0fcfcc0478f9..05d3e6b93ae9 100644
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -1169,6 +1169,7 @@ static const struct encoding_to_trap_config encoding_to_cgt[] __initconst = {
 	SR_TRAP(SYS_PMSIRR_EL1,		CGT_MDCR_TPMS),
 	SR_TRAP(SYS_PMSLATFR_EL1,	CGT_MDCR_TPMS),
 	SR_TRAP(SYS_PMSNEVFR_EL1,	CGT_MDCR_TPMS),
+	SR_TRAP(SYS_PMSDSFR_EL1,	CGT_MDCR_TPMS),
 	SR_TRAP(SYS_TRFCR_EL1,		CGT_MDCR_TTRF),
 	SR_TRAP(SYS_TRBBASER_EL1,	CGT_MDCR_E2TB),
 	SR_TRAP(SYS_TRBLIMITR_EL1,	CGT_MDCR_E2TB),
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 5dde9285afc8..9f544ac7b5a6 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2956,6 +2956,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_PMBLIMITR_EL1), undef_access },
 	{ SYS_DESC(SYS_PMBPTR_EL1), undef_access },
 	{ SYS_DESC(SYS_PMBSR_EL1), undef_access },
+	{ SYS_DESC(SYS_PMSDSFR_EL1), undef_access },
 	/* PMBIDR_EL1 is not trapped */
 
 	{ PMU_SYS_REG(PMINTENSET_EL1),

-- 
2.34.1

