From: Daniel Speyer <dspeyer@gmail.com>
Subject: What helps with stacks?
Date: Tue, 21 Apr 2015 19:54:28 +0000 (UTC)
Message-ID: <loom.20150421T215002-474@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46675 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756253AbbDUTyo (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 21 Apr 2015 15:54:44 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1YkeFm-0002Q6-58
	for linux-perf-users@vger.kernel.org; Tue, 21 Apr 2015 21:54:42 +0200
Received: from cpe-74-65-228-248.nyc.res.rr.com ([74.65.228.248])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Apr 2015 21:54:42 +0200
Received: from dspeyer by cpe-74-65-228-248.nyc.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Apr 2015 21:54:42 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello all,

I'm trying to get stack traces for a bunch of events using perf record and
having trouble with them getting cut off.  I'm using --callgraph dwarf,
which helps a little, and I recompiled libc with --fno-omit-frame-pointer,
which doesn't seem to have helped at all.  Very often, the bottom of the
stack is in libc, often __epoll_wait_nocancel.  Stacks for
sched:sched_switch events seem to be worse than cycles or sched:sched_wakeup
events, but it isn't 100%.  Is there anything else I could try?

Thanks,
--Daniel Speyer
