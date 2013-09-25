From: Luke Gorrie <luke@snabb.co>
Subject: First time user, problem with toplev.py levels (-l)
Date: Wed, 25 Sep 2013 13:44:41 +0200
Message-ID: <CAA2XHbcy6qSvm_s=XPdp3GuXHgTAQqtiDZ1cgvM5rZMF9f00RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:59530 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684Ab3IYLon (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 25 Sep 2013 07:44:43 -0400
Received: by mail-bk0-f50.google.com with SMTP id mz11so2206793bkb.37
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Sep 2013 04:44:42 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Howdy!

I'm a first-time user of toplev.py today. The -l option isn't working
for me, and I'm wondering if someone can help me understand why?

I've tested with a few different programs under test and combinations
of -l<n>, -v, and -d. No luck yet. Here's an example below:

$ uname -a
Linux chur 3.11.0-8-generic #15-Ubuntu SMP Fri Sep 20 04:11:26 UTC
2013 x86_64 x86_64 x86_64 GNU/Linux
$ perf --version
perf version 3.11.1
$ git log | head -1
commit c765cf1ae73efce887468abf4c7a3f4fbe549763
$ ./toplev.py -v -d -l4 sleep 5
WARNING: HT enabled
Measuring multiple processes/threads on the same core may not be reliable.
perf stat -x, -e '{r2c2,r100030d,r19c,r10e,cycles}' sleep 5
Frontend Bound:                                 10.11% below
        This category reflects slots where the Frontend of the
processor undersupplies
        its Backend.
Bad Speculation:                                 9.05% below
        This category reflects slots wasted due to incorrect speculations, which
        include slots used to allocate uops that do not eventually get
retired and
        slots for which allocation was blocked due to recovery from
earlier incorrect
        speculation. For example, wasted work due to miss-predicted branches is
        categorized under the Bad Speculation category
Backend Bound:                                  59.36% above
        This category reflects slots where no uops are being delivered
due to a lack
        of required resources for accepting more uops in the Backend
of the pipeline.
Retiring:                                       21.48% below
        This category reflects slots utilized by good uops i.e.
allocated uops that
        eventually get retired.

any tips would be much appreciated.

Cheers,
-Luke
