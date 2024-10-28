Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C533A20400A;
	Mon, 28 Oct 2024 21:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152112; cv=none; b=FmfZanRKmbD2k/vValxaPG7f39sICNdzKIT2WkMfd185/z6t1GtgXtF+2ZlwM7lWn6a5zd0ePaRFQ43V6s5jZOzq717TZif5Q14cqlqVI8kAKYNBWuBRhrL5bTajv0OvozInUDPpcr0Yft6NNYibzMNRrTK9+OE3zCTx5fazZ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152112; c=relaxed/simple;
	bh=Poz0p10l/+kW4oqw8/2L7OSc9QLpdN4nyvik6LbO9aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lu3BuD7/jkzSj2lhqHJiRjUbTqzhWbVI4LLvKWg+pxqBDRoatzSVIjVxtONWTjnhj+/utKQ5xVyNdTnBUcey53gqOu5JJarFV9cHtgP6IfjyMijQYvqViZlSPX6W+lF7gcF521N08fApxST4fzDRzYD6UxCaGKFt/sg50H4Q6Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSwAvZNI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSwAvZNI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84340C4CEEC;
	Mon, 28 Oct 2024 21:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152112;
	bh=Poz0p10l/+kW4oqw8/2L7OSc9QLpdN4nyvik6LbO9aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VSwAvZNISAjFTdYkg5vgLY6JUjprGPxIO0R0+DGDzS+KD6/YxziQI4HMO83s2dTLl
	 RK3l+4MEYDYObswbXSbZxWRNacl07cmrX4jX9tQm979nBXydGn30BMrfucllCa7z/B
	 wS1p2Nj9e5JpMLiDT6ujAhhfRQIjaHX6z7zTuK2H9r9y3ioNa77skSWfKA1CfD4yfN
	 GpfsLYzjLCuiWrR9uLXpXUApUmJsGJa41ZoH2bWZTnnnN0DwMCDS/WrmSg53uYtXmw
	 KV/c6rWLQDWwPUt7ZbCboOVkpW6WnAVXet3ZY/BmDC0WbZeNKLK0A7WcHAOTZHxYpw
	 Q5ASgFNxyW/qQ==
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
Subject: [PATCH v3 02/19] x86/asm: Avoid emitting DWARF CFI for non-VDSO
Date: Mon, 28 Oct 2024 14:47:49 -0700
Message-ID: <f2dcdcf95240149bfd21e118209bf3b94efad857.1730150953.git.jpoimboe@kernel.org>
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
Message-ID: <20241028214749.eqP4mlz5k0szQtXgaPqrapCBKlvG6aM_8ep_6GOzyUw@z>

VDSO is the only part of the "kernel" using DWARF CFI directives.  For
the kernel proper, ensure the CFI_* macros don't do anything.

These macros aren't yet being used outside of VDSO, so there's no
functional change.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/dwarf2.h | 37 +++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
index 430fca13bb56..b1aa3fcd5bca 100644
--- a/arch/x86/include/asm/dwarf2.h
+++ b/arch/x86/include/asm/dwarf2.h
@@ -6,6 +6,15 @@
 #warning "asm/dwarf2.h should be only included in pure assembly files"
 #endif
 
+#ifdef BUILD_VDSO
+
+	/*
+	 * For the vDSO, emit both runtime unwind information and debug
+	 * symbols for the .dbg file.
+	 */
+
+	.cfi_sections .eh_frame, .debug_frame
+
 #define CFI_STARTPROC		.cfi_startproc
 #define CFI_ENDPROC		.cfi_endproc
 #define CFI_DEF_CFA		.cfi_def_cfa
@@ -21,7 +30,8 @@
 #define CFI_UNDEFINED		.cfi_undefined
 #define CFI_ESCAPE		.cfi_escape
 
-#ifndef BUILD_VDSO
+#else /* !BUILD_VDSO */
+
 	/*
 	 * Emit CFI data in .debug_frame sections, not .eh_frame sections.
 	 * The latter we currently just discard since we don't do DWARF
@@ -29,13 +39,24 @@
 	 * useful to anyone.  Note we should not use this directive if we
 	 * ever decide to enable DWARF unwinding at runtime.
 	 */
+
 	.cfi_sections .debug_frame
-#else
-	 /*
-	  * For the vDSO, emit both runtime unwind information and debug
-	  * symbols for the .dbg file.
-	  */
-	.cfi_sections .eh_frame, .debug_frame
-#endif
+
+#define CFI_STARTPROC
+#define CFI_ENDPROC
+#define CFI_DEF_CFA
+#define CFI_DEF_CFA_REGISTER
+#define CFI_DEF_CFA_OFFSET
+#define CFI_ADJUST_CFA_OFFSET
+#define CFI_OFFSET
+#define CFI_REL_OFFSET
+#define CFI_REGISTER
+#define CFI_RESTORE
+#define CFI_REMEMBER_STATE
+#define CFI_RESTORE_STATE
+#define CFI_UNDEFINED
+#define CFI_ESCAPE
+
+#endif /* !BUILD_VDSO */
 
 #endif /* _ASM_X86_DWARF2_H */
-- 
2.47.0

