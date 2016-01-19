From: Benjamin King <benjaminking@web.de>
Subject: Re: perf tracepoints for regular user?
Date: Tue, 19 Jan 2016 06:02:44 +0100
Message-ID: <20160119050244.GA13183@localhost>
References: <20160115210516.GA6329@localhost>
 <4927145.OUESRpdSEU@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:51052 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750698AbcASFCs (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 19 Jan 2016 00:02:48 -0500
Content-Disposition: inline
In-Reply-To: <4927145.OUESRpdSEU@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Linux perf users <linux-perf-users@vger.kernel.org>

Hi Milian,

On Sun, Jan 17, 2016 at 10:20:00PM +0100, Milian Wolff wrote:
>On Freitag, 15. Januar 2016 22:05:16 CET Benjamin King wrote:
>> I am trying to use 'perf stat -e uprobes:xyz' on a tracepoint that I have
>> previously set, but with no success.
>Try these commands:
>
>$ sudo mount -o remount,mode=755 /sys/kernel/debug
>$ sudo mount -o remount,mode=755 /sys/kernel/debug/tracing
>$ echo \"-1\" | sudo tee /proc/sys/kernel/perf_event_paranoid

Hm, that does not work for me. I can do the first remount, but not the
second:
-----
$ sudo mount -o remount,mode=755 /sys/kernel/debug/tracing
mount: can't find /sys/kernel/debug/tracing in /etc/fstab
$ mount|grep debug
none on /sys/kernel/debug type debugfs (rw,mode=755,mode=755)
-----

And then, I still can not see tracepoints as a regular user:
-----
$ perf list tracepoint

List of pre-defined events (to be used in -e):

$ 
-----

If this works for you, then maybe it's my version? I'm on 4.2.3


Cheers,
  Benjamin
