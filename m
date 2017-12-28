From: David Hinkle <david.hinkle@securly.com>
Subject: Re: Trying to understand some strange samples in a perf profile
Date: Thu, 28 Dec 2017 15:31:41 -0800
Message-ID: <CAOrDofTn68XiBjEvF=boM94LwfXUt_W-AhCoOsK7aijiOknyfQ@mail.gmail.com>
References: <db0e4795-de77-ac92-6bab-4b4d451daf26@lal.in2p3.fr>
 <9831756.pFeoWVMjH9@milian-kdab2> <6d2adf7a-b181-a8ed-2069-6063abadf6a1@lal.in2p3.fr>
 <2337765.oK3dqqyzHo@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:46570 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754269AbdL1Xbm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Dec 2017 18:31:42 -0500
Received: by mail-it0-f52.google.com with SMTP id c16so5459548itc.5
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Dec 2017 15:31:42 -0800 (PST)
In-Reply-To: <2337765.oK3dqqyzHo@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Hadrien Grasland <grasland@lal.in2p3.fr>, linux-perf-users@vger.kernel.org

> - build a minimal "unwinder" application for libunwind e.g.
> - notify libunwind about all mmap events
> - install the register and stack state from the per.data file
> - try to unwind, see what happens

I'm having some problems with perf dwarf stack unwindings that stop at
the kernel/userspace boundary and some userspace stacks that aren't
unwinding at all on 4.9.70 I'd really love to shed some light on.
Similar situation, in my case the stacks are in libc-2.17.so, which I
think is symbolized properly (Other traces are unwinding through this
library fine).  I'm also using libdw for unwinding and not libunwind.

I'd love to be able to do the above 4 things in an app and see if I
can figure out why it's not unwinding properly.   Do you have some
example code that can do that?  If you do now or you write it please
share.
