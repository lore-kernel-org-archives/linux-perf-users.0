From: Dervin Thunk <dervin.thunk@gmail.com>
Subject: perf not measuring LLC events?
Date: Sat, 15 Dec 2012 18:26:22 +0000 (UTC)
Message-ID: <loom.20121215T192044-606@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:58072 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750995Ab2LOS3y (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 15 Dec 2012 13:29:54 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1TjwUt-0001uJ-JU
	for linux-perf-users@vger.kernel.org; Sat, 15 Dec 2012 19:30:04 +0100
Received: from pc-233-76-241-201.cm.vtr.net ([201.241.76.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Sat, 15 Dec 2012 19:30:03 +0100
Received: from dervin.thunk by pc-233-76-241-201.cm.vtr.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Sat, 15 Dec 2012 19:30:03 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Dear all,

I'm trying to measure the LLC events of a program. I'm running
linux-tools-3.2.0- 34 on a fairly recent 4 core Intel machine. For a
certain program that reads a 64 MB file into memory, I get

 Performance counter stats for './algo data/E.dna':

                 0 LLC-loads                                                   
                 0 LLC-load-misses
        26,538,349 cache-misses                                                
     4,465,644,541 L1-dcache-misses                                            

      35.116615511 seconds time elapsed

I have tried this in another machine, and it does give me some results
for LLC.  Also Valgrind gives me results (different from 0, that is)

Any idea what I'm doing wrong? Anyone else experiencing this problem
with perf right now? Please let me know if I need to provide more
information.

Thanks.
