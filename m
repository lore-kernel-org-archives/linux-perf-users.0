From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Two questions on perf dwarf callchains
Date: Thu, 30 Jan 2014 16:40:47 +0100
Message-ID: <20140130154047.GB1827@krava.brq.redhat.com>
References: <1389954083.1125.23.camel@nb-andreolini.mat.unimo.it>
 <20140129111844.GA1869@krava.brq.redhat.com>
 <1391008146.1316.8.camel@nb-andreolini.mat.unimo.it>
 <20140130114751.GB1161@krava.brq.redhat.com>
 <1391092999.1111.3.camel@nb-andreolini.mat.unimo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43778 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753089AbaA3Pkt (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 30 Jan 2014 10:40:49 -0500
Content-Disposition: inline
In-Reply-To: <1391092999.1111.3.camel@nb-andreolini.mat.unimo.it>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mauro Andreolini <mauro.andreolini@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Thu, Jan 30, 2014 at 03:43:19PM +0100, Mauro Andreolini wrote:
> > zero's are taken care by:
> > http://marc.info/?t=138909914500003&r=1&w=2
> > within following patchset:
> > http://marc.info/?l=linux-kernel&m=138909914404574&w=2
> 
> > which implements libdw dwarf unwind.. you might
> > actualy want to try it, it seems to be little faster
> > than libunwind unwinder
> Since I do not yet have elfutils 0.158 installed, I tried
> to apply the single patch both to linux-3.12 and to the kernel you
> pointed me at, and used perf with the libunwind unwinder. With the 3.12
> kernel I get segfaults on perf report; with the 3.13 branch zeroes are
> still present. Maybe I messed up.
> I think I'll wait for the newest elfutils and give a shot ad the
> libdw unwinder.

I use elfutils git tree ;-)
git://git.fedorahosted.org/git/elfutils.git

and the latest patchset (recently rebased) is in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/core_libdw_unwind

jirka
