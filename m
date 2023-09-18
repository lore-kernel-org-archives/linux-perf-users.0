Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707D1CD37B0
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Sep 2023 16:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjIRQVH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjIRQUh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Sep 2023 12:20:37 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BE0CE0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Sep 2023 09:11:02 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76ef80a503fso307288885a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Sep 2023 09:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695053449; x=1695658249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1AtaBW2SsBllDiJ99v10Ny7HNDE5iUEtI8mOBYM/rVQ=;
        b=Buqcs6SV3HSe6HPxVw8L9lsfBH6mDY19527IR+m6z430BqKlGYFeNuBS1vKOpwFFSA
         sMd2hQfkvsE5CNjII3P1O7mwDfpB0bLy2Ex3lGZ1R8P5Q/2L0G7eq/9N6JFnccmYd/Gk
         TK65BeUXIfG8CKF/P4nWQdcGqizbSRxNeM13LhrqEwbW72qvPnBgbz3g2nTF1wTDyaJd
         +NauZ/ERf7MHvQwEMsldL0Ee1Hr7V76TgJEe6oVNdN6wDNt1nLqSuQkbxMrSIuCAYMGf
         4SFlYHhgejshpI+QLfkUfN5SjJuNj2BVPvNxtuzQuFx8PRr368ASyuC4QMQXGdoV8HzT
         LAHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053449; x=1695658249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AtaBW2SsBllDiJ99v10Ny7HNDE5iUEtI8mOBYM/rVQ=;
        b=EQBibz4T8b7ZGVm4Ux6/I09w2CH0kup0SuuQQxiaYas+vC5LAUyY5uhOJYOjPW9WRC
         z4e0gIxTiwVlrTngLLDg4RVY6AZiRkXs7XUOMxLQ41/4lW3uSEOsdN/xblVM+2sxzg+K
         nkMkCG6h/Wefqyk4mLcp/QcT69r0tAwiElRtftvoXvSwUe/lWeLudIjvtgvedxUYhNiw
         Z2lQYXbjqubuOyDCQwI7SJmaTAre9/eTNMyD5IEWoWxDU8mOVYjNi2MxOR6z6eG6+dv/
         sKoED+rwnMUexZIHO3U1aB80mbxkAgXaKZHezJnqyIX9mMbBPg4FsQ3kCQ9g84yvSchx
         /oIw==
X-Gm-Message-State: AOJu0YzQ4GkvTW9q3laWKKFXVTk4I+acMv9KGmRvJGEdaXVXhhOFIVcB
        Aof4efHI/eLKSn6YFEq+Ob9XdVaDMaHCptVa8is=
X-Google-Smtp-Source: AGHT+IH/YnREI891cZLYoBidRStzCIsQeTayS2VX/iNCJzxAWIRbDBhzALGmOqWbEj1DKL9seHAlIw==
X-Received: by 2002:a0c:eacf:0:b0:655:78f5:bef7 with SMTP id y15-20020a0ceacf000000b0065578f5bef7mr9471806qvp.21.1695052995341;
        Mon, 18 Sep 2023 09:03:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id u20-20020a0cdd14000000b006581e82a628sm989437qvk.134.2023.09.18.09.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 09:03:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qiGiA-0005k6-DG;
        Mon, 18 Sep 2023 13:02:58 -0300
Date:   Mon, 18 Sep 2023 13:02:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sean Christopherson <seanjc@google.com>
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
Subject: Re: [PATCH 05/26] vfio: KVM: Pass get/put helpers from KVM to VFIO,
 don't do circular lookup
Message-ID: <20230918160258.GL13795@ziepe.ca>
References: <20230916003118.2540661-1-seanjc@google.com>
 <20230916003118.2540661-6-seanjc@google.com>
 <20230918152110.GI13795@ziepe.ca>
 <ZQhxpesyXeG+qbS6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQhxpesyXeG+qbS6@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Sep 18, 2023 at 08:49:57AM -0700, Sean Christopherson wrote:
> On Mon, Sep 18, 2023, Jason Gunthorpe wrote:
> > On Fri, Sep 15, 2023 at 05:30:57PM -0700, Sean Christopherson wrote:
> > > Explicitly pass KVM's get/put helpers to VFIO when attaching a VM to
> > > VFIO instead of having VFIO do a symbol lookup back into KVM.  Having both
> > > KVM and VFIO do symbol lookups increases the overall complexity and places
> > > an unnecessary dependency on KVM (from VFIO) without adding any value.
> > > 
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > >  drivers/vfio/vfio.h      |  2 ++
> > >  drivers/vfio/vfio_main.c | 74 +++++++++++++++++++---------------------
> > >  include/linux/vfio.h     |  4 ++-
> > >  virt/kvm/vfio.c          |  9 +++--
> > >  4 files changed, 47 insertions(+), 42 deletions(-)
> > 
> > I don't mind this, but Christoph had disliked my prior attempt to do
> > this with function pointers..
> > 
> > The get can be inlined, IIRC, what about putting a pointer to the put
> > inside the kvm struct?
> 
> That wouldn't allow us to achieve our goal, which is to hide the details of
> "struct kvm" from VFIO (and the rest of the kernel).

> What's the objection to handing VFIO a function pointer?

Hmm, looks like it was this thread:

 https://lore.kernel.org/r/0-v1-33906a626da1+16b0-vfio_kvm_no_group_jgg@nvidia.com

Your rational looks a little better to me.

> > The the normal kvm get/put don't have to exported symbols at all?
> 
> The export of kvm_get_kvm_safe() can go away (I forgot to do that in this series),
> but kvm_get_kvm() will hang around as it's needed by KVM sub-modules (PPC and x86),
> KVMGT (x86), and drivers/s390/crypto/vfio_ap_ops.c (no idea what to call that beast).

My thought would be to keep it as an inline, there should be some way
to do that without breaking your desire to hide the bulk of the kvm
struct content. Like put the refcount as the first element in the
struct and just don't ifdef it away?.

Jason
