Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262FF18F2D4
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Sep 2024 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276547; cv=none; b=KAOn1sMSW2Sy/u9aiYH7HbAaa8RBueYYo5UrZhnbDhacccqZVdwRzdI9O7KafXGMtaPM/Q64faSKDjkcFl8oDNiiFJCWDLudblTmKQ+DhtCNoPVbO1G61e6CMTLQGTova9wSpSYne/sECWmiG77DnpGT05xvaNpLcU9Q+dx6ciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276547; c=relaxed/simple;
	bh=P2FcDMrWaViJAVOVZOgFhqVr7ndECoGt9aNdX1NbL6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dZjcDuvRXTQ+DomN1FxceuK6cRgBQ9rwTKBOkQPXPAZevjCGzFRsRWTRm8YPaT9PVY1+bH94i4topC1Kth5rHSrRviyFcTKE6GslN6BGXxTPCb4/KHTDJi66HaDVJJSwuMpQ/zTG9+gPLie/iqQQ3Vpgz6MO3rWoS2jcrFroKWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lQtn/1YJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lQtn/1YJ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1d46cee0b0so10267429276.2
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Sep 2024 08:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727276543; x=1727881343; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vu/ZbROFphQGBAR+273iXbk1tlXuWo8crbz4dEomRj0=;
        b=lQtn/1YJn8ofwp00YPqh/7ezdca6i/dHyOqwIKn9NYR/t34JCf/JnPUsE/CTB64V03
         XZQA9DoCVY0P4KsZmS6kF6A3RLqm2zeGzo6VDPM6iwiemCFUih2Dg0OCxkYSE/SMg1Us
         cW7HeP21m6KnShkftmJzo9cbUKesSxLQSeKXdqNy6YyZxhbp0xOCN+it/zMTpFMhQ21A
         5K4QzdOBDM237nQcdJz6PAF+hW1p8zl8uML/NoXt6W8agRnzoo/bdG273F4gG0tLvBj4
         KUtgPm9oCEZZYT+PQrU4BKNIjVqOkVLcWKePKSU60RBD5kDm8Gt0DAAzS+wIlRIB6Dta
         8nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276543; x=1727881343;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vu/ZbROFphQGBAR+273iXbk1tlXuWo8crbz4dEomRj0=;
        b=oLFhuKRLoRHprpXeNI+LlGHXqaV0VYpOkZacuE+Bwt5umZt5Wd1XoydI7n3CLu4Smu
         FuUonSP9I3Y89HHSN1d5uO1om2mW0j1HvNfFS16wBNl+9ghevVQ2udHhBhUUNBdFaECi
         bG9rNfuHsAUEqxDaJjIma2vhJTQScxotmge1VkAO/sDi27lYPJiyFARbsABp2i9/imVP
         Wd3OMVRS9bycUPq7eAy9vCZPI7/144LV0VIYeqdrg9Po+xO7qZBtBMUR50J3bwwYQ0GX
         h4P4LifzbkxhnF4hTHEUazFJ72xSGvZsYM+Q4HFKf4+NJdKb/4ctDQFs67uklsRuB7in
         13qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYRVbbj5vA6Dpl9EkmAs/dUXYo0KsKhqb3UEAqpuILVmgJopNiC7+OOyJB3Fiu24ybPvPfpac5Msxd5mVvc45d@vger.kernel.org
X-Gm-Message-State: AOJu0Yxydfpb61KBP2ztx18nOqN51bIbL0LMmdKXk7kcWmBdZzpNkyeD
	fxck03DbyNfTrLwsuzn995J32N5oCTpkVrLFZkcokCI33XKhJTpBNY5MLSfhT+tk0pV2og==
X-Google-Smtp-Source: AGHT+IEyaWBDeaj2o4LzPpSYVvpQbis55gp/KI/SuWbxXUep7wBTAaa7DqSfUrTGsylfjBz2VoxVb7Nf
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:6902:1782:b0:e0b:958a:3344 with SMTP id
 3f1490d57ef6-e24da39b0c3mr17936276.10.1727276543053; Wed, 25 Sep 2024
 08:02:23 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:01:13 +0200
In-Reply-To: <20240925150059.3955569-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1397; i=ardb@kernel.org;
 h=from:subject; bh=OCB6ogDK8zWwsvV7jOJ7CFiQBF2ggvTbOxK6mQJaX9A=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2L6r76WO61FcfVRPyObM7vdxPl3nB63j7e+T6H1Wu+r
 TX46mXYUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYyaR4jwzOv6S8kr9nwfXyX
 9iPzW9q5kzeEqzTXKbA29B6+VB8ddZORYZns0cK9u93/3DfuTd/m9X/T7v+32d81/dIy2BMjHfO RgwMA
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925150059.3955569-43-ardb+git@google.com>
Subject: [RFC PATCH 13/28] x86/kvm: Use RIP-relative addressing
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

Avoid absolute references in code, which require fixing up at boot time,
and replace them with RIP-relative ones. In this particular case, due to
the register pressure, they cannot be avoided entirely, so one absolute
reference is retained but the resulting reference via the GOT is
compatible with running the linker in PIE mode.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/kvm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 263f8aed4e2c..8eac209a31aa 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -800,9 +800,11 @@ extern bool __raw_callee_save___kvm_vcpu_is_preempted(long);
  * Hand-optimize version for x86-64 to avoid 8 64-bit register saving and
  * restoring to/from the stack.
  */
-#define PV_VCPU_PREEMPTED_ASM						     \
- "movq   __per_cpu_offset(,%rdi,8), %rax\n\t"				     \
- "cmpb   $0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rax)\n\t" \
+#define PV_VCPU_PREEMPTED_ASM						\
+ "leaq   __per_cpu_offset(%rip), %rax				\n\t"	\
+ "movq   (%rax,%rdi,8), %rax					\n\t"	\
+ "addq   steal_time@GOTPCREL(%rip), %rax			\n\t"	\
+ "cmpb   $0, " __stringify(KVM_STEAL_TIME_preempted) "(%rax)	\n\t"	\
  "setne  %al\n\t"
 
 DEFINE_ASM_FUNC(__raw_callee_save___kvm_vcpu_is_preempted,
-- 
2.46.0.792.g87dc391469-goog

