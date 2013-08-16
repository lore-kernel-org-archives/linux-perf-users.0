From: Peipei Wang <wangpeipei.90@gmail.com>
Subject: Does perf record does overflowing per thread over multiprocess?
Date: Fri, 16 Aug 2013 01:33:50 -0400
Message-ID: <CAEuYUer0NTVBfwpenOKLhZGHPyhGSTHOFejkjHECfmPSqDmJAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170]:46834 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439Ab3HPFdv (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 16 Aug 2013 01:33:51 -0400
Received: by mail-ve0-f170.google.com with SMTP id 15so1175245vea.15
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Aug 2013 22:33:50 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: perf group <linux-perf-users@vger.kernel.org>, David Ahern <dsahern@gmail.com>

Hi David/All,

I have a multi-thread process, If I use the method of perf record -p
pid, does perf do the OVERFLOWING on the per-THREAD mode or
per-PROCESS mode??

Another question is similar, if what I have is a multi-process
program, one process spawns other processes. To make it complicate,
each process could still be a Multi-thread process. I give the first
process pid to perf record -p pid, does perf do OVERFLOWING on the
per-THREAD mode or per-PROCESS mode or per-CORE or ALL-CPUs mode??

The third question is just one I want to make sure:

Although I get the information that perf record use per-thread as
default mode, when I check the multi-thread program, given the command
running this program to perf record like "perf record -e cycles java
Helloworld", I find that:
           some timestamps are so close to each other that I begin to
doubt if the above perf calculates perf counter values over the whole
process, rather than calculate perf event counters for each thread.

Thanks again for your help very much.

Best wishes.
Yours,
Wang Peipei
