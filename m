From: Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH v2 2/3] perf vendor events amd: add Zen2 events
Date: Fri, 28 Feb 2020 10:24:29 -0600
Message-ID: <f7dba82f-beac-2669-c7e7-5a85edc2798d@amd.com>
References: <20200225192815.50388-1-vijaythakkar@me.com>
 <20200225192815.50388-3-vijaythakkar@me.com>
 <6f2a1097-a656-8226-1be3-36a337539412@amd.com>
 <20200228160045.GA23708@shwetrath.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200228160045.GA23708@shwetrath.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Thakkar <vijaythakkar@me.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>, Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 2/28/20 10:00 AM, Vijay Thakkar wrote:
>>> +  {
>>> +    "EventName": "ls_pref_instr_disp.prefetch_nta",
>>> +    "EventCode": "0x4b",
>>> +    "BriefDescription": "Software Prefetch Instructions (PREFETCHNTA instruction) Dispatched.",
>>> +    "PublicDescription": "Software Prefetch Instructions (PREFETCHNTA instruction) Dispatched.",
>>> +    "UMask": "0x4"
>>> +  },
>>> +  {
>>> +    "EventName": "ls_pref_instr_disp.store_prefetch_w",
>>> +    "EventCode": "0x4b",
>>> +    "BriefDescription": "Software Prefetch Instructions (3DNow PREFETCHW instruction) Dispatched.",
>>> +    "PublicDescription": "Software Prefetch Instructions (3DNow PREFETCHW instruction) Dispatched.",
>>> +    "UMask": "0x2"
>>> +  },
>>> +  {
>>> +    "EventName": "ls_pref_instr_disp.load_prefetch_w",
>>> +    "EventCode": "0x4b",
>>> +    "BriefDescription": "Prefetch, Prefetch_T0_T1_T2.",
>>> +    "PublicDescription": "Software Prefetch Instructions Dispatched. Prefetch, Prefetch_T0_T1_T2.",
>>> +    "UMask": "0x1"
>>> +  },
> These three are present in the PPR for model 71h (56176 Rev 3.06 - Jul
> 17, 2019) but are missing from the PPR for model 31h (55803 Rev 0.54 -
> Sep 12, 2019). Not sure what to do about it. 

They're producing nonzero counts on my model 31h, so leave them in?

> Similarly, PMC 0x0AF - Dispatch Resource Stall Cycles 0 only has one
> subcounter in the model 31h PPR, whereas the PPR for 71h is the one that
> contains the eight subcounters we see in the mainline right now.

I'm getting nonzero values on my model 31h for that event's
various unit masks, too.

> There could be more subtle differences like these, since I have not
> really compared the PPR versions that thoroughly. I was going with the
> assumption that since both are for SoCs based on the Zen2, they would
> have identical events. 

I think that's a reasonable assumption.

> Otherwise, I have made all the other changes and corrections, and will
> send in v3 after you suggest how to proceed about the above two.

Thanks, I'd veer toward making them available despite differences in PPR
versions.

Thanks,

Kim
