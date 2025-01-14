Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E16721858C
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736895513; cv=none; b=HN6IwJHdrdAc204lQ9/B3Lpw9BP5Y51ogQR0/Aj3Y65qJX3BIGn0WmojrpcKnWFgWqH1xIsvu/FH6G1+YOIp5IgzQRsK+ml1df+rrIYD/LtlUbm5rLF9YG+oZRKwVGrZyTicFmrxwi2Usi8btnv9VzRLTKMkPFZfmPP32RYx9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736895513; c=relaxed/simple;
	bh=qgt8CBKBjjf1pXbLg4nyI/opS5gZuaUjt8a3Zl80Jzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kfFXaR9kYZ8bWsraq6N+vEpQGaA0Va4PLhgeB4CHHNw9eYq1fXizdSI/6O7RO3Anl6xBEHxMUGpaCcqozeWRsdIEfKxkpr0Sym4stqpmBHIGR2HOS/zLoBrXhr3GM5AynHWb4Wa4wrz22msokT9xstxSClEhiTcRSxVVe0OV3PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bRkvnBJz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bRkvnBJz"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21bc1512a63so44256045ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 14:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736895511; x=1737500311; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zp+Ban9UqcPtxcekhEzEgx0H42XNY1XoD8n/tlKqBKQ=;
        b=bRkvnBJzvp5aw+J+GMvSbA0yo9sBhhQP7QDmDK6OaFgq/QEeE3RiYdEy7fFac4SjAE
         R43AE7qiqTTVbMZepBwoW1XbcduYdRK5kWESTRvgTUw51LPthmwG1jz0Qx7OjKhPOG/L
         HtfXtav+SQGHoDBwjIt8oaVcdXAKRHGmXT/pSeklvsqsYs8UiKYf6zeLCONquAsEHUgw
         Gqh22UumTVrAhsBDUmIQdkCkrIpblZPz9nMr2wOPz83bohzJ37h6gjYWwhQGguN9w/fS
         ic0CtBXorSVB2sqFztOxiHlMyv8ORKIihg1+Wx6xtOFTz/IapklkrOndMF7WvyXSAcjD
         GMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736895511; x=1737500311;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zp+Ban9UqcPtxcekhEzEgx0H42XNY1XoD8n/tlKqBKQ=;
        b=t2bZp/IPIAlooJstH2XQzuoqBf4EJWAHu/6ERpKJMskyWxfRvvF9dxGVcMEQC1PNCx
         B6ozQCLLHmjDluhcbfrW952/wcQBIu6eSv8G2J0cvOox9EAsiZYhEioRGbJ8hAt0LWxw
         atxDsMAxY4fiVffHBiBGb3g/mSdtSQcOt5ehj2wx9bBJwUngPpoK8Fg7YU2nT2YthQPD
         +rz0hEAZs8uCLj3wIz8Fu0paXRP7OBuPnSaphHpaSosAmiaBZ6/nlSZMv48e2yCVpGVB
         NSWK//Pkk05l5wMeE1uUkVqaG0KeGVnBW6IfmiMCUCQimJgzvWanOjKcDLbbWjOq/upj
         XOIw==
X-Forwarded-Encrypted: i=1; AJvYcCXlbWJ3uLoqpXwJz50i1I12jRQtOGA1pkOiWMkL4ANewd85NGvgV7UDExfoYzfyJ7C1ZheZg3RirbbLDlslob+i@vger.kernel.org
X-Gm-Message-State: AOJu0YygxTCNoMfGVBbQ10nKCysxOeB6A5eq4mDAOj17HWplMoBPrmw/
	SRNZYPWjIKrU+Ro6gwz6RDlAFsGa6MuwfWsvmsqsCu0uUlw97zdURcd3zDO5LKc=
X-Gm-Gg: ASbGncv9TIWTj3cqcKU62TvAgsCxUA3xnizuJ1IhNqj60BRgxw61DtaYFc9LWo1KpqA
	1Ljl7k8v8TLjZDdVdIXEUtpaoasSJE9sA2SJ4l1I/Q8hLgklt1V6e6ORe+/sK6KWIbwWbP5xkoM
	E+20w55lnGhsiCUjyEwJgH3QQgISyGkhvQzeZkvYzfVXgBIz3KKpe/qg8erTP9zm9fHbWT9ujUL
	g480sks/IntRJInj5TZ+dfee9zTYQfm37+k9cTQdkKax5YxbEXYWA6uoLXyX61oqT5rvQ==
X-Google-Smtp-Source: AGHT+IFw2aOxa/RiLQrRWKk2z3D3w1uFmOOWORKNifbT2/MJ7FdclBZ5ykBjK1s8a/t6cnrYBG/h2Q==
X-Received: by 2002:a17:902:fc8f:b0:216:48dd:d15c with SMTP id d9443c01a7336-21a83f65a79mr399235235ad.27.1736895511537;
        Tue, 14 Jan 2025 14:58:31 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10df7asm71746105ad.47.2025.01.14.14.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 14:58:31 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 14 Jan 2025 14:57:33 -0800
Subject: [PATCH v2 08/21] dt-bindings: riscv: add Ssccfg ISA extension
 description
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-counter_delegation-v2-8-8ba74cdb851b@rivosinc.com>
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

Add description for the Ssccfg extension.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 0cfdaa4552a6..c8685fb1fb42 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -128,6 +128,13 @@ properties:
             changes to interrupts as frozen at commit ccbddab ("Merge pull
             request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
 
+	- const: smcdeleg
+	  description: |
+	    The standard Smcdeleg supervisor-level extension for the machine mode
+	    to delegate the hpmcounters to supvervisor mode so that they are
+	    directlyi accessible in the supervisor mode. This extension depend
+	    on Sscsrind, Zihpm, Zicntr extensions.
+
         - const: smmpm
           description: |
             The standard Smmpm extension for M-mode pointer masking as
@@ -166,6 +173,12 @@ properties:
             interrupt architecture for supervisor-mode-visible csr and
             behavioural changes to interrupts as frozen at commit ccbddab
             ("Merge pull request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
+	- const: ssccfg
+	  description: |
+	    The standard Ssccfg supervisor-level extension for configuring
+            the delegated hpmcounters to be accessible directly in supervisor
+            mode. This extension depend on Sscsrind, Smcdeleg, Zihpm, Zicntr
+            extensions.
 
         - const: sscofpmf
           description: |

-- 
2.34.1

