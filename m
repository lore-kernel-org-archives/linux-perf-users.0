From: "Paul A. Clarke" <pc@us.ibm.com>
Subject: Re: [PATCH 2/2] perf: Add missing metrics to POWER9 'cpi_breakdown'
Date: Thu, 14 May 2020 16:04:25 -0500
Message-ID: <20200514210425.GA3338@oc3272150783.ibm.com>
References: <1588868938-21933-1-git-send-email-pc@us.ibm.com>
 <1588868938-21933-3-git-send-email-pc@us.ibm.com>
 <87eerob5n4.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87eerob5n4.fsf@mpe.ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org, ananth@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.ibm.com, irogers@google.com
List-Id: linux-perf-users.vger.kernel.org

On Wed, May 13, 2020 at 06:28:31PM +1000, Michael Ellerman wrote:
> "Paul A. Clarke" <pc@us.ibm.com> writes:
> > Add the following metrics to the POWER9 'cpi_breakdown' metricgroup:
> > - ict_noslot_br_mpred_cpi
> > - ict_noslot_br_mpred_icmiss_cpi
> > - ict_noslot_cyc_other_cpi
> > - ict_noslot_disp_held_cpi
> > - ict_noslot_disp_held_hb_full_cpi
> > - ict_noslot_disp_held_issq_cpi
> > - ict_noslot_disp_held_other_cpi
> > - ict_noslot_disp_held_sync_cpi
> > - ict_noslot_disp_held_tbegin_cpi
> > - ict_noslot_ic_l2_cpi
> > - ict_noslot_ic_l3_cpi
> > - ict_noslot_ic_l3miss_cpi
> > - ict_noslot_ic_miss_cpi
> >
> > Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> > ---
> >  .../arch/powerpc/power9/metrics.json          | 143 ++++++++++--------
> >  1 file changed, 78 insertions(+), 65 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> > index 811c2a8c1c9e..6169351a72c8 100644
> > --- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> > +++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> > @@ -207,6 +207,84 @@
> >          "MetricGroup": "cpi_breakdown",
> >          "MetricName": "fxu_stall_cpi"
> >      },
> > +    {
> > +        "BriefDescription": "Ict empty for this thread due to branch mispred",
> 
> I think you're just moving this, not adding it. But ICT is an acronym,
> so it should be spelled ICT not Ict.
> 
> It might be worth expanding it too?

This was 98% produced through automated means, translating an existing
XML file to perf's JSON format.

I've gotten the upstream XML file changed to include the "ICT" metrics
in the "cpi_breakdown" group already, and can request the changes you
suggest also be incorporated.

For the time being, can we move forward with the patch as-is?

PC
