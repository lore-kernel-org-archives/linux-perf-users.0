From: Vijay Thakkar <vijaythakkar@me.com>
Subject: Re: [PATCH v2 2/3] perf vendor events amd: add Zen2 events
Date: Fri, 28 Feb 2020 12:34:19 -0500
Message-ID: <20200228173419.GB34885@shwetrath.localdomain>
References: <20200225192815.50388-1-vijaythakkar@me.com>
 <20200225192815.50388-3-vijaythakkar@me.com>
 <6f2a1097-a656-8226-1be3-36a337539412@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6f2a1097-a656-8226-1be3-36a337539412@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim Phillips <kim.phillips@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>, Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

> > +  {
> > +    "EventName": "de_dis_dispatch_token_stalls0.sc_agu_dispatch_stall",
> > +    "EventCode": "0xaf",
> > +    "BriefDescription": "SC AGU dispatch stall.",
> > +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
> > +    "UMask": "0x80"
> > +  },
> 
> All the above Public descriptions have "RETIRE Tokens unavailable." 
> yet their BriefDescriptions are different.  Please fix.

Just noticed that this one is not present at all in PPR 56176 Rev 3.06 - Jul
17, 2019 and that the umasks for the rest of the sub-counters in PMC0xAF
are right shifted by one when compared to those in Zen1. As a result,
the previous counter at umask 0x1 is no longer present.

I will update this counter to reflect what is documented in model 71h PPR 56176 Rev
3.06 - Jul 17, 2019.

-Vijay
