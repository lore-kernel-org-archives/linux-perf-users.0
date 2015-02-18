From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Weird instruction profiling
Date: Wed, 18 Feb 2015 01:57:50 -0800
Message-ID: <CAE40pddnqg-H-YqvyHodw1ME6W9_7et151+=O9y=S7sHB0an7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34103 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbbBRJ6L (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 18 Feb 2015 04:58:11 -0500
Received: by mail-ig0-f181.google.com with SMTP id hn18so688328igb.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Feb 2015 01:58:10 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>

G'Day,

I was profiling and noticed some odd instruction counts, and boiled it
down to a 16 NOP loop:

# perf annotate -i perf.data.noplooper --stdio
 Percent |      Source code & Disassembly of noplooper
--------------------------------------------------------
         :
         :      Disassembly of section .text:
         :
         :      00000000004004ed <main>:
    0.00 :        4004ed:       push   %rbp
    0.00 :        4004ee:       mov    %rsp,%rbp
   20.86 :        4004f1:       nop
    0.00 :        4004f2:       nop
    0.00 :        4004f3:       nop
    0.00 :        4004f4:       nop
   19.84 :        4004f5:       nop
    0.00 :        4004f6:       nop
    0.00 :        4004f7:       nop
    0.00 :        4004f8:       nop
   18.73 :        4004f9:       nop
    0.00 :        4004fa:       nop
    0.00 :        4004fb:       nop
    0.00 :        4004fc:       nop
   19.08 :        4004fd:       nop
    0.00 :        4004fe:       nop
    0.00 :        4004ff:       nop
    0.00 :        400500:       nop
   21.49 :        400501:       jmp    4004f1 <main+0x4>

Despite millions of samples, many NOPs are never seen. (See the
Percent column.) I'm not using PEBS, but I suppose I should.

I think Andi mentioned this to me last year -- that instruction
profiling was no longer reliable. At the time I hadn't been bitten by
it, but now I have!

Is this due to parallel and out-of-order execution? (ie, we're
sampling the instruction pointer, but that's set to the resumption
instruction, not the instructions being processed in the backend?).
Thanks,

Brendan
