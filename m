Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFFE225790
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 22:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895516; cv=none; b=uVTc3AYakm55qC+nqST2+y87ih5uTu+AT/14dgN2vJWhgc8ofqhebyzlqxtkvmtqBSWPFDPXc4EmBKKesCvQrUNbfW9O2CfRbzlfBW3xBYbMImOBTPoamgqxOygy4GlWR+kBXh0WufW6cWsKZv32oO2ZoEmXNBZj1P6vQJ/gW4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895516; c=relaxed/simple;
	bh=6cvdh9C7OPpZKWwBlCCCuIR/XmKs0464rb7Zln508uw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i8lcdgeqP8Tg9vOqjuiSzdfw+YzWCGMI7J5WSxHucP189DrwfHAylzH78TaBl3rh4BlDy9iiNQ4kcwNZIMfEXRRm2YUXcDvmxO3OpjaEbB0PfCRqUbRdl2o8k0Ax4JKLr+FLwkjlc5RvGDZeF3Ts5EO3Atm68ZHpNRKg0XiM/zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ByoSjsS+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ByoSjsS+"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21644aca3a0so133714965ad.3
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 14:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736895513; x=1737500313; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWIGDLFCubHBSCVyRujLDRmHtXnqwdBi6tbEZKWPh8g=;
        b=ByoSjsS+rJagZici9xtLzFoM1xDW5uEXH4ApT63qf79CvC7hNj/rsKJzdVum+fTHm1
         F7RLgwVD+7ra2Ty3u+WEHKhsFtLdbkQTRVQDnuA++slaDQVTzULiBpnjMflhdKpJc+eC
         Gj2xSkhEjXLu/dkHzYbV6RoAfVt01Q/AJZL4ANQbXYzZuQSi8AYAes8BtSoZX0GoW0T/
         weZKWWAkiHMBKFkSD8riT9gGg6CgsPQLebb3wwQV4/1ep/zJfGZa0S2oFYuq1zwPdtWQ
         TS6FWgaXMqSJ3TpJkbSQq3CiPw5ipK4PoNdjiaW/1ZeyQsIWvIYJoIcjcZOCpOBGDLWa
         MN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736895513; x=1737500313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWIGDLFCubHBSCVyRujLDRmHtXnqwdBi6tbEZKWPh8g=;
        b=dIcvWtLCV0SzuAtTS/58/qswcEKWFC9FoeBF6MJ/uQ1dmG7XDlBDaorX9BXJCNFsfx
         AB+S3WczjoXN5vBNh+4CLnekS9wxGv5RqIyX3I/vmdSW2EoXxwI9ADWgw1E80tgIo95T
         iowgUPWrL8DsE4Znfmi8l6CQrPuH6unLJeuhAfbNVOx4Z3CCwz9N6mLwnxiYE6Lcg/a+
         pcJCY03Lvk7CqQzjY8ZRKCaMp77YHaXjnImjs1uX0jil3w1emHjL3DTY8TAZ+p8dWx33
         OVRRDx1YoxvUuTQ/TJNgS0WFuTJs3va4IoJq28YG0VNyRTYllASQtlxfa1XBfKqa9xDC
         DFKA==
X-Forwarded-Encrypted: i=1; AJvYcCUy2lckDhJGiI+OXgN50qe0w8IImVT1eFRb9X6FFU/jJaGHFfBOWYFDV9LiIbbvQwPgJ0YY74onAyIEp4wQiy9j@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn5w3Np11QnjGh66vLdRnfhzBsfWp9SQlQn7LtfrOybktWyUVo
	dxi42o+eVteP8vpP7BSwNa7jjKbjpDFvkcbfRxFkrVXlaIYz5XHWO8cRJY9NfCg=
X-Gm-Gg: ASbGncsA6mEWX7BQ7ENOlydewzzb8C1veVIynZNxekBU4YcJr3CN0sdKFbEBV02Wqrn
	ybEMqi9vF/QpDm8eGnLhHO+z0C4fyjZxypuZTvcouesqzAhFl4FELgpULzmjtXyP6nPrRdZKZoQ
	LurV07qybkriLCVDDUUM0GC+hEWRXQWbkagVXYXXO6NCM2pZQ3PJrzs/7hEu0DfsxPt/s52NorZ
	GSxyAwYiyvaKcXMQUUAIY2OW7SSFGL12Fybc6+/pVVJu9lqwmYAkP2ChKmcashhvMEnGw==
X-Google-Smtp-Source: AGHT+IEA456GfI5+8oEuqGE6qvT+i61hsuXVFO4kFDRLI54KTxTxc0Qi5q2Wl0+CmS3HjZwnXXbB9Q==
X-Received: by 2002:a17:902:dac6:b0:216:4a8a:2665 with SMTP id d9443c01a7336-21a84012a17mr412337025ad.50.1736895513466;
        Tue, 14 Jan 2025 14:58:33 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10df7asm71746105ad.47.2025.01.14.14.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 14:58:33 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 14 Jan 2025 14:57:34 -0800
Subject: [PATCH v2 09/21] RISC-V: Add Smcntrpmf extension parsing
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-counter_delegation-v2-9-8ba74cdb851b@rivosinc.com>
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
 linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
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

