From: Rick Jones <rick.jones2@hpe.com>
Subject: Tutorial/git's guide to c-state counters on Intel?
Date: Wed, 6 Jul 2016 12:30:32 -0700
Message-ID: <577D5C58.20802@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:57260 "EHLO
	g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932351AbcGFTae (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 6 Jul 2016 15:30:34 -0400
Received: from g4t3428.houston.hpe.com (g4t3428.houston.hpe.com [15.241.140.76])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id DC8E662AF0
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Jul 2016 19:30:33 +0000 (UTC)
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
	by g4t3428.houston.hpe.com (Postfix) with ESMTP id E9B9256
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Jul 2016 19:30:32 +0000 (UTC)
Received: from [16.103.148.51] (tardy.usa.hp.com [16.103.148.51])
	by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id CA24347
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Jul 2016 19:30:32 +0000 (UTC)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

I am presently trying to tease-out why a "slight" change in kernel 
(4.4.7 to 4.4.11) might result in a large change in some VM to VM 
netperf TCP_RR performance.  I've seen that if I set the system firmware 
to be in a static high performance mode rather than a dynamic power 
management (by the firmware) mode the gap narrows considerably.

I've come across:

   cstate_core/c3-residency/                          [Kernel PMU event]
   cstate_core/c6-residency/                          [Kernel PMU event]
   cstate_core/c7-residency/                          [Kernel PMU event]
   cstate_pkg/c2-residency/                           [Kernel PMU event]
   cstate_pkg/c3-residency/                           [Kernel PMU event]
   cstate_pkg/c6-residency/                           [Kernel PMU event]
   cstate_pkg/c7-residency/                           [Kernel PMU event]

and when I count those via perf comparing the two, back in the dynamic 
power managment mode, I can see more package c* residency on the slower 
setup (newer kernel).  That fits with the hypothesis that the slower 
request/response performance is coming from going into and out of sleep 
states more - something which has been known to affect the likes of a 
netperf TCP_RR test for years.   I don't see nearly as large a 
difference between the core c* counts though, which leaves me wondering 
why/how that might be.

The processors in question here are E5-2640:

model name	: Intel(R) Xeon(R) CPU E5-2640 0 @ 2.50GHz

happy benchmarking,

rick jones
