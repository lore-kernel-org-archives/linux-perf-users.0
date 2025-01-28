Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F801DC994
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 04:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738040395; cv=none; b=XP3Hq0VsbNneeY0ozdEekEIkVeOo6v8l3M09hX5UDaYKSXv5JFEUH4h9ctIwyC9onTYpJT5Scw6/KacSp22oa5Jqi2ihYMBhQnDbNSBRgulmdAHlmF+oVDgdYVUtXx3FUXHt16ARE29NdLWz7K2v9hiWSXdG6Fywxw5e+qJs43Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738040395; c=relaxed/simple;
	bh=dEycrqPujNQoyCH4UD+bkihtlTfJcGr4YH26Pdpa3s4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dn4sVkM3+5UFxA9g6G703P6RLw+/axNgxxD6Pmcz3GSPr+5kHKy3C6gT5pgtG7QiqhXky3Lf/JLvbahAF63cfvjgfJgBYU3pGaLzEbkuM8sgRMfByVmWIGjeHYSVNddNPcD6a7n2h4as0nJ63gI4XK2dDhrRpoAutMRexm+kLxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=AU31rmzJ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="AU31rmzJ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f43da61ba9so6861783a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 20:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738040393; x=1738645193; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NxfKG65dTTWELGQSY1XBUvmc4ww6DrMBB5fk3tB2Lpw=;
        b=AU31rmzJPv33n0Qc7iBSxAFKIxLtsNsPEz67yEHrAMy3XbNCV7q071sHPEsoJwiTHO
         gOPu2zz8qwSrCotGu+HOcgv0T1VlUf84a67LLdeBRMRkg8TWPeOMmTOLCmL+YTTp7hbC
         Wkpbj75fQx+nJ3Y3Qx/tMIZjwCYWyuIAbS+UmbpFm1HcVRuboYtzyidaoyogHZgql1m6
         vRninQExaOY/ztj7q1KQVM8JAtJrLnWRL+34RyHC6KeGvDzGaCgKNyurlZRbU0ZdCzzM
         NGjIY4Qq3mmbi/U6fnDBmrL32frml7uECn5T0s0VTyk1CJObavktRh8KXn4mdgAE/P5R
         OlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738040393; x=1738645193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxfKG65dTTWELGQSY1XBUvmc4ww6DrMBB5fk3tB2Lpw=;
        b=RhNpuUOVNpJybY61nRonGcDmEjqH4Qg8jSlptfEwAwRQjPF6ydMykIDG58PZmaA0XY
         WxKLuDq5iaLUdVnex3VMYNvCuUbRpDZtVc5LqmiztMQGGHBkgrPD/1/5mMf3pqiIX+vz
         2lorlNpP1jVQC0lOR/6KM551x0WgPQE6myKPSncy8Rs9JdVGcvjSwYSjlQxfdQrKVkVK
         FrOV4heC1W3j5soyq/JwhP1AAnLFGe6lfLghlljG2DFSEs2rx8YLK7Z3BTJge47DDUIp
         s65/VMKu1YHM7VTQzT14SQzVJWlQErOPNq7y9JAO8FtBirpmaGuZUO1eqp3NfqT4/DOi
         SztQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9Tl9IwgG2BQAV2Y7IXf3vG2y0JFAZeTSI7ycYJ2XNi3AsLcUZMxIVShWO6d/JJe93LwTRBHytIV29kZ2IhYpM@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2FBwscVSi0YJR1yp5EcQzy4u54ltK22YuOQAfIWJSOj3vfL80
	AFMz5+SEGoRce8OMrC6lZZELnOeMNGnmEFj2pTXkSTDqkNpzPGwKrgJTtvYqIAA=
X-Gm-Gg: ASbGncuGrXWyK6D0sN3SUmwpjZTrhPFUzu7ZugzVZgYloFoOwSNrBpAvLSMmo9e7Go5
	4xEqHaZjetuhCJ/xXTC25NWymmKSSVtCJkQ+SB2790kCsVluwGpOfO/N7OMoi25eQ5M4LXNV+hE
	B2Fcqs8apgjamTAKBtXHwmU1B9TQuC1iS8eAD1dtxLcrxPypyLI2hq0uAQ5CbqiIOmjf4mXSrcW
	8VsGwkNqKaWqxomojx5M4VRAPxmEqdm/tRVCv8qV6O8YeSy3bK3DCCjuRCoSdXLWqzcEe3BgAL4
	TSVQ+xTpND30oqyi15Epc/LfmdqL6tHc/blfAxg=
X-Google-Smtp-Source: AGHT+IESukFvE4jgQHaD3G8e0OnXfuu3U2xg6/y3jZ2pizirle7LkpWlYPqExckDpakmelWJ9tr/CQ==
X-Received: by 2002:a17:90b:4d04:b0:2ee:8619:210b with SMTP id 98e67ed59e1d1-2f782d97e04mr58425837a91.29.1738040392749;
        Mon, 27 Jan 2025 20:59:52 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa5a7f7sm8212776a91.11.2025.01.27.20.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 20:59:52 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 27 Jan 2025 20:59:43 -0800
Subject: [PATCH v3 02/21] RISC-V: Add Sxcsrind ISA extension CSR
 definitions
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-counter_delegation-v3-2-64894d7e16d5@rivosinc.com>
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
 Atish Patra <atishp@rivosinc.com>, Kaiwen Xue <kaiwenx@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds definitions of new CSRs and bits defined in Sxcsrind ISA
extension. These CSR enables indirect accesses mechanism to access
any CSRs in M-, S-, and VS-mode. The range of the select values
and ireg will be define by the ISA extension using Sxcsrind extension.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/csr.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 37bdea65bbd8..2ad2d492e6b4 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -318,6 +318,12 @@
 /* Supervisor-Level Window to Indirectly Accessed Registers (AIA) */
 #define CSR_SISELECT		0x150
 #define CSR_SIREG		0x151
+/* Supervisor-Level Window to Indirectly Accessed Registers (Sxcsrind) */
+#define CSR_SIREG2		0x152
+#define CSR_SIREG3		0x153
+#define CSR_SIREG4		0x155
+#define CSR_SIREG5		0x156
+#define CSR_SIREG6		0x157
 
 /* Supervisor-Level Interrupts (AIA) */
 #define CSR_STOPEI		0x15c
@@ -365,6 +371,14 @@
 /* VS-Level Window to Indirectly Accessed Registers (H-extension with AIA) */
 #define CSR_VSISELECT		0x250
 #define CSR_VSIREG		0x251
+/*
+ * VS-Level Window to Indirectly Accessed Registers (H-extension with Sxcsrind)
+ */
+#define CSR_VSIREG2		0x252
+#define CSR_VSIREG3		0x253
+#define CSR_VSIREG4		0x255
+#define CSR_VSIREG5		0x256
+#define CSR_VISREG6		0x257
 
 /* VS-Level Interrupts (H-extension with AIA) */
 #define CSR_VSTOPEI		0x25c
@@ -407,6 +421,12 @@
 /* Machine-Level Window to Indirectly Accessed Registers (AIA) */
 #define CSR_MISELECT		0x350
 #define CSR_MIREG		0x351
+/* Machine-Level Window to Indrecitly Accessed Registers (Sxcsrind) */
+#define CSR_MIREG2		0x352
+#define CSR_MIREG3		0x353
+#define CSR_MIREG4		0x355
+#define CSR_MIREG5		0x356
+#define CSR_MIREG6		0x357
 
 /* Machine-Level Interrupts (AIA) */
 #define CSR_MTOPEI		0x35c
@@ -452,6 +472,11 @@
 # define CSR_IEH		CSR_MIEH
 # define CSR_ISELECT	CSR_MISELECT
 # define CSR_IREG	CSR_MIREG
+# define CSR_IREG2	CSR_MIREG2
+# define CSR_IREG3	CSR_MIREG3
+# define CSR_IREG4	CSR_MIREG4
+# define CSR_IREG5	CSR_MIREG5
+# define CSR_IREG6	CSR_MIREG6
 # define CSR_IPH		CSR_MIPH
 # define CSR_TOPEI	CSR_MTOPEI
 # define CSR_TOPI	CSR_MTOPI
@@ -477,6 +502,11 @@
 # define CSR_IEH		CSR_SIEH
 # define CSR_ISELECT	CSR_SISELECT
 # define CSR_IREG	CSR_SIREG
+# define CSR_IREG2	CSR_SIREG2
+# define CSR_IREG3	CSR_SIREG3
+# define CSR_IREG4	CSR_SIREG4
+# define CSR_IREG5	CSR_SIREG5
+# define CSR_IREG6	CSR_SIREG6
 # define CSR_IPH		CSR_SIPH
 # define CSR_TOPEI	CSR_STOPEI
 # define CSR_TOPI	CSR_STOPI

-- 
2.34.1

