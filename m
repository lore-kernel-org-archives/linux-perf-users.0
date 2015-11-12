From: Yuanfang Chen <cyfmxc@gmail.com>
Subject: Re: event group without multiplexing
Date: Thu, 12 Nov 2015 10:02:08 -0500
Message-ID: <CAJh9x3q1ZeJ7U2XFpP2PbaeJ4xtjNJ1K13fYQSjnZKiO2LjKWQ@mail.gmail.com>
References: <CAJh9x3q+g4Q4WfZ8XZ9ZOw0BcgYd_hdoUufu2YpRGtZt2tfu5Q@mail.gmail.com>
	<CAJh9x3qCnvz4yWTBxyMp_RZt66L7OXHxbgTcfWaqFBfdZiGkLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37431 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519AbbKLPCL (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 Nov 2015 10:02:11 -0500
Received: by wmww144 with SMTP id w144so92289476wmw.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2015 07:02:10 -0800 (PST)
In-Reply-To: <CAJh9x3qCnvz4yWTBxyMp_RZt66L7OXHxbgTcfWaqFBfdZiGkLQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

And the case can be reduced to

perf stat -e \{r1000248,r148\} -- sleep 1

 Performance counter stats for 'sleep 1':

              7008      r1000248
   <not supported>      r148

       1.001885804 seconds time elapsed

On Thu, Nov 12, 2015 at 9:58 AM, Yuanfang Chen <cyfmxc@gmail.com> wrote:
> Sorry, r1000248 on haswell should be
>
> L1D_PEND_MISS.FB_FULL     0,1,2,3       0,1,2,3,4,5,6,7
>
> On Wed, Nov 11, 2015 at 5:05 PM, Yuanfang Chen <cyfmxc@gmail.com> wrote:
>> Hello
>>
>> I am using a haswell box. (E3-1231 v3). HT enabled.
>>
>> perf stat -e \{cycles,r148,r1000248,r8d1,r40d1\} -- sleep 1
>>
>> with ubuntu version of perf
>>
>> Performance counter stats for 'sleep 1':
>>
>>             756066      cycles
>>               5740      r1000248
>>               5516      r8d1
>>               9064      r40d1
>>                  0        r148
>>
>>        1.001770249 seconds time elapsed
>>
>> with relatively new tip of perf/core:
>>
>>  Performance counter stats for 'sleep 1':
>>
>>             729403      cycles
>>               7250      r1000248
>>               5628      r8d1
>>               9273      r40d1
>>    <not supported>      r148
>>
>>        1.001674174 seconds time elapsed
>>
>> from https://download.01.org/perfmon/HSW/
>>                                                          SMT on
>>           SMT off
>> cpu_clk_unhalted.thread cycles           Fixed counter 2      Fixed counter 2
>> ld_blocks.no_sr    r803                        0,1,2,3
>>  0,1,2,3,4,5,6,7
>> mem_load_uops_retired.l1_miss r8d1   0,1,2,3                  0,1,2,3
>> mem_load_uops_retired.hit_lfb r40d1    0,1,2,3                  0,1,2,3
>> l1d_pend_miss.pending r148                2                          2
>>
>> Seems these five events couldn't be counting at the same time,
>> although in terms of hardware they should get along.  Is this a bug or
>> a limitation I should be aware of? Thank you so much.
>>
>> Yuanfang
