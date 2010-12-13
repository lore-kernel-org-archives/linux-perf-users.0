From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: perf-probe: issue with latest fedora kernel
Date: Mon, 13 Dec 2010 16:11:16 +0100
Message-ID: <m2fwu1so6j.fsf@gmail.com>
References: <m2pqtb9ekn.fsf@gmail.com>
	<20101209153548.GA11820@ghostprotocols.net> <m2wrnernw3.fsf@gmail.com>
	<20101213125837.GB5407@ghostprotocols.net> <m2sjy1stuf.fsf@gmail.com>
	<20101213142159.GF5407@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56060 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758011Ab0LMPLX (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 13 Dec 2010 10:11:23 -0500
Received: by wwa36 with SMTP id 36so6420127wwa.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Dec 2010 07:11:21 -0800 (PST)
In-Reply-To: <20101213142159.GF5407@ghostprotocols.net> (Arnaldo Carvalho de
	Melo's message of "Mon, 13 Dec 2010 12:21:59 -0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: linux-perf-users@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Arnaldo Carvalho de Melo <acme@ghostprotocols.net> writes:

> Em Mon, Dec 13, 2010 at 02:08:56PM +0100, Francis Moreau escreveu:
>> Arnaldo Carvalho de Melo <acme@ghostprotocols.net> writes:
>> > Em Mon, Dec 13, 2010 at 11:02:52AM +0100, Francis Moreau escreveu:
>> >> Arnaldo Carvalho de Melo <acme@ghostprotocols.net> writes:
>
>> >> > Em Thu, Dec 09, 2010 at 04:00:08PM +0100, Francis Moreau escreveu:
>> >> >> I'm trying to use perf-probe(1) with the latest F14 kernel
>> >> >> (2.6.35.9-64.fc14.x86_64).
>> >> >> I also installed kernel-debug-debuginfo-2.6.35.9-64.fc14.x86_64 which
>> >> >> contains the running vmlinux image AFAICT.
>> >> > Can you try using:
>
>> >> > $ perf probe -k /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux <rest of the probe definition>
>
>> >> > So that it tries it directly instead of looking into the buildid cache?
>
>> >> Does anybody know where I can report this issue to Fedora community ?
>
>> > Please create a ticket at:
>
>> > http://bugzilla.redhat.com
>
>> Hmm, I don't think that any patches recently posted in response of this
>> thread will solve the problem.
>> 
>> The primarily concern here, is that the running kernel has a different
>> build-id than the debug image installed by the corresponding debug
>> package.
>
> So? The problem for me is that:
>
> 1. looks at /sys/kernel/notes and gets the running kernel build-id
> 2. fails to locate a vmlinux with a matching build-id
> 3. ignores the -k specified path
> 4. The mentioned patch makes it consider the -k specified path
>
> So it should look at the -k specified path and make sure that it has a
> matching build-id, if it has, problem solved, no?

But as I said, there's no matching build-id. I understand that -k is
currently broken but suppose that it works, which vmlinux should I use
then ?

$ rpm -qa | grep kernel
kernel-debuginfo-common-x86_64-2.6.35.9-64.fc14.x86_64
kernel-debug-debuginfo-2.6.35.9-64.fc14.x86_64
kernel-headers-2.6.35.6-48.fc14.x86_64
kernel-devel-2.6.35.9-64.fc14.x86_64
kernel-2.6.35.9-64.fc14.x86_64

$ rpm -ql kernel-debug-debuginfo-2.6.35.9-64.fc14.x86_64 | grep vmlinux
/usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux

So the debug package installed the kernel image with debug info into

   /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug

directory. Please note that this path can't be found by perf without the
recent patches.

To check the build id of this image, I do:

$ perf buildid-cache -v -a /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux
Adding 4d89e23415d8ab491cfc8ef8aa67764b91cc6787 ...

This is the only way I know to dump the debug id of an object.

The buildid of the running kernel:

$ perf buildid-list
882b1b53eb1d653200e8fa7100273aa8493896c4 [kernel.kallsyms]

So they both don't match.

>
>  
>> I think it's a distrib issue, hence my question about Fedora report.
>
> Well, here I have fedora 14 and:

[...]

>
> All this with:
>
> [root@felicio linux-2.6.35.x86_64]# type perf
> perf is hashed (/usr/bin/perf)
> [root@felicio linux-2.6.35.x86_64]# rpm -qf /usr/bin/perf
> perf-2.6.35.9-64.fc14.x86_64
> [root@felicio linux-2.6.35.x86_64]# 
>
> I.e. the perf binary shipping in fedora, without the recent patches.

In that case how perf can find the right vmlinux in your system since it
needs to be patched to find the vmlinux image in the
/usr/lib/debug/lib/modules/%s.debug directory ?

>
>
> To finish the session:
>

[...]

>
> And...
>
> [root@felicio linux-2.6.35.x86_64]# perf buildid-list
> 882b1b53eb1d653200e8fa7100273aa8493896c4 [kernel.kallsyms]
>
> This is the build-id of the running kernel, and:
>
> [root@felicio linux-2.6.35.x86_64]# perf buildid-cache -v --add /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64/vmlinux
> Adding 882b1b53eb1d653200e8fa7100273aa8493896c4 /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64/vmlinux: FAIL
> /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64/vmlinux already in the cache

Ah, that's interesting...

In the path you're using, you loose the '.debug', therefore this image
doesn't seem to belong to kernel-debug-debuginfo-2.6.35.9-64.fc14.x86_64.

And that explains how perf can find the debug kernel image.

-- 
Francis
