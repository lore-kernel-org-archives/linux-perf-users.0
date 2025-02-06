Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC2422D4FE
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Feb 2025 07:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738826612; cv=none; b=Gt28W+bC4+1nuY0LYhsanOuHLCj/TU7hUXc1VZnZX/I72cB6MLE6nvrIGGemUrw5JJAhO/t9dRIgUVD4sBo88rW8xks5LLyJQJnlQw1g0NYvyzauL8WttxWuJP2eNE3nFTXKQkGiXHS70nB6h8lhErLLSOoFpgeQnf1Yy5G83pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738826612; c=relaxed/simple;
	bh=Cw8hFyaXgWy3bdMMjpJ7k6K4Vod4OUBAmQtKBzIis4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p8dyOp3sdOVqVdmjlFRbP1hQx9KXJrCR3j7U23VvlR6Roq5vwTO3CwhE8Z3pR6PIeBFr39mScTLffzyTkA+tya/k3fZ9gIraIHhRL8pfNSdQL3wfAfcvJ7VxyP1g8qsq/SFLuGbPDwvyYQDsEHAr4KMhUDO6dzBDR0/+5xo4vzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CF2o03DB; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CF2o03DB"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f9d627b5fbso955605a91.2
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 23:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738826610; x=1739431410; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nYw8eDaBPoa3lZTMqvm38RPB8/mlpG4q3+7Mk5EH9kg=;
        b=CF2o03DBBQXjqy2rAabOZOI0ks1+kzNgDtZ+sh2plQt9LIT63z2tfyp2xTGewu/ZjO
         d2OvY2BJiko+sSlB+4htIYejV0wKgfj5zpzLjtrbzY0v7QElw2rFW0JgB2WfMMhfrhRa
         753pFhOVtBTJv1rWw2IsKSlivRZCnjlS8uGpvhD1OQUWoop1fg0n7YKttlcn/VJ5qiJw
         um6zeb30Sk8UI62aD63Kc62iJ66Y6FLGFob3PlkbSBpT7WpL+s8Zbd+Cnzekwdlp6eDN
         Ot7Uk5JZch3MJWxc55J0I9JYliJW2Rzvrw9QTSxE/SnHdfiggHXIVFRxz4P5tVb8UGqN
         WGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738826610; x=1739431410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYw8eDaBPoa3lZTMqvm38RPB8/mlpG4q3+7Mk5EH9kg=;
        b=vHJgH46D9yJap4HDxG9EyhWI3vx6mh3Q4NoMjuWHOB3WxPmx6zkDjAk//oHpzLs/7A
         WdxHBb1mHoDqAp6jRia2UXnc0zZmuoEYZ+q/gU4HU++re5rhlcwlWz+MhA1JhFD3F+i6
         28gGQndbr/eSrhNRuxofGViXaoKZFy4CYud1IoYG4sLQ5zY9rzGgXY9SHb0GxSx43/cT
         3SOtrSFhZ9OES1LIYQGG6THB9132YNuIUTDIh1jDnklm0ZlaVb9Qrru9HcOY1IkDtA6z
         iH3W5Jl7uipneW+Loyz1R2zAU2DB++pMw7+jnms96lAns7Q3YL1wmTkLWLDp0qfQqYpr
         A7Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWpSzm7qECGG/9xAyA8cDy+BxXMFy52vH0oJzs/88Kouu+gZsmt9ZMd4xiJQBBfUnnhOTtT//QZXNwzm31HWLaO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1OiTq/HREABG0nXHImYA+KDfzWR60KGjX2jSXwC1qWULvK2HV
	gChbTUO7K/kXKv/m7IIf52AQY1eoCg8tOTyC5SjA0HRJULLSVa0YVK+fEdX4eX4=
X-Gm-Gg: ASbGnctacZgw3dIsxngmXMgo/FTJqhBMvVNKUgSoSmaHkzGkIzfwdQKjtptV5iGsWw1
	dnSs6fFDPSUwP38skLMGqVJHJ23K4kx9IRw9F14BZgA/1z2DfcN4eSmN/vmaXeXAs5eGli6MHb5
	Y9TWKapQWxk2ly4crObUqtP1WClIknTgMTQw+9ailDkBn93f2ZkmY4iX3ElyXs0WrFXhMenRewe
	xWqF/7DtbWEuORivZHbHJfBhhIQK0KTkbL0PnwufRroPCHH+RTPpDX8i1GG95UOoLVV3GEfrelA
	mjtE+ysUZpe7GnO5ulyGaERwpmKx
X-Google-Smtp-Source: AGHT+IFmp7b1yh0QEKdLgrjIIYD49wESbW2YfC1lavQg5SmkfBv2dPjIMLPytR1zKx8iqVccmwXu3w==
X-Received: by 2002:a17:90b:2b4d:b0:2ee:f687:6acb with SMTP id 98e67ed59e1d1-2f9e07673b6mr8850611a91.13.1738826610015;
        Wed, 05 Feb 2025 23:23:30 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a72292sm630883a91.27.2025.02.05.23.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 23:23:29 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 05 Feb 2025 23:23:14 -0800
Subject: [PATCH v4 09/21] RISC-V: Add Ssccfg ISA extension definition and
 parsing
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250205-counter_delegation-v4-9-835cfa88e3b1@rivosinc.com>
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

Ssccfg (‘Ss’ for Privileged architecture and Supervisor-level
extension, ‘ccfg’ for Counter Configuration) provides access to
delegated counters and new supervisor-level state.

This patch just enables the definitions and enable parsing.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 2 ++
 arch/riscv/kernel/cpufeature.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b4eddcb57842..fa5e01bcb990 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -103,6 +103,8 @@
 #define RISCV_ISA_EXT_SSCSRIND		94
 #define RISCV_ISA_EXT_SMCSRIND		95
 #define RISCV_ISA_EXT_SMCNTRPMF         96
+#define RISCV_ISA_EXT_SSCCFG            97
+#define RISCV_ISA_EXT_SMCDELEG          98
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 8f225c9c3055..3cb208d4913e 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -390,12 +390,14 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_BUNDLE(zvksg, riscv_zvksg_bundled_exts),
 	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
 	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
+	__RISCV_ISA_EXT_DATA(smcdeleg, RISCV_ISA_EXT_SMCDELEG),
 	__RISCV_ISA_EXT_DATA(smcntrpmf, RISCV_ISA_EXT_SMCNTRPMF),
 	__RISCV_ISA_EXT_DATA(smcsrind, RISCV_ISA_EXT_SMCSRIND),
 	__RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
 	__RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
+	__RISCV_ISA_EXT_DATA(ssccfg, RISCV_ISA_EXT_SSCCFG),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_DATA(sscsrind, RISCV_ISA_EXT_SSCSRIND),
 	__RISCV_ISA_EXT_SUPERSET(ssnpm, RISCV_ISA_EXT_SSNPM, riscv_xlinuxenvcfg_exts),

-- 
2.43.0

