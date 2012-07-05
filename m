From: Arnaldo Carvalho de Melo <acme@infradead.org>
Subject: Re: Callgraph like kcachegrind
Date: Wed, 4 Jul 2012 21:44:28 -0300
Message-ID: <20120705004428.GA17035@infradead.org>
References: <r21ub9-8f1.ln1@barney.bruehl.pontohonk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:48757 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978Ab2GEAoh (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 4 Jul 2012 20:44:37 -0400
Content-Disposition: inline
In-Reply-To: <r21ub9-8f1.ln1@barney.bruehl.pontohonk.de>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Christoph Bartoschek <bartoschek@gmx.de>
Cc: linux-perf-users@vger.kernel.org

Em Thu, Jun 28, 2012 at 02:59:39PM +0200, Christoph Bartoschek escreveu:
> Hi,
> 
> is it somehow possible to get a callgraph like gets it from kcachegrind?
> 
> I tried to use -g/-G on a program that runs but the information is not as 
> expected. I do not see how the 100% runtime of main() is distributed.

This is a feature we should have, but till then I think there is a
script out there that does that, lemme try to google that, gack, I know
there is one, but 'perf tools' really isn't google friendly, anyone?

- Arnaldo
