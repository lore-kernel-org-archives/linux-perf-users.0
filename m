From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: /tmp/perf-PID.map ownership
Date: Thu, 12 Nov 2015 16:04:44 -0300
Message-ID: <20151112190444.GB7160@kernel.org>
References: <CAE40pdctG6CUcmangzqSKmd7GkSv1oz7jP5hR-=GFSTTeQ-2sQ@mail.gmail.com>
 <20151112185205.GA7160@kernel.org>
 <CAE40pdcfdBV_xwJtuBvVe3Fjqxa69W7XT_LN6r9UH94wcfEQeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:49884 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbbKLTEu (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 Nov 2015 14:04:50 -0500
Received: from [2804:14d:1285:110c:213:3bff:fe74:11bc] (helo=zoo.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
	id 1ZwxAu-0001Wl-O6
	for linux-perf-users@vger.kernel.org; Thu, 12 Nov 2015 19:04:49 +0000
Content-Disposition: inline
In-Reply-To: <CAE40pdcfdBV_xwJtuBvVe3Fjqxa69W7XT_LN6r9UH94wcfEQeQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

Em Thu, Nov 12, 2015 at 10:59:36AM -0800, Brendan Gregg escreveu:
> On Thu, Nov 12, 2015 at 10:52 AM, Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> > Em Thu, Nov 12, 2015 at 10:27:26AM -0800, Brendan Gregg escreveu:
> >> G'Day,
> >>
> >> # perf record -F 99 -a -g -- sleep 30
> >> [...]
> >> # perf report -n --stdio
> >> File /tmp/perf-25958.map not owned by current user or root, ignoring it.
> >>
> >> Can root bypass this test? I'm root, and profiling apps from different
> >
> > In other places such tests are overridable via '-f' (force), this one
> > should too, I think.
> >
> > # perf report
> > File perf.data not owned by current user or root (use -f to override)
> > [root@zoo linux]# ls -la perf.data
> > -rw-------. 1 acme acme 20032 Nov 12 15:50 perf.data
> 
> Yes, a -f option would work too...

Cooking up a patch right now.

- Arnaldo
