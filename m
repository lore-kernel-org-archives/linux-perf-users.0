Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3D12F23;
	Thu,  8 Aug 2024 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723102243; cv=none; b=t40LUkCUJUT6JSHUUwgvIPV+ch7bOnW6zcq1XPHHXKO2rOhR4vMLaCDssZxhy6kGhaTFx1GaHufmk5SxyS4UJPdATVfCL436lcAohVvD//hoIUo2RSZottrgh/v+zKN39yM8a+q1DT1y1fodfirhZM3q9KJkPCpEREizrVT9264=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723102243; c=relaxed/simple;
	bh=1TVBZZONKZz7U2HPtRM9ji7DtnXB7mHDYDicdjhW14E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nEDSL2gO6cq45OGFrL7i9QWnBC5gqzRSqH0zyQDT86wqgA5xvXNwYaN+iY+ggT8Lihx1/ca7EuyMbQd42iW3iFih2JApx1wXhd4UGsHX1FPQBtredM/gcOOwWQlgENKR4fI3quG1LaLK8pvWFMYTyC6gFLoH7GS+kT8SCufL2LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wfdx42sl5z1T6pS;
	Thu,  8 Aug 2024 15:30:16 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C25D180101;
	Thu,  8 Aug 2024 15:30:38 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 8 Aug 2024 15:30:36 +0800
Message-ID: <3bb87fb4-c32e-0a35-0e93-5e1971fe8268@huawei.com>
Date: Thu, 8 Aug 2024 15:30:36 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] uprobes: Improve scalability by reducing the contention
 on siglock
To: Oleg Nesterov <oleg@redhat.com>
CC: <mhiramat@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>
References: <20240801082407.1618451-1-liaochang1@huawei.com>
 <20240801140639.GE4038@redhat.com>
 <51a756b7-3c2f-9aeb-1418-b38b74108ee6@huawei.com>
 <20240802092406.GC12343@redhat.com>
 <0c69ef28-26d8-4b6e-fa78-2211a7b84eca@huawei.com>
 <20240806172529.GC20881@redhat.com> <20240807101746.GA27715@redhat.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20240807101746.GA27715@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/8/7 18:17, Oleg Nesterov 写道:
> So. Liao, I am sorry, but I dislike your patch/approach in any case.
> 
> UTASK_SSTEP_DENY_SIGNAL complicates the state machine. And I don't like the fact
> that set_thread_flag(TIF_SIGPENDING) is called twice, from handle_singlestep()
> and uprobe_post_sstep_notifier(), this complicates the logic even more.
> 
> We need a flag, not the new state.
> 
> And if I read this patch correctly it is wrong:
> 
> 	- uprobe_deny_signal() clears TIF_SIGPENDING and sets UTASK_SSTEP_DENY_SIGNAL
> 
> 	- another signal cames after that and sets TIF_SIGPENDING again
> 
> 	- in this case the task won't return to user-space and execute the probed
> 	  insn, exit_to_user_mode_loop() will notice another TIF_SIGPENDING and
> 	  call arch_do_signal_or_restart()->get_signal() again.
> 
> 	- get_signal() will call uprobe_deny_signal() again hit
> 
> 		WARN_ON_ONCE(utask->state != UTASK_SSTEP);
> 
> 
> And no, we shouldn't change this check into UTASK_SSTEP || UTASK_SSTEP_DENY_SIGNAL.
> Again, the fact that uprobe_deny_signal() cleared TIF_SIGPENDING must not be the
> new state.

Oleg, If i understand correctly, current state machine expects the single-step handling
should end up with either _ACK or _TRAPPED. Any new state would disrupt this logic. If so,
I'm convinced that adding a new state is uncessary. As you mentioned, I propose using a
boolean flag in the uprobe_task data to track whether a signal should be restored at the
cost of increased size. Here's outline of the changes:

  - pre_ssout() resets the deny signal flag

  - uprobe_deny_signal() sets the deny signal flag when TIF_SIGPENDING is cleared.

  - handle_singlestep() check the deny signal flag and restore TIF_SIGPENDING if necessary.

Does this approach look correct to you,do do you have any other way to implement the "flag"?

Thanks.

> 
> Oleg.
> 
> On 08/06, Oleg Nesterov wrote:
>>
>> On 08/06, Liao, Chang wrote:
>>>
>>> You're absolutely right. handle_signlestep() has chance to handle _DENY_SIGANL
>>> unless it followed by setting TIF_UPROBE in uprobe_deny_signal(). This means
>>> _DENY_SIGNAL is likey replaced during next uprobe single-stepping.
>>>
>>> I believe introducing _DENY_SIGNAL as the immediate state between UTASK_SSTEP
>>> and UTASK_SSTEP_ACK is still necessary. This allow uprobe_post_sstep_notifier()
>>> to correctly restore TIF_SIGPENDING upon the completion of single-step.
>>>
>>> A revised implementation would look like this:
>>
>> Still looks "obviously wrong" to me... even the approach itself.
>>
>> Perhaps I am wrong, yet another day when I can't even read emails on lkml
>> carefully, sorry.
>>
>> But can you please send the patch which I could actually apply? This one
>> looks white-space damaged...
>>
>> I'll try to reply with more details as soon I convince myself I fully
>> understand what does your patch actually do, but most probably not tomorrow.
>>
>> Thanks,
>>
>> Oleg.
>>
>>> ------------------%<------------------
>>> --- a/kernel/events/uprobes.c
>>> +++ b/kernel/events/uprobes.c
>>> @@ -1980,6 +1980,7 @@ bool uprobe_deny_signal(void)
>>>
>>>         if (task_sigpending(t)) {
>>>                 clear_tsk_thread_flag(t, TIF_SIGPENDING);
>>> +               utask->state = UTASK_SSTEP_DENY_SIGNAL;
>>>
>>>                 if (__fatal_signal_pending(t) || arch_uprobe_xol_was_trapped(t)) {
>>>                         utask->state = UTASK_SSTEP_TRAPPED;
>>> @@ -2276,22 +2277,23 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
>>>         int err = 0;
>>>
>>>         uprobe = utask->active_uprobe;
>>> -       if (utask->state == UTASK_SSTEP_ACK)
>>> +       switch (utask->state) {
>>> +       case UTASK_SSTEP_ACK:
>>>                 err = arch_uprobe_post_xol(&uprobe->arch, regs);
>>> -       else if (utask->state == UTASK_SSTEP_TRAPPED)
>>> +               break;
>>> +       case UTASK_SSTEP_TRAPPED:
>>>                 arch_uprobe_abort_xol(&uprobe->arch, regs);
>>> -       else
>>> +               set_thread_flag(TIF_SIGPENDING);
>>> +               break;
>>> +       default:
>>>                 WARN_ON_ONCE(1);
>>> +       }
>>>
>>>         put_uprobe(uprobe);
>>>         utask->active_uprobe = NULL;
>>>         utask->state = UTASK_RUNNING;
>>>         xol_free_insn_slot(current);
>>>
>>> -       spin_lock_irq(&current->sighand->siglock);
>>> -       recalc_sigpending(); /* see uprobe_deny_signal() */
>>> -       spin_unlock_irq(&current->sighand->siglock);
>>> -
>>>         if (unlikely(err)) {
>>>                 uprobe_warn(current, "execute the probed insn, sending SIGILL.");
>>>                 force_sig(SIGILL);
>>> @@ -2351,6 +2353,8 @@ int uprobe_post_sstep_notifier(struct pt_regs *regs)
>>>                 /* task is currently not uprobed */
>>>                 return 0;
>>>
>>> +       if (utask->state == UTASK_SSTEP_DENY_SIGNAL)
>>> +               set_thread_flag(TIF_SIGPENDING);
>>>         utask->state = UTASK_SSTEP_ACK;
>>>         set_thread_flag(TIF_UPROBE);
>>>         return 1;
>>>
>>> ------------------>%------------------
>>>
>>>>
>>>> Oleg.
>>>>
>>>>
>>>
>>> --
>>> BR
>>> Liao, Chang
>>>
> 
> 

-- 
BR
Liao, Chang
