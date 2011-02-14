From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [perfmon2] updating perf tool
Date: Mon, 14 Feb 2011 18:48:30 -0200
Message-ID: <20110214204830.GF21384@ghostprotocols.net>
References: <AANLkTim5QGwisxLEHHHECrE1nLSYFxzXEMu7hvTRy09=@mail.gmail.com>
 <AANLkTi=h6Qb7aCB0wER-FEGMwkD6xp1sBgnQudTZ=e+x@mail.gmail.com>
 <AANLkTimqRjUTzv+AO7zHCfXvA1RZFDTjyb-r0s_MVNTW@mail.gmail.com>
 <AANLkTinYM-Sg2uQFkXFy25mSZZZEtTSAUNrA==CxJP0=@mail.gmail.com>
 <20110214194428.GE21384@ghostprotocols.net>
 <AANLkTikfaAbdFWzcvayOjYLNECKf_L08nUUEWUy=p8it@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52916 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab1BNUsf (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 14 Feb 2011 15:48:35 -0500
Received: by yxt3 with SMTP id 3so2247908yxt.19
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Feb 2011 12:48:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikfaAbdFWzcvayOjYLNECKf_L08nUUEWUy=p8it@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <arun@sharma-home.net>
Cc: Can Hankendi <hankendi@gmail.com>, linux-perf-users@vger.kernel.org

Em Mon, Feb 14, 2011 at 12:08:28PM -0800, Arun Sharma escreveu:
> On Mon, Feb 14, 2011 at 11:44 AM, Arnaldo Carvalho de Melo wrote

> >> http://perfmon2.git.sourceforge.net/git/gitweb.cgi?p=perfmon2/libpfm4;a=blob;f=python/sys.py;h=e3a44f24174b979694e2588592f759010b77621e;hb=f70e032b5b69cf5aa6f7e0da746b1817c64341e9

> > Interesting, have you seen the python binding in tip/perf/core?

> My understanding of the stuff under scripts/python is that it links in
> a python interpreter into perf and allows the user to write scripts to
> filter the data coming in from the kernel.

That is not what I'm talking about :-)

I'm talking about:

http://git.kernel.org/?p=linux/kernel/git/tip/linux-2.6-tip.git;a=commitdiff;h=877108e42b1b9ba64857c4030cf356ecc120fd18

<quote cset log>

perf tools: Initial python binding

Sun, 30 Jan 2011 13:37:38 +0000 (11:37 -0200)

First clarifying that this kind of binding is not a replacement or an
equivalent to the 'perf script' way of using python with perf.

The 'perf script' way is to process events and look at a given script
for some python function that matches the events to pass each event for
processing.

This is a python module, i.e. everything is driven from the python
script, that merely uses "import perf" or "from perf import".

perf script is focused on tracepoints, this binding is focused on profiling as
an initial target. More work is needed to make available tracepoint specific
variables as event variables accessible via this binding.

</>
 
> The scripts I wrote a couple of years ago knew nothing about perf, the
> user space tool and wrapped the syscall directly. Sample use case:
> parse the hardware topology of a machine, understand how many NUMA
> nodes/memory controllers there are in the system and print the
> percentage of the memory bandwidth being used on each controller.

That is really cool, I should use something like that in another tool
that does topology parsing, GUI representation of it:

https://www.osadl.org/Single-View.111+M52212cb1379.0.html
http://userweb.kernel.org/~acme/tuna/screenshots/4socket6core.png
 
> Potentially, perf itself could be structured as a set of shared
> libraries, which are then glued together using a scripting language.

That is what I'm talking about, see above commit.

> That may be the wrong trade-off for many users, who value simplicity
> and efficiency of a tool written in C over scriptability. But such a
> design could make activities such as parsing perf.data in a python
> script essentially free.

Agreed :-)

- Arnaldo
