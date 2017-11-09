From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf stat crashes with latest download (git clone -b perf/core)
Date: Thu, 9 Nov 2017 11:31:42 -0300
Message-ID: <20171109143142.GL4333@kernel.org>
References: <c64c1529-d0d7-2d1d-0a42-91db6e247863@linux.vnet.ibm.com>
 <20171109143024.GK4333@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbdKIObp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Nov 2017 09:31:45 -0500
Content-Disposition: inline
In-Reply-To: <20171109143024.GK4333@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <andi@firstfloor.org>

Em Thu, Nov 09, 2017 at 11:30:24AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Nov 09, 2017 at 03:23:43PM +0100, Thomas-Mich Richter escreveu:
> > I have downloaded this code some days ago
> > 
> >     git clone -b perf/core git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux acme
> > 
> > and run into this issue which I reproduce on my KVM virtual machine on intel and s390x.
> > 
> > [root@localhost perf]# ./perf stat  -e '{cpu-clock,instructions}' kill
> > kill: not enough arguments
> > Segmentation fault (core dumped)
> > [root@localhost perf]# 
> > 
> > When I debug this further using gdb I get this error:
> 
> Trying with today's acme/perf/core:
> 
> Yeah,
> 
> [acme@jouet linuxdev-br]$ perf stat  -e '{cpu-clock,instructions}' kill
> kill: not enough arguments
> Segmentation fault (core dumped)
> [acme@jouet linuxdev-br]$
> 
> Trying to bisect it now, thanks for the report!

Additional data point, this is happening only with perf/core, not
perf/urgent.

- Arnaldo
