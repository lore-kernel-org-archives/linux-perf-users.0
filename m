Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A8121D58F
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104184; cv=none; b=QqdUXWe2NS3WrgwxKeTUkhE1B4VGvwJXSdfgeF6lq7bRp6C2cJoMNCSsgemPEPFIxLee/g9YE9kxhxBbtn+/KvpayK1UzJskA741ngleGlL7HoSn51oyR6xX4veSO/bJMxqcIDemwi4+DntQ03S+ctmCMFyCvKou6NtHnUJcOLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104184; c=relaxed/simple;
	bh=7gzyqd1Bpe/8V7Xh/c5GHAjOiN3oEMtm7RQOKlXxUCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hhbuPI1+X3aQ54T01Ex4fFgt6L6Uh9ewHz2IPQYIAJ0qlXbFkoCMsl41Yik45BJY8CUD56BuIuKNNKZERwkL7S4y2NgU1bCbAwvkGieH/uotUKWJuy+gaBcuvTsShL5+cS2mrm5ewqEFLgKA6cKRPpUZkXwjddPtxB6JD3/01ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hXTxyTX3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hXTxyTX3"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2255003f4c6so30015875ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 12:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1743104181; x=1743708981; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/JOQ8WwmCbSnRqnzBomZTQ9W38PHSEAGnjY39LhZEAM=;
        b=hXTxyTX3TfdVlk0JnYiJ1dKtlQYQ+RreS4vqfBJOFmq2DqT/2p8/WkUUJkplFWm5Ps
         5HyP0LsMpEm/lHdVywzERrOyj3zNaTyNIwoe2AcAunKM9uEB4wgtQgEaCyf4jjyNAtuR
         jYwvelJwDcyHmewF5yzCamRd4uGVhBwn5HmcR0UTAjGEqXQVhWE67fmUSUtrN5yJImMu
         dDSOmq0pIB2U7bIfN8yLz4sbVIGxv5YutYySbdAvXpGODh6+6dxYzpChGuuhIjsiom4f
         nuLy7M715/CgVFTLD61wtXG3nzzi6tjsYEUvT40cQ/KFBEZt0Y+0UA7m5q0tQRpHleeD
         /0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743104181; x=1743708981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JOQ8WwmCbSnRqnzBomZTQ9W38PHSEAGnjY39LhZEAM=;
        b=b+py4ftyoWcFwlYbXrmax2JTclIutHikPc3N9CsILL00S86QdZ70reqPP8+UA42xv7
         qc2k1XA50k5vL03Tvs0RqQovRlVS9VWPoQ5JQrX5qiOTnukf7/clmkPeHvO3TKXO0QFS
         WuOnJ38FPfP+Nc3er0ynPNU1SuNR6RUTWzoa+4dLYx4cB0MQyinZIDTEU8d14Qh6ZF/a
         ZDwXd2nF+x9LpaZGmFQ4nupMeeieHiQOEiOma5GeMJowIVYpRXXYkYkhJH6Je8M/Q8fm
         HXLmz8zrn2IymsMRnCkcU1V7OM8E7esjgOOf/aY07UmhEUCzEoc49OdfPhjW/JcOLLDv
         Iabw==
X-Forwarded-Encrypted: i=1; AJvYcCUoYunivMwZBnbOz6uVucE/lp2vJuQ0viC0e1GxjDPKCxeqDyQdZ40lf+/CjbWXMq9/FOpIzQjbPJmzITSum6Lm@vger.kernel.org
X-Gm-Message-State: AOJu0YxqHRLbfdtk0YkAsSVQQCZbcsiCBnYeYP9sSvKZd4QEH+BU8E1u
	7hLYJwMVIiZ2sene3XUkTpWUAK2vwTwTtX+Gbtm/EMcZOxCLyy/gLWxFlTOi0A8=
X-Gm-Gg: ASbGncsO3fbTREpg2AJ61FzwCWh6YmbmC+KUqQwH9GNH960gZs+TmXoEcjPlPPE6IlZ
	yVEBGzssvkcuArExED/vc+YN0lrzhcquAw+dOGQpk1H9YM3qNjgoGs0MH3b9IEajkeF8Obont7F
	yJklUnpT4nWqg355+rGzKI5ZsKr+cweTtk1kNJVkGB8PurN/x39Y7bEmN1ZmHD+lBFVe8/mBZvx
	b4DCS3SeK1YABEfnZSQbmvAYggQssZ7l5m0ezmcQP5RmfDbPX9xcpC/npTnyrUNhSrwI2L/fXzd
	AAuUbVIaN39pujbEhZ98Cegs4y3DB/C2BNlO0hVd/qB4NrRvGpbhlXJyORioal1MResV
X-Google-Smtp-Source: AGHT+IFSLJpOO+uUPIXxxR4PWavcDhvMZFlKhYeaacVfbM6bFNGqTFcN8T3TvSAfTzPEFeN7iSGrUA==
X-Received: by 2002:a17:903:11c7:b0:215:4a4e:9262 with SMTP id d9443c01a7336-2280481d0b6mr52437215ad.8.1743104181444;
        Thu, 27 Mar 2025 12:36:21 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039f6b638csm2624220a91.44.2025.03.27.12.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 12:36:21 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 27 Mar 2025 12:35:47 -0700
Subject: [PATCH v5 06/21] RISC-V: Add Smcntrpmf extension parsing
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250327-counter_delegation-v5-6-1ee538468d1b@rivosinc.com>
References: <20250327-counter_delegation-v5-0-1ee538468d1b@rivosinc.com>
In-Reply-To: <20250327-counter_delegation-v5-0-1ee538468d1b@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atishp@atishpatra.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, weilin.wang@intel.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 Atish Patra <atishp@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

Smcntrpmf extension allows M-mode to enable privilege mode filtering
for cycle/instret counters. However, the cyclecfg/instretcfg CSRs are
only available only in Ssccfg only Smcntrpmf is present.

That's why, kernel needs to detect presence of Smcntrpmf extension and
enable privilege mode filtering for cycle/instret counters.

Reviewed-by: Clément Léger <cleger@rivosinc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 3d6e706fc5b2..b4eddcb57842 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -102,6 +102,7 @@
 #define RISCV_ISA_EXT_SVADU		93
 #define RISCV_ISA_EXT_SSCSRIND		94
 #define RISCV_ISA_EXT_SMCSRIND		95
+#define RISCV_ISA_EXT_SMCNTRPMF         96
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index eddbab038301..e3e40cfe7967 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -394,6 +394,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_BUNDLE(zvksg, riscv_zvksg_bundled_exts),
 	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
 	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
+	__RISCV_ISA_EXT_DATA(smcntrpmf, RISCV_ISA_EXT_SMCNTRPMF),
 	__RISCV_ISA_EXT_DATA(smcsrind, RISCV_ISA_EXT_SMCSRIND),
 	__RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
 	__RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinuxenvcfg_exts),

-- 
2.43.0

