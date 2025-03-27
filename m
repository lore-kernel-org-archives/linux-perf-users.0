Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7742192E1
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 19:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104178; cv=none; b=H/U801hDWnbSKGJ+5Nbwp5zmZ1oxjVG0f1FY3R8987chASZVRuQUNKSYXmwNX3HCldZOSWcVAzQcUX4rlOJj4ZOWVBZxTHsayQN6PqqLsOS96TVvw5IP8vLc+D2//TOq8JXXIsgRO0fuVkyn7cvLCjBqThgs1IhPcgUmz7IJ8ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104178; c=relaxed/simple;
	bh=F5i3QRzErqwDL1vzGRrlZuwV3sA5CVX++faxgHNMB8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KO4e609u25gvWKp29tucRWgbU2XlhJ9nTyYl41Hql9lQdcUtvIbu5sa1ytunGu/JCbyTjVqoNXL5u0dnjAteBv+O53dJT5Fsz6mp5N3e0D1z2nCwEyTUwdTVH/1hU8x8XFyqqEWybsupn5z8euxZEFMB0zVMyiI9gG9MAkb2/tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=u1AUGlWK; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="u1AUGlWK"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff6a98c638so2797976a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 12:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1743104176; x=1743708976; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwDPeMXJfPX+eaLbjuVCFPuV2SZpHciR7qaWH3I9ArU=;
        b=u1AUGlWKZeoSbh58kfPvr6pudUTHYUzUseaXPhqpe6iXSymmeQvc3vXoUtqLbdCCrK
         hG1/kKrOEjEplwVh4vguDJN3eX2NfPJQWsxbotBp+O4JEfiO2MJFa0MTi8wTKkIKWhDn
         62xkRGq/l91ERg9TwHNL/MgbbMbmiWHn0iOAM1yraIFANzr2gvGuAgD0S490d00OhAZ3
         fiHkITWtGHSYnS0S3tV63YmiPEHrdZYT1Ot9Z7KlwE+8ORRDJfOcU2n57s6URhML+KrR
         28Y3vaTtgYsc9BhDUETCP5VovQ5x+H8TYln30Ub/Fh6LOiUJYAITJZssvBlXca8xn5IS
         U48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743104176; x=1743708976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwDPeMXJfPX+eaLbjuVCFPuV2SZpHciR7qaWH3I9ArU=;
        b=NM26m0xOr+Ogo1bmE0yI+xAvIIpaTTKCh3Ooimeomam1WAIMPxS0CkuTrqbAGDNdY5
         1q58e9mr83y12yaRbQnwaNzUcMTl/B6eW/ZJY0rM8+CKJzCmIiCeI+Hyu8qmc4fqaZj2
         iDjMzW7VtlxsaI5U0/s3IvkGNTfY9zQ0rvbw5YeCSeShO8QaFceW0c4gcrzIhAWRRGHK
         7d8nMODsYH81XctOu5exLfDQ/6LbO1BbCS9mYtFpN7RRDcvQkW/bERUvacnMtwsxeDLq
         D6OIpvjt9AGnE00LkDMZBVXaMosgVW+uk5L/htkveiNcIDTl10gIbeJkoUTuhRMhIWQw
         LxSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0VPHSv9b0LO9kMxVYo+bATbnZIMXY7yjo2q6B64nI0X6BzklGMAtpqfeBRbQC5hIc4pNxIMdhZPDhOcTB+yE4@vger.kernel.org
X-Gm-Message-State: AOJu0YzeJtyKV5mK8InzEJBmkFUZhFZ7uy2+vfNGpKqZGWu9NBx72qeg
	5gCzH3pupvxKkEjJngh8VV3qQUncjjHEg+wS7yM0Qld/V8zQEpfdXQeHrtQjy9s=
X-Gm-Gg: ASbGnctIvjHvnn/1I9bXFq3+hOFaNsWLp6F6LukItWhOhkPzLWrWXVKjoZbPN4Vr0G/
	JojbBBkNxyzXIfADeRL7OOi1eCnhWIwEzySlObLbjWaKQK/2v+wHBGZ6TLhMehJuo8uDsmPnvn8
	Lpi3PJr5aZ05grkl+JTL7A5TKb4z3VYSdijPnmoVa1R5r94OkOSwiIcCHd6sVHrVE2zQv+WtOAu
	bXOii2x197GYlRqCveHcL4WJ35EEawnRWt6UU7d0bu4+jCFd9G9TM4Ul6gM1ao+9mL6IrAe3a3b
	uMs3Vgnfjx4bg9y2kXglg5zUiG/glnx8Gn1CBrp5OsGjfq/xugk3UfMKvb4mQqUOISd9
X-Google-Smtp-Source: AGHT+IGz75Wx8Bt7QWuszatV2VM9mkY8/YUQoqlctkJAiAm8Pl5r9TqAJ39Hb6cqblaB+y3PgjrXrw==
X-Received: by 2002:a17:90b:38c4:b0:2ee:9b2c:3253 with SMTP id 98e67ed59e1d1-303a9192f68mr5197278a91.30.1743104176455;
        Thu, 27 Mar 2025 12:36:16 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039f6b638csm2624220a91.44.2025.03.27.12.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 12:36:16 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 27 Mar 2025 12:35:44 -0700
Subject: [PATCH v5 03/21] RISC-V: Add Sxcsrind ISA extension definition and
 parsing
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-counter_delegation-v5-3-1ee538468d1b@rivosinc.com>
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
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-42535

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
index 40ac72e407b6..eddbab038301 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -394,11 +394,13 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_BUNDLE(zvksg, riscv_zvksg_bundled_exts),
 	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
 	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
+	__RISCV_ISA_EXT_DATA(smcsrind, RISCV_ISA_EXT_SMCSRIND),
 	__RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
 	__RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
+	__RISCV_ISA_EXT_DATA(sscsrind, RISCV_ISA_EXT_SSCSRIND),
 	__RISCV_ISA_EXT_SUPERSET(ssnpm, RISCV_ISA_EXT_SSNPM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA(svade, RISCV_ISA_EXT_SVADE),

-- 
2.43.0

