Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D76C4338F
	for <linux-perf-users@archiver.kernel.org>; Thu, 12 Aug 2021 16:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB396103E
	for <linux-perf-users@archiver.kernel.org>; Thu, 12 Aug 2021 16:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbhHLQvJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 12 Aug 2021 12:51:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233442AbhHLQvJ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 12 Aug 2021 12:51:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEEB160F57;
        Thu, 12 Aug 2021 16:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628787043;
        bh=MMQsxh6VWVq+fupL985dZZlxsg7x7bCSJmg0HZ5KAPI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pt+GzlIWPUjvN1FKuS5Y2/IT/zDean7E5jRFJMDVSdForr8hHIkFcvxvIgA1VLxr5
         pCdN8z00KhbjHiAA4irL4DFIfFrkNwygyuY6uBv6V0rRCvfnV7XcHbYbAXxI8zlFIh
         WNC2/eOQy6Ql9nKTNxoA2m4yhbJ9AMxX2IE3nBrOUc9czsoAkh5+522i9Ls1Bd80x9
         QEgqgWdXXx0HGNZa5q968gd6UF/+4XrH/jdFZi0de4rMIeXbG23lCX51NKut68f/NO
         muWhaLjjPWfBhhYuJqCvFaZlkfmA0nxNijwNi0WjY+k+ywxi/JjQy1Ejfvu4bKjIzQ
         obGlL6971gNAw==
Subject: Re: [RFC 2/3] perf/x86: Control RDPMC access from .enable() hook
To:     Rob Herring <robh@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-perf-users@vger.kernel.org
References: <20210728230230.1911468-1-robh@kernel.org>
 <20210728230230.1911468-3-robh@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <d720903c-926e-f57a-0862-4e5d76db763a@kernel.org>
Date:   Thu, 12 Aug 2021 09:50:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728230230.1911468-3-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 7/28/21 4:02 PM, Rob Herring wrote:
> Rather than controlling RDPMC access behind the scenes from switch_mm(),
> move RDPMC access controls to the PMU .enable() hook. The .enable() hook
> is called whenever the perf CPU or task context changes which is when
> the RDPMC access may need to change.
> 
> This is the first step in moving the RDPMC state tracking out of the mm
> context to the perf context.

Is this series supposed to be a user-visible change or not?  I'm confused.

If you intend to have an entire mm have access to RDPMC if an event is
mapped, then surely access needs to be context switched for the whole
mm.  If you intend to only have the thread to which the event is bound
have access, then the only reason I see to use IPIs is to revoke access
on munmap from the wrong thread.  But even that latter case could be
handled with a more targeted approach, not a broadcast to all of mm_cpumask.

Can you clarify what the overall intent is and what this particular
patch is trying to do?

> 
>  	if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
> -		on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
> +		on_each_cpu_mask(mm_cpumask(mm), x86_pmu_set_user_access_ipi, NULL, 1);

Here you do something for the whole mm.

> -		on_each_cpu(cr4_update_pce, NULL, 1);
> +		on_each_cpu(x86_pmu_set_user_access_ipi, NULL, 1);

Here too.

>  void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>  			struct task_struct *tsk)
>  {
> @@ -581,10 +556,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>  	this_cpu_write(cpu_tlbstate.loaded_mm, next);
>  	this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
> 
> -	if (next != real_prev) {
> -		cr4_update_pce_mm(next);
> +	if (next != real_prev)
>  		switch_ldt(real_prev, next);
> -	}
>  }

But if you remove this, then what handles context switching?

> 
>  /*
> --
> 2.27.0
> 

