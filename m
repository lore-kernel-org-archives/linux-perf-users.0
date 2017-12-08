From: David Hinkle <david.hinkle@securly.com>
Subject: Discrepency between `perf script` and `perf report` output for flame graphs
Date: Fri, 8 Dec 2017 13:18:11 -0800
Message-ID: <CAOrDofSv21YsB+mMNjHwnHB78qkhdrPS0P9SpuK=Q6pzz0pnSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:47083 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753653AbdLHVSN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Dec 2017 16:18:13 -0500
Received: by mail-io0-f182.google.com with SMTP id x129so3747442iod.13
        for <linux-perf-users@vger.kernel.org>; Fri, 08 Dec 2017 13:18:12 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I'm using perf to generate flame graphs.  The default approach for
this uses `perf script` to output stack traces.

Many of my traces, however, don't seem to have a stack associated with
them.  I've worked pretty hard to fully symbolize this EC2 instance,
so I don't think its something as simple as missing symbols, but
obviously I could have just made a mistake.   I see many lines like
this in the perf script output:

squid  2779 [000]  2007.460853:   10101010 cpu-clock:

I.E., everything but the stack trace.

When use the following to generate the folded stack traces:

perf report --stdio --no-children -n -g folded,0,caller,count -s comm

Those anomalies disappear.   But, they disappear in such a way that
makes me suspicious that they've been simply discarded.

Is there an approach I can use to try to identify what might be
missing symbols, if missing symbols is the likely problem?   Can
anybody shed any light on why the two methods might be producing
different output?
