From: OSDepend <osdepend@gmail.com>
Subject: Re: Re: Fw: Re: Re: Howto make perf probe work
Date: Thu, 4 Apr 2013 01:28:34 +0800
Message-ID: <201304040128323646722@gmail.com>
References: <201304010130139026692@gmail.com>,
 <CAGJbQddYW4-QZUvGpwCbmVhsvGEan5UkgRbXq+w4i+9Ob9vUrw@mail.gmail.com>,
 <201304012320294652937@gmail.com>,
 <201304012324395211298@gmail.com>,
 <201304021710591525728@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:32824 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756011Ab3DCR2l (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 3 Apr 2013 13:28:41 -0400
Received: by mail-pb0-f53.google.com with SMTP id un15so960287pbc.26
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Apr 2013 10:28:41 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>, nelakurthi koteswararao <koteswararao18@gmail.com>

Hi,

> > Or How can i add a exit tracepoint for handle_mm_fault()? so I can calculate the latency of that fault handle function?

> Try "perf probe -a entry=handle_mm_fault -a exit=handle_mm_fault%return"

That's works nicely for me! 
Thanks a lot!!

> On Tue, 2 Apr 2013 17:11:01 +0800,
> >> For some reason, do_page_fault() is marked as __kprobe on some arch
> >> which means it cannot be probed.
> >
> > My kernel is runing on X86_64 arch, is there any chance for me to get the do_page_fault() entry/exit work?
> nope, AFAIK.
Is there any guide for us to decide which tracepoint (or other kernel symbol) canbe used, and which cannot? 
For some of the kallsyms cannot be used directly. Such as  do_raw_spin_lock.
	perf probe -a test=do_raw_spin_lock
    Fatal: Kernel symbol 'do_raw_spin_lock' not found - probe not added. 
		
Best,
Chen
