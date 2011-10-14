From: "Maucci, Cyrille" <cyrille.maucci@hp.com>
Subject: RE: perf for analyzing userspace contention
Date: Fri, 14 Oct 2011 08:33:12 +0100
Message-ID: <0E02F16954AF394BB163AEE50FDF5485690C6533EB@GVW1121EXC.americas.hpqcorp.net>
References: <CAG4TOxPowPUbmZBL41MNJjPYKymTNFW3JMAgEf35u1k2BFgbwA@mail.gmail.com>
 <0E02F16954AF394BB163AEE50FDF5485690C6533A3@GVW1121EXC.americas.hpqcorp.net>
 <CAG4TOxPYjOxojTAti7gxrPJinKkGJXTMvAYoeD5MkgQFqVmgLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:11993 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab1JNHaN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 14 Oct 2011 03:30:13 -0400
In-Reply-To: <CAG4TOxPYjOxojTAti7gxrPJinKkGJXTMvAYoeD5MkgQFqVmgLw@mail.gmail.com>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Roland Dreier <roland@kernel.org>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

So I don't know posix mutexex implementation on linux but on HPUX they usually spin first then yield then spin again etc... Until sleep.
So tools like perf, reporting cpu consumption showing some mutexes path would reveal the pb.
On HPUX, posix mutexes spin/yield/sleep can be tuned through env variables.
If this is the same for Linux, you could temporarily set the # of spins to a very high value, to 'emphasize' the hotness of the contention through CPU usage and therefore something 'perf' was meant for since day1.

++Cyrille

-----Original Message-----
From: roland.dreier@gmail.com [mailto:roland.dreier@gmail.com] On Behalf Of Roland Dreier
Sent: Friday, October 14, 2011 9:21 AM
To: Maucci, Cyrille
Cc: linux-perf-users@vger.kernel.org
Subject: Re: perf for analyzing userspace contention

On Thu, Oct 13, 2011 at 11:58 PM, Maucci, Cyrille <cyrille.maucci@hp.com> wrote:
> So are those mutexes acquired/released from different call sites or from one single generic function of yours like LOCK/UNLOCK and the mutex is passed as a param?

I have lots of code paths taking lots of different classes of locks.

My problem is I don't know what to ask perf for to see if I have a mutex that is heavily contended, and so some threads are spending a lot of time asleep waiting to acquire it.  As I said, this is probably pretty basic stuff, but I'm not usually much of a userspace guy...

Thanks,
  Roland
