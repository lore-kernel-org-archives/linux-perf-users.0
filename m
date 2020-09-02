From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH] perf/core: Fix hung issue on perf stat command during cpu
 hotplug
Date: Wed, 2 Sep 2020 21:27:54 +0530
Message-ID: <42e61c14-4774-600d-2347-2cf2f8b2a59e@linux.ibm.com>
References: <20200827064732.20860-1-kjain@linux.ibm.com>
 <20200902150516.GA3474644@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200902150516.GA3474644@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: jolsa@redhat.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, maddy@linux.ibm.com, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, namhyung@kernel.org, daniel@iogearbox.net, brho@google.com, srikar@linux.vnet.ibm.com
List-Id: linux-perf-users.vger.kernel.org



On 9/2/20 8:35 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Aug 27, 2020 at 12:17:32PM +0530, Kajol Jain escreveu:
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
>>
>> Patch here removes the tertiary condition added as part of that
>> commit and added a check for NULL and -EAGAIN.
> 
> I reproduced this issue with v5.9-rc3, now have to reboot for a conf
> call, will try to test the patch afterwards,
> 
> [65108.467416] IRQ 165: no longer affine to CPU23
> [65108.468495] smpboot: CPU 23 is now offline
> [65129.003879] Uhhuh. NMI received for unknown reason 1c on CPU 20.
> [65129.003880] Do you have a strange power saving mode enabled?
> [65129.003880] Dazed and confused, but trying to continue
> [65156.155539] Uhhuh. NMI received for unknown reason 1c on CPU 2.
> [65156.155539] Do you have a strange power saving mode enabled?
> [65156.155540] Dazed and confused, but trying to continue
> [65161.985284] Uhhuh. NMI received for unknown reason 1c on CPU 21.
> [65161.985285] Do you have a strange power saving mode enabled?
> [65161.985285] Dazed and confused, but trying to continue
> [65183.154444] Uhhuh. NMI received for unknown reason 1c on CPU 1.
> [65183.154445] Do you have a strange power saving mode enabled?
> [65183.154446] Dazed and confused, but trying to continue
> [65189.724797] Uhhuh. NMI received for unknown reason 0c on CPU 4.
> [65189.724798] Do you have a strange power saving mode enabled?
> [65189.724799] Dazed and confused, but trying to continue
> [65196.259918] Uhhuh. NMI received for unknown reason 1c on CPU 11.
> [65196.259918] Do you have a strange power saving mode enabled?
> [65196.259918] Dazed and confused, but trying to continue
> [65234.794490] Uhhuh. NMI received for unknown reason 0c on CPU 5.
> [65234.794491] Do you have a strange power saving mode enabled?
> [65234.794491] Dazed and confused, but trying to continue
> [65454.559831] Uhhuh. NMI received for unknown reason 1c on CPU 19.
> [65454.559832] Do you have a strange power saving mode enabled?
> [65454.559832] Dazed and confused, but trying to continue
> [65529.657789] Uhhuh. NMI received for unknown reason 1c on CPU 3.
> [65529.657790] Do you have a strange power saving mode enabled?
> [65529.657790] Dazed and confused, but trying to continue
> [acme@five perf]$
> 
> 
> Things seems to be working again after bringing that CPU back online:

Hi Arnaldo,
    You are right, once we bring back the CPU again, things will start working as our 'smp_call_function_single'
will not fail and we will come out of the loop. But till then, task_function_call will be hung.

Thanks,
Kajol Jain
> 
> [root@five ~]# perf top --stdio -C 0-22
> Error:
> The sys_perf_event_open() syscall returned with 16 (Device or resource busy) for event (cycles).
> /bin/dmesg | grep -i perf may provide additional information.
> 
> [root@five ~]# perf stat -e cycles sleep 1
> Error:
> The sys_perf_event_open() syscall returned with 16 (Device or resource busy) for event (cycles).
> /bin/dmesg | grep -i perf may provide additional information.
> 
> [root@five ~]# perf record -e cycles sleep 1
> Error:
> The sys_perf_event_open() syscall returned with 16 (Device or resource busy) for event (cycles).
> /bin/dmesg | grep -i perf may provide additional information.
> 
> [root@five ~]# echo 1 > /sys/devices/system/cpu/cpu23/online
> [root@five ~]# perf record -e cycles sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.039 MB perf.data (7 samples) ]
> [root@five ~]# perf stat -e cycles sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>            842,743      cycles
> 
>        1.000903853 seconds time elapsed
> 
>        0.000902000 seconds user
>        0.000000000 seconds sys
> 
> 
> [root@five ~]# perf stat -e cycles sleep 1
> 
> 
> - Arnaldo
> 
>  
>> Fixes: 2ed6edd33a21("perf: Add cond_resched() to task_function_call()")
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>> Reviewed-by: Barret Rhoden <brho@google.com>
>> Tested-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
>> ---
>>  kernel/events/core.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> Changelog:
>> - Remove RFC tag
>> - Resolve some nits issues like space after if and
>>   added -ENXIO in comment msg of function 'task_function_call'
>>   as suggested by Barret Rhoden.
>>
>> Link to the RFC: https://lkml.org/lkml/2020/8/26/896
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 5bfe8e3c6e44..cef646084198 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -99,7 +99,7 @@ static void remote_function(void *data)
>>   * retry due to any failures in smp_call_function_single(), such as if the
>>   * task_cpu() goes offline concurrently.
>>   *
>> - * returns @func return value or -ESRCH when the process isn't running
>> + * returns @func return value or -ESRCH or -ENXIO when the process isn't running
>>   */
>>  static int
>>  task_function_call(struct task_struct *p, remote_function_f func, void *info)
>> @@ -115,7 +115,8 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
>>  	for (;;) {
>>  		ret = smp_call_function_single(task_cpu(p), remote_function,
>>  					       &data, 1);
>> -		ret = !ret ? data.ret : -EAGAIN;
>> +		if (!ret)
>> +			ret = data.ret;
>>  
>>  		if (ret != -EAGAIN)
>>  			break;
>> -- 
>> 2.26.2
>>
> 
