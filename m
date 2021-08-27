Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C96CC4320A
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 Aug 2021 14:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E08D960524
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 Aug 2021 14:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245380AbhH0O73 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 27 Aug 2021 10:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245343AbhH0O73 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 27 Aug 2021 10:59:29 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FBDC061757
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Aug 2021 07:58:40 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d17so4083488plr.12
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Aug 2021 07:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uRFFUbAhELNbaSp6/gZa0c8lVubPxa9shGc4LpwPEKA=;
        b=LaTxPm5alTPx3ec48IA6+ZkyOejP1tGYjt5wY+p50UOfksJNBKAzDXOzoDDiJpQJ7C
         7ZlQ2CaQrXUZrhEVe/+L/sf91LGMM0vWjp8eP3YRAXU34kmcSmT/loEOx2KY28gVVCsl
         oNwRHnusQG6CUmxymYZ58t9NT8p9wB0iZAAe71TUcHWHnrhk4i1QLthTClskPP73rEx7
         8W5oVGVmckueDqbKs0mB5YdxIHBLQgh+JwU0k3CO0TH8YixDpwG1SB6F/loD+NPrNZ2l
         0CosQb5gLTnLJ9MX51KpbZFvZYLNN8TvF8Ol0HP7oCHqmHClmMDvOIzUAi7IGzMuFHXf
         oANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uRFFUbAhELNbaSp6/gZa0c8lVubPxa9shGc4LpwPEKA=;
        b=ILgF1VawemkkeuoEhA1F5383o/yHPl+wWiXpRHArS77imj4h1V8QWs5xFf8qUE+7GK
         g+LP8ZTaC5OIYqQT/MwH0uPU7LPluZFk1oTl3u9M62nUOvJfajZV8OZZ/YGbrHI0k4Y0
         tGZKoeHkONIbu2A0yUPGMgMD7ZTg2Dtiay9y2OLU6nZMpqARjRPPzw39OYwKcjnHmZCN
         xJYYtPal7jSFexcmxkEQ0jeBpT5ggi2Kikevz85JWGXWtgX+bPm/JN8Riq3rBfMmpO8C
         UTND/ROdqk+TKmVtY9jASz4RHf82NAV9hMCzhb0wIeahvaXFooioLpnGj/17jGOXKC2X
         +37w==
X-Gm-Message-State: AOAM531f8T4kI0KD6yGwgojVk9cs1oL0XgPgDw++EETRkTDDotxg4aL8
        lN9AHe5nfxh7M4Z0/9tZlnS5tg==
X-Google-Smtp-Source: ABdhPJzgh09WISpUzNhO7TIEv2MEhpi/JDC49fmE6awwyfv/L0ffcVcqSZUNcnR7TJ7/0hyFRiQ/2g==
X-Received: by 2002:a17:902:e20a:b0:134:221f:657d with SMTP id u10-20020a170902e20a00b00134221f657dmr9134631plb.78.1630076319283;
        Fri, 27 Aug 2021 07:58:39 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id e11sm6590628pfn.49.2021.08.27.07.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 07:58:38 -0700 (PDT)
Date:   Fri, 27 Aug 2021 14:58:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        Artem Kashkanov <artem.kashkanov@intel.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH 07/15] KVM: Use dedicated flag to track if KVM is
 handling an NMI from guest
Message-ID: <YSj9mz4F2NDSKaas@google.com>
References: <20210827005718.585190-1-seanjc@google.com>
 <20210827005718.585190-8-seanjc@google.com>
 <YSiUnDbi/aZ3nunT@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSiUnDbi/aZ3nunT@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 27, 2021, Peter Zijlstra wrote:
> On Thu, Aug 26, 2021 at 05:57:10PM -0700, Sean Christopherson wrote:
> > diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> > index 5cedc0e8a5d5..4c5ba4128b38 100644
> > --- a/arch/x86/kvm/x86.h
> > +++ b/arch/x86/kvm/x86.h
> > @@ -395,9 +395,10 @@ static inline void kvm_unregister_perf_callbacks(void)
> >  
> >  DECLARE_PER_CPU(struct kvm_vcpu *, current_vcpu);
> >  
> > -static inline void kvm_before_interrupt(struct kvm_vcpu *vcpu)
> > +static inline void kvm_before_interrupt(struct kvm_vcpu *vcpu, bool is_nmi)
> >  {
> >  	__this_cpu_write(current_vcpu, vcpu);
> > +	WRITE_ONCE(vcpu->arch.handling_nmi_from_guest, is_nmi);
> >  
> >  	kvm_register_perf_callbacks();
> >  }
> > @@ -406,6 +407,7 @@ static inline void kvm_after_interrupt(struct kvm_vcpu *vcpu)
> >  {
> >  	kvm_unregister_perf_callbacks();
> >  
> > +	WRITE_ONCE(vcpu->arch.handling_nmi_from_guest, false);
> >  	__this_cpu_write(current_vcpu, NULL);
> >  }
> 
> Does this rely on kvm_{,un}register_perf_callback() being a function
> call and thus implying a sequence point to order the stores? 

No, I'm just terrible at remembering which macros provide what ordering guarantees,
i.e. I was thinking WRITE_ONCE provided guarantees against compiler reordering.
