From: kajoljain <kjain@linux.ibm.com>
Subject: Re: [PATCH v4 0/5] powerpc/perf: Add json file support for hv_24x7
 core level events
Date: Sun, 26 Jul 2020 15:01:09 +0530
Message-ID: <b2830443-8e86-8e70-705b-ac243f7a63f1@linux.ibm.com>
References: <20200720070127.109234-1-kjain@linux.ibm.com>
 <20200720192133.GM760733@krava> <20200720193149.GA3906670@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200720193149.GA3906670@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>, ak@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, pc@us.ibm.com, namhyung@kernel.org, yao.jin@linux.intel.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, irogers@google.com, maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com, anju@linux.vnet.ibm.com, kan.liang@linux.intel.com, nasastry@in.ibm.com
List-Id: linux-perf-users.vger.kernel.org



On 7/21/20 1:01 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jul 20, 2020 at 09:21:33PM +0200, Jiri Olsa escreveu:
>> On Mon, Jul 20, 2020 at 12:31:22PM +0530, Kajol Jain wrote:
>>> Patchset enhance current runtime parameter support. It introduces new
>>> fields like "PerChip" and "PerCore" similar to the field "PerPkg" which is
>>> used to specify perpkg events. 
>>>
>>> The "PerCore" and "PerChip" specifies whether its core or chip events.
>>> Based on which we can decide which runtime parameter user want to
>>> access. Now character  '?' can refers different parameter based on user
>>> requirement.
>>>
>>> Initially, every time we want to add new terms like chip, core, thread
>>> etc, we need to create corrsponding fields in pmu_events and event
>>> struct.
>>> This patchset adds an enum called 'aggr_mode_class' which store all these
>>> aggregation like perpkg/percore. It also adds new field 'AggregationMode'
>>> to capture these terms.
>>> Now, if user wants to add any new term, they just need to add it in
>>> the enum defined. I try to test it with  my current setup.
>>>
>>> I also need to replace PerPkg field to AggregationMode in all the
>>> x86 uncore json files. It will great if Andi and team can test it
>>> and let me know if they have any concerns.
>>>
>>> Changelog:
>>> v3 -> v4:
>>> - Include pmu-events.h header file in jevents.c and remove
>>>   redecalaration of enum aggr_mode_class as Suggested by Jiri.
>>> - Add Acked-by tag.
>>
>> looks good to me, but still missing reaction from people maintaining
>> intel's jsons
> 
> Yeah, since this is something trying to be generic enough to describe
> events from different arches, we should not double-fail into
> generalizing this :-\

Hi,
   Yes that make sense. In this patchset we are not doing any logical change from intel side,
as in all the json file "PerPkg" value map to '1', we are using same value in the
enum to not break that use case. And just replacing 'PerPkg' to new added field
`AggregationMode'. 

But you are right, it will be good to have Ack from intel people. Any comments how we can push these
changes?

Thanks,
Kajol Jain
> 
> - Arnaldo
> 
