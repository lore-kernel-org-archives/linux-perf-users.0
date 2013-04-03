From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Fw: Re: Re: Howto make perf probe work
Date: Wed, 03 Apr 2013 17:09:04 +0900
Message-ID: <87y5d0doin.fsf@sejong.aot.lge.com>
References: <201304010130139026692@gmail.com>
	<CAGJbQddYW4-QZUvGpwCbmVhsvGEan5UkgRbXq+w4i+9Ob9vUrw@mail.gmail.com>
	<201304012320294652937@gmail.com> <201304012324395211298@gmail.com>
	<201304021710591525728@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:55419 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758886Ab3DCIJI (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 3 Apr 2013 04:09:08 -0400
In-Reply-To: <201304021710591525728@gmail.com> (osdepend@gmail.com's message
	of "Tue, 2 Apr 2013 17:11:01 +0800")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: OSDepend <osdepend@gmail.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>, nelakurthi koteswararao <koteswararao18@gmail.com>

Hi,

On Tue, 2 Apr 2013 17:11:01 +0800,
>> For some reason, do_page_fault() is marked as __kprobe on some arch
>> which means it cannot be probed.
>
> My kernel is runing on X86_64 arch, is there any chance for me to get the do_page_fault() entry/exit work?

nope, AFAIK.


> Or How can i add a exit tracepoint for handle_mm_fault()? so I can calculate the latency of that fault handle function?

Try "perf probe -a entry=handle_mm_fault -a exit=handle_mm_fault%return"


Thanks,
Namhyung
