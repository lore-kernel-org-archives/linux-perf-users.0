From: Sean V Kelley <seanvk.dev@oregontracks.org>
Subject: Re: [PATCH v2] perf vendor events arm64: Revise core JSON events for
 eMAG
Date: Mon, 17 Sep 2018 08:40:30 -0700
Message-ID: <43F96985-80D1-4398-8614-59678FF7B32C@oregontracks.org>
References: <20180910002625.22253-1-seanvk.dev@oregontracks.org>
 <1d601b30-5065-b778-9927-b7d9f04f6b6f@redhat.com>
 <bb09333a-ac9c-4163-98a0-4f50b6ff9079@huawei.com>
 <0c154237-0c1f-cc9d-c697-1ca66e9297ae@redhat.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <0c154237-0c1f-cc9d-c697-1ca66e9297ae@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: William Cohen <wcohen@redhat.com>
Cc: linux-perf-users@vger.kernel.org, John Garry <john.garry@huawei.com>, acme@kernel.org, linux-arm-kernel@lists.infradead.org, Linuxarm <linuxarm@huawei.com>
List-Id: linux-perf-users.vger.kernel.org



Sent from my iPhone

> On Sep 17, 2018, at 7:39 AM, William Cohen <wcohen@redhat.com> wrote:
> 
>> On 9/17/18 4:53 AM, John Garry wrote:
>>> On 16/09/2018 21:39, William Cohen wrote:
>>>> On 9/9/18 8:26 PM, Sean V Kelley wrote:
>>>> Split the PMU events into meaningful functional groups.  Update core
>>>> pmu events based on supported ARMv8 recommended IMPLEMENTATION DEFINED
>>>> events.
>>>> 
>>>> The JSON files are updated with reference to a PMU table shared here:
>>>> 
>>>> https://github.com/AmpereComputing/ampere-centos-kernel/blob/amp-centos-7.5-kernel/Documentation/arm64/eMAG-ARM-CoreImpDefined.pdf
>>>> 
>>>> -- 
>>>> Changes in V2:
>>>> - Provided documentation for changes - John, William
>>>> - Broke up into meaningful groups - William
>>>> -- 
>>>> 
>>>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>>>> Cc: William Cohen <wcohen@redhat.com>
>>>> Cc: John Garry <john.garry@huawei.com>
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> 
>>>> Signed-off-by: Sean V Kelley <seanvk.dev@oregontracks.org>
>>>> ---
>>>>  .../arch/arm64/ampere/emag/branch.json        |  23 +++
>>>>  .../arch/arm64/ampere/emag/bus.json           |  26 +++
>>>>  .../arch/arm64/ampere/emag/cache.json         | 191 ++++++++++++++++++
>>>>  .../arch/arm64/ampere/emag/clock.json         |  20 ++
>>>>  .../arch/arm64/ampere/emag/core-imp-def.json  |  32 ---
>>>>  .../arch/arm64/ampere/emag/counter.json       |   8 +
>>>>  .../arch/arm64/ampere/emag/exception.json     |  50 +++++
>>>>  .../arch/arm64/ampere/emag/instruction.json   |  89 ++++++++
>>>>  .../arch/arm64/ampere/emag/intrinsic.json     |  14 ++
>>>>  .../arch/arm64/ampere/emag/memory.json        |  29 +++
>>>>  .../arch/arm64/ampere/emag/pipeline.json      |  50 +++++
>>>>  11 files changed, 500 insertions(+), 32 deletions(-)
>>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/branch.json
>>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/bus.json
>>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/cache.json
>>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/clock.json
>>>>  delete mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json
>>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/counter.json
>>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/exception.json
>>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/instruction.json
>>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/intrinsic.json
>>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/memory.json
>>>>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/pipeline.json
>>> 
>>> Hi,
>>> 
>>> The patch looks okay for most part. It would be good to factor out the events 0x00-0x38 from "Table D5-8 PMU common architectural and microarchitectural event numbers" in https://static.docs.arm.com/ddi0487/ca/DDI0487C_a_armv8_arm.pdf and have them in armv8-recommended.json so events like BR_MIS_PRED and BR_PRED (and anything else in the range of 0x000-0x038) just end up be ArchStdEvent like the other predefined events.  Maybe do the factoring out as a follow on patch to this patch.
>>> 
>> 
>> I know it's not ideal, but I think it would be better to only use the common arch events exposed by the pmu kernel driver, as:
>> - it's generally bad to replicate
>> - the common arch event support are detected by PMCEIDx, so there is need to add perf tool churn in defining per-SoC support
>> - potential problems in enabling replicated events
>> 
>> Thanks,
>> John
> 
> Yes, definitely want minimize duplication.  If the kernel is already determing which common events are available in an AARCH64 process then should be able to eliminate any entry that is below ARMV8_PMUV3_MAX_COMMON_EVENTS (0x40) from the event maps:

Hi

Definitely would like to reduce duplication while providing descriptive and meaningful access to users. I can strip the sub 0x40 common events already exposed  in the PMU perf driver in a v4 patch for now. 

But as you say, the kernel already knows what is exposed by the core pmu driver and could eliminate the duplication. 

Thanks

Sean 


> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/perf/arm_pmu.h#n104
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kernel/perf_event.c#n1007
> 
> -Will Cohen
>> Hi 
>>> The following counter.json wouldn't be that useful.  Perf doesn't allow layout of what goes in which PMU register. It should be removed:
>>> 
>>>> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/counter.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/counter.json
>>>> new file mode 100644
>>>> index 000000000000..6561ed58f13f
>>>> --- /dev/null
>>>> +++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/counter.json
>>>> @@ -0,0 +1,8 @@
>>>> +[
>>>> +    {
>>>> +        "PublicDescription": "For odd-numbered counters, increments the count by one for each overflow of the preceding even-numbered counter. For even-numbered counters there is no increment.",
>>>> +        "EventCode": "0x1e",
>>>> +        "EventName": "CHAIN",
>>>> +        "BriefDescription": "Chain counter"
>>>> +    },
>>>> +]
>>> 
>>> 
>>> 
>>> -Will Cohen
>>> 
>>> .
>>> 
>> 
>> 
> 
