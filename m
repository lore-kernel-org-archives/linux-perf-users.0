Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31454C9F;
	Mon, 12 Aug 2024 06:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723445151; cv=none; b=A/Y1vBdwFo9QmoEOBieRnrq1EsePwtFwLZaZ+0/DYWCGJDaT1yoDAa1bbMiIAhujZtaWowoDRyU9nzLXvxRRNbcA7RAeJ2BHsDZA8td5FP9nHU0m4HbtlALIEH6ZIny5s5wfKnKQvrKYg2pQHYLvA1tTsUZoL8oL8ElQQiXKGIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723445151; c=relaxed/simple;
	bh=XfmrLFpLWoF1YAkhFvppp/41F3i+9EL8hDu/4B98ISk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DoOvGkUGCwB4J03AWvRKE+4AjxyhdwtbBpl7eR7bSM6mfzG14G380RMq/K1qPw9DfRBvg62sruYhb31MEwR/xL0c2FinBX07351TotIvHBQzcHZIejl9YSDoyMZlJJ5aNxm6iZNmo5RCzM6X1VIXlcTqTRHES2kdfejC4MMx928=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wj4lJ1QvbzyPDT;
	Mon, 12 Aug 2024 14:45:16 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C367140132;
	Mon, 12 Aug 2024 14:45:43 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 14:45:41 +0800
Message-ID: <d7b9116e-bddc-2ab2-06eb-6191612fe16b@huawei.com>
Date: Mon, 12 Aug 2024 14:45:40 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] ARM: stacktrace: Add USER_STACKTRACE support
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<will@kernel.org>, <arnd@arndb.de>, <afd@ti.com>, <linus.walleij@linaro.org>,
	<akpm@linux-foundation.org>, <masahiroy@kernel.org>,
	<eric.devolder@oracle.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20240730021532.1752582-1-ruanjinjie@huawei.com>
 <ZqzHgFB2t+SWy5o9@shell.armlinux.org.uk>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZqzHgFB2t+SWy5o9@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/8/2 19:48, Russell King (Oracle) wrote:
> On Tue, Jul 30, 2024 at 10:15:32AM +0800, Jinjie Ruan wrote:
>> Currently, userstacktrace is unsupported for ARM. So use the
>> perf_callchain_user() code as blueprint to implement the
>> arch_stack_walk_user() which add userstacktrace support on ARM.
>> Meanwhile, we can use arch_stack_walk_user() to simplify the implementation
>> of perf_callchain_user().
>>
>> A ftrace test case is shown as below:
>> 	# cd /sys/kernel/debug/tracing
>> 	# echo 1 > options/userstacktrace
>> 	# echo 1 > options/sym-userobj
>> 	# echo 1 > events/sched/sched_process_fork/enable
>> 	# cat trace
>>
>> 	......
>> 	              sh-100     [000] .....    51.779261: sched_process_fork: comm=sh pid=100 child_comm=sh child_pid=108
>> 	              sh-100     [000] .....    51.779285: <user stack trace>
>> 	 => /lib/libc.so.6[+0xb3c8c]
>> 	 => /bin/busybox[+0xffb901f1]
>>
>> Also a simple perf test is ok as below:
>> 	# perf record -e cpu-clock --call-graph fp top
>> 	# perf report --call-graph
>>
>> 	.....
>> 	  [[31m  65.00%[[m     0.00%  top      [kernel.kallsyms]  [k] __ret_fast_syscall
>>
>> 	            |
>> 	            ---__ret_fast_syscall
>> 	               |
>> 	               |--[[31m30.00%[[m--__se_sys_getdents64
>> 	               |          iterate_dir
>> 	               |          |
>> 	               |          |--[[31m25.00%[[m--proc_pid_readdir
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Do you have a use case for this feature?

To my knowledge, user stack trace is used in both uprobes and ftrace.

> 
> Given that userspace is free to do whatever it likes with stack frames,
> I think this is going to be hit and miss whether it works.

To be honest, I referred to the implementation of ARM64. Does anyone
have suggestions for improvements or modifications?

> 
