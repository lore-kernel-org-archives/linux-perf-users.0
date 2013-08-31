From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: perf_event: rdpmc self-monitoring overhead issue
Date: Sat, 31 Aug 2013 12:06:42 +0200
Message-ID: <21025.49202.207730.949120@pilspetsen.it.uu.se>
References: <alpine.DEB.2.10.1308301334410.19094@vincent-weaver-1.um.maine.edu>
	<CAMsRxfLSnNi_vESxYHM5w0tQrOtOPsEy3ythoViRMBbEi+XHGw@mail.gmail.com>
	<alpine.DEB.2.10.1308301426070.19485@vincent-weaver-1.um.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.10.1308301426070.19485@vincent-weaver-1.um.maine.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: eranian@gmail.com, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Vince Weaver writes:
 > On Fri, 30 Aug 2013, Stephane Eranian wrote:
 > > >
 > > You mean that the high cost in your first example comes from the fact
 > > that you are averaging over all the iterations and not n-1 (where 1 is
 > > the first). I don't see a flag in mmap() to fault it in immediately. But
 > > why not document, that programs should touch the page once before
 > > starting any timing measurements.
 > 
 > I was just curious why perfctr didn't need to do this, but possibly
 > I'm just missing the mmap page being touched.  Though the code is pretty
 > small and I'm not seeing any such access.

perfctr's ->mmap() actively inserts the counters page into the calling
process' mm, so it's available immediately.  The other model is to wait
for the first page fault on that page before inserting it; apparently
the other performance counter frameworks do that instead.
