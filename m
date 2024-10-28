Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12901F9ABE;
	Mon, 28 Oct 2024 21:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152094; cv=none; b=h6mSayvZ7P3I6t40PmpVf5pYaFpgz/oI+tW9ByRJAEFgqwk11UXydimh0hrHw4q0Paremx+rv7Ij+thP4p0vyf9uelMm+DQywLaavKZqEGJL6zsTNkMAaa4GDOszsTtwzIVUcpuhx+DqKoPK+zfhkL7tKRASM9eMT+l6+unVcL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152094; c=relaxed/simple;
	bh=novk9n48ZW5HwpctN0xt5g9gOey0iB8co3QMa5J7oe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VD63PgrToSuQcSevpxUPKIvDnKzpf3IzDov2gcSyfa5RxTB21fA9ud545MGXyS6NKHMruENHUxKzyhvjOoUBzWK0q4NY72YsD+EoqRMSSkU6sgIT7o6/Qs0DOz53rhLDLRG4RMBVcypufAAXwbPPZyl+I0060IyhU9oiLUBgNr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnpJiaJR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnpJiaJR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB33DC4CEF9;
	Mon, 28 Oct 2024 21:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152094;
	bh=novk9n48ZW5HwpctN0xt5g9gOey0iB8co3QMa5J7oe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BnpJiaJR7sj7O5xsTFb48i8Hz9f+ZJuDx5JGWpguHbeeE4L74oPhWf3l5c4hSuFpB
	 q6bfgj9kT7LsWaZqyBHCvWdIsh0xpbSurToGhZUN8zMXnWkX4mZqs4osdeYrUWqn/B
	 52fjqAadv2+C7jPmVMSwlz+ht2gk3oC1+tX/PhZJU4Uoc6xNgEpPh1R3AvBN/Tngv/
	 oIkbJlkZbyrsluR9NpUPLnoOZ+VGyK/OdNMBwmLU7MZVe9zbuK1MpesaqjiOpKZ3dg
	 zuHr/LVNeCSmzlVFNG8YS4PZNioIELVJ2Kr5AV80o9KoUFEvEXPogir+f7WkssC2v1
	 pR4bd3XInncqw==
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
	linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 05/19] x86/vdso: Use CFI macros in __vdso_sgx_enter_enclave()
Date: Mon, 28 Oct 2024 14:47:32 -0700
Message-ID: <95cb05cfd657091c0d3126709a55535ebd09e2ba.1730150953.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730150953.git.jpoimboe@kernel.org>
References: <cover.1730150953.git.jpoimboe@kernel.org>
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
2.47.0

