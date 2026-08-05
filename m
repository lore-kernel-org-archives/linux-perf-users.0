Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6DB361DC0;
	Wed,  5 Aug 2026 00:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785889772; cv=none; b=gA0MJwkklOpHpzBN35qi2WMgVWh9EuMRxzZ+S1gzVJayzUwfjm43uRTVSZTOG/Br4UoFClv6qZndARSbD7Mim159qDgfCNVdPC5TWxo56kp4T18SSZX80KSGTytT26skZX7/8hGRsOML/VcxQyfmk/esCXm8TUHHSiAsrjVVfCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785889772; c=relaxed/simple;
	bh=h6ADNI3Kl7h/D2LtoHMYy1FpLZvIZCwYbviuyOKBHpY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aQYbOHt8Cf076k4DmurosbNASaw6NDAURtqPQYXDnMcw8mAltUoxYjFJ72go00VYqlSOPUmeIPNUJwxTLi+6H+k9VrZgJGAf3WRx7Isdtepw97dmJVlAROyH3QhJhSLLd51UfRCoZ0yjtp7XJt5+9NuoIq6DilQS4HyqwTRmwuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqAoRhfm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqAoRhfm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F5A1F000E9;
	Wed,  5 Aug 2026 00:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785889770;
	bh=wVEMBbEdefM7yw4jrExG2EaFI8XCUTLCLGP+UaBsQzk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=MqAoRhfm1zlG8hISZxXC9aRivBnaEvPzdNFBBBHfSHKBlsKVlZzBNOrghJirMVk12
	 aXbziJiP4Rj3/So76Q0nQh9vtGLjxySwQsx4sE6SlawSIl2tN1bo44PoBfIuXSkkZg
	 jLCErxwpJMkC4CHj5/1cIEBCXz//t6+mRgDGCblwdqrD0Qpz0ugk4cFt8CIvcFLgdS
	 xwMYAe7GE5JChqwqsOYMbijdN0K5M6UNI7uVG3i2TOoMjLlOColEXzQc269Ul5It9v
	 4EoRZ5QVAJP0iU0pN9CYAoeDqh979YQGenaf/56OrjUcVnfiKOTdflbHRyqhxbTn0+
	 p14QBWYOHauuA==
Date: Tue, 4 Aug 2026 18:29:28 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Atish Patra <atish.patra@linux.dev>
cc: Jiri Olsa <jolsa@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
    Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, Ian Rogers <irogers@google.com>, 
    Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
    linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v8 04/22] dt-bindings: riscv: add Sxcsrind ISA extension
 description
In-Reply-To: <20260701-counter_delegation-v8-4-7909f863a645@meta.com>
Message-ID: <66661b25-5cef-6590-b885-31cf954a16ce@kernel.org>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com> <20260701-counter_delegation-v8-4-7909f863a645@meta.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 1 Jul 2026, Atish Patra wrote:

> From: Atish Patra <atishp@rivosinc.com>
> 
> Add the S[m|s]csrind ISA extension description.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Along the lines of the comments on patches 2 and 3, here's what's been 
queued for v7.3.


- Paul

From: Atish Patra <atishp@rivosinc.com>

dt-bindings: riscv: add Smcsrind and Sscsrind ISA extension descriptions

Add the S[m|s]csrind ISA extension description.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Link: https://patch.msgid.link/20260701-counter_delegation-v8-4-7909f863a645@meta.com
[pjw@kernel.org: use official extension names in the patch description]
Signed-off-by: Paul Walmsley <pjw@kernel.org>
---
 .../devicetree/bindings/riscv/extensions.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 5ffc40d599c0..ccff2be1224d 100644
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
2.53.0

