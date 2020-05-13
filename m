From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/2] perf: Add missing metrics to POWER9 'cpi_breakdown'
Date: Wed, 13 May 2020 18:28:31 +1000
Message-ID: <87eerob5n4.fsf@mpe.ellerman.id.au>
References: <1588868938-21933-1-git-send-email-pc@us.ibm.com> <1588868938-21933-3-git-send-email-pc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1588868938-21933-3-git-send-email-pc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul A. Clarke" <pc@us.ibm.com>, linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, acme@kernel.org, ananth@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.ibm.com, irogers@google.com
List-Id: linux-perf-users.vger.kernel.org

"Paul A. Clarke" <pc@us.ibm.com> writes:
> From: "Paul A. Clarke" <pc@us.ibm.com>
>
> Add the following metrics to the POWER9 'cpi_breakdown' metricgroup:
> - ict_noslot_br_mpred_cpi
> - ict_noslot_br_mpred_icmiss_cpi
> - ict_noslot_cyc_other_cpi
> - ict_noslot_disp_held_cpi
> - ict_noslot_disp_held_hb_full_cpi
> - ict_noslot_disp_held_issq_cpi
> - ict_noslot_disp_held_other_cpi
> - ict_noslot_disp_held_sync_cpi
> - ict_noslot_disp_held_tbegin_cpi
> - ict_noslot_ic_l2_cpi
> - ict_noslot_ic_l3_cpi
> - ict_noslot_ic_l3miss_cpi
> - ict_noslot_ic_miss_cpi
>
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> ---
>  .../arch/powerpc/power9/metrics.json          | 143 ++++++++++--------
>  1 file changed, 78 insertions(+), 65 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> index 811c2a8c1c9e..6169351a72c8 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> @@ -207,6 +207,84 @@
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "fxu_stall_cpi"
>      },
> +    {
> +        "BriefDescription": "Ict empty for this thread due to branch mispred",

I think you're just moving this, not adding it. But ICT is an acronym,
so it should be spelled ICT not Ict.

It might be worth expanding it too?

cheers
