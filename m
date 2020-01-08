From: Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH 1/3] perf vendor events amd: restrict model detection for
 zen1 based processors
Date: Wed, 8 Jan 2020 17:52:49 -0600
Message-ID: <e2cb90b2-7cd2-122d-6e31-dbca5f1c79a8@amd.com>
References: <20191227125536.1091387-1-vijaythakkar@me.com>
 <20191227125536.1091387-2-vijaythakkar@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191227125536.1091387-2-vijaythakkar@me.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Thakkar <vijaythakkar@me.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>, Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Hi Vijay,

I'm just starting to review this...first comments are:

On 12/27/19 6:55 AM, Vijay Thakkar wrote:
> This patch changes the previous blanket detection of AMD Family 17h
> processors to be more specific to Zen1 core based products only by
> replacing model detection regex pattern [[:xdigit:]]+ with [01][18],
> restricting to models 01, 08, 11 and 18 only.

I've asked within AMD to find out if those are the only ones with zen1 cores.

> This change is required to allow for the addition of separate PMU events
> for Zen2 core based models in the following patches as those belong to family
> 17h but have different PMCs. Current PMU events directory has also been
> renamed to "amdzen1" from "amdfam17h" to reflect this specificity.

I'm not sure if this is 100% the way to go.  Technically, the events and their descriptions vary in the per model PPRs, due to things like AMD's validation tests passing.  So historically, we've kept the source of the events for a specific model in its PPR.  I realize that that may not sound very efficient, and in fact would increase redundancy under pmu-events/, but looking at the data volume figures for each of their family names, that is how Intel does it, too.

> Note that although this change does not break PMU counters for existing
> zen1 based systems, it does disable the current set of counters for zen2
> based systems. Counters for zen2 have been added in the following
> patches in this patchset.

Right, and I'd like for the regexes to not be restrictive like this.  Is there a way to get them to be more open to working for unspecified family and model numbers, like the current version is?

> Signed-off-by: Vijay Thakkar <vijaythakkar@me.com>
> ---
> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> @@ -36,4 +36,4 @@ GenuineIntel-6-55-[56789ABCDEF],v1,cascadelakex,core
>  GenuineIntel-6-7D,v1,icelake,core
>  GenuineIntel-6-7E,v1,icelake,core
>  GenuineIntel-6-86,v1,tremontx,core
> -AuthenticAMD-23-[[:xdigit:]]+,v1,amdfam17h,core
> +AuthenticAMD-23-[01][18],v1,amdzen1,core

Last but not least, this fails to match on my AuthenticAMD-23-8-2 machine, which gets me no 'perf list' output, when there should be.  I think it is because the regex requires the 0 in front of the 8?

Thanks,

Kim
