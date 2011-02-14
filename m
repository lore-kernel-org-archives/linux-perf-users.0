From: Arun Sharma <arun@sharma-home.net>
Subject: Re: [perfmon2] updating perf tool
Date: Mon, 14 Feb 2011 12:08:28 -0800
Message-ID: <AANLkTikfaAbdFWzcvayOjYLNECKf_L08nUUEWUy=p8it@mail.gmail.com>
References: <AANLkTim5QGwisxLEHHHECrE1nLSYFxzXEMu7hvTRy09=@mail.gmail.com>
	<AANLkTi=h6Qb7aCB0wER-FEGMwkD6xp1sBgnQudTZ=e+x@mail.gmail.com>
	<AANLkTimqRjUTzv+AO7zHCfXvA1RZFDTjyb-r0s_MVNTW@mail.gmail.com>
	<AANLkTinYM-Sg2uQFkXFy25mSZZZEtTSAUNrA==CxJP0=@mail.gmail.com>
	<20110214194428.GE21384@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56185 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab1BNUI3 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 14 Feb 2011 15:08:29 -0500
Received: by iwn9 with SMTP id 9so5182584iwn.19
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Feb 2011 12:08:28 -0800 (PST)
In-Reply-To: <20110214194428.GE21384@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: Can Hankendi <hankendi@gmail.com>, linux-perf-users@vger.kernel.org

On Mon, Feb 14, 2011 at 11:44 AM, Arnaldo Carvalho de Melo
<acme@ghostprotocols.net> wrote:
>>
>> http://perfmon2.git.sourceforge.net/git/gitweb.cgi?p=perfmon2/libpfm4;a=blob;f=python/sys.py;h=e3a44f24174b979694e2588592f759010b77621e;hb=f70e032b5b69cf5aa6f7e0da746b1817c64341e9
>
> Interesting, have you seen the python binding in tip/perf/core?

My understanding of the stuff under scripts/python is that it links in
a python interpreter into perf and allows the user to write scripts to
filter the data coming in from the kernel.

The scripts I wrote a couple of years ago knew nothing about perf, the
user space tool and wrapped the syscall directly. Sample use case:
parse the hardware topology of a machine, understand how many NUMA
nodes/memory controllers there are in the system and print the
percentage of the memory bandwidth being used on each controller.

Potentially, perf itself could be structured as a set of shared
libraries, which are then glued together using a scripting language.
That may be the wrong trade-off for many users, who value simplicity
and efficiency of a tool written in C over scriptability. But such a
design could make activities such as parsing perf.data in a python
script essentially free.

 -Arun
