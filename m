From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: perf-probe: issue with latest fedora kernel
Date: Mon, 13 Dec 2010 20:32:54 +0100
Message-ID: <m239q1sc2h.fsf@gmail.com>
References: <m2pqtb9ekn.fsf@gmail.com>
	<20101209153548.GA11820@ghostprotocols.net> <m2wrnernw3.fsf@gmail.com>
	<20101213125837.GB5407@ghostprotocols.net> <m2sjy1stuf.fsf@gmail.com>
	<20101213142159.GF5407@ghostprotocols.net> <m2fwu1so6j.fsf@gmail.com>
	<20101213164009.GJ5407@ghostprotocols.net> <m2bp4psd7r.fsf@gmail.com>
	<20101213191736.GB7984@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34869 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739Ab0LMTc7 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 13 Dec 2010 14:32:59 -0500
Received: by wwa36 with SMTP id 36so6687636wwa.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Dec 2010 11:32:58 -0800 (PST)
In-Reply-To: <20101213191736.GB7984@ghostprotocols.net> (Arnaldo Carvalho de
	Melo's message of "Mon, 13 Dec 2010 17:17:36 -0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: linux-perf-users@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Arnaldo Carvalho de Melo <acme@ghostprotocols.net> writes:

> Em Mon, Dec 13, 2010 at 08:08:08PM +0100, Francis Moreau escreveu:
>> Arnaldo Carvalho de Melo <acme@ghostprotocols.net> writes:
>> 
>> > Em Mon, Dec 13, 2010 at 04:11:16PM +0100, Francis Moreau escreveu:
>
>> >> But as I said, there's no matching build-id. I understand that -k is
>> >> currently broken but suppose that it works, which vmlinux should I use
>> >> then ?
>
>> >> $ rpm -qa | grep kernel
>> >> kernel-debuginfo-common-x86_64-2.6.35.9-64.fc14.x86_64
>> >> kernel-debug-debuginfo-2.6.35.9-64.fc14.x86_64
>> >> kernel-headers-2.6.35.6-48.fc14.x86_64
>> >> kernel-devel-2.6.35.9-64.fc14.x86_64
>> >> kernel-2.6.35.9-64.fc14.x86_64
>
>> > Bzzt, here is the problem: you're not using the right package,
>> > kernel-debug-debuginfo is for the kernel-debug package, a kernel built
>> > with lots of CONFIG_DEBUG_ options turned on, please install the right
>> > package, which is kernel-debuginfo-2.6.35.9-64.fc14.x86_64
>> 
>> Ah, that's it.
>
> Yeah, those package names are a bit confusing :-)
>
> Please let us know about any other problem you have using these tools,
> any feedback is _greatly_ appreciated.

Don't worry, I won't miss an opportunity.

Thanks
-- 
Francis
