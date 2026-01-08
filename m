Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6547F328B5F
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767902654; cv=none; b=uqmpTf+z3sy5TnMVkm6RLdrKN4AXKYspTukla2gR7UXhMXvtFkrqcC4fJvWBX2S4Xoc0u0kbEnQ4VFvFeuN483bRZdKPH1G1jgwJu2TJhOBs/Nt1hUjgI4D5xDgETc3Or2rLKp6JjAbvPFrfcRH5QWics1+R2xnvjaMWdH3MPp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767902654; c=relaxed/simple;
	bh=Sc+ak6kXD2O2otUHZGDuYAqOJ/KnbA1ceZEKyhd2zdc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kGpvOxN4uckBYkKo7HX8A08ON0s5XevwNNWFKlMCz146ZVD3wxuDx+qr+CGo+K+byFbDzONDzDyx/4HPPNvIdyksHG8oV9FTUBv4XORa9YutM7VR7gzoVz2Z6Kv4+z51U2aP+6SZJlQN1HgFW+BeMrqoccHljPngNk4WC9rJeWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0arqA01X; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0arqA01X"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c55434c3b09so211556a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 12:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767902653; x=1768507453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RHDeNFz490Nrky17RXCNoP5KLrJVy9PVF3wfzv9VqJU=;
        b=0arqA01XpbM3TMubUP5H+mLn2n88A6rvPSWzfrsAKarq2TR9qylufJ57fgzE3QI/63
         i+01Np2Su+UuNW+rNzVa0qSMgG1osn/Et9e4aUK93pxF8el9yVmLbgVqjnu9eLrA9FP9
         ieR3Km8iaPS+m0gZ4LNas7Ayui7ADg/zd1chuZdTKmxWXufxDilfUA7pNWIbTalRaY8K
         KSkBR8bfGhaU5CaQsOmSPzxy18Elbcdtc7V/6Fn4UzslkS0T0GEk8ENkAAedKrU43JSq
         MFYHxw7pxbHzVa8wkZJFKHC9zriuv76mmnnZvmXF9d2wmdRjHcq7FLV6Bu/pRKp2RDle
         90iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767902653; x=1768507453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RHDeNFz490Nrky17RXCNoP5KLrJVy9PVF3wfzv9VqJU=;
        b=bIwRSUaj9ivSsYN/QfBCfSNZx+H7ydexpPMydeRUzMb/dPvU5M5cDouyvB7ZL1ViHS
         11IlIpD15ohqqegbMhCa+RjVs7vjplj5ajXpxJKfq20/DEXZ03xuP+gW8zqXOemFpE3D
         0sMIOb9yjqz0fyoASAiuX9ApFEBfkFe4i4rWeVC/7DbIo95129O4DluhOzLf5ihB12f9
         4bma3U05BvEVeN3HptdstmC8iAjKK5VWpdfmwWsjZBLbMtXy9AkzehQ5GTEFOUq3Xsmi
         dMSxE+jjE7iR1XROtbwgwgw57QLrITCXFCPIqqONudTqJBfPQC4LcCXc6p6Uc0wDI/HB
         JcMQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9lDQvC2YPVbCHL8egeCZMi3i5nohe0y+1uW6Tnli5brmLGDJ7rgaYRrg3b9rd18V1hwfi/tadn7QRWMygi8li@vger.kernel.org
X-Gm-Message-State: AOJu0YyEudvSvZWs7zSwzHExe4R8fJWGejNR2Yi9KpXyugYfC7PSGW2Y
	CqqnHoeSn7V79/Rc+5H/4YBaDmkkGn/PiP0A/3RYyx2tC5wff0KPmRdatsz33SpNld/BOa/BVso
	swaXc2w==
X-Google-Smtp-Source: AGHT+IFhKs48GN0WkSDiAO4qPNHLVPhcEoNB+pDwryoeKjyNGQcxURXgfxIrWzkPwVlbxpHNfeozbbrhcz8=
X-Received: from plhi7.prod.google.com ([2002:a17:903:2ec7:b0:29f:68b:3548])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3947:b0:344:97a7:8c6a
 with SMTP id adf61e73a8af0-3898f9cc49cmr7749765637.51.1767902652739; Thu, 08
 Jan 2026 12:04:12 -0800 (PST)
Date: Thu, 8 Jan 2026 12:04:11 -0800
In-Reply-To: <04c70698-e523-43ae-9092-f360c848d797@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251206001720.468579-1-seanjc@google.com> <20251206001720.468579-40-seanjc@google.com>
 <04c70698-e523-43ae-9092-f360c848d797@linux.intel.com>
Message-ID: <aWANuxukqWmo36N0@google.com>
Subject: Re: [PATCH v6 39/44] KVM: VMX: Bug the VM if either MSR auto-load
 list is full
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Xudong Hao <xudong.hao@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Manali Shukla <manali.shukla@amd.com>, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Dec 08, 2025, Dapeng Mi wrote:
> On 12/6/2025 8:17 AM, Sean Christopherson wrote:
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index 38491962b2c1..2c50ebf4ff1b 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -1098,6 +1098,7 @@ static void add_atomic_switch_msr(struct vcpu_vmx *vmx, unsigned msr,
> >  {
> >  	int i, j = 0;
> >  	struct msr_autoload *m = &vmx->msr_autoload;
> > +	struct kvm *kvm = vmx->vcpu.kvm;
> >  
> >  	switch (msr) {
> >  	case MSR_EFER:
> > @@ -1134,12 +1135,10 @@ static void add_atomic_switch_msr(struct vcpu_vmx *vmx, unsigned msr,
> >  	i = vmx_find_loadstore_msr_slot(&m->guest, msr);
> >  	j = vmx_find_loadstore_msr_slot(&m->host, msr);
> >  
> > -	if ((i < 0 && m->guest.nr == MAX_NR_LOADSTORE_MSRS) ||
> > -	    (j < 0 &&  m->host.nr == MAX_NR_LOADSTORE_MSRS)) {
> > -		printk_once(KERN_WARNING "Not enough msr switch entries. "
> > -				"Can't add msr %x\n", msr);
> > +	if (KVM_BUG_ON(i < 0 && m->guest.nr == MAX_NR_LOADSTORE_MSRS, kvm) ||
> > +	    KVM_BUG_ON(j < 0 &&  m->host.nr == MAX_NR_LOADSTORE_MSRS, kvm))
> 
> nit: Remove one extra space before "m->host.nr".

Oh, that's intentional, so that the rest of the line is aligned with the "guest"
line above.
