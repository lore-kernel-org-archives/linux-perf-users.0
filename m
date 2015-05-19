From: "Krishnamurthy, Ravichandra Madapura" <rvchan@hp.com>
Subject: perf script - format differs between cpu_clock and other events
Date: Tue, 19 May 2015 13:43:36 +0000
Message-ID: <B6B318D619BCEB4CB9F09BD9513847E77E6C19E1@G4W3298.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from g9t5008.houston.hp.com ([15.240.92.66]:37033 "EHLO
	g9t5008.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103AbbESNoU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 19 May 2015 09:44:20 -0400
Received: from G4W6310.americas.hpqcorp.net (g4w6310.houston.hp.com [16.210.26.217])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by g9t5008.houston.hp.com (Postfix) with ESMTPS id 7C4A0297
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2015 13:44:19 +0000 (UTC)
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi,

I am a new user of Flamegraph with Linux Perf.

When perf data for sched_stat_sleep and sched_wait are used with Flamegraph, there are errors of the kind:
Unrecognized line:             nfsd  6216 [001] 86792.628647: sched_stat_sleep: task: nfsd:6214 sleep: 26918 [ns] at /root/FlameGraph//stackcollapse-perf.pl line 228, <> line 635105.

This seems due to 'perf script' output not being of similar format for these events as the default cpu_clock event.
Is there any sort of conversion for this format or other options that could get Flamegraph working with events that are not cpu_clock?

Thanks,
Ravi
