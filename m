From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Cross platform perf reporting
Date: Fri, 12 Aug 2016 12:31:25 -0300
Message-ID: <20160812153125.GK27651@kernel.org>
References: <1710265.PTtVSNFpcJ@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41588 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752534AbcHLPbb (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 12 Aug 2016 11:31:31 -0400
Content-Disposition: inline
In-Reply-To: <1710265.PTtVSNFpcJ@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org, David Ahern <dsahern@gmail.com>, He Kuang <hekuang@huawei.com>

Em Fri, Aug 12, 2016 at 05:10:18PM +0200, Milian Wolff escreveu:
> On Friday, August 12, 2016 2:22:29 PM CEST Milian Wolff wrote:


> > I'm trying to analyze perf.data files that I recorded on one machine
> > (usually arm or arm64) on my development machine (x86_64). I have compiled
> > a new version of perf (and the corresponding dependencies, where needed) to
> > do this.

Adding He Kuang, that did work on this area recently.

> > Now I do:
> > 
> > ~~~~~~~~~~~~~~~~~~~~~~~~
> > aarch64$ perf record -g ...
> > aarch64$ perf archive
> > 
> > x86_64$ scp aarch64:perf.data* .
> > x86_64$ tar xvf perf.data.tar.bz2 -C ~/.debug
> > x86_64$ perf report |& less
> > -> lots of errors, none of which are displayed in the TUI, such as:
> > 
> > unwind: target platform=arm64 is not supported
> > (often repeated)
> > Failed to open /lib/ld-2.21.so, continuing without symbols
> > Failed to open /lib/libc-2.21.so, continuing without symbols
> > Failed to open /lib/libpthread-2.21.so, continuing without symbols
> > Failed to open /lib/libdl-2.21.so, continuing without symbols
> > ...
> > ~~~~~~~~~~~~~~~~~~~~~~~~
> 
> What I notice, is that `perf buildid-list` does not contain any of these 

That is a limitation that needs fixing, what gets into the build-id are
entries that had hits, DSOs, but those are sample hits, not callchain
hits.

We would have to traverse all callchains and add build-id entries for
the DSOs in it.

I need to do this :-\

But if you have a copy of your target in a file and use --symfs with it it
should work, because then, because it doesn't have the build-id for the DSOs in
the callchains that didn't had hits, it will resort to using just the pathname
when looking for a symtab or the whole ELF for annotation, etc.

> files. I also don't have the corresponding files in my target's ~/.debug 
> folder, where everything seems to work as expected. Is that, because there the 
> symbols are read directly from the file and nothing is cached in ~/.debug?

That is a possibility, yes. But it should be adding it to ~/.debug, that
is the default, unless you have something disabling that in your
~/.perfconfig or some sort of problem is happening that is preventing it
to do the hardlink/copy.
 
> Can I set an environment variable to let perf know to look in secondary paths 
> for the libraries? I.e. I hope to make it look into the cross compile sysroot 
> for these libraries, instead of literally interpreting the path as a valid 
> path on my development machine.

That is the --symfs David talked about, no?

[acme@jouet linux]$ perf report -h symfs

 Usage: perf report [<options>]

        --symfs <directory>
                          Look for files with symbols relative to this directory

[acme@jouet linux]$ 
 
> Thanks
> 
> -- 
> Milian Wolff | milian.wolff@kdab.com | Software Engineer
> KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt Experts
