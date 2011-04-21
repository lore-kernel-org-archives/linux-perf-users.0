From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: how to get a kernel callgraph starting from a syscall
Date: Thu, 21 Apr 2011 20:48:23 +0200
Message-ID: <BANLkTinvMLaL8vdDWiG5fDEEAXUNBsyrBQ@mail.gmail.com>
References: <BANLkTikNDX4hYpLjgDnPx8SXFvsv8Syr9g@mail.gmail.com>
	<4DB04BF3.8080206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:64291 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815Ab1DUSsY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 21 Apr 2011 14:48:24 -0400
Received: by pvg12 with SMTP id 12so9758pvg.19
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Apr 2011 11:48:23 -0700 (PDT)
In-Reply-To: <4DB04BF3.8080206@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Thu, Apr 21, 2011 at 5:23 PM, David Ahern <dsahern@gmail.com> wrote:
>
>
> On 04/21/11 01:46, Francis Moreau wrote:
>> Hello,
>>
>> Sorry if the question is dumb but I'm a bit lost about this.
>>
>> I know that ftrace exists but I think that perf can do this too: I
>> have a userspace application which is calling a libc C function (read)
>> which ends up doing a sys_read.
>>
>> For the sys_read, I'd like to see what's happening in the kernel by
>> displaying the call graph.
>>
>> Can perf do that ?
>
> Have you tried 'perf record -g'?
>

Well, I don't see how it can be done with perf record -g.

Let's say I'm interested to see the path taken in the kernel when a
process is calling sys_sleep:

  $ perf record -g sleep 1

Then I can use:

  $ perf report -g

But I don't see what I am asking for.

What am I missing ?

Thanks
-- 
Francis
