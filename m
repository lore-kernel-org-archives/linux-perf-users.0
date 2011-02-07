From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: Profiling a program's runtime
Date: Mon, 7 Feb 2011 18:38:31 -0200
Message-ID: <20110207203831.GE4470@ghostprotocols.net>
References: <ukft18-pba.ln1@burns.bruehl.pontohonk.de>
 <4D4C4105.3050002@cisco.com>
 <0E02F16954AF394BB163AEE50FDF548568FE033612@GVW1121EXC.americas.hpqcorp.net>
 <201102042048.09677.bartoschek@gmx.de>
 <0E02F16954AF394BB163AEE50FDF548568FE033642@GVW1121EXC.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61255 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752038Ab1BGUig (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 7 Feb 2011 15:38:36 -0500
Received: by gwj20 with SMTP id 20so1893226gwj.19
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Feb 2011 12:38:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <0E02F16954AF394BB163AEE50FDF548568FE033642@GVW1121EXC.americas.hpqcorp.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Maucci, Cyrille" <cyrille.maucci@hp.com>
Cc: Christoph Bartoschek <bartoschek@gmx.de>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>

Em Fri, Feb 04, 2011 at 07:57:00PM +0000, Maucci, Cyrille escreveu:
> Yep. I was not promoting caliper here.
> I was just referring to it so that we may get an idea of what he'd like to see in 'perf' reports.

Right, useful pointers, thanks, barring patents, I think we can get that
with perf at some point.

Catering to I/O bound workloads is something that is in the radar, has
been experimented with and should resume development soon, please take a
look at the 'trace' description at:

http://lwn.net/Articles/415728/

The discussion also has lots of useful suggestions and insights.

It is an area that badly needs help to get the perf infrastructure to
the next level, beyong the current state of good (excellent?) CPU bound
profiling.

- Arnaldo
