From: Johan Tibell <johan.tibell@gmail.com>
Subject: Symbols not decoded in 0.0.2.PERF
Date: Tue, 19 Apr 2011 13:22:02 +0200
Message-ID: <BANLkTike-f9qjdtjce+uiAPrjXgucn=5xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43357 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844Ab1DSL3A (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 19 Apr 2011 07:29:00 -0400
Received: by pwi15 with SMTP id 15so2701676pwi.19
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Apr 2011 04:28:59 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I'm trying to use perf record/report on a non-stripped, Haskell binary
(i.e. compiled using GHC). Unfortunately, not all symbols are
decoded*:

    75.28%            bench  ./bench                    [.] 0x000000002b612b
     7.11%            bench  /lib/libc-2.11.1.so        [.] memcpy
     5.47%            bench  ./bench                    [.] 0x0000000000438f
     3.47%            bench  ./bench                    [.] allocate
     1.86%            bench  ./bench                    [.] s1Ol_info
     1.65%            bench  ./bench                    [.] s1Ok_info
     0.62%            bench  ./bench                    [.] memcpy@plt
     0.48%            bench  ./bench                    [.] clearNurseries
     0.33%            bench  ./bench                    [.] evacuate1
     0.24%            bench  ./bench                    [.] GarbageCollect

How can I figure out what 0x000000002b612b corresponds to?

perf version: 0.0.2.PERF (installed from Ubuntu package)
Kernel version: 2.6.32

$ cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 44
model name	: Intel(R) Xeon(R) CPU           X5650  @ 2.67GHz

* It could be the case that GHC is generating symbols that perf cannot
interpret somehow. If we can confirm this is the case we can try to
fix that.

-- Johan
