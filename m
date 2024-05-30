Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFBF18396D;
	Thu, 30 May 2024 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717062463; cv=none; b=A8TLRE4TJt1N0kL5rpfjy6sn6hKpYsP5Qa9yXG3iaO91gwdGTVYNeP/M+wnnO4M21KAU8g8xdTyW+2wvliy8WvXfJUA34CXUINuMi1QfCmtILqrWs/HJfu7rGlF54Lc6rY2/MyaLHzbIdvWA2pZtkJK+eSxp7jxZgPjWF+waYKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717062463; c=relaxed/simple;
	bh=oJceATgDva1QgjQ+6MSy7M5QY7VdjFO8E11FvM9DfH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLMgoVhyBtQ2T7E3/dtog0mWMICP7epfPCwSVyOwuuRnmVlGlynw5ZmJ4q+tvmpDVErJTKxS2rt3IQQCTZRfh5VTG+NchFOeUHdU6HO8q32AeJ+08eBxOi4KZC/433QXa4dIQ0zHeK4sQJ4in08BlkxvAmc2zz52/o+FgBygMp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C1B9339;
	Thu, 30 May 2024 02:47:58 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A4AD3F641;
	Thu, 30 May 2024 02:47:32 -0700 (PDT)
Message-ID: <80d33844-bdd2-4fee-81dd-9cd37c63d42c@arm.com>
Date: Thu, 30 May 2024 10:47:34 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V17 0/9] arm64/perf: Enable branch stack sampling
To: Anshuman Khandual <anshuman.khandual@arm.com>, mark.rutland@arm.com
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Suzuki Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com
References: <20240405024639.1179064-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240405024639.1179064-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/04/2024 03:46, Anshuman Khandual wrote:
> This series enables perf branch stack sampling support on arm64 platform
> via a new arch feature called Branch Record Buffer Extension (BRBE). All
> the relevant register definitions could be accessed here.
> 
> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
> 
> This series applies on 6.9-rc2.
> 
> Also this series is being hosted below for quick access, review and test.
> 
> https://git.gitlab.arm.com/linux-arm/linux-anshuman.git (brbe_v17)
> 
> There are still some open questions regarding handling multiple perf events
> with different privilege branch filters getting on the same PMU, supporting
> guest branch stack tracing from the host etc. Finally also looking for some
> suggestions regarding supporting BRBE inside the guest. The series has been
> re-organized completely as suggested earlier.
> 
> - Anshuman
> 
[...]
> 
> ------------------ Possible 'branch_sample_type' Mismatch -----------------
> 
> Branch stack sampling attributes 'event->attr.branch_sample_type' generally
> remain the same for all the events during a perf record session.
> 
> $perf record -e <event_1> -e <event_2> -j <branch_filters> [workload]
> 
> event_1->attr.branch_sample_type == event_2->attr.branch_sample_type
> 
> This 'branch_sample_type' is used to configure the BRBE hardware, when both
> events i.e <event_1> and <event_2> get scheduled on a given PMU. But during
> PMU HW event's privilege filter inheritance, 'branch_sample_type' does not
> remain the same for all events. Let's consider the following example
> 
> $perf record -e cycles:u -e instructions:k -j any,save_type ls
> 
> cycles->attr.branch_sample_type != instructions->attr.branch_sample_type
> 
> Because cycles event inherits PERF_SAMPLE_BRANCH_USER and instruction event
> inherits PERF_SAMPLE_BRANCH_KERNEL. The proposed solution here configures
> BRBE hardware with 'branch_sample_type' from last event to be added in the
> PMU and hence captured branch records only get passed on to matching events
> during a PMU interrupt.
> 

Hi Anshuman,

Surely because of this example we should merge? At least we have to try
to make the most common basic command lines work. Unless we expect all
tools to know whether the branch buffer is shared between PMUs on each
architecture or not. The driver knows though, so can merge the settings
because it all has to go into one BRBE.

Merging the settings in tools would be a much harder problem.

Any user that doesn't have permission for anything in the merged result
can continue to get nothing.

And we can always add filtering in the kernel later on if we want to to
make it appear to behave even more normally.

> static int
> armpmu_add(struct perf_event *event, int flags)
> {
> 	........
> 	if (has_branch_stack(event)) {
> 		/*
> 		 * Reset branch records buffer if a new task event gets
> 		 * scheduled on a PMU which might have existing records.
> 		 * Otherwise older branch records present in the buffer
> 		 * might leak into the new task event.
> 		 */
> 		if (event->ctx->task && hw_events->brbe_context != event->ctx) {
> 			hw_events->brbe_context = event->ctx;
> 			if (armpmu->branch_reset)
> 				armpmu->branch_reset();
> 		}
> 		hw_events->brbe_users++;
> Here ------->	hw_events->brbe_sample_type = event->attr.branch_sample_type;
> 	}
> 	........
> }
> 
> Instead of overriding existing 'branch_sample_type', both could be merged.
> 

I can't see any use case where anyone would want the override behavior.
Especially if you imagine multiple users not even aware of each other.
Either the current "no records for mismatches" or the merged one make sense.

James
