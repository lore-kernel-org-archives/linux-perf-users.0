From: Jose <jose.sgarcia.aldonza@gmail.com>
Subject: IPC sampling
Date: Fri, 3 Jun 2016 11:54:57 +0000 (UTC)
Message-ID: <loom.20160603T134548-395@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37078 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751727AbcFCMAN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 3 Jun 2016 08:00:13 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1b8nll-0004JM-7r
	for linux-perf-users@vger.kernel.org; Fri, 03 Jun 2016 14:00:05 +0200
Received: from est48.red8.uclm.es ([161.67.8.48])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Jun 2016 14:00:05 +0200
Received: from jose.sgarcia.aldonza by est48.red8.uclm.es with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Jun 2016 14:00:05 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

I need lot of IPC values for a given program execution. I can use "perf stat":

perf stat -I 10 -e cycles,instructions <program>   

and I can calculate IPC from cycles and instructions.

           time             counts unit events
     0.100137436        163.924.770      cycles
     0.100137436         77.957.069      instructions
     0.200370555        250.248.467      cycles
     0.200370555        124.686.255      instructions
     0.300493502        260.316.390      cycles
     0.300493502        467.691.086      instructions
     0.400623447        260.334.219      cycles
     0.400623447        467.711.817      instructions
     0.500922368        389.205.220      cycles
     0.500922368        689.460.813      instructions
     0.601220080      3.229.694.697      cycles
     0.601220080      6.415.412.796      instructions
      .....

The problem is that the frequency is very limited for my purposes (interval
must be >= 100ms)

It seems that "perf record" can help me:

perf record -F 10000 -e cycles,instructions <ejecutable>    (-F allows
greater frequencies)

My problem now is that I don't know how to obtain "cycles" and
"instructions" from perf.data file. I have tried several options using "perf
report" and "perf script" but I don't achieve it.

Thanks

Jose
