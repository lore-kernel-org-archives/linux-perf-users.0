From: Milian Wolff <mail@milianw.de>
Subject: task-clock vs. cpu-clock; per-event documentation
Date: Wed, 05 Aug 2015 14:55:11 +0200
Message-ID: <1472439.mytDSkIAAG@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:35281 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbbHEMzO (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 5 Aug 2015 08:55:14 -0400
Received: from milian-kdab2.localnet (unknown [185.28.184.2])
	by dd17628.kasserver.com (Postfix) with ESMTPSA id 33E666280295
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2015 14:55:12 +0200 (CEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello all,

I was asked by a colleague of mine what the difference between task-clock and 
cpu-clock is. I found many similar questions on the web, but none have a final 
answer:

http://stackoverflow.com/questions/23965363/linux-perf-events-cpu-clock-and-task-clock-what-is-the-difference
https://lkml.org/lkml/2010/11/3/373

Could someone explain the difference between the two counters for a non-kernel 
person? What is a task for that matter? When I compare the counters on test 
applications, they deviate only marginally.

In general, is there hope for more documentation on the individual performance 
counters? Perf list shows what's available but has no information whatsoever 
about the actual meaning of the counters. It would be excellent to also 
explain how to interpret the counter, or in what case you'd want to look at a 
given event.

Thanks
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
