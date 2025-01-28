Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B628F1F2394
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 05:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738040406; cv=none; b=jiJVJGDIC+1Vz6tHCFaymH1b6ezgwS1tguUJ9WngS3Zud9yBslGQlKtkkzP2KVYGIeMQOHzgN1LKt0WnlsznBIFtD2dDKf4h1C+SE7y90nQWr6/yN8y1ltw+Umt+2C7kVv20Wi3QgJaSXJbe5yjptdtY0GwsLm3hREHecCTsIHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738040406; c=relaxed/simple;
	bh=6cvdh9C7OPpZKWwBlCCCuIR/XmKs0464rb7Zln508uw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OqbMRFIDBQhpB6CHbOvfkVQRIObYym3Hh0zi37q0rhIKEc+JWEmmpZm4565+79dRoWDDmhikKtIgaRFBueD/P7BEczNemFTATlw5ypT8oxOwWwGJUJkfT27dmpR3bxfV4pmYLGHYrHnsvQwIKCWY0FNPS/jg0X3FvD9h8TnW+c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GZVpJZdG; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GZVpJZdG"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f441791e40so6858814a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 21:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738040404; x=1738645204; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWIGDLFCubHBSCVyRujLDRmHtXnqwdBi6tbEZKWPh8g=;
        b=GZVpJZdGtC3jnLTogmO3r6LqiJ8uDTNF50xGi6KxF8ShNnR1fCdDCxEn+xMT0fliwx
         gzX0TOYzqdFVtJslklfdF7YIIhxgdYulyYTaqsqo3q3iZXxTdirTA03Yec2bRaCrBsW0
         Iat8ZdU4WNnhfxuo3W+Yf+opLtamyXltwQg/EaLr+RkINkW4m0g4roIOC+7NKWW9glqN
         JeyIZLdZU+3uAgGDuVHtOkQ9BWQ9m+A+9bsHBbKgQ+1EW1GDAI1O759qXX5j3I/gQzho
         Yhj5D7pVi2dHbEvg3Hrjd52qQ8LmeuOmCOXyl9GBqkjBeJiIOBMiK0t+B48Uk3rDshLo
         ng/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738040404; x=1738645204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWIGDLFCubHBSCVyRujLDRmHtXnqwdBi6tbEZKWPh8g=;
        b=XxweCTwT1l2/j1tHwcqPZlc327Lk2B0SLA3JRtXUVWkmChC68UvLGJjeHWy/i55wgE
         1jb27AL6xFgb8rbXKJ3c4s7q0zCCds2zGsuIBRF3omVEGnjiqgZSF6qrGQTrndUiprx1
         BT9sUuF0zAkDYPFP5g2fjyvjxmpazfREVdu6h/YXi6CRirnOhjjv0v5+pEuJl5sZHxT0
         ZOJMQyEkwbgPCXz+VqzFPPoQ4i+c3NoH4nmVFrgixJbFuE+xHjR30LPbydgiYBRHRkQi
         IZ19NHw8N2xKjn0+AVrsDbiwZcVPjDEmfIJKSchxWhItaXdZM6uYIUMIokkJkX+/ThYt
         yZHg==
X-Forwarded-Encrypted: i=1; AJvYcCWbQN4ho7Cjbx4DKJoFOVg78VxH0m4R4CsREhlpLWf0jrfvITVmb3bWR/pzDI9+JO9wPPU/jpLUuUKUH7ZwVxsu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0aEThnBqEw2P8JgO0fAf6v9gaZxIn7tDObDy/AtLLOjYcfpRx
	zPYZf5OTLhYuFDxsH9UMfssctlMzSEsLatdnQpY1DRnvEDOkQEeVk7BksDDdS3E=
X-Gm-Gg: ASbGncumKRtS2eYIy4C9VaJGhE59MsQIr5kO79I60ahoEOlXAVM8TydjOL9mOnSYQMg
	CdGNvXk1PVjghMit3+PLDrg/Krah3NdhiS8g008W9HWKRrc9pSXRe3kU+jZtAl7xYzqE6wdHzBG
	h9Cpig8MN/6NeyGWM4gO2zqLMzOwkh5d9+IZzNOicyczPPwyMKPR9gLzcTIs6D51ktT4bekGkYe
	TucCR8rLZMZ16jM49JTIB+GJjmBl0XULc4twlileCHZumCjKgg3c4sJD3YgQG/Gk8eUJOMOM9fa
	AgTMj1BRdcT965uWwIaIFgUHqeNV
X-Google-Smtp-Source: AGHT+IF6z2gLBaxXEkT5T0gtB5dB8hKkZBHYBvrUyOYQ2AWcmEN76E95Mjw0gLw3wzxwSkAZ6LwcMQ==
X-Received: by 2002:a17:90b:2c85:b0:2ee:c9d8:d01a with SMTP id 98e67ed59e1d1-2f782c92ce0mr63874654a91.11.1738040403855;
        Mon, 27 Jan 2025 21:00:03 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa5a7f7sm8212776a91.11.2025.01.27.21.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 21:00:03 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 27 Jan 2025 20:59:50 -0800
Subject: [PATCH v3 09/21] RISC-V: Add Smcntrpmf extension parsing
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-counter_delegation-v3-9-64894d7e16d5@rivosinc.com>
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

Smcntrpmf extension allows M-mode to enable privilege mode filtering
for cycle/instret counters. However, the cyclecfg/instretcfg CSRs are
only available only in Ssccfg only Smcntrpmf is present.

That's why, kernel needs to detect presence of Smcntrpmf extension and
enable privilege mode filtering for cycle/instret counters.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 2f5ef1dee7ac..42b34e2f80e8 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -104,6 +104,7 @@
 #define RISCV_ISA_EXT_SMCSRIND		95
 #define RISCV_ISA_EXT_SSCCFG            96
 #define RISCV_ISA_EXT_SMCDELEG          97
+#define RISCV_ISA_EXT_SMCNTRPMF         98
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b584aa2d5bc3..ec068c9130e5 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -394,6 +394,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
 	__RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
+	__RISCV_ISA_EXT_DATA(smcntrpmf, RISCV_ISA_EXT_SMCNTRPMF),
 	__RISCV_ISA_EXT_DATA(smcsrind, RISCV_ISA_EXT_SMCSRIND),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscsrind, RISCV_ISA_EXT_SSCSRIND),

-- 
2.34.1

