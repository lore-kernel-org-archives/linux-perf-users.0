Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A7FC4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 06:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EF78611C6
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 06:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhIVG1W (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 02:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57073 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232635AbhIVG1V (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 02:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632291951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdG5hvixHxpBF3qV2Nc1iurvw1d5rRrVn0cpW/kHHXU=;
        b=EuhvNCorqlOiCKvXlM92eOW6nrvV57/SifpMmbge2dc7gHb1Rw+aPCJAHioXZlYVSZRqdx
        SlS7bV323yiNH44ZQOynL7FT2GsDgXsg7TZ/qKrySoaFTjM6lOYGZTjQbRWTb089ivcXrK
        wLeo88GYcv6C73/hctYizoeGEiZ18Iw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-puGjpLTgORa1jeDy9nxKBA-1; Wed, 22 Sep 2021 02:25:50 -0400
X-MC-Unique: puGjpLTgORa1jeDy9nxKBA-1
Received: by mail-wr1-f72.google.com with SMTP id e1-20020adfa741000000b0015e424fdd01so1129881wrd.11
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 23:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gdG5hvixHxpBF3qV2Nc1iurvw1d5rRrVn0cpW/kHHXU=;
        b=SxBZWS7RxLVkLdihgJlh/xtX96IDNEqUtkjBdvMsSFY5a3cgquAsj4+6LoL/O3gW2n
         eRcm2QXJv0Fsjq+gz8GqctYE91VKFFvV3uLzOcZ16m25/qPrkL8KKq9xVrpFIIwqQYBV
         oNnPrN9GWyFRMPg5oArxelFpRaFe9dINbO4fppo8E8JUHSe3h5UHq8nwmM2ubqlx1QKt
         4jMy4suWWYOEZzyBialv0o5Mbff3OZPxug1gWeBhnw9vLRaLgb/sQl/4pgo1leeJ8qTj
         QYPy9J3cGNm5IAeXhFDpieQaMvsZ07k1kEg8YFMrPnyM5QmMOoA5CXfmOyz2ikNz9WYl
         ZXpw==
X-Gm-Message-State: AOAM531svDNb//jg/prUIpdBgUN5b6bQeUZdIK0815bIPPnvQuICCycj
        OiWxdU9pVuc94vLercEKgrJ5h1qiAHWkhT71iZTHOUhS9st0/Es16wyBSKZCOySjRixTEh4rVOS
        ulR7yhhpqZ3X/pDGJuFsqHSqzuRGyFw==
X-Received: by 2002:a1c:f302:: with SMTP id q2mr8427296wmq.56.1632291948894;
        Tue, 21 Sep 2021 23:25:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzItVKh/AhZh5/Igm3bcU7YShmtTIldU49veASOpN+187Ot1E0vGGn3OxfbqcgagpWMesDpA==
X-Received: by 2002:a1c:f302:: with SMTP id q2mr8427271wmq.56.1632291948590;
        Tue, 21 Sep 2021 23:25:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id 25sm5710788wmo.9.2021.09.21.23.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 23:25:47 -0700 (PDT)
Subject: Re: [PATCH v3 04/16] perf: Stop pretending that perf can handle
 multiple guest callbacks
To:     Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Juergen Gross <jgross@suse.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
References: <20210922000533.713300-1-seanjc@google.com>
 <20210922000533.713300-5-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <37afc465-c12f-01b9-f3b6-c2573e112d76@redhat.com>
Date:   Wed, 22 Sep 2021 08:25:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922000533.713300-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 22/09/21 02:05, Sean Christopherson wrote:
> Drop the 'int' return value from the perf (un)register callbacks helpers
> and stop pretending perf can support multiple callbacks.  The 'int'
> returns are not future proofing anything as none of the callers take
> action on an error.  It's also not obvious that there will ever be
> co-tenant hypervisors, and if there are, that allowing multiple callbacks
> to be registered is desirable or even correct.
> 
> Opportunistically rename callbacks=>cbs in the affected declarations to
> match their definitions.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/arm64/include/asm/kvm_host.h |  4 ++--
>   arch/arm64/kvm/perf.c             |  8 ++++----
>   include/linux/perf_event.h        | 12 ++++++------
>   kernel/events/core.c              | 16 ++++------------
>   4 files changed, 16 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 41911585ae0c..ed940aec89e0 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -670,8 +670,8 @@ unsigned long kvm_mmio_read_buf(const void *buf, unsigned int len);
>   int kvm_handle_mmio_return(struct kvm_vcpu *vcpu);
>   int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa);
>   
> -int kvm_perf_init(void);
> -int kvm_perf_teardown(void);
> +void kvm_perf_init(void);
> +void kvm_perf_teardown(void);
>   
>   long kvm_hypercall_pv_features(struct kvm_vcpu *vcpu);
>   gpa_t kvm_init_stolen_time(struct kvm_vcpu *vcpu);
> diff --git a/arch/arm64/kvm/perf.c b/arch/arm64/kvm/perf.c
> index 151c31fb9860..c37c0cf1bfe9 100644
> --- a/arch/arm64/kvm/perf.c
> +++ b/arch/arm64/kvm/perf.c
> @@ -48,15 +48,15 @@ static struct perf_guest_info_callbacks kvm_guest_cbs = {
>   	.get_guest_ip	= kvm_get_guest_ip,
>   };
>   
> -int kvm_perf_init(void)
> +void kvm_perf_init(void)
>   {
>   	if (kvm_pmu_probe_pmuver() != 0xf && !is_protected_kvm_enabled())
>   		static_branch_enable(&kvm_arm_pmu_available);
>   
> -	return perf_register_guest_info_callbacks(&kvm_guest_cbs);
> +	perf_register_guest_info_callbacks(&kvm_guest_cbs);
>   }
>   
> -int kvm_perf_teardown(void)
> +void kvm_perf_teardown(void)
>   {
> -	return perf_unregister_guest_info_callbacks(&kvm_guest_cbs);
> +	perf_unregister_guest_info_callbacks(&kvm_guest_cbs);
>   }
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 6b0405e578c1..317d4658afe9 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1245,8 +1245,8 @@ static inline struct perf_guest_info_callbacks *perf_get_guest_cbs(void)
>   	/* Prevent reloading between a !NULL check and dereferences. */
>   	return READ_ONCE(perf_guest_cbs);
>   }
> -extern int perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
> -extern int perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *callbacks);
> +extern void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs);
> +extern void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs);
>   
>   extern void perf_event_exec(void);
>   extern void perf_event_comm(struct task_struct *tsk, bool exec);
> @@ -1489,10 +1489,10 @@ perf_sw_event(u32 event_id, u64 nr, struct pt_regs *regs, u64 addr)	{ }
>   static inline void
>   perf_bp_event(struct perf_event *event, void *data)			{ }
>   
> -static inline int perf_register_guest_info_callbacks
> -(struct perf_guest_info_callbacks *callbacks)				{ return 0; }
> -static inline int perf_unregister_guest_info_callbacks
> -(struct perf_guest_info_callbacks *callbacks)				{ return 0; }
> +static inline void perf_register_guest_info_callbacks
> +(struct perf_guest_info_callbacks *cbs)					{ }
> +static inline void perf_unregister_guest_info_callbacks
> +(struct perf_guest_info_callbacks *cbs)					{ }
>   
>   static inline void perf_event_mmap(struct vm_area_struct *vma)		{ }
>   
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 80ff050a7b55..d90a43572400 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6482,31 +6482,23 @@ static void perf_pending_event(struct irq_work *entry)
>   		perf_swevent_put_recursion_context(rctx);
>   }
>   
> -/*
> - * We assume there is only KVM supporting the callbacks.
> - * Later on, we might change it to a list if there is
> - * another virtualization implementation supporting the callbacks.
> - */
>   struct perf_guest_info_callbacks *perf_guest_cbs;
> -
> -int perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
> +void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
>   {
>   	if (WARN_ON_ONCE(perf_guest_cbs))
> -		return -EBUSY;
> +		return;
>   
>   	WRITE_ONCE(perf_guest_cbs, cbs);

Maybe you want a smp_store_release or rcu_assign_pointer here?

> -	return 0;
>   }
>   EXPORT_SYMBOL_GPL(perf_register_guest_info_callbacks);
>   
> -int perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
> +void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
>   {
>   	if (WARN_ON_ONCE(perf_guest_cbs != cbs))
> -		return -EINVAL;
> +		return;
>   
>   	WRITE_ONCE(perf_guest_cbs, NULL);
>   	synchronize_rcu();
> -	return 0;
>   }
>   EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
>   
> 

Apart from the above,

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

