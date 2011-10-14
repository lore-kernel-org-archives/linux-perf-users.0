From: David Ahern <dsahern@gmail.com>
Subject: Re: perf for analyzing userspace contention
Date: Fri, 14 Oct 2011 15:25:49 -0600
Message-ID: <4E98A8DD.6000201@gmail.com>
References: <CAG4TOxPowPUbmZBL41MNJjPYKymTNFW3JMAgEf35u1k2BFgbwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35184 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab1JNVZy (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 14 Oct 2011 17:25:54 -0400
Received: by yxp4 with SMTP id 4so1551705yxp.5
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Oct 2011 14:25:54 -0700 (PDT)
In-Reply-To: <CAG4TOxPowPUbmZBL41MNJjPYKymTNFW3JMAgEf35u1k2BFgbwA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Roland Dreier <roland@kernel.org>
Cc: linux-perf-users@vger.kernel.org



On 10/14/2011 12:36 AM, Roland Dreier wrote:
> Anyway, suppose I have a multithreaded userspace app that uses a bunch of
> pthread_mutexes, and I want to figure out which locks are hot and/or heavily
> contended.  What's the best way to do that?  Is perf the right, or is there
> something better?  (This seems like such an obvious thing to want that there
> must be some good way to get this data, I hope)

You can capture futex entry and exit with:

perf trace -e syscalls:sys_enter_futex -e syscalls:sys_exit_futex

add -g to get the callchains. From there perf-script will dump the events.

David
