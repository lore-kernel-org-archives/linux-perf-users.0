Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D30D204940;
	Mon, 28 Oct 2024 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152116; cv=none; b=k2QNeofH4WKrfkVnJnAchhlkB1EZhO6krAnaaumrgHldB+MLUubPFnaYvDgoQQdmllZndpEHqlkUnUMjPmRWhNg/tUtNWF4JIg0Quf94KPKUpOu+mht2raqV5qOqI9TM8jeWtwUcq2HQsbTR9r9Pk/LA5+Y7pSJOVRN+BplguhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152116; c=relaxed/simple;
	bh=csgk8n4iRRjcqkq8BEX7gzKoaA91YAbqf7sWW4GqaNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcJIAiWx91UJisT5h7igPHb0Jz4h9Sn6ROfzq6veqmDwMq+1wshLwyPV1uR5r0pNwaqL7MNAW0abb2mJxlOAT40QJN4KdTGp0lbgR3856HFaL1m9o0tASis0DeIUXRn9sVRrbfxwHqarNMo0N6NEKU7AJElJiGM5D7Ce166oJSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijb5dyNg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijb5dyNg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E98AC4CEE9;
	Mon, 28 Oct 2024 21:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152116;
	bh=csgk8n4iRRjcqkq8BEX7gzKoaA91YAbqf7sWW4GqaNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ijb5dyNgkc4TtnhRxSnT4WDozXMbt2uEjiaWW22Y5IOlFHXx1yy9KqyZcZIBCcwV/
	 +IE6m8/Iuj3ghBl/o1LcE3qE6Rgr8CtPwOcqZb9ZmInZU/ilOulwHrHoru2zw6mFCT
	 XoPU/4Jcqc1brMpbwMpwDp1UqX5URIOOzPBoFDDUBLNi9LU1Nj9Xx5iZIFKFcTMuWo
	 MMydmTWIQe/o382RuMSoq6AtHssgWq6St9kC557nvwrkUo43Unk7USbTEcknXWKpof
	 4aqGcnPhl0AxQn673MKuHwew99TM+FP0aT7oDDwxYST5AFDXn0BABTowqpULK6b2KG
	 Eesxu5SYisfdw==
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
Subject: [PATCH v3 06/19] x86/vdso: Enable sframe generation in VDSO
Date: Mon, 28 Oct 2024 14:47:53 -0700
Message-ID: <ebc4e4a51af47cd1e9a1c515407410e1f69d224f.1730150953.git.jpoimboe@kernel.org>
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
Message-ID: <20241028214753.-hfD_ytd9Xj1tlTcNFYf_mV9LQVYCyWVW1ynhto9ln4@z>

Enable sframe generation in the VDSO library so kernel and user space
can unwind through it.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/entry/vdso/Makefile          | 6 ++++--
 arch/x86/entry/vdso/vdso-layout.lds.S | 3 +++
 arch/x86/include/asm/dwarf2.h         | 5 ++++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index c9216ac4fb1e..75ae9e093a2d 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -47,13 +47,15 @@ quiet_cmd_vdso2c = VDSO2C  $@
 $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
 	$(call if_changed,vdso2c)
 
+SFRAME_CFLAGS := $(call as-option,-Wa$(comma)-gsframe,)
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
@@ -63,7 +65,7 @@ endif
 endif
 
 $(vobjs): KBUILD_CFLAGS := $(filter-out $(PADDING_CFLAGS) $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
-$(vobjs): KBUILD_AFLAGS += -DBUILD_VDSO
+$(vobjs): KBUILD_AFLAGS += -DBUILD_VDSO $(SFRAME_CFLAGS)
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index a42c7d4a33da..f6cd6654bb9e 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -69,6 +69,7 @@ SECTIONS
 	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
 	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
 
+	.sframe		: { *(.sframe) }		:text	:sframe
 
 	/*
 	 * Text is well-separated from actual data: there's plenty of
@@ -97,6 +98,7 @@ SECTIONS
  * Very old versions of ld do not recognize this name token; use the constant.
  */
 #define PT_GNU_EH_FRAME	0x6474e550
+#define PT_GNU_SFRAME	0x6474e554
 
 /*
  * We must supply the ELF program headers explicitly to get just one
@@ -108,4 +110,5 @@ PHDRS
 	dynamic		PT_DYNAMIC	FLAGS(4);		/* PF_R */
 	note		PT_NOTE		FLAGS(4);		/* PF_R */
 	eh_frame_hdr	PT_GNU_EH_FRAME;
+	sframe		PT_GNU_SFRAME;
 }
diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
index b1aa3fcd5bca..1a49492817a1 100644
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
2.47.0

