From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf report: Support caller callchain order when using
 DWARF unwinder.
Date: Tue, 3 Nov 2015 11:28:37 -0300
Message-ID: <20151103142837.GJ21609@kernel.org>
References: <1443971797-25548-1-git-send-email-milian.wolff@kdab.com>
 <20151103073325.GA23878@krava.brq.redhat.com>
 <20151103120631.GI21609@kernel.org>
 <2431085.Wl2WqsIU7l@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33006 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016AbbKCO2o (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 3 Nov 2015 09:28:44 -0500
Content-Disposition: inline
In-Reply-To: <2431085.Wl2WqsIU7l@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>

Em Tue, Nov 03, 2015 at 01:54:58PM +0100, Milian Wolff escreveu:
> On Tuesday, November 3, 2015 9:06:31 AM CET Arnaldo Carvalho de Melo wrote:
> > Em Tue, Nov 03, 2015 at 08:33:25AM +0100, Jiri Olsa escreveu:
> > > On Mon, Nov 02, 2015 at 06:19:44PM -0300, Arnaldo Carvalho de Melo wrote:
> > > 
> > > SNIP
> > > 
> > > > > > there's no check for return value of entry callback
> > > > > > 
> > > > > > also I wonder would it be better to store into ips[] within
> > > > > > the single loop all the time, and iterate throught it after
> > > > > > forward/backward based on the callchain_param.order
> > > > > > 
> > > > > > please check attached patch, totaly untested, probably leaking some
> > > > > > index
> > > > > > ;-)
> > > > > > 
> > > > > > any chance this could be done also for util/unwind-libdw.c ?
> > > > > 
> > > > > That patch looks much better than mine. I'll try it out later next
> > > > > week and
> > > > > will also have a look at util/unwind-libdw.c. Question: How can I test
> > > > > the
> > > > 
> > > > So, you tried this patch, right? Jiri, have you submitted this in some
> > > > other message I missed?
> > > 
> > > nope.. I thought Milian would take it ;-)
> > 
> > I can take it, as soon as you guys agree its something I should :-)
> 
> Yes, I think it's good as-is. Should I resubmit Jiris patch? Considering that 
> he rewrote the patch, should he send it and add me as tester? How do you 
> handle such situations in the Kernel land?

So, I'll fix this all up by adding a Signed-off-by: Jiri and a
Tested-by: Millian, which I think I can do according to the above
messages and past experience, but the Correct Way to do this would
be for Jiri to collect your Tested-by and resubmit in a separate
message, not as a patch added to the text of a thread.

Thanks,

- Arnaldo
