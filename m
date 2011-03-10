From: Arnaldo Carvalho de Melo <acme@infradead.org>
Subject: Re: perf record regression?
Date: Thu, 10 Mar 2011 13:31:09 -0300
Message-ID: <20110310163109.GD23555@ghostprotocols.net>
References: <AANLkTikcz=_HX7Ws2Ojmky+JgQhk1cj2YW=uxSkYkXBQ@mail.gmail.com>
 <20110310144927.GF14438@ghostprotocols.net>
 <20110310152807.GA23555@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:56010 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267Ab1CJQbQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 10 Mar 2011 11:31:16 -0500
Content-Disposition: inline
In-Reply-To: <20110310152807.GA23555@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <arun@sharma-home.net>
Cc: linux-perf-users@vger.kernel.org

Em Thu, Mar 10, 2011 at 12:28:07PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Mar 10, 2011 at 11:49:28AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Mar 09, 2011 at 09:59:39PM -0800, Arun Sharma escreveu:
> > > I pulled the perf/core branch in
> > > git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux-2.6.git today
> > > and found that:
> > > 
> > > perf record -ag -- sleep 1
> > > perf report -D | grep dso:
> > > 
> > > was returning:
> > > 
> > >  ...... dso: <not found>
> > >  ...... dso: <not found>
> > >  ...... dso: /boot/vmlinux-2.6.38-rc5+
> > > 
> > > i.e perf report was not able to map IP addresses to the correct dso
> > > for anything in user space.
> > > perf built after these commits is able to symbolize properly for
> > > perf.data collected using an older version of perf. So I believe, the
> > > perf report side of things are ok. But perf record is not.
> > 
> > Thanks for bisecting, I noticed some problems yesterday and was trying
> > to bisect it, but run into another bug, will investigate now.
> 
> Can you try with this one? Has the fix plus some simplifications.

Ah, just noticed that Ingo didn't merge this branch due to some other
isues with 'perf script' patches from David Ahern, so I'll just fold
this before resubmitting to him, so that we remove this problem from our
bisectable upstream :-)

- Arnaldo
