From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: perf-probe: issue with latest fedora kernel
Date: Mon, 13 Dec 2010 11:02:52 +0100
Message-ID: <m2wrnernw3.fsf@gmail.com>
References: <m2pqtb9ekn.fsf@gmail.com>
	<20101209153548.GA11820@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33524 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756810Ab0LMKC7 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 13 Dec 2010 05:02:59 -0500
Received: by wwa36 with SMTP id 36so6121246wwa.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Dec 2010 02:02:58 -0800 (PST)
In-Reply-To: <20101209153548.GA11820@ghostprotocols.net> (Arnaldo Carvalho de
	Melo's message of "Thu, 9 Dec 2010 13:35:48 -0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: linux-perf-users@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Hi,

Arnaldo Carvalho de Melo <acme@ghostprotocols.net> writes:

> Em Thu, Dec 09, 2010 at 04:00:08PM +0100, Francis Moreau escreveu:
>> I'm trying to use perf-probe(1) with the latest F14 kernel
>> (2.6.35.9-64.fc14.x86_64).
>> 
>
>> I also installed kernel-debug-debuginfo-2.6.35.9-64.fc14.x86_64 which
>> contains the running vmlinux image AFAICT.
>> 
>> I added it to the buildid cache:
>> 
>> $ perf buildid-cache -v -a /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux
>> Adding 4d89e23415d8ab491cfc8ef8aa67764b91cc6787 /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux: OK
>> 
>> But when running perf-probe(1) like the following:
>> 
>>   $ perf probe schedule cpu
>>   Failed to find path of kernel moduleFailed to open debuginfo file.
>>   Error: Failed to add events. (-2)
>> 
>> it fails.
>> 
>> One strange thing is that when perf read the running kernel build id, it
>> get: 882b1b53eb1d65320e8fa710273aa8493896c4.
>> 
>> Could anybody tell me what I'm doing wrong ?
>
> Can you try using:
>
> $ perf probe -k /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux <rest of the probe definition>
>
> So that it tries it directly instead of looking into the buildid cache?
>
> I'll check if perf probe actually looks in the buildid cache, till then,
> please try specifying it directly,

Does anybody know where I can report this issue to Fedora community ?

-- 
Francis
