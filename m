Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B54A2361DE
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737069033; cv=none; b=HcxflL+yupEeLenTnFyiYSmHg9Gm2VggzfBHxqPLF4GjaGnEyOwuwlusGyxCK0YnhXtNfJmNWlxxARW/2tiPGKwFDEkBX2olBBizDUjMBLWvYvdYca/2zk54TILdNunzOtr0KCHjt7lx4TfmXTe4htAS0cZAEfxnJV7f2XVHGA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737069033; c=relaxed/simple;
	bh=zlS1xy6+dHjpI5H8uR2wkbHrZK3tJwT3UrYnLGr2MPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YRrCj9XXfOxI9qoGyls8vlLZUZA7wILPY9SNJ16A2J/puTOX8OaFalAuk4/bM94QtcapgN6aLCg92WDAUN73l7lvQwDMpsTV0/y++l7/BS0Ky/n9F9u9KTUEr9Lxi2fjwp60tpyA6rftMgxXz5cUzohFQVulezXbFaTOWMv/CcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hd3Wh4zs; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hd3Wh4zs"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436202dd730so9744665e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jan 2025 15:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1737069030; x=1737673830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vp/FsiaV0Z94/Qxw/F7YAAt+C4ai0FuIMW/dVHkyoAE=;
        b=hd3Wh4zsEzE4yaLb3u0k/mDowC7jfFcYhUKnX2XB2FpjlCFn2gSyMbXEpErS1rqHp+
         WhFHxcOhpRl8piHM0rA9vgutvtersBdX4fpfcDPlflTsVf+MxFww12hqPDI4Z1ihUP9L
         6SDd7EF5ITexYmZgIfvSk6thmLjbsQkmQCOmabmjp0btr1TBDuSncZ1CdaFVJc07+Cw5
         0SVs/MK8S+MfyalyeQAJonudadHoFZrPD5cz/RNSEr+ZVnbwcSUD6ZMRImx4Tpr3HcNm
         WYjhRCchduFadWxSsHs0PVuu71rasTn2xGorom2Xhe5riujkVuyIChKBDaCRw9rgQDXQ
         k+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737069030; x=1737673830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vp/FsiaV0Z94/Qxw/F7YAAt+C4ai0FuIMW/dVHkyoAE=;
        b=gsDQiv5olxcpUfiwTSs6nVUSmltM8L0A6B10HgeQHuxFQh4uEvosjkhJjK8DMHduGB
         2K2k4zO3yCWRZf68RKGfOT+oEpE4wVCDZKWaXZ3qqhnLYj+6Pe6gosyPyPhBQhJgBVo9
         PiMuhiOIRHTNEz86vDOi8XSRvkj1EIPswf8wFdxtDkUOHn+DRpHUjbI0kTwBOHowsC42
         qPVMsxG01AhuNiqFKuHKFfNDKKq1a1RyBCnq+FLIZZAXXDUPEj7g7fCTqREKwFz/hjJn
         M9cwr5xgWZB8resJc51NSTlfgSrNTFUQV/kYC0JifCJFdUd1nBGbqjDiFNmOOynuAqOu
         GsGA==
X-Gm-Message-State: AOJu0YyLXWicmtlxytqhbz3ATRD/wMnZHrN4LLYE/myIo2O2WyizmfAl
	JJnZ9ef0Xfxp3H6EE8LfktelTFBTTDrOr/No6cpJsg5t8sh+QtOECvZhr2NdI0eYIGqIca9IOEA
	n
X-Gm-Gg: ASbGncsLZmr/5stPjRwkVBZg4Bz1Vt//NGubyviYTBDFykLUzaqXrZ46899ORtyXysG
	3QuLTaCToY5tfKl/rujXZeVzcRuQ01/r0QOlgLjJjVD4GktrFXTyU3583MJY2PtYDFYCf8s6wNA
	3+fGBV6DNhQY/J+QZnXkvcMJsu9qnHEbZvjH4NcInNtTxeEy3OSZAadTzefFf6Bc3bz+DIj6XX5
	KwEdoypZYIE+FGFAZ3enyOpAANd8D/P+VfmCPLg9WWE2H75SYqh/a30thz7+/obZne/y8ntpOSZ
	jSsCF+7enKUaGAh8
X-Google-Smtp-Source: AGHT+IE0MecDnwhZClHJ7PgerRYXtp8cYAxIgYswrea4HoSFCj4iDiT/DdG8q//dcV9mlJlAaDCGOA==
X-Received: by 2002:a5d:5f51:0:b0:385:dc45:ea26 with SMTP id ffacd0b85a97d-38bf566240amr315638f8f.12.1737069030525;
        Thu, 16 Jan 2025 15:10:30 -0800 (PST)
Received: from rkanwal-XPS-15-9520.uk.rivosinc.com ([2a02:c7c:75ac:6300:b3f2:3a24:1767:7db0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf322b337sm974991f8f.59.2025.01.16.15.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 15:10:30 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	acme@kernel.org,
	atishp@rivosinc.com,
	beeman@rivosinc.com,
	brauner@kernel.org,
	conor@kernel.org,
	heiko@sntech.de,
	irogers@google.com,
	mingo@redhat.com,
	james.clark@arm.com,
	renyu.zj@linux.alibaba.com,
	jolsa@kernel.org,
	jisheng.teoh@starfivetech.com,
	palmer@dabbelt.com,
	will@kernel.org,
	kaiwenxue1@gmail.com,
	vincent.chen@sifive.com,
	Rajnesh Kanwal <rkanwal@rivosinc.com>
Subject: [PATCH v2 3/7] riscv: Add Control Transfer Records extension parsing
Date: Thu, 16 Jan 2025 23:09:51 +0000
Message-Id: <20250116230955.867152-4-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116230955.867152-1-rkanwal@rivosinc.com>
References: <20250116230955.867152-1-rkanwal@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding CTR extension in ISA extension map to lookup for extension
availability.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 4 ++++
 arch/riscv/kernel/cpufeature.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 42b34e2f80e8..552c7ebae7be 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -105,6 +105,8 @@
 #define RISCV_ISA_EXT_SSCCFG            96
 #define RISCV_ISA_EXT_SMCDELEG          97
 #define RISCV_ISA_EXT_SMCNTRPMF         98
+#define RISCV_ISA_EXT_SMCTR             99
+#define RISCV_ISA_EXT_SSCTR             100
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
@@ -115,11 +117,13 @@
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
 #define RISCV_ISA_EXT_SUPM		RISCV_ISA_EXT_SMNPM
 #define RISCV_ISA_EXT_SxCSRIND		RISCV_ISA_EXT_SMCSRIND
+#define RISCV_ISA_EXT_SxCTR		RISCV_ISA_EXT_SMCTR
 #else
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
 #define RISCV_ISA_EXT_SUPM		RISCV_ISA_EXT_SSNPM
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
 #define RISCV_ISA_EXT_SxCSRIND		RISCV_ISA_EXT_SSCSRIND
+#define RISCV_ISA_EXT_SxCTR		RISCV_ISA_EXT_SSCTR
 #endif
 
 #endif /* _ASM_RISCV_HWCAP_H */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index ec068c9130e5..ef3b70f7d5d2 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -391,6 +391,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
 	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
 	__RISCV_ISA_EXT_DATA(smcdeleg, RISCV_ISA_EXT_SMCDELEG),
+	__RISCV_ISA_EXT_DATA(smctr, RISCV_ISA_EXT_SMCTR),
 	__RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
 	__RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
@@ -400,6 +401,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(sscsrind, RISCV_ISA_EXT_SSCSRIND),
 	__RISCV_ISA_EXT_DATA(ssccfg, RISCV_ISA_EXT_SSCCFG),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
+	__RISCV_ISA_EXT_DATA(ssctr, RISCV_ISA_EXT_SSCTR),
 	__RISCV_ISA_EXT_SUPERSET(ssnpm, RISCV_ISA_EXT_SSNPM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA(svade, RISCV_ISA_EXT_SVADE),
-- 
2.34.1

