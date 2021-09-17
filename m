Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5391DC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Sep 2021 16:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3673F61164
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Sep 2021 16:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244607AbhIQQzU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Sep 2021 12:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbhIQQzU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Sep 2021 12:55:20 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE39C061574
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Sep 2021 09:53:57 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s11so10157820pgr.11
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Sep 2021 09:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fRMxd8azh7E1BFxsMIqGYJmHYephRNLnlBlA+X7n5iE=;
        b=OCd2JnsFm+PC0WRg9Dy8nwrv0xb6S01W9Op4r/ZIu2wiEWDdIoF9l2WbVBKByhSPPF
         pgrkna7a3wLYVWEKuAik8asYNbpDEgJtdjZ+5dk4g6kfSL2XrdSoKcoPwqesfcoOwhOu
         WWbUTglAWniqlHYXmzaYzrF0F49uRRMs/V59Ek2JYLZBnMp92N934h45zumxZj/0PpGD
         /zvBIntmv3EDlaS6KVxhx1MfK4sOMy/cLwcByoT+tkw90D/Cj3jlQCjxNda2rrqk2GSV
         L6ETbBTdUnfohyRSi9IUyYAHcI9Z9pYHZQ5tjcYdmN/t6vpNHZYY3PO0hm+uRnpvMlkD
         xKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fRMxd8azh7E1BFxsMIqGYJmHYephRNLnlBlA+X7n5iE=;
        b=SVjPsBInH65Qxig9ixl1U+tn42lkKPM0jeo8lJTyOeshMA0oVOcbq/dCaaoX0jcQ0a
         42fWu/Hq+hZCQGgjMoTnWozruC4gam9eH0DVnbLD/GVCshRmG/PR+ttnwzaMkFBOQfWK
         bziCngOZ1DqD153SpQfFL6jkinJC/UnLR3nqcarGkFvgfxetnALI2ZlcM1v2jEbYUfGb
         HiXPM6VEVtLB7+h2QcJNJgg+br2WvucWU3dp7HCTisLKfWJkLsZBjeu+FvVdHIny+0zy
         0huLnNmGr4dpvaoAnmNcoJ8VkuAQttTDGA11cFVAIE3k9Rmli1Y/JUDqoujsdHypv0jh
         mZGg==
X-Gm-Message-State: AOAM5322APZd8wIhEzCD2ehqzZUWUBE+mFk/gui5Re+16o9Km2qq+PAn
        2sC/r/K26hYem/ehtS/Pm8tx+Q==
X-Google-Smtp-Source: ABdhPJyVPh/MP+xok4eNnL6IICz9yFWugy2q7G+GDgXi8Z/wRNwWTua9Dj2q+LfRii59WPG0Vad6Iw==
X-Received: by 2002:a05:6a00:174a:b0:433:9589:bdb5 with SMTP id j10-20020a056a00174a00b004339589bdb5mr11713777pfc.5.1631897636965;
        Fri, 17 Sep 2021 09:53:56 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h21sm6580708pfc.118.2021.09.17.09.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 09:53:56 -0700 (PDT)
Date:   Fri, 17 Sep 2021 16:53:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v2 00/13] perf: KVM: Fix, optimize, and clean up callbacks
Message-ID: <YUTIIG4ZCKMbqrFi@google.com>
References: <20210828003558.713983-1-seanjc@google.com>
 <20210828201336.GD4353@worktop.programming.kicks-ass.net>
 <YUO5J/jTMa2KGbsq@google.com>
 <YURDqVZ1UXKCiKPV@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YURDqVZ1UXKCiKPV@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Sep 17, 2021, Peter Zijlstra wrote:
> On Thu, Sep 16, 2021 at 09:37:43PM +0000, Sean Christopherson wrote:
> So I don't mind exporting __static_call_return0, but exporting a raw
> static_call is much like exporting a function pointer :/

Ya, that part is quite gross.

> > The unregister path would also need its own synchronize_rcu().  In general, I
> > don't love duplicating the logic, but it's not the end of the world.
> > 
> > Either way works for me.  Paolo or Peter, do either of you have a preference?
> 
> Can we de-feature kvm as a module and only have this PT functionality
> when built-in? :-)

I agree that many of the for-KVM exports are ugly, especially several of the
perf exports, but I will fight tooth and nail to keep KVM-as-a-module.  It is
invaluable for development and testing, and in the not-too-distant future there
is KVM-maintenance related functionality that we'd like to implement that relies
on KVM being a module.

I would be more than happy to help explore approaches that reduce the for-KVM
exports, but I am strongly opposed to defeaturing KVM-as-a-module.  I have a few
nascent ideas for eliminating a handful of a random exports, but no clever ideas
for eliminating perf's for-KVM exports.
