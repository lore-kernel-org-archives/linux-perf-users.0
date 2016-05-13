From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Sampling hardware counter values with timers
Date: Fri, 13 May 2016 13:42:52 -0400 (EDT)
Message-ID: <alpine.DEB.2.20.1605131341350.19648@macbook-air>
References: <CAEoGj_-43BRwknevsRtZWpwLuF5sh=mYs5J36swowB17FwkWxg@mail.gmail.com> <87vb2ikrdy.fsf@tassilo.jf.intel.com> <CAEoGj_-0GEadeBKQjBmMXiQmAp1839WqkLqDcnJmkB_LEOO3Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:35568 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbcEMRnC (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 13 May 2016 13:43:02 -0400
Received: by mail-io0-f179.google.com with SMTP id d62so141705612iof.2
        for <linux-perf-users@vger.kernel.org>; Fri, 13 May 2016 10:43:02 -0700 (PDT)
In-Reply-To: <CAEoGj_-0GEadeBKQjBmMXiQmAp1839WqkLqDcnJmkB_LEOO3Qg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Keno Fischer <kfischer@college.harvard.edu>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

On Fri, 13 May 2016, Keno Fischer wrote:

> Thanks. I know that perf sample works this way, but I didn't think it
> was possible to have it sample a specified counter. Is it? `perf stat
> -I` looks exactly like what I need, but it looks like the maximum
> frequency is 10Hz. I was hoping for a higher frequency (& ideally
> something that
> doesn't require switching back into user space and calling `read`).

you can easily hack perf -I to sample faster than 10Hz, but if you sample 
much more often than that you're going to start ending up with a lot of 
perf_event measurement overhead in your data.

Vince
