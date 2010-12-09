From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: perf-probe: issue with latest fedora kernel
Date: Thu, 9 Dec 2010 13:35:48 -0200
Message-ID: <20101209153548.GA11820@ghostprotocols.net>
References: <m2pqtb9ekn.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gx0-f180.google.com ([209.85.161.180]:52163 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab0LIPfy (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 9 Dec 2010 10:35:54 -0500
Received: by gxk19 with SMTP id 19so1487513gxk.11
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Dec 2010 07:35:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m2pqtb9ekn.fsf@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Em Thu, Dec 09, 2010 at 04:00:08PM +0100, Francis Moreau escreveu:
> I'm trying to use perf-probe(1) with the latest F14 kernel
> (2.6.35.9-64.fc14.x86_64).
> 
> I also installed kernel-debug-debuginfo-2.6.35.9-64.fc14.x86_64 which
> contains the running vmlinux image AFAICT.
> 
> I added it to the buildid cache:
> 
> $ perf buildid-cache -v -a /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux
> Adding 4d89e23415d8ab491cfc8ef8aa67764b91cc6787 /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux: OK
> 
> But when running perf-probe(1) like the following:
> 
>   $ perf probe schedule cpu
>   Failed to find path of kernel moduleFailed to open debuginfo file.
>   Error: Failed to add events. (-2)
> 
> it fails.
> 
> One strange thing is that when perf read the running kernel build id, it
> get: 882b1b53eb1d65320e8fa710273aa8493896c4.
> 
> Could anybody tell me what I'm doing wrong ?

Can you try using:

$ perf probe -k /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux <rest of the probe definition>

So that it tries it directly instead of looking into the buildid cache?

I'll check if perf probe actually looks in the buildid cache, till then,
please try specifying it directly,

Regards,

- Arnaldo
