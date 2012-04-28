From: David Wragg <david@wragg.org>
Subject: LLC-* events not working on sandybridge
Date: Sun, 29 Apr 2012 00:03:14 +0100
Message-ID: <sa7r4v7foi5.fsf@wragg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63932 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068Ab2D1XDS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 28 Apr 2012 19:03:18 -0400
Received: by wgbdr13 with SMTP id dr13so1883965wgb.1
        for <linux-perf-users@vger.kernel.org>; Sat, 28 Apr 2012 16:03:17 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I've run into a problem with perf on an Intel Sandybridge machine: The
LLC-* events never seem to trigger.

For example:

$ perf stat -e LLC-load-misses ls /
[...]
                 0 LLC-load-misses

       0.001082639 seconds time elapsed

Non-LLC events work fine:

$ perf stat -e cache-misses ls /
[...]
             4,272 cache-misses

       0.002945606 seconds time elapsed

This is on a Intel i5 machine (i5-2520M), running a fully updated Fedora
16 ('perf --version': 3.3.2-6.fc16.x86_64, 'uname -r':
3.3.2-6.fc16.x86_64).

Any ideas?

David
