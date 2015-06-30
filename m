From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: perf probe an addr without debuginfo
Date: Tue, 30 Jun 2015 16:37:09 +0900
Message-ID: <55924725.5010504@hitachi.com>
References: <CAE40pdemFG8f7EB6SerUEGeK0G2qeztqzeLCnLigB3TdgY6G1Q@mail.gmail.com> <20150628154651.GA3953@localhost> <20150629150038.GA1225@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from fallback.hitachi.co.jp ([133.145.228.50]:58071 "EHLO
	mailxx.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbbF3IPB (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 30 Jun 2015 04:15:01 -0400
Received: from mail4.hitachi.co.jp (mail4.hitachi.co.jp [133.145.228.5])
	by mailxx.hitachi.co.jp (Postfix) with ESMTP id 76E4F1770290
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2015 16:37:15 +0900 (JST)
In-Reply-To: <20150629150038.GA1225@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Benjamin King <benjaminking@web.de>, Brendan Gregg <brendan.d.gregg@gmail.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>, cti.systems-productivity-manager.ts@hitachi.com

On 2015/06/30 0:00, Arnaldo Carvalho de Melo wrote:
> Em Sun, Jun 28, 2015 at 05:46:51PM +0200, Benjamin King escreveu:
>> Hi Brendan
>>
>>> Is there a trick to getting perf to probe a user-level address without
>>> debuginfo? Eg (on Linux 4.0):
>>> [...]
>>> I can do this using ftrace ok, eg, "p:tick_0x583 /root/tick:0x583"
>>> works. Thanks,
>>
>> Not quite what you have asked for, but you can add the probe via ftrace and
>> then use it from perf. Probes from /sys/kernel/debug/tracing/uprobe_events
>> will show up in 'perf list' as well.
> 
> Masami,
> 
> 	Is this already possible?

Yes, it should be possible. However, I don't recommend you to
probe the address inside a function without debuginfo. You must
check the instruction boundary in that case.

> 
> - Arnaldo
> 
> P.S.: If you're not subscribed to this list, please consider it :-)

Oh, I didn't know the list! I will.
Thanks!

> 


-- 
Masami HIRAMATSU
Linux Technology Research Center, System Productivity Research Dept.
Center for Technology Innovation - Systems Engineering
Hitachi, Ltd., Research & Development Group
E-mail: masami.hiramatsu.pt@hitachi.com
