From: Roland Dreier <roland@kernel.org>
Subject: Re: perf for analyzing userspace contention
Date: Fri, 14 Oct 2011 00:21:06 -0700
Message-ID: <CAG4TOxPYjOxojTAti7gxrPJinKkGJXTMvAYoeD5MkgQFqVmgLw@mail.gmail.com>
References: <CAG4TOxPowPUbmZBL41MNJjPYKymTNFW3JMAgEf35u1k2BFgbwA@mail.gmail.com>
 <0E02F16954AF394BB163AEE50FDF5485690C6533A3@GVW1121EXC.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34230 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab1JNHV1 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 14 Oct 2011 03:21:27 -0400
Received: by eye27 with SMTP id 27so838562eye.19
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Oct 2011 00:21:26 -0700 (PDT)
In-Reply-To: <0E02F16954AF394BB163AEE50FDF5485690C6533A3@GVW1121EXC.americas.hpqcorp.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Maucci, Cyrille" <cyrille.maucci@hp.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Thu, Oct 13, 2011 at 11:58 PM, Maucci, Cyrille <cyrille.maucci@hp.com> wrote:
> So are those mutexes acquired/released from different call sites or from one single generic function of yours like LOCK/UNLOCK and the mutex is passed as a param?

I have lots of code paths taking lots of different classes of locks.

My problem is I don't know what to ask perf for to see if I have a mutex that
is heavily contended, and so some threads are spending a lot of time asleep
waiting to acquire it.  As I said, this is probably pretty basic
stuff, but I'm not
usually much of a userspace guy...

Thanks,
  Roland
