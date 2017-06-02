From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH 1/2] perf report: ensure the perf DSO mapping matches what libdw sees
Date: Fri, 02 Jun 2017 18:21:44 +0200
Message-ID: <13986004.8uJxbMKobt@agathebauer>
References: <20170602143753.16907-1-milian.wolff@kdab.com> <20170602152341.GB7901@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:58358 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750955AbdFBQVu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 2 Jun 2017 12:21:50 -0400
In-Reply-To: <20170602152341.GB7901@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>

On Freitag, 2. Juni 2017 17:23:41 CEST Arnaldo Carvalho de Melo wrote:
> Em Fri, Jun 02, 2017 at 04:37:52PM +0200, Milian Wolff escreveu:
> > In some situations the libdw unwinder stopped working properly.
> > I.e. with libunwind we see:
> > 
> > ~~~~~
> > 
> > heaptrack_gui  2228 135073.400112:     641314 cycles:
> > 	            e8ed _dl_fixup (/usr/lib/ld-2.25.so)
> > 	           
> > 	           15f06 _dl_runtime_resolve_sse_vex (/usr/lib/ld-2.25.so)
> > 	           ed94c KDynamicJobTracker::KDynamicJobTracker
> > 	           (/home/milian/projects/compiled/kf5/lib64/libKF5KIOWidgets.so
> > 	           .5.35.0) 608f3 _GLOBAL__sub_I_kdynamicjobtracker.cpp
> > 	           (/home/milian/projects/compiled/kf5/lib64/libKF5KIOWidgets.so
> > 	           .5.35.0)> 	           
> > 	            f199 call_init.part.0 (/usr/lib/ld-2.25.so)
> > 	            f2a5 _dl_init (/usr/lib/ld-2.25.so)
> > 	            
> > 	             db9 _dl_start_user (/usr/lib/ld-2.25.so)
> > 
> > ~~~~~
> > 
> > But with libdw and without this patch this sample is not properly
> > unwound:
> > 
> > ~~~~~
> > 
> > heaptrack_gui  2228 135073.400112:     641314 cycles:
> > 	            e8ed _dl_fixup (/usr/lib/ld-2.25.so)
> > 	           
> > 	           15f06 _dl_runtime_resolve_sse_vex (/usr/lib/ld-2.25.so)
> > 	           ed94c KDynamicJobTracker::KDynamicJobTracker
> > 	           (/home/milian/projects/compiled/kf5/lib64/libKF5KIOWidgets.so
> > 	           .5.35.0)> 
> > ~~~~~
> > 
> > Debug output showed me that libdw found a module for the last frame
> > address, but it thinks it belongs to /usr/lib/ld-2.25.so. This patch
> > double-checks what libdw sees and what perf knows. If the mappings
> > mismatch, we now report the elf known to perf. This fixes the
> > situation above, and the libdw unwinder produces the same stack as
> > libunwind.
> 
> Looks ok, having both implementations matching and the callchains making
> sense for your workloads is a good way to verify the sanity, thanks.
> 
> I wonder if we shouldn't somehow script this, i.e. build it with one
> implementation, generate output from some test workload, build it with
> the other, second output, diff it, report when not the same.

That does sound like a good idea, but I'm unsure how to do it. Note that many 
"simple" tests work just fine. Only larger complicated workloads trigger this 
issue for me.

One potential way to test it would be `perf archive` - i.e. I send you the 
binaries involved and then we can use perf script diffing to ensure it all 
works...

Cheers

-- 
Milian Wolff | milian.wolff@kdab.com | Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
