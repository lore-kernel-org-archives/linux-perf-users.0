Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E72F3770D
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Jun 2024 17:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718213492; cv=none; b=NNj6kQe/KtNwUxsOvDBfwriO09XyUANo7kHS9EoD7z23tlDx6FmUzG8HEg3FvDT0Si8AfCtTSP+uRS2Vz5b96x8tqoF9XHnnbsiaf2Y+qet8Q4yawvA11mO1zCxGFGjCRM+0pM8rw76OzJ5kkliH6dfeInpu9EeZ/VktmiOHhL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718213492; c=relaxed/simple;
	bh=BVxVglBu/aJdIm8zaMwOg3iRpiLrT6XOkxr2cN79Qtg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e4HgCJZvdnYayysDROLD96eQZoz8Yc6zspl4ud88fYhWhVIVffpRgdxm54zih0j/klw/wACAxlWVc6GzhKdMqrhRQX5cXlhtatYw0vy03zFakqczQcVM08Y9S6N0pQFCyH1ap+Zibj9i9jUGkg+FD45kQio993kWAUTpbVE5hZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i0cBOEnQ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i0cBOEnQ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1f71d5a85f9so1533005ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jun 2024 10:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718213490; x=1718818290; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZttrWbEybPZrU6j9LIdJZge1/Pd2kmv/UPX9FdzbJ4o=;
        b=i0cBOEnQ8Lm98on5l5RxTTuCBaACWKEtVy/GX9+itfhKIcHzQXC+bEbRE1CKivZvom
         XLKWAM72TlCggUqyPmEKeQke1XuNIOlzohkwzoKEHyVToBzi5mZoefTI++NhFo765QWg
         GQtGvj4OQt+pQa0ZhPozSAHJsGDQ5+RB/bwym06hQL7bt7JmtabMScvFHS/fDjZj4tPO
         KExAVi1jjmXFaw+yAjQL+JhEBDgWsGBlZOgVqxOqOynh3mUd/KG+Y60lRrFbX+AF3jsp
         XlQLl9IhgHEaaYEAk1wx0F1UOhLz1O1h3N4qXU6wvHgPoGkREYLiapvgzagjQ/7K8q0S
         24qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718213490; x=1718818290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZttrWbEybPZrU6j9LIdJZge1/Pd2kmv/UPX9FdzbJ4o=;
        b=C+tMz82cK6BB9PLvr1euEhLDAYzGh0G7i8ZY9/Z5VW7sP614iOWJKEjruiyeyO+0Fi
         E139A4c7ioszuUBKLGS3oQNbSwiZIQhEvuFudSRFpUamzlkIuT3zSiT7GmwWARfpNNUy
         NjjFgceEMSViyRZFan46JVefZfSaY3k3Psr9ebwWeJXbJt6DFAv0+4CqDoZSux+icuXm
         XkuLdnsYfj47tg4bubJSCNLsSgfJe059MItC8qv3ISWxu8nf0uMXFm/zkQniqLod1x9v
         3hfiJ6TmfmfrTVPjd10HZfBbbQiVA5xWWD40xmck6WN2m7T03QZfwz7gSVtaEYOudpLG
         EC2g==
X-Forwarded-Encrypted: i=1; AJvYcCV6DYBrHekx75R1uSuK5oXY9QUlNffhFFS8vd7HGX3AV/moDalRxKl3Qqjo+vgds/dWIwW3ajBfYTMQ+oVM9cjxg/Yn9+vTh7jMZDXcv1IV1Q==
X-Gm-Message-State: AOJu0Ywx5ukrOZWXI0x1pxctomuAYm786dg6NPZidx2W88XkLeG0fIaa
	vSANj4rH5RSd7TUweJWFyMgOuRbmwLz/KD8fFGNCq/fy2eHevlsPNfnJcZ2w3a1qZSFlKS63fJj
	jpg==
X-Google-Smtp-Source: AGHT+IEfEUqjAJd5HwtcI3SellD9wJyKICC45AOG2hDSPfUBXvAeRlQriWUGwdY0fjJOl8E1dOYOBVVBc8s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:182:b0:1f3:4b2a:1acb with SMTP id
 d9443c01a7336-1f83b23ddb1mr79315ad.0.1718213489334; Wed, 12 Jun 2024 10:31:29
 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:31:27 -0700
In-Reply-To: <Zmm9SdVfg18RECT5@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405115815.3226315-2-pbonzini@redhat.com> <20240412104408.GA27645@willie-the-truck>
 <86jzl2sovz.wl-maz@kernel.org> <ZhlLHtfeSHk9gRRO@google.com>
 <86h6g5si0m.wl-maz@kernel.org> <Zh1d94Pl6gneVoDd@google.com>
 <20240418141932.GA1855@willie-the-truck> <ZiF6NgGYLSsPNEOg@google.com>
 <20240419112432.GB2972@willie-the-truck> <Zmm9SdVfg18RECT5@google.com>
Message-ID: <Zmnbb-Xlyz4VXNHI@google.com>
Subject: Re: [PATCH 1/4] KVM: delete .change_pte MMU notifier callback
From: Sean Christopherson <seanjc@google.com>
To: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nicholas Piggin <npiggin@gmail.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jun 12, 2024, Sean Christopherson wrote:
> On Fri, Apr 19, 2024, Will Deacon wrote:
> > On Thu, Apr 18, 2024 at 12:53:26PM -0700, Sean Christopherson wrote:
> > > On Thu, Apr 18, 2024, Will Deacon wrote:
> > > > > I assume the idea would be to let arch code do single-page invalidations of
> > > > > stage-2 entries for each gfn?
> > > > 
> > > > Right, as it's the only code which knows which ptes actually ended up
> > > > being aged.
> > > > 
> > > > > Unless I'm having a brain fart, x86 can't make use of that functionality.  Intel
> > > > > doesn't provide any way to do targeted invalidation of stage-2 mappings.  AMD
> > > > > provides an instruction to do broadcast invalidations, but it takes a virtual
> > > > > address, i.e. a stage-1 address.  I can't tell if it's a host virtual address or
> > > > > a guest virtual address, but it's a moot point because KVM doen't have the guest
> > > > > virtual address, and if it's a host virtual address, there would need to be valid
> > > > > mappings in the host page tables for it to work, which KVM can't guarantee.
> > > > 
> > > > Ah, so it sounds like it would need to be an arch opt-in then.
> > > 
> > > Even if x86 (or some other arch code) could use the precise tracking, I think it
> > > would make sense to have the behavior be arch specific.  Adding infrastructure
> > > to get information from arch code, only to turn around and give it back to arch
> > > code would be odd.
> > 
> > Sorry, yes, that's what I had in mind. Basically, a way for the arch code
> > to say "I've handled the TLBI, don't worry about it."
> > 
> > > Unless arm64 can't do the invalidation immediately after aging the stage-2 PTE,
> > > the best/easiest solution would be to let arm64 opt out of the common TLB flush
> > > when a SPTE is made young.
> > > 
> > > With the range-based flushing bundled in, this?
> > > 
> > > ---
> > >  include/linux/kvm_host.h |  2 ++
> > >  virt/kvm/kvm_main.c      | 40 +++++++++++++++++++++++++---------------
> > >  2 files changed, 27 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > > index afbc99264ffa..8fe5f5e16919 100644
> > > --- a/include/linux/kvm_host.h
> > > +++ b/include/linux/kvm_host.h
> > > @@ -2010,6 +2010,8 @@ extern const struct kvm_stats_header kvm_vcpu_stats_header;
> > >  extern const struct _kvm_stats_desc kvm_vcpu_stats_desc[];
> > >  
> > >  #ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
> > > +int kvm_arch_flush_tlb_if_young(void);
> > > +
> > >  static inline int mmu_invalidate_retry(struct kvm *kvm, unsigned long mmu_seq)
> > >  {
> > >  	if (unlikely(kvm->mmu_invalidate_in_progress))
> > > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > > index 38b498669ef9..5ebef8ef239c 100644
> > > --- a/virt/kvm/kvm_main.c
> > > +++ b/virt/kvm/kvm_main.c
> > > @@ -595,6 +595,11 @@ static void kvm_null_fn(void)
> > >  }
> > >  #define IS_KVM_NULL_FN(fn) ((fn) == (void *)kvm_null_fn)
> > >  
> > > +int __weak kvm_arch_flush_tlb_if_young(void)
> > > +{
> > > +	return true;
> > > +}
> > 
> > I tend to find __weak functions a little ugly, but I think the gist of the
> > diff looks good to me. Thanks for putting it together!
> 
> Circling back to this, I don't think we should pursue this specific tweak, at
> least not without hard data for a concrete use case.

Ha, I spoke too soon.  Based on the learning from the KVM+MGLRU thread[*], it
looks like KVM should omit the TLB flush when aging pages whenever possible.  If
that's not doable on all architectures for whatever reason, then something like
this is probably the way to go.

[*] https://lore.kernel.org/all/CAOUHufYCmYNngmS=rOSAQRB0N9ai+mA0aDrB9RopBvPHEK42Ng@mail.gmail.com
