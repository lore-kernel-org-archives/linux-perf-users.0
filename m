From: Benjamin King <benjaminking@web.de>
Subject: Re: perf probe an addr without debuginfo
Date: Sun, 28 Jun 2015 17:46:51 +0200
Message-ID: <20150628154651.GA3953@localhost>
References: <CAE40pdemFG8f7EB6SerUEGeK0G2qeztqzeLCnLigB3TdgY6G1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:63348 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056AbbF1Pq4 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 28 Jun 2015 11:46:56 -0400
Content-Disposition: inline
In-Reply-To: <CAE40pdemFG8f7EB6SerUEGeK0G2qeztqzeLCnLigB3TdgY6G1Q@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

Hi Brendan

>Is there a trick to getting perf to probe a user-level address without
>debuginfo? Eg (on Linux 4.0):
>[...]
>I can do this using ftrace ok, eg, "p:tick_0x583 /root/tick:0x583"
>works. Thanks,

Not quite what you have asked for, but you can add the probe via ftrace and
then use it from perf. Probes from /sys/kernel/debug/tracing/uprobe_events
will show up in 'perf list' as well.

Cheers,
  Benjamin
