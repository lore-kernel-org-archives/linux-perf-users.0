From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: perf-probe: issue with latest fedora kernel
Date: Mon, 13 Dec 2010 23:04:36 +0900
Message-ID: <4D0627F4.1030605@hitachi.com>
References: <m2pqtb9ekn.fsf@gmail.com>	<20101209153548.GA11820@ghostprotocols.net> <m2wrnernw3.fsf@gmail.com>	<20101213125837.GB5407@ghostprotocols.net> <m2sjy1stuf.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42]:44413 "EHLO
	mail7.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932086Ab0LMOEm (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 13 Dec 2010 09:04:42 -0500
In-Reply-To: <m2sjy1stuf.fsf@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, linux-perf-users@vger.kernel.org, 2nddept-manager@sdl.hitachi.co.jp

(2010/12/13 22:08), Francis Moreau wrote:
> Arnaldo Carvalho de Melo <acme@ghostprotocols.net> writes:
> 
>> Em Mon, Dec 13, 2010 at 11:02:52AM +0100, Francis Moreau escreveu:
>>> Arnaldo Carvalho de Melo <acme@ghostprotocols.net> writes:
>>>> Em Thu, Dec 09, 2010 at 04:00:08PM +0100, Francis Moreau escreveu:
>>>>> I'm trying to use perf-probe(1) with the latest F14 kernel
>>>>> (2.6.35.9-64.fc14.x86_64).
>>
>>>>> I also installed kernel-debug-debuginfo-2.6.35.9-64.fc14.x86_64 which
>>>>> contains the running vmlinux image AFAICT.
>>
>>>> Can you try using:
>>
>>>> $ perf probe -k /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux <rest of the probe definition>
>>
>>>> So that it tries it directly instead of looking into the buildid cache?
>>
>>> Does anybody know where I can report this issue to Fedora community ?
>>
>> Please create a ticket at:
>>
>> http://bugzilla.redhat.com
>>
>> More specifically:
>>
>> https://bugzilla.redhat.com/enter_bug.cgi?product=Fedora
>>
>> Mention this changeset:
>>
>> http://git.kernel.org/?p=linux/kernel/git/acme/linux-2.6.git;a=commit;h=34d2ea084a3bce03d73ffe64350db2813f07260c
>>
>> It will make the -k argument work.
>>
>> There is another that will look automatically at this location, but I
>> haven't merged yet, will post here when done.
> 
> Hmm, I don't think that any patches recently posted in response of this
> thread will solve the problem.

I agree with you.

> The primarily concern here, is that the running kernel has a different
> build-id than the debug image installed by the corresponding debug
> package.
> 
> I think it's a distrib issue, hence my question about Fedora report.

Yes, that is just for fedora people who can easily check
how to reproduce and make sure the problem is here.
Then they can try to solve the problem until the issue
is resolved.

Thank you,



-- 
Masami HIRAMATSU
2nd Dept. Linux Technology Center
Hitachi, Ltd., Systems Development Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
