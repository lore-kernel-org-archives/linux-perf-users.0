From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: perf-probe: issue with latest fedora kernel
Date: Mon, 13 Dec 2010 14:40:51 -0200
Message-ID: <20101213164051.GK5407@ghostprotocols.net>
References: <m2pqtb9ekn.fsf@gmail.com>
 <20101209153548.GA11820@ghostprotocols.net>
 <m3tyimxeyc.fsf@gmail.com>
 <20101212140851.GA2343@ghostprotocols.net>
 <m3ei9mfxj5.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:42507 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135Ab0LMQk5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 13 Dec 2010 11:40:57 -0500
Received: by gwb20 with SMTP id 20so5121934gwb.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Dec 2010 08:40:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m3ei9mfxj5.fsf@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc: Francis Moreau <francis.moro@gmail.com>, linux-perf-users@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

Em Sun, Dec 12, 2010 at 11:15:26PM +0100, Franck Bui-Huu escreveu:
> Arnaldo Carvalho de Melo <acme@ghostprotocols.net> writes:
> 
> > Em Fri, Dec 10, 2010 at 08:30:19AM +0100, Franck Bui-Huu escreveu:
> >> Looks like a standard path is missing...
> >> 
> >> What about adding the one above since it looks like Fedora is installing
> >> their debug kernel images at this place ?
> >
> > Can I get your signed-off-by on this one?
> >
> 
> Of course.
> 
> [PATCH] perf-tools: add one more default search path for kernel image
> 
> From: Franck Bui-Huu <fbuihuu@gmail.com>
> 
> It looks like Fedora is using this one.

Nope, this is not needed, see the rest of the discussion please.

- Arnaldo
