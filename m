Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A7718C91F
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 05:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738040408; cv=none; b=Kgg+Q8eWVYn7QgakjqJWpGMJoY50IqJxvO6RoMYyjOE+Tj1DWdSCOHUQnqMwxlgcC1hkgl7X2iVBCvd5WMr6dQrlQnfTJkdJLcKpFwwd3PBcoayS36Xa0pLQXG7SlU8uJ/xrTielJP6nCDv86dAlVwzxI38A42UbDKtDneobosw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738040408; c=relaxed/simple;
	bh=lgDPl7XeyZ3VsFlwl0qRhI6mGZXrHGPpz/tt601F8DA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tlcm2CYmY9PZWeu4mpNGnYUGAYA93ae/M2wBkF8Jt2OFl3tk6WErrpJNSAYlnqq2ZbPc9DCD6cyi1lfG4kzEIB3GRXXqLyNYwZFDzmQ0bE9OAf9Tp4lskk1Cq1LdD/vfvlCbgjSA7pIcxQq8UT/o6/+WbHGgYCV4tvHgPtY2F6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=quL4OjKC; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="quL4OjKC"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f4409fc8fdso7986533a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 21:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738040405; x=1738645205; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8nwB5ijQXYUTHkLWAXohil6yVgl/NyKIaGqyFvphby4=;
        b=quL4OjKCyDsBiuWswt5xXC8ILMOVGolFt8YnY3xOGkvh8Z699cgyNET8hITBlR1xS1
         SsDttzlCmWrvGKil68AFFzZ1QLEUo1mCaEelWNVEg7VKuu04ydr+v6PGl05HvdaeBb6A
         95fT+iHtjwEgqIRnNMAK9KntDhBZRypAojNuAfclFhCo0ZnIT3C1dvxl+iaatv/B78q6
         80WUXt9jUgRQ66pQZIF/Vtm1Z1datfY3dkRISDisGCMSm6pxht5r/96RtSIoLsjehp0a
         EvdJIe7bxJQSfUy4zvfNgOwNkRqrJxbDROcpbiPBNsdX5zYYGQ81vtjwwkf0g+xqKEHi
         driw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738040405; x=1738645205;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nwB5ijQXYUTHkLWAXohil6yVgl/NyKIaGqyFvphby4=;
        b=Wzx3//4os/vO3rSn36vu3yfdmqyz2BvDHSTq2vpi2u+sfRn6LrRAvo7J9u5TpjAAG+
         t3V1uv4VoxCzVV4w6WsA3KYROPdKa7PQ1sdu1FQtGroi9jaPEV2fcGNUaVfZ4N/pOTcR
         99lDnrqKdmy2w0WkDOuuBGrdffoge/zpBDWTevCeBeofEe7pDhQ8O1kdt4teMNwIeITJ
         RIgGiaI7tT2qunV1sH1FkiqjmxemI2xkY1WaffjTJmAAbsk5Px+BNEdW5XdAgAavgCGu
         8EJGLmGyPGf27i49w8Sjx3SysZP4NLMCpKNDjza9zNFIlXpp0hx/x4ffzZPy0/209fz2
         VHAg==
X-Forwarded-Encrypted: i=1; AJvYcCXVuw0kKxxfekReTJWBJUDnydbKGch6clNUprypRIEMjYYHPEameDP6q9VCcHyBS5ixsHRS9NkyU4jTQrUjaJkS@vger.kernel.org
X-Gm-Message-State: AOJu0YzQg1NQguleSxIH0rg1tyCU4bKTIjxUtx5hbAYrbAjuaflwrxmH
	mv1G7/Uj2/6x2JE/cdt1e1bgKD3b0MoW21ooAKjG5z7tToIm/6HLu414XWY/+s0=
X-Gm-Gg: ASbGncs3PMNG+Lf1KmMFewVmEZ1SKbi8GSfaALup4gOEPgKxu0TRGD7mJu+xj9u0Wv4
	sLOF1/O/34rhjfrkBrtwD0pOqDUsVnrHcIzv1iHq0UsOTpsyz6Sjr3bxzCeM4TS6LO0eVZtH1Mk
	oIqgSPyRkhixxh8AsJlmSJ7RpcHQUeWvm74jh/s6s4cuI29yu7IFoDIkvf9cmUaEgADw9SM+62l
	wrond/GEMRWA1h1mY7cv6tHsnnwnGzQbrZS7VsFA5wj6945voaDA7sbtJdu3XgZAkI6sW73Y5Ck
	rUjlOWTgjPfqm0peZOwRRlRSEnZG
X-Google-Smtp-Source: AGHT+IFrXpURXC6IeRPpOGWg3/tFzqB6mJrEgvaEoQuFlLXK7BO3fm1YNKQtwAqXg3g7vbpjjvAXGA==
X-Received: by 2002:a17:90b:54c6:b0:2ef:949c:6f6b with SMTP id 98e67ed59e1d1-2f82c0d31e5mr3090153a91.13.1738040405414;
        Mon, 27 Jan 2025 21:00:05 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa5a7f7sm8212776a91.11.2025.01.27.21.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 21:00:05 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 27 Jan 2025 20:59:51 -0800
Subject: [PATCH v3 10/21] dt-bindings: riscv: add Smcntrpmf ISA extension
 description
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-counter_delegation-v3-10-64894d7e16d5@rivosinc.com>
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
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

Add the description for Smcntrpmf ISA extension

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 1706a77729db..0afe47259c55 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -136,6 +136,14 @@ properties:
             20240213 version of the privileged ISA specification. This extension
             depends on Sscsrind, Zihpm, Zicntr extensions.
 
+        - const: smcntrpmf
+          description: |
+            The standard Smcntrpmf supervisor-level extension for the machine mode
+            to enable privilege mode filtering for cycle and instret counters as
+            ratified in the 20240326 version of the privileged ISA specification.
+            The Ssccfg extension depends on this as *cfg CSRs are available only
+            if smcntrpmf is present.
+
         - const: smmpm
           description: |
             The standard Smmpm extension for M-mode pointer masking as

-- 
2.34.1

