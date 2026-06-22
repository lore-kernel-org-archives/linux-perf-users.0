Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2591A38E121
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115488; cv=none; b=IL3eWTA+XzJp3+dPq6pPq7Ce27J0lgKN7vatHIOAfCiGPqUxa1QBw4auOW8xYhP2DIVN0DxVUYseQatG2Z4cGdRXTfFx4SEtVdYRrYPQLjyNtY47DID7gg/MsYH73SidS6H0mWj7UiSLhiwWS394Isqa+brQ6nc/Rx4LZoyhYyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115488; c=relaxed/simple;
	bh=A3gRyl4ltUH9yUsRKVqvAMCjF315BmzM3okD18OgTNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZV9D3xdZFps6r/pAhO8PohdOscdWgyUiOslgZMFX37kfeJ8z5ySYpwEO6jjxQORHDvMocjT6m+Qp2GUEywiDzxSg/q4hWqsSoah94QY19VQ/nmKAYEj5kbU+j1wWRILP2PpUU8DhiLPutPA7ckyRFec63uNxco0YTL4trCk+9ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X2W+ZRqz; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X2W+ZRqz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782115485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q3CU0znujUTwcxjeKNolaCbQsHD6AswnEQkiO1fL85Y=;
	b=X2W+ZRqzoLrT/KVkCjlx6Ky/okCd3f8oaS2cwKIQ22YfgP90TNjDf+Boxj7XWwNJGqYLZD
	DIbTVouRH3iS4s9wYYJMM0izbiAMg243UcZEZEP0Yodir1AuiHYLCZVqErOd6/i5Xh9oVG
	vifNr4k46rxQ1GYy64kBQ9eBsuZWTAs=
From: Atish Patra <atish.patra@linux.dev>
Date: Mon, 22 Jun 2026 01:04:16 -0700
Subject: [PATCH v7 04/22] dt-bindings: riscv: add Sxcsrind ISA extension
 description
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-counter_delegation-v7-4-0ba2fd34614e@meta.com>
References: <20260622-counter_delegation-v7-0-0ba2fd34614e@meta.com>
In-Reply-To: <20260622-counter_delegation-v7-0-0ba2fd34614e@meta.com>
To: Jiri Olsa <jolsa@kernel.org>, James Clark <james.clark@linaro.org>, 
 Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Rob Herring <robh@kernel.org>, 
 Ian Rogers <irogers@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
 Atish Patra <atish.patra@linux.dev>, Namhyung Kim <namhyung@kernel.org>
Cc: devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Conor Dooley <conor@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Migadu-Flow: FLOW_OUT

From: Atish Patra <atishp@rivosinc.com>

Add the S[m|s]csrind ISA extension description.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 2b0a8a93bb21..15cf0e2ee3ed 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -181,6 +181,14 @@ properties:
             changes to interrupts as frozen at commit ccbddab ("Merge pull
             request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
 
+        - const: smcsrind
+          description: |
+            The standard Smcsrind machine-level extension extends the
+            indirect CSR access mechanism defined by the Smaia extension. This
+            extension allows other ISA extensions to use indirect CSR access
+            mechanism in M-mode as ratified in the 20240326 version of the
+            privileged ISA specification.
+
         - const: smmpm
           description: |
             The standard Smmpm extension for M-mode pointer masking as
@@ -226,6 +234,14 @@ properties:
             Profiles Version 1.0, with commit b1d806605f87 ("Updated to
             ratified state.")
 
+        - const: sscsrind
+          description: |
+            The standard Sscsrind supervisor-level extension extends the
+            indirect CSR access mechanism defined by the Ssaia extension. This
+            extension allows other ISA extensions to use indirect CSR access
+            mechanism in S-mode as ratified in the 20240326 version of the
+            privileged ISA specification.
+
         - const: ssnpm
           description: |
             The standard Ssnpm extension for next-mode pointer masking as

-- 
2.53.0-Meta

