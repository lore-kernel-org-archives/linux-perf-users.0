From: David Ahern <dsahern@gmail.com>
Subject: Re: how to get a kernel callgraph starting from a syscall
Date: Thu, 21 Apr 2011 18:47:11 -0600
Message-ID: <4DB0D00F.3040706@gmail.com>
References: <BANLkTikNDX4hYpLjgDnPx8SXFvsv8Syr9g@mail.gmail.com>	<4DB04BF3.8080206@gmail.com>	<BANLkTinvMLaL8vdDWiG5fDEEAXUNBsyrBQ@mail.gmail.com>	<4DB08A5B.3060706@gmail.com> <BANLkTimZA6YA07d8hNKuxhoySvHpTmWjvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43651 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960Ab1DVArN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 21 Apr 2011 20:47:13 -0400
Received: by pzk9 with SMTP id 9so120406pzk.19
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Apr 2011 17:47:12 -0700 (PDT)
In-Reply-To: <BANLkTimZA6YA07d8hNKuxhoySvHpTmWjvw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On 04/21/11 14:07, Francis Moreau wrote:
> On Thu, Apr 21, 2011 at 9:49 PM, David Ahern <dsahern@gmail.com> wrote:
>>
>> You want the individual samples? if so, perf script dumps them and you
>> can see the callchain for each sys_read.
>>
> 
> hmm, I don't see what you mean by individual samples.
> 
> I don't think sampling can help in my case (tracing the callchain of
> one syscall).
> 
> Could you give me an example of what you have in mind ?
> 
> Thanks

I think I get it now. 'perf record' for syscall event stops at sys_read
as that is the point the event is generated. You want where the kernel
goes starting with sys_read. In that case you are limited to the
pre-existing tracepoints (see 'perf list -e tracepoints') to trigger an
event and back trace, or if the read causes the processes to block you
can you use the context-switch event or sched_switch trace point.

You could also insert probe points using perf probe. Lin Ming posted an
example of this a couple of weeks ago:
# ./perf probe -k ~/vmlinux -s ~/linux-2.6/  find_get_page
# ./perf record -e probe:find_get_page -f -g -a

David
