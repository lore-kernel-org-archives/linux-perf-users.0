From: Manuel Selva <manuel.selva@insa-lyon.fr>
Subject: Understanding perf mem -t load results
Date: Thu, 12 Dec 2013 15:06:04 +0100 (CET)
Message-ID: <1776760155.10395562.1386857164818.JavaMail.root@insa-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp2.insa-lyon.fr ([134.214.76.44]:40184 "EHLO
	smtp2.insa-lyon.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489Ab3LLOgx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 Dec 2013 09:36:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by smtp2.insa-lyon.fr (Postfix) with ESMTP id 9EBBC9DE70
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Dec 2013 15:31:42 +0100 (CET)
Received: from smtp2.insa-lyon.fr ([127.0.0.1])
	by localhost (smtp2.insa-lyon.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id USeYulcmIk26 for <linux-perf-users@vger.kernel.org>;
	Thu, 12 Dec 2013 15:31:39 +0100 (CET)
Received: from zstore1.insa-lyon.fr (zstore1.insa-lyon.fr [134.214.182.187])
	by smtp2.insa-lyon.fr (Postfix) with ESMTP id DCCED9D9BF
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Dec 2013 15:06:05 +0100 (CET)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

I am trying to understand the output of the perf mem tool on my workstation with two intel Xeon X5650.

I recorded a perf.data file with memory load sampling (write sampling is not availble for these processors) as following (in the root directory of a Linux kernel source tree):

perf mem -t load rec -c 1 make -j18

Then I am reporting the results with

perf mem rep --sort=mem

 97.00%      25519343  L1 hit
  1.31%         43687  L3 hit
  1.15%         37253  LFB hit
  0.32%          3156  Remote Cache (1 hop) hit
  0.14%         38579  L3 miss
  0.05%          6309  L2 hit
  0.03%           231  Remote RAM (1 hop) hit
  0.00%             8  Local RAM hit
  0.00%             2  Uncached hit

As you can see, 97% of the loads (I am sampling all loads with -c 1: is it true ?) hit the L1 cache. My first question is about this high L1 hit ration and the small number of RAM requests (231 + 8). Is it realistic to have 97% of L1 hit and only 239 RAM accesses when compiling a Linux kernel ? 

Writing this email and looking again into Intel SDM I am thinking that the L3 misses are what is called "unknown L3 cache miss in SDM". As a consequence the total number of memory accesses would be L3 miss + Remote RAM + Local RAM, is it correct ?

The second question is the Uncached hit: is it the Un-cacheable memory in the SDM ? If yes, I guess it's also a request to RAM.

Finally, it's not very clear for me what Line Fill Buffer (LFB) is exactly and I was not able to find a pointer explaining that. Do you know where I can read information about this ?

Thanks,

------
Manuel
