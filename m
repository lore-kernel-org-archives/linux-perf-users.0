From: Benjamin King <benjaminking@web.de>
Subject: uretprobe occasionally fires twice
Date: Tue, 8 Aug 2017 20:56:58 +0200
Message-ID: <20170808185658.GA17828@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:51520 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752356AbdHHS5A (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Aug 2017 14:57:00 -0400
Received: from localhost ([77.23.101.92]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MIvJx-1ddDk33UqH-002bhv for
 <linux-perf-users@vger.kernel.org>; Tue, 08 Aug 2017 20:56:58 +0200
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,
 
I have placed a uprobe and a uretprobe on the same function in libc. When
perf record'ing a larger test where the function is called from multiple
threads, I can occasionally see the following sequence of events in a 'perf
script':
  
  1) uretprobe fires
  2) uprobe fires
  3) uretprobe fires again

More specifically, I am tracing libc's realloc. Since I trace the size of
the memory in question, I think that the uretprobe in 1) is called at
function entry.

This only happens occasionally and I unfortunately I could not reproduce it
with a small testcase yet.

'perf script' prints two warnings:
  * Processed 17216221 events and lost 2 chunks!
  * 114 out of order events recorded.

Could this explain the duplicated output? Are there other known circumstances
where a uretprobe could be unreliable in some way?

Cheers,
  Benjamin
