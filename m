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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB0FC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 06:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E3460EE5
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 06:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhIVGbc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 02:31:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232768AbhIVGbc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 02:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632292202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uMqrFogGHJvh/zXMgi/UYOAI5rgMXo+1p47tZLBtnbA=;
        b=jKey5BmJXlfX+G8dR4hFXyfkNL+voNpCjLFV10JcEcjDORc7SNDPYL3W275oJj4YwePLPx
        LMUmdkWUnymbD/XRuR8PuOJQkIH0OMA6T0HiWVjgnlHsnNArDeu44/LvXMtmI4zTSpghzZ
        9aUsFnsw1olLoJ6OHAIZQ12mV8HzO1E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-8oh_RT9bMe-ohVSOIaQiJg-1; Wed, 22 Sep 2021 02:30:00 -0400
X-MC-Unique: 8oh_RT9bMe-ohVSOIaQiJg-1
Received: by mail-wr1-f72.google.com with SMTP id s14-20020adff80e000000b001601b124f50so1157468wrp.5
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 23:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uMqrFogGHJvh/zXMgi/UYOAI5rgMXo+1p47tZLBtnbA=;
        b=py6t1HJoa4NEj+mJNkmdD3Zrr6A0zRRhX9KLsRBEdi2gZX34IM/E5woAFvoRZk/gmO
         I42SJWech6STQXjU1UesSulT04eym0VvL8rRlAEo9+j+4y/5J+huUXvstiZPN7zbKeH5
         /7BeDhg+l/A90G3+LRV/Qo2/5Nos+dHLB5fIR12KYISXpo/5NzwVNTRC5lOGmw1hEbOI
         65EOIrPDl2etW/XbvuYkfS0+Q7RRFupEMbaYa1s6UlAvo2wRb/l9dxjXLT7I0iE1GJbA
         ysKWFqw/vYvqWwDSmnnU88JSgIP3vzSkAETpSFbpW7TOWZnl4u93pVyhPmtASixX6eiZ
         4tLw==
X-Gm-Message-State: AOAM531WVXu1b+Gqusf/ZrA0rni4AMW7tV9XDRJ6369l15306SgTrQuz
        MHmoWmZerV5o7qCGDx8A+sDshLI3PxJ5svXEKI9g88df/YVv1DmDQMIvshETUv8kDuIWYwjWEIx
        qzFJ97vLxnmI7sgg932jhq0/IxsvH7g==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr40001532wro.264.1632292199586;
        Tue, 21 Sep 2021 23:29:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6eHdpjSr8WTnz77WfeSYfS+jJfgrKqObxO+Wy3OIPCrDpgLHnqBvaUwGRJU1fc0Wlc4Hr5Q==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr40001494wro.264.1632292199252;
        Tue, 21 Sep 2021 23:29:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k4sm947672wmj.30.2021.09.21.23.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 23:29:58 -0700 (PDT)
Subject: Re: [PATCH v3 07/16] perf: Add wrappers for invoking guest callbacks
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
 <20210922000533.713300-8-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a67e5fde-8b96-47b9-f1dd-c8be8ea9da7f@redhat.com>
Date:   Wed, 22 Sep 2021 08:29:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922000533.713300-8-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 22/09/21 02:05, Sean Christopherson wrote:
> Add helpers for the guest callbacks to prepare for burying the callbacks
> behind a Kconfig (it's a lot easier to provide a few stubs than to #ifdef
> piles of code), and also to prepare for converting the callbacks to
> static_call().  perf_instruction_pointer() in particular will have subtle
> semantics with static_call(), as the "no callbacks" case will return 0 if
> the callbacks are unregistered between querying guest state and getting
> the IP.  Implement the change now to avoid a functional change when adding
> static_call() support, and because the new helper needs to return
> _something_ in this case.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/arm64/kernel/perf_callchain.c | 16 +++++-----------
>   arch/x86/events/core.c             | 15 +++++----------
>   arch/x86/events/intel/core.c       |  5 +----
>   include/linux/perf_event.h         | 24 ++++++++++++++++++++++++
>   4 files changed, 35 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
> index 274dc3e11b6d..db04a55cee7e 100644
> --- a/arch/arm64/kernel/perf_callchain.c
> +++ b/arch/arm64/kernel/perf_callchain.c
> @@ -102,9 +102,7 @@ compat_user_backtrace(struct compat_frame_tail __user *tail,
>   void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
>   			 struct pt_regs *regs)
>   {
> -	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
> -
> -	if (guest_cbs && guest_cbs->state()) {
> +	if (perf_guest_state()) {
>   		/* We don't support guest os callchain now */
>   		return;
>   	}
> @@ -149,10 +147,9 @@ static bool callchain_trace(void *data, unsigned long pc)
>   void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
>   			   struct pt_regs *regs)
>   {
> -	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
>   	struct stackframe frame;
>   
> -	if (guest_cbs && guest_cbs->state()) {
> +	if (perf_guest_state()) {
>   		/* We don't support guest os callchain now */
>   		return;
>   	}
> @@ -163,18 +160,15 @@ void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
>   
>   unsigned long perf_instruction_pointer(struct pt_regs *regs)
>   {
> -	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
> -
> -	if (guest_cbs && guest_cbs->state())
> -		return guest_cbs->get_ip();
> +	if (perf_guest_state())
> +		return perf_guest_get_ip();
>   
>   	return instruction_pointer(regs);
>   }
>   
>   unsigned long perf_misc_flags(struct pt_regs *regs)
>   {
> -	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
> -	unsigned int guest_state = guest_cbs ? guest_cbs->state() : 0;
> +	unsigned int guest_state = perf_guest_state();
>   	int misc = 0;
>   
>   	if (guest_state) {
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 3a7630fdd340..d20e4f8d1aef 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2761,11 +2761,10 @@ static bool perf_hw_regs(struct pt_regs *regs)
>   void
>   perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
>   {
> -	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
>   	struct unwind_state state;
>   	unsigned long addr;
>   
> -	if (guest_cbs && guest_cbs->state()) {
> +	if (perf_guest_state()) {
>   		/* TODO: We don't support guest os callchain now */
>   		return;
>   	}
> @@ -2865,11 +2864,10 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
>   void
>   perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
>   {
> -	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
>   	struct stack_frame frame;
>   	const struct stack_frame __user *fp;
>   
> -	if (guest_cbs && guest_cbs->state()) {
> +	if (perf_guest_state()) {
>   		/* TODO: We don't support guest os callchain now */
>   		return;
>   	}
> @@ -2946,18 +2944,15 @@ static unsigned long code_segment_base(struct pt_regs *regs)
>   
>   unsigned long perf_instruction_pointer(struct pt_regs *regs)
>   {
> -	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
> -
> -	if (guest_cbs && guest_cbs->state())
> -		return guest_cbs->get_ip();
> +	if (perf_guest_state())
> +		return perf_guest_get_ip();
>   
>   	return regs->ip + code_segment_base(regs);
>   }
>   
>   unsigned long perf_misc_flags(struct pt_regs *regs)
>   {
> -	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
> -	unsigned int guest_state = guest_cbs ? guest_cbs->state() : 0;
> +	unsigned int guest_state = perf_guest_state();
>   	int misc = 0;
>   
>   	if (guest_state) {
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 524ad1f747bd..f5b02017ba16 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2786,7 +2786,6 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>   {
>   	struct perf_sample_data data;
>   	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> -	struct perf_guest_info_callbacks *guest_cbs;
>   	int bit;
>   	int handled = 0;
>   	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
> @@ -2853,9 +2852,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>   	 */
>   	if (__test_and_clear_bit(GLOBAL_STATUS_TRACE_TOPAPMI_BIT, (unsigned long *)&status)) {
>   		handled++;
> -
> -		guest_cbs = perf_get_guest_cbs();
> -		if (likely(!guest_cbs || !guest_cbs->handle_intel_pt_intr()))
> +		if (!perf_guest_handle_intel_pt_intr())
>   			intel_pt_interrupt();
>   	}
>   
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index f9be88a47434..c0a6eaf55fb1 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1247,6 +1247,30 @@ static inline struct perf_guest_info_callbacks *perf_get_guest_cbs(void)
>   	/* Prevent reloading between a !NULL check and dereferences. */
>   	return READ_ONCE(perf_guest_cbs);
>   }
> +static inline unsigned int perf_guest_state(void)
> +{
> +	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
> +
> +	return guest_cbs ? guest_cbs->state() : 0;
> +}
> +static inline unsigned long perf_guest_get_ip(void)
> +{
> +	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
> +
> +	/*
> +	 * Arbitrarily return '0' in the unlikely scenario that the callbacks
> +	 * are unregistered between checking guest state and getting the IP.
> +	 */
> +	return guest_cbs ? guest_cbs->get_ip() : 0;
> +}
> +static inline unsigned int perf_guest_handle_intel_pt_intr(void)
> +{
> +	struct perf_guest_info_callbacks *guest_cbs = perf_get_guest_cbs();
> +
> +	if (guest_cbs && guest_cbs->handle_intel_pt_intr)
> +		return guest_cbs->handle_intel_pt_intr();
> +	return 0;
> +}
>   extern void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs);
>   extern void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs);
>   
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

