From: Andrew Davidoff <davidoff@qedmf.net>
Subject: Getting started with perf; a couple of questions
Date: Thu, 30 May 2013 23:26:11 -0600
Message-ID: <CAJLXCZTs4i0P3wA78u25aCt-rfcsBNQ8t0QSsbWazQyoV-XdLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:38064 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743Ab3EaF0M (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 31 May 2013 01:26:12 -0400
Received: by mail-ie0-f172.google.com with SMTP id 17so2909914iea.31
        for <linux-perf-users@vger.kernel.org>; Thu, 30 May 2013 22:26:11 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I am getting started with perf and have a couple of questions.

* Does the version of perf being used need to be built from the source
for the running kernel, or is it supported to use a build from a newer
kernel source? I am currently running perf built from 3.9.4 kernel
sources on a machine running kernel 2.6.32.

* I am getting event output with a specific `perf stat` invocation,
but when I run the same invocation under `perf record`, `perf report`
complains "The perf.data file has no samples". Why would that be? The
invocation looks like this:

perf record -e cache-misses,page-faults,minor-faults,major-faults,cpu-migrations,L1-dcache-load-misses,L1-dcache-store-misses,L1-icache-load-misses,LLC-load-misses,LLC-store-misses,dTLB-load-misses,dTLB-store-misses,iTLB-load-misses
-- {program} {arg} {arg} ... {arg}


Any info/advice is appreciated.

Thanks.
Andy
