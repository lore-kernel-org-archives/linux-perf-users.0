From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: event group without multiplexing
Date: Thu, 12 Nov 2015 11:51:41 -0500 (EST)
Message-ID: <alpine.DEB.2.20.1511121148550.6382@vincent-weaver-1.umelst.maine.edu>
References: <CAJh9x3q+g4Q4WfZ8XZ9ZOw0BcgYd_hdoUufu2YpRGtZt2tfu5Q@mail.gmail.com> <CAJh9x3qCnvz4yWTBxyMp_RZt66L7OXHxbgTcfWaqFBfdZiGkLQ@mail.gmail.com> <CAJh9x3q1ZeJ7U2XFpP2PbaeJ4xtjNJ1K13fYQSjnZKiO2LjKWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37152 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbbKLQtw (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 Nov 2015 11:49:52 -0500
Received: by igbhv6 with SMTP id hv6so44653008igb.0
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2015 08:49:51 -0800 (PST)
In-Reply-To: <CAJh9x3q1ZeJ7U2XFpP2PbaeJ4xtjNJ1K13fYQSjnZKiO2LjKWQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Yuanfang Chen <cyfmxc@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Thu, 12 Nov 2015, Yuanfang Chen wrote:

> And the case can be reduced to
> 
> perf stat -e \{r1000248,r148\} -- sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>               7008      r1000248
>    <not supported>      r148

the kernel thinks that all events of type 0x48 (L1D_PEND_MISS) can only go 
into one of the counters, and thus you can't have multiple at the same 
time.

If this is a bug you'll need to report it to the perf_event developers.
I'd double check intel's documents to see what they actuall say about this 
class of events on your processor.

Vince
