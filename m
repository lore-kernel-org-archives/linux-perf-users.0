From: David Ahern <dsahern@gmail.com>
Subject: Re: Perf record premature termination
Date: Tue, 12 Feb 2013 10:16:21 -0700
Message-ID: <511A78E5.8000909@gmail.com>
References: <1360608612.17632.193.camel@schen9-DESK>  <511947CB.5010600@gmail.com> <1360620940.17632.194.camel@schen9-DESK>  <51197120.7030207@gmail.com> <1360688851.17632.195.camel@schen9-DESK>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:38383 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932915Ab3BLRQ0 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 12 Feb 2013 12:16:26 -0500
Received: by mail-pa0-f53.google.com with SMTP id bg4so189992pad.40
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Feb 2013 09:16:25 -0800 (PST)
In-Reply-To: <1360688851.17632.195.camel@schen9-DESK>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org, ak <ak@linux.intel.com>

On 2/12/13 10:07 AM, Tim Chen wrote:
> On Mon, 2013-02-11 at 15:30 -0700, David Ahern wrote:
>> On 2/11/13 3:15 PM, Tim Chen wrote:
>>> On Mon, 2013-02-11 at 12:34 -0700, David Ahern wrote:
>>>> On 2/11/13 11:50 AM, Tim Chen wrote:
>>>>> David,
>>>>>
>>>>> When I am doing a profiling of kernel compile with 32 threads on a 4
>>>>> socket westmere machine, I found that perf record terminated right away
>>>>> for the version of perf in 3.7 kernel source tree.
>>>>> There's no profile data recroded and the compile is running in
>>>>> background.
>>>>>
>>>>> $ make -j32 &
>>>>> then
>>>>> $ sudo /test/perf record -a -g -f sleep 5
>>>>> sleep: Terminated
>>
>> This is the more appropriate fix. Make mmap consistent with comm. Revert
>> the other one.
>
> Thanks.  Works for me.
>
> Tim
>

BTW, this does not seem to be a problem with 3.8 - at least I could not 
reproduce it. So it seems limited to 3.7 kernels only.

David
