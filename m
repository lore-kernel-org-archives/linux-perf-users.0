From: Vince Weaver <vince@deater.net>
Subject: RE: disabling multiplexing for offcore/uncore events
Date: Tue, 17 Sep 2013 20:38:30 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1309172036560.15719@pianoman.cluster.toy>
References: <0C53B16FB1F182409A7BA6DC928E7AFE2C2CC3@039-SN2MPN1-022.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from fbr04.mfg.siteprotect.com ([64.26.60.139]:59808 "EHLO
	fbr04.mfg.siteprotect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab3IRAol (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 17 Sep 2013 20:44:41 -0400
Received: from smtpauth05.mfg.siteprotect.com (unknown [192.168.33.144])
	by fbr04.mfg.siteprotect.com (Postfix) with ESMTP id 2F2979C073
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Sep 2013 19:37:30 -0500 (CDT)
In-Reply-To: <0C53B16FB1F182409A7BA6DC928E7AFE2C2CC3@039-SN2MPN1-022.039d.mgd.msft.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Freehill Christopher-RAT063 <RAT063@freescale.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

On Tue, 17 Sep 2013, Freehill Christopher-RAT063 wrote:

> > Hi,
> > 
> > Is there a way to disable the multiplexing perf does when (presumably)
> > there are not enough resources?
> 
> I neglected to mention, in this case, there *are* enough resources to handle all the events without multiplexing. My presumption above is that multiplexing occurs when there are not enough counters to handle all of the requests. 
> 
> I would rather perf just fail, and say it cannot handle the request than multiplex. In this case, however, as I stated earlier, multiplexing is not required, so I'm not sure why perf deletes the perf_event, and then adds it again.

Have you tried grouping with {}?  It should force a subset to run 
together.

For example:
  perf stat -e \{instructions,cycles\} /bin/ls

will always run instructions and cycles at the same time.  You need the \
so the shell won't escape the {

as an aside, there are ARM chips that support offcore SOC events?

Vince
