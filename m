Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233551E505
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723816324; cv=none; b=G6O4g82EqvhIki0MtEwxfY9jG6tYnM/yPwPaLTtoZBngxuIYuszPc4VhvjJ3V5e7iPzxoRrSFnye47kLx5oJaCq02Ml1SCoICql6chejuR+GFR/IMqwAlcQLspQIOByb7wCFcZlTpCYpedBoPVmHoCNjdobLf6sGJNoWY1z+47o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723816324; c=relaxed/simple;
	bh=0vMnJeItITEKUhZ+4B6u6aLPzmgxLi8GhPQvynlgOeQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ryI4MtBWsWXxotLkaZV+iB5bMjY9193gnqxJeOtUZYWDpkAzHowXfIoEnVJIWqM6FfSG9EBXilZ6eaX3+opyg4xokGS2zQIJW7dTGz2HKZZ3lqnk8aEi5deNDgEr5UizHbGj8QuR8ApefaIB4mpNpkzACS1XL4yfTn5//AgxTfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4iKDHoXK; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4iKDHoXK"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71274faa89aso1294465b3a.2
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 06:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723816321; x=1724421121; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1BIM/YN0EFHp0lGV/J6CAgo0gM9QaqgZeNQr3CGSECg=;
        b=4iKDHoXKZJ47WrKMiK0STaS6i/UpnXZN96uI1sbN0giA2KfJ7+DuVsQyuOpNLitKyb
         UqUrbzHqWDAaQbSA8mt+nnWu5/w78QrOn1wI7e0+wWQVX86EAuCJbD90sszD7Oc4m4Gv
         /7lOQLUYsl9JZoPSZKSxJqSkWYE9G/EObA0SSQjjxI/U9ehUrB1o+I4+6s3iLl6AVXVG
         dRynkg0S1x7j7rm3QQGkhJnxC4566EI+Y85YrhF6dCyc57qD6FEVX8ZfQpUv05syZzXn
         N2igHw9rhM6/5iZm7u7/VXTGfJYggZBkV7lVizeg6QcqsxzJtOpa5UW69VuYx+6XqcF5
         tdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723816321; x=1724421121;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BIM/YN0EFHp0lGV/J6CAgo0gM9QaqgZeNQr3CGSECg=;
        b=sXk7p9XQaFY7RuzylxJQdxXTKb9/ZCTD+6agMibTeZkTEY04mc7EqfcGCH3BSgNv2l
         3wStinRSnw2XOJsT00RwK6pZzzcPdaOnOPQVHaFNObN62raXD6n+aXMG0yf6iSAuCtyh
         vYDxVrYBlNhKLODIOA3wd5idG+HIf+lqNUhUQrk6u9ZFoIcNTOQ3ZFfceURTJzx/G/w/
         AFNNny3TDm6Y39bnkzoPv0sm4iulpS7mXOumSICNt+i6eujPFw8pWMMoaZEEAVJ1VI/O
         gvWqqNEBmjsBX+CRe41KNYSNE7/zpf0+IN0itGnTy8PG+8T7L2RQjoiTtuivY2C7I4tM
         jPNA==
X-Forwarded-Encrypted: i=1; AJvYcCXXZHvwW15wFI8ymBb+jzvWw2K0S3rVwNmXepA6Kj0O8K5GnvcqMceysvTLUcqpinXKdGoMmo8mZ5nIP6zovHD27tjSjQydeP8le7J+Nq2GKw==
X-Gm-Message-State: AOJu0Ywjf9BcmM2TFdc/KfWTEjs8a8dPpG7Rh6bElG6ZMo7vl18cdkgr
	z8v5SE3RV6LDXphoRH2vL4ORX0bXCUcryojEFIg3G3jgeF8+i6GH1zs/ACtmPZwgVuJfNVGdQ0S
	eVA==
X-Google-Smtp-Source: AGHT+IH8a8qcXJJW+Qp3bJP39BsD1Cyr84EbX9y+L3n28Q1J2pBP/8qUIq8u5YL+mnRxlhFVVdYB1lvysvs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:aa1a:0:b0:70d:2547:44a with SMTP id
 d2e1a72fcca58-713c528e49cmr11004b3a.5.1723816321203; Fri, 16 Aug 2024
 06:52:01 -0700 (PDT)
Date: Fri, 16 Aug 2024 06:52:00 -0700
In-Reply-To: <20240709143906.1040477-12-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709143906.1040477-1-jacob.jun.pan@linux.intel.com> <20240709143906.1040477-12-jacob.jun.pan@linux.intel.com>
Message-ID: <Zr9ZgDIhUEzUlOFa@google.com>
Subject: Re: [PATCH v4 11/11] KVM: X86: Use common code for PV IPIs in linux guest
From: Sean Christopherson <seanjc@google.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: X86 Kernel <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Xin Li <xin3.li@intel.com>, linux-perf-users@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Tony Luck <tony.luck@intel.com>, Andy Lutomirski <luto@kernel.org>, acme@kernel.org, 
	kan.liang@linux.intel.com, Andi Kleen <andi.kleen@intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, Sohil Mehta <sohil.mehta@intel.com>, 
	Zeng Guang <guang.zeng@intel.com>
Content-Type: text/plain; charset="us-ascii"

"x86/kvm:" for the scope.  "KVM: x86:" is for host-side KVM, this is guest code.

On Tue, Jul 09, 2024, Jacob Pan wrote:
> The paravirtual APIC hooks in KVM, some of which are used for sending PV
> IPIs, can reuse common code for ICR preparation. This shared code also
> encompasses NMI-source reporting when in effect.

Please state what the patch actually does, not what it can do.  For folks that
aren't intimately familiar with FRED (read: me), that second sentence in particular
is wildly unhelpful.  I had to download yet another version of the FRED spec, and
decipher the poorly documented software-defined encoding scheme introduced by this
series just to understand what this patch does.

And the order of patches in this series is broken.  Overloading the vector *before*
switching the PV IPI code to __prepare_ICR() will result in KVM sending garbage
to the host.  I.e. _all_ IPI implementations need to be made safe before the NMI
source reporting code can be introduced.

> Originally-by: Zeng Guang <guang.zeng@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
> v4: Refine comments, no functional change.
> ---
>  arch/x86/kernel/kvm.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 263f8aed4e2c..a45d60aa0302 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -516,15 +516,7 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
>  
>  	local_irq_save(flags);
>  
> -	switch (vector) {
> -	default:
> -		icr = APIC_DM_FIXED | vector;
> -		break;
> -	case NMI_VECTOR:
> -		icr = APIC_DM_NMI;
> -		break;
> -	}
> -
> +	icr = __prepare_ICR(0, vector, 0);

Rather than force KVM to throw in junk dest+shorthand, what about adding a
__prepare_ICR_vector()?  Then KVM doesn't need to arbitrarily pass zeroes, and
even __prepare_ICR() itself benefits (IMO), e.g. this is nice and easy to read:

static inline unsigned int __prepare_ICR(unsigned int shortcut, int vector,
					 unsigned int dest)
{
	return shortcut | dest | __prepare_ICR_vector(vector);
}
