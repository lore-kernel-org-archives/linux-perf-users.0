From: Freehill Christopher-RAT063 <RAT063@freescale.com>
Subject: disabling multiplexing for offcore/uncore events
Date: Tue, 17 Sep 2013 21:42:35 +0000
Message-ID: <0C53B16FB1F182409A7BA6DC928E7AFE2C2CA8@039-SN2MPN1-022.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:53242
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753457Ab3IQVml convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 17 Sep 2013 17:42:41 -0400
Received: from mail180-ch1 (localhost [127.0.0.1])	by
 mail180-ch1-R.bigfish.com (Postfix) with ESMTP id CB184320127	for
 <linux-perf-users@vger.kernel.org>; Tue, 17 Sep 2013 21:42:39 +0000 (UTC)
Received: from CH1EHSMHS041.bigfish.com (snatpool3.int.messaging.microsoft.com
 [10.43.68.225])	by mail180-ch1.bigfish.com (Postfix) with ESMTP id
 31E432E0087	for <linux-perf-users@vger.kernel.org>; Tue, 17 Sep 2013 21:42:37
 +0000 (UTC)
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users <linux-perf-users@vger.kernel.org>



Hi,

Is there a way to disable the multiplexing perf does when (presumably) there are not enough resources?

I am dealing with off-core/SOC/uncore events/counters. If I issue the following:

perf stat -a -e ra0000000,ra0000001,ra0000002 sleep 1


I see that perf multiplexes:

           3027440 ra0000000                                                    [99.86%]
         293037102 ra0000001                                                    [99.89%]
          59123244 ra0000002                                                   

I don't want it to multiplex because I get an erroneous result for off-core events.

Seems like there should be a way to disable this, but I am not sure what it is.

Thanks,
Chris

 
