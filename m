From: Marina Moran <esperandoelmilagro@gmail.com>
Subject: event for speculative executed instruction
Date: Wed, 20 May 2015 10:45:42 -0300
Message-ID: <CAP5Bk4hT3sSRprB6JP7NYbuG7fQdsK70NMNqqtPgpJM0TzfaGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:36134 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435AbbETNpn (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 20 May 2015 09:45:43 -0400
Received: by lagv1 with SMTP id v1so74892338lag.3
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2015 06:45:42 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi All,

We need to measure over two Intel computers the instruction executed
in a speculative manner, but not commited. We need to measure how many
instructions are discarded (over a period of time), to see how the
speculative execution is working. We check the manual with the
Performance Monitoring Events (from Intel) but cant figure out which
event to monitor. If you could please know where to look for it, or
with which name we shoudl look for it.

The intels are:
Intel Xeon CPU E5-2630 0 @ 2.30GHz
Intel Core2 Quad CPU    Q6600  @ 2.40GHz

Thanks so much in advance.
regards
Marina
