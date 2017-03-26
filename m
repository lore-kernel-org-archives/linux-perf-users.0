From: Yijie Shen <henry.yijieshen@gmail.com>
Subject: toplev would hang forever when analyzing a program with PID
Date: Sun, 26 Mar 2017 22:07:44 +0800
Message-ID: <CADGfq7zQv_3B-vYkTi8p1SQ=xcjyp3cVBAGaL=P7-gUBobbDzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:32789 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbdCZOHq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 26 Mar 2017 10:07:46 -0400
Received: by mail-wr0-f179.google.com with SMTP id w43so10406331wrb.0
        for <linux-perf-users@vger.kernel.org>; Sun, 26 Mar 2017 07:07:45 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

I'm planning to do some exploration on my program performance using
toplev, but faced with these problems:

when I called toplev.py -l1 ls, it stoped gracefully with the following output:

Will measure complete system.
Using level 1.
Nodes Backend_Bound Frontend_Bound have errata HSD135
perf stat -x\; -e
'{cpu/event=0x3c,umask=0x0,any=1/,cpu/event=0xe,umask=0x1/,cpu/event=0x9c,umask=0x1/,cpu/event=0xd,umask=0x3,any=1,cmask=1/,cpu/event=0xc2,umask=0x2/}'
-A -a ls

S0-C0    FE      Frontend_Bound:                51.94 % Slots
[100.00%] This category represents slots fraction where the
processor's Frontend undersupplies its Backend...
S0-C0    BE      Backend_Bound:                 24.73 % Slots
[100.00%] This category represents slots fraction where no uops are
being delivered due to a lack of required resources for
accepting new uops in the Backend...
S0-C1    FE      Frontend_Bound:                37.89 % Slots
[100.00%]S0-C1    BE      Backend_Bound:                 33.91 % Slots
    [100.00%]S1-C4    FE      Frontend_Bound:                82.60 %
Slots     [100.00%]S1-C4    RET     Retiring:
88.53 % Slots     [100.00%]


but toplev would hang forever when it was called to analyze a program using pid:

toplev.py -l1 -- --pid 29297
Will measure complete system.
Using level 1.
Nodes Backend_Bound Frontend_Bound have errata HSD135
perf stat -x\; -e
'{cpu/event=0x3c,umask=0x0,any=1/,cpu/event=0xe,umask=0x1/,cpu/event=0x9c,umask=0x1/,cpu/event=0xd,umask=0x3,any=1,cmask=1/,cpu/event=0xc2,umask=0x2/}'
-A -a --pid 29297


this would hang forever even if the process with such pid end, this
happens whatever the pid is pointing at is, a Java process or a Linux
tool such as top.


Am I doing something wrong? What does the right command look like to
analyze a program using PID?


Thanks in advance.

Yours,
Yijie
