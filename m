Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCB5134B0;
	Thu,  6 Jun 2024 04:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717649918; cv=none; b=LTiu0dfp7C16CgvkAHo+3tBNWeVc3YUKphFnyDBBlpICoO8YwJcOc8INb5xwbLC5+kNKKQ30mTEzzylW+x6oR/EK4CF1k29cLEaX7IPTUOHxoo7J1InjnX36OgpMm5JHdtVsqs+nvcmlx3InIf18tP592Kxuui8fvid7HVe4lwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717649918; c=relaxed/simple;
	bh=LafqlTLn7oYSHshTHT3OhRxkk7C5uZQPODZTHbgo49w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mW3/tCro4PBZMCD8Ib1itN/M7fmDNZpmTvqghk3+s5DOc3fFw1St+Rdio2Ak21MJ3nnrF0BGjoIsH0PADrcFen2sPjwQqXmFSb3xo8JSfmUwxo6mrjkgyBwkc20rgH0wQg5wiXkA6+cM9jsJoN2Ejone0lml1Mu37kP8e5es52Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 192C4339;
	Wed,  5 Jun 2024 21:58:59 -0700 (PDT)
Received: from [10.162.40.16] (a077893.blr.arm.com [10.162.40.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B69103F64C;
	Wed,  5 Jun 2024 21:58:29 -0700 (PDT)
Message-ID: <5dcfbebe-f9f1-4767-bf21-7717f20af5d0@arm.com>
Date: Thu, 6 Jun 2024 10:28:26 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V17 0/9] arm64/perf: Enable branch stack sampling
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>, James Clark <james.clark@arm.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Suzuki Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com
References: <20240405024639.1179064-1-anshuman.khandual@arm.com>
 <80d33844-bdd2-4fee-81dd-9cd37c63d42c@arm.com> <Zli6Ot0TwK3Qy-ee@J2N7QTR9R3>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Zli6Ot0TwK3Qy-ee@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/30/24 23:11, Mark Rutland wrote:
> On Thu, May 30, 2024 at 10:47:34AM +0100, James Clark wrote:
>> On 05/04/2024 03:46, Anshuman Khandual wrote:
>>> This series enables perf branch stack sampling support on arm64 platform
>>> via a new arch feature called Branch Record Buffer Extension (BRBE). All
>>> the relevant register definitions could be accessed here.
>>>
>>> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
>>>
>>> This series applies on 6.9-rc2.
>>>
>>> Also this series is being hosted below for quick access, review and test.
>>>
>>> https://git.gitlab.arm.com/linux-arm/linux-anshuman.git (brbe_v17)
>>>
>>> There are still some open questions regarding handling multiple perf events
>>> with different privilege branch filters getting on the same PMU, supporting
>>> guest branch stack tracing from the host etc. Finally also looking for some
>>> suggestions regarding supporting BRBE inside the guest. The series has been
>>> re-organized completely as suggested earlier.
>>>
>>> - Anshuman
>>>
>> [...]
>>>
>>> ------------------ Possible 'branch_sample_type' Mismatch -----------------
>>>
>>> Branch stack sampling attributes 'event->attr.branch_sample_type' generally
>>> remain the same for all the events during a perf record session.
>>>
>>> $perf record -e <event_1> -e <event_2> -j <branch_filters> [workload]
>>>
>>> event_1->attr.branch_sample_type == event_2->attr.branch_sample_type
>>>
>>> This 'branch_sample_type' is used to configure the BRBE hardware, when both
>>> events i.e <event_1> and <event_2> get scheduled on a given PMU. But during
>>> PMU HW event's privilege filter inheritance, 'branch_sample_type' does not
>>> remain the same for all events. Let's consider the following example
>>>
>>> $perf record -e cycles:u -e instructions:k -j any,save_type ls
>>>
>>> cycles->attr.branch_sample_type != instructions->attr.branch_sample_type
>>>
>>> Because cycles event inherits PERF_SAMPLE_BRANCH_USER and instruction event
>>> inherits PERF_SAMPLE_BRANCH_KERNEL. The proposed solution here configures
>>> BRBE hardware with 'branch_sample_type' from last event to be added in the
>>> PMU and hence captured branch records only get passed on to matching events
>>> during a PMU interrupt.
>>>
>>
>> Hi Anshuman,
>>
>> Surely because of this example we should merge? At least we have to try
>> to make the most common basic command lines work. Unless we expect all
>> tools to know whether the branch buffer is shared between PMUs on each
>> architecture or not. The driver knows though, so can merge the settings
>> because it all has to go into one BRBE.
> 
> The difficulty here is that these are opened as independent events (not
> in the same event group), and so from the driver's PoV, this is no
> different two two users independently doing:
> 
> 	perf record -e event:u -j any,save_type -p ${SOME_PID}
> 
> 	perf record -e event:k -j any,save_type -p ${SOME_PID}
> 
> ... where either would be surprised to get the merged result.

Right, that's the problem. The proposed idea here ensures that each event
here will get only expected branch records, even though sample size might
get reduced as the HW filters overrides might not be evenly split between
them during the perf session.

> 
> So, if we merge the filters into the most permissive set, we *must*
> filter them when handing them to userspace so that each event gets the
> expected set of branch records.

Agreed, if the branch filters get merged to the most permissive set via
an OR semantics, then results must be filtered before being pushed into
the ring buffer for each individual event that has overflown during the
PMU IRQ.

> 
> Assuming we do that, for Anshuman's case above:
> 
> 	perf record -e cycles:u -e instructions:k -j any,save_type ls	
> 
> ... the overflow of the cycles evnt will only record user branch
> records, and the overflow of the instructions event will only record
> kernel branch records.

Right.

> 
> I think it's arguable either way as to whether users want that or merged
> records; we should probably figure out with the tools folk what the
> desired behaviour is for that command line, but as above I don't think
> that we can have the kernel give both events merged records unless
> userspace asks for that explicitly.

Right, we should not give merged results unless explicitly asked by the
event. Otherwise that might break the semantics.

> 
>> Merging the settings in tools would be a much harder problem.
> 
> I can see that it'd be harder to do that up-front when parsing each
> event independently, but there is a phase where the tool knows about all
> of the events and *might* be able to do that, where the driver doesn't
> really know at any point that these events are related.
> 
> Regardless, I assume that if the user passes:
> 
> 	perf record -e cycles:u -e instructions:k -k any,u,k,save_type ls
> 
> ... both events will be opened with PERF_SAMPLE_BRANCH_USER and
> PERF_SAMPLE_BRANCH_KERNEL, so maybe that's good, and in-kernel filtering
> is sufficient.
Kernel filtering will not be required in this case as "-j any,u,k," overrides
both event's individual privilege request i.e cycles:u and instructions:k. So
both the events will receive branch records related to PERF_SAMPLE_BRANCH_USER
and PERF_SAMPLE_BRANCH_KERNEL. From branch sample perspective privilege filter
is (PERF_SAMPLE_BRANCH_USER | PERF_SAMPLE_BRANCH_KERNEL).

> 
>> Any user that doesn't have permission for anything in the merged result
>> can continue to get nothing.
>>
>> And we can always add filtering in the kernel later on if we want to to
>> make it appear to behave even more normally.
> 
> As above, I think if we merge the HW filters in the kernel then the
> kernel must do SW filtering. I don't think that's something we can leave
> for later.

Alright.

> 
>>> static int
>>> armpmu_add(struct perf_event *event, int flags)
>>> {
>>> 	........
>>> 	if (has_branch_stack(event)) {
>>> 		/*
>>> 		 * Reset branch records buffer if a new task event gets
>>> 		 * scheduled on a PMU which might have existing records.
>>> 		 * Otherwise older branch records present in the buffer
>>> 		 * might leak into the new task event.
>>> 		 */
>>> 		if (event->ctx->task && hw_events->brbe_context != event->ctx) {
>>> 			hw_events->brbe_context = event->ctx;
>>> 			if (armpmu->branch_reset)
>>> 				armpmu->branch_reset();
>>> 		}
>>> 		hw_events->brbe_users++;
>>> Here ------->	hw_events->brbe_sample_type = event->attr.branch_sample_type;
>>> 	}
>>> 	........
>>> }
>>>
>>> Instead of overriding existing 'branch_sample_type', both could be merged.
>>>
>>
>> I can't see any use case where anyone would want the override behavior.
>> Especially if you imagine multiple users not even aware of each other.
> 
> I completely agree that one event overriding another is not an
> acceptable solution.
> 
>> Either the current "no records for mismatches" or the merged one make sense.
> 
> I think our options are:
> 
> 1) Do not allow events with conflicting HW filters to be scheduled (e.g.
>    treating this like a counter constraint).

That's the easiest solution and will keep things simple but downside being
the sample size will probably get much reduced. But such scenarios will be
rare, and hence won't matter much.

> 
> 2) Allow events with conflicting HW filters to be scheduled, merge the
>    active HW filters, and SW filter the records in the kernel.
> 
> 3) Allow events with conflicting branch filters to be scheduled, but
>    only those which match the "active" filter get records.

That's the proposed solution. "Active" filter gets decided on which event
comes last thus override the previous and PMU interrupt handler delivers
branch records only to the matching events.

> 
> So far (2) seems to me like the best option, and IIUC that's what x86
> does with LBR. I suspect that also justifies discarding records at
> context switch time, since we can't know how many relevant records were
> discarded due to conflicting records (and so cannot safely stitch
> records), and users have to expect that they may get fewer records than
> may exist in HW anyway.

So if we implement merging branch filters requests and SW filtering for the
captured branch records, we should also drop saving and stitching mechanism
completely ?

Coming back to the implementation for option (2), the following code change
(tentative and untested) will merge branch filter requests and drop the event
filter check during PMU interrupt.

diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
index 45ac2d0ca04c..9afa4e48d957 100644
--- a/drivers/perf/arm_brbe.c
+++ b/drivers/perf/arm_brbe.c
@@ -286,7 +286,13 @@ void armv8pmu_branch_stack_add(struct perf_event *event, struct pmu_hw_events *h
                armv8pmu_branch_stack_reset();
        }
        hw_events->branch_users++;
-       hw_events->branch_sample_type = event->attr.branch_sample_type;
+
+       /*
+        * Merge all branch filter requests from different perf
+        * events being added into this PMU. This includes both
+        * privilege and branch type filters.
+        */
+       hw_events->branch_sample_type |= event->attr.branch_sample_type;
 }
 
 void armv8pmu_branch_stack_del(struct perf_event *event, struct pmu_hw_events *hw_events)
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 6137ae4ba7c3..c5311d5365cc 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -856,15 +856,12 @@ static void read_branch_records(struct pmu_hw_events *cpuc,
                return;
 
        /*
-        * Overflowed event's branch_sample_type does not match the configured
-        * branch filters in the BRBE HW. So the captured branch records here
-        * cannot be co-related to the overflowed event. Report to the user as
-        * if no branch records have been captured, and flush branch records.
-        * The same scenario is applicable when the current task context does
-        * not match with overflown event.
+        * When the current task context does not match with the PMU overflown
+        * event, the captured branch records here cannot be co-related to the
+        * overflowed event. Report to the user as if no branch records have
+        * been captured, and flush branch records.
         */
-       if ((cpuc->branch_sample_type != event->attr.branch_sample_type) ||
-           (event->ctx->task && cpuc->branch_context != event->ctx))
+       if (event->ctx->task && cpuc->branch_context != event->ctx)
                return;
 
        /*

and something like the following change (tentative and untested) implements the
required SW branch records filtering.

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index c5311d5365cc..d2390657c466 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -843,11 +843,97 @@ static void armv8pmu_stop(struct arm_pmu *cpu_pmu)
        armv8pmu_pmcr_write(armv8pmu_pmcr_read() & ~ARMV8_PMU_PMCR_E);
 }
 
+static bool filter_branch_type(struct perf_event *event, struct perf_branch_entry *entry)
+{
+       u64 br_type = event->attr.branch_sample_type;
+       u64 mask = PERF_BR_UNCOND;
+
+       if (br_type & PERF_SAMPLE_BRANCH_ANY)
+               return true;
+
+       if (entry->type == PERF_BR_UNKNOWN)
+               return true;
+
+       if (br_type & PERF_SAMPLE_BRANCH_IND_JUMP)
+               mask |= PERF_BR_IND;
+
+       if (br_type & PERF_SAMPLE_BRANCH_COND) {
+               mask &= ~PERF_BR_UNCOND;
+               mask |= PERF_BR_COND;
+       }
+
+       if (br_type & PERF_SAMPLE_BRANCH_CALL)
+               mask |= PERF_BR_CALL;
+
+       if (br_type & PERF_SAMPLE_BRANCH_IND_CALL)
+               mask |= PERF_BR_IND_CALL;
+
+       if (br_type & PERF_SAMPLE_BRANCH_ANY_CALL) {
+               mask |= PERF_BR_CALL;
+               mask |= PERF_BR_IRQ;
+               mask |= PERF_BR_SYSCALL;
+               mask |= PERF_BR_SERROR;
+               if (br_type & PERF_SAMPLE_BRANCH_COND)
+                       mask |= PERF_BR_COND_CALL;
+       }
+
+       if (br_type & PERF_SAMPLE_BRANCH_ANY_RETURN) {
+               mask |= PERF_BR_RET;
+               mask |= PERF_BR_ERET;
+               mask |= PERF_BR_SYSRET;
+               if (br_type & PERF_SAMPLE_BRANCH_COND)
+                       mask |= PERF_BR_COND_RET;
+       }
+       return mask & entry->type;
+}
+
+static bool filter_branch_privilege(struct perf_event *event, struct perf_branch_entry *entry)
+{
+       u64 br_type = event->attr.branch_sample_type;
+
+       if (!(br_type & PERF_SAMPLE_BRANCH_USER)) {
+               if (is_ttbr0_addr(entry->from) || is_ttbr0_addr(entry->to))
+                       return false;
+       }
+
+       if (!(br_type & PERF_SAMPLE_BRANCH_KERNEL)) {
+               if (is_ttbr1_addr(entry->from) || is_ttbr1_addr(entry->to))
+                       return false;
+       }
+
+       if (!(br_type & PERF_SAMPLE_BRANCH_HV)) {
+               if (is_kernel_in_hyp_mode()) {
+                       if (is_ttbr1_addr(entry->from) || is_ttbr1_addr(entry->to))
+                               return false;
+               }
+       }
+       return true;
+}
+
+static void filter_branch_records(struct perf_event *event, struct pmu_hw_events *cpuc,
+                                 struct branch_records *event_records)
+{
+       struct perf_branch_entry *entry;
+       int idx, count;
+
+       memset(event_records, 0, sizeof(struct branch_records));
+       for (idx = 0, count = 0; idx < cpuc->branches->branch_stack.nr; idx++) {
+               entry = &cpuc->branches->branch_entries[idx];
+               if (!filter_branch_privilege(event, entry) || !filter_branch_type(event, entry))
+                       continue;
+
+               memcpy(&event_records->branch_entries[count], &entry, sizeof(struct perf_branch_entry));
+               count++;
+       }
+}
+
 static void read_branch_records(struct pmu_hw_events *cpuc,
                                struct perf_event *event,
                                struct perf_sample_data *data,
                                bool *branch_captured)
 {
+       struct branch_records event_records;
+
        /*
         * CPU specific branch records buffer must have been allocated already
         * for the hardware records to be captured and processed further.
@@ -874,6 +960,20 @@ static void read_branch_records(struct pmu_hw_events *cpuc,
                armv8pmu_branch_read(cpuc, event);
                *branch_captured = true;
        }
+
+       /*
+        * Filter captured branch records
+        *
+        * PMU captured branch records would contain samples applicable for
+        * the agregated branch filters, for all events that got scheduled
+        * on this PMU. Hence the branch records need to be filtered first
+        * so that each individual event get samples they had requested.
+        */
+       if (cpuc->branch_sample_type != event->attr.branch_sample_type) {
+               filter_branch_records(event, cpuc, &event_records);
+               perf_sample_save_brstack(data, event, &event_records.branch_stack, NULL);
+               return;
+       }
        perf_sample_save_brstack(data, event, &cpuc->branches->branch_stack, NULL);
 }
 
