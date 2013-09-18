From: Freehill Christopher-RAT063 <RAT063@freescale.com>
Subject: RE: disabling multiplexing for offcore/uncore events
Date: Wed, 18 Sep 2013 18:09:08 +0000
Message-ID: <0C53B16FB1F182409A7BA6DC928E7AFE2C2DFB@039-SN2MPN1-022.039d.mgd.msft.net>
References: <0C53B16FB1F182409A7BA6DC928E7AFE2C2CC3@039-SN2MPN1-022.039d.mgd.msft.net>
 <alpine.DEB.2.02.1309172036560.15719@pianoman.cluster.toy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:41155
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751683Ab3IRSJN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 18 Sep 2013 14:09:13 -0400
In-Reply-To: <alpine.DEB.2.02.1309172036560.15719@pianoman.cluster.toy>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vince@deater.net>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

> Have you tried grouping with {}?  It should force a subset to run
> together.
> 
> For example:
>   perf stat -e \{instructions,cycles\} /bin/ls
> 
> will always run instructions and cycles at the same time.  You need the \
> so the shell won't escape the {
> 
> as an aside, there are ARM chips that support offcore SOC events?

Vince, 
Thanks for the suggestion. I hadn't tried that, and was not knowledgeable about grouping. Unfortunately, I still see the same behavior using grouping. 

That is, if I had the following:

Perf stat -e \{a,b,c\} /bin/ls

(assume a, b and c are legit events)

the event a is added, configured for and then deleted. Then, then a and b are added, configured for, then deleted. Finally, a, b and c are added, configured for and deleted. This pattern would continue for however many events I specify.

This is probably just broken in my own environment. I'll investigate more. Of course, any suggestions are welcome.

Thanks again,

Chris
