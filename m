From: Vijay Thakkar <vijaythakkar@me.com>
Subject: Re: [PATCH v3 3/3] perf vendor events amd: update Zen1 events to V2
Date: Fri, 13 Mar 2020 23:13:10 -0400
Message-ID: <20200314031310.GA66224@shwetrath.localdomain>
References: <20200228175639.39171-1-vijaythakkar@me.com>
 <20200228175639.39171-4-vijaythakkar@me.com>
 <77552e9e-7fca-7186-24cc-6a8a87d4b7b6@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <77552e9e-7fca-7186-24cc-6a8a87d4b7b6@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim Phillips <kim.phillips@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>, Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

I think I may have accidentally deleted your review of Patch 2 so I am
replying to that here. Still quite new to mutt, sorry :p

> > +  {                                                                                                  
> > +    "EventName": "ls_tablewalker.perf_mon_tablewalk_alloc_iside",                                    
> > +    "EventCode": "0x46",                                                                             
> > +    "BriefDescription": "Tablewalker allocation.",                                                   
> > +    "PublicDescription": "Tablewalker allocation.",                                                  
> > +    "UMask": "0xc"                                                                                   
> > +  },                                                                                                 
> > +  {                                                                                                  
> > +    "EventName": "ls_tablewalker.perf_mon_tablewalk_alloc_dside",                                    
> > +    "EventCode": "0x46",                                                                             
> > +    "BriefDescription": "Tablewalker allocation.",                                                   
> > +    "PublicDescription": "Tablewalker allocation.",                                                  
> > +    "UMask": "0x3"                                                                                   
> > +  },                                                                                                 
>                                                                                                         
> I see each of the two tablewalkers got consolidated into their own                                      
> unit mask groups?  Any reason we couldn't leave the original
> instances there, and add these in addition?  In any case we'd need
> clarification of which 'side' are the both counting - I or D - in
> a single BriefDescription here.

So these have not been changed since zen1, and are still present as is
in the mainline. Zen2 PPR version 55803 Rev 0.54 does not include them.
But I see that these have been updated even for zen1 in the latest PPR
version 54945 Rev 3.03 so I will add them for both.

> I thought we agreed to call these LS MAB Allocates by Type", like the text in the
> later PPR for AMD Family 17h Model 31h B0 - 55803 Rev 0.54 - Sep 12, 2019?
> 
> DC Miss By Type is probably less correct given the MAB != DC, and the name of
> the event is "LsMabAlloc".
> 
> FWIW, a MAB is a Miss address buffer (seen in the Model 71h PPR's MCA_CTL_LS
> register definition).

Ah I am really sorry, I must have missed these. Should be fixed now.

> Another case where it's hard to make out what the event is counting
> in general: Make its PublicDescription a single Breifdescription?
Yeah, I agree. Will merge the descriptions.

> +  {
> +    "EventName": "ls_refills_from_sys.ls_mabresp_rmt_dram",
> +    "EventCode": "0x43",
> +    "BriefDescription": "DRAM or IO from different die.",
> +    "PublicDescription": "Demand Data Cache Fills by Data Source. DRAM or IO from different die.",
> +    "UMask": "0x40"
> +  },
> +  {
> +    "EventName": "ls_refills_from_sys.ls_mabresp_rmt_cache",
> +    "EventCode": "0x43",
> +    "BriefDescription": "Hit in cache; Remote CCX and the address's Home Node is on a different die.",
> +    "PublicDescription": "Demand Data Cache Fills by Data Source. Hit in cache; Remote CCX and the address's Home Node is on a different die.",
> +    "UMask": "0x10"
> +  },
> +  {
> +    "EventName": "ls_refills_from_sys.ls_mabresp_lcl_dram",
> +    "EventCode": "0x43",
> +    "BriefDescription": "DRAM or IO from this thread's die.",
> +    "PublicDescription": "Demand Data Cache Fills by Data Source. DRAM or IO from this thread's die.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "ls_refills_from_sys.ls_mabresp_lcl_cache",
> +    "EventCode": "0x43",
> +    "BriefDescription": "Hit in cache; local CCX (not Local L2), or Remote CCX and the address's Home Node is on this thread's die.",
> +    "PublicDescription": "Demand Data Cache Fills by Data Source. Hit in cache; local CCX (not Local L2), or Remote CCX and the address's Home Node is on this thread's die.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ls_refills_from_sys.ls_mabresp_lcl_l2",
> +    "EventCode": "0x43",
> +    "BriefDescription": "Local L2 hit.",
> +    "PublicDescription": "Demand Data Cache Fills by Data Source. Local L2 hit.",
> +    "UMask": "0x1"
> +  },

These events are ripe for fusing the public description with the brief
one too, so I will do so as well.

-Vijay
