From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH v3 0/5] powerpc/perf: Add json file support for hv_24x7
 core level events
Date: Fri, 17 Jul 2020 13:41:22 +0530
Message-ID: <a80eebc2-885c-171d-7c7a-74df727d60b4@linux.ibm.com>
References: <20200716094216.1418659-1-kjain@linux.ibm.com>
 <20200716152237.GC373728@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200716152237.GC373728@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, anju@linux.vnet.ibm.com, kan.liang@linux.intel.com, nasastry@in.ibm.com
List-Id: linux-perf-users.vger.kernel.org



On 7/16/20 8:52 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jul 16, 2020 at 03:12:11PM +0530, Kajol Jain escreveu:
>> Patchset enhance current runtime parameter support. It introduces new
>> fields like "PerChip" and "PerCore" similar to the field "PerPkg" which is
>> used to specify perpkg events. 
>>
>> The "PerCore" and "PerChip" specifies whether its core or chip events.
>> Based on which we can decide which runtime parameter user want to
>> access. Now character  '?' can refers different parameter based on user
>> requirement.
>>
>> Initially, every time we want to add new terms like chip, core, thread
>> etc, we need to create corrsponding fields in pmu_events and event
>> struct.
>> This patchset adds an enum called 'aggr_mode_class' which store all these
>> aggregation like perpkg/percore. It also adds new field 'AggregationMode'
>> to capture these terms.
>> Now, if user wants to add any new term, they just need to add it in
>> the enum defined. I try to test it with  my current setup.
>>
>> I also need to replace PerPkg field to AggregationMode in all the
>> x86 uncore json files. It will great if Andi and team can test it
>> and let me know if they have any concerns.
>>
>> Changelog:
>> v2 -> v3:
>> - Did some nits changes suggested by Jiri include correction of
>>   indentation, and making PerCore/PerChip values forward after
>>   PerPkg as 1 in the enum.
>> - Rebase the patchset on Arnaldo's tmp.perf/core branch.
>> - Change RFC tag
> 
> Hey, have anybody provided Acked-by/Reviewed-by for previous revisions
> of this patchset? If so you could have collected them for patches
> without changes, was that the case?

Hi Arnaldo,
      I did get "Acked-by: Ian Rogers" on my initial prototype which I send in my RFC.
Link to the patch: https://lkml.org/lkml/2020/7/5/399

After that, I break it down and made some nits changes as suggested by Jiri, that's why I didn't
add his Acked-by tag.
Ian should I add it, if it seems fine to you.

Thanks,
Kajol Jain
> 
> - Arnaldo
>  
>> v1 -> v2:
>> - Rather then adding new field as PerCore/PerChip, created a new enum
>>   to get these fields. And new field as "AggregationMode" which can
>>   be used to capture these fields from json file.
>>   - Suggested By Ian Rogers
>>
>>
>> Kajol Jain (5):
>>   perf/pmu-events/jevents: Add enum to store aggregation like PerPkg
>>   pmu-events/x86/uncore: Replace PerPkg field to AggregationMode in x86
>>     json files
>>   perf jevents: Add support for parsing perchip/percore events
>>   perf/tools: Pass pmu_event structure as a parameter for
>>     arch_get_runtimeparam
>>   perf/tools/pmu_events/powerpc: Add hv_24x7 core level metric events
>>
>>  tools/perf/arch/powerpc/util/header.c         |   7 +-
>>  .../arch/powerpc/power9/nest_metrics.json     |  27 +-
>>  .../arch/x86/broadwellde/uncore-cache.json    |  62 ++--
>>  .../arch/x86/broadwellde/uncore-memory.json   |  18 +-
>>  .../arch/x86/broadwellde/uncore-power.json    |  18 +-
>>  .../arch/x86/broadwellx/uncore-cache.json     |  62 ++--
>>  .../x86/broadwellx/uncore-interconnect.json   |   6 +-
>>  .../arch/x86/broadwellx/uncore-memory.json    |  18 +-
>>  .../arch/x86/broadwellx/uncore-power.json     |  18 +-
>>  .../arch/x86/cascadelakex/uncore-memory.json  |  64 ++--
>>  .../arch/x86/cascadelakex/uncore-other.json   | 332 +++++++++---------
>>  .../arch/x86/haswellx/uncore-cache.json       |  62 ++--
>>  .../x86/haswellx/uncore-interconnect.json     |   6 +-
>>  .../arch/x86/haswellx/uncore-memory.json      |  18 +-
>>  .../arch/x86/haswellx/uncore-power.json       |  18 +-
>>  .../arch/x86/ivytown/uncore-cache.json        |  62 ++--
>>  .../arch/x86/ivytown/uncore-interconnect.json |  10 +-
>>  .../arch/x86/ivytown/uncore-memory.json       |  16 +-
>>  .../arch/x86/ivytown/uncore-power.json        |  52 +--
>>  .../arch/x86/jaketown/uncore-cache.json       |  40 +--
>>  .../x86/jaketown/uncore-interconnect.json     |  10 +-
>>  .../arch/x86/jaketown/uncore-memory.json      |  18 +-
>>  .../arch/x86/jaketown/uncore-power.json       |  52 +--
>>  .../x86/knightslanding/uncore-memory.json     |   8 +-
>>  .../arch/x86/skylakex/uncore-memory.json      |  36 +-
>>  .../arch/x86/skylakex/uncore-other.json       | 220 ++++++------
>>  .../arch/x86/tremontx/uncore-memory.json      |  14 +-
>>  .../arch/x86/tremontx/uncore-other.json       |  70 ++--
>>  .../arch/x86/tremontx/uncore-power.json       |   2 +-
>>  tools/perf/pmu-events/jevents.c               |  45 ++-
>>  tools/perf/pmu-events/jevents.h               |   2 +-
>>  tools/perf/pmu-events/pmu-events.h            |   8 +-
>>  tools/perf/tests/pmu-events.c                 |   8 +-
>>  tools/perf/util/metricgroup.c                 |   5 +-
>>  tools/perf/util/metricgroup.h                 |   3 +-
>>  tools/perf/util/pmu.c                         |   6 +-
>>  36 files changed, 729 insertions(+), 694 deletions(-)
>>
>> -- 
>> 2.26.2
>>
> 
