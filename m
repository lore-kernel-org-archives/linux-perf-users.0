Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B8C21C9EE
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 22:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895506; cv=none; b=jFOnTour0PwzIspA2UcnWti5o22mZ4xboPWWoNtGFgKwsRyNtw9bNL0FKKqbTzrDVYv0aAHnO918bEIyVabw0ziTzzaLLk6dMvWrm6ZrXzow6+QUZgp1588QqyvM+nL3pU8XmDc5DxXbtsCjQjZ1G8dZQk/OeTBpH1jwKNO4oiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895506; c=relaxed/simple;
	bh=Vmwsa/ctBo8N43GnV4TfHr9aW95FI1ojPvJ/QsRfYGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rpFqDZ4EVzFSCR5HzM2NTAFYOEGyv3mUueEaM2uSe4nG2ccDOz8levBjLnJRNbZ1gv1g8zPmL8ZuCDvh9DeV3tNbZQCHjb2WRo38KdSV2PCUA2eG0VOlsGRh3GZwHq/OcC6mGp5V+HN0UZ8uJgtamy4ycF9EDsG7GJMo3Yt9JkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Jw4kC5Zz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Jw4kC5Zz"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-219f8263ae0so100312485ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 14:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736895504; x=1737500304; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nuV14UWlVLpKqlK5QJyBaxP+s4wgcBZS80Qr+dhQF8=;
        b=Jw4kC5ZztlXxPgkp43W3EuEe/NdpYEZk+K6frb6Yav7IAz3bHS1VQ4vxn5KNy9u5q3
         sAvPcowJhdTAhmSrs4VL/ML5bPIVheH9WbdVqrV6wEAbln3KBefUp55LMDbDg71YNd4G
         maygkQhQqObjgLuYl/tCHsOX58JNpqAPgCtsd36+70j565yLmAevxF++aiJzEEoTDaIi
         h1I1QTaf+iMU7sB8BZ/fSm2QcOrxF310TgZwamoLAlRen0zUXKT3kaNp6VHBd8puIS/2
         /ynqMmDf6/ddqWxtmeX/fvj6bH2Bmp57NZlwVwnLSxp92GmEgoPp/yn83oM2BKzqvgRy
         meaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736895504; x=1737500304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nuV14UWlVLpKqlK5QJyBaxP+s4wgcBZS80Qr+dhQF8=;
        b=NAUtTXHVfelOpRoL3HWwSXzVAsuW6RmDVr/Fn521AVX0yS4GeFt1KpTMwc+iqsCtpb
         AF6njvSSONo7j9TlTHPivoQZlWgxyahROk8ql7Wv14wW8VAHF4bysPJDAgrd0+4YfcMp
         HxExsErOGeGExrj0w565E+uFPHujGYiAnuGmQL7lpDojH5SsuJFsyIanF4XGu0P2lzy+
         MMKgZ4sEJYoAxwuG+bUk2ir+HbUqSD3n+kxzvVczc7VL4SDgh7P26piD4++3BJ1f+xZc
         7bRF3oyJplWx+dhq5zfQxrBH1vRaNMZaMyGxpU8AA0qbEPKBP0uK1OppuFkx72NEHjjI
         QtbA==
X-Forwarded-Encrypted: i=1; AJvYcCUuuXQHvteAxJyRguQmoUn+MGJrIbuZ2j1fkyeB4MSDJix2yePNm+Icmaii+VP7wZ7rT2XjaH8Y2gHQtpmPZlhK@vger.kernel.org
X-Gm-Message-State: AOJu0YwzkSOMKqjoz6TtFmcB2aJy3FitWIKUOt5mTmxiiqqBo5C3dOB7
	frBoavAIy7zQGfMeIVhWP5ftr4lc9i50GCvQsCmw1Mm+MzD8K3oexYpWiajsiVw=
X-Gm-Gg: ASbGncuRZSz7qKSPvNTD2IPW5g6QYiJrKkUIt382URnx7dJLY+kSyhd2vMbjdIHPGee
	/4aPFmwmeYYdd7kJjcxV+fZv7oUR7+FoB3n+Q8ckx76uamoa3+HDbnwl7bhDQBarh+bzonD0rOD
	Hda9SElizs1kYHbqKUoafyOaDRfhD9OdZ6AF5tLghZaDQQ/G0iIextEAqPjMLc8J2SkB6xlwkdW
	+66uS2+ouf3CWszOdwYRszFewduLNc4UjkKOtD/3InuE1aH8zODV5V9mwm6Ol8uctMLJw==
X-Google-Smtp-Source: AGHT+IEV9xqrGE2EwbwN10kTDKoQE5y094MCv+vKIzLtISYj8DvmatP2DVPnEqTLBoPDrnLS9ZbWpg==
X-Received: by 2002:a17:902:d2ca:b0:211:8404:a957 with SMTP id d9443c01a7336-21a83fc0619mr405796975ad.41.1736895504307;
        Tue, 14 Jan 2025 14:58:24 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10df7asm71746105ad.47.2025.01.14.14.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 14:58:23 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 14 Jan 2025 14:57:29 -0800
Subject: [PATCH v2 04/21] dt-bindings: riscv: add Sxcsrind ISA extension
 description
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-counter_delegation-v2-4-8ba74cdb851b@rivosinc.com>
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

Add the S[m|s]csrind ISA extension description.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 9c7dd7e75e0c..0cfdaa4552a6 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -146,6 +146,20 @@ properties:
             added by other RISC-V extensions in H/S/VS/U/VU modes and as
             ratified at commit a28bfae (Ratified (#7)) of riscv-state-enable.
 
+	- const: smcsrind
+          description: |
+            The standard Smcsrind supervisor-level extension extends the
+	    indirect CSR access mechanism defined by the Smaia extension. This
+	    extension allows other ISA extension to use indirect CSR access
+	    mechanism in M-mode.
+
+	- const: sscsrind
+          description: |
+            The standard Sscsrind supervisor-level extension extends the
+	    indirect CSR access mechanism defined by the Ssaia extension. This
+	    extension allows other ISA extension to use indirect CSR access
+	    mechanism in S-mode.
+
         - const: ssaia
           description: |
             The standard Ssaia supervisor-level extension for the advanced

-- 
2.34.1

