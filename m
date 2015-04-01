From: sahil aggarwal <sahil.agg15@gmail.com>
Subject: Re: perf smapling
Date: Wed, 1 Apr 2015 14:52:46 +0530
Message-ID: <CAGAANTUgpMLY6tNfOrzgH7YKJw2TvJWeyrkqXXnRZi5x5+1ctg@mail.gmail.com>
References: <loom.20150329T075320-204@post.gmane.org>
	<CAL2Y34Bi+VLSvGucN8J=4RXKh785Lg9BYAa4LUU_yCMR7COTgQ@mail.gmail.com>
	<20150331111813.GA1152@ubuntu>
	<CAL2Y34A=Fk03_LSTM_SHwVaE4NaKSD=zZt0vWtzn3Rm9dQtDLQ@mail.gmail.com>
	<CAL2Y34CxT=YRGx6G0kcCWK0AVnaPdb4ybL+u-BiUE7gYg1jYGg@mail.gmail.com>
	<CAGAANTXoY_iVhSHf+dq2K0UEk1Vt=4pGA6ovHwSKmFr=-Xh7Jg@mail.gmail.com>
	<CAGAANTWToURnsEQ4YfYiw2e4y9g=54N+joKpHuO2i6vQV_wVBQ@mail.gmail.com>
	<CAL2Y34AL94U7KGej5mN3enqLpXWs_xiE36D1MY3NghH17g+Epw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:34530 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbbDAJWr (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 1 Apr 2015 05:22:47 -0400
Received: by obbgh1 with SMTP id gh1so66778880obb.1
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2015 02:22:46 -0700 (PDT)
In-Reply-To: <CAL2Y34AL94U7KGej5mN3enqLpXWs_xiE36D1MY3NghH17g+Epw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Elazar Leibovich <elazar.leibovich@ravellosystems.com>
Cc: linux-perf-users@vger.kernel.org

Hi Elazar

Finally i am able to make small prototype to enable tracepoints. :)

One more thing, is it possible to enable multiple tracepoints through
1 thread and
while parsing output find out to which tracepoint that raw data belongs.?

Or i would have to create separate thread for each tracepoint. ?

Man page says:
  Set config to one of the  following:
          .........

So i am assuming i will have to create separate thread for each event.


Thanks a lot.

On 31 March 2015 at 23:37, Elazar Leibovich
<elazar.leibovich@ravellosystems.com> wrote:
> Look at the man page, you should set the type to PERF_TYPE_TRACEPOINT
> and set the config to the event id.
>
> On my system, sys_enter_open event id is 455
>
> $ sudo cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_open/id
> 455
>
> Add PERF_SAMPLE_RAW to the sample_type.
>
> BTW
> You can compile the tar.gz I sent and echo JSON in the attr format to
> it, it'll print back perf data in json format. Easier to experiment
> with perf_event_open API than writing a C program.
>
> For example
>
> $ make
> $ sudo ./perf2 <<EOF
> {
>   "attr": {
>     "sample_type": [
>       "PERF_SAMPLE_IP",
>       "PERF_SAMPLE_RAW"
>     ],
>     "wakeup_events": 1,
>     "config": 455,
>     "sample_period": 1,
>     "type": "PERF_TYPE_TRACEPOINT"
>   }
> }
> EOF
> {"type":"PERF_RECORD_SAMPLE","misc":"PERF_RECORD_MISC_USER","sample":{"ip":"7f4f3625263d","data":[-57,1,0,0,7,11,0,0,2,0,0,0,0,0,0,0,-32,101,75,22,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}}
> {"type":"PERF_RECORD_SAMPLE","misc":"PERF_RECORD_MISC_USER","sample":{"ip":"7f4f3625263d","data":[-57,1,0,0,7,11,0,0,2,0,0,0,0,0,0,0,-64,112,75,22,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}}
> {"type":"PERF_RECORD_SAMPLE","misc":"PERF_RECORD_MISC_USER","sample":{"ip":"7f4f3625263d","data":[-57,1,0,0,7,11,0,0,2,0,0,0,0,0,0,0,-112,70,75,22,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}}
> {"type":"PERF_RECORD_SAMPLE","misc":"PERF_RECORD_MISC_USER","sample":{"ip":"7f4f3625263d","data":[-57,1,0,0,7,11,0,0,2,0,0,0,0,0,0,0,-32,70,75,22,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}}
> {"type":"PERF_RECORD_SAMPLE","misc":"PERF_RECORD_MISC_USER","sample":{"ip":"7f4f3625263d","data":[-57,1,0,0,7,11,0,0,2,0,0,0,0,0,0,0,0,-99,26,-19,-1,127,0,0,0,0,0,0,0,0,0,0,-74,1,0,0,0,0,0,0,0,0,0,0]}}
> ...
>
> What is the raw data? Depends on the event. For sys_enter/exit it is
> struct syscall_trace_enter/exit.
>
> http://osxr.org/linux/source/kernel/trace/trace.h#0095
> struct trace_entry {
>      unsigned short      type;
>      unsigned char       flags;
>      unsigned char       preempt_count;
>      int         pid;
> };
> struct syscall_trace_enter {
>     struct trace_entry  ent;
>     int         nr;
>     unsigned long       args[];
> };
>
> How did I know that? I followed the kernel logic here:
>
> http://osxr.org/linux/source/kernel/trace/trace_syscalls.c#0636
> static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
> {
> ...
> rec = (struct syscall_trace_exit *)perf_trace_buf_prepare(size, ...);
> ...
> }
>
> Note that indeed after short+char+char+int we have 2, the open syscall
> number in all event's raw data.
>
> On Tue, Mar 31, 2015 at 6:22 PM, sahil aggarwal <sahil.agg15@gmail.com> wrote:
>> Actually i need most of the sampling around PERF_TYPE_TRACEPOINT,
>> so if i enable tracepoint "syscalls/sys_enter_open/" what will be the "type"
>> field in perf_event_header.? And, the the record struct will be same as given
>> in "syscalls/sys_enter_open/format" .?
>>
>> Thanks
>>
>> On 31 March 2015 at 20:40, sahil aggarwal <sahil.agg15@gmail.com> wrote:
>>> Yeah that was clear enough.
>>> Thanks a lot. Your code is of great help.
>>>
>>> Regards
>>> Sahil
>>>
>>> On 31 March 2015 at 19:45, Elazar Leibovich
>>> <elazar.leibovich@ravellosystems.com> wrote:
>>>> I wanted to ensure the user always see contiguous array of data from
>>>> the ring buffer.
>>>>
>>>> The last piece of data, say "abcde" could wrap around in the ring
>>>> buffer and appear like:
>>>>
>>>> [de...                 ...abc]
>>>>
>>>> I wanted the user to see a contigious array of the form [abcde].
>>>>
>>>> So in the case I'm having input that wrap around, I'll simply copy it
>>>> to the first buffer
>>>>
>>>> [wrap_buffer][de..                 ...abc]
>>>> would become
>>>> [               abc][de...               ...abc]
>>>>
>>>> And then I'll the user pointer to the leftmost "a", and he'll see
>>>> "abcde" without knowing he's handling a ring buffer.
>>>>
>>>> Let me know if I was clear enough.
>>>>
>>>> On Tue, Mar 31, 2015 at 2:18 PM, sahil aggarwal <sahil.agg15@gmail.com> wrote:
>>>>>
>>>>> Hi Elazar
>>>>>
>>>>> Can you help me understand why you have used
>>>>> mmap_pages->wrap_base.? And, instead of allocating
>>>>> (2^n)+1 pages you allocate (2^n)+2 pages, why so.?
>>>>> wrap_base points to (2^n)+2 pages and base points to
>>>>> (2^n)+1 pages, what is use of wrap_base.? I tried reading
>>>>> perf source too, there it seems they use (2^n)+1 pages only.
>>>>>
>>>>>
>>>>> Thanks
>>>>> Regards
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
