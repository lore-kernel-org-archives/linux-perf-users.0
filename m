From: Freehill Christopher-RAT063 <RAT063@freescale.com>
Subject: RE: perf event attrributes
Date: Wed, 3 Apr 2013 22:26:38 +0000
Message-ID: <0C53B16FB1F182409A7BA6DC928E7AFE20FD93@039-SN2MPN1-022.039d.mgd.msft.net>
References: <0C53B16FB1F182409A7BA6DC928E7AFE1FDA4F@039-SN2MPN1-022.039d.mgd.msft.net>
	<m2boa4ia23.fsf@firstfloor.org>
	<0C53B16FB1F182409A7BA6DC928E7AFE20C90D@039-SN2MPN1-022.039d.mgd.msft.net>
 <87ehetfsqu.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:47894
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758711Ab3DCW0m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 3 Apr 2013 18:26:42 -0400
In-Reply-To: <87ehetfsqu.fsf@sejong.aot.lge.com>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users <linux-perf-users@vger.kernel.org>

> > Can you point me to the Intel uncore drivers you mentioned?
> 
> You can see it under /sys/bus/event_source/devices/uncore_imc_*/ on a
> recent kernel.  There'll be the "format" and "events" directories.

Thanks Namhyung. Installed Ubuntu 12.10 (with 3.5.0-17-generic) on VirtualBox. I'm not seeing this folder is it later than this?

Also, are you aware of any documentation on the usage?

Thanks,
Chris
