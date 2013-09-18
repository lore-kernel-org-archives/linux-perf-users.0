From: Vince Weaver <vincent.weaver@maine.edu>
Subject: RE: disabling multiplexing for offcore/uncore events
Date: Wed, 18 Sep 2013 16:24:16 -0400 (EDT)
Message-ID: <alpine.DEB.2.10.1309181623340.14068@vincent-weaver-1.um.maine.edu>
References: <0C53B16FB1F182409A7BA6DC928E7AFE2C2CC3@039-SN2MPN1-022.039d.mgd.msft.net> <alpine.DEB.2.02.1309172036560.15719@pianoman.cluster.toy> <0C53B16FB1F182409A7BA6DC928E7AFE2C2DFB@039-SN2MPN1-022.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35958 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627Ab3IRURG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 18 Sep 2013 16:17:06 -0400
Received: by mail-ie0-f176.google.com with SMTP id as1so13392612iec.21
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Sep 2013 13:17:05 -0700 (PDT)
In-Reply-To: <0C53B16FB1F182409A7BA6DC928E7AFE2C2DFB@039-SN2MPN1-022.039d.mgd.msft.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Freehill Christopher-RAT063 <RAT063@freescale.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

On Wed, 18 Sep 2013, Freehill Christopher-RAT063 wrote:

> > Have you tried grouping with {}?  It should force a subset to run
> > together.
> > 
> > For example:
> >   perf stat -e \{instructions,cycles\} /bin/ls
> > 
> > will always run instructions and cycles at the same time.  You need the \
> > so the shell won't escape the {
> > 
> > as an aside, there are ARM chips that support offcore SOC events?
> 
> Vince, 
> Thanks for the suggestion. I hadn't tried that, and was not knowledgeable about grouping. Unfortunately, I still see the same behavior using grouping. 
> 
> That is, if I had the following:
> 
> Perf stat -e \{a,b,c\} /bin/ls
> 
> (assume a, b and c are legit events)
> 
> the event a is added, configured for and then deleted. Then, then a and b are added, configured for, then deleted. Finally, a, b and c are added, configured for and deleted. This pattern would continue for however many events I specify.
> 
> This is probably just broken in my own environment. I'll investigate more. Of course, any suggestions are welcome.

Support for { } grouping wasn't introduced until the version of perf
that came with Linux 3.7 so that might affect the results you see.

Vince
