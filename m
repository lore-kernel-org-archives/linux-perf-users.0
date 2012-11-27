From: Chris Freehill <cfreehill@gmail.com>
Subject: Re: perf stat -e cycles -p <pid> sleep 10
Date: Tue, 27 Nov 2012 13:13:36 +0000 (UTC)
Message-ID: <loom.20121127T140924-617@post.gmane.org>
References: <loom.20121126T234917-97@post.gmane.org> <50B461F4.10003@core.kaist.ac.kr> <loom.20121127T131426-104@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59949 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753310Ab2K0NNw (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 27 Nov 2012 08:13:52 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1TdKzA-0004AG-RR
	for linux-perf-users@vger.kernel.org; Tue, 27 Nov 2012 14:14:00 +0100
Received: from gate-tx3.freescale.com ([192.88.168.1])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Nov 2012 14:14:00 +0100
Received: from cfreehill by gate-tx3.freescale.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Nov 2012 14:14:00 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org


An update in case another newbie runs into this...this was user error.

I believe the reason I was seeing no events is that the processes (in the 
"failure" cases) I chose to monitor were not being allocated any time, so of 
course they generated no events. When I select the right processes, I get events.
