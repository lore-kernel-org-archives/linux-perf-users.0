Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297091AF0DB;
	Wed, 22 Jan 2025 02:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737513122; cv=none; b=WaSguUddKSOEcvguDC+QgcCKqrUHXAb3DM0oqNIBbucRc3qUzo55V2qnVfBHMsFsMjZnoKI7oivDtjQtMa/GVtqD5+EO6q4jVRm4n+E+H0GPcijDW9GggPRjM0mG6KNbaj+hdasviUH0upjK9rOzrLVkxk1PQhsvOVBsNYWzxks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737513122; c=relaxed/simple;
	bh=naZUMNTiJIsZIoJxWyFoddFok9zA5MJhKH8ft2VkwuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gt9ihRDw3yGExZDcdeepVAbflQoXMjTNbaV2SFIwYGvAnNnS5N9ZRzMGMfNmrNEovvq/qgTGfWGU+yRbv1LDlpnj/zLmY/tSjb+/uwK0/lqizKU+D6OM1bBQZf008xVh9jOOdsvHjmgU4xpmn0a3d9t9yb5QOPemcj058cbqwB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTSmJTAa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTSmJTAa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1917C4CEE2;
	Wed, 22 Jan 2025 02:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737513121;
	bh=naZUMNTiJIsZIoJxWyFoddFok9zA5MJhKH8ft2VkwuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RTSmJTAa4oSV8B6jl7fwZqUSn5ddX9/9lbsfq1ANEnOyCyCQvWTxaOS/FXioAYpjY
	 WzIx7pOAEPDW0ZfS5BJlkpIZYx9+JYqGz2mPXYsTTjdwhiFjoYXhQV7wJuyVToCWJW
	 C6WLv1NBYrJ5b34Cj0uHkZLNvmNMSvsyfMmbLtaJcyV7ukgtf6jTabGmWMbLQCECsW
	 F1kNZFGkzttIcTTlSfeiRDKjZ/Jcc9lULYXtMoEFCd79D8oFzPzm9o5egnSVphSjmv
	 DOG8+FJJyKFwV9GvOTS7N53Pk8jtY0qRbVh0qK/v0OVMqEZLrJaBqiocpEmU17J9Gz
	 ZOX15ey84LmEA==
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
Subject: [PATCH v4 09/39] x86/vdso: Enable sframe generation in VDSO
Date: Tue, 21 Jan 2025 18:31:01 -0800
Message-ID: <c93fbd53f01c2c86f747af27040ac11f16dee032.1737511963.git.jpoimboe@kernel.org>
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

Enable sframe generation in the VDSO library so kernel and user space
can unwind through it.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/Kconfig                          |  3 +++
 arch/x86/entry/vdso/Makefile          | 10 +++++++---
 arch/x86/entry/vdso/vdso-layout.lds.S |  3 +++
 arch/x86/include/asm/dwarf2.h         |  5 ++++-
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6682b2a53e34..65228c78fef0 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -435,6 +435,9 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
 	  It uses the same command line parameters, and sysctl interface,
 	  as the generic hardlockup detectors.
 
+config AS_SFRAME
+	def_bool $(as-instr,.cfi_sections .sframe\n.cfi_startproc\n.cfi_endproc)
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index c9216ac4fb1e..478de89029d1 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -47,13 +47,17 @@ quiet_cmd_vdso2c = VDSO2C  $@
 $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
 	$(call if_changed,vdso2c)
 
+#ifdef CONFIG_AS_SFRAME
+SFRAME_CFLAGS := -Wa$(comma)-gsframe
+#endif
+
 #
 # Don't omit frame pointers for ease of userspace debugging, but do
 # optimize sibling calls.
 #
 CFL := $(PROFILING) -mcmodel=small -fPIC -O2 -fasynchronous-unwind-tables -m64 \
        $(filter -g%,$(KBUILD_CFLAGS)) -fno-stack-protector \
-       -fno-omit-frame-pointer -foptimize-sibling-calls \
+       -fno-omit-frame-pointer $(SFRAME_CFLAGS) -foptimize-sibling-calls \
        -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 
 ifdef CONFIG_MITIGATION_RETPOLINE
@@ -63,7 +67,7 @@ endif
 endif
 
 $(vobjs): KBUILD_CFLAGS := $(filter-out $(PADDING_CFLAGS) $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
-$(vobjs): KBUILD_AFLAGS += -DBUILD_VDSO
+$(vobjs): KBUILD_AFLAGS += -DBUILD_VDSO $(SFRAME_CFLAGS)
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
@@ -104,7 +108,7 @@ $(obj)/%-x32.o: $(obj)/%.o FORCE
 
 targets += vdsox32.lds $(vobjx32s-y)
 
-$(obj)/%.so: OBJCOPYFLAGS := -S --remove-section __ex_table
+$(obj)/%.so: OBJCOPYFLAGS := -g --remove-section __ex_table
 $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index 506c9800a5aa..4dcde4747b07 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -63,6 +63,7 @@ SECTIONS
 	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
 	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
 
+	.sframe		: { *(.sframe) }		:text	:sframe
 
 	/*
 	 * Text is well-separated from actual data: there's plenty of
@@ -91,6 +92,7 @@ SECTIONS
  * Very old versions of ld do not recognize this name token; use the constant.
  */
 #define PT_GNU_EH_FRAME	0x6474e550
+#define PT_GNU_SFRAME	0x6474e554
 
 /*
  * We must supply the ELF program headers explicitly to get just one
@@ -102,4 +104,5 @@ PHDRS
 	dynamic		PT_DYNAMIC	FLAGS(4);		/* PF_R */
 	note		PT_NOTE		FLAGS(4);		/* PF_R */
 	eh_frame_hdr	PT_GNU_EH_FRAME;
+	sframe		PT_GNU_SFRAME;
 }
diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
index b195b3c8677e..1c354f648505 100644
--- a/arch/x86/include/asm/dwarf2.h
+++ b/arch/x86/include/asm/dwarf2.h
@@ -12,8 +12,11 @@
 	 * For the vDSO, emit both runtime unwind information and debug
 	 * symbols for the .dbg file.
 	 */
-
+#ifdef __x86_64__
+	.cfi_sections .eh_frame, .debug_frame, .sframe
+#else
 	.cfi_sections .eh_frame, .debug_frame
+#endif
 
 #define CFI_STARTPROC		.cfi_startproc
 #define CFI_ENDPROC		.cfi_endproc
-- 
2.48.1

