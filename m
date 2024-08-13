Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CBA19B3DD;
	Tue, 13 Aug 2024 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554847; cv=none; b=kyv/3MMGedZwDisaKNovOfjk9rDC9PdnN7Nrp4n8r9MxtoS5G4YdcjlUdQ5HLsju/PI5FiVmfLwdyogxxEn5rygpAIGmeW06Yqqmvo4ZGenwkYWV8GdQeaQUD8Or2V6w+z5v9+XKGKH8mkjFicH3Zyu1pIgdLUqnt/tmfYYSCsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554847; c=relaxed/simple;
	bh=SlRisIpCNCpm6zvwnFEUNWuu0OeVFENHsXjtjgFQ/f8=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FsvTMO8oESGjywp3up1XK8ILNGAGOKNG+eMIsKF5WnQa7AYF3PVsV4UAQZ5ryUZbd7r/spmTaPZyw3BT4Hvay00aGgnOeEcelDNYtj1L8bClPtv5L9WqC1dKnz4rgxklJAB6TKvHDwfFzTOOjY4mOQXxLVU1754kayxp3rCaIJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WjsCn5fB9z2CmYC;
	Tue, 13 Aug 2024 21:09:09 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B2FB140337;
	Tue, 13 Aug 2024 21:14:00 +0800 (CST)
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 13 Aug 2024 21:13:59 +0800
Subject: Re: [PATCH] perf/x86/intel: Restrict period on Haswell
To: Thomas Gleixner <tglx@linutronix.de>, <peterz@infradead.org>,
	<mingo@redhat.com>
CC: <acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	<hpa@zytor.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240729223328.327835-1-lihuafei1@huawei.com>
 <875xsl5pwv.ffs@tglx>
From: Li Huafei <lihuafei1@huawei.com>
Message-ID: <fb87cc82-94b7-31aa-0374-a1d7fa49470e@huawei.com>
Date: Tue, 13 Aug 2024 21:13:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <875xsl5pwv.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500004.china.huawei.com (7.202.181.242)


Hi Thomas, sorry for the late reply.

On 2024/8/1 3:20, Thomas Gleixner wrote:
> On Tue, Jul 30 2024 at 06:33, Li Huafei wrote:
>> On my Haswell machine, running the ltp test cve-2015-3290 concurrently
>> reports the following warnings:
>>
>>   perfevents: irq loop stuck!
>>   WARNING: CPU: 31 PID: 32438 at arch/x86/events/intel/core.c:3174 intel_pmu_handle_irq+0x285/0x370
>>   CPU: 31 UID: 0 PID: 32438 Comm: cve-2015-3290 Kdump: loaded Tainted: G S      W          6.11.0-rc1+ #3
>>   ...
>>   Call Trace:
>>    <NMI>
>>    ? __warn+0xa4/0x220
>>    ? intel_pmu_handle_irq+0x285/0x370
>>    ? __report_bug+0x123/0x130
>>    ? intel_pmu_handle_irq+0x285/0x370
>>    ? __report_bug+0x123/0x130
>>    ? intel_pmu_handle_irq+0x285/0x370
>>    ? report_bug+0x3e/0xa0
>>    ? handle_bug+0x3c/0x70
>>    ? exc_invalid_op+0x18/0x50
>>    ? asm_exc_invalid_op+0x1a/0x20
>>    ? irq_work_claim+0x1e/0x40
>>    ? intel_pmu_handle_irq+0x285/0x370
>>    perf_event_nmi_handler+0x3d/0x60
>>    nmi_handle+0x104/0x330
>>    ? ___ratelimit+0xe4/0x1b0
>>    default_do_nmi+0x40/0x100
>>    exc_nmi+0x104/0x180
>>    end_repeat_nmi+0xf/0x53
>>    ...
>>    ? intel_pmu_lbr_enable_all+0x2a/0x90
>>    ? __intel_pmu_enable_all.constprop.0+0x16d/0x1b0
>>    ? __intel_pmu_enable_all.constprop.0+0x16d/0x1b0
>>    perf_ctx_enable+0x8e/0xc0
>>    __perf_install_in_context+0x146/0x3e0
>>    ? __pfx___perf_install_in_context+0x10/0x10
>>    remote_function+0x7c/0xa0
>>    ? __pfx_remote_function+0x10/0x10
>>    generic_exec_single+0xf8/0x150
>>    smp_call_function_single+0x1dc/0x230
>>    ? __pfx_remote_function+0x10/0x10
>>    ? __pfx_smp_call_function_single+0x10/0x10
>>    ? __pfx_remote_function+0x10/0x10
>>    ? lock_is_held_type+0x9e/0x120
>>    ? exclusive_event_installable+0x4f/0x140
>>    perf_install_in_context+0x197/0x330
>>    ? __pfx_perf_install_in_context+0x10/0x10
>>    ? __pfx___perf_install_in_context+0x10/0x10
>>    __do_sys_perf_event_open+0xb80/0x1100
>>    ? __pfx___do_sys_perf_event_open+0x10/0x10
>>    ? __pfx___lock_release+0x10/0x10
>>    ? lockdep_hardirqs_on_prepare+0x135/0x200
>>    ? ktime_get_coarse_real_ts64+0xee/0x100
>>    ? ktime_get_coarse_real_ts64+0x92/0x100
>>    do_syscall_64+0x70/0x180
>>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>    ...
> 
> Please trim the backtrace to something useful:
> 
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces
> 

Okay, thanks for the tip!

>> My machine has 32 physical cores, each with two logical cores. During
>> testing, it executes the CVE-2015-3290 test case 100 times concurrently.
>>
>> This warning was already present in [1] and a patch was given there to
>> limit period to 128 on Haswell, but that patch was not merged into the
>> mainline.  In [2] the period on Nehalem was limited to 32. I tested 16
>> and 32 period on my machine and found that the problem could be
>> reproduced with a limit of 16, but the problem did not reproduce when
>> set to 32. It looks like we can limit the cycles to 32 on Haswell as
>> well.
> 
> It looks like? Either it works or not.
> 

It worked for my test scenario. I say "looks like" because I'm not sure
how it circumvents the problem, and if the limit of 32 no longer works
if I increase the number of test cases executed in parallel. Any
suggestions?

>>  
>> +static void hsw_limit_period(struct perf_event *event, s64 *left)
>> +{
>> +	*left = max(*left, 32LL);
>> +}
> 
> And why do we need a copy of nhm_limit_period() ?
> 

Do you mean why the period is limited to 32 like nhm_limit_period()? I
referred to nhm_limit_period() and found that the problem cannot be
reproduced when the limit is 32, while it can be reproduced when the
limit is 16. Therefore, similar to nhm, the limit period is 32. As
mentioned earlier, I am not sure how it works and need expert advice.

Thanks,
Huafei

> Thanks,
> 
>         tglx
> 
> .
> 
