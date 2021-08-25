Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EAEC4338F
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Aug 2021 15:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABBDA610A3
	for <linux-perf-users@archiver.kernel.org>; Wed, 25 Aug 2021 15:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbhHYPAt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 25 Aug 2021 11:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240934AbhHYPAs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Aug 2021 11:00:48 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41676C0613C1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Aug 2021 08:00:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id w19-20020a17090aaf9300b00191e6d10a19so19829pjq.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Aug 2021 08:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kn/AYMVeYnmieiIHFjFN8sDP9OZuVONc2B9QEaekI3A=;
        b=Waai87LKp635jm1pb/aC2JPtvvsoBVA8xxaMLtj3ABGHD9d09uoxQcvp9uO7RN6gse
         1vGFTMXryIfiPG+GWpphQXX48S1azU87y8pJh98TkZHqhCFAsawJfwk+ZhWnwfVfNq4/
         niaQoZuEWe28eHccWmpPQrvoobpXnYcyNb0cH3Jzmgq8o0LPoqMt2ULbhZ77iaJV6lyN
         uquZ5dJdKD8eAWidXPjClTw+o0bWwiXv0xw7lN2rsjHM9PmH38iH+DKgJPI8FtmMucE2
         i6Cwu7k+e2QfZh9P9euJNi7awa3Ud8iJ5ZdlgKrB/3kFwO6Q29c53NX3Onot0osIJleO
         luqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kn/AYMVeYnmieiIHFjFN8sDP9OZuVONc2B9QEaekI3A=;
        b=DVs2JQ0spkiS7kns2b32hB0fX/i/qgW6InL6cAhg5CZNpsUefxPb1Ub2AFyj8HkFW7
         aBiYnchMKG1W+jjPjBmya6mRx8nZ0EXwcbQkK1+uZNeVXX0n3ebM6a3/TWmrUsFkHJNy
         EvbG0Z/pm0LnSPT2eu/NBxdjhk1V4kkqy+04ij/NJo0WPD7JIAkS1NFc+FT0LIqI8aFo
         TNXW6Z4wN8v+/x3MJhulP+ZCY5NYhqqBkAq9iyjdmUbBy/rzrYWrguMtxGk0URWbt6ZE
         u8I5DcYhUy6zyblptETYhzdrHo2kWE1hcOdpmrPB+CYGbSDxsXVXuOB1xhhM9sQyPvep
         5+Qw==
X-Gm-Message-State: AOAM531S8BtiTiSm2kc1v5BpibYxZViDbhvQRwb1tUTR4PgcbjoCG6Sm
        H9tRODwCH+yyPH5P0l2cEWytEA==
X-Google-Smtp-Source: ABdhPJx+5iZUz3c/bQH0SD/kXyMauyq2qFirxiVHJwjy0MwTFV+vSSXt34Qnp6xy+b81CeSt+wq3lg==
X-Received: by 2002:a17:90b:384f:: with SMTP id nl15mr10874650pjb.203.1629903602513;
        Wed, 25 Aug 2021 08:00:02 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id v5sm5965271pjs.45.2021.08.25.08.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 08:00:01 -0700 (PDT)
Date:   Wed, 25 Aug 2021 14:59:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Artem Kashkanov <artem.kashkanov@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] KVM: x86: Register Processor Trace interrupt hook
 iff PT enabled in guest
Message-ID: <YSZa7dkw6t7yN6vL@google.com>
References: <20210823193709.55886-1-seanjc@google.com>
 <20210823193709.55886-3-seanjc@google.com>
 <3021c1cc-a4eb-e3ab-d6b7-558cbaefd03b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3021c1cc-a4eb-e3ab-d6b7-558cbaefd03b@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 25, 2021, Like Xu wrote:
> On 24/8/2021 3:37 am, Sean Christopherson wrote:
> > @@ -11061,6 +11061,8 @@ int kvm_arch_hardware_setup(void *opaque)
> >   	memcpy(&kvm_x86_ops, ops->runtime_ops, sizeof(kvm_x86_ops));
> >   	kvm_ops_static_call_update();
> > +	if (ops->intel_pt_intr_in_guest && ops->intel_pt_intr_in_guest())
> > +		kvm_guest_cbs.handle_intel_pt_intr = kvm_handle_intel_pt_intr;
> 
> Emm, it's still buggy.
> 
> The guest "unknown NMI" from the host Intel PT can still be reproduced
> after the following operation:
> 
> 	rmmod kvm_intel
> 	modprobe kvm-intel pt_mode=1 ept=1
> 	rmmod kvm_intel
> 	modprobe kvm-intel pt_mode=1 ept=0
> 
> Since the handle_intel_pt_intr is not reset to NULL in kvm_arch_hardware_unsetup(),
> and the previous function pointer still exists in the generic KVM data structure.

Ooof, good catch.  Any preference between nullifying handle_intel_pt_intr in
setup() vs. unsetup()?  I think I like the idea of "unwinding" during unsetup(),
even though it splits the logic a bit.

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b5ade47dad9c..ffc6c2d73508 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11093,6 +11093,7 @@ int kvm_arch_hardware_setup(void *opaque)
 void kvm_arch_hardware_unsetup(void)
 {
        perf_unregister_guest_info_callbacks(&kvm_guest_cbs);
+       kvm_guest_cbs.handle_intel_pt_intr = NULL;

        static_call(kvm_x86_hardware_unsetup)();
 }


vs.


diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b5ade47dad9c..462aa7a360e9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11063,6 +11063,8 @@ int kvm_arch_hardware_setup(void *opaque)

        if (ops->intel_pt_intr_in_guest && ops->intel_pt_intr_in_guest())
                kvm_guest_cbs.handle_intel_pt_intr = kvm_handle_intel_pt_intr;
+       else
+               kvm_guest_cbs.handle_intel_pt_intr = NULL;
        perf_register_guest_info_callbacks(&kvm_guest_cbs);

        if (!kvm_cpu_cap_has(X86_FEATURE_XSAVES))

> But I have to say that this fix is much better than the one I proposed [1].
> 
> [1] https://lore.kernel.org/lkml/20210514084436.848396-1-like.xu@linux.intel.com/
> 
> >   	perf_register_guest_info_callbacks(&kvm_guest_cbs);
> >   	if (!kvm_cpu_cap_has(X86_FEATURE_XSAVES))
> > 
