From: Manuel Selva <selva.manuel@gmail.com>
Subject: Per thread sampling
Date: Wed, 19 Feb 2014 16:00:45 +0100
Message-ID: <CALbiyZwOjpfppitvPgJkHa8=L9XhD0Bq9d0sxgucMBo6tukk=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:52607 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753771AbaBSPAr (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 19 Feb 2014 10:00:47 -0500
Received: by mail-lb0-f179.google.com with SMTP id l4so363136lbv.38
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2014 07:00:45 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

I just tried in a 2-threaded application to call twice (one call for
each thread) perf_event_open syscall with parameters configured to do
sampling on MEM INST RETIRED.LATENCY ABOVE THRESHOLD event. Both call
succeed.

"mmaping" the file descriptor return by the first call succeed but
"mmaping" the second file descriptor results in a "Operation not
permitted" error (errno = 1).

A work around could be to sample all threads (with pid = -1) including
pid and tid in samples and filter samples at processing time. Before
switching to this solution I wanted to ask if this a known limitation
of the syscall, an error from my side, or a bug  (the man page doesn't
answer to this question) ?

Thanks,

Manu
