From: Nitisha Jain <nitishajain15@gmail.com>
Subject: urgent help needed :perf record and report showing inconsistent results
Date: Wed, 23 Oct 2013 16:06:02 +0000 (UTC)
Message-ID: <loom.20131023T175255-294@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47071 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447Ab3JWQKF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 23 Oct 2013 12:10:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1VZ10W-0005zz-85
	for linux-perf-users@vger.kernel.org; Wed, 23 Oct 2013 18:10:04 +0200
Received: from 14.139.128.12 ([14.139.128.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Oct 2013 18:10:04 +0200
Received: from nitishajain15 by 14.139.128.12 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Oct 2013 18:10:04 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

hi, 

I am trying to find the overhead due to the kvm hypervisor when an IO
intensive process is running on a virtual machine and the perf record/report
are run on the host.( host has 12 cores, VM is pinned to a core)

I need to understand how to interpret the perf report in order to find the
cpu utilization of various components. In order to do that, I ran simple
tests on the host.

However, even if I run the exact same perf record command on the host
repeatedly, the results are quite different in terms of the report size, no
of samples and the total no of cycles shown in perf report.
The following commands were run in quick succession :

perf record -a -c 10000 -C 0 -o 1.data sleep 5
[ perf record: Woken up 3 times to write data ]
[ perf record: Captured and wrote 0.837 MB 1.data (~36559 samples) ]

perf report -i 1.data  (shows Events :15k cycles at the top)


perf record -a -c 10000 -C 0 -o 1.data sleep 5
[ perf record: Woken up 20 times to write data ]
[ perf record: Captured and wrote 5.214 MB 1.data (~227824 samples) ]

perf report -i 1.data  (shows Events :128k cycles at the top)


 perf record -a -c 10000 -C 0 -o 1.data sleep 5
[ perf record: Woken up 3 times to write data ]
[ perf record: Captured and wrote 0.775 MB 1.data (~33867 samples) ]

perf report -i 1.data  (shows Events :13k cycles at the top)


perf record -a -c 10000 -C 0 -o 1.data sleep 5
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.605 MB 1.data (~26442 samples) ]

perf report -i 1.data  (shows Events :9k cycles at the top)

Why is there such disparity between the reports ?

If I need to compare any two perf reports, how can I do so with the total
cycles being different on the 2 cases ?

Please assist me in this matter .
