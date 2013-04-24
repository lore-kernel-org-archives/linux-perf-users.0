From: David Ahern <dsahern@gmail.com>
Subject: Re: perf script timestamp
Date: Wed, 24 Apr 2013 07:10:48 -0600
Message-ID: <5177D9D8.4060209@gmail.com>
References: <201304241622032855179@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:51497 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491Ab3DXNKy (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 24 Apr 2013 09:10:54 -0400
Received: by mail-pb0-f51.google.com with SMTP id rr4so449798pbb.38
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Apr 2013 06:10:53 -0700 (PDT)
In-Reply-To: <201304241622032855179@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: OSDepend <osdepend@gmail.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

On 4/24/13 2:22 AM, OSDepend wrote:
> Hi guys,
> I just try to use perf script, and get some thing like below:
>              java 15893 [015] 96380.588871: timer_cancel: timer=0xffff8804379d6698
>              java 15721 [010] 96380.588872: timer_cancel: timer=0xffff8800be3d6698
>              java 15893 [015] 96380.588875: timer_expire_entry: timer=0xffff8804379d6698 function=delayed_work_timer_fn now=4391194790
>              java 15721 [010] 96380.588876: timer_expire_entry: timer=0xffff8800be3d6698 function=delayed_work_timer_fn now=4391194790
>
> I want to know exactly about the time units of the events, such as 96380.588871, and 96380.588872.
> The number befor "." is second or millisecond? and  Is the number after "." nanoseconds or microseconds?
> I'm a little confused about the documation for ktime_t, please help me out!

times are <seconds>.<microseconds>

David
