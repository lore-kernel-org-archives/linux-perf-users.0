From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC v2 0/5] tools/perf/pmu-events/jevents.c
Date: Sun, 12 Jul 2020 20:57:46 +0200
Message-ID: <20200712185746.GD147742@krava>
References: <20200707122314.624400-1-kjain@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200707122314.624400-1-kjain@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kajol Jain <kjain@linux.ibm.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, anju@linux.vnet.ibm.com, kan.liang@linux.intel.com, nasastry@in.ibm.com
List-Id: linux-perf-users.vger.kernel.org

On Tue, Jul 07, 2020 at 05:53:09PM +0530, Kajol Jain wrote:
> Patchset enhance current runtime parameter support. It introduces new
> fields like "PerChip" and "PerCore" similar to the field "PerPkg" which is
> used to specify perpkg events. 
> 
> The "PerCore" and "PerChip" specifies whether its core or chip events.
> Based on which we can decide which runtime parameter user want to
> access. Now character  '?' can refers different parameter based on user
> requirement.
> 
> Initially, every time we want to add new terms like chip, core, thread
> etc, we need to create corrsponding fields in pmu_events and event
> struct.
> This patchset adds an enum called 'aggr_mode_class' which store all these
> aggregation like perpkg/percore. It also adds new field 'AggregationMode'
> to capture these terms.
> Now, if user wants to add any new term, they just need to add it in
> the enum defined. I try to test it with  my current setup.
> 
> I also need to replace PerPkg field to AggregationMode in all the
> x86 uncore json files. It will great if Andi and team can test it
> and let me know if they have any concerns.
> 
> Changelog:
> v1 -> v2:
> - Rather then adding new field as PerCore/PerChip, created a new enum
>   to get these fields. And new field as "AggregationMode" which can
>   be used to capture these fields from json file.

few nits, but generaly looks good to me

Andi,
are you ok with this change? not sure how bad is the
PerPkg -> AggregationMode json change for you

jirka
