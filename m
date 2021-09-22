Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E88C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 06:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2158561184
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 06:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhIVGet (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 02:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232743AbhIVGet (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 02:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632292399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hK1TAJDdleQGO4jZBAmuPgddEjoHfavTDxwu6JuYxPc=;
        b=JlDDnaak59jQNHs2dj27x7ZjvcngSDVkkv3ldNbEkXiD9kKGjTNWzgmF0fSw8cEu1Fp2po
        xswDQbrHpki0LeMJPtxu0kXg1pFWIa7ggHaudP+kRtf6TidkRg/5LohkkZRcqVtvCYQYqb
        7KDjJYrYXTwzICH/Cq4TJKcmEEN5qHo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-VIgMeug_NHyOMyVHLfZcAA-1; Wed, 22 Sep 2021 02:33:18 -0400
X-MC-Unique: VIgMeug_NHyOMyVHLfZcAA-1
Received: by mail-ed1-f70.google.com with SMTP id z6-20020a50cd06000000b003d2c2e38f1fso1862592edi.1
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 23:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hK1TAJDdleQGO4jZBAmuPgddEjoHfavTDxwu6JuYxPc=;
        b=zi93bnY7b27cQyg2VJgBzF4sg4kbIAvnG8sPiZ5NGm1R4V1Bw6JhsaDBPQYyc5hagG
         xzsB+cPuFP3NGq4reUyL+8R19jfU13SpfWbv2RBh21BUXJy14UPv+ATW0g0fc/0hX+Ol
         jxK/odeJhhXcdibG3LkTe5TKSwJuKBdjE30X994ES3JTtICUMhfVg+r05PNt5oiFqGcU
         1Dp5TYiPz+bEfrppnx0kwA+uyYjHj6u8Z89LPfFc0ORto0vL9iUtg1riehNnJjRcPiL8
         Qr40C8Id06X2j6RWjYKrF1CQ1DwYEC1nfG+1cpUoT0WsL6e/1QQ9T68qW6e+hiltbMSa
         MmZw==
X-Gm-Message-State: AOAM532csoOenADNaOUJWcf7Rv8tiM8Dc/SlbE5zV7cHFwo3bR4nLIrf
        llssXiCndTkB5DWpsy5YN8NyPC5wG7XPj+pswrzE43cDw9GN1+Jb4JUC2WbrbBIg5t1+TETvruk
        r064ssVb4HxNmUUKA924+Js5rFt+qfw==
X-Received: by 2002:a17:906:a01:: with SMTP id w1mr40417069ejf.117.1632292396946;
        Tue, 21 Sep 2021 23:33:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWUo+BlVIV+JEHRlDKOT5sLvq+4KeWDB237/AGh6qJRsKlnsARTagHguA0XIMd4G8mEtTIGA==
X-Received: by 2002:a17:906:a01:: with SMTP id w1mr40417041ejf.117.1632292396704;
        Tue, 21 Sep 2021 23:33:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n16sm628454edd.10.2021.09.21.23.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 23:33:16 -0700 (PDT)
Subject: Re: [PATCH v3 09/16] perf/core: Use static_call to optimize
 perf_guest_info_callbacks
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
 <20210922000533.713300-10-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5ad3e3f9-260b-52b2-e0c8-9ab824e08fb4@redhat.com>
Date:   Wed, 22 Sep 2021 08:33:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922000533.713300-10-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 22/09/21 02:05, Sean Christopherson wrote:
> Use static_call to optimize perf's guest callbacks on arm64 and x86,
> which are now the only architectures that define the callbacks.  Use
> DEFINE_STATIC_CALL_RET0 as the default/NULL for all guest callbacks, as
> the callback semantics are that a return value '0' means "not in guest".
> 
> static_call obviously avoids the overhead of CONFIG_RETPOLINE=y, but is
> also advantageous versus other solutions, e.g. per-cpu callbacks, in that
> a per-cpu memory load is not needed to detect the !guest case.
> 
> Based on code from Peter and Like.
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Like Xu <like.xu.linux@gmail.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   include/linux/perf_event.h | 28 ++++++----------------------
>   kernel/events/core.c       | 15 +++++++++++++++
>   2 files changed, 21 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index eefa197d5354..d582dfeb4e20 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1240,37 +1240,21 @@ extern void perf_event_bpf_event(struct bpf_prog *prog,
>   
>   #ifdef CONFIG_GUEST_PERF_EVENTS
>   extern struct perf_guest_info_callbacks *perf_guest_cbs;
> -static inline struct perf_guest_info_callbacks *perf_get_guest_cbs(void)
> -{
> -	/* Reg/unreg perf_guest_cbs waits for readers via synchronize_rcu(). */
> -	lockdep_assert_preemption_disabled();
> +DECLARE_STATIC_CALL(__perf_guest_state, *perf_guest_cbs->state);
> +DECLARE_STATIC_CALL(__perf_guest_get_ip, *perf_guest_cbs->get_ip);
> +DECLARE_STATIC_CALL(__perf_guest_handle_intel_pt_intr, *perf_guest_cbs->handle_intel_pt_intr);
>   
> -	/* Prevent reloading between a !NULL check and dereferences. */
> -	return READ_ONCE(perf_guest_cbs);
> -}
>   static inline unsigned int perf_guest_state(void)
>   {
> -	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
> -
> -	return guest_cbs ? guest_cbs->state() : 0;
> +	return static_call(__perf_guest_state)();
>   }
>   static inline unsigned long perf_guest_get_ip(void)
>   {
> -	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
> -
> -	/*
> -	 * Arbitrarily return '0' in the unlikely scenario that the callbacks
> -	 * are unregistered between checking guest state and getting the IP.
> -	 */
> -	return guest_cbs ? guest_cbs->get_ip() : 0;
> +	return static_call(__perf_guest_get_ip)();
>   }
>   static inline unsigned int perf_guest_handle_intel_pt_intr(void)
>   {
> -	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
> -
> -	if (guest_cbs && guest_cbs->handle_intel_pt_intr)
> -		return guest_cbs->handle_intel_pt_intr();
> -	return 0;
> +	return static_call(__perf_guest_handle_intel_pt_intr)();
>   }
>   extern void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs);
>   extern void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs);
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c6ec05809f54..79c8ee1778a4 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6485,12 +6485,23 @@ static void perf_pending_event(struct irq_work *entry)
>   #ifdef CONFIG_GUEST_PERF_EVENTS
>   struct perf_guest_info_callbacks *perf_guest_cbs;
>   
> +DEFINE_STATIC_CALL_RET0(__perf_guest_state, *perf_guest_cbs->state);
> +DEFINE_STATIC_CALL_RET0(__perf_guest_get_ip, *perf_guest_cbs->get_ip);
> +DEFINE_STATIC_CALL_RET0(__perf_guest_handle_intel_pt_intr, *perf_guest_cbs->handle_intel_pt_intr);
> +
>   void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
>   {
>   	if (WARN_ON_ONCE(perf_guest_cbs))
>   		return;
>   
>   	WRITE_ONCE(perf_guest_cbs, cbs);
> +	static_call_update(__perf_guest_state, cbs->state);
> +	static_call_update(__perf_guest_get_ip, cbs->get_ip);
> +
> +	/* Implementing ->handle_intel_pt_intr is optional. */
> +	if (cbs->handle_intel_pt_intr)
> +		static_call_update(__perf_guest_handle_intel_pt_intr,
> +				   cbs->handle_intel_pt_intr);
>   }
>   EXPORT_SYMBOL_GPL(perf_register_guest_info_callbacks);
>   
> @@ -6500,6 +6511,10 @@ void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
>   		return;
>   
>   	WRITE_ONCE(perf_guest_cbs, NULL);
> +	static_call_update(__perf_guest_state, (void *)&__static_call_return0);
> +	static_call_update(__perf_guest_get_ip, (void *)&__static_call_return0);
> +	static_call_update(__perf_guest_handle_intel_pt_intr,
> +			   (void *)&__static_call_return0);
>   	synchronize_rcu();
>   }
>   EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

