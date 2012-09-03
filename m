From: Arkaprava Basu <arkaprava.basu@gmail.com>
Subject: Collecting raw PEBS sample using perf
Date: Mon, 3 Sep 2012 16:35:21 -0500
Message-ID: <CAErB21jqztpUcyvzcPmMntyLQzO6=V73ZgNecRccngsH1T4-Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:61516 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645Ab2ICVfW (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 3 Sep 2012 17:35:22 -0400
Received: by ieje11 with SMTP id e11so3993266iej.19
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Sep 2012 14:35:21 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

   I need to collect raw hardware dumped PEBS (precise event based
sampling) records (i.e., dump of architectural state) on sampled DTLB
miss events.  I need the dump of the architectural state since I plan
to use it regenerate address trace of the sampled DTLB miss event.  I
was trying to use perf (kernel version 2.6.39) to record PEBS samples.
Following is an example of a common I was using.

perf record -e r80cb:pp -o ls_k.out -c 1000 /bin/ls   (the raw event
number 80cb is for load DTLB miss)

However, it seems like this does not dump the PEBS records written by
the hardware and only dumps the processed samples collected by the
perf tool. I was wondering if there is a way to get perf dump the raw
PEBS record in the output file.

Does somebody know how raw PEBS dumps can be collected?

Thanks
Arka
