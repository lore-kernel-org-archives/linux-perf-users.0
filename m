From: Arnaldo Carvalho de Melo <acme@infradead.org>
Subject: Re: Stand alone perf.data parser (Was Re: Callgraph like kcachegrind)
Date: Fri, 6 Jul 2012 12:12:08 -0300
Message-ID: <20120706151208.GB24429@infradead.org>
References: <r21ub9-8f1.ln1@barney.bruehl.pontohonk.de>
 <20120705004428.GA17035@infradead.org>
 <87obntlon0.fsf@sejong.aot.lge.com>
 <4FF6363A.3020206@fb.com>
 <CAM9d7cjaRxCgwi2QM5dd3w59mORJ5wo8k9DO71d5AhhL5Fvo=g@mail.gmail.com>
 <20120706074018.GA7728@somewhere.redhat.com>
 <4FF6FCFF.5070400@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:47419 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab2GFPMP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 6 Jul 2012 11:12:15 -0400
Content-Disposition: inline
In-Reply-To: <4FF6FCFF.5070400@fb.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Christoph Bartoschek <bartoschek@gmx.de>, linux-perf-users@vger.kernel.org

Em Fri, Jul 06, 2012 at 07:58:07AM -0700, Arun Sharma escreveu:
> On 7/6/12 12:40 AM, Frederic Weisbecker wrote:
> >Another thing that could be interesting is a perf output mode that dumps
> >informations in the Kcachegrind format: http://kcachegrind.sourceforge.net/html/CallgrindFormat.html
> >so that Kcachegrind can open it.
> 
> I spent a night couple of months ago hacking on this:
> https://github.com/adsharma/py-perf-parser
> 
> It needs to be combined with code that can symbolize raw IP
> addresses to make it more useful (pydevtools, pyelftools or parts of
> perf exported as a library)

yeah, the symbols code needs some love and care so that it can be
librarified, my plans are to have it available via the perf.so python
binding first, 'perf script' could then use it as well.

I.e. process PERF_RECORD_{MMAP,FORK,EXIT} events just like the tools do
so that any adjustments needed to do symbol resolution are done, etc.

Perhaps after vacations 8-)
 
> Thought I'd post it here, so folks interested in transforming
> perf.data into something else can hack on it.

- Arnaldo
