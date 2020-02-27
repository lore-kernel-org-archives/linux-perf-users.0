From: Vijay Thakkar <vijaythakkar@me.com>
Subject: Re: [PATCH v2 3/3] perf vendor events amd: update Zen1 events to V2
Date: Thu, 27 Feb 2020 15:00:26 -0500
Message-ID: <20200227200026.GA8493@shwetrath.localdomain>
References: <20200225192815.50388-1-vijaythakkar@me.com>
 <20200225192815.50388-4-vijaythakkar@me.com>
 <73b5b731-9597-1243-485a-788437500c7a@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <73b5b731-9597-1243-485a-788437500c7a@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim Phillips <kim.phillips@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>, Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

> OSRR for AMD Family 17h processors, Models 00h-2Fh, 56255 Rev 3.03 - July, 2018
I have included this for v3 that I will submit later, including all the
changes for the FPU counters. Sorry, I messed up copy-pasting the text
and forgot to change the trailing pipe number.
> and their counts don't seem to match up very well when running
> various workloads.  The microarchitecture is likely to have changed
> in this area from families prior to 17h, so a MAB alloc can likely
> count different events than what is presumed here: a Data cache
> load/store/prefetch miss.
> 
> I think it's safer to just leave the PPR text "LS MAB Allocates
> by Type" as-is, instead of assuming they are L1 load/store misses.
> What do you think?

I did some checking accross PPRs, and this counter seems to have changed
names multiple times throughout the PPR revisions. 

Zen1 PPR (54945 Rev 1.14 - April 15, 2017) lists counter called "LsMabAllocPipe"
with 5 subcounters that have different names compared to ones we see in
the mainline right now. PPRs for stepping B2
onwards change this to the 3 sub-counter and primary counter name
we see right now. This public description still changes accross various
PPR revisions, which is why I had this set to what it was. The lastest
PPR I can find is indeed lists it as "LS MAB Allocates by Type";
I will change it to that with the fuffix of tehe sub-counter name. Since
the same counter is in Zen2 as well, I will make the same changes there
too.

Let me know if this sounds good to you!
Best,
Vijay
