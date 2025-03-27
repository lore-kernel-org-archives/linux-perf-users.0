Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0F221C192
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104182; cv=none; b=Ld6QsHFuvuDD5M8vM2LMpyJAf8IQ/XBWKb5rluKJfi+62uM6JbDUccz20tp81PscAqgqg1/jT67EXxgDqEl1atCAYLppZ+u+k2U180zPVARGBUYYFcQahDvDGgx8xJCyneaoDc46KrbvUYxTL2ed7tzsYCOGfFoO63VQC87BZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104182; c=relaxed/simple;
	bh=w+WG3/hTVbYWnKFaU0I9UFeLZ3mNLhg68etVPwj0GZk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nqpnkKgvQULVnwYYy8MHkOz55ZwZT9NWhP2EkP3McuLFz6xBsAVcFFVmJ+G6NHbEouoSbGP1GE3fjLFAqDYmEIFcYLKrlhK+zLK/BOTB6l6fVn5tJF3y0zIMxt1vbVZLaDlp424SFhuk139oIK8FZ+3lUZ4/f9nIjXAaavhM5GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=c4IpcaFB; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="c4IpcaFB"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30155bbbed9so1804410a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 12:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1743104180; x=1743708980; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zw3zbGTAqHMsJs8YvOYpRy60tVdSbXNH77zwDO4GVCI=;
        b=c4IpcaFBL76BLHBVNgKS1L1650FF/45ql8tkIYu9zfIr2Anf7xsj3B3Yn/j7cL6Toe
         5Wu7KgxfJF3PNDYSckTjGAATSdtcHhL9auMyXxR4l8ZsWivDGEpEPtk8/44vk+fCSiTz
         OTtDgMwhfMwcV29vbP/Q1d4bpPM3M4npr5tux8CbB5l3w1Qp20Y8TuJprVQKipsPHIHH
         Ev84V0PwtoU2OYn44JoiRpohwtLW4aEZ8c4OyH7/eBYemKePQyxkmhQDC+mhwx55cw4D
         UB7VQitGDrGkNetkqCV2yWblMmNGpnyDb0xud7f9x6w8Vaeu75bPAQs7/ns90nMhSw/G
         Vw8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743104180; x=1743708980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zw3zbGTAqHMsJs8YvOYpRy60tVdSbXNH77zwDO4GVCI=;
        b=PNlTkphYwKYxDDCpiyy/enpOnTyA52bFq1Ux44ftDjNXaulVF9lERMbNnDRcqRwQV0
         qvEkp4e9+AnOXaKyHdllD/OaKwtkMSKQf3GfDZXZSeym0/x69YvtPcTj6p1lOmxkYX3D
         OuZyHt3V8wofcbQZCrGZAhO/9jMI0IG+Ba7TqFLnYpAhv2C42j5RS7Lg6F09G3t4+Uco
         90BpKMNcurrqhhBNa4ST8rzIswCoJeFlLWQq6b7qqz0ZVS6zuZG7LsFM+Nk2x6e4NfZ4
         FCdAlj9Q/Gl5ehA5qbo7F9xVkBDIfIv4WdiiLhq3GDz/t9WZvgKyCmg66M9+jeGqAqMF
         nx6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYK/HtrRC5BK2u4UcIw6NiZAwZ9xNWC0q8hFa43XDTUBMJgpJcURULCLRHv8/DMhFhkBjbZeYjMJ44adBYcQDu@vger.kernel.org
X-Gm-Message-State: AOJu0YyLzB6Wcz+KbNI9oRX87SIDcrSqctP8EaKSqHMjSxRLkaG7N1AZ
	9EXhtjeBqLmPp5BQPhS7Uic/yhQjm60NwaeV7t9vlcv8OU/7fd7Ay6P7pOiR9R3bQGpNzO8SVni
	l
X-Gm-Gg: ASbGncsuwI3BFeRAH3FygMUjlH3sUV0ldcXehwtKSgnTHg1darH9dqfMBjGW2pgdo3i
	bfPgHNl9BeDlNKuaiy1GY6JFlWBuh30HjEN0Tulp3cHiZ7kZryAOYG1l5Ik8MCufqd+pvU7VdRV
	3RrIj5JQ4cj8B31d77o7no6PUf4Z1sGmT0zeJMI2lAjtYgVvUandszEHpRDzuw4ufEB55a7RLpz
	QMKNeoWsMlMQ/HuVtzf5t6r+8vF5ZXBL2mGTov9WCyW72gOnPYnVrqPK04jauqvFYJZgOFT+6ZP
	wDCjhJcKvcS/i7fvIBfmShTe8ytBdGou2lk8XnRCtw1ukvSFjBV+XLZBXQ==
X-Google-Smtp-Source: AGHT+IHpWwO+ALT63AnEQfROc0MsU9HJIU94/2wnOwykaqK6qJLji7kuLw7H0FVEp+QuB62Asb9xXA==
X-Received: by 2002:a17:90b:5827:b0:2fe:a336:fe65 with SMTP id 98e67ed59e1d1-303a7d64066mr7195102a91.10.1743104179797;
        Thu, 27 Mar 2025 12:36:19 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039f6b638csm2624220a91.44.2025.03.27.12.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 12:36:19 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 27 Mar 2025 12:35:46 -0700
Subject: [PATCH v5 05/21] RISC-V: Define indirect CSR access helpers
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-counter_delegation-v5-5-1ee538468d1b@rivosinc.com>
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

