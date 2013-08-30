From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: perf_event: rdpmc self-monitoring overhead issue
Date: Fri, 30 Aug 2013 14:35:26 -0400 (EDT)
Message-ID: <alpine.DEB.2.10.1308301426070.19485@vincent-weaver-1.um.maine.edu>
References: <alpine.DEB.2.10.1308301334410.19094@vincent-weaver-1.um.maine.edu> <CAMsRxfLSnNi_vESxYHM5w0tQrOtOPsEy3ythoViRMBbEi+XHGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMsRxfLSnNi_vESxYHM5w0tQrOtOPsEy3ythoViRMBbEi+XHGw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: eranian@gmail.com
Cc: LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

On Fri, 30 Aug 2013, Stephane Eranian wrote:
> >
> You mean that the high cost in your first example comes from the fact
> that you are averaging over all the iterations and not n-1 (where 1 is
> the first). I don't see a flag in mmap() to fault it in immediately. But
> why not document, that programs should touch the page once before
> starting any timing measurements.

I was just curious why perfctr didn't need to do this, but possibly
I'm just missing the mmap page being touched.  Though the code is pretty
small and I'm not seeing any such access.

With perf_event you have one mmap page per event so touching all the pages
starts racking up some overhead if you have multiple events, but yes 
probably lost in the noise if you do it at open() rather than at read().

It's also hard to have a dummy read of a page w/o the compiler
optimizing it away...

Vince Weaver
vincent.weaver@maine.edu
http://www.eece.maine.edu/~vweaver/
