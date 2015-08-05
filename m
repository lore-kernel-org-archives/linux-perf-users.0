From: Milan Radulovic <milan.radulovic@bsc.es>
Subject: Latency values in perf mem report
Date: Wed, 5 Aug 2015 14:54:22 +0000 (UTC)
Message-ID: <loom.20150805T123916-655@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38978 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935AbbHEPPH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 5 Aug 2015 11:15:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1ZN0PJ-0000Ab-IJ
	for linux-perf-users@vger.kernel.org; Wed, 05 Aug 2015 17:15:06 +0200
Received: from 84.88.51.9 ([84.88.51.9])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2015 17:15:05 +0200
Received: from milan.radulovic by 84.88.51.9 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2015 17:15:05 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello all,

I measured load latency using perf mem rec and I have some doubts regarding
the results.
It is a 2 socket machine, with 2x Intel E5-2620 (2x 6 cores) at 2.3 GHz.
I sampled the application which runs on all 12 cores for half an hour.
When I print out the results with perf mem rep I get a very broad range of
latencies for certain events. Specifically, Local RAM hits have latencies
from ~20 cycles up to ~2000 cycles.
It is similar for Remote RAM hits (which happen rarely).
First, I used 200 samples/second, but it is the same when I use 50
samples/second.

Is there some useful advice how could I filter these results?
I guess RAM hits should not have latencies bellow ~200 cycles.

Thanks for your help,
Milan
