From: nishtala <nishtala.raj@gmail.com>
Subject: Re: perf-twatch.py -- python perf experimental setup
Date: Fri, 10 Jul 2015 16:12:40 +0200
Message-ID: <559FD2D8.7090809@gmail.com>
References: <559E3871.7030808@gmail.com> <559E3C8F.3000206@gmail.com> <20150709160739.GB2182@redhat.com> <559EC990.4020601@gmail.com> <20150709205812.GG19430@kernel.org> <559F5BDE.5020206@gmail.com> <20150710140511.GH19430@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:33358 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932336AbbGJOMo (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 Jul 2015 10:12:44 -0400
Received: by wgck11 with SMTP id k11so250722912wgc.0
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Jul 2015 07:12:42 -0700 (PDT)
In-Reply-To: <20150710140511.GH19430@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Clark Williams <williams@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>, Mike Galbraith <efault@gmx.de>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Tom Zanussi <tzanussi@gmail.com>, linux-perf-users@vger.kernel.org

Hi Arnaldo,

On Friday 10 July 2015 04:05 PM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jul 10, 2015 at 07:45:02AM +0200, nishtala escreveu:
>> On Thursday 09 July 2015 10:58 PM, Arnaldo Carvalho de Melo wrote:
>>> Em Thu, Jul 09, 2015 at 09:20:48PM +0200, nishtala escreveu:
>>>> Hi Arnaldo,
>>>>
>>>> On 2015-07-09 18:07, Arnaldo Carvalho de Melo wrote:
>>>>> Em Thu, Jul 09, 2015 at 11:19:11AM +0200, nishtala escreveu:
>>>>>> Hi all,
>>>>>>
>>>>>> I am using the experimental perf interface which you provide in the
>>>>>> linux perf tools, specifically twatch.py
>>>>>>
>>>>>> I am trying to collect HW_CPU_CYCLES. So, I modified the twatch.py
>>>>>> in the following manner:
>>>>> Well, we can try to figure out if there is a problem in how the perf
>>>>> binding provides those COUNT_FOO constants, but you can try by removing
>>>>> that 'config = perf.COUNT_HW_CPU_CYCLES' part, as:
>>>>>
>>>>> enum perf_hw_id {
>>>>>          /*
>>>>>           * Common hardware events, generalized by the kernel:
>>>>>           */
>>>>>          PERF_COUNT_HW_CPU_CYCLES                = 0,
>>>> Where exactly do you want me to change in python.c ? I do not see anything
>>>> like this.
>>> I have not asked you to change anything in python.c, I just said that
>>> HW_CPU_CYCLES is the same thing as zero, 0, and if you do not set
>>> that "config" parameter, the default value for it is zero, aka
>>> PERF_COUNT_HW_CPU_CYCLES
>>>
>>>>> And then config will default to zero, which is the value for the counter
>>>>> you want to use, right?
>>>> I was trying to collect the PMC per thread using perf, using the external
>>>> python interface.. so, the value of the counter required is not zero, but
>>>> the actual number of HW_CPU_CYCLES.
>>> The counter required is zero, which is the same thing as HW_CPU_CYCLES,
>>> do you understand now?
>> Yes, I do understand that part  of it.
>>>> Am i clear?
>>>> something like this.
>>>> perf stat -p <pid> -e HW_CPU-CYCLES -I 1000 using the python interface
>>>    [root@zoo ~]# perf stat -p `pidof firefox` -e HW_CPU_CYCLES -I 1000
>>>    event syntax error: 'HW_CPU_CYCLES'
>>>                         \___ parser error
>>>    Run 'perf list' for a list of valid events
>>>     usage: perf stat [<options>] [<command>]
>>>
>>>        -e, --event <event>   event selector. use 'perf list' to list
>>>    available events
>>>    [root@zoo ~]#
>>>
>>> If you want PERF_COUNT_HW_CPU_CYCLES, then, as 'perf list' shows:
>>>
>>> [acme@zoo linux]$ perf list hw
>>>
>>> List of pre-defined events (to be used in -e):
>>>
>>>    branch-instructions OR branches                    [Hardware event]
>>>    branch-misses                                      [Hardware event]
>>>    bus-cycles                                         [Hardware event]
>>>    cache-misses                                       [Hardware event]
>>>    cache-references                                   [Hardware event]
>>>    cpu-cycles OR cycles                               [Hardware event]
>>>    instructions                                       [Hardware event]
>>>    ref-cycles                                         [Hardware event]
>>>    stalled-cycles-frontend OR idle-cycles-frontend    [Hardware event]
>>>
>>> [acme@zoo linux]$
>>>
>>> You should use 'cycles' or 'cpu-cycles':
>>>
>>> [root@zoo ~]# perf stat -p `pidof firefox` -e cycles -I 1000
>>> #           time             counts unit events
>>>       1.000207393        772,734,328      cycles
>>>       2.000560518        929,263,749      cycles
>>> ^C     2.370850328        143,012,704      cycles
>>>
>>> [root@zoo ~]#
>>>
>>> But the default, if you don't specify any '-e event' in the command line
>>> for 'perf record' is to use an event that has .config equal to zero,
>>> which means, to use PERF_COUNT_HW_CPU_CYCLES. 'perf stat' will count
>>> 'cycles' and several other counters if you do not specify '-e something'.
>>>
>>> In the python case, you should use something like:
>>>
>>> [root@zoo ~]# python
>>> Python 2.7.8 (default, Apr 15 2015, 09:26:43)
>>> [GCC 4.9.2 20150212 (Red Hat 4.9.2-6)] on linux2
>>> Type "help", "copyright", "credits" or "license" for more information.
>>>>>> import perf
>>>>>> threads = perf.thread_map(6302)
>>>>>> print threads[0]
>>> 6302
>>>
>>> In the twatch example, i.e. just add the pids you want to monitor and
>>> then the rest of twatch.py should do what you want.
>>>
>>> Try it with these changes:
>>>
>>> +++ b/tools/perf/python/twatch.py
>>> @@ -13,14 +13,14 @@
>>> -import perf
>>> +import perf, sys
>>> -def main():
>>> +def main(argv):
>>>   	cpus = perf.cpu_map()
>>> -	threads = perf.thread_map()
>>> +	threads = perf.thread_map(int(argv[1]))
>>>   	evsel = perf.evsel(task = 1, comm = 1, mmap = 0,
>>>   			   wakeup_events = 1, watermark = 1,
>>> -			   sample_id_all = 1,
>>> +			   sample_id_all = 1, sample_freq = 1,
>>>   			   sample_type = perf.SAMPLE_PERIOD | perf.SAMPLE_TID | perf.SAMPLE_CPU)
>>>   	evsel.open(cpus = cpus, threads = threads);
>>>   	evlist = perf.evlist(cpus, threads)
>>> @@ -38,4 +38,4 @@ def main():
>>>   			print event
>>>   if __name__ == '__main__':
>>> -    main()
>>> +    main(sys.argv)
>> Thanks for this. I modified this part of it. However in the example
>> below what I don't understand is, where is the reading (counts) for
>> the performance monitoring counter (cycles). For example, when you
>> used you got the following readings.
>   
>> [root@zoo ~]# perf stat -p `pidof firefox` -e cycles -I 1000
>> #           time             counts unit events
>>       1.000207393        772,734,328      cycles
>>       2.000560518        929,263,749      cycles
>> ^C     2.370850328        143,012,704      cycles
>>
>>
>> I don't see them using perf integration of python. That was and is my
>> problem still.
> Ok, so if you add a:
>
> 	print dir(event)
>
> to that 'event' thing returned from evlist.read_on_cpu(cpu), then you
> will see its fields:
>
> ['__class__', '__delattr__', '__doc__', '__format__',
> '__getattribute__', '__hash__', '__init__', '__new__', '__reduce__',
> '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__',
> '__subclasshook__', 'sample_addr', 'sample_cpu', 'sample_id',
> 'sample_ip', 'sample_period', 'sample_pid', 'sample_stream_id',
> 'sample_tid', 'sample_time', 'type']
>
> So, probably what you want is that sample_period, right? Lets try it...
>
> Replace that 'print event' line with:
>
>                          print event,
>                          if event.type == perf.RECORD_SAMPLE:
>                                  print " period=%d" % event.sample_period,
>                          print
>
> Then try it:
>
> [acme@zoo linux]$ tools/perf/python/twatch.py 6302
> cpu:  0, pid: 6302, tid: 23893 { type: sample }  period=1
> cpu:  0, pid: 6302, tid: 23893 { type: sample }  period=1
> cpu:  2, pid: 6302, tid: 6452 { type: sample }  period=1
> cpu:  0, pid: 6302, tid: 23893 { type: sample }  period=16615
> cpu:  2, pid: 6302, tid: 6452 { type: sample }  period=1
> cpu:  0, pid: 6302, tid: 23893 { type: sample }  period=726957136
> cpu:  1, pid: 6302, tid: 23893 { type: sample }  period=1
> cpu:  2, pid: 6302, tid: 6452 { type: sample }  period=20772
> cpu:  0, pid: 6302, tid: 6302 { type: sample }  period=1
> cpu:  1, pid: 6302, tid: 23893 { type: sample }  period=1
> cpu:  2, pid: 6302, tid: 6452 { type: sample }  period=1055077095
> ^CTraceback (most recent call last):
>    File "tools/perf/python/twatch.py", line 44, in <module>
>      main(sys.argv)
>    File "tools/perf/python/twatch.py", line 30, in main
>      evlist.poll(timeout = -1)
> KeyboardInterrupt
> [acme@zoo linux]$
>
> Now add all those periods and you should have the result that 'perf
> stat' provides.
>
> Go on printing it every 1000ms and you'll get something similar to
>
> 'perf stat -I 1000'
>
> Pleas note that this is for a thread_map() with a pid of 6302, i.e. for
> 6302 and its children, that is why you see all those different tids.
>
> If you wanted, say, just for tid 23893, one of 6302's children, do this
> at thread_map creation time:
>
> 	threads = perf.thread_map(-1, int(argv[1]))
>
> I.e. use -1 for the pid, and pass as the second argument the tid you
> want, that, using the above line, would get the 23893 samples by using:
>
> [acme@zoo linux]$ tools/perf/python/twatch.py 23893
> cpu:  0, pid: 6302, tid: 23893 { type: sample }  period=1
> cpu:  0, pid: 6302, tid: 23893 { type: sample }  period=1
> cpu:  0, pid: 6302, tid: 23893 { type: sample }  period=30356
> cpu:  1, pid: 6302, tid: 23893 { type: sample }  period=1
> cpu:  0, pid: 6302, tid: 23893 { type: sample }  period=2633267367
> cpu:  1, pid: 6302, tid: 23893 { type: sample }  period=1
> cpu:  2, pid: 6302, tid: 23893 { type: sample }  period=1
> ^CTraceback (most recent call last):
>    File "tools/perf/python/twatch.py", line 44, in <module>
>      main(sys.argv)
>    File "tools/perf/python/twatch.py", line 30, in main
>      evlist.poll(timeout = -1)
> KeyboardInterrupt
> [acme@zoo linux]$
>
> Say you want a few children threads of this 6302 firefox pid, oops, that
> is not supported in the current python binding, left as an exercise for
> the reader, one would need to use:
>
>     struct thread_map *thread_map__new_str(const char *pid, const char *tid, uid_t uid)
>
> In:
>
>     tools/perf/util/python.c
>
> In this function:
>
> static int pyrf_thread_map__init(struct pyrf_thread_map *pthreads,
>                                   PyObject *args, PyObject *kwargs)
> {
>          static char *kwlist[] = { "pid", "tid", "uid", NULL };
>          int pid = -1, tid = -1, uid = UINT_MAX;
>
>          if (!PyArg_ParseTupleAndKeywords(args, kwargs, "|iii",
>                                           kwlist, &pid, &tid, &uid))
>                  return -1;
>
>          pthreads->threads = thread_map__new(pid, tid, uid);
>          if (pthreads->threads == NULL)
>                  return -1;
>          return 0;
> }
>
> You would need to figure out how to accept either an integer, like it is
> now, or an string, if it was a integer, do as today and call
> thread_map__new(pid, tid, uid), if it is a list, use
> thread_map__new_str(), etc.
>
> This way we keep the existing interface, while allowing lists of pids
> and tids to be passed as well.
Thanks! this works for me.
>
> Ah, please add linux-perf-users@vger.kernel.org when if you reply to
> this message, so that we can get this stored somewhere, may as well
> serve as documentation :-)
>
> - Arnaldo
