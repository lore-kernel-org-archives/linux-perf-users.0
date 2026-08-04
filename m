Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A74635675A;
	Tue,  4 Aug 2026 23:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886559; cv=none; b=hr8Bt9B0zIaAgenpr3rYsvKCmyn5S4An+Hng1bScQUZGTmjrHlg7isRbGB22V2UxK3WJT5GvSoEhHCu9AYtQ2PzZPbWUy4UTJZuCmx3RsITuvDHyd3DygUnwrqKswrbWi6P2uoM9l3TVKpo99Kj/RBULMy15zaoXsCjqE2gVMPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886559; c=relaxed/simple;
	bh=zMKaccGj1izOf6T+qQuYvQnmqQ/k25GBB/6q1WmNGQ4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IO1zj2LZZR3RXaOpJxewL7UleBgCPwj3t5FbH6SXDx9kwwe7TI6nwYeJWi3Py846VyansGwMi3i71HIIE1UVTHC1kImDUpRqNTWy84t+goJoEMnnmOCLKXjo/SN5Yrg4KYSYV3QKOiHMIvZ46xpgqV2hFhIxHreksMFmKtaP1PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9pa1dn5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9pa1dn5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B5C1F000E9;
	Tue,  4 Aug 2026 23:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785886557;
	bh=qqSMQv43Ny77SHf94e7R4UsEgWA5Ic7Z9DHRZuUb4NY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=W9pa1dn5Cz5qL/i7r4WcyaBfi3EanadOrI+Ib2i5ftXpBzAmp+tDpfJbBDPHZQutj
	 bWSTKnYWJfu52h+dpHBHA6ECJblz/Wiufass2MhiwIRo6cSbMYJl9I7xJKZHFqdBVI
	 Gd0vv1qLOXqO9NSfoqntg615eEf1Ev50ldxaA/FdqzXNUCwnD6d5dN+Ir11ooO1WgV
	 WCZve5HJ/I25Lud6ufyJN6YW+jFJ12sUs/NEnR+oXDAY+gYgtqf0SCqOQxBnImVin7
	 ivD9HvWaS0ETbbfOQt+X/Xgog+QxkrcWql54g/14/LbSgdHb/IojI3qfi3K9K/X/te
	 4+d4Zl6i+zd4g==
Date: Tue, 4 Aug 2026 17:35:55 -0600 (MDT)
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
Subject: Re: [PATCH v8 02/22] RISC-V: Add Sxcsrind ISA extension CSR
 definitions
In-Reply-To: <20260701-counter_delegation-v8-2-7909f863a645@meta.com>
Message-ID: <3d1f698c-6b76-5252-4e8f-b61671e309c7@kernel.org>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com> <20260701-counter_delegation-v8-2-7909f863a645@meta.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-5439955-1785886557=:1346571"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-5439955-1785886557=:1346571
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 1 Jul 2026, Atish Patra wrote:

> From: Kaiwen Xue <kaiwenx@rivosinc.com>
> 
> This adds definitions of new CSRs and bits defined in Sxcsrind ISA
> extension. These CSR enables indirect accesses mechanism to access
> any CSRs in M-, S-, and VS-mode. The range of the select values
> and ireg will be define by the ISA extension using Sxcsrind extension.
> 
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> Reviewed-by: Clément Léger <cleger@rivosinc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Thanks.  It's easier for folks to grep and cross-reference if the official 
RISC-V extension names are used whenever possible, rather than something 
like Sxcsrind.  Queued the following patch for v7.3.


- Paul


RISC-V: Add Smcsrind and Sscrind ISA extension CSR definitions

From: Kaiwen Xue <kaiwenx@rivosinc.com>

This adds definitions of new CSRs and bits defined in the Smcsrind and
Sscrinq ISA extensions. These CSRs enable the indirect CSR accesses
mechanism to access any indirect CSRs in M-, S-, and VS-mode. The
range of the select values and ireg will be defined by the ISA
extension that are based on the Smcsrind and Sscsrind extensions.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Reviewed-by: Clément Léger <cleger@rivosinc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Link: https://patch.msgid.link/20260701-counter_delegation-v8-2-7909f863a645@meta.com
[pjw@kernel.org: clean up the patch description; use official RISC-V extension names]
Signed-off-by: Paul Walmsley <pjw@kernel.org>
---
 arch/riscv/include/asm/csr.h |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 31b8988f4488..7f09e54a0f9a 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -347,6 +347,12 @@
 /* Supervisor-Level Window to Indirectly Accessed Registers (AIA) */
 #define CSR_SISELECT		0x150
 #define CSR_SIREG		0x151
+/* Supervisor-Level Window to Indirectly Accessed Registers (Sscsrind) */
+#define CSR_SIREG2		0x152
+#define CSR_SIREG3		0x153
+#define CSR_SIREG4		0x155
+#define CSR_SIREG5		0x156
+#define CSR_SIREG6		0x157
 
 /* Supervisor-Level Interrupts (AIA) */
 #define CSR_STOPEI		0x15c
@@ -394,6 +400,14 @@
 /* VS-Level Window to Indirectly Accessed Registers (H-extension with AIA) */
 #define CSR_VSISELECT		0x250
 #define CSR_VSIREG		0x251
+/*
+ * VS-Level Window to Indirectly Accessed Registers (H-extension with Sscsrind)
+ */
+#define CSR_VSIREG2		0x252
+#define CSR_VSIREG3		0x253
+#define CSR_VSIREG4		0x255
+#define CSR_VSIREG5		0x256
+#define CSR_VSIREG6		0x257
 
 /* VS-Level Interrupts (H-extension with AIA) */
 #define CSR_VSTOPEI		0x25c
@@ -436,6 +450,12 @@
 /* Machine-Level Window to Indirectly Accessed Registers (AIA) */
 #define CSR_MISELECT		0x350
 #define CSR_MIREG		0x351
+/* Machine-Level Window to Indirectly Accessed Registers (Smcsrind) */
+#define CSR_MIREG2		0x352
+#define CSR_MIREG3		0x353
+#define CSR_MIREG4		0x355
+#define CSR_MIREG5		0x356
+#define CSR_MIREG6		0x357
 
 /* Machine-Level Interrupts (AIA) */
 #define CSR_MTOPEI		0x35c
@@ -498,6 +518,11 @@
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
@@ -523,6 +548,11 @@
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

--8323329-5439955-1785886557=:1346571--
