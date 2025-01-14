Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC06C223715
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 22:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895510; cv=none; b=MthOWWbUTdl6Bqcdc2wwHON7TCCMj03c1Zr/LwxQ8snKUW9EzpxixGwzKUjW+fPO2vr4rGcNRDYQBQ0/GRGJGKcr3w3xZvG+dY94l5oI/L+QrPVk+OJeeihiFYd1r//SG0AHjv1zMgjF7CmBJs3xswpLmImm7FMT1O0X6zEaC2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895510; c=relaxed/simple;
	bh=h5wOko5/ga8cV219RAU/eWL2w/vmxvwUPsYu9zhL7hY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kB9GVodC7/MaEfVWjI1NqDSAGeo8+9kJD50j4Fr2RcK1aT1geKVwtAtAyJDPqkPyN/qUgwsa88S5mQNJWJzrYW9VAiNaDKWTUp0nNa3qWkmG99IATD+ag4cioTt5C0bVi1cHqFjqjOe6ZjJ1gG2J6gC4Fiy3YHvz3oHD2NntEkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=t8hQq2vM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="t8hQq2vM"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-216281bc30fso129166225ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 14:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736895508; x=1737500308; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qaBtUmcc8yUuB4kb43/yPbo3SeenY+DY+wt99rutmtE=;
        b=t8hQq2vMsxL9DAf1y2Z/Oyei8eH3bi4fOWZXfxNHZbgauJy+68efkYs5F9mGMCWMKv
         jKQinFhigkdOZwBwr5S4FajEPoBRueL2tG0udrcLBWOSCF/pDancjXVUKhF99LkJiTCN
         gFIaPe2khXjaST5+0d8NcAM5y8R26mjXzZ3fWnAG+E4Xy45HG9C+3YbBYhgV+qbRJfsj
         xzQEREdK5O0gqp5wfYQ/DfEw3CTOYfCOaR/jUSxZ7ZTyDuWDbTo/lI4lZRJpcVlFlOV+
         +/l3cYn6/CIJC7i5HaEiHEsgw/llDV4g6m0huWrCe50Z/96TUM0YH94CRnFPX7XqsG5i
         M69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736895508; x=1737500308;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaBtUmcc8yUuB4kb43/yPbo3SeenY+DY+wt99rutmtE=;
        b=FAFJ1eSszEHlze2gKHfEEPyvfDYtjf8yvJSZFV8aUkujKMVRnBiPZmcRpqd3Br+Ue1
         Nt90g3qsXfcVexjl57tiOStxXCFts/PHCeysHa4xcdBGyLiNNZpbvqnmaljFobc34nMq
         NCu2eSSkRypN6plLf6WrPBdXVlwwOEtYjdtgX9wDajda87iCY+zLJP8w4jHE127AtDsQ
         E0tcQ5DGxy6LMLdrVjOflo6Tagbig0EDz8NvvOsau84GzDV8CeVRKiPPonnBXea9zx5h
         cMeLf2IEFtQWUzTyUtz9UeQMui+nNYlkVXz2mqs5BZbhb17aPpzXf/FBAB0GK0KuVdig
         fRwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN2CBaFnKSyygFXSog57skcm8s7TeF61N2bCSYErtB9jf+KSfU4wEvpRP0W5zYP7+2M4t/T+uFV6I5rnRghgYV@vger.kernel.org
X-Gm-Message-State: AOJu0YyPbuOlH+VSwBHt79OSZEr32flAfDh1aGPm7i8u6wunmqCFv6nh
	P3svMnt8adntGI3W9x+eZ6jKSTWAeuv4s5fY6r9nz0Ip6kocUFiGRe9MWj/tjIs=
X-Gm-Gg: ASbGncuzXa0Q/E6PV67bDxZzkcrCkD1jJrxhJgBl/e1aVmtvNJitea7vR2iR8gmzVr8
	uWiav+gcWYB8PLnaWurrfk3wBG3gvd8xlbP2U5VU/isZ+qrOCJ5yM8GzOI66+CTSoKysFm7F5X1
	qBP6yiBzlfeY9WUFU0S48rLG9Xo/qfyAw0anxQHlSY4IZM+kxvDFJ6Or+7Qu0ErCr/KLtszV2Xa
	dLcPXjVkp/NxXLBK4O6AzrZflFftlmkhtyK0bkOkkiUF0TxwuciDukitI6g9rmP/N/h2Q==
X-Google-Smtp-Source: AGHT+IF/AABCTddporckIjUOKN96hiQBtfgegSha8GUyPdUbW6ovhlFLWrya9o4NBU/v7Wam3y7MPQ==
X-Received: by 2002:a17:902:db0e:b0:216:3d72:1712 with SMTP id d9443c01a7336-21a83fdf36emr438120255ad.48.1736895508081;
        Tue, 14 Jan 2025 14:58:28 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10df7asm71746105ad.47.2025.01.14.14.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 14:58:27 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 14 Jan 2025 14:57:31 -0800
Subject: [PATCH v2 06/21] RISC-V: Add Sscfg extension CSR definition
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-counter_delegation-v2-6-8ba74cdb851b@rivosinc.com>
References: <20250114-counter_delegation-v2-0-8ba74cdb851b@rivosinc.com>
In-Reply-To: <20250114-counter_delegation-v2-0-8ba74cdb851b@rivosinc.com>
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
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 devicetree@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds the scountinhibit CSR definition and S-mode accessible hpmevent
bits defined by smcdeleg/ssccfg. scountinhibit allows S-mode to start/stop
counters directly from S-mode without invoking SBI calls to M-mode. It is
also used to figure out the counters delegated to S-mode by the M-mode as
well.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 2ad2d492e6b4..42b7f4f7ec0f 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -224,6 +224,31 @@
 #define SMSTATEEN0_HSENVCFG		(_ULL(1) << SMSTATEEN0_HSENVCFG_SHIFT)
 #define SMSTATEEN0_SSTATEEN0_SHIFT	63
 #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
+/* HPMEVENT bits. These are accessible in S-mode via Smcdeleg/Ssccfg */
+#ifdef CONFIG_64BIT
+#define HPMEVENT_OF			(_UL(1) << 63)
+#define HPMEVENT_MINH			(_UL(1) << 62)
+#define HPMEVENT_SINH			(_UL(1) << 61)
+#define HPMEVENT_UINH			(_UL(1) << 60)
+#define HPMEVENT_VSINH			(_UL(1) << 59)
+#define HPMEVENT_VUINH			(_UL(1) << 58)
+#else
+#define HPMEVENTH_OF			(_ULL(1) << 31)
+#define HPMEVENTH_MINH			(_ULL(1) << 30)
+#define HPMEVENTH_SINH			(_ULL(1) << 29)
+#define HPMEVENTH_UINH			(_ULL(1) << 28)
+#define HPMEVENTH_VSINH			(_ULL(1) << 27)
+#define HPMEVENTH_VUINH			(_ULL(1) << 26)
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
@@ -305,6 +330,7 @@
 #define CSR_SCOUNTEREN		0x106
 #define CSR_SENVCFG		0x10a
 #define CSR_SSTATEEN0		0x10c
+#define CSR_SCOUNTINHIBIT	0x120
 #define CSR_SSCRATCH		0x140
 #define CSR_SEPC		0x141
 #define CSR_SCAUSE		0x142

-- 
2.34.1

