Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0088222589
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 19:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104187; cv=none; b=qG0gMmC2k6XMxwk7EstZ8kvcOwtJhp6E2Mn4BHFGju4ELJG6gJMFJr6oTE1qskAeHcMgsKKP7HqmLHrl0Vu/XkMPzytMvCZDMK/m1YfGlE8D5+yAVHeYkFRDI2MHaS8OV5M3qQXjGh7Lrj4epRSXSSDd3KOqy8IAA3tacvrBeMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104187; c=relaxed/simple;
	bh=zbUFnatx4CgI/XxIAGH/rswQYfjg9L9FFatwKHPX9Dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=stxLN9WMioAF8jRmqXe9ex/Dpe6NYdC+saIV5n/b0NwrEUxCdQIjCTobrWGU05dP80jLwTvjDFHNn9+BF9ClkGNpg5BOE0JCBZpBtTsoQCNTl1XVsZN5UNwddSr6gMWmFoM/BbZ8iF87g22Sv/WItAGIF7rMyz4B3mAW/gov3Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GWnBWuTi; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GWnBWuTi"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-300fefb8e06so2284153a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 12:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1743104185; x=1743708985; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yUgUK85uZXa6Y/dNTr7Q9E0wfwXHdLdLqKfyUg5SYXI=;
        b=GWnBWuTiafleafFeUbv53i5WxaFpJqLUqEgvyRsQTaCz1l0n+hmD0qlAMvngWo4pof
         5j8UAfNnMdaQncTvaDU3edDRQLCuecTNkUttnpvjrj/GqTcCiVCsrOjfsF1gfcG2vDoU
         CbyIX30TvTalHuffHvdA65X3JPUYIOJkmsdibVtwHJbOqGu6Jp7XSJCzkAT/HLC6pQu9
         Pfi/AD8jgmqb0TobG5Zo/RlbnPk+q4l4DXFnYRaopYOkOnNShiqNgsbdVXoQwexpyoRW
         GvUzKY/ZIQ9OJWVzpvaDEkBJ/SLdKWHLOXKBYZzt9vGoHawmtGe0oCp1Sog+xt39Q7O7
         uxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743104185; x=1743708985;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUgUK85uZXa6Y/dNTr7Q9E0wfwXHdLdLqKfyUg5SYXI=;
        b=F3BY9TOxtVmAhx0uBGwb5OmYXlm6PhHxif44fNPl3HWEzBfkBPvTDheAylWW6aMAi4
         N+4mLNYlEdz/I6KOA9RQwdhHB2mpDQRZ8mhu+o2yfhvt6Cm8LcyjCznUE4DZu2GkweD2
         WHSYSnKjbH4alPPtsFvt4wL5ild/LoLw3mwzhfU6sWtlmeTrYkMz7hYmHoh8G50pny7x
         xQDJBfWVpZusxiJV6ndzTXMJRBgMYrqBvalXE3x3gD+jZa7Bjfp3dqzeJVhywmeMpy15
         x0O6o4LnqbWKGVb5wtMkY4uZ3o58P8QeDts0avBj0FBo52aelbcqbnqdMZ7GrMOT6nCz
         la+w==
X-Forwarded-Encrypted: i=1; AJvYcCUDL62JUdYA8QOb6FLSIeLZD5JEormRyRfu9ZDlYaNdgDOdn5CbetHinjeogWI1sL/yQpk3f9XveOhlR0IvvSam@vger.kernel.org
X-Gm-Message-State: AOJu0YyTi22moSypF5Xxor8QOyuQuD3s3/Nsg57ohUEcKrNMTK07Ln1D
	tN0RpOR741301rdbHTuxY4aJrPJ9nOrmb2OLwJPrMPO2JHi9hKS7T3YTr0Ru509gX03xnQonLzA
	d
X-Gm-Gg: ASbGncudV271E8ld6lhbWNy1Myu+AkYYO2mxDE200JMSCjWYm8+rBthCW+V58m3C/oO
	2g2tBZDVPshNfFFwOfBpqHIWEK7MEkatVBpOd0IwnMiaPGg2h6VTCyoH/aJ7oB+Ey2S/dkHsh7t
	HvwEuXUaxqUt0BeCh1fUPsFe6P92dRRoNZk/lBiD+gd+nRlLaAPRoqrawRSL0AHCVL1rXYKy0tg
	uLfzWt1PeuNMh+ChEmYzvjjFYbFo1NrOM68/xXIfBzRXgIRd+4+xbfZPAUea/Spjx1BzpO36lVh
	jw3qh6Otz64IAECkhLhNplmiofRnVY+nPlUMOt6QDodtoOf/+eEBJ0VUwQ==
X-Google-Smtp-Source: AGHT+IHsQmzPAsgx/ng9OITR58/G/eBONWXQGgyTGskdwaITzdO2LxTvI25NheeogcoyYSwC74/u/Q==
X-Received: by 2002:a17:90b:2f4d:b0:2fe:8a84:e033 with SMTP id 98e67ed59e1d1-303a7b5a137mr7359505a91.2.1743104184705;
        Thu, 27 Mar 2025 12:36:24 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039f6b638csm2624220a91.44.2025.03.27.12.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 12:36:24 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 27 Mar 2025 12:35:49 -0700
Subject: [PATCH v5 08/21] RISC-V: Add Sscfg extension CSR definition
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250327-counter_delegation-v5-8-1ee538468d1b@rivosinc.com>
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
 Atish Patra <atishp@rivosinc.com>, Kaiwen Xue <kaiwenx@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds the scountinhibit CSR definition and S-mode accessible hpmevent
bits defined by smcdeleg/ssccfg. scountinhibit allows S-mode to start/stop
counters directly from S-mode without invoking SBI calls to M-mode. It is
also used to figure out the counters delegated to S-mode by the M-mode as
well.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Reviewed-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index bce56a83c384..3d2d4f886c77 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -230,6 +230,31 @@
 #define SMSTATEEN0_HSENVCFG		(_ULL(1) << SMSTATEEN0_HSENVCFG_SHIFT)
 #define SMSTATEEN0_SSTATEEN0_SHIFT	63
 #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
+/* HPMEVENT bits. These are accessible in S-mode via Smcdeleg/Ssccfg */
+#ifdef CONFIG_64BIT
+#define HPMEVENT_OF			(BIT_ULL(63))
+#define HPMEVENT_MINH			(BIT_ULL(62))
+#define HPMEVENT_SINH			(BIT_ULL(61))
+#define HPMEVENT_UINH			(BIT_ULL(60))
+#define HPMEVENT_VSINH			(BIT_ULL(59))
+#define HPMEVENT_VUINH			(BIT_ULL(58))
+#else
+#define HPMEVENTH_OF			(BIT_ULL(31))
+#define HPMEVENTH_MINH			(BIT_ULL(30))
+#define HPMEVENTH_SINH			(BIT_ULL(29))
+#define HPMEVENTH_UINH			(BIT_ULL(28))
+#define HPMEVENTH_VSINH			(BIT_ULL(27))
+#define HPMEVENTH_VUINH			(BIT_ULL(26))
+
+#define HPMEVENT_OF			(HPMEVENTH_OF << 32)
+#define HPMEVENT_MINH			(HPMEVENTH_MINH << 32)
+#define HPMEVENT_SINH			(HPMEVENTH_SINH << 32)
+#define HPMEVENT_UINH			(HPMEVENTH_UINH << 32)
+#define HPMEVENT_VSINH			(HPMEVENTH_VSINH << 32)
+#define HPMEVENT_VUINH			(HPMEVENTH_VUINH << 32)
+#endif
+
+#define SISELECT_SSCCFG_BASE		0x40
 
 /* mseccfg bits */
 #define MSECCFG_PMM			ENVCFG_PMM
@@ -311,6 +336,7 @@
 #define CSR_SCOUNTEREN		0x106
 #define CSR_SENVCFG		0x10a
 #define CSR_SSTATEEN0		0x10c
+#define CSR_SCOUNTINHIBIT	0x120
 #define CSR_SSCRATCH		0x140
 #define CSR_SEPC		0x141
 #define CSR_SCAUSE		0x142

-- 
2.43.0

