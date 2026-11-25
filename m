Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587366;
	b=G+7Ss95m8FfP707L085QTHeWbl1Ta7O8/iredkXqPsIDY15FEzsdXyAE71PWwxkq/bCA
	 UognUord3OMrYX7XNAtrB6EGkDaK2cGOyZQOsS1jfu/yM1R5bqpbjAI8Ahck417AOKqmP
	 MA+g5I1kIEYfEjo8HlPDIAJJtvtTBxnPSm0fZKBnnwTAe6eYF1ZhoWaYbBub6d3B+hVZj
	 TkxbYwydU34OjFPFC6+B6o3cBxRlB727sC1c0UeAyx7hGnO0IdpK79XiwxJ+qn3xjd3CC
	 rHiGC6+Ke02BOr1pU/EYHAC0SZLvXKXVl8bMs/BTSPfQnLfKtFrW67x5In02qycUE1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Tq8mjhDcSofx5kxw5eKn8LOnbaPk4exl2xG2U8WBwwQ=;
	b=Z6b+2n9Qtfy+FAxRztHbM1XF3lNMwluiqM38qWdM78E2yheZy/WeqzfrijXXcY0Yu26C
	 NzFoVS2LRvRYu83Jyog8FAMLu0L5o5Y4eeusT49IgAXovoZUQF6Xv1a6/g64s7/R7Olxf
	 UCC6Yy6ovpwrqmuJ1Y5etwdAdp/88p1Z3H8Ew+azJV4+0BvfNIRHeOwWdUwnTFHPB+EI7
	 7il9zOMCNUVyX1w2ZfeqGCLhuuGGcghTke6CytLhL4+75xUJRtc1uFKtDBK7JnHOpAC6e
	 a5e9/zZMbxZV6kSkYzA7Vw24/EGKFJlzsvK5kL7KwYAerzZbWzxZJPr+OXXe0iCed+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XBc4yd4I;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AE1606DE6E
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 06:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74AE1606DE6E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XBc4yd4I
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-383ec96a7deso6021260eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 22:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795587365; x=1796192165; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tq8mjhDcSofx5kxw5eKn8LOnbaPk4exl2xG2U8WBwwQ=;
        b=XBc4yd4IuYHvDt/TolT0eq4CqFjuUCPoHs1qRWCRIlkUa0/ma9Bz2B/ehlL4XD70+/
         L6+Ja9pugipWLAAQ5CWFoSAiRZ+G1rGhoR8HSno+f73YqXbyKxlpUifvKG4u34DS2l7r
         QNEfZcEmteBBKozX5KWdb9OM3f6HoyiBGSJEalQ4Kt6uL2rD4/1QQ0j/syZ8y2ohh1np
         NgY6X/O278pXS3bjNr3irHwfr0XCGHOGiJS+CY2d9wZ2yWz6tSDjK6XIYeK0FmHJ8k8c
         oGYnKF5qiMgoLWaXUf06OGasQXvEIcn5I64ilKLYya0QeFqeTbZsop9rltdvX4QNJpBc
         DV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587365; x=1796192165;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tq8mjhDcSofx5kxw5eKn8LOnbaPk4exl2xG2U8WBwwQ=;
        b=Ox8wfpvBklyG4oINpTwfAEBT7WM9q3hu6QlX2WnwK1YxUpYDansb2y47aXgd+0fPlC
         5DkeBapADGlqMZcdaCPqot0Lnm/pYb7NPrpjU7flz04rxeR1sgRWql36vZdV9uMBic9a
         /OvmT/lFccPDWOgc2dQ4s6FI+ei4GaXuUvYbeTySC3TUWiiU1ZDG/YK1TsvcbUgub0If
         CavUeIe1+FJC0LTEgMxvTazOmMuS55WL1gAVyZ19YpdmTltXaTw4SRczmrN7rYYnYURH
         zCBrwWr1FkbJCrGobB66zV6q6j68i26WvXOXN1BGKc6m0TcWzwumTJYu6j+unN9P8fx7
         7g1g==
X-Forwarded-Encrypted: i=1; AL+hErEThglEEKgEU5t522nmcBzgJgFnGuMYSWx6THHlbgwOmzdkAe3dvZheyNvdF/lF55Q2bry6fDGBSpR2NtfbFaBO@vger.kernel.org
X-Gm-Message-State: APuU4Z/Hy8U64FFF6EGSubbQNjpvE6GjNW1/e/fH08pCz3YdVrbzMGs1
	/+H60qNzZDdKyhlDACmVkgpSX5Kig7h7lSTaK9+XOiGJtELP83zlbYTa4q1yNB+ES7zAglAgnZV
	fi63lW+aspA==
X-Received: from dyckx5.prod.google.com ([2002:a05:7300:c7c5:b0:386:c57e:ee36])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4201:b0:385:b8f4:755d
 with SMTP id 5a478bee46e88-385b8f47ad3mr17347048eec.20.1795587364179; Tue, 24
 Nov 2026 22:16:04 -0800 (PST)
Date: Tue, 24 Nov 2026 22:14:57 -0800
In-Reply-To: <20261125061523.1540234-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125061523.1540234-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125061523.1540234-5-irogers@google.com>
Subject: [RFC PATCH v2 04/30] x86: unwind_user: Support Minimal DWARF CFI user unwinding
From: Ian Rogers <irogers@google.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org
Cc: jpoimboe@kernel.org, rostedt@goodmis.org, peterz@infradead.org, 
	mingo@redhat.com, tglx@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, mhiramat@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	nathan@kernel.org, llvm@lists.linux.dev, nsc@kernel.org, 
	linux-kbuild@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, ardb@kernel.org, linux-efi@vger.kernel.org, 
	maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, indu.bhagat@oracle.com, jremus@linux.ibm.com, 
	wnliu@google.com, dylanbhatch@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Provide unwind_user_cfi_arch() in arch/x86/include/asm/unwind_user.h for
both 64-bit x86-64 (%rsp=7, %rbp=6, %rip=16) and 32-bit IA-32 compat
(%esp=4, %ebp=5, %eip=8) user tasks, and select HAVE_UNWIND_USER_CFI on
X86_64.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 arch/x86/Kconfig                   |  1 +
 arch/x86/include/asm/unwind_user.h | 47 ++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58dce0b66179..c8096cf66c38 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -300,6 +300,7 @@ config X86
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UACCESS_VALIDATION		if HAVE_OBJTOOL
 	select HAVE_UNSTABLE_SCHED_CLOCK
+	select HAVE_UNWIND_USER_CFI		if X86_64
 	select HAVE_UNWIND_USER_FP		if X86_64
 	select HAVE_USER_RETURN_NOTIFIER
 	select VDSO_GETRANDOM			if X86_64
diff --git a/arch/x86/include/asm/unwind_user.h b/arch/x86/include/asm/unwind_user.h
index 6e469044e4de..1a6be08968c3 100644
--- a/arch/x86/include/asm/unwind_user.h
+++ b/arch/x86/include/asm/unwind_user.h
@@ -4,9 +4,17 @@
 
 #ifdef CONFIG_UNWIND_USER
 
+#include <linux/unwind_dwarf_cfi.h>
 #include <asm/ptrace.h>
 #include <asm/uprobes.h>
 
+/**
+ * unwind_user_word_size() - Return the user-space word size in bytes on x86
+ * @regs: User-mode register state.
+ *
+ * Return: 8 for 64-bit user mode, 4 for 32-bit IA-32/compat mode, or 0 for
+ * VM86 mode stacks which cannot be unwound.
+ */
 static inline int unwind_user_word_size(struct pt_regs *regs)
 {
 	/* We can't unwind VM86 stacks */
@@ -15,22 +23,61 @@ static inline int unwind_user_word_size(struct pt_regs *regs)
 	return user_64bit_mode(regs) ? 8 : 4;
 }
 
+/**
+ * unwind_user_cfi_arch() - Populate x86/x86-64 DWARF register numbers
+ * @ws: User word size in bytes (8 for x86-64, 4 for i386).
+ * @arch: Output DWARF CFI architecture descriptor.
+ *
+ * Return: true if @ws is 4 or 8, false otherwise.
+ */
+static inline bool unwind_user_cfi_arch(unsigned int ws,
+					struct dwarf_cfi_arch *arch)
+{
+	if (ws == 8) {
+		*arch = (struct dwarf_cfi_arch){
+			.ws	= 8,
+			.sp_reg	= 7,	/* %rsp */
+			.fp_reg	= 6,	/* %rbp */
+			.ra_reg	= 16,	/* %rip */
+		};
+		return true;
+	}
+	if (ws == 4) {
+		*arch = (struct dwarf_cfi_arch){
+			.ws	= 4,
+			.sp_reg	= 4,	/* %esp */
+			.fp_reg	= 5,	/* %ebp */
+			.ra_reg	= 8,	/* %eip */
+		};
+		return true;
+	}
+	return false;
+}
+
 #endif /* CONFIG_UNWIND_USER */
 
 #ifdef CONFIG_HAVE_UNWIND_USER_FP
 
+/* Standard x86 frame record: {saved_bp, ret_addr} at [bp, bp + 2 * ws). */
 #define ARCH_INIT_USER_FP_FRAME(ws)			\
 	.cfa_off	=  2*(ws),			\
 	.ra_off		= -1*(ws),			\
 	.fp_off		= -2*(ws),			\
 	.use_fp		= true,
 
+/* At function entry before push %rbp: return address is at [sp, sp + ws). */
 #define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)		\
 	.cfa_off	=  1*(ws),			\
 	.ra_off		= -1*(ws),			\
 	.fp_off		= 0,				\
 	.use_fp		= false,
 
+/**
+ * unwind_user_at_function_start() - Check if @regs is at a function entry point
+ * @regs: User-mode register state.
+ *
+ * Return: true if stopped on an entry uprobe before the frame prologue ran.
+ */
 static inline bool unwind_user_at_function_start(struct pt_regs *regs)
 {
 	return is_uprobe_at_func_entry(regs);
-- 
2.56.1.831.g720f3f5937-goog

