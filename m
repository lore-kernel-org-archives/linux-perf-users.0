From: Keno Fischer <kfischer@college.harvard.edu>
Subject: Re: Sampling hardware counter values with timers
Date: Fri, 13 May 2016 10:44:14 -0400
Message-ID: <CAEoGj_-0GEadeBKQjBmMXiQmAp1839WqkLqDcnJmkB_LEOO3Qg@mail.gmail.com>
References: <CAEoGj_-43BRwknevsRtZWpwLuF5sh=mYs5J36swowB17FwkWxg@mail.gmail.com>
 <87vb2ikrdy.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33745 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbcEMOoe (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 13 May 2016 10:44:34 -0400
Received: by mail-oi0-f54.google.com with SMTP id v145so173453535oie.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 May 2016 07:44:34 -0700 (PDT)
In-Reply-To: <87vb2ikrdy.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

Hi Andi,

Thanks. I know that perf sample works this way, but I didn't think it
was possible to have it sample a specified counter. Is it? `perf stat
-I` looks exactly like what I need, but it looks like the maximum
frequency is 10Hz. I was hoping for a higher frequency (& ideally
something that
doesn't require switching back into user space and calling `read`).

Thanks,
Keno

On Fri, May 13, 2016 at 9:40 AM, Andi Kleen <andi@firstfloor.org> wrote:
> Keno Fischer <kfischer@college.harvard.edu> writes:
>
>> Hello everyone,
>>
>> I was wondering if it is possible (either using the `perf` user space
>> tool or using the perf_events API) to periodically sample the value of
>> a hardware counter (in my particular case I'd like to sample the
>> retired-branch-counter). I know it is possible to do the opposite
>> (i.e. sample a timestamp every specified number of branches), but I
>> wasn't able to see an easy way to sample the hardware counter at a
>> specified frequency. Is this possible?
>
> perf record works this way by default. The counter period is dynamically
> adjusted for a given frequency. The default frequency is 1000.
> You can set it with -F.
>
> Another alternative is to use perf stat -I ... if you only need the counts.
>
> -Andi
