From: zhangmengting <zhangmengting@huawei.com>
Subject: Re: [PATCH] perf evsel: Enable ignore_missing_thread for pid option
Date: Thu, 7 Dec 2017 22:03:55 +0800
Message-ID: <97a9ae35-d728-7db8-0fab-1f831dcf23b7@huawei.com>
References: <1512464613-44634-1-git-send-email-zhangmengting@huawei.com>
 <20171206125925.GA8717@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206125925.GA8717@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com, huawei.libin@huawei.com, wangnan0@huawei.com, cj.chengjian@huawei.com
List-Id: linux-perf-users.vger.kernel.org

Hi Jiri,

Thanks for your review!   I've sent a patch V2 to address these issues.

On 2017/12/6 20:59, Jiri Olsa wrote:
> On Tue, Dec 05, 2017 at 05:03:33PM +0800, Mengting Zhang wrote:
>> While monitoring a multithread process with pid option, perf sometimes
>> may return sys_perf_event_open failure with 3(No such process) if any
>> of the process's threads die before we open the event. However, we want
>> perf continue monitoring the remaining threads and do not exit with error.
>>
>> Here, the patch enables perf_evsel::ignore_missing_thread for -p option
>> to ignore complete failure if any of threads die before we open the event.
>> But it may still return sys_perf_event_open failure with 22(Invalid) if we
>> monitors several event groups.
>>
>> 	sys_perf_event_open: pid 28960  cpu 40  group_fd 118202  flags 0x8
>> 	sys_perf_event_open: pid 28961  cpu 40  group_fd 118203  flags 0x8
>> 	WARNING: Ignored open failure for pid 28962
>> 	sys_perf_event_open: pid 28962  cpu 40  group_fd [118203]  flags 0x8
>> 	sys_perf_event_open failed, error -22
>>
>> That is because when we ignore a missing thread, we change the thread_idx
>> without dealing with its fds, FD(evsel, cpu, thread). Then get_group_fd()
>> may return a wrong group_fd for the next thread and sys_perf_event_open()
>> return with 22.
> oops, nice catch
>
> SNIP
>
>> +static int group_fd__remove(struct perf_evsel *evsel,
>> +			    int nr_cpus, int cpu_idx,
>> +			    int nr_threads, int thread_idx)
> please call this something more generic like update_fds,
> I think it affects more stuff than just group_fds

Yeah, not just change the group_fds. It affects fds related with
the missing thread.

>
>> +{
>> +	struct perf_evsel *pos;
>> +	struct perf_evlist *evlist = evsel->evlist;
>> +
>> +	if (nr_cpus < 1 || nr_threads < 1)
>> +		return -EINVAL;
> we already have check for threads->nr == 1 in ignore_missing_thread
> also not sure how possible is to get nr_cpus < 1, but ok

Yes, this condition seems redundant. I will remove this condition.

>> +
>> +	if (cpu_idx >= nr_cpus || thread_idx >= nr_threads)
>> +		return -EINVAL;
>> +
>> +	evlist__for_each_entry(evlist, pos) {
>> +		if (pos != evsel) {
>> +			for (int cpu = 0; cpu < nr_cpus; cpu++)
>> +				for (int thread = thread_idx; thread < nr_threads; thread++)
>> +					FD(pos, cpu, thread) = FD(pos, cpu, thread + 1);
>> +		}
>> +		else {
>> +			for (int cpu = 0; cpu < cpu_idx; cpu++)
>> +				for (int thread = thread_idx; thread < nr_threads; thread++)
>> +					FD(pos, cpu, thread) = FD(pos, cpu, thread + 1);
>> +			break;
>> +		}
>> +	}
> could you please put this into some generic function, like:
>
> 	void perf_evsel__remove_thread(evsel, nr_cpus, nr_threads, int thread_idx)
> 	{
> 		for (int cpu = 0; cpu < nr_cpus; cpu++)
> 			for (int thread = thread_idx; thread < nr_threads; thread++)
> 				FD(pos, cpu, thread) = FD(pos, cpu, thread + 1);
> 	}
>
>
> with the loop would be like:
>
> 	evlist__for_each_entry(evlist, pos) {
> 		int nr_cpus = pos != evsel ? nr_cpus : cpu_idx;
>
> 		perf_evsel__remove_thread(evsel, nr_cpus, nr_threads, thread_idx)
> 	}
>
> or something along those lines...

That looks much nicer, just like literate programming!

> thanks for catching this
>
> jirka
>
> .
>
