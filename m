From: Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH 1/3] perf vendor events amd: restrict model detection for
 zen1 based processors
Date: Tue, 14 Jan 2020 17:07:26 -0600
Message-ID: <bc195ac2-d356-9932-993f-778e48ce799d@amd.com>
References: <20191227125536.1091387-1-vijaythakkar@me.com>
 <20191227125536.1091387-2-vijaythakkar@me.com>
 <e2cb90b2-7cd2-122d-6e31-dbca5f1c79a8@amd.com>
 <20200112131021.GA5437@shwetrath.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200112131021.GA5437@shwetrath.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Thakkar <vijaythakkar@me.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>, "Grimm, Jon" <Jon.Grimm@amd.com>
List-Id: linux-perf-users.vger.kernel.org

[re-adding all to cc, since I think Reply-all was not used by mistake]

On 1/12/20 7:10 AM, Vijay Thakkar wrote:
> On Wed, Jan 08, 2020 at 05:52:49PM -0600, Kim Phillips wrote:
>> Hi Vijay,
>>
>> I'm just starting to review this...first comments are:
>>
>> On 12/27/19 6:55 AM, Vijay Thakkar wrote:
>>> This patch changes the previous blanket detection of AMD Family 17h
>>> processors to be more specific to Zen1 core based products only by
>>> replacing model detection regex pattern [[:xdigit:]]+ with [01][18],
>>> restricting to models 01, 08, 11 and 18 only.
>>
>> I've asked within AMD to find out if those are the only ones with zen1 cores.
> 
> I did not find a go-to source of CPU IDs on AMD's website, and on the
> tech-docs list, what I found was out of date. For now, I used the CPU
> models for zen1 and zen2 that I could find on WikiChip. Let me know if I
> am missing any.

OK, zen1 is f17h, models 0 through 0x2f, inclusive.  We can assume the rest - 0x30 and higher - are zen2.

>>> This change is required to allow for the addition of separate PMU events
>>> for Zen2 core based models in the following patches as those belong to family
>>> 17h but have different PMCs. Current PMU events directory has also been
>>> renamed to "amdzen1" from "amdfam17h" to reflect this specificity.
>>
>> I'm not sure if this is 100% the way to go.  Technically, the events and their descriptions vary in the per model PPRs, due to things like AMD's validation tests passing.  So historically, we've kept the source of the events for a specific model in its PPR.  I realize that that may not sound very efficient, and in fact would increase redundancy under pmu-events/, but looking at the data volume figures for each of their family names, that is how Intel does it, too.
> 
> I realize that a lot of the events between zen1 and zen2 are redudant,
> but as you point out, that is how other related CPU models are also
> choosing to differentiate the events, so I chose to take that route.

Right, I'm just saying ideally we'd have to do this for each public PPR, not just zen1 vs. zen2.

Here is a list of publicly available PPRs, in chronological publication date order:

PPR for AMD Family 17h Model 01h B1
54945 Rev 1.14 - April 15, 2017
[used to be here: https://support.amd.com/TechDocs/54945_PPR_Family_17h_Models_00h-0Fh.pdf , but not found there any more]
https://developer.amd.com/wordpress/media/2017/11/54945_PPR_Family_17h_Models_00h-0Fh.pdf
https://www.amd.com/system/files/TechDocs/54945_3.03_ppr_ZP_B2_pub.zip

OSRR for AMD Family 17h processors, Models 00h-2Fh
56255 Rev 3.03 - July, 2018
https://www.amd.com/system/files/TechDocs/56255_OSRR.pdf

PPR for AMD Family 17h Models 01h,08h B2
54945 Rev 3.03 - Jun 14, 2019
https://www.amd.com/system/files/TechDocs/54945_3.03_ppr_ZP_B2_pub.zip

^^^ those first three are zen1.

PPR for AMD Family 17h Model 71h B0
56176 Rev 3.06 - Jul 17, 2019
https://www.amd.com/system/files/TechDocs/56176_ppr_Family_17h_Model_71h_B0_pub_Rev_3.06.zip

PPR for AMD Family 17h Model 31h B0
55803 Rev 0.54 - Sep 12, 2019
https://developer.amd.com/wp-content/resources/55803_0.54-PUB.pdf

^^^ these two are zen2.

PPR for AMD Family 17h Model 18h B1
55570-B1 Rev 3.14 - Sep 26, 2019
https://www.amd.com/system/files/TechDocs/55570-B1_PUB.zip

^^^ and that's a zen1 again.

I'm sure the different PPRs for the same zen generation change their supposedly identical event descriptions, too.

>>> Note that although this change does not break PMU counters for existing
>>> zen1 based systems, it does disable the current set of counters for zen2
>>> based systems. Counters for zen2 have been added in the following
>>> patches in this patchset.
>>
>> Right, and I'd like for the regexes to not be restrictive like this.  Is there a way to get them to be more open to working for unspecified family and model numbers, like the current version is?
> 
> I am not sure if that is possible, but I also do not know why we would
> want this considering there are quite a few differences between Zen1 and
> Zen2 events. Missing models can always be added later, and if you can
> provide full list of models from AMD, that should solve this issue as
> well.

The problem with that is I don't want to have to update perf every time AMD comes out with a new model.  We have the zen1 vs zen2 model range figures now, and for now this seems a good fit, until something more automated is developed against the PPRs, which have the more restrictive model ranges.

>>> Signed-off-by: Vijay Thakkar <vijaythakkar@me.com>
>>> ---
>>> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
>>> @@ -36,4 +36,4 @@ GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
>>>  GenuineIntel-6-7D,v1,icelake,core
>>>  GenuineIntel-6-7E,v1,icelake,core
>>>  GenuineIntel-6-86,v1,tremontx,core
>>> -AuthenticAMD-23-[[:xdigit:]]+,v1,amdfam17h,core
>>> +AuthenticAMD-23-[01][18],v1,amdzen1,core
>>
>> Last but not least, this fails to match on my AuthenticAMD-23-8-2 machine, which gets me no 'perf list' output, when there should be.  I think it is because the regex requires the 0 in front of the 8?
>>
>> Thanks,
> 
> Ah yes, I did not realize the prefix 0 would not be included. Changing
> the pattern to be [01]?[18] should fix it. I can send a new version of

The most restrictive pattern should be first, for zen1, and to match models 0-2f, it should be something like this:

AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),,amdzen1,core

Then zen2 can be the catch-all for the rest:

AuthenticAMD-23-[[:xdigit:]]+,,amdzen2,core

Technically that family check can also be changed to make it even more future proof, e.g., 23 or higher.

> the patch set. This is my first contribution to the kernel, so I
> apologize for the newbie question, but should I send v2 as its own new
> patch series, or in reply to this email?

As its own new patch series, but after I reply with my review for patches 2 & 3 out of 3, please.

Thanks,

Kim
