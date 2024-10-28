Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051BE1F4273;
	Mon, 28 Oct 2024 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152093; cv=none; b=AZGqTkByuqy244A5NGhVEkhsw3Ma8sul5mN2++zS7IMYfHDuOIIESbMLqxgTbHYSgnNRJtWZSqxS82vY2pcMATTX+PQmCU3YUqc8RYxbW+7A2n9kISgc6c/ZOefzmBcm5C0Gw/jZLYi+QM2Oc87J9aIvVSbbYir5f1gLnLYIurY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152093; c=relaxed/simple;
	bh=3UaGSX/DcLgu2RuoIEL7DdM11xoyzjhEsw5DgNuktbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSxvUkx2Eh8W20Ti23UXmkk24fjaGRy5scdrWIdzjCKNmzZkrzj7wXiqL/auKCbNQv4yWbWj2m6uRIXEoc7x0kqj4l4CY+nK8akVuB/AEc5x422hyxCqDad9L9hSMsNZE7IYlaOfzAV+Rr2vgXP9kOUqSAh7Q6WFytBjm5N8nSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuteH+5h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuteH+5h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD963C4CEED;
	Mon, 28 Oct 2024 21:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152092;
	bh=3UaGSX/DcLgu2RuoIEL7DdM11xoyzjhEsw5DgNuktbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iuteH+5hTpoTwAq6XFfcSVztYitTMPOO4YHVX/EscUOGfNG6cQfwoVSd3km0OWeRX
	 w/ECyR81F3pCCcV1qCy0KuInu9yVTiDqz1v8yW7GAwhAumVoVv5jEjB2ogAmCNbjSs
	 8icPEFspvvjae1K0aUQRmia++HbqbklN3bnehkb46do8w2GHTg54N3L5gmp/wSxcdL
	 rkg72TUNupy9DdE9Hq4nJQsy1mSv1CJyv2LnERUAl072h6baoceD4zvd75segeOtsJ
	 O06QxXNz8q34eFOi0hjIg0m9IbLb3bdV+obbHAUgXHVI/Z0hxac7uOqlyE6rRMdJ8U
	 hdiG+3fUKHY3g==
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
Subject: [PATCH v3 03/19] x86/asm: Fix VDSO DWARF generation with kernel IBT enabled
Date: Mon, 28 Oct 2024 14:47:30 -0700
Message-ID: <b1b8498a9aa9f6dfb69dc27f9bc8b21656c5e7ab.1730150953.git.jpoimboe@kernel.org>
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

The DWARF .cfi_startproc annotation needs to be at the very beginning of
a function.  But with kernel IBT that doesn't happen as ENDBR is
sneakily embedded in SYM_FUNC_START.  So the DWARF unwinding info is
wrong at the beginning of the VDSO functions.

Fix it by adding CFI_STARTPROC and CFI_ENDPROC to SYM_FUNC_START_* and
SYM_FUNC_END respectively.  Note this only affects VDSO, as the CFI_*
macros are empty for the kernel proper.

Fixes: c4691712b546 ("x86/linkage: Add ENDBR to SYM_FUNC_START*()")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/entry/vdso/vdso-layout.lds.S   |  2 +-
 arch/x86/entry/vdso/vgetrandom-chacha.S |  2 --
 arch/x86/entry/vdso/vsgx.S              |  4 ----
 arch/x86/include/asm/linkage.h          | 29 +++++++++++++++++++------
 arch/x86/include/asm/vdso.h             |  1 -
 5 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index bafa73f09e92..a42c7d4a33da 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/vdso.h>
+#include <asm/page_types.h>
 
 /*
  * Linker script for vDSO.  This is an ELF shared object prelinked to
diff --git a/arch/x86/entry/vdso/vgetrandom-chacha.S b/arch/x86/entry/vdso/vgetrandom-chacha.S
index cc82da9216fb..a33212594731 100644
--- a/arch/x86/entry/vdso/vgetrandom-chacha.S
+++ b/arch/x86/entry/vdso/vgetrandom-chacha.S
@@ -22,7 +22,6 @@ CONSTANTS:	.octa 0x6b20657479622d323320646e61707865
  *	rcx: number of 64-byte blocks to write to output
  */
 SYM_FUNC_START(__arch_chacha20_blocks_nostack)
-	CFI_STARTPROC
 .set	output,		%rdi
 .set	key,		%rsi
 .set	counter,	%rdx
@@ -175,5 +174,4 @@ SYM_FUNC_START(__arch_chacha20_blocks_nostack)
 	pxor		temp,temp
 
 	ret
-	CFI_ENDPROC
 SYM_FUNC_END(__arch_chacha20_blocks_nostack)
diff --git a/arch/x86/entry/vdso/vsgx.S b/arch/x86/entry/vdso/vsgx.S
index 37a3d4c02366..c0342238c976 100644
--- a/arch/x86/entry/vdso/vsgx.S
+++ b/arch/x86/entry/vdso/vsgx.S
@@ -24,8 +24,6 @@
 .section .text, "ax"
 
 SYM_FUNC_START(__vdso_sgx_enter_enclave)
-	/* Prolog */
-	.cfi_startproc
 	push	%rbp
 	.cfi_adjust_cfa_offset	8
 	.cfi_rel_offset		%rbp, 0
@@ -143,8 +141,6 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
 	jle	.Lout
 	jmp	.Lenter_enclave
 
-	.cfi_endproc
-
 _ASM_VDSO_EXTABLE_HANDLE(.Lenclu_eenter_eresume, .Lhandle_exception)
 
 SYM_FUNC_END(__vdso_sgx_enter_enclave)
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index dc31b13b87a0..2866d57ef907 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -40,6 +40,10 @@
 
 #ifdef __ASSEMBLY__
 
+#ifndef LINKER_SCRIPT
+#include <asm/dwarf2.h>
+#endif
+
 #if defined(CONFIG_MITIGATION_RETHUNK) && !defined(__DISABLE_EXPORTS) && !defined(BUILD_VDSO)
 #define RET	jmp __x86_return_thunk
 #else /* CONFIG_MITIGATION_RETPOLINE */
@@ -112,40 +116,51 @@
 # define SYM_FUNC_ALIAS_MEMFUNC	SYM_FUNC_ALIAS
 #endif
 
+#define __SYM_FUNC_START				\
+	CFI_STARTPROC ASM_NL				\
+	ENDBR
+
+#define __SYM_FUNC_END					\
+	CFI_ENDPROC ASM_NL
+
 /* SYM_TYPED_FUNC_START -- use for indirectly called globals, w/ CFI type */
 #define SYM_TYPED_FUNC_START(name)				\
 	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_F_ALIGN)	\
-	ENDBR
+	__SYM_FUNC_START
 
 /* SYM_FUNC_START -- use for global functions */
 #define SYM_FUNC_START(name)				\
 	SYM_START(name, SYM_L_GLOBAL, SYM_F_ALIGN)	\
-	ENDBR
+	__SYM_FUNC_START
 
 /* SYM_FUNC_START_NOALIGN -- use for global functions, w/o alignment */
 #define SYM_FUNC_START_NOALIGN(name)			\
 	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)	\
-	ENDBR
+	__SYM_FUNC_START
 
 /* SYM_FUNC_START_LOCAL -- use for local functions */
 #define SYM_FUNC_START_LOCAL(name)			\
 	SYM_START(name, SYM_L_LOCAL, SYM_F_ALIGN)	\
-	ENDBR
+	__SYM_FUNC_START
 
 /* SYM_FUNC_START_LOCAL_NOALIGN -- use for local functions, w/o alignment */
 #define SYM_FUNC_START_LOCAL_NOALIGN(name)		\
 	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)	\
-	ENDBR
+	__SYM_FUNC_START
 
 /* SYM_FUNC_START_WEAK -- use for weak functions */
 #define SYM_FUNC_START_WEAK(name)			\
 	SYM_START(name, SYM_L_WEAK, SYM_F_ALIGN)	\
-	ENDBR
+	__SYM_FUNC_START
 
 /* SYM_FUNC_START_WEAK_NOALIGN -- use for weak functions, w/o alignment */
 #define SYM_FUNC_START_WEAK_NOALIGN(name)		\
 	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)		\
-	ENDBR
+	__SYM_FUNC_START
+
+#define SYM_FUNC_END(name)				\
+	__SYM_FUNC_END					\
+	SYM_END(name, SYM_T_FUNC)
 
 #endif /* _ASM_X86_LINKAGE_H */
 
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index d7f6592b74a9..0111c349bbc5 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -2,7 +2,6 @@
 #ifndef _ASM_X86_VDSO_H
 #define _ASM_X86_VDSO_H
 
-#include <asm/page_types.h>
 #include <linux/linkage.h>
 #include <linux/init.h>
 
-- 
2.47.0

