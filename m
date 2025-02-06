Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6149222579C
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Feb 2025 07:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738826603; cv=none; b=jZQrj5pHzagUPggOAiavAVCv5BgKuCw9RRWjXVc7zkKhMXcNtEWJlFHT2/nNyriy7WQxhYPjSwuhO8XZPNv2c1KkIWZibxOdWi9l1XN/XZwG014UDTZ7Da4qWwnt1CHPM/QzzxsnX8diAcA9jiCHKWgvFd9XpgPY6Ll/Ae76I6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738826603; c=relaxed/simple;
	bh=F4DjoUBQe6/kcWYhbsJGiKZXxvav9OH07q13dJJ6i5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O5w8T3dnBRXhj/07vlDBI2ghW6FirVYuyVduTU0PHXLkzzuGyz7YySABjSO/n5Rw5tclLB4jpY5qja10kuve/NHXainIk0k43J5/ziHjdSzxOcdFjiq0IaUT1AdhsfDwxDoZ/KO9iq2lHNaUpHX4zDkWc+KcmRBJ/AgPwsXosUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xxxU4FDI; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xxxU4FDI"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f9d74037a7so1038403a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 23:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738826600; x=1739431400; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJ5m0Zv/n9Oaz8jMiZ4dpuMO84fRe+qZfct3W6wk+oc=;
        b=xxxU4FDIkzqcdMWvIo2kFinhVHpZ/mWZb077tx1GJkYDvQmJ4c4oae1du7zCTQJBGt
         GAxAZJG1cjH8FNSzqi1UjSVbg7eJJ54bqb+brQDGxX+qGvvwdjXqQ0msqQCoAPTmjAyu
         biVbSp7FXOn8YQFUJZH/47umxscS2UFiaAfX2cRWaSxEHJhZK7PZORodEqsVnEg0wptm
         MjdMYCb/ZCTMrMbCXwJCgEV/5zAzDYMciGQWXz2DhbmjDxHvuvuo66cPwn/v1GfOTs9M
         7m4tBEkPZfE0i/yrquwDzIYmjPSZzk3rZLoyqrV1AQ3pOai1FdstaME6M1HjXl4/ln1P
         OMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738826600; x=1739431400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJ5m0Zv/n9Oaz8jMiZ4dpuMO84fRe+qZfct3W6wk+oc=;
        b=n7jSeCa+u+V2jjwqKctZZFtr0FUSowviOz7vjpi2I3Tm69F0LgWxF9Z4hQ8jUTMXbc
         g929JFMnIA1DlMEQXy1wkTRjRw/LXhKEjtQJRhDzswRs9JK8+Fu012hZazpt/QuLH6f1
         WSsKCEN/mK4fGlCNWZjV1yJ+af8P5BZxpdCqwWyUPK+QZtd4LF8X77f/75b7L/m67HE+
         tCA4/8po6QdhrplZ96R18aOicVQzQNgyDeE7RLs2bFJwGPRg3aOJxmRe7U693nPM27MV
         FmWWPRj4+hxWwBzEbwnVtkso8EZ9Unxs4LSKes60pqs+4bEoGmUOFyDIslBQVNv13ltS
         1hHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6McEiS91wKC06tGx3W47cchnXxKqisL9Zo7jDUFa29PxhCPylW3iC2RN/P/wyFFl7eiIkGwpjLBcxTCwWxHdZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+puihBNxRIEFOjx4BTL5i0li2nTOJcuZ6RXhIvDeXT73ub3yF
	NE3MxX0v1IH0DP/8EKCpRJZgCa+85xzXl6zjhGFBsO9x7Uo5Z26bCQDCMlRpOBM=
X-Gm-Gg: ASbGncuGf7wvmEyIvnRNz+yTLvTeMtwLLRagMoLThhhRaxLVAnRXn0VA9dIIVg8tFeM
	PG0IpljM7Q411vz7vVGkO0zluk2qn9hydyx0j60iUfl/imqeV/IK8jm66pDbVbHoT9IkPUygVgW
	WYckMnvpFoYXx+inUkCq9GTQ90KW5RxFlzYzgcqM4F9rxc6ULzBxCwSNUoMF2g7uSLQMYtpZ49E
	Gu3u8rxtAwcVNgQ+7c4j/RLx0TbcRRXsbGUrfHMDCe2qf0s32XJwPtRfe8hW7Bhxq3ba+bpj7kr
	W79BKDFZWABKd+M0CVspoaIB4APy
X-Google-Smtp-Source: AGHT+IF7N62GzT6UR79bVSug46033WXYgVAcquwI6oHxNyG08rwtx9LdnCcav0B0Haf/hbAqjbl9EQ==
X-Received: by 2002:a17:90a:12c3:b0:2fa:ba3:5451 with SMTP id 98e67ed59e1d1-2fa0ba37cd6mr1441805a91.35.1738826600432;
        Wed, 05 Feb 2025 23:23:20 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a72292sm630883a91.27.2025.02.05.23.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 23:23:20 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 05 Feb 2025 23:23:08 -0800
Subject: [PATCH v4 03/21] RISC-V: Add Sxcsrind ISA extension definition and
 parsing
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-counter_delegation-v4-3-835cfa88e3b1@rivosinc.com>
References: <20250205-counter_delegation-v4-0-835cfa88e3b1@rivosinc.com>
In-Reply-To: <20250205-counter_delegation-v4-0-835cfa88e3b1@rivosinc.com>
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
index c0916ed318c2..c6da81aa48aa 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -390,11 +390,13 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
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

