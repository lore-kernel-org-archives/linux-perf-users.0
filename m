From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: perf-probe: issue with latest fedora kernel
Date: Mon, 13 Dec 2010 10:58:37 -0200
Message-ID: <20101213125837.GB5407@ghostprotocols.net>
References: <m2pqtb9ekn.fsf@gmail.com>
 <20101209153548.GA11820@ghostprotocols.net>
 <m2wrnernw3.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:64167 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757384Ab0LMM6o (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 13 Dec 2010 07:58:44 -0500
Received: by ywl5 with SMTP id 5so3228295ywl.19
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Dec 2010 04:58:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m2wrnernw3.fsf@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Em Mon, Dec 13, 2010 at 11:02:52AM +0100, Francis Moreau escreveu:
> Arnaldo Carvalho de Melo <acme@ghostprotocols.net> writes:
> > Em Thu, Dec 09, 2010 at 04:00:08PM +0100, Francis Moreau escreveu:
> >> I'm trying to use perf-probe(1) with the latest F14 kernel
> >> (2.6.35.9-64.fc14.x86_64).

> >> I also installed kernel-debug-debuginfo-2.6.35.9-64.fc14.x86_64 which
> >> contains the running vmlinux image AFAICT.

> > Can you try using:

> > $ perf probe -k /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux <rest of the probe definition>

> > So that it tries it directly instead of looking into the buildid cache?

> Does anybody know where I can report this issue to Fedora community ?

Please create a ticket at:

http://bugzilla.redhat.com

More specifically:

https://bugzilla.redhat.com/enter_bug.cgi?product=Fedora

Mention this changeset:

http://git.kernel.org/?p=linux/kernel/git/acme/linux-2.6.git;a=commit;h=34d2ea084a3bce03d73ffe64350db2813f07260c

It will make the -k argument work.

There is another that will look automatically at this location, but I
haven't merged yet, will post here when done.

- Arnaldo
