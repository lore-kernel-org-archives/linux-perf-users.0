Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE901EF92F;
	Mon, 28 Oct 2024 21:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152115; cv=none; b=je712gc4CPqWHVrtESw5y1nmLBRKcdTyP0/+Yhvrgz7YQPe/eN0qhhZsEGrLH3CcWWFgLJhUH8k7Z2dL2Ka/78/KppL1V8w4kKBrLLOIxktnQoeWW9l0WQDrZxHcw6gO2t9ksSAT1k+KyzPLjj6QXEjotYRMftpCSsTSlbmtFO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152115; c=relaxed/simple;
	bh=novk9n48ZW5HwpctN0xt5g9gOey0iB8co3QMa5J7oe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGRzT1rEJIDl/C6INWq9a1nWu4JBowt03j45IDGikm8eps80jvucg4mV5LZ5WfymKNYKUy1HWC4ESdafbG2OWW/J4H5vUZQ17il93B38mK9tFGBDtrIl9jltNR3CV0RUqPsYUWmRmcyaaX+gfKnMN2YsyFRMQ8rwG+hxMrsanbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pq4TNxbQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pq4TNxbQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAD6C4CEC3;
	Mon, 28 Oct 2024 21:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152115;
	bh=novk9n48ZW5HwpctN0xt5g9gOey0iB8co3QMa5J7oe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pq4TNxbQUWnHzF0/p/OHd81qstZ991ZkhGmctWZz7gnWBviq+8OJUB7u7GT5603Su
	 7CNdAZluhI7IjrUoZ09cUdbitS/3nAYWDTU7SkHKMaetMOS1YrH9Qrza9LPBvApcl8
	 +DIznj4q60FYmR7s3U1YEZXfVybdcksgY8KzovUt6LXNHcppeY+MpiaM4Y3r6VWqnv
	 3FgFxcVwvfj4q93Lm0re6mUPFvdd1AmgG0WAmFDQk8XC6mtPffPU1LGtH5uvMHFVqZ
	 XhyO2WxyM5KCMOEoJg96q1shEniiJzJeLdS76yey3/KlDs/ZpliOZk+mPJEmSKAbwG
	 KPsR5YynqIg8w==
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
Date: Mon, 28 Oct 2024 14:47:52 -0700
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
Message-ID: <20241028214752.EZdSeKXLz2s3lAAICFDTihxSz57ElnO8C23RMovhqxA@z>

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

