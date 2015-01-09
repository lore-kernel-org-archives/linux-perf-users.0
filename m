From: fche@redhat.com (Frank Ch. Eigler)
Subject: Re: Size of perf data files
Date: Thu, 08 Jan 2015 21:06:37 -0500
Message-ID: <y0mlhlcemhe.fsf@fche.csb>
References: <CALQF7ZygJpx=Lf0Dc70=cRRCheF_8SFos8sv8z0kjiog2Do0Zg@mail.gmail.com>
	<87ppas31sq.fsf@tassilo.jf.intel.com>
	<CALQF7ZzpLB3Ch3=nn5yi23eneqwXnEpFTq6dX4BT7dLYvxcVXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42558 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129AbbAICIL (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 8 Jan 2015 21:08:11 -0500
In-Reply-To: <CALQF7ZzpLB3Ch3=nn5yi23eneqwXnEpFTq6dX4BT7dLYvxcVXw@mail.gmail.com> (Yale Zhang's message of "Tue, 6 Jan 2015 13:02:23 -0800")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Yale Zhang <yzhang1985@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

Yale Zhang <yzhang1985@gmail.com> writes:

> [...]
> I've already tried lowering the size of each sample from 8KiB to 512,
> but that only allows storing 2 or 3 parent function calls, which isn't
> enough for me.
>
> "don't use dwarf unwinding."
> The main reason I'm trying to switch from Zoom to perf is because it
> supports dwarf unwinding! [...]

You may wish to try systemtap.  Its backtracing uses in-situ dwarf
unwinding, and is pretty fast.  Each sample costs not 4K+ of stack
snapshots, but a hexadecimal pc-list or optionally symbolic backtrace
string.  The downside is that the programs that you may be backtracing
need to be identified at stap invocation - ahead of time - via
something like:

  % stap -d /bin/foo -d /usr/lib64/libbar.so --ldd --all-modules SCRIPT.stp

See e.g. https://sourceware.org/systemtap/examples/#profiling/pf4.stp

- FChE
