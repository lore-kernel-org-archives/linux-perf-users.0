Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9516946B80;
	Thu, 30 May 2024 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090883; cv=none; b=tlKr4yir4jKbihcu3z4qxKW61hwh1t4XW/6lzMPjtGNfe3l+sH47wOHYQFiD2bsMbIE+yvuNOk3tXcOTIKFYSJ7FYPQWwCzy/VfZVmf1ep8JI+xrQDSHZsNSCfF9BzJommvSD3VT3TF49tENgzlRQvTBHs8iY56eBK4vOtsVki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090883; c=relaxed/simple;
	bh=+5ZRUANTEIFrVyEyZnCY/GGZi2TOl1WPU+VLIwb8Vog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHV+bGCsKFETdPFk17O0QUMfx+F7vHSOxQ4LyNubsREkCe8OzAadXTogw4MrpReF6mX3TX0X7KVIQF1ixsU85kG+s8/2cwy+0hoOREn7xoZGUOa4LHqbdtFer+kQglxtLi8TJ0UJ3w/xTwOnl04PQ9Yv8nyDC0JNt75HUkYuUzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 142491424;
	Thu, 30 May 2024 10:41:45 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D60633F792;
	Thu, 30 May 2024 10:41:17 -0700 (PDT)
Date: Thu, 30 May 2024 18:41:14 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: James Clark <james.clark@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com
Subject: Re: [PATCH V17 0/9] arm64/perf: Enable branch stack sampling
Message-ID: <Zli6Ot0TwK3Qy-ee@J2N7QTR9R3>
References: <20240405024639.1179064-1-anshuman.khandual@arm.com>
 <80d33844-bdd2-4fee-81dd-9cd37c63d42c@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80d33844-bdd2-4fee-81dd-9cd37c63d42c@arm.com>

On Thu, May 30, 2024 at 10:47:34AM +0100, James Clark wrote:
> On 05/04/2024 03:46, Anshuman Khandual wrote:
> > This series enables perf branch stack sampling support on arm64 platform
> > via a new arch feature called Branch Record Buffer Extension (BRBE). All
> > the relevant register definitions could be accessed here.
> > 
> > https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
> > 
> > This series applies on 6.9-rc2.
> > 
> > Also this series is being hosted below for quick access, review and test.
> > 
> > https://git.gitlab.arm.com/linux-arm/linux-anshuman.git (brbe_v17)
> > 
> > There are still some open questions regarding handling multiple perf events
> > with different privilege branch filters getting on the same PMU, supporting
> > guest branch stack tracing from the host etc. Finally also looking for some
> > suggestions regarding supporting BRBE inside the guest. The series has been
> > re-organized completely as suggested earlier.
> > 
> > - Anshuman
> > 
> [...]
> > 
> > ------------------ Possible 'branch_sample_type' Mismatch -----------------
> > 
> > Branch stack sampling attributes 'event->attr.branch_sample_type' generally
> > remain the same for all the events during a perf record session.
> > 
> > $perf record -e <event_1> -e <event_2> -j <branch_filters> [workload]
> > 
> > event_1->attr.branch_sample_type == event_2->attr.branch_sample_type
> > 
> > This 'branch_sample_type' is used to configure the BRBE hardware, when both
> > events i.e <event_1> and <event_2> get scheduled on a given PMU. But during
> > PMU HW event's privilege filter inheritance, 'branch_sample_type' does not
> > remain the same for all events. Let's consider the following example
> > 
> > $perf record -e cycles:u -e instructions:k -j any,save_type ls
> > 
> > cycles->attr.branch_sample_type != instructions->attr.branch_sample_type
> > 
> > Because cycles event inherits PERF_SAMPLE_BRANCH_USER and instruction event
> > inherits PERF_SAMPLE_BRANCH_KERNEL. The proposed solution here configures
> > BRBE hardware with 'branch_sample_type' from last event to be added in the
> > PMU and hence captured branch records only get passed on to matching events
> > during a PMU interrupt.
> > 
> 
> Hi Anshuman,
> 
> Surely because of this example we should merge? At least we have to try
> to make the most common basic command lines work. Unless we expect all
> tools to know whether the branch buffer is shared between PMUs on each
> architecture or not. The driver knows though, so can merge the settings
> because it all has to go into one BRBE.

The difficulty here is that these are opened as independent events (not
in the same event group), and so from the driver's PoV, this is no
different two two users independently doing:

	perf record -e event:u -j any,save_type -p ${SOME_PID}

	perf record -e event:k -j any,save_type -p ${SOME_PID}

... where either would be surprised to get the merged result.

So, if we merge the filters into the most permissive set, we *must*
filter them when handing them to userspace so that each event gets the
expected set of branch records.

Assuming we do that, for Anshuman's case above:

	perf record -e cycles:u -e instructions:k -j any,save_type ls	

... the overflow of the cycles evnt will only record user branch
records, and the overflow of the instructions event will only record
kernel branch records.

I think it's arguable either way as to whether users want that or merged
records; we should probably figure out with the tools folk what the
desired behaviour is for that command line, but as above I don't think
that we can have the kernel give both events merged records unless
userspace asks for that explicitly.

> Merging the settings in tools would be a much harder problem.

I can see that it'd be harder to do that up-front when parsing each
event independently, but there is a phase where the tool knows about all
of the events and *might* be able to do that, where the driver doesn't
really know at any point that these events are related.

Regardless, I assume that if the user passes:

	perf record -e cycles:u -e instructions:k -k any,u,k,save_type ls

... both events will be opened with PERF_SAMPLE_BRANCH_USER and
PERF_SAMPLE_BRANCH_KERNEL, so maybe that's good, and in-kernel filtering
is sufficient.

> Any user that doesn't have permission for anything in the merged result
> can continue to get nothing.
> 
> And we can always add filtering in the kernel later on if we want to to
> make it appear to behave even more normally.

As above, I think if we merge the HW filters in the kernel then the
kernel must do SW filtering. I don't think that's something we can leave
for later.

> > static int
> > armpmu_add(struct perf_event *event, int flags)
> > {
> > 	........
> > 	if (has_branch_stack(event)) {
> > 		/*
> > 		 * Reset branch records buffer if a new task event gets
> > 		 * scheduled on a PMU which might have existing records.
> > 		 * Otherwise older branch records present in the buffer
> > 		 * might leak into the new task event.
> > 		 */
> > 		if (event->ctx->task && hw_events->brbe_context != event->ctx) {
> > 			hw_events->brbe_context = event->ctx;
> > 			if (armpmu->branch_reset)
> > 				armpmu->branch_reset();
> > 		}
> > 		hw_events->brbe_users++;
> > Here ------->	hw_events->brbe_sample_type = event->attr.branch_sample_type;
> > 	}
> > 	........
> > }
> > 
> > Instead of overriding existing 'branch_sample_type', both could be merged.
> > 
> 
> I can't see any use case where anyone would want the override behavior.
> Especially if you imagine multiple users not even aware of each other.

I completely agree that one event overriding another is not an
acceptable solution.

> Either the current "no records for mismatches" or the merged one make sense.

I think our options are:

1) Do not allow events with conflicting HW filters to be scheduled (e.g.
   treating this like a counter constraint).

2) Allow events with conflicting HW filters to be scheduled, merge the
   active HW filters, and SW filter the records in the kernel.

3) Allow events with conflicting branch filters to be scheduled, but
   only those which match the "active" filter get records.

So far (2) seems to me like the best option, and IIUC that's what x86
does with LBR. I suspect that also justifies discarding records at
context switch time, since we can't know how many relevant records were
discarded due to conflicting records (and so cannot safely stitch
records), and users have to expect that they may get fewer records than
may exist in HW anyway.

Mark.
