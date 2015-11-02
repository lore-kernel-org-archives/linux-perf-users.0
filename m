From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Inverted call-graph broken?
Date: Mon, 2 Nov 2015 14:31:01 -0300
Message-ID: <20151102173101.GQ2923@kernel.org>
References: <55D20AF9.9040705@gmail.com>
 <5634C153.8020001@gmail.com>
 <1674883.ENQNaJOMdu@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45952 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751771AbbKBRbH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 2 Nov 2015 12:31:07 -0500
Content-Disposition: inline
In-Reply-To: <1674883.ENQNaJOMdu@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Ben Redelings <benjamin.redelings@gmail.com>, linux-perf-users@vger.kernel.org

Em Sun, Nov 01, 2015 at 03:09:45PM +0100, Milian Wolff escreveu:
> On Samstag, 31. Oktober 2015 09:25:39 CET Ben Redelings wrote:
> >      I've been using perf with '--call-graph=dwarf' -- very useful! I'd
> > like to view call graphs in 'perf report' in "inverted" order. Adding
> > '-G' to 'perf report' appears to have no effect, though. (Also
> > '--call-graph=fractal,caller' has no effect.)  Am I missing something
> > obvious?
> 
> This was broken and only recently got fixed by me and Jiri.
> 
> http://article.gmane.org/gmane.linux.kernel.perf.user/2279
> 
> Afaik, the patch has not yet been included upstream though. Arnaldo, can you 
> take Jiri's patch, or is there still something left to be done?

I'll check, but please post the title of the message, the gmane link
above isn't working for me, produces:

"Gmane 	weft didn't produce an output."

A Message-Id would be even better.

- Arnaldo
