From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Sampling hardware counter values with timers
Date: Fri, 13 May 2016 06:40:41 -0700
Message-ID: <87vb2ikrdy.fsf@tassilo.jf.intel.com>
References: <CAEoGj_-43BRwknevsRtZWpwLuF5sh=mYs5J36swowB17FwkWxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36727 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104AbcEMNkv (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 13 May 2016 09:40:51 -0400
In-Reply-To: <CAEoGj_-43BRwknevsRtZWpwLuF5sh=mYs5J36swowB17FwkWxg@mail.gmail.com>
	(Keno Fischer's message of "Fri, 13 May 2016 00:00:16 -0400")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Keno Fischer <kfischer@college.harvard.edu>
Cc: linux-perf-users@vger.kernel.org

Keno Fischer <kfischer@college.harvard.edu> writes:

> Hello everyone,
>
> I was wondering if it is possible (either using the `perf` user space
> tool or using the perf_events API) to periodically sample the value of
> a hardware counter (in my particular case I'd like to sample the
> retired-branch-counter). I know it is possible to do the opposite
> (i.e. sample a timestamp every specified number of branches), but I
> wasn't able to see an easy way to sample the hardware counter at a
> specified frequency. Is this possible?

perf record works this way by default. The counter period is dynamically
adjusted for a given frequency. The default frequency is 1000.
You can set it with -F.

Another alternative is to use perf stat -I ... if you only need the counts.

-Andi
