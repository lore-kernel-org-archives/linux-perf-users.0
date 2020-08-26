From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [RFC] perf/core: Fixes hung issue on perf stat command during cpu
 hotplug
Date: Wed, 26 Aug 2020 20:07:20 +0530
Message-ID: <135a1238-9a43-8335-e8a6-961678e95f65@linux.ibm.com>
References: <20200826093236.446024-1-kjain@linux.ibm.com>
 <20200826132107.GH1059382@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200826132107.GH1059382@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: jolsa@redhat.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, maddy@linux.ibm.com, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, namhyung@kernel.org, daniel@iogearbox.net, brho@google.com, srikar@linux.vnet.ibm.com
List-Id: linux-perf-users.vger.kernel.org



On 8/26/20 6:51 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Aug 26, 2020 at 03:02:36PM +0530, Kajol Jain escreveu:
>> Commit 2ed6edd33a21 ("perf: Add cond_resched() to task_function_call()")
>> added assignment of ret value as -EAGAIN in case function
>> call to 'smp_call_function_single' fails.
>> For non-zero ret value, it did 
>> 'ret = !ret ? data.ret : -EAGAIN;', which always
>> assign -EAGAIN to ret and make second if condition useless.
>>
>> In scenarios like when executing a perf stat with --per-thread option, and 
>> if any of the monitoring cpu goes offline, the 'smp_call_function_single'
>> function could return -ENXIO, and with the above check,
>> task_function_call hung and increases CPU
>> usage (because of repeated 'smp_call_function_single()')
>>
>> Recration scenario:
>> 	# perf stat -a --per-thread && (offline a CPU )
> 
> Peter, this is kernel stuff, can you take a look?
> 
> - Arnaldo
>  
>> Patch here removes the tertiary condition added as part of that 
>> commit and added a check for NULL and -EAGAIN.
>>
>> Fixes: 2ed6edd33a21("perf: Add cond_resched() to task_function_call()")
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>> ---
>>  kernel/events/core.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 5bfe8e3c6e44..330c53f7df9c 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -115,9 +115,9 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
>>  	for (;;) {
>>  		ret = smp_call_function_single(task_cpu(p), remote_function,
>>  					       &data, 1);
>> -		ret = !ret ? data.ret : -EAGAIN;
>> -
>> -		if (ret != -EAGAIN)
>> +		if (!ret)
>> +			ret = data.ret;
>> +		else if (ret != -EAGAIN)
>>  			break;
>>  
>>  		cond_resched();
>> -- 

Hi,
  Sorry for the confusion, I send wrong version of the patch. We don't have else in second
condition.

The right patch changes are:

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5bfe8e3c6e44..53d960394af9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -115,8 +115,8 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
        for (;;) {
                ret = smp_call_function_single(task_cpu(p), remote_function,
                                               &data, 1);
-               ret = !ret ? data.ret : -EAGAIN;
-
+               if (!ret)
+                       ret = data.ret;
                if (ret != -EAGAIN)
                        break;

I will again send the patch, please ignore this one.

Thanks,
Kajol Jain
 
>> 2.26.2
>>
> 
