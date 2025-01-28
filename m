Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2761AAA1E
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 04:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738040396; cv=none; b=FnXivo70OG0wqNRqJG660+LK5e//Dmf+yxsEVfY9kp8RwmsCa0xFimbuaWVJWX8x4gSCQOiGmv+zKc5oNgLu4huzFmyw8gu6icxsQG5KyUg4CWiCn8jhBkxYzXAo33/jFHGWvhzzE5GQG0UC0NvQEZ0uSibjEQigKR+hdVhawzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738040396; c=relaxed/simple;
	bh=m6q4Neyt8+DISvN9Er7fHAb+rxOe7GRGob3X+Htbmbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R3p+o+tz3V0whrNvLP0br53TVqzyuU8wXQRe33yP9BG5T0MGUTOVOEJ1OjAApnE0eWzRdXoFqFWM3I9Tkaetu9yT6c6xtj0lri6nQz/JuNSYIxKEW2AMHLcHHTR+fz+fcOMs0I7C0cqY7WXgTFpezH7M/FY8P85MmUGhA8PM0Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=x0JqsMIA; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="x0JqsMIA"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso8960317a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 20:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738040394; x=1738645194; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XdmJbLVNE72s4snJvlCZyY59rcdtG68osktCOOFf4IU=;
        b=x0JqsMIAVwzdxLFNyE/FKoa1Lnf0o0xinvpF+Pxttt/Ewlm8M1a9i78nDFfyopnJdb
         aV8w0S/NaSEQExij1KnrJKbbBAqN5vTkArJZyg+D+upHReo9uLLlKVVWfg3WfjWKDVut
         2OL+65gDk8UvlATNxAOvew7UfJ29t0ibo6lZu1w4+Wfci4RAu5iRSKBj3Z4lMWWys0oN
         WW5syeeglHPUxK2EdQIppa8WDUyMoy4mK7P8B0kmFuwknYhh37TW8sz9cOaGNnSbPagC
         kd1rFDfMQ9dRxo8/6PvYd7bbzeAa2pFT3Xg0ophyV/hUqhOLSamnlP0NI++gIzoixVKF
         uZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738040394; x=1738645194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdmJbLVNE72s4snJvlCZyY59rcdtG68osktCOOFf4IU=;
        b=sicR75Qi1FRv1wg4s0Pm7aNkhE8zyIu7Y3zEjpNWELPDOrMntBLSidJhdnfm0j9hPV
         vafYOOSWy2gQeMaGEEsWSt+j6Eo/N12OgKpCyAOiDAlLweo1x/CSOtQXIcqzrvfE7x5B
         hTs+R7wfFp2ubjyJrnPTa2wu1DDOiVqMZMqlNLxLR3t3xN7zNYsk7yYwlmsW2t4gh5ty
         QiiDNpKuWlEbr3JVmREveKHakJSUPfrxJCjAFYcy2Q36W91drJyAS2FKUQf9UJftRJOI
         9OPpYXqsjjJ/z8kaHwWoSF8S5wQXazXGuWazm5kQOJvXIfxIkiqB67q/e94c7YxgU0AG
         Mkgg==
X-Forwarded-Encrypted: i=1; AJvYcCW15iayfw61KK5n2TSkWvWkWl8jjANR8xqaPecQkdab1D8UE5VFFs8XNtE2izmE695RQXxXjVo7dWG3V0vq7CTv@vger.kernel.org
X-Gm-Message-State: AOJu0Yya2PWl6Wc1C0OfQ2eXKPYhnxQ8EDKz1qGqnON8HMzOYUTuwSyU
	TgJgXBsyH2DQqcBwmJMYs3R73n3obQs0mP2+CSH2mPkdoOAVZcMwPZskXZbzhtw=
X-Gm-Gg: ASbGncuSnezHrGjsONr8IuE0Lk1v4EUZ+pagrFQ8DTCQBZMTaPnmFF7tkNur1hLXfXD
	mASpuktV+S8V6F5o+RFGBFpKXcXKQzzwXWshbKFlWQaq+xXhz7HLWhjL6RK3x75D26w+dpTOKWL
	sk82r7ABTLAYiEF/o/rET/I96Q/rr1dKd6dFnwSBpXDoLudkmdq5Kr3/b624OUDMsskJVWG4D+S
	8fFnOa+QWJhN/dEr8iWGDY+6KXAmiIVaQeJXnB7LqNott7PK8UyHui2eY/wKQTj4/5ZSFz48I0+
	pT6VJX8sMb+P1ZCkO+1+m+6MJ3s1
X-Google-Smtp-Source: AGHT+IHSyPvtuQcDcqt3ZNPeK0UBj94g96yzFH1G7FLZXdPg/qfAF4HitoyPnQvPmyX4Tw9btm7mhg==
X-Received: by 2002:a17:90b:258b:b0:2ee:48bf:7dc9 with SMTP id 98e67ed59e1d1-2f782cb092dmr65904028a91.15.1738040394340;
        Mon, 27 Jan 2025 20:59:54 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa5a7f7sm8212776a91.11.2025.01.27.20.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 20:59:54 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 27 Jan 2025 20:59:44 -0800
Subject: [PATCH v3 03/21] RISC-V: Add Sxcsrind ISA extension definition and
 parsing
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-counter_delegation-v3-3-64894d7e16d5@rivosinc.com>
References: <20250127-counter_delegation-v3-0-64894d7e16d5@rivosinc.com>
In-Reply-To: <20250127-counter_delegation-v3-0-64894d7e16d5@rivosinc.com>
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
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

The S[m|s]csrind extension extends the indirect CSR access mechanism
defined in Smaia/Ssaia extensions.

This patch just enables the definition and parsing.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 5 +++++
 arch/riscv/kernel/cpufeature.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 869da082252a..3d6e706fc5b2 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -100,6 +100,8 @@
 #define RISCV_ISA_EXT_ZICCRSE		91
 #define RISCV_ISA_EXT_SVADE		92
 #define RISCV_ISA_EXT_SVADU		93
+#define RISCV_ISA_EXT_SSCSRIND		94
+#define RISCV_ISA_EXT_SMCSRIND		95
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
@@ -109,9 +111,12 @@
 #ifdef CONFIG_RISCV_M_MODE
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
 #define RISCV_ISA_EXT_SUPM		RISCV_ISA_EXT_SMNPM
+#define RISCV_ISA_EXT_SxCSRIND		RISCV_ISA_EXT_SMCSRIND
 #else
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
 #define RISCV_ISA_EXT_SUPM		RISCV_ISA_EXT_SSNPM
+#define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
+#define RISCV_ISA_EXT_SxCSRIND		RISCV_ISA_EXT_SSCSRIND
 #endif
 
 #endif /* _ASM_RISCV_HWCAP_H */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index c0916ed318c2..d3259b640115 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -393,7 +393,9 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
 	__RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
+	__RISCV_ISA_EXT_DATA(smcsrind, RISCV_ISA_EXT_SMCSRIND),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
+	__RISCV_ISA_EXT_DATA(sscsrind, RISCV_ISA_EXT_SSCSRIND),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_SUPERSET(ssnpm, RISCV_ISA_EXT_SSNPM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),

-- 
2.34.1

