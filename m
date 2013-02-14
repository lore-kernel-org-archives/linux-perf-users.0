From: Yunqi Zhang <yqzhang@ucsd.edu>
Subject: question about stalls in perf
Date: Thu, 14 Feb 2013 00:08:19 +0000 (UTC)
Message-ID: <loom.20130214T005706-973@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35298 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752869Ab3BNAOr (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 13 Feb 2013 19:14:47 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1U5mTg-0006Wt-3K
	for linux-perf-users@vger.kernel.org; Thu, 14 Feb 2013 01:15:04 +0100
Received: from 128.54.45.216 ([128.54.45.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Feb 2013 01:15:04 +0100
Received: from yqzhang by 128.54.45.216 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Feb 2013 01:15:04 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

Recently, I'm using perf to do some profiling work on SandyBridge.

And I found two events stalled-cycles-frontend and stalled-cycles-backend
very interesting, while I'm not sure what are their accurate definitions.
So my question is which hardware counters on SandyBridge are used to
calculate these two events and how (an equation would be perfect).
Furthermore, I was wondering if it is possible for someone to tell
me in which file this calculation processes in the source code of perf.

Thanks a lot!

Regards,
Yunqi
