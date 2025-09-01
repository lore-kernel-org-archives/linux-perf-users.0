Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BBC30DEC3
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Sep 2025 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730513; cv=none; b=NaiieTitnKXRnl6oY0MF/R3XXPg6Ax+qybHr9JzSrxO1pw3Hk0UI8waktImKkwiP5Z92kLB/KONBVzgmMM/ffTHbtgzeTBq6IP8bR3uI929iqoAOl5KKo9xKRJ7jFWPJRAI2SBLTQBnESqPLE6nBDEeCVyMU3/CsjZosk5e2BgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730513; c=relaxed/simple;
	bh=51vdVVrDG2YLBYS3Pf8NCD6LBuxxPOs+8V116Ol8P34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VjCTEbWMEglMFaMU4a4bzoXErqcnloJbQ7ueLgxzVhAQpKbdoWvS38DULuUEj+oooIJW3/H0NGL/DMmylZHgju+FxsMUl+nc78YWYiStfaFiSEA0+XrP5J56Dvlnp7l2ovfI5CyLYCMWUSU5V4HjZ6O/FZCkCvZZRBbFotOcFeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KSLJ8OHF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KSLJ8OHF"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b7c01a708so13932385e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Sep 2025 05:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756730510; x=1757335310; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CE9jiANI0cz/l/cDSr25IEHnZ3OQaeUcRCYLlwFZaDU=;
        b=KSLJ8OHFtKsK31Tw0zIpqb4zGK/GIZkebUUsXm04g/yN7z9rANcdK++IHl2GGgvR10
         VbKsEwO8pHlpyPDc/onLGlRyKyOKpO2Gz6gH+T7kITDRZnkXHl1E/HvHFOA3zd15KS02
         3DEE82X6JnAEVkaRLhdCDPBagc/MaeBwykBJzs3Be6WfQheQwQ7Y4Bqn8yWzPFzDJ+Sk
         WxTtZhIotGOdpb014s37v+pWQlBBEjSMnJO5tMbShwijUZNNkiYStI644IBez0UUY3Hp
         inSCquu5VgIn990JofdVJiG1vCOQ41AlylV47uLclxeQal0tNCIj+nxv9BUWVfsDtSUH
         Q8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756730510; x=1757335310;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CE9jiANI0cz/l/cDSr25IEHnZ3OQaeUcRCYLlwFZaDU=;
        b=i6isS+SE8WnyYneMUCwzuSId7EzBGChxRiThBifV/PWM1OvTZe9ovzxu1phvarYJu2
         Dyu5T4vDw+IH6UoEt/omnUhy6ZjAMg4vnvtK+F5XEv1MIUr6RXqxApIsfFti4OHmK8Cp
         snFe6sWj4cX4k1OBDjo05V9Wz4BDHUrKo9A5ekjEliCmte28uZn+nU2lqs6qsM0aqIpK
         2up9smt4JqtXKQlaTbEMw/9z+v0Ue0RYoy/Z8Aww3AEe98LLchQLQYQOaCT22gZ2jctN
         H5vrdrYycysdUGJwJfiLcI/ZHfYtJAjdlVukDnXGHtdyO3hsQ406qmuuUHOHDHVuSHPQ
         CoiA==
X-Forwarded-Encrypted: i=1; AJvYcCUofnFLQDZmxWYOtL/m6o99uihi0h/aKEs0DM9m/hCiiK+SvegzCK9Y1CXgiU1TL85U/DhSWhGDvr1ytaVRUCbL@vger.kernel.org
X-Gm-Message-State: AOJu0YwLbK9SMld/+5OuzJYY82VcZu2dqxBxQINQq+kuHCbU7ncS8yyV
	rDZM8Z4D3+8Qvlobw5tTMuPSPkD5HlMiKSKB6/br4KMzIghG78RM8iHIqiGBDb+Ellk=
X-Gm-Gg: ASbGnctOMiELbxPNqcBhra06urSfmIFp2KO58Sa01HJ07HCe5WkHfc2mvu40q1WkKYV
	oFSGVQlHvdvx0QPjePm69xg/BnIb0f8CIYN1SvWtFpmL0rbzGv3zS3JpFYLQMvgwcxYBtIexxvK
	6UGIlBjmnSID0vW/YwkvWxcGbVj2dEcJiMgo2nrwf7bewy98zy/mFfMUZJgs65V/NS7vptQdzh+
	QV+VVZhwYttlsBzu5n5tw1AZwYFZDs+8DkJznVGw8usVISkz0skF/ptGoV15aTjuDL0M/pfsP4m
	ZD/o4vi1Tnm2StkmMwvW0Z6iBZivnelNqNmvJT0G2rD2fw4EY04WO8fA7ZYug+v+pKkwyKz+5er
	Yq0PZA8tvtCywM6fAzC/JBzdAkVDvTlRz17YIL1vTFQ==
X-Google-Smtp-Source: AGHT+IEpKxBP9k/vYtw8Ht1MbnsTYjDO7wEj/uW0QbGaAjhmSNIBbT3ZI/wMtrWxLNIo5Z9MYwmVUA==
X-Received: by 2002:a05:600c:1e89:b0:45b:88c6:70a2 with SMTP id 5b1f17b1804b1-45b88c67360mr50627485e9.1.1756730509844;
        Mon, 01 Sep 2025 05:41:49 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e898b99sm154946315e9.19.2025.09.01.05.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:41:49 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 01 Sep 2025 13:40:30 +0100
Subject: [PATCH v8 01/12] arm64: sysreg: Add new PMSFCR_EL1 fields and
 PMSDSFR_EL1 register
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-james-perf-feat_spe_eft-v8-1-2e2738f24559@linaro.org>
References: <20250901-james-perf-feat_spe_eft-v8-0-2e2738f24559@linaro.org>
In-Reply-To: <20250901-james-perf-feat_spe_eft-v8-0-2e2738f24559@linaro.org>
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

Add new fields and register that are introduced for the features
FEAT_SPE_EFT (extended filtering) and FEAT_SPE_FDS (data source
filtering).

Tested-by: Leo Yan <leo.yan@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 arch/arm64/tools/sysreg | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 696ab1f32a67..b743fc8ffe5d 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2994,11 +2994,20 @@ Field	0	RND
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

