From: Luke Gorrie <luke@snabb.co>
Subject: Signal on PMU event?
Date: Sun, 20 Apr 2014 20:45:08 +0200
Message-ID: <CAA2XHbfJdXBzxF8=FCpBv5pM76XOPBY5av5np0dNkr4CYU0Jrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:52010 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbaDTSpK (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 20 Apr 2014 14:45:10 -0400
Received: by mail-lb0-f180.google.com with SMTP id 10so2605817lbg.39
        for <linux-perf-users@vger.kernel.org>; Sun, 20 Apr 2014 11:45:08 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Howdy!

Is it possible for a self-profiling program to receive a signal (e.g.
SIGPROF) driven by a chosen PMU event (e.g. cache-misses, etc)?

I'm using a SIGITIMER-driven profiler (LuaJIT's one) and it would be
wonderfully convenient to be able to switch the event source while
keeping the signal-driven flow.

Cheers,
-Luke (a big perf tools fan)
