From: Iegorov Oleg <oleg_iegorov@mentor.com>
Subject: perf: prctl(PR_TASK_PERF_EVENTS_DISABLE) has no effect
Date: Thu, 26 Jul 2012 12:54:11 +0200
Message-ID: <501121D3.3060700@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:32987 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812Ab2GZKyP (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 26 Jul 2012 06:54:15 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org, mingo@elte.hu, a.p.zijlstra@chello.nl, acme@ghostprotocols.net

as there was no proposed solution that helped me in response to the same 
post by Andrew Steets, I would like to know if it is possible to 
disable/enable perf event counters from the source code?

calling prctl(PR_TASK_PERF_EVENTS_DISABLE) has no effect, nor does 
compiling with -fno-omit-frame-pointer option.

It would be extremely useful to disable perf event counters for some 
parts of code and re-enable them for other parts of code, like:

prctl(PR_TASK_PERF_EVENTS_DISABLE);
// not important for performance analysis code
prctl(PR_TASK_PERF_EVENTS_ENABLE);
// code that needs to be analysed

and then, run perf:

$ perf record ./program
$ perf report

Can anyone tell me how can I enable such functionality?
Thank you

--Oleg
