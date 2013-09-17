From: Freehill Christopher-RAT063 <RAT063@freescale.com>
Subject: RE: disabling multiplexing for offcore/uncore events
Date: Tue, 17 Sep 2013 21:56:03 +0000
Message-ID: <0C53B16FB1F182409A7BA6DC928E7AFE2C2CC3@039-SN2MPN1-022.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from co1ehsobe006.messaging.microsoft.com ([216.32.180.189]:49771
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753816Ab3IQV5T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 17 Sep 2013 17:57:19 -0400
Received: from mail217-co1 (localhost [127.0.0.1])	by
 mail217-co1-R.bigfish.com (Postfix) with ESMTP id 04EDC8801D7	for
 <linux-perf-users@vger.kernel.org>; Tue, 17 Sep 2013 21:57:18 +0000 (UTC)
Received: from CO1EHSMHS025.bigfish.com (unknown [10.243.78.241])	by
 mail217-co1.bigfish.com (Postfix) with ESMTP id 487029C0060	for
 <linux-perf-users@vger.kernel.org>; Tue, 17 Sep 2013 21:56:05 +0000 (UTC)
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users <linux-perf-users@vger.kernel.org>

> Hi,
> 
> Is there a way to disable the multiplexing perf does when (presumably)
> there are not enough resources?

I neglected to mention, in this case, there *are* enough resources to handle all the events without multiplexing. My presumption above is that multiplexing occurs when there are not enough counters to handle all of the requests. 

I would rather perf just fail, and say it cannot handle the request than multiplex. In this case, however, as I stated earlier, multiplexing is not required, so I'm not sure why perf deletes the perf_event, and then adds it again.

Chris
