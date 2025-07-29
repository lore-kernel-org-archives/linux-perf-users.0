Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE60298CBC
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Jul 2025 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753810970; cv=none; b=XCZLhB0U3bbePHoP3BL6AL0IJ96AjvwLv4F+NlMgE8JDGJoFaDR0F3rUBMIGWBqG7icE+R93IE8u4vuX1GZMjsLdoviEbuT2xHsaDlIY/MvXl1gZf6uS0/JoxhKWx98/OU3hRLZLaH81O/D6y19Es/e19e9HU8RiMwrwTW0W9cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753810970; c=relaxed/simple;
	bh=UYBEIMyzSrNEBgHDKHOOrkv/8nq3K58nn32I5bNBWRA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jb5hASRBPqR2SGN0eFLlXD68t8XZOIJUXgsxQ4rnNx7/WMnGm8QoXAdKwEgXoYzoCsmsl9FAblERZsExOfGOfjuYS7rJ0cxCgTKpoCRNOS+P1CtMPpXEiNjb3S0YCyWGvr/6lBlXEd91NaZc98YRc1r/5ahk3ZUY46yaTp7B65w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=guImVWIq; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="guImVWIq"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31eac278794so3294129a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Jul 2025 10:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753810968; x=1754415768; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0cDIK6qF6nWwCr2NoTbZWaYG+2Frltnz2b6AbcPAKOQ=;
        b=guImVWIqe5AfaMLgQxuFjCHp3UkCsbDbgz4JIpmlH73MNctb4SV4UrxXGPP5dW8Gae
         9kx4SGgdNDtb8tGA1PiVxQ2FaYR7kuUDc+Hpm+rE+ivQuYY9NL4h4i1Jmo2XxTrioWqK
         7BCjCONvZ0k02qVQgOjZbumXqtjSr3Ww/uqTr+UGLaX3vq6r/JALGaNFrE6y/408FryT
         iP4V4dBgWm0sS06RYJwSre0VY865W5nXUwNs/xvaPz4XgF4Q5xxenFNHBm8/WBWyREDk
         CDAtEkfyZaVVq0bVLNFsrHvWEe7OdERLpvT+zpjRjVWvJNA/gVNbvOaIO6M4vZEhT+4h
         ruJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753810968; x=1754415768;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0cDIK6qF6nWwCr2NoTbZWaYG+2Frltnz2b6AbcPAKOQ=;
        b=J8xjsGeuW/VXKdgxoq3VBK85LpQv5DVWrEM/qPxiNdkFKkZ/lKpZ0nhvkFfD8fHqSB
         +1I/ZDCjoidGd7sAwOdHM5MECUyXtZYgvmULK1Og14+9zc/VQ+5uK2EmA2qKQCg08WFX
         ZnhgT8WDr4YaveFgVE+pXc3V9W59RpIyKYeP9VhipJUERgQZQiWe5vWUF1P+jVnr6kRS
         +2i5ZMC0Q877OlhTGP6qJRXBABgOyZQvkZ00ftvBOqAoH79JbM0W1hIHUQydEBhED+GU
         S/1I8XE0nm02Q4u8EbjhmrxYRwSy4o7YH0f19wCdSidPn+OO7iCYZOejD9Wq6zqjGvVn
         O9Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXvc/o1gpNP5VjxYJS7d2MCNA4uIjw38lnftwp4BuJj+0Jc3GTBbNZ/ZgXCNBfSIkLYOt25p8NkV8E4qNOxuCF3@vger.kernel.org
X-Gm-Message-State: AOJu0YxiKwCksGPAKisUnm6BlNanbe5lhnqC8L3nPVky3uah2GpITiDe
	Gz7jk6bnRNe2CTL0gbTn8MzGFbZrhSNMWHKWr4qOhEP5HXvqjVc7Lxt8v2d2K1zWC0AmKofEb4z
	g4n0sYw==
X-Google-Smtp-Source: AGHT+IEy2tKRxEDM0MA44Vkr5JiteWyEFEnQvVSVGFQxO5N3upFR7JMnSmnNBB5kB8Ubw1uZp7pGKyP+A6w=
X-Received: from pjsc24.prod.google.com ([2002:a17:90a:bf18:b0:31f:3029:884a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:47:b0:31f:42cd:690d
 with SMTP id 98e67ed59e1d1-31f5dd9e0d8mr540145a91.13.1753810968559; Tue, 29
 Jul 2025 10:42:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Jul 2025 10:42:36 -0700
In-Reply-To: <20250729174238.593070-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729174238.593070-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729174238.593070-5-seanjc@google.com>
Subject: [PATCH 4/6] KVM: x86: Drop pointless exports of kvm_arch_xxx() hooks
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Andy Lutomirski <luto@kernel.org>, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
	Jason Herne <jjherne@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, 
	Holger Dengler <dengler@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-sgx@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Drop the exporting of several kvm_arch_xxx() hooks that are only called
from arch-neutral code, i.e. that are only called from kvm.ko.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a1c49bc681c4..14c0e03b48ae 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13492,14 +13492,12 @@ void kvm_arch_register_noncoherent_dma(struct kvm *kvm)
 	if (atomic_inc_return(&kvm->arch.noncoherent_dma_count) == 1)
 		kvm_noncoherent_dma_assignment_start_or_stop(kvm);
 }
-EXPORT_SYMBOL_GPL(kvm_arch_register_noncoherent_dma);
 
 void kvm_arch_unregister_noncoherent_dma(struct kvm *kvm)
 {
 	if (!atomic_dec_return(&kvm->arch.noncoherent_dma_count))
 		kvm_noncoherent_dma_assignment_start_or_stop(kvm);
 }
-EXPORT_SYMBOL_GPL(kvm_arch_unregister_noncoherent_dma);
 
 bool kvm_arch_has_noncoherent_dma(struct kvm *kvm)
 {
@@ -13516,7 +13514,6 @@ bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
 {
 	return (vcpu->arch.msr_kvm_poll_control & 1) == 0;
 }
-EXPORT_SYMBOL_GPL(kvm_arch_no_poll);
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
 int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order)
-- 
2.50.1.552.g942d659e1b-goog

