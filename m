Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E519226187
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Feb 2025 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738826606; cv=none; b=qsCo1G3aqpNuDGUVyJVDv60ZE0WcBfmVnP/ebn/h9qSna/hyHohMJgbA23/LVp7KATehn6EWuBZB12JfMXvAQCOMaNFfKWt2V+0Q4Vi1lnb6EVLSxmJ208dwj6W9BS0z5vqA6nRukoP7uueO/Y/J+LCGy5JsErAyx97+7w7fzFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738826606; c=relaxed/simple;
	bh=w+WG3/hTVbYWnKFaU0I9UFeLZ3mNLhg68etVPwj0GZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wy+rrL5WE5Yn8mS1arW7Q/IAYnjxv9Dmc4UEK8IYyqvXEyJDIlmPxX18EbKn7YVSkDwCV635+E8qs7LdqfPUZDJvNiYYHzVA98Wy/7odds9eVOZN8SL14j1ilqMq6ypX9HTZfT0vA21xsS2eLy/I9Qxk6dr7ZyiRbxClv5DGVtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=r1mieA6W; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="r1mieA6W"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f9dbd7d80dso1083085a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 23:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738826604; x=1739431404; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zw3zbGTAqHMsJs8YvOYpRy60tVdSbXNH77zwDO4GVCI=;
        b=r1mieA6WPzMFNUNCiwIXCQkPVgAVonI0YM89bZnNMmIr5/QB6MHBW9nqPqjPefzqB3
         9hZP9/E15Paw1kYUqGPDdReyDr3E7I9lOalma3daSPtPm3pXlbChcVnO9LqPBFdr/713
         z2SAHiXvjsVkVICaEBMuDCdBJo/ZO2+WhqCGNrF57oXSf9fRHhasI/UCFBDn4VcVTPkd
         Gu65MoLB2Ou8lSrmFSXveD//assCdMB/lC0z+E/T0XIinLpJLvrW6AA5YYTMu8X4+KaI
         2ZRU7HIUfV0y9pVoQiD28oilbFxsxjkhHiM/STmThSt+f0z+0JKV8U8+yccuCJWPbxyW
         L0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738826604; x=1739431404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zw3zbGTAqHMsJs8YvOYpRy60tVdSbXNH77zwDO4GVCI=;
        b=nx5S3IE6H1IP9FvkKAVKCoRS+iqCwIs6T4lOrnaP7F5Y62W8raR98C/HXnqAqW8GU0
         IOxngYx2LP3O0SNPy77lfrtPcEtADtOsIZ8OYHMZF0kZaIuk0X2Vlz4i9JrvD6nunpFm
         1pzweaCusZC24VYtVuSHxO1YMR/STfgNmY9SqpkojllquihPn/n6jihJRSZujH+jYL6b
         gNgBy07KKCbXhjBr9NYJ6+6A7vljSCZNeyDjltQc+8Ip7JVnEi+xiQCTM5PsLokm/JW0
         8TwTvKzi6THSVEPV/wN3ksrlvYho/moSURNRyrPoABRUwYMIXySp9fkMMroiQEhfA0vx
         vDOA==
X-Forwarded-Encrypted: i=1; AJvYcCUuBMAgxNqWMDDfci9zaTGpZRfCTVgKhKyBdnUXKYS1zuCle8xhzVV3YxTpZmALPFvF/wk8A5SsTuk2/KR+C23H@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz21YhGEj6mCt/awmkJuWrMwec4ICiSIyDX5xKTvUzdquaOboD
	0UPyNOwD/X0Fnszg0/jnlAa/on3hW4/kO1nrGg7yXZmC4ZIXlH1VyAnIs/hWJ7MRuW0TIysHW29
	Z8UA=
X-Gm-Gg: ASbGncvHPaGnQYVk3sIHoQ9Z7N9jk1J9a5dM1kvoMVfMlT/HeYXWOc8r67a0cbCI+ND
	OQctJCCFZbRrTsezK8jkl8/bHBxFiyBscaXiOg87pB8PBG5B/pc+o/d1TSJUXA6ATMrylETWKnI
	hI8aYn25as5r9A4KE9qxMJdBHKKtzC6QEAYeWv0ImtGto7EKVuRbRtfO+PDQwP5dQ2Gz5oKb1Ar
	t5mD6byfxQqOcb4vMOGOaCTZlY2Kw24py8uTRQlRLfkKBAfmrx2TXcbLrYoMZpLB38HKAyYQfmU
	SbahgNtdnHdGy8nfTa5Rd1td1vhf
X-Google-Smtp-Source: AGHT+IG32go+lZuwjCgg/zbLptZ9A9o5+Wocjk0VyZkgS2Pr3FK1vOOJ1tss0czCWnqvvWKX+hfRsQ==
X-Received: by 2002:a17:90b:4c4b:b0:2ee:aed6:9ec2 with SMTP id 98e67ed59e1d1-2f9e075fa50mr10140486a91.14.1738826603728;
        Wed, 05 Feb 2025 23:23:23 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a72292sm630883a91.27.2025.02.05.23.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 23:23:23 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 05 Feb 2025 23:23:10 -0800
Subject: [PATCH v4 05/21] RISC-V: Define indirect CSR access helpers
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-counter_delegation-v4-5-835cfa88e3b1@rivosinc.com>
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

The indriect CSR requires multiple instructions to read/write CSR.
Add a few helper functions for ease of usage.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/csr_ind.h | 42 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/riscv/include/asm/csr_ind.h b/arch/riscv/include/asm/csr_ind.h
new file mode 100644
index 000000000000..d36e1e06ed2b
--- /dev/null
+++ b/arch/riscv/include/asm/csr_ind.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Rivos Inc.
+ */
+
+#ifndef _ASM_RISCV_CSR_IND_H
+#define _ASM_RISCV_CSR_IND_H
+
+#include <asm/csr.h>
+
+#define csr_ind_read(iregcsr, iselbase, iseloff) ({	\
+	unsigned long value = 0;			\
+	unsigned long flags;				\
+	local_irq_save(flags);				\
+	csr_write(CSR_ISELECT, iselbase + iseloff);	\
+	value = csr_read(iregcsr);			\
+	local_irq_restore(flags);			\
+	value;						\
+})
+
+#define csr_ind_write(iregcsr, iselbase, iseloff, value) ({	\
+	unsigned long flags;					\
+	local_irq_save(flags);					\
+	csr_write(CSR_ISELECT, iselbase + iseloff);		\
+	csr_write(iregcsr, value);				\
+	local_irq_restore(flags);				\
+})
+
+#define csr_ind_warl(iregcsr, iselbase, iseloff, warl_val) ({	\
+	unsigned long old_val = 0, value = 0;			\
+	unsigned long flags;					\
+	local_irq_save(flags);					\
+	csr_write(CSR_ISELECT, iselbase + iseloff);		\
+	old_val = csr_read(iregcsr);				\
+	csr_write(iregcsr, warl_val);				\
+	value = csr_read(iregcsr);				\
+	csr_write(iregcsr, old_val);				\
+	local_irq_restore(flags);				\
+	value;							\
+})
+
+#endif

-- 
2.43.0

