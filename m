From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH] perf vendor events intel: Add uncore_upi JSON support
Date: Tue, 14 May 2019 09:59:56 -0300
Message-ID: <20190514125956.GG3198@kernel.org>
References: <1557234991-130456-1-git-send-email-kan.liang@linux.intel.com>
 <9e816fed-5d00-c490-21b3-ad9c56dac446@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9e816fed-5d00-c490-21b3-ad9c56dac446@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kan Liang <kan.liang@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Mon, May 13, 2019 at 05:29:30PM -0400, Liang, Kan escreveu:
> Hi Arnaldo,
> 
> Could you please apply this fix?

Sure, please next time specify which arch this should be tested on, as I
tried it here on a skylake notebook (lenovo t480s) before your patch and
got:

[root@quaco ~]# perf stat -e UPI_DATA_BANDWIDTH_TX
event syntax error: 'UPI_DATA_BANDWIDTH_TX'
                     \___ parser error
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
[root@quaco ~]#

Then, looking at 'perf list' /UPI I got just these:

Pipeline:
<SNIP>
  UPI
       [Uops Per Instruction]

Which already probably told me a bit about what this is about, its under
the "METRIC groups" header

After your patch applied I get:

[root@quaco ~]# perf stat -e UPI_DATA_BANDWIDTH_TX
event syntax error: 'UPI_DATA_BANDWIDTH_TX'
                     \___ parser error
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list available events
[root@quaco ~]# 

I.e. nothing seem to have changed, but then, to further look at this I
tried:

# strings ~/bin/perf | grep -i upi
<SNIP>
Data Response packets that go direct to Intel UPI. Unit: uncore_upi 
Counts Data Response (DRS) packets that attempted to go direct to Intel Ultra Path Interconnect (UPI) bypassing the CHA 
Cycles Intel UPI is in L1 power mode (shutdown). Unit: uncore_upi 
Counts cycles when the Intel Ultra Path Interconnect (UPI) is in L1 power mode.  L1 is a mode that totally shuts down the UPI link.  Link power states are per link and per direction, so for example the Tx direction could be in one state while Rx was in another, this event only coutns when both links are shutdown
Cycles the Rx of the Intel UPI is in L0p power mode. Unit: uncore_upi 
Counts cycles when the the receive side (Rx) of the Intel Ultra Path Interconnect(UPI) is in L0p power mode. L0p is a mode where we disable 60% of the UPI lanes, decreasing our bandwidth in order to save power
FLITs received which bypassed the Slot0 Receive Buffer. Unit: uncore_upi 
Valid data FLITs received from any slot. Unit: uncore_upi 
<SNIP>

So this "UPI" TLA, here, should not mean "UOPS per instruction", but
Intel's "Ultra Path Interconnect", right? Lemme update the changelog...

/me googles... https://en.wikipedia.org/wiki/Intel_Ultra_Path_Interconnect

So I'd need a Skylake-SP test machine to test this...

Please add such notes in the future, helps reviewing and testing this.

At some point I'd like to have 'perf test' test such stuff with a
Requires_cpuid/arch, etc.

- Arnaldo
 
> Thanks,
> Kan
> 
> On 5/7/2019 9:16 AM, kan.liang@linux.intel.com wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> > 
> > Perf cannot parse UPI events.
> > 
> >      #perf stat -e UPI_DATA_BANDWIDTH_TX
> >      event syntax error: 'UPI_DATA_BANDWIDTH_TX'
> >                       \___ parser error
> >      Run 'perf list' for a list of valid events
> > 
> > The JSON lists call the box UPI LL, while perf calls it upi.
> > Add conversion support to json to convert the unit properly.
> > 
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> > ---
> >   tools/perf/pmu-events/jevents.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> > index 68c92bb..daaea50 100644
> > --- a/tools/perf/pmu-events/jevents.c
> > +++ b/tools/perf/pmu-events/jevents.c
> > @@ -235,6 +235,7 @@ static struct map {
> >   	{ "iMPH-U", "uncore_arb" },
> >   	{ "CPU-M-CF", "cpum_cf" },
> >   	{ "CPU-M-SF", "cpum_sf" },
> > +	{ "UPI LL", "uncore_upi" },
> >   	{}
> >   };
> > 

-- 

- Arnaldo
