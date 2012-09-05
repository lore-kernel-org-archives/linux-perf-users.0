From: Joel Uckelman <joel@lightboxtechnologies.com>
Subject: duplicate cache misses counter labels with perf-stat
Date: Wed, 5 Sep 2012 17:21:10 +0200
Message-ID: <CAB04Epfe1n0R3HHi217YJzazh4ejWJk2-Ww1r55X0=q__WftwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:58252 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab2IEPVL (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 5 Sep 2012 11:21:11 -0400
Received: by vbbff1 with SMTP id ff1so227246vbb.19
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Sep 2012 08:21:10 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

When I do this with perf 3.5.2,

  perf stat -x, -e
L1-dcache-loads,L1-dcache-load-misses,L1-dcache-stores,L1-dcache-store-misses
ls

I'm seeing this output from perf:

  697171,L1-dcache-loads

  28012,L1-dcache-misses

  455691,L1-dcache-stores

  11791,L1-dcache-misses

So, I'm getting two results labeled "L1-dcache-misses" (with different
values!) and none labeled "L1-dcache-store-misses". It looks to me
like one of the "L1-dcache-misses" is mislabeled.

There appears to be a general problem with all of the *-misses
counters, as a similar thing happens with, e.g., LLC-load-misses and
LLC-store-missses, and all of the others I've checked.

Is this a bug, or am I misunderstanding how perf-stat is supposed to work?
