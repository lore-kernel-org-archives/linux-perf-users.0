Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B0A2EA72D
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Aug 2025 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163562; cv=none; b=BFdocJb+/UoQ7/MrG/jtRoZPQCvNOSc5NwgzjbDWsJtYHe0j8dGQeXju+AwvjsHKf7vufzUzkWs5JMx8d793qbitmbdEWStR6U0HzJYhPoMIIGhOTeJ79lQ1YYebpNa6AmB+O0eOZ/5MJrVLs8SeFcW6WZ2W9FgZlYYIMhnWv64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163562; c=relaxed/simple;
	bh=51vdVVrDG2YLBYS3Pf8NCD6LBuxxPOs+8V116Ol8P34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FpQI3HiCfs6Jke35jisJ9dtAnJRJRca8/HLmsz54Ve7LjeaJAKIerEV3zVgC6niTPHft1i31vchMXhVN2ZyyQoFGjk8FMSlSm51d114Nz03huCqUaQhdLFNsi6vSVVfkutbPOndK9ymRR+boEHDrLW5KNcw1u7QEyVlnbx0cqog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dVE1kZ4D; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dVE1kZ4D"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b0d224dso3544595e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Aug 2025 02:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755163559; x=1755768359; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CE9jiANI0cz/l/cDSr25IEHnZ3OQaeUcRCYLlwFZaDU=;
        b=dVE1kZ4DMWvjobvT1UbW3o+gMQ71xDrIorQujvcxwL+bteea2tnhFv2zL1jsuSw7dA
         d22C3relist1PqWR8OdDQ0B3PS8qL5fifNTbjsmNyiBNtbdSKdYUEygKwnwfXgTqQhog
         mgrHyRMq8L2J2xdlUeFIlZQOW760vJliGPNvNnwIP2J9+TtMRfot9vje0YufpRBO9ilb
         dsh8vDl0e6EQsGlMWyG7Kb5FdZBQ4u6UZQdVZNQCBTtrDVc0Dc6dO1cAnjzRvlG9tNLI
         s72tNplwzYN01Upc8pWpmZcLx9kDNMPA1CnQWYcAVVa7R7ekUkYTIEF38LyN09tLG27y
         z1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163559; x=1755768359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CE9jiANI0cz/l/cDSr25IEHnZ3OQaeUcRCYLlwFZaDU=;
        b=PaqWBE+Dsf+t9UG6ObyQeGuCQtCdFU7xEBgIpx/4ZUj6Z8+o8mH49xmm3XTjzWRgl/
         bXkF8HWGf55AxjctxA4V6BJFx9WpbxpuEitqLOzFDXBRDN9BuQdId+8gYkGKl+YLGdsd
         EChCw7VyYw9FfrlvY5mmwVazOEn6MTcIbXQw/ldS5J3i1VpsS6F5+fiXEVsQyKKs7o8a
         D9cynfXa+l53XYUQDE125qaAuPwGJaEjrOaab6pA+77G1IXOYqfLdyUtYkjmXEQCUlyM
         oITaryOnc/XUr8KSK+1Bz4WJoZFmi9wJr5gvnYDF/5mjvEx1At5uNp9QzYDY8HAZKemO
         wS2w==
X-Forwarded-Encrypted: i=1; AJvYcCVuZtjYBxXYUa+dVAoRiLfhxCYXm1NPQKs8gb/7ADL65saQy7ycs4oIgTcMuv8CylNiBkYa1NIRkWfa0tJmy7jD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw57vCr1JNtvoesiISWPpO6mLj78rYNVGFCtl4/OrbOL8UDH1XQ
	XejGmnKoqnC0vuglefRPWuLUeHmB5TsVlGOc+OlqDNrf43akEzcRVQr7LiXrPz5Emwg=
X-Gm-Gg: ASbGnct9dTcDOfIi6wW69UFOL3j9WWzlBJ9wJhXidaEOiXy5pJmYGRzIcOcmVaceiCD
	0qoQiVWT2U9JTzriA//EuwT9JcdSffJzQ/5WshQ1e0oEKhQfpLKbiLDZ0D+g/Eihba8ARiXAsiV
	IN44m8tDzLXC/rv5jSpjEWt/E8nxWkds2O13912n1BX1rkmlpIte/202mq6oma3PsWrYdg4S9Zi
	1wEdpYCvmSKYCG/U+B0r9CGPHmA2walxXec33Y5ltGz1TTqynDoX/bWhp552tds1qK64JNA6235
	hPmWz0TSxEhqnLzUqg/lkXVoIcJH8ftf1ksdpOf80usdBP6q474d05Ep29215hiS3dsFCZaOH+n
	I2Cb0gttCRtr2DktrJzFUOB8c+86slOg=
X-Google-Smtp-Source: AGHT+IH3aH4s+NYnAVYfqbXpSrP1ix9p1QHXe6mSxBCrVv3jDGybUKX6JctDT3xmTAkJSTP0/FwOIA==
X-Received: by 2002:a05:600c:450e:b0:456:496:2100 with SMTP id 5b1f17b1804b1-45a1b6753a2mr19666565e9.31.1755163558609;
        Thu, 14 Aug 2025 02:25:58 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c76e9basm14536775e9.21.2025.08.14.02.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:25:58 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 10:25:23 +0100
Subject: [PATCH v7 01/12] arm64: sysreg: Add new PMSFCR_EL1 fields and
 PMSDSFR_EL1 register
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-perf-feat_spe_eft-v7-1-6a743f7fa259@linaro.org>
References: <20250814-james-perf-feat_spe_eft-v7-0-6a743f7fa259@linaro.org>
In-Reply-To: <20250814-james-perf-feat_spe_eft-v7-0-6a743f7fa259@linaro.org>
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

