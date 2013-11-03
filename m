From: Vivek Nair <vivekaxl@gmail.com>
Subject: Cache Misses
Date: Sat, 2 Nov 2013 21:43:20 -0400
Message-ID: <CAOWdYyU3SDd8UDUYUWNqxKhxTBcJ=JsznQbZxykGv-qBEyPrLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:62091 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab3KCBnl (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 2 Nov 2013 21:43:41 -0400
Received: by mail-vb0-f46.google.com with SMTP id 10so595978vbe.33
        for <linux-perf-users@vger.kernel.org>; Sat, 02 Nov 2013 18:43:41 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users <linux-perf-users@vger.kernel.org>

Hello,

I am trying to get the performance counters (cache reference, cache
misses) using the counting mode for hadoop which is running on a
physical machine. The various processes of hadoop is contained inside
a cgroup. I am trying to get information using the following script

perf stat -B -a -e cache-references,cache-misses  -G cgroup_hadoop sleep 1

But, I am getting cache misses to be  197.478 (percent) of all cache refs

My question is how can I have cache-misses which is greater than the
cache-reference? I have multiple occurrences where the cache-misses is
more that the cache reference. Is there something wrong with the way I
am measuring the performance counters.

Regards,
Vivek Nair
