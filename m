Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D6BC433FE
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Sep 2021 21:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FC861165
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Sep 2021 21:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbhIUVbY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Sep 2021 17:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbhIUVbX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Sep 2021 17:31:23 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2B9C061756
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 14:29:54 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id w6so338015pll.3
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 14:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LSn/kFygvp1Gc7LYRPSl9USN2eKVUYYqQK80C4S3HbY=;
        b=btxgeKmkbIeI+ZpOc6VlwSC4J1M0NxXCmAKO/nawCIYSv8cbGywGkAH3QCnwAqLAUI
         IOyxlnQF3u2reCho4aOS27m8AURN66z+f1gzEN4gfB+N1/w2JLIXtC4yGrRdYBUrXdWC
         Vx/SNzr0zgBg66Mt5tqVTWXtqNRo1cMW1HRk7P6/aIgQitN5dojnf/rmx3fJsNEBiKh4
         2oG4JdRFZ1cCImM5O4stFWaGUi4+BBk4LEDc8ZYoSTyQQ09FyLfXbzxkQRIwj2f3Y1ux
         qkOUO+HshbP+1GDpYX5TBWF68F9+FWvzry5+DIxEzwl/5EC5N4EFZsnTQtNpn8FiRBGK
         Np7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LSn/kFygvp1Gc7LYRPSl9USN2eKVUYYqQK80C4S3HbY=;
        b=Dlr44xCA7LQBaM0emjLaFIiZimP3nAmGdJALq+ScRTWsQ47mCyrK2AI9afgwIf4VzY
         l1lLjXvgUVZCI43fGY497E8jhFbV3++KJPUBlED9zi7f6x7kPrZzocXBPV75jMR474Hv
         s+hjijr3uVNQD0Cbrm/KOAAA6u7dJG9oC4jZtU57FQdA7eEhPrFjHGzK2P2Shqd6q6nk
         qL81LGcyNjb0t5o2NBnpaLSa4JjH1WaKZ66CvgbP9+3bMtg3jZmRPfH1+844JnD2Pwfk
         YDCw1LsKqZgKEjkHo5otuus8Sh8VB8Rsgx4FuJ6ccM3qtinYySm0ZgX6oZUJFZxSscm3
         Fghw==
X-Gm-Message-State: AOAM530YU+wv0X0ODdqRoBMjYXEfiQfkAxhbcNx73jrO43/bWW9IQuX6
        IHCtgrCIQ8dMjjSSb2VeaxK+yg==
X-Google-Smtp-Source: ABdhPJzMgcR9UgCsbvPuA/02v4FkJblQW9htJs47A2YRdbvRMs4AQG7O660EDIsBZdZMmGrIa23JJg==
X-Received: by 2002:a17:902:bf42:b0:13d:b79f:a893 with SMTP id u2-20020a170902bf4200b0013db79fa893mr8518959pls.1.1632259793364;
        Tue, 21 Sep 2021 14:29:53 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w142sm103618pfc.47.2021.09.21.14.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 14:29:52 -0700 (PDT)
Date:   Tue, 21 Sep 2021 21:29:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: Re: [PATCH v2 05/13] perf: Force architectures to opt-in to guest
 callbacks
Message-ID: <YUpOzFW3K3iJAoWa@google.com>
References: <20210828003558.713983-1-seanjc@google.com>
 <20210828003558.713983-6-seanjc@google.com>
 <20210828194752.GC4353@worktop.programming.kicks-ass.net>
 <8ee13a69-f2c4-2413-2d6c-b6c0a559286e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ee13a69-f2c4-2413-2d6c-b6c0a559286e@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Sep 21, 2021, Paolo Bonzini wrote:
> On 28/08/21 21:47, Peter Zijlstra wrote:
> > > +config HAVE_GUEST_PERF_EVENTS
> > > +	bool
> > 	depends on HAVE_KVM
> 
> It won't really do anything, since Kconfig does not detects conflicts
> between select' and 'depends on' clauses.

It does throw a WARN, though the build doesn't fail.

WARNING: unmet direct dependencies detected for HAVE_GUEST_PERF_EVENTS
  Depends on [n]: HAVE_KVM [=n] && HAVE_PERF_EVENTS [=y]
  Selected by [y]:
  - ARM64 [=y]

WARNING: unmet direct dependencies detected for HAVE_GUEST_PERF_EVENTS
  Depends on [n]: HAVE_KVM [=n] && HAVE_PERF_EVENTS [=y]
  Selected by [y]:
  - ARM64 [=y]

WARNING: unmet direct dependencies detected for HAVE_GUEST_PERF_EVENTS
  Depends on [n]: HAVE_KVM [=n] && HAVE_PERF_EVENTS [=y]
  Selected by [y]:
  - ARM64 [=y]

> Rather, should the symbol be selected by KVM, instead of ARM64 and X86?

By KVM, you mean KVM in arm64 and x86, correct?  Because HAVE_GUEST_PERF_EVENTS
should not be selected for s390, PPC, or MIPS.

Oh, and Xen also uses the callbacks on x86, which means the HAVE_KVM part is
arguabably wrong, even though it's guaranteed to be true for the XEN_PV case.
I'll drop that dependency and send out a separate series to clean up the arm64
side of HAVE_KVM.

The reason I didn't bury HAVE_GUEST_PERF_EVENTS under KVM (and XEN_PV) is that
there are number of references to the callbacks throught perf and I didn't want
to create #ifdef hell.

But I think I figured out a not-awful solution.  If there are wrappers+stubs for
the guest callback users, then the new Kconfig can be selected on-demand instead
of unconditionally by arm64 and x86.  That has the added bonus of eliminating
the relevant code paths for !KVM (and !XEN_PV on x86), with or without static_call.
It also obviates the needs for __KVM_WANT_GUEST_PERF_EVENTS or whatever I called
that thing.

It more or less requires defining the static calls in generic perf, but I think
that actually ends up being good thing as it consolidates more code without
introducing more #ifdefs.  The diffstats for the static_call() conversions are
also quite nice.

 include/linux/perf_event.h | 28 ++++++----------------------
 kernel/events/core.c       | 15 +++++++++++++++
 2 files changed, 21 insertions(+), 22 deletions(-)

I'll try to get a new version out today or tomorrow.
