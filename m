From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf report: Support caller callchain order when using
 DWARF unwinder.
Date: Tue, 3 Nov 2015 08:37:11 +0100
Message-ID: <20151103073711.GB23878@krava.brq.redhat.com>
References: <1443971797-25548-1-git-send-email-milian.wolff@kdab.com>
 <20151004203817.GE20515@kernel.org>
 <20151005110836.GA28364@krava.landal.opennet>
 <2192570.dg0L2eaEiH@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34811 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248AbbKCHhO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 3 Nov 2015 02:37:14 -0500
Content-Disposition: inline
In-Reply-To: <2192570.dg0L2eaEiH@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>

On Fri, Oct 09, 2015 at 07:29:34PM +0200, Milian Wolff wrote:

SNIP

> > ;-)
> > 
> > any chance this could be done also for util/unwind-libdw.c ?
> 
> That patch looks much better than mine. I'll try it out later next week and 
> will also have a look at util/unwind-libdw.c. Question: How can I test the 
> behavior of the latter? Do I need to uninstall libunwind, or can I change the 
> unwinder at runtime somehow (env var?).

It's either libunwind or libdw compiled in, so I'd suggest
generic test (see below) and compile with make variables
NO_LIBUNWIND=1 or NO_LIBDW_DWARF_UNWIND=1 to get desired
unwinder compiled in

> 
> Also, are there unit tests for this behavior somewhere?

please check tests/dwarf-unwind.c, I think you can add similar test

thanks,
jirka
