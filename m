From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Reusable data analysis/parser library?
Date: Mon, 22 Jul 2013 10:33:11 +0200
Message-ID: <20130722083311.GA12256@krava.brq.redhat.com>
References: <1435472.kqSja2FelP@minime>
 <1570240.AOWUWmZr1e@minime>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12025 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756701Ab3GVIdZ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 22 Jul 2013 04:33:25 -0400
Content-Disposition: inline
In-Reply-To: <1570240.AOWUWmZr1e@minime>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <mail@milianw.de>
Cc: linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>

On Sun, Jul 21, 2013 at 11:57:26PM +0200, Milian Wolff wrote:
> On Thursday 27 December 2012 15:42:32 Milian Wolff wrote:
> > Hey there,
> > 
> > I found [1] and [2] but not a reusable shared library which one could use to
> > write custom analyzers for perf.data files. Are you still working on this
> > or should one rather stick to parsing the output of "perf script"?
> > 
> > As a start I would like to integrate a parser into KCacheGrind to seamlessly
> > open perf.data files with it.
> > 
> > Thanks
> > 
> > [1]: https://openlab-mu-internal.web.cern.ch/openlab-mu-> internal/03_Documents/3_Technical_Documents/Technical_Reports/2011/Urs_Fassl
> > er_report.pdf [2]:
> > http://article.gmane.org/gmane.linux.kernel.perf.user/974/match=kcachegrind
> 
> Ping, is there anything available which I can use to write a perf.data parser 
> for KCacheGrind? This would be highly benefitial for many people using perf.
> 
> Otherwise, is there at least a solid documentation of the binary format which 
> I might then use to write a custom external library?

hi,
I'm currently doing some reorg in this part:
http://marc.info/?l=linux-kernel&m=137408381902423&w=2
I'll check and see if we could isolate the parser somehow.

Above patchset contains some doc of the perf.data format:
http://marc.info/?l=linux-kernel&m=137408345402297&w=2

Also Andi sent out following python parser, but I did not
get to it so far:
http://marc.info/?l=linux-kernel&m=137424881921089&w=2

jirka
