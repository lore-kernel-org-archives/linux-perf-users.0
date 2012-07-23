From: Mark Hills <mark@pogo.org.uk>
Subject: Re: Callgraph like kcachegrind
Date: Mon, 23 Jul 2012 14:28:00 +0100 (BST)
Message-ID: <1207231425280.28435@wes.ijneb.com>
References: <r21ub9-8f1.ln1@barney.bruehl.pontohonk.de> <20120705004428.GA17035@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx.ij.cx ([212.13.201.15]:51656 "EHLO wes.ijneb.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750969Ab2GWOMc (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 23 Jul 2012 10:12:32 -0400
In-Reply-To: <20120705004428.GA17035@infradead.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@infradead.org>
Cc: Christoph Bartoschek <bartoschek@gmx.de>, linux-perf-users@vger.kernel.org

On Wed, 4 Jul 2012, Arnaldo Carvalho de Melo wrote:

> Em Thu, Jun 28, 2012 at 02:59:39PM +0200, Christoph Bartoschek escreveu:
> > Hi,
> > 
> > is it somehow possible to get a callgraph like gets it from kcachegrind?
> > 
> > I tried to use -g/-G on a program that runs but the information is not as 
> > expected. I do not see how the 100% runtime of main() is distributed.
> 
> This is a feature we should have, but till then I think there is a
> script out there that does that, lemme try to google that, gack, I know
> there is one, but 'perf tools' really isn't google friendly, anyone?

Perhaps you mean gprof2dot. I have been using it very successfully, 
although I find it sensitive to changes in perf; it may need updating for 
the most recent changes.

http://code.google.com/p/jrfonseca/wiki/Gprof2Dot

-- 
Mark
