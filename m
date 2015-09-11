From: "Krishnamurthy, Ravichandra Madapura" <rvchan@hpe.com>
Subject: Is there a way to get perf tool working inside a KVM guest running
 2.6.32 kernel?
Date: Fri, 11 Sep 2015 05:09:41 +0000
Message-ID: <B6B318D619BCEB4CB9F09BD9513847E78854AA37@G4W3298.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:42652 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbbIKFLd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 11 Sep 2015 01:11:33 -0400
Received: from G4W6310.americas.hpqcorp.net (g4w6310.houston.hp.com [16.210.26.217])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by g4t3426.houston.hp.com (Postfix) with ESMTPS id 6376E61
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2015 05:11:32 +0000 (UTC)
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi All,

When I run perf tool inside a KVM guest running 2.6.32 kernel, I cannot see all the kernel function stack trace.
But can only see the scheduler, page fault functions and a handful of others.
Is there a way I can get it to work inside a KVM guest?

Thanks,
Ravi
