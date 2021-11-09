Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4E4C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 23:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A972361156
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 23:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhKIXTK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 18:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhKIXTJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 18:19:09 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FD5C061766
        for <linux-perf-users@vger.kernel.org>; Tue,  9 Nov 2021 15:16:23 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id z6so867205pfe.7
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Nov 2021 15:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3iDOWhiMYVH4J/xrL04EpHxxB+pfcqrny8aFQ+9uha4=;
        b=VzrYqN0K7z0Tuv/HZEo98TZC4k8HLv0Bi89F+eTM7VIgt8Hd0SbLQLu1jfW8/8S8fv
         tzfRT3bkeDhN2PHc31X4H7Y8DtkUZW4N710CDOsPQBTQtnUWIqdFY6F7ije1Cnoj6Q+4
         ppkFKf+QIHaiDGp0vt5e+c8PAWdm9ufyP9kMeDz/DPFOwmptdhrUt8KETig+vfK9Hq/N
         lJFBQKcjKRbfCPyMg8YrBLHsmR9t18pjj8BDwHYytNF7IYDGiDNiRxMB/BsE6ChUEAKz
         f1UvA+hVEnhTbq/8QIGBSxxEpmi70akY31pDC1IU1AtgFWCS0WgRlyVxJZndzjJCKeh8
         qtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3iDOWhiMYVH4J/xrL04EpHxxB+pfcqrny8aFQ+9uha4=;
        b=U4rQDGbbsHBsSqhbbzYtSIEPpIPvSVr/pXjABNS79olGNGXG+zXV3RvXgDHQ04MBaC
         Wpc50WEkLo4L2TDrB+EoNoZqe50r2oLseAsvtCwKSjprpG63RJzOu9JG3RAvZ7TEseuh
         Gqwd+LZ4kVH5A5QBXwxSU8m0iqVxisUG6swi+HIeZUEf5iEuA3sH7VxqgvOOBhrcbc7P
         ksj77bl1dcIsyujgJuFpa+cQrfP5rcWKyxmlRYZQu9xwCpsnpbaJK1mBclsoFhr2Ej3i
         mXsjGGFV3iLeLbxObO61Lc0pZ6xvjOBbOOqjLq7Tiz8LjZ/uMSHLreK4alUoTv1jVVZ1
         VTpg==
X-Gm-Message-State: AOAM530uZ3a1rrGOBHIoV8gDkdmWG5d5w29Ab5Md3BQsmfQ1ScTizhkE
        eWFzbXxEtpvAw9I4S42v88L8/w==
X-Google-Smtp-Source: ABdhPJzkNcQryrFCiNL8a59OsXtVtP1KqfiFu5fhzV9PARw6xea5VYu1cXC91MqNZo8wxwwswlX9UA==
X-Received: by 2002:a63:2c0f:: with SMTP id s15mr9035602pgs.6.1636499782405;
        Tue, 09 Nov 2021 15:16:22 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id y9sm3778534pjt.27.2021.11.09.15.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 15:16:21 -0800 (PST)
Date:   Tue, 9 Nov 2021 23:16:18 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guo Ren <guoren@kernel.org>, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
Subject: Re: [PATCH v3 15/16] KVM: arm64: Drop perf.c and fold its tiny bits
 of code into arm.c / pmu.c
Message-ID: <YYsBQvJPrG5Qrm6J@google.com>
References: <20210922000533.713300-1-seanjc@google.com>
 <20210922000533.713300-16-seanjc@google.com>
 <87tuhnq4it.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuhnq4it.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Oct 11, 2021, Marc Zyngier wrote:
> On Wed, 22 Sep 2021 01:05:32 +0100,
> Sean Christopherson <seanjc@google.com> wrote:
> > diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
> > index 864b9997efb2..42270676498d 100644
> > --- a/include/kvm/arm_pmu.h
> > +++ b/include/kvm/arm_pmu.h
> > @@ -14,6 +14,7 @@
> >  #define ARMV8_PMU_MAX_COUNTER_PAIRS	((ARMV8_PMU_MAX_COUNTERS + 1) >> 1)
> >  
> >  DECLARE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
> > +void kvm_pmu_init(void);
> >  
> >  static __always_inline bool kvm_arm_support_pmu_v3(void)
> >  {
> 
> Note that this patch is now conflicting with e840f42a4992 ("KVM:
> arm64: Fix PMU probe ordering"), which was merged in -rc4. Moving the
> static key definition to arch/arm64/kvm/pmu-emul.c and getting rid of
> kvm_pmu_init() altogether should be enough to resolve it.

Defining kvm_arm_pmu_available in pmu-emul.c doesn't work as-is because pmu-emul.c
depends on CONFIG_HW_PERF_EVENTS=y.  Since pmu-emul.c is the only path that enables
the key, my plan is to add a prep match to bury kvm_arm_pmu_available behind the
existing #ifdef CONFIG_HW_PERF_EVENTS in arm_pmu.h and add a stub
for kvm_arm_support_pmu_v3().  The only ugly part is that the KVM_NVHE_ALIAS() also
gains an #ifdef, but that doesn't seem too bad.
