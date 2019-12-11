From: Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: perf top for arm64?
Date: Wed, 11 Dec 2019 10:36:39 +0800
Message-ID: <0870e660-2511-ced0-7402-5ff389c4c281@huawei.com>
References: <1573045254-39833-1-git-send-email-john.garry@huawei.com>
 <20191106140036.GA6259@kernel.org>
 <418023e7-a50d-cb6f-989f-2e6d114ce5d8@huawei.com>
 <20191210163655.GG14123@krava>
 <952dc484-2739-ee65-f41c-f0198850ab10@huawei.com>
 <20191210170841.GA23357@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191210170841.GA23357@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>, John Garry <john.garry@huawei.com>
Cc: mark.rutland@arm.com, peterz@infradead.org, Linuxarm <linuxarm@huawei.com>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, linux-kernel@vger.kernel.org, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, alexander.shishkin@linux.intel.com, mingo@redhat.com, namhyung@kernel.org, will@kernel.org, linux-arm-kernel@lists.infradead.org, wanghaibin.wang@huawei.com
List-Id: linux-perf-users.vger.kernel.org

Hi John,

On 2019/12/11 1:08, Jiri Olsa wrote:
> On Tue, Dec 10, 2019 at 04:52:52PM +0000, John Garry wrote:
>> On 10/12/2019 16:36, Jiri Olsa wrote:
>>> On Tue, Dec 10, 2019 at 04:13:49PM +0000, John Garry wrote:
>>>> Hi all,
>>>>
>>>> I find to my surprise that "perf top" does not work for arm64:
>>>>
>>>> root@ubuntu:/home/john/linux# tools/perf/perf top
>>>> Couldn't read the cpuid for this machine: No such file or directory
>>>
>>
>> Hi Jirka,
>>
>>> there was recent change that check on cpuid and quits:
>>>     608127f73779 perf top: Initialize perf_env->cpuid, needed by the per arch annotation init routine
>>>
>>
>> ok, this is new code. I obviously didn't check the git history...
>>
>> But, apart from this, there are many other places where get_cpuid() is
>> called. I wonder what else we're missing out on, and whether we should still
>> add it.
> 
> right, I was just wondering how come vendor events are working for you,
> but realized we have get_cpuid_str being called in there ;-)
> 
> I think we should add it as you have it prepared already,
> could you post it with bigger changelog that would explain
> where it's being used for arm?

I've also seen the similar problem when I was looking to add support
for 'perf kvm stat' on arm64 [1] (which though got stuck due to some
other reasons for a very long time :(

It would be great if your patch can address this issue!


[1] https://lore.kernel.org/patchwork/patch/1087531/


Thanks,
Zenghui
