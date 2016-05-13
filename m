From: Keno Fischer <kfischer@college.harvard.edu>
Subject: Re: Sampling hardware counter values with timers
Date: Fri, 13 May 2016 14:26:29 -0400
Message-ID: <CAEoGj_-jjfVt7gcAu4nyF+o8wgad+Ap93ouU9aSS3Fte-GtMjg@mail.gmail.com>
References: <CAEoGj_-43BRwknevsRtZWpwLuF5sh=mYs5J36swowB17FwkWxg@mail.gmail.com>
 <87vb2ikrdy.fsf@tassilo.jf.intel.com> <CAEoGj_-0GEadeBKQjBmMXiQmAp1839WqkLqDcnJmkB_LEOO3Qg@mail.gmail.com>
 <alpine.DEB.2.20.1605131341350.19648@macbook-air>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36609 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbcEMS0u (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 13 May 2016 14:26:50 -0400
Received: by mail-oi0-f66.google.com with SMTP id i2so18873890oib.3
        for <linux-perf-users@vger.kernel.org>; Fri, 13 May 2016 11:26:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605131341350.19648@macbook-air>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

Thanks Vince,

I figured I could do something like that, but I was indeed concerned
about the performance overhead, esp. since it seems like the way I'd
have to structure it is to have a user space timer interrupt which
then `read`s the perf counter. Since perf can sample e.g. the ip at
sufficiently high frequencies, I was hoping there was some mechanism
that would allow me to do the same for the retired branch counter.

For some background to this question, I'm hoping to use this in
combination with mozilla's record/replay framework (BTW, your work
on deterministic perf counters has come in super handy several times
here, Vince). rr identifies program points by combinations of
(retired-branch-counter, ip), so I was hoping to be able to correlate
those program points with actual time elapsed.

Keno

On Fri, May 13, 2016 at 1:42 PM, Vince Weaver <vincent.weaver@maine.edu> wrote:
> On Fri, 13 May 2016, Keno Fischer wrote:
>
>> Thanks. I know that perf sample works this way, but I didn't think it
>> was possible to have it sample a specified counter. Is it? `perf stat
>> -I` looks exactly like what I need, but it looks like the maximum
>> frequency is 10Hz. I was hoping for a higher frequency (& ideally
>> something that
>> doesn't require switching back into user space and calling `read`).
>
> you can easily hack perf -I to sample faster than 10Hz, but if you sample
> much more often than that you're going to start ending up with a lot of
> perf_event measurement overhead in your data.
>
> Vince
