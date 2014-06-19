From: Jesper Dangaard Brouer <jbrouer@redhat.com>
Subject: Use of PMU counters inside kernel?
Date: Thu, 19 Jun 2014 12:53:52 +0200
Message-ID: <20140619125352.768e1ec9@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21995 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753528AbaFSKyW (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 19 Jun 2014 06:54:22 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>, Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org
Cc: Daniel Borkmann <dborkman@redhat.com>, Florian Westphal <fw@strlen.de>, Hannes Frederic Sowa <hannes@stressinduktion.org>

Hi

I want to use/read the PMU counters for 'instructions' and 'cycles',
from within the kernel, to measure the overhead of different in-kernel
functions (and calc the pipeline efficiency ala perf-stat insns per cycle).

What is the prefered way/API to read these counters, without
conflicting with the perf tool?


I've already looked at Andi Kleens "simple-pmu" kernel module
 https://github.com/andikleen/simple-pmu/
Thus, I have figured out how I can hack this together open-coded. I'm
looking for advice on howto use the existing perf APIs ?

I basically just need a in-kernel API to turn in these counters, and
then I can just read them via the rdpcm instruction.


Info I already learned (correct me if I'm wrong):

The 'instructions' counter is the "Instruction Retired" counter
 * Event num: 0xC0, Umask: 0x00
 * Read via rdpmc 0x40000000

The 'cycles' counter is the "Unhalted core cycles" counter
 * Event num: 0x3C, Umask: 0x00
 * Read via rdpmc 0x40000001

I'm uncertain about the rdpmc hex values (taken from simple-pmu).

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Sr. Network Kernel Developer at Red Hat
  Author of http://www.iptv-analyzer.org
  LinkedIn: http://www.linkedin.com/in/brouer
