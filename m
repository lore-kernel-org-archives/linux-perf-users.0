From: Chulmin Kim <cmkim@core.kaist.ac.kr>
Subject: Question about LLC-load-misses event
Date: Mon, 15 Oct 2012 21:59:48 +0900
Message-ID: <507C08C4.1090705@core.kaist.ac.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from core.kaist.ac.kr ([143.248.147.118]:33992 "EHLO
	core.kaist.ac.kr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529Ab2JOODT (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 15 Oct 2012 10:03:19 -0400
Received: from [143.248.165.115] (az.kaist.ac.kr [143.248.165.115])
	by core.kaist.ac.kr (8.14.4/8.14.4) with ESMTP id q9FD8x6v019304
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Oct 2012 22:09:00 +0900
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi, all.

I'm currently evaluating memory performance of my own machine (intel
x5650 cpu).
My machine can have NUMA configuration, but it is under control. (only
local mem access allowed)

As i run STREAM benchmark, i monitor LLC cache misses using "perf"
simultaneously.
(perf command : perf stat -a -A -e LLC-loads -e LLC-load-misses -e
instructions sleep 3)

The problem is,, the bandwidth from STREAM benchmark does not match with
the monitored value.

e.g.
I got 9395MB/s from Stream.

"perf" shows 134,642,063 LLC-load-misses for 3 seconds.
-> BW = ((# of events)/(3 seconds)) * 64 bytes / (1024*1024) = 2739MB/s
In this equation, the term (64bytes) is for cache line size, and the
term(1024*1024) is for (MB/s).

Why does this mismatch occur?
