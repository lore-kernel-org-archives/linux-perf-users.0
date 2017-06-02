From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/2] perf report: ensure the perf DSO mapping matches
 what libdw sees
Date: Fri, 2 Jun 2017 16:49:10 -0300
Message-ID: <20170602194910.GB31764@kernel.org>
References: <20170602143753.16907-1-milian.wolff@kdab.com>
 <20170602152341.GB7901@redhat.com>
 <13986004.8uJxbMKobt@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750966AbdFBTtO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 2 Jun 2017 15:49:14 -0400
Content-Disposition: inline
In-Reply-To: <13986004.8uJxbMKobt@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>

Em Fri, Jun 02, 2017 at 06:21:44PM +0200, Milian Wolff escreveu:
> On Freitag, 2. Juni 2017 17:23:41 CEST Arnaldo Carvalho de Melo wrote:
> > Looks ok, having both implementations matching and the callchains making
> > sense for your workloads is a good way to verify the sanity, thanks.

> > I wonder if we shouldn't somehow script this, i.e. build it with one
> > implementation, generate output from some test workload, build it with
> > the other, second output, diff it, report when not the same.
 
> That does sound like a good idea, but I'm unsure how to do it. Note that many 
> "simple" tests work just fine. Only larger complicated workloads trigger this 
> issue for me.
 
> One potential way to test it would be `perf archive` - i.e. I send you the 
> binaries involved and then we can use perf script diffing to ensure it all 
> works...

Humm, I'm trying to cook up a:

  perf data filter --pid 12345 --perf-data-offset 1234567 --output perf.data.subset

to allow when finding some case like that to get a small subset of a
perf.data file with just the sample we want to get the backtrace from +
the mmaps, etc up to that point.

With that I could keep a repo of interesting perf.data files to have in
my regression tests.

- Arnaldo
