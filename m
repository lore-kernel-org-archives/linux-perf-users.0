From: Freehill Christopher-RAT063 <RAT063@freescale.com>
Subject: how perf handles (or should handle) off-core events
Date: Fri, 12 Apr 2013 14:52:55 +0000
Message-ID: <0C53B16FB1F182409A7BA6DC928E7AFE210D39@039-SN2MPN1-022.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-db8lp0185.outbound.messaging.microsoft.com ([213.199.154.185]:5342
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752758Ab3DLPII convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 12 Apr 2013 11:08:08 -0400
Received: from mail59-db8 (localhost [127.0.0.1])	by mail59-db8-R.bigfish.com
 (Postfix) with ESMTP id D96A56801CB	for <linux-perf-users@vger.kernel.org>;
 Fri, 12 Apr 2013 14:53:00 +0000 (UTC)
Received: from DB8EHSMHS026.bigfish.com (unknown [10.174.8.254])	by
 mail59-db8.bigfish.com (Postfix) with ESMTP id E7481980045	for
 <linux-perf-users@vger.kernel.org>; Fri, 12 Apr 2013 14:52:58 +0000 (UTC)
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users <linux-perf-users@vger.kernel.org>


Hi,

I am seeing inconsistencies when I use perf to measure off core events with the -a option, compared with using a probe. For example

$ perf -a -A -e rXXXX sleep 5

I am running a simple program that copies arrays. The rXXXX event above counts memory accesses.

For comparison, I have a probe from which I can measure the events. To see if the measurements are equal, I am comparing events/second collected by each method, while the simple array-copy program is running. What I am seeing is that the counts provided by perf are 2X to 3X smaller for the memory accesses.

My theory is that for non-core events, when perf is handling counter overflows via interrupt in one of the cores, the other cores are still active, but the events they are generating are not being counted, because perf is busy handling a counter overflow. 

I've tried various tests, but have not been able to prove/disprove this theory. 

If the theory is correct, is there already a way to deal with this issue? Seems like you would have to suspend the other cores while handling the counter overflow in order to avoid losing events.

Any thoughts, suggestions, ideas, etc. are most welcome.

Thanks,

Chris
