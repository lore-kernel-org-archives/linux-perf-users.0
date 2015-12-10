From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH perf/core  00/22] perf refcnt debugger API and fixes
Date: Wed, 9 Dec 2015 19:31:40 -0800
Message-ID: <20151210033139.GA10056@ast-mbp.thefacebook.com>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
 <20151209134138.GB15864@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36515 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbbLJDbo (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 9 Dec 2015 22:31:44 -0500
Content-Disposition: inline
In-Reply-To: <20151209134138.GB15864@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>, Wang Nan <wangnan0@huawei.com>

On Wed, Dec 09, 2015 at 10:41:38AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Dec 09, 2015 at 11:10:48AM +0900, Masami Hiramatsu escreveu:
> > Hi Arnaldo,
> > 
> > Here is a series of patches for perf refcnt debugger and
> > some fixes.
> > 
> > In this series I've replaced all atomic reference counters
> > with the refcnt interface, including dso, map, map_groups,
> > thread, cpu_map, comm_str, cgroup_sel, thread_map, and
> > perf_mmap.
> > 
> >   refcnt debugger (or refcnt leak checker)
> >   ===============
> > 
> > At first, note that this change doesn't affect any compiled
> > code unless building with REFCNT_DEBUG=1 (see macros in
> > refcnt.h). So, this feature is only enabled in the debug binary.
> > But before releasing, we can ensure that all objects are safely
> > reclaimed before exit in -rc phase.
> 
> That helps and is finding bugs and is really great stuff, thank you!
> 
> But I wonder if we couldn't get the same results on an unmodified binary
> by using things like 'perf probe', the BPF code we're introducing, have
> you thought about this possibility?
> 
> I.e. trying to use 'perf probe' to do this would help in using the same
> technique in other code bases where we can't change the sources, etc.
> 
> For perf we could perhaps use a 'noinline' on the __get/__put
> operations, so that we could have the right places to hook using
> uprobes, other codebases would have to rely in the 'perf probe'
> infrastructure that knows where inlines were expanded, etc.
> 
> Such a toold could work like:
> 
>    perf dbgrefcnt ~/bin/perf thread 
> 
> And it would look up thread__get and thread__put(), create an eBPF map
> where to store the needed tracking data structures, and use the same
> techniques you used, asking for backtraces using the perf
> infrastructure, etc.

I really like the idea. It's doable with minimal changes.
The only question is the speed of uprobes.
I just haven't benchmarked them. If uprobe+bpf is within 10% slower
than this native refcnt debugger then I think we can build some really
cool tools on top of it. Like generic debugging of std::shared_ptr
or dead lock detection of unmodified binaries.
We can uprobe into pthread_mutex_lock, etc.
Infinite possibilites.
