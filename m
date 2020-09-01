From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] perf: correct SNOOPX field offset
Date: Tue, 1 Sep 2020 12:58:34 -0300
Message-ID: <20200901155834.GC10147@redhat.com>
References: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
 <20200825174043.GQ1509399@tassilo.jf.intel.com>
 <20200826142631.GA5351@redhat.com>
 <d68e68f5-a7c3-c276-6134-a68f068a2b80@foss.arm.com>
 <20200901150225.GA1424523@kernel.org>
 <20200901150630.GB1424523@kernel.org>
 <20200901151204.GE2674@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200901151204.GE2674@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>, Al Grant <al.grant@foss.arm.com>, Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Sep 01, 2020 at 05:12:04PM +0200, peterz@infradead.org escreveu:
> On Tue, Sep 01, 2020 at 12:06:30PM -0300, Arnaldo Carvalho de Melo wrote:
> 
> > Also you mixed up tools/ with include/ things, the perf part of the
> > kernel is maintained by Ingo, PeterZ.
> 
> Right, it helps if the right people are on Cc.
> 
> > Peter, the patch is the one below, I'll collect the
> > tools/include/uapi/linux/perf_event.h bit as it fixes the tooling,
> > please consider taking the kernel part.
> 
> Al, can you resend with the right people on Cc? Also see below.
> 
> > ---
> > 
> > From:   Al Grant <al.grant@foss.arm.com>
> > Subject: [PATCH] perf: correct SNOOPX field offset
> > Message-ID: <9974f2d0-bf7f-518e-d9f7-4520e5ff1bb0@foss.arm.com>
> > Date:   Mon, 24 Aug 2020 10:28:34 +0100
> > 
> > perf_event.h has macros that define the field offsets in the
> > data_src bitmask in perf records. The SNOOPX and REMOTE offsets
> > were both 37. These are distinct fields, and the bitfield layout
> > in perf_mem_data_src confirms that SNOOPX should be at offset 38.
> > 
> 
> This needs a Fixes: tag.

He provided it in a later message, here it goes:

    Fixes: 52839e653b5629bd ("perf tools: Add support for printing new mem_info encodings")

Also Andi has provided this:

    Reviewed-by: Andi Kleen <ak@linux.intel.com>

- Arnaldo

 
> > Signed-off-by: Al Grant <al.grant@arm.com>
> > 
> > ---
> > 
> >   include/uapi/linux/perf_event.h       | 2 +-
> >   tools/include/uapi/linux/perf_event.h | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > ---
> > 
> > diff --git a/include/uapi/linux/perf_event.h 
> > b/include/uapi/linux/perf_event.h
> > index 077e7ee69e3d..3e5dcdd48a49 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -1196,7 +1196,7 @@ union perf_mem_data_src {
> > 
> >   #define PERF_MEM_SNOOPX_FWD    0x01 /* forward */
> >   /* 1 free */
> > -#define PERF_MEM_SNOOPX_SHIFT  37
> > +#define PERF_MEM_SNOOPX_SHIFT  38
> > 
> >   /* locked instruction */
> >   #define PERF_MEM_LOCK_NA       0x01 /* not available */
> > diff --git a/tools/include/uapi/linux/perf_event.h 
> > b/tools/include/uapi/linux/perf_event.h
> > index 077e7ee69e3d..3e5dcdd48a49 100644
> > --- a/tools/include/uapi/linux/perf_event.h
> > +++ b/tools/include/uapi/linux/perf_event.h
> > @@ -1196,7 +1196,7 @@ union perf_mem_data_src {
> > 
> >   #define PERF_MEM_SNOOPX_FWD    0x01 /* forward */
> >   /* 1 free */
> > -#define PERF_MEM_SNOOPX_SHIFT  37
> > +#define PERF_MEM_SNOOPX_SHIFT  38
> > 
> >   /* locked instruction */
> >   #define PERF_MEM_LOCK_NA       0x01 /* not available */
