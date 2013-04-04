From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Fw: Re: Re: Howto make perf probe work
Date: Thu, 04 Apr 2013 15:05:54 +0900
Message-ID: <876202esot.fsf@sejong.aot.lge.com>
References: <201304010130139026692@gmail.com>
	<CAGJbQddYW4-QZUvGpwCbmVhsvGEan5UkgRbXq+w4i+9Ob9vUrw@mail.gmail.com>
	<201304012320294652937@gmail.com> <201304012324395211298@gmail.com>
	<201304021710591525728@gmail.com> <201304040128323646722@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:57383 "EHLO
	LGEMRELSE7Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756556Ab3DDGF4 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 4 Apr 2013 02:05:56 -0400
In-Reply-To: <201304040128323646722@gmail.com> (osdepend@gmail.com's message
	of "Thu, 4 Apr 2013 01:28:34 +0800")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: OSDepend <osdepend@gmail.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>, nelakurthi koteswararao <koteswararao18@gmail.com>

Hi,

On Thu, 4 Apr 2013 01:28:34 +0800, OSDepend wrote:
>> On Tue, 2 Apr 2013 17:11:01 +0800, OSDepend wrote:
>> >> For some reason, do_page_fault() is marked as __kprobe on some arch
>> >> which means it cannot be probed.
>> >
>> > My kernel is runing on X86_64 arch, is there any chance for me to get the do_page_fault() entry/exit work?
>> nope, AFAIK.
> Is there any guide for us to decide which tracepoint (or other kernel symbol) canbe used, and which cannot? 
> For some of the kallsyms cannot be used directly. Such as  do_raw_spin_lock.
> 	perf probe -a test=do_raw_spin_lock
>     Fatal: Kernel symbol 'do_raw_spin_lock' not found - probe not added. 

Hmm.. it seems not, currently.

Maybe we can change perf to output the symbol was not able to be probed
after checking symbol address and it's between
__kprobes_text_{start,end}.

I'll take a look at it later.

Thanks,
Namhyung
