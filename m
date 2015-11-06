From: =?UTF-8?B?Sm9zw6kgU2ltw6Nv?= <jose.m.simao@gmail.com>
Subject: observations at periodic intervals
Date: Fri, 6 Nov 2015 21:06:14 +0000
Message-ID: <CAJ38vxsyHv4+SDHhP_YKMFAf-5i_S2Hp+T-0oc4RtsEgdGFodg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:33406 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965993AbbKFVGQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 6 Nov 2015 16:06:16 -0500
Received: by lffz63 with SMTP id z63so10054025lff.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2015 13:06:14 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Dear user of linux-perf-users@vger.kernel.org,

When using the -I option of 'stat' to periodically collect the value
of performance counters (e.g. perf stat -e cache-misses -I 500 cmd)
the reported value at each internal (500ms in the example) is how much
the selected counter increased since the last observation?

I assume it is because the values are not monotonically increasing.

Best,
Jose
