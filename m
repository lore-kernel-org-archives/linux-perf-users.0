From: Bernie Pope <bjpope@unimelb.edu.au>
Subject: What is the source of the time field in perf_sample events?
Date: Sun, 18 Mar 2012 23:08:42 +1100
Message-ID: <B76DE0C2-3A2B-4D77-BBA2-9157891B222D@unimelb.edu.au>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:21010 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753675Ab2CRMIp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 18 Mar 2012 08:08:45 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

I'm writing a tool to parse the perf.data output of perf and was wondering about the source of the timestamps found in perf_sample events? Specifically I mean the u64 time field in the perf_sample struct in util/event.h. I believe it is in nanoseconds from a particular event (system start?), but I can't find any documentation about where the time comes from.

I'm also interested in reading from this time source from a userspace program, is that possible?

Regards,
Bernie.
