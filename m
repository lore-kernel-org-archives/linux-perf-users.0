Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA87BCD13D2
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Sep 2023 16:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjIRQFJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjIRQFG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Sep 2023 12:05:06 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C7CE65
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Sep 2023 09:02:37 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id af79cd13be357-76e26652e6fso629450985a.2
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Sep 2023 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695052757; x=1695657557; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sNXD76U7haNeW91VMZlpdLB8TVqFEiovhx95zes76gg=;
        b=YT+ooOOdzFzo+HBgHjhmjfLpI4c3ZNkc3O185v4C1Ya+nGtX3YTZCc8KxWxXUmNuP0
         AWnFBNU4sl0b5uGVGGvfi1EzBd+VU4/QS41NN9zXG5osiKA/h4jPgW+NVHHCDgiI62zi
         +W28wb4VbpGAaSncysFM1SjmEBACJdidZlFR+n0kluF+MEzZXQDwJ3KMfTfCMjfcm6UP
         MvL2iPyFk8+C/jjIjctcRaxETyyujAVeLBK+3w0Rj0HPUBHpAOQqJLnd1X5OR/mYX5d3
         l0h/mbTt4JAP6H9NuT0+wNds6+Qf41Tv/67qD+XDpf8NveGqVTJ1d9cpb7fNDSeQ8W7D
         HG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695052757; x=1695657557;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sNXD76U7haNeW91VMZlpdLB8TVqFEiovhx95zes76gg=;
        b=JgLUbSKeCpXNrPgvlhsSMXXXyfcabL88yebTWTh3TWVZhPaFtCPXJdMg0jnRQjm8f4
         w+FzF+ZNGYU7Xgq0G8NvO7byxbAuVBoG86M94yCCg8ZhFzB0DdGgTjYtuO4GY/99Ivsa
         fPzKwUa3ikC2ksGkYdsv7UJxSKHQqvn72nHQB3BgvYJki+OjSHcui0k4X9Nu1z7ltsWM
         UfzAO0c59TCCHJpznsB17O/hXDoRd+MV/y9plK34SLSwOCYiKraxwQDs4xMkVXkoq1b2
         YjXCUq7/65JaEdw8FNgyeHZF56yuYVky32Mev/ncyO5EkhiCPQQU79jt6KpEoyA8OwxW
         fHNg==
X-Gm-Message-State: AOJu0YysAMtDatoxRG3jNrlAIEwurXOl2n/aHBVSA005W1wxbLrzbMnS
        m3zUtv5Yuyp/+sRCYyXoViqNIxrVM8g=
X-Google-Smtp-Source: AGHT+IE1DPoRp0N2nDleDeL+nMknRqhKzdJCPwHMJrwMUBjkYLBNjcfJz91+ASKxJdGzFGGlGgloaP/fXoU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2411:0:b0:d81:78ec:c403 with SMTP id
 k17-20020a252411000000b00d8178ecc403mr192905ybk.12.1695052199184; Mon, 18 Sep
 2023 08:49:59 -0700 (PDT)
Date:   Mon, 18 Sep 2023 08:49:57 -0700
In-Reply-To: <20230918152110.GI13795@ziepe.ca>
Mime-Version: 1.0
References: <20230916003118.2540661-1-seanjc@google.com> <20230916003118.2540661-6-seanjc@google.com>
 <20230918152110.GI13795@ziepe.ca>
Message-ID: <ZQhxpesyXeG+qbS6@google.com>
Subject: Re: [PATCH 05/26] vfio: KVM: Pass get/put helpers from KVM to VFIO,
 don't do circular lookup
From:   Sean Christopherson <seanjc@google.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Anish Ghulati <aghulati@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>,
        Andrew Thornton <andrewth@google.com>
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Sep 18, 2023, Jason Gunthorpe wrote:
> On Fri, Sep 15, 2023 at 05:30:57PM -0700, Sean Christopherson wrote:
> > Explicitly pass KVM's get/put helpers to VFIO when attaching a VM to
> > VFIO instead of having VFIO do a symbol lookup back into KVM.  Having both
> > KVM and VFIO do symbol lookups increases the overall complexity and places
> > an unnecessary dependency on KVM (from VFIO) without adding any value.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  drivers/vfio/vfio.h      |  2 ++
> >  drivers/vfio/vfio_main.c | 74 +++++++++++++++++++---------------------
> >  include/linux/vfio.h     |  4 ++-
> >  virt/kvm/vfio.c          |  9 +++--
> >  4 files changed, 47 insertions(+), 42 deletions(-)
> 
> I don't mind this, but Christoph had disliked my prior attempt to do
> this with function pointers..
> 
> The get can be inlined, IIRC, what about putting a pointer to the put
> inside the kvm struct?

That wouldn't allow us to achieve our goal, which is to hide the details of
"struct kvm" from VFIO (and the rest of the kernel).

What's the objection to handing VFIO a function pointer?

> The the normal kvm get/put don't have to exported symbols at all?

The export of kvm_get_kvm_safe() can go away (I forgot to do that in this series),
but kvm_get_kvm() will hang around as it's needed by KVM sub-modules (PPC and x86),
KVMGT (x86), and drivers/s390/crypto/vfio_ap_ops.c (no idea what to call that beast).

Gah, KVMGT doesn't actually need to call get/put, that can be handled by
kvm_page_track_register_notifier().

I am planning on making exports for sub-modules conditional on there actually
being submodules, so that's 2 of the 3 gone, but tackling the s390 crypto driver
is an entirely different story.
