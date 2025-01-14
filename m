Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199D7217705
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 22:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895506; cv=none; b=GtvvcgUUC+LC9GlufwabIMF6kuOw4RIYg16IyLN9KUxtaXoer8sdGT7ug067Sk3Q2dPNN9gW1Hex2b+blW6QSM4x3InD3J10biSwZvc32Vm4xV7cpE6BR8ViP71PgG7iOkXXYURbc2ypaMcx40UFt8miH9xsjr/qij+RhzNtEV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895506; c=relaxed/simple;
	bh=m6q4Neyt8+DISvN9Er7fHAb+rxOe7GRGob3X+Htbmbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f6Lkg2UYfic5u+wCcyEp70fiwknlo+4JGVJeVuJH6A8uSiTk6CmKlnbb65JcHRkz4b9ADvaS67CvucmAD+CY5TDW+DifXTs6mJo+WZ31IJl6Mp/+V6z8IAgZXlRFnq71DmkZHFQf4OA194BUhwhK71tkJh48aMrSJtCwK1zRQGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=p6vKFe/o; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="p6vKFe/o"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2165cb60719so109165185ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 14:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736895502; x=1737500302; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XdmJbLVNE72s4snJvlCZyY59rcdtG68osktCOOFf4IU=;
        b=p6vKFe/oPNeqNyHbGuwxcpiq5b4JccBG83dMentlBdnf+bi+LTk7XkLhltDM6LvEmg
         21eqREkm6IPy1ex6XKv5eNPmHYX+of/gNsa+Vnct9ZryLbX9BziGwfjNnpHnSDYN06sn
         abkUEYLX7M1ye9Pzeu62uT5Qf7z11Dqz4peavp9wamsQt8BteFT4ctDAWmGgLyvHpmtl
         lzKksqxpf1sWjQH16X5lZNHJANU2VFmXUn6y5iXhi5HyOppAsgV+Zdaljdmzp0DqsjL3
         Fn6OLE1/yds1S+vdQ4BgEbdVk3FBbT6hODQH8UqcrIlV2RCgbDuJPwnyDLo8UUN8HEWU
         uhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736895502; x=1737500302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdmJbLVNE72s4snJvlCZyY59rcdtG68osktCOOFf4IU=;
        b=upeA/rweZydZolP6mzGoS8z5JSmtPlY7YTZRvAbw2vVtSGun4/UX+yCDR+ovB0XMF7
         6iYX8jTFbPWX4cALyIIx/1NoCzlMn2JKDkXPXfKyl7W0RU4psZkirJlAs30Od1RarqTL
         MwSf4m6kV5KsHbUX2NYS8/p1v63vxIhSA7yuS1ll9BbMDVNF1/9IdrJ6RnApz7+OggQF
         frDtqWZaexYw8DY/835a1sIyyio6kEHQs3+6J4RR3rWyCjTHmBxzC0Rhs55j/sdl2v80
         WVbKYaiEkPzArvPkX39iCQ0aaCfsEuZ9jsgwVwHLF+Yk72wAaNgwB2u6y47aIsavcNCY
         SWgw==
X-Forwarded-Encrypted: i=1; AJvYcCVvTDALCaB2ZZ8LywggSuy8j3yYWZJu4owfZ7CAcO2afFWAUehbKuE8kBDtwLr89zeMT0R0hFi/T2k0851Odgpb@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0DJKImFt2dqDBUYMRU8rpGd05K62w8gwlOSn1nYdL2/8yLjbv
	9GTgGbwEvvXy3dJrOJDdQLHq2/2/cLIVgmKXW930UujEWyB7+zitlhMtXCnW9DA=
X-Gm-Gg: ASbGncuCZ0EINlDi2G5xylrTqRbVPlsjeS8GnshkMHBfxrbE+6jJdEBX/BGmJ6IVxtQ
	dgOex8VdhLDZch0g5n4mPBFeulpYUVPMZWU/ix0VMJCWG/0HLVLCN3sKYECLr8mzghwew/xzE+M
	zNUA+v79XfMLMmVxMV9OjClsFpbx7dvYV9R4B10Qpp+/d+RMeWMx5Kv6jHeBQRoW9/t8KlHQB3I
	hN8X2FQxWerjJEysCcPnmGpiRGVt8ntdkGPwm7c+XWqKZ0YB6zZD1Pp+AJVCStocvpxdQ==
X-Google-Smtp-Source: AGHT+IH1ltU/mRUuewPYEws/WbJoOFmxt2kzpsU09c76uR3HaGq/wIEXCgpsEq3E5r1Kj+FsLU8f4Q==
X-Received: by 2002:a17:902:dad1:b0:21a:8716:fa97 with SMTP id d9443c01a7336-21a87264051mr357793715ad.13.1736895502516;
        Tue, 14 Jan 2025 14:58:22 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10df7asm71746105ad.47.2025.01.14.14.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 14:58:22 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 14 Jan 2025 14:57:28 -0800
Subject: [PATCH v2 03/21] RISC-V: Add Sxcsrind ISA extension definition and
 parsing
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-counter_delegation-v2-3-8ba74cdb851b@rivosinc.com>
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

