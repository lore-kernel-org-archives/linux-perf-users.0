Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D47192B86;
	Wed, 22 Jan 2025 02:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513121; cv=none; b=AFLTGVmfppbn2zakb1vylglevW2sA1hoAqHQH5WvsThrUmqq8hmKxRJf5BpGiEDX6FlAI+BWWC0X2+YJ7DF0KxPxJVTRZQlMuxK4Ipkn3MSjkUUGU5xPOGeVPYB1tA6V4oy236GzjeQ+RyZbnr3IJ4eDdu/f6wH4wmgz/R/rlZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513121; c=relaxed/simple;
	bh=uMF4+TnDKOaSbuY20FZjJhd0apIR9OxAuehwgAGZ9PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMbYdM/BJUL0bJiE2KiR/Q6RK2eVUNiT2S2agHKslkuB7oYzp9nQEA8cfDDpcvYfs+wAVnWGptHwEHagaKGrxEpOJzwBF+KKzUYiFA4ZPJgZLNv0YurpYHxTy449Zi2COsH/l2egh5oUvvj5taa/XPhKXC/HWbMTgkXeiNuatdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=og8zjOL4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="og8zjOL4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A516FC4CEED;
	Wed, 22 Jan 2025 02:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513120;
	bh=uMF4+TnDKOaSbuY20FZjJhd0apIR9OxAuehwgAGZ9PQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=og8zjOL4MZb9DzhJMGIxdHicAFOsIuziimkgHnA7I6ZKlliIu7kpWkdom5gcA/7YR
	 izSpCxxNRKOOqDAUnVFsTjCd7oH0Mh7auCPn4PyccAsXFu2S8GHOyRViiMULpTka2L
	 q+l95aX8VJvDZOlheEBcreiZGv5Z2uAhapF/HYY0DgL2eqBmUCnIXAadhzYdmHiwVt
	 eDw/AX1s7Jlwl7aWBfGZo6aS62F6rKjg+y0ScDMZcAB6AI20wUQwb9oZkgZaj2YabM
	 a0Gzxie7O5vzwIJ2pgNl5A3pyoJUHlY+xUBmiilZQjjBIgX1fsZ89dm7e5c+IRi6kP
	 FpB13wDND6n7Q==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org,
	Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: [PATCH v4 08/39] x86/vdso: Use CFI macros in __vdso_sgx_enter_enclave()
Date: Tue, 21 Jan 2025 18:31:00 -0800
Message-ID: <688fecff7dda7650a4ccf193ce59affa516c8250.1737511963.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1737511963.git.jpoimboe@kernel.org>
References: <cover.1737511963.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the CFI macros instead of the raw .cfi_* directives to be consistent
with the rest of the VDSO asm.  It's also easier on the eyes.

No functional changes.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/entry/vdso/vsgx.S | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/vdso/vsgx.S b/arch/x86/entry/vdso/vsgx.S
index c0342238c976..8d7b8eb45c50 100644
--- a/arch/x86/entry/vdso/vsgx.S
+++ b/arch/x86/entry/vdso/vsgx.S
@@ -24,13 +24,14 @@
 .section .text, "ax"
 
 SYM_FUNC_START(__vdso_sgx_enter_enclave)
+	SYM_F_ALIGN
 	push	%rbp
-	.cfi_adjust_cfa_offset	8
-	.cfi_rel_offset		%rbp, 0
+	CFI_ADJUST_CFA_OFFSET	8
+	CFI_REL_OFFSET		%rbp, 0
 	mov	%rsp, %rbp
-	.cfi_def_cfa_register	%rbp
+	CFI_DEF_CFA_REGISTER	%rbp
 	push	%rbx
-	.cfi_rel_offset		%rbx, -8
+	CFI_REL_OFFSET		%rbx, -8
 
 	mov	%ecx, %eax
 .Lenter_enclave:
@@ -77,13 +78,11 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
 .Lout:
 	pop	%rbx
 	leave
-	.cfi_def_cfa		%rsp, 8
+	CFI_DEF_CFA		%rsp, 8
 	RET
 
-	/* The out-of-line code runs with the pre-leave stack frame. */
-	.cfi_def_cfa		%rbp, 16
-
 .Linvalid_input:
+	CFI_DEF_CFA		%rbp, 16
 	mov	$(-EINVAL), %eax
 	jmp	.Lout
 
-- 
2.48.1

