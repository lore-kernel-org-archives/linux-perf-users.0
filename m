Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03F946426;
	Tue,  6 Aug 2024 03:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722913602; cv=none; b=h8CmtkDU+m3WTqBXVA/zTbI0E91UwSKVxScrSlAwgKwwuMiXj/Wz2A348rLvnNkPkhnzfP+NCq3Q/mDU9hYczzzgYGsHjVpUrQ0a3lR8P0Lbt4Ww0mu08oJcEC4ZBnxeVN66KZi4sr8Eug44yCK7iv9dn1rtki8n3EWESnKx744=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722913602; c=relaxed/simple;
	bh=smMDiTbaBRj4i9fHbX1UswDY5rROW12ggIkv10ZoIpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JojuyyOjdWJa5p7Hls74a/dCFuhhDsxKjtAiqbq/bkznKiKl0u5/T3BVtXIO+AH5bOueVIxO9zTvg5Y1hEALDsfdtMYXhvatCw3cH4Gmtd40ATv0c0dr0zW6bDQeCg6ojuBE+AyXRBEkLNF18DSdy4CzTTMu2wzISHPnI26AGxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WdJ7c1wlkz1xtxv;
	Tue,  6 Aug 2024 11:04:44 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id EDB9A1A016C;
	Tue,  6 Aug 2024 11:06:31 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 6 Aug 2024 11:06:30 +0800
Message-ID: <0c69ef28-26d8-4b6e-fa78-2211a7b84eca@huawei.com>
Date: Tue, 6 Aug 2024 11:06:30 +0800
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
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20240802092406.GC12343@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/8/2 17:24, Oleg Nesterov 写道:
> On 08/02, Liao, Chang wrote:
>>
>>
>> 在 2024/8/1 22:06, Oleg Nesterov 写道:
>>> On 08/01, Liao Chang wrote:
>>>>
>>>> @@ -2276,22 +2277,25 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
>>>>  	int err = 0;
>>>>
>>>>  	uprobe = utask->active_uprobe;
>>>> -	if (utask->state == UTASK_SSTEP_ACK)
>>>> +	switch (utask->state) {
>>>> +	case UTASK_SSTEP_ACK:
>>>>  		err = arch_uprobe_post_xol(&uprobe->arch, regs);
>>>> -	else if (utask->state == UTASK_SSTEP_TRAPPED)
>>>> +		break;
>>>> +	case UTASK_SSTEP_TRAPPED:
>>>>  		arch_uprobe_abort_xol(&uprobe->arch, regs);
>>>> -	else
>>>> +		fallthrough;
>>>> +	case UTASK_SSTEP_DENY_SIGNAL:
>>>> +		set_tsk_thread_flag(current, TIF_SIGPENDING);
>>>> +		break;
>>>> +	default:
>>>>  		WARN_ON_ONCE(1);
>>>> +	}
>>>
>>> Liao, at first glance this change looks "obviously wrong" to me.
>>
>> Oleg. Did i overlook some thing obvious here?
> 
> OK, lets suppose uprobe_deny_signal() sets UTASK_SSTEP_DENY_SIGNAL.
> 
> In this case handle_singlestep() will only set TIF_SIGPENDING and
> do nothing else. This is wrong, either _post_xol() or _abort_xol()
> must be called.
> 
> But I think handle_singlestep() will never hit this case. In the
> likely case uprobe_post_sstep_notifier() will replace _DENY_SIGNAL
> with _ACK, and this means that handle_singlestep() won't restore
> TIF_SIGPENDING cleared by uprobe_deny_signal().

You're absolutely right. handle_signlestep() has chance to handle _DENY_SIGANL
unless it followed by setting TIF_UPROBE in uprobe_deny_signal(). This means
_DENY_SIGNAL is likey replaced during next uprobe single-stepping.

I believe introducing _DENY_SIGNAL as the immediate state between UTASK_SSTEP
and UTASK_SSTEP_ACK is still necessary. This allow uprobe_post_sstep_notifier()
to correctly restore TIF_SIGPENDING upon the completion of single-step.

A revised implementation would look like this:

------------------%<------------------
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1980,6 +1980,7 @@ bool uprobe_deny_signal(void)

        if (task_sigpending(t)) {
                clear_tsk_thread_flag(t, TIF_SIGPENDING);
+               utask->state = UTASK_SSTEP_DENY_SIGNAL;

                if (__fatal_signal_pending(t) || arch_uprobe_xol_was_trapped(t)) {
                        utask->state = UTASK_SSTEP_TRAPPED;
@@ -2276,22 +2277,23 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
        int err = 0;

        uprobe = utask->active_uprobe;
-       if (utask->state == UTASK_SSTEP_ACK)
+       switch (utask->state) {
+       case UTASK_SSTEP_ACK:
                err = arch_uprobe_post_xol(&uprobe->arch, regs);
-       else if (utask->state == UTASK_SSTEP_TRAPPED)
+               break;
+       case UTASK_SSTEP_TRAPPED:
                arch_uprobe_abort_xol(&uprobe->arch, regs);
-       else
+               set_thread_flag(TIF_SIGPENDING);
+               break;
+       default:
                WARN_ON_ONCE(1);
+       }

        put_uprobe(uprobe);
        utask->active_uprobe = NULL;
        utask->state = UTASK_RUNNING;
        xol_free_insn_slot(current);

-       spin_lock_irq(&current->sighand->siglock);
-       recalc_sigpending(); /* see uprobe_deny_signal() */
-       spin_unlock_irq(&current->sighand->siglock);
-
        if (unlikely(err)) {
                uprobe_warn(current, "execute the probed insn, sending SIGILL.");
                force_sig(SIGILL);
@@ -2351,6 +2353,8 @@ int uprobe_post_sstep_notifier(struct pt_regs *regs)
                /* task is currently not uprobed */
                return 0;

+       if (utask->state == UTASK_SSTEP_DENY_SIGNAL)
+               set_thread_flag(TIF_SIGPENDING);
        utask->state = UTASK_SSTEP_ACK;
        set_thread_flag(TIF_UPROBE);
        return 1;

------------------>%------------------

> 
> Oleg.
> 
> 

-- 
BR
Liao, Chang
