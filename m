From: "Maucci, Cyrille" <cyrille.maucci@hp.com>
Subject: RE: perf for analyzing userspace contention
Date: Fri, 14 Oct 2011 07:58:42 +0100
Message-ID: <0E02F16954AF394BB163AEE50FDF5485690C6533A3@GVW1121EXC.americas.hpqcorp.net>
References: <CAG4TOxPowPUbmZBL41MNJjPYKymTNFW3JMAgEf35u1k2BFgbwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from g4t0016.houston.hp.com ([15.201.24.19]:15762 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab1JNGz5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 14 Oct 2011 02:55:57 -0400
In-Reply-To: <CAG4TOxPowPUbmZBL41MNJjPYKymTNFW3JMAgEf35u1k2BFgbwA@mail.gmail.com>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Roland Dreier <roland@kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

So are those mutexes acquired/released from different call sites or from one single generic function of yours like LOCK/UNLOCK and the mutex is passed as a param?

If from different call paths, I'd say perf is ok for you to troubleshoot.
If from one single generic call paths, I don't know if perf already has the same capability that HP Caliper has on HPUX to provide a breakdown.

++Cyrille

-----Original Message-----
From: linux-perf-users-owner@vger.kernel.org [mailto:linux-perf-users-owner@vger.kernel.org] On Behalf Of Roland Dreier
Sent: Friday, October 14, 2011 8:36 AM
To: linux-perf-users@vger.kernel.org
Subject: perf for analyzing userspace contention

Hi everyone,

Hope this question from a kernel hacker about profiling userspace isn't too dumb...

Anyway, suppose I have a multithreaded userspace app that uses a bunch of pthread_mutexes, and I want to figure out which locks are hot and/or heavily contended.  What's the best way to do that?  Is perf the right, or is there something better?  (This seems like such an obvious thing to want that there must be some good way to get this data, I hope)

Thanks!
  Roland
--
To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
