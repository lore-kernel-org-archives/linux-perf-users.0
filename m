From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: perf-probe: issue with latest fedora kernel
Date: Mon, 13 Dec 2010 14:40:09 -0200
Message-ID: <20101213164009.GJ5407@ghostprotocols.net>
References: <m2pqtb9ekn.fsf@gmail.com>
 <20101209153548.GA11820@ghostprotocols.net>
 <m2wrnernw3.fsf@gmail.com>
 <20101213125837.GB5407@ghostprotocols.net>
 <m2sjy1stuf.fsf@gmail.com>
 <20101213142159.GF5407@ghostprotocols.net>
 <m2fwu1so6j.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gx0-f180.google.com ([209.85.161.180]:48475 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135Ab0LMQkP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 13 Dec 2010 11:40:15 -0500
Received: by gxk19 with SMTP id 19so4049752gxk.11
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Dec 2010 08:40:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m2fwu1so6j.fsf@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Em Mon, Dec 13, 2010 at 04:11:16PM +0100, Francis Moreau escreveu:
> But as I said, there's no matching build-id. I understand that -k is
> currently broken but suppose that it works, which vmlinux should I use
> then ?
> 
> $ rpm -qa | grep kernel
> kernel-debuginfo-common-x86_64-2.6.35.9-64.fc14.x86_64
> kernel-debug-debuginfo-2.6.35.9-64.fc14.x86_64
> kernel-headers-2.6.35.6-48.fc14.x86_64
> kernel-devel-2.6.35.9-64.fc14.x86_64
> kernel-2.6.35.9-64.fc14.x86_64

Bzzt, here is the problem: you're not using the right package,
kernel-debug-debuginfo is for the kernel-debug package, a kernel built
with lots of CONFIG_DEBUG_ options turned on, please install the right
package, which is kernel-debuginfo-2.6.35.9-64.fc14.x86_64
 
> $ rpm -ql kernel-debug-debuginfo-2.6.35.9-64.fc14.x86_64 | grep vmlinux
> /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug/vmlinux
> 
> So the debug package installed the kernel image with debug info into
> 
>    /usr/lib/debug/lib/modules/2.6.35.9-64.fc14.x86_64.debug

Right, this matches what is in the kernel in the kernel-debug package.

Please install the right debuginfo package and try again

- Arnaldo
