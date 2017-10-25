From: "chengjian (D)" <cj.chengjian@huawei.com>
Subject: Re: [PATCH] perf/tools : remove default system_wide in sched record
Date: Wed, 25 Oct 2017 19:03:17 +0800
Message-ID: <a7537e22-9ef3-9dd2-79b3-305e93f84e64@huawei.com>
References: <1508831134-151993-1-git-send-email-cj.chengjian@huawei.com>
 <20171024134644.GF7045@kernel.org> <20171025022326.GD12785@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:8989 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdJYLHa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Oct 2017 07:07:30 -0400
In-Reply-To: <20171025022326.GD12785@sejong>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, xiexiuqi@huawei.com, huawei.libin@huawei.com, zhangmengting@huawei.com, kernel-team@lge.com



On 2017/10/25 10:23, Namhyung Kim wrote:
> On Tue, Oct 24, 2017 at 10:46:44AM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Tue, Oct 24, 2017 at 03:45:34PM +0800, Cheng Jian escreveu:
>>> When running perf sched record, there is a bug.
>>>
>>> It's system_wide when we specify a command line.
>> Humm, isn't this because if you trace just a workload you will miss the
>> sched-in events?
>>
>> Perhaps with PERF_RECORD_SWITCH we can solve that... I.e. still get the
>> sched-in events while tracing just one workload, not requiring
>> system_wide like it is the case now, right?
> Yes, but it will lose other task's comm, also (at least) sched-wakeup
> (from other task) events are still needed.
>
> Thanks,
> Namhyung
>

I found that if the parameters -p and -a were specified at the same time,
PID/TID(-p/-t) would overwrite SYSTEM_WIDE (-a) in target__validate( ).

If we don't specify a process(-p) or a workload, it will make system 
wide (-a)
as the default target.

     /* Make system wide (-a) the default target. */
     if (!argc && target__none(&rec->opts.target))
         rec->opts.target.system_wide = true;

So don't -a and -p should have the same operation and feedback?

It also lose some events when use -p.
