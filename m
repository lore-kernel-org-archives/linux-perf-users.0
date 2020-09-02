From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf c2c report: count remote loads correctly
Date: Wed, 2 Sep 2020 10:47:52 -0300
Message-ID: <20200902134752.GC1464000@kernel.org>
References: <6282053a-d813-8638-531d-56e852d582a2@foss.arm.com>
 <20200901201717.GA656443@krava>
 <20200901204614.GC656443@krava>
 <be482330-5532-6c34-ed0a-1c6f79e365fc@redhat.com>
 <0ffdeb34-6fa7-380e-3183-8ce1022ed21c@foss.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0ffdeb34-6fa7-380e-3183-8ce1022ed21c@foss.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Grant <al.grant@foss.arm.com>
Cc: Joe Mario <jmario@redhat.com>, Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Sep 02, 2020 at 01:09:42PM +0100, Al Grant escreveu:
> On 01/09/2020 22:26, Joe Mario wrote:
> > On 9/1/20 4:46 PM, Jiri Olsa wrote:
> > > On Tue, Sep 01, 2020 at 10:17:19PM +0200, Jiri Olsa wrote:
> > > > On Thu, Aug 20, 2020 at 02:48:58PM +0100, Al Grant wrote:
> > > > I'm getting following when trying to apply the patch:

> > > > patching file util/mem-events.c
> > > > patch: **** malformed patch at line 83: struct mem_info *mi)

> > > > > "perf c2c report" can show load counts for cache lines, which
> > > > > don't match the actual number of load samples, e.g. as
> > > > > displayed by "perf script". This is specific to "Remote Any
> > > > > cache hit" loads. Firstly, these loads are counted twice,
> > > > > because if the "remote" flag is set, rmt_dram is always
> > > > > incremented, and then rmt_hitm or rmt_hit may also be
> > > > > incremented. These are then totalled in the overall load
> > > > > count, causing double-counting. "Remote Any cache hit" should
> > > > > not increment rmt_dram. Instead, use LVLNUM to discriminate
> > > > > between remote cache and remote DRAM. Also, non-HITM loads to
> > > > > remote cache are not being counted as hits (the last column in
> > > > > the cache line report is zero), when the SNOOP field is unset.
> > > > > This causes under-reporting of the load count. The code
> > > > > currently only increments counters if the SNOOP field is set
> > > > > to either HIT or HITM. Instead, for access to remote cache (as
> > > > > indicated by LVLNUM), increment rmt_hitm if SNOOP=HITM,
> > > > > increment rmt_hit otherwise.

> > > > seems like you described more issues in here,
> > > > could you please put them in separate patches,
> > > > so it's easier to review?

> > > > Andi, Joe,
> > > > any idea about changes described above?

> > Hi Al:
> > Can you provide a simple reproducer for this?
> > When I try it, the "perf c2c report" shows the same counts for the load samples as the "perf script" output does.
> > 
> > For example:
> > Here's the output from the "perf c2c report"
> > # head -6 c2c.out
> >     =================================================
> >                 Trace Event Information
> >     =================================================
> >       Total records                     :      32923
> >       Locked Load/Store Operations      :        306
> >       Load Operations                   :       5392
> > 
> > And here's the grep count from the "perf script" output:
> >     # egrep -c 'mem-stores|mem-loads' script.out
> >     32923
> >     # egrep -c "LCK Yes" script.out
> >     306
> >     # grep -c mem-loads script.out
> >     5392

> "Load Operations" is correct, the problem is with some of the
> counts of more specific load types. E.g. in this output:

>   Load Operations                   :        782
>   Loads - uncacheable               :          0
>   Loads - IO                        :          0
>   Loads - Miss                      :         18
>   Loads - no mapping                :          0
>   Load Fill Buffer Hit              :         85
>   Load L1D hit                      :        171
>   Load L2D hit                      :         16
>   Load LLC hit                      :         86
>   Load Local HITM                   :          0
>   Load Remote HITM                  :        110
>   Load Remote HIT                   :          0
>   Load Local DRAM                   :         86
>   Load Remote DRAM                  :        320

> LFB, L1D, L2D, LLC, local DRAM, remote HIT/HITM and remote DRAM are
> distinct places so their individual counts should total up to no more
> than the total load count. But 85+171+16+86+110+86+320 is 874 which
> exceeds the total load count by 92. If you add in "Loads - Miss"
> (which is "L3 Miss" in perf script - it's not specific about where
> it hit) the excess is 110.

> # grep -c "Remote Any cache hit" script.out
> 111

> # grep -c "Remote Any cache hit|SNP HitM" script.out
> 110

> # grep -c "Remote RAM" script.out
> 209

> # grep -c "Remote" script.out
> 320

> Loads which hit remote cache are being counted as both remote HIT/HITM
> and remote DRAM. perf c2c is reporting 320 "Load Remote DRAM" but this
> is the count of all remote loads, including "Remote Any cache hit".
> "Load Remote DRAM" should match "grep -c "Remote RAM" i.e. 209 not
> 320.  The 110 excess in the total matches the count of "Remote Any
> cache hit|SNP HitM" as it is these which are counted twice. (There is
> one "SNP N/A" which isn't counted, that's the other issue I mentioned)

> There are knock-on effects in the detailed cache line reporting, but I
> believe it's all due to the same root cause where we have some records
> triggering two counts which should be mutually exclusive.

Would you consider adding a tools/perf/tests/ entry to do these checks,
i.e. run some synthetic workload, record some of these events, then do
this math, to check that perf is doing the right thing?

The starting point is something like:

  $ ls -la tools/perf/tests/sw-clock.c 
  -rw-rw-r--. 1 acme acme 3326 Aug 14 09:00 tools/perf/tests/sw-clock.c
  $ 
  $ wc -l tools/perf/tests/sw-clock.c 
  149 tools/perf/tests/sw-clock.c
  $ 
  $ perf test clock
  25: Software clock events period values                   : Ok
  $ perf test -v clock
  Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
  25: Software clock events period values                   :
  --- start ---
  test child forked, pid 3455348
  mmap size 528384B
  mmap size 528384B
  test child finished with 0
  ---- end ----
  Software clock events period values: Ok
  $

This way, everytime we go sending patches upstream and do:

  # perf test

We make sure the changes in the current batch of patches being submitted
don't regress,

Thanks for your consideration and for your patches and detailed
discussion,

Regards,

- Arnaldo

P.S.: The SNOOPX fix for tools/ is already in Linus tree, he even
noticed that now the kernel UAPI header is out of sync and needs that
fix :-)

https://lore.kernel.org/lkml/CAHk-=wifL-04oOF3RAbX9Odyfgz4zc4dE=pq-QL+2C-aTxUmqw@mail.gmail.com/
