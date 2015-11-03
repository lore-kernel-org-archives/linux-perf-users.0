From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf report: Support caller callchain order when using
 DWARF unwinder.
Date: Tue, 3 Nov 2015 08:33:25 +0100
Message-ID: <20151103073325.GA23878@krava.brq.redhat.com>
References: <1443971797-25548-1-git-send-email-milian.wolff@kdab.com>
 <20151004203817.GE20515@kernel.org>
 <20151005110836.GA28364@krava.landal.opennet>
 <2192570.dg0L2eaEiH@agathebauer>
 <20151102211944.GR2923@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54064 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016AbbKCHd2 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 3 Nov 2015 02:33:28 -0500
Content-Disposition: inline
In-Reply-To: <20151102211944.GR2923@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Milian Wolff <milian.wolff@kdab.com>, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>

On Mon, Nov 02, 2015 at 06:19:44PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> > > 
> > > there's no check for return value of entry callback
> > > 
> > > also I wonder would it be better to store into ips[] within
> > > the single loop all the time, and iterate throught it after
> > > forward/backward based on the callchain_param.order
> > > 
> > > please check attached patch, totaly untested, probably leaking some index
> > > ;-)
> > > 
> > > any chance this could be done also for util/unwind-libdw.c ?
> > 
> > That patch looks much better than mine. I'll try it out later next week and 
> > will also have a look at util/unwind-libdw.c. Question: How can I test the 
> 
> So, you tried this patch, right? Jiri, have you submitted this in some
> other message I missed?

nope.. I thought Milian would take it ;-)

jirka
