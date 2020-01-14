From: Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH 2/3] perf vendor events amd: add Zen2 events
Date: Tue, 14 Jan 2020 17:15:04 -0600
Message-ID: <e6ecb0ce-fdee-1458-616d-5e1927a7255c@amd.com>
References: <20191227125536.1091387-1-vijaythakkar@me.com>
 <20191227125536.1091387-3-vijaythakkar@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191227125536.1091387-3-vijaythakkar@me.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Thakkar <vijaythakkar@me.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>, Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 12/27/19 6:55 AM, Vijay Thakkar wrote:
> This patch adds PMU events for AMD Zen2 core based processors, namely,
> Matisse (model 71h), Castle Peak (model 31h) and Rome (model 2xh), as
> documented in the AMD Processor Programming Reference for Matisse [1].
> Zen2 adds some additional counters that are not present in Zen1 and
> events for them have been added in this patch. Some counters have also
> been removed for Zen2 thatwere previously present in Zen1 and have been
> confirmed to always sample zero on zen2. These added/removed counters
> have been omitted for brevity.

I'd like to see the list, if at all possible.

> Note that PPR for Zen2 [1] does not include some counters that were
> documented in the PPR for Zen1 based processors [2]. After having tested
> these counters, some of them that still work for zen2 systems have been
> preserved in the events for zen2. The counters that are omitted in [1]
> but are still measurable and non-zero on zen2 (tested on a Ryzen 3900X
> system) are the following:
> 
> PMC 0x000 fpu_pipe_assignment.{total|total0|total1|total2|total3}
> PMC 0x004 fp_num_mov_elim_scal_op.*
> PMC 0x046 ls_tablewalker.*
> PMC 0x062 l2_latency.l2_cycles_waiting_on_fills
> PMC 0x063 l2_wcb_req.*
> PMC 0x06D l2_fill_pending.l2_fill_busy
> PMC 0x080 ic_fw32
> PMC 0x081 ic_fw32_miss
> PMC 0x086 bp_snp_re_sync
> PMC 0x087 ic_fetch_stall.*
> PMC 0x08C ic_cache_inval.*
> PMC 0x099 bp_tlb_rel
> PMC 0x0C7 ex_ret_brn_resync
> PMC 0x28A ic_oc_mode_switch.*
> L3PMC 0x001 l3_request_g1.*
> L3PMC 0x006 l3_comb_clstr_state.*

How do you know there aren't others, given your workload just may have not triggered some?  This is why ultimately I'd like to use the AMD-sanctioned events from the PPRs.

> +  {
> +    "EventName": "bp_dyn_ind_pred",
> +    "EventCode": "0x8e",
> +    "BriefDescription": "Dynamic Indirect Predictions.",
> +    "PublicDescription": "Indirect Branch Prediction for potential multi-target branch (speculative)."
> +  },
> +  {
> +    "EventName": "bp_de_redirect",
> +    "EventCode": "0x91",
> +    "BriefDescription": "Decoder Overrides Existing Branch Prediction (speculative)."
> +  },

So at first glance of this patch, I'm seeing at least these last two events present in these PPRs:

54945_3.03_ppr_ZP_B2_pub
55570-B1_3.14_ppr_B1_pub
55803_0.54-PUB
56176_ppr_Family_17h_Model_71h_B0_pub_Rev_3.06

and when testing the events on my zen1 system, sure enough, they return non-zero values.

So do we need to correct the zen1 events first?

Thanks,

Kim
