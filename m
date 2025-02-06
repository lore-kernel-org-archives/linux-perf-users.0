Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB419225A46
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Feb 2025 07:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738826604; cv=none; b=hxRD8USKomaPFERvmkk2xV/iiSgVjQnHInG/+AoFyXxSyStQ4GhNo3I8mbkEqwZaVH4zdzYkj1Tzx61m3+LpAumxbpM5ztMtjktFf6vkcIL0CGlfpHr1ABV57ifLDNpRYHsQOEQ85fOZqnu41edoukidpOpRZZizD2UfMB4xZTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738826604; c=relaxed/simple;
	bh=RqSSON5eVcBRgVyPFWbMdlHCMx4LYhF5jWyiKPtESMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RCzFf6uJ252n2FOcNMT8dtMIkQ+tPVwPs1Bmsjg21rKFDygcDYyCvp7h9c44uDHaBKYIB8qhuRe0sDQDndU5+JPXemHh+puija8FtWQ2zZ7E6RsWPYKetOajQ8mwYDEgQmzf43W9tGM7CbZsNviHutQ/IIES+Q4Q1dfuKDEQSEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=iD6Nlc5F; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="iD6Nlc5F"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so988161a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 23:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738826602; x=1739431402; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2CXRkSzd4LW5IV8mtGWOkMlVaZyNScQT8kSGB+ZHxc=;
        b=iD6Nlc5FoRTnHJZgjmwnyueISYMOPjVDEfqc5HBYNW3cgqR79Bf3db+Du6F8iPnUU8
         Gm3j+lNXM9MvklADBbfzDkCMuqkUowc/6xXqDfcU22f+dd1lX4biiQz9D/5DZ+6BtJeO
         my+TUqMQa8VjLZrGIocEivZigap8nAJy5EddtTeg61cHAaRFPa3TmSDHHWbvZWfQreWX
         3d3/Jx4dprkrc71So5JW+j3p6oXBVFhs6gqw3sWStNAsGPkrBwJw8T3M5vANNS2hRTZp
         l22sLPhoMSphvNgCdMiQWeO2kWRF02le36WntD0ZmYw0FVtgvQR4IgrMYjfE2LIh7TeO
         0Irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738826602; x=1739431402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2CXRkSzd4LW5IV8mtGWOkMlVaZyNScQT8kSGB+ZHxc=;
        b=oQTXpZK/GIIYGWyjdzFx+Pyof5UxKCRWe1E1d/Kh2v7I1MpMqOg1rW0hUIn+pzpSc/
         +tm41TATgl/rFaLsKigAXexcmQR4ojOMhxZObOi1t/BnTbJIKwYgdCioJI4tHflfstFo
         d4pJmaIq6DHJYmtgWCv0vlx1mkTwOKqdCuuvaP41R4/MvmaqAt2BX6/QqTSojteVj3Zx
         5cqXcpQEtqvIQH6iztlEWG3jd6kraP2YYPIwpaXSG6qgDeSyKb/AnSQW8hTd6tsgATM+
         a4P1iVsqWjWP5gX3J0ujqdGvHFtEnekwa8Fjk1ianTzWs45Pnt/DJEG/pW8K9HuBVvEw
         qZEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm9iFV/Wpvob/nD1M5n0Xf5yVoyTEC1XNF4Q+AIbAmr9R5iLPdHjDvmpolbpS7H8I3PcUmJ4KoOvoYzUQEnY8L@vger.kernel.org
X-Gm-Message-State: AOJu0YzyUGb15YLIoFnocSBKgEEEHYGzuDStuyykjWjYXy8KVKIW6VbB
	DMbTJISJc8785DNKD69CvjSjR2XnZfDaUvR0yIzKk67O64LwWxdjOf+Cs/zXhjnTcvsnMo4iAjQ
	vTzU=
X-Gm-Gg: ASbGncvY8cj6+w9aWzmYmUvo3UtCGP3u9HkrnUMx7ahZT2obUtMUH0ukaW9ihIn+bgo
	C3bqBx73BAQbZ90lUOBlf2i2TuGmrLQP5t33OembTGSGmCIZQKOIXxGbSwEY4hSpCVwOvc8Mhau
	aegAcSUhbuvXWfYwZTs9EERMBheI2CT5gxKZejjHWfbk5E9BjK7Krm9+xpGMAwcatwWo0iTLeoN
	Ec6Nzhr9SI8jS8tJIChpikwX+JfSAothvfcCZcWsuq2ZRvA/lStkQivEdpqyDdm/iFVJ9PI5Ubs
	EmH7Y891hNGVpz1AMouoENhQ3Nyh
X-Google-Smtp-Source: AGHT+IEsdW7e0nnU+hOuQNSvBNjT6hUmPYli2IAeU6lmXJs5V7j20UKpuutlBvTAACwmkO+Xy8ldvg==
X-Received: by 2002:a17:90b:17d1:b0:2ee:df70:1ff3 with SMTP id 98e67ed59e1d1-2f9e06a1b1dmr11330512a91.0.1738826601990;
        Wed, 05 Feb 2025 23:23:21 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a72292sm630883a91.27.2025.02.05.23.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 23:23:21 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 05 Feb 2025 23:23:09 -0800
Subject: [PATCH v4 04/21] dt-bindings: riscv: add Sxcsrind ISA extension
 description
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-counter_delegation-v4-4-835cfa88e3b1@rivosinc.com>
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

Add the S[m|s]csrind ISA extension description.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 9c7dd7e75e0c..42e2494b126d 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -128,6 +128,14 @@ properties:
             changes to interrupts as frozen at commit ccbddab ("Merge pull
             request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
 
+        - const: smcsrind
+          description: |
+            The standard Smcsrind supervisor-level extension extends the
+            indirect CSR access mechanism defined by the Smaia extension. This
+            extension allows other ISA extension to use indirect CSR access
+            mechanism in M-mode as ratified in the 20240326 version of the
+            privileged ISA specification.
+
         - const: smmpm
           description: |
             The standard Smmpm extension for M-mode pointer masking as
@@ -146,6 +154,14 @@ properties:
             added by other RISC-V extensions in H/S/VS/U/VU modes and as
             ratified at commit a28bfae (Ratified (#7)) of riscv-state-enable.
 
+        - const: sscsrind
+          description: |
+            The standard Sscsrind supervisor-level extension extends the
+            indirect CSR access mechanism defined by the Ssaia extension. This
+            extension allows other ISA extension to use indirect CSR access
+            mechanism in S-mode as ratified in the 20240326 version of the
+            privileged ISA specification.
+
         - const: ssaia
           description: |
             The standard Ssaia supervisor-level extension for the advanced

-- 
2.43.0

