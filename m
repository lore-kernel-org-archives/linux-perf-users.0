From: sahil aggarwal <sahil.agg15@gmail.com>
Subject: Re: perf smapling
Date: Tue, 31 Mar 2015 20:52:17 +0530
Message-ID: <CAGAANTWToURnsEQ4YfYiw2e4y9g=54N+joKpHuO2i6vQV_wVBQ@mail.gmail.com>
References: <loom.20150329T075320-204@post.gmane.org>
	<CAL2Y34Bi+VLSvGucN8J=4RXKh785Lg9BYAa4LUU_yCMR7COTgQ@mail.gmail.com>
	<20150331111813.GA1152@ubuntu>
	<CAL2Y34A=Fk03_LSTM_SHwVaE4NaKSD=zZt0vWtzn3Rm9dQtDLQ@mail.gmail.com>
	<CAL2Y34CxT=YRGx6G0kcCWK0AVnaPdb4ybL+u-BiUE7gYg1jYGg@mail.gmail.com>
	<CAGAANTXoY_iVhSHf+dq2K0UEk1Vt=4pGA6ovHwSKmFr=-Xh7Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35803 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbbCaPWS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 31 Mar 2015 11:22:18 -0400
Received: by igcau2 with SMTP id au2so21525203igc.0
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2015 08:22:17 -0700 (PDT)
In-Reply-To: <CAGAANTXoY_iVhSHf+dq2K0UEk1Vt=4pGA6ovHwSKmFr=-Xh7Jg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Elazar Leibovich <elazar.leibovich@ravellosystems.com>
Cc: linux-perf-users@vger.kernel.org

Actually i need most of the sampling around PERF_TYPE_TRACEPOINT,
so if i enable tracepoint "syscalls/sys_enter_open/" what will be the "type"
field in perf_event_header.? And, the the record struct will be same as given
in "syscalls/sys_enter_open/format" .?

Thanks

On 31 March 2015 at 20:40, sahil aggarwal <sahil.agg15@gmail.com> wrote:
> Yeah that was clear enough.
> Thanks a lot. Your code is of great help.
>
> Regards
> Sahil
>
> On 31 March 2015 at 19:45, Elazar Leibovich
> <elazar.leibovich@ravellosystems.com> wrote:
>> I wanted to ensure the user always see contiguous array of data from
>> the ring buffer.
>>
>> The last piece of data, say "abcde" could wrap around in the ring
>> buffer and appear like:
>>
>> [de...                 ...abc]
>>
>> I wanted the user to see a contigious array of the form [abcde].
>>
>> So in the case I'm having input that wrap around, I'll simply copy it
>> to the first buffer
>>
>> [wrap_buffer][de..                 ...abc]
>> would become
>> [               abc][de...               ...abc]
>>
>> And then I'll the user pointer to the leftmost "a", and he'll see
>> "abcde" without knowing he's handling a ring buffer.
>>
>> Let me know if I was clear enough.
>>
>> On Tue, Mar 31, 2015 at 2:18 PM, sahil aggarwal <sahil.agg15@gmail.com> wrote:
>>>
>>> Hi Elazar
>>>
>>> Can you help me understand why you have used
>>> mmap_pages->wrap_base.? And, instead of allocating
>>> (2^n)+1 pages you allocate (2^n)+2 pages, why so.?
>>> wrap_base points to (2^n)+2 pages and base points to
>>> (2^n)+1 pages, what is use of wrap_base.? I tried reading
>>> perf source too, there it seems they use (2^n)+1 pages only.
>>>
>>>
>>> Thanks
>>> Regards
