From: Milan Radulovic <milan.radulovic@bsc.es>
Subject: Re: Latency values in perf mem report
Date: Tue, 11 Aug 2015 15:16:42 +0000 (UTC)
Message-ID: <loom.20150811T170505-860@post.gmane.org>
References: <loom.20150805T123916-655@post.gmane.org> <alpine.DEB.2.20.1508051602080.7381@vincent-weaver-1.umelst.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:57544 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965076AbbHKPQ6 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 11 Aug 2015 11:16:58 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1ZPBIO-00048L-Nl
	for linux-perf-users@vger.kernel.org; Tue, 11 Aug 2015 17:16:57 +0200
Received: from 84.88.51.9 ([84.88.51.9])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2015 17:16:56 +0200
Received: from milan.radulovic by 84.88.51.9 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2015 17:16:56 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Vince Weaver <vincent.weaver <at> maine.edu> writes:
>
https://software.intel.com/en-us/articles/
performance-monitoring-on-intel-xeon-processor-e5-family
> 
> Vince

Hello Vince,

I took a look at the document you suggested. 
It seems that the counter which measures
latency on SandyBridge may undercount...
If you apply some of the workarounds which they suggest, I get better results.
There are still some small values but they appear far less.

Thanks for the help!

Best regards,
Milan
