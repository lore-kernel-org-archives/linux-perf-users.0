Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69621192D99
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Sep 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276567; cv=none; b=MNyaRzXQZUfeR0mAm/uiDqni/rretTvd6uRBWUhtQM8CwC1ht/iI8qK0lQ9Cdw6l1oWWVT1VxR6PHt2SnbK0Pzb4jzWtJdtBWFXZDo19piS5WioCTayQ9PjNwdd3rHa0ejo7y4VwlcMdQSmeB8zoyf/fk3vDRcL/r7n4CJ9UdpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276567; c=relaxed/simple;
	bh=9UAQuGK2mWhKEqX7oxUH9zhtKGPJ6CK9xsJA2g/Xjq0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pZ/utagxXDPHovZxAyNtoC3PH5mrlj/D3G3VsEadX17YWwhRf+pfuCEsDtacDk6cx4Y4z8XCCc9ARc2lRCtI827fOuawgyKVM4lxDb5/rpf4eqzTKR8sJ46RGz8N9hmGVazSqPTf00lX3IMKH90wLT1O6PIgRvK7fSuqBj5hbqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IaC9jD8Y; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IaC9jD8Y"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6db7a8c6831so109995697b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Sep 2024 08:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727276561; x=1727881361; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FlbORA03gt7VD7U3AKlte04ifRsDRozPK1w/WollpSI=;
        b=IaC9jD8YpWlb+NCU9e67XCuo3kv2uwa1BPK7X8tClCdPocUNZWV6grI1ExqTONqDqc
         rmnlZCQt6Ck4GzQuASe+KiECDP/vsIVbr7TdzUY6cUov2xdnNCm/ELgFEcQWMQF4AUuO
         0RtMVJ+cCkyJDZVieNIZorPUcLLzjFi6L3e60UlQ6iUZyjBZmr2kjgN43hHKApZcvVKy
         rsT7wtMPICkxJ/4cdjBNppSp6ArQf5d6t8ncw+pysDbe5BiD6s63bnOlU9AA36XlUgD3
         PY9j1Fmf1ULtMhN80q32jriOG27+u8TcDn8OA4AB19vLWG0CpGNRuBiKrWMTaQP7ExCw
         EJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276561; x=1727881361;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlbORA03gt7VD7U3AKlte04ifRsDRozPK1w/WollpSI=;
        b=BF7h9sH812852L4f68EszaMsdwkry3tCPX2RdhDsyEaqFwZ/uCNyJZ19GgBuYzgD5+
         PW87JfJFbwxQAhSw8pHQOHj5jDKZSkaJuRVUQRHTHXAFkaJXpdNNToXK5cdN/7m4frnt
         leB7Z5Kb5Tu5AjTzaLi5H7N1vlyrHVeUboQ0htxgCGHP9H+ibg2Qwu9FgJnndQIgTrf/
         nG8jfBBd3zzIRSXK0oCHFXUxe0MskyCXM5iJPZKnj06RcBBuGiTdhMac/rBKz+We/sn1
         +s00fh4ivcl/eIQxMMGzO3JVUGiA94IDjWeEwNgSpd5L/yYQF/31x8JgsYLvUfAzIVMe
         Kh8A==
X-Forwarded-Encrypted: i=1; AJvYcCWXLcSn8pllbKIDVHcaKVy7y3duJBlmImb04d7NzUlmsjrc0UZ6pe5ur6aCMRt0stwsUcwZgwj0Nqwa/p/mrTlj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/rDn0nEvXpDdQFhyr1eiQ5PwweJJwawIlo/awx1z/EIA4Xa69
	lE3PaLheYySTPxDnU3LCFFPgzkOVQA6dLMPDfO4+a9wuopAPTxlC+nZWMc2BglZGtrSZCg==
X-Google-Smtp-Source: AGHT+IH4yCJxpgJpRghyt05ffZ0KMtbzY3622CltTm7OPK0ZYLkhBwwkH9bUzMfV7VeGOafl80KA41By
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:4289:b0:6e0:1ad:b197 with SMTP id
 00721157ae682-6e21d9eb35cmr74667b3.3.1727276561223; Wed, 25 Sep 2024 08:02:41
 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:01:20 +0200
In-Reply-To: <20240925150059.3955569-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2120; i=ardb@kernel.org;
 h=from:subject; bh=udZt3Ybebg1JaBid31YzntWp5JIa5pAk0HVUlAzZyZ0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2L6gljFsPIOfpfC+4mTz0SPOfTfNeM53artXe5vlz2r
 m2tZ4xiRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjI/0qG/z53N1inv844/EXP
 gLPr2aVVD8T/nDB5/WSxtlzL53WrfboZGX7d3NY04aKrkHqeft+Obu4DWbvCTcvYF6zT0yzuZn0 pwQAA
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925150059.3955569-50-ardb+git@google.com>
Subject: [RFC PATCH 20/28] x64/acpi: Use PIC-compatible references in wakeup_64.S
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Use ordinary RIP-relative references to make the code compatible with
running the linker in PIE mode.

Note that wakeup_long64() runs in the kernel's ordinary virtual mapping
so there is no need to record the address of .Lresume_point in a global
variable. And fix the comment while at it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/acpi/wakeup_64.S | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index 94ff83f3d3fe..af2f2ed57658 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -14,7 +14,7 @@
 
 .code64
 	/*
-	 * Hooray, we are in Long 64-bit mode (but still running in low memory)
+	 * Hooray, we are in Long 64-bit mode
 	 */
 SYM_FUNC_START(wakeup_long64)
 	movq	saved_magic(%rip), %rax
@@ -40,7 +40,7 @@ SYM_FUNC_START(wakeup_long64)
 	movq	saved_rsi(%rip), %rsi
 	movq	saved_rbp(%rip), %rbp
 
-	movq	saved_rip(%rip), %rax
+	leaq	.Lresume_point(%rip), %rax
 	ANNOTATE_RETPOLINE_SAFE
 	jmp	*%rax
 SYM_FUNC_END(wakeup_long64)
@@ -51,7 +51,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
 	xorl	%eax, %eax
 	call	save_processor_state
 
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	%rsp, pt_regs_sp(%rax)
 	movq	%rbp, pt_regs_bp(%rax)
 	movq	%rsi, pt_regs_si(%rax)
@@ -70,8 +70,6 @@ SYM_FUNC_START(do_suspend_lowlevel)
 	pushfq
 	popq	pt_regs_flags(%rax)
 
-	movq	$.Lresume_point, saved_rip(%rip)
-
 	movq	%rsp, saved_rsp(%rip)
 	movq	%rbp, saved_rbp(%rip)
 	movq	%rbx, saved_rbx(%rip)
@@ -88,7 +86,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
 	.align 4
 .Lresume_point:
 	/* We don't restore %rax, it must be 0 anyway */
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	saved_context_cr4(%rax), %rbx
 	movq	%rbx, %cr4
 	movq	saved_context_cr3(%rax), %rbx
@@ -137,7 +135,6 @@ saved_rsi:		.quad	0
 saved_rdi:		.quad	0
 saved_rbx:		.quad	0
 
-saved_rip:		.quad	0
 saved_rsp:		.quad	0
 
 SYM_DATA(saved_magic,	.quad	0)
-- 
2.46.0.792.g87dc391469-goog

