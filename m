Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACF722D4D2
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Feb 2025 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738826611; cv=none; b=rj6343teXdrfNelMjYb/GJc4nMBTLT/AnnXZxte4FkXeIqkwe7wAYlIt7ZT4ZlfiAibN/7clKtdXyY+w8Nj/glbH333YMoBWwEVgZYcKyRyWrmf5MhtMZvA0xItMO5Ar6vdrdDId3L38Lj2p6UBUhRLeff+L1gmyau1/6WxhFKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738826611; c=relaxed/simple;
	bh=HHH1zghcNvQXpV5wj4QvWZZiP+q6wghkX5W0XvlVWCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CKRCAFOmz96QREhYtqmilZYbQo9F0ZSmbEidQxDB3Ry5DddimITW8dd8aJbnieXN0vlCYlr4Sa8HJmysZ2fLaFw+wgudtNGfVSbrXwpLdLs5Ez9nen+pwDXa1PZrrBfU56Xld1xJqJRWav5UjRjDgKh1QXq+9aFfsSYt8WEAg38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Ye+lZv22; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Ye+lZv22"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f441791e40so770637a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 23:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738826608; x=1739431408; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1ycQPnopfj+lIzIUm/dRgw4jBMxR4nO8n6QcQamF/g=;
        b=Ye+lZv22CEuz7dWWpIM2ZTiVPxBwpKOSbRhu00GGh0FjXLSnrV1OWsoeb/TkThAJHE
         mzMowQHjO5q5HfVMUoagdVA9p1XcydJydamHWhWB620LKqMTIJQ+AhfTKy2UADwiGJGt
         P/HR7nMFjVm26+xWm26fqiCd9mNez0A+3/SHWad/38+YqUhHcnsF9HbX79r26IqByUhE
         0ro2qvteimqhiK9Yl7D8YmDd2ld8AZc6zbvNu0+R9sCzQmiM0Gcq8NHrJEdXFXFbeAIk
         qfcJP0XAVge/Ev15fbEzxq9Iu8k5DSAU5+M+WH2L6vn/etiIlBTijZL/xgX/0/VQJDmZ
         Hbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738826608; x=1739431408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1ycQPnopfj+lIzIUm/dRgw4jBMxR4nO8n6QcQamF/g=;
        b=d6p+CHxeDLlrmpTmsop2ywLDSnon76NWMUxj0+stix0sOkOVTWARqKL+fh7Ya0O9JK
         Qd84LlxWgyxZJQnuhAUPLIavBczUs+KicQbtMUf8WX90EGQyGEE0NfpUYIO9leyTOeez
         zOQvGiepnsdtObHGMlsd75ir6Nj/8yk+QjQ9G8PFlOf+YzZuMiysyEoKW5XEf1G4Qvef
         U0oRZbAY8PTRrDIYVBIGxX46sRDD59hZqWOZ9NOsUr0i2QKTuzrOtNWy4Jq90fc5kry4
         DEnwkoo1BQDoERs331m6C/02Ox29hs5OEwy77uTcoDg1KDo241ptWXxUVMunqd3zW+Y1
         KKRw==
X-Forwarded-Encrypted: i=1; AJvYcCV+M4KyKcNP/bHiYdz9z7/dA+yK3N6LXSHTjVdspNrAu5qRD9wsiRJyUEoFmSq3VRcWcRtiohM2pWi4/VAm9l6C@vger.kernel.org
X-Gm-Message-State: AOJu0YxQCSqGjDL2hjCIuNhnSbiHtrz9UUHLmnTfpWJw3JviCB0hibw7
	tQ3Zy4uA4mCPcbAW/4m0pNNAFvOPo7PzkZzBpGWFQ3dBu10XcYRpFCZPHYlABIg=
X-Gm-Gg: ASbGncszLPi3ZcOZRQbl6JYSaBcBwaRKCYdVprGD072N8mowX90Fw06/h7IwfK82HMs
	KP1UVK52nXZHmAXb5C8vhs5AC18Et/viRVeG3gN8pGoKCDRzOsVVO+IorzbpsZxJTdklOM7muO2
	nD2Bnn7KqMKSEI286KD3UWK2rmdoJ6KxdlJ24Dwfz5woi31ujlhlFV0dOqTnJ+DrEDONrfDOKp8
	9CxOGCZGyvr4JibdWiX8hm4u9RO/DeTcDYYgz5B2b54qqUOLTiwN6dsAxCeMiMgfOuZ3wPovCPA
	/WupKGsZYjNjMiclxM2JbIXTE9ge
X-Google-Smtp-Source: AGHT+IFwe864GICHNnq9EVCYpLvbwfcMr9HibfAj+2D5yDDYG7ZeHAVPjVfRo7yQfH146FLB/di+WQ==
X-Received: by 2002:a17:90b:1d87:b0:2ee:edae:780 with SMTP id 98e67ed59e1d1-2f9e0793401mr10185856a91.15.1738826608431;
        Wed, 05 Feb 2025 23:23:28 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a72292sm630883a91.27.2025.02.05.23.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 23:23:28 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 05 Feb 2025 23:23:13 -0800
Subject: [PATCH v4 08/21] RISC-V: Add Sscfg extension CSR definition
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-counter_delegation-v4-8-835cfa88e3b1@rivosinc.com>
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
 Atish Patra <atishp@rivosinc.com>, Kaiwen Xue <kaiwenx@rivosinc.com>
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
2.43.0

