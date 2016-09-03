From: Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: profiling Firefox, no perf-<PID>.map file
Date: Sat, 03 Sep 2016 20:53:26 +0200
Message-ID: <1472928806.2377.2.camel@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41408 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753600AbcICSxs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 3 Sep 2016 14:53:48 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F05DDABDE
        for <linux-perf-users@vger.kernel.org>; Sat,  3 Sep 2016 18:53:14 +0000 (UTC)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

when profiling firefox with perf (i.e. `perf top` or `perf record`) I
get errors like "Failed to open /tmp/perf-<PID>.map, continuing
without symbols". The perf docs says it has to do with the support for
JIT'ed code (tools/perf/Documentation/jit-interface.txt), which I
guess is produced by firefox' javascript engine (I could be wrong).

The documentation is a bit vague on how to have those perf-<PID>.map
files produced correctly, and the original commit introducing this
feature, 80d496be89ed "perf report: Add support for profiling JIT
generated code" only says "A JIT compiler is required [...]".

Is there a way to profile firefox and get those *.map files?
It's more of a curiosity, I am new to perf and I'm playing around.

Thanks,
Giovanni
