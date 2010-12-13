From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: perf-probe: issue with latest fedora kernel
Date: Mon, 13 Dec 2010 17:17:36 -0200
Message-ID: <20101213191736.GB7984@ghostprotocols.net>
References: <m2pqtb9ekn.fsf@gmail.com>
 <20101209153548.GA11820@ghostprotocols.net>
 <m2wrnernw3.fsf@gmail.com>
 <20101213125837.GB5407@ghostprotocols.net>
 <m2sjy1stuf.fsf@gmail.com>
 <20101213142159.GF5407@ghostprotocols.net>
 <m2fwu1so6j.fsf@gmail.com>
 <20101213164009.GJ5407@ghostprotocols.net>
 <m2bp4psd7r.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33515 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496Ab0LMTRn (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 13 Dec 2010 14:17:43 -0500
Received: by ywl5 with SMTP id 5so3461460ywl.19
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Dec 2010 11:17:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m2bp4psd7r.fsf@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Em Mon, Dec 13, 2010 at 08:08:08PM +0100, Francis Moreau escreveu:
> Arnaldo Carvalho de Melo <acme@ghostprotocols.net> writes:
> 
> > Em Mon, Dec 13, 2010 at 04:11:16PM +0100, Francis Moreau escreveu:
> >> But as I said, there's no matching build-id. I understand that -k is
> >> currently broken but suppose that it works, which vmlinux should I use
> >> then ?

> >> $ rpm -qa | grep kernel
> >> kernel-debuginfo-common-x86_64-2.6.35.9-64.fc14.x86_64
> >> kernel-debug-debuginfo-2.6.35.9-64.fc14.x86_64
> >> kernel-headers-2.6.35.6-48.fc14.x86_64
> >> kernel-devel-2.6.35.9-64.fc14.x86_64
> >> kernel-2.6.35.9-64.fc14.x86_64

> > Bzzt, here is the problem: you're not using the right package,
> > kernel-debug-debuginfo is for the kernel-debug package, a kernel built
> > with lots of CONFIG_DEBUG_ options turned on, please install the right
> > package, which is kernel-debuginfo-2.6.35.9-64.fc14.x86_64
> 
> Ah, that's it.

Yeah, those package names are a bit confusing :-)

Please let us know about any other problem you have using these tools,
any feedback is _greatly_ appreciated.

- Arnaldo
