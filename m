From: William Cohen <wcohen@redhat.com>
Subject: RFE: More inclusive pid filtering of sched:sched_switch tracepoint
 events
Date: Wed, 18 Nov 2015 14:01:13 -0500
Message-ID: <564CCAF9.3070805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49930 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754016AbbKRTBP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 18 Nov 2015 14:01:15 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id DEBF0368E3
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2015 19:01:14 +0000 (UTC)
Received: from [10.13.129.159] (dhcp129-159.rdu.redhat.com [10.13.129.159])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tAIJ1EC2026516
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2015 14:01:14 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I was experimenting with the sched:sched_switch tracepoint to look at
the time that a process spend off the processor.  As a really simple
experiment record data with:

$ sudo perf record -e sched:sched_switch -- du

Then examine the data with:

$ sudo perf script

The output only shows the sched:sched_switch when the process is moved
off the processor.  However, there is no data showing when the process is
scheduled back onto the processor:

              du 20960 [007] 339893.429394: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
              du 20960 [007] 339893.429411: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
              du 20960 [007] 339893.429544: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
              du 20960 [007] 339893.429556: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
              du 20960 [007] 339893.429561: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
              du 20960 [007] 339893.429567: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]
              du 20960 [007] 339893.430150: sched:sched_switch: du:20960 [120] R ==> kworker/7:0:16805 [120]

Would it be possible to make perf's process filtering more inclusive so
that output also includes sched:sched_switch tracepoints for pid that
are also being scheduled onto the processor?  The alternative of
recording all sched:sched_switch events system-wide and filtering out
all the unwanted pid's is undesirable.

-Will
