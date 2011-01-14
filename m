From: Arnaldo Carvalho de Melo <acme@infradead.org>
Subject: Re: perf timechart broken
Date: Fri, 14 Jan 2011 15:37:40 -0200
Message-ID: <20110114173739.GA29318@ghostprotocols.net>
References: <201101071104.37576.trenn@suse.de>
 <20110111114951.GA8564@ghostprotocols.net>
 <20110111145134.GA11968@ghostprotocols.net>
 <201101141749.36716.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:38267 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab1ANRiW (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 14 Jan 2011 12:38:22 -0500
Content-Disposition: inline
In-Reply-To: <201101141749.36716.trenn@suse.de>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Renninger <trenn@suse.de>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>, linux-perf-users@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Em Fri, Jan 14, 2011 at 05:49:36PM +0100, Thomas Renninger escreveu:
> On Tuesday 11 January 2011 15:51:34 Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jan 11, 2011 at 09:49:51AM -0200, Arnaldo Carvalho de Melo escreveu:
> > > Looking at it now.
> > 
> > Can you try with this patch applied? We need a better way of specifying
> > ordering of __exit and __init routines :-\
> I tested on x86/tip and it is fixed.
> I explicitly reverted your fix and run into it again.
> 
> Thanks!

Thanks a lot for reporting and retesting,

- Arnaldo
