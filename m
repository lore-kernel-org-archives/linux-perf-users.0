From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: perf-probe: issue with latest fedora kernel
Date: Fri, 10 Dec 2010 12:27:59 +0900
Message-ID: <4D019E3F.4040902@hitachi.com>
References: <m2pqtb9ekn.fsf@gmail.com>	<20101209153548.GA11820@ghostprotocols.net> <m2k4jiewhi.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mailx.hitachi.co.jp ([133.145.228.49]:46692 "EHLO
	mailx.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247Ab0LJDaR (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 9 Dec 2010 22:30:17 -0500
In-Reply-To: <m2k4jiewhi.fsf@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, linux-perf-users@vger.kernel.org, 2nddept-manager@sdl.hitachi.co.jp

(2010/12/10 1:34), Francis Moreau wrote:
> Arnaldo Carvalho de Melo <acme@ghostprotocols.net> writes:
> 
>> Em Thu, Dec 09, 2010 at 04:00:08PM +0100, Francis Moreau escreveu:
>>> I'm trying to use perf-probe(1) with the latest F14 kernel
>>> (2.6.35.9-64.fc14.x86_64).
>>>
>>
>>> I also installed kernel-debug-debuginfo-2.6.35.9-64.fc14.x86_64 which
>>> contains the running vmlinux image AFAICT.
>>>
>>> I added it to the buildid cache:
>>>
>>> $ perf buildid-cache -v -a /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux
>>> Adding 4d89e23415d8ab491cfc8ef8aa67764b91cc6787 /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux: OK
>>>
>>> But when running perf-probe(1) like the following:
>>>
>>>   $ perf probe schedule cpu
>>>   Failed to find path of kernel moduleFailed to open debuginfo file.
>>>   Error: Failed to add events. (-2)
>>>
>>> it fails.
>>>
>>> One strange thing is that when perf read the running kernel build id, it
>>> get: 882b1b53eb1d65320e8fa710273aa8493896c4.
>>>
>>> Could anybody tell me what I'm doing wrong ?
>>
>> Can you try using:
>>
>> $ perf probe -k /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux <rest of the probe definition>
>>
>> So that it tries it directly instead of looking into the buildid cache?
>>
> 
> Well that still fail:
> 
> $ perf probe -k /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux schedule cpu
> Failed to find path of kernel moduleFailed to open debuginfo file.
>   Error: Failed to add events. (-2)
> 
> but that's not really suprising if perf checks that the running kernel
> build-id is the same as the one in:
> /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux
> 
> It really looks like something is broken in the F14 kernel-debuginfo
> package.

Hmm, curious. I'll check it after setting up Fedora 14.
Thank you for reporting :-)


-- 
Masami HIRAMATSU
2nd Dept. Linux Technology Center
Hitachi, Ltd., Systems Development Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
