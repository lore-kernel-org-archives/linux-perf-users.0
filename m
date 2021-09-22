Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BE1C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 14:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA0C460FC1
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 14:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbhIVOuh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 10:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236199AbhIVOuc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 10:50:32 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D1CC06175F
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 07:49:02 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c1so2879915pfp.10
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 07:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0sqc+8Rn23i9NIXRc3rzWglOlIsYoDOCKK+U0vVnVf8=;
        b=i17P/LE0kBMgmTnemIWdlFQzqY0Hs2jbI6I1/q7BOVL5p2dtOUMx0v77u9KgBVc6Wn
         aKV+BPEmJqQFBnpf2JgmIIqtssY8WUcJgn0PyaL+KfSiTDztZbnAplBfnqcfDhlXXfFn
         BjrKCa5IqUkRjskJLByrIP0vUAdGBFoOpGk78YEBagXPKCi9T3kxBnFA97BcpKw7BZcR
         bmLTSv6ivPklBCfoVzjL+iJjEelTUzY+vAJf7MF3MbJsLpnqXAXpI4Q3beusWaRqYBkI
         4OoNyyAV9qr/c1FTp2tfQsv3gnSyBPHEnLObwapHJkjxKwND1CbJf6lm69JT2lSfnhHf
         qYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0sqc+8Rn23i9NIXRc3rzWglOlIsYoDOCKK+U0vVnVf8=;
        b=OLWVyfNVW+t2BdgHQ4fGXkoZoIwUjnx1k2D1YUGWOm65nRAcUipshrLNvW8tm7Hbmn
         ss/oq8GaWNuYykXwKqrVsVwBMNAQLNX3fIs3bZJEq0644Tq9v7Ah30UG/YoHY8j3FsV0
         cLdQIMBVHP5namFDjEAsQ3uijadr7NUcrU9h07xM8Np91HrZEvf5eJQS5CVTozoHU3bZ
         NDyK+DImzrV7zx7yC4AAQOOgHjcDa9GQ0Tx365fY5vXuUw1qie1gwB2wL7YS+v3Pd+DT
         wAktiMzmcd//6kHdhRE6eV2e4DZCPHaumGz82C64FtsRbg5mXPIrJYiXRMJGBtlKRQot
         sujA==
X-Gm-Message-State: AOAM530QlrYfBfODRgFZk/TJoGZfzthujmHwgPA/ULdHn/lQqTBz11PL
        OKbFa26LyJCRVJ9Cd9DefxXl7Q==
X-Google-Smtp-Source: ABdhPJyY3Fv9QcnunPtvdtmn1QYeYqhfMcgkYKWmFqTAaf0DAX+dPQteKaq7uTqZ/uQmOkkrqsksfg==
X-Received: by 2002:a62:5fc7:0:b0:438:9e3a:b8c0 with SMTP id t190-20020a625fc7000000b004389e3ab8c0mr22443pfb.74.1632322141372;
        Wed, 22 Sep 2021 07:49:01 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id x19sm3250084pgk.37.2021.09.22.07.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 07:49:00 -0700 (PDT)
Date:   Wed, 22 Sep 2021 14:48:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Artem Kashkanov <artem.kashkanov@intel.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH v3 08/16] perf: Force architectures to opt-in to guest
 callbacks
Message-ID: <YUtCWOYJwCUYDYtW@google.com>
References: <20210922000533.713300-1-seanjc@google.com>
 <20210922000533.713300-9-seanjc@google.com>
 <f2ad98e2-ddfb-c688-65af-7ecbd8bc3b3d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2ad98e2-ddfb-c688-65af-7ecbd8bc3b3d@redhat.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 22, 2021, Paolo Bonzini wrote:
> On 22/09/21 02:05, Sean Christopherson wrote:
> > @@ -1273,6 +1274,11 @@ static inline unsigned int perf_guest_handle_intel_pt_intr(void)
> >   }
> >   extern void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs);
> >   extern void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs);
> > +#else
> > +static inline unsigned int perf_guest_state(void)		 { return 0; }
> > +static inline unsigned long perf_guest_get_ip(void)		 { return 0; }
> > +static inline unsigned int perf_guest_handle_intel_pt_intr(void) { return 0; }
> > +#endif /* CONFIG_GUEST_PERF_EVENTS */
> 
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Having perf_guest_handle_intel_pt_intr in generic code is a bit off.  Of
> course it has to be in the struct, but the wrapper might be placed in
> arch/x86/include/asm/perf_event.h as well (applies to patch 7 as well).

Yeah, I went with this option purely to keep everything bundled together.  I have
no strong opinion.
