From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [RFC v2 3/5] perf jevents: Add support for parsing
 perchip/percore events
Date: Tue, 14 Jul 2020 14:42:15 +0530
Message-ID: <92f5fb5e-8abb-64a4-a217-0dc068a2a47b@linux.ibm.com>
References: <20200707122314.624400-1-kjain@linux.ibm.com>
 <20200707122314.624400-4-kjain@linux.ibm.com> <20200712185523.GA147742@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200712185523.GA147742@krava>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, anju@linux.vnet.ibm.com, kan.liang@linux.intel.com, nasastry@in.ibm.com
List-Id: linux-perf-users.vger.kernel.org



On 7/13/20 12:25 AM, Jiri Olsa wrote:
> On Tue, Jul 07, 2020 at 05:53:12PM +0530, Kajol Jain wrote:
>> Added the "PerChip" field  in enum so that perf knows they are
>> per chip events.
>>
>> Added the "PerCore" field in enum so that perf knows they are
>> per core events and add these fields to pmu_event structure.
>>
>> Similar to the way we had "PerPkg field
>> to specify perpkg events.
>>
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> ---
>>  tools/perf/pmu-events/jevents.c    | 8 +++++++-
>>  tools/perf/pmu-events/pmu-events.h | 4 +++-
>>  2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
>> index b2f59f0af63d..1f65047db000 100644
>> --- a/tools/perf/pmu-events/jevents.c
>> +++ b/tools/perf/pmu-events/jevents.c
>> @@ -54,13 +54,19 @@ int verbose;
>>  char *prog;
>>  
>>  enum aggr_mode_class {
>> -	PerPkg = 1
>> +	PerChip = 0,
> 
> is there a reason for the values? just wonder if it's wise to have PerChip == 0,
> and why you would not continue with forward when PerPkg is 1

Hi Jiri,
     Yes, there is no reason for having particular values, It just added to get which parameter
we are referring. I can sure continue it after Perpkg.

Thanks,
Kajol Jain

> 
> jirka
> 
>> +	PerPkg = 1,
>> +	PerCore = 2
>>  };
>>  
> 
> SNIP
> 
