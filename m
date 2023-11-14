Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB1C4175D
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Nov 2023 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98B5D123;
	Tue, 14 Nov 2023 09:17:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CB6AC15;
	Tue, 14 Nov 2023 09:18:16 -0800 (PST)
Received: from [10.57.72.217] (unknown [10.57.72.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8019F3F641;
	Tue, 14 Nov 2023 09:17:29 -0800 (PST)
Message-ID: <af04e269-d43d-0dd6-5434-3cea9c74be01@arm.com>
Date: Tue, 14 Nov 2023 17:17:28 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [V14 0/8] arm64/perf: Enable branch stack sampling
Content-Language: en-US
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Suzuki Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com,
 mark.rutland@arm.com
References: <20231114051329.327572-1-anshuman.khandual@arm.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <20231114051329.327572-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/11/2023 05:13, Anshuman Khandual wrote:
> This series enables perf branch stack sampling support on arm64 platform
> via a new arch feature called Branch Record Buffer Extension (BRBE). All
> the relevant register definitions could be accessed here.
> 
[...]
> 
> --------------------------- Virtualisation support ------------------------
> 
> - Branch stack sampling is not currently supported inside the guest (TODO)
> 
> 	- FEAT_BRBE advertised as absent via clearing ID_AA64DFR0_EL1.BRBE
> 	- Future support in guest requires emulating FEAT_BRBE

If you never add support for the host looking into a guest, and you save
and restore all the BRBINF[n] registers, I think you might be able to
just let the guest do whatever it wants with BRBE and not trap and
emulate it? Maybe there is some edge case why that wouldn't work, but
it's worth thinking about.

For BRBE specifically I don't see much of a use case for hosts looking
into a guest, at least not like with PMU counters.

> 
> - Branch stack sampling the guest is not supported in the host      (TODO)
> 
> 	- Tracing the guest with event->attr.exclude_guest = 0
> 	- There are multiple challenges involved regarding mixing events
> 	  with mismatched branch_sample_type and exclude_guest and passing
> 	  on captured BRBE records to intended events during PMU interrupt
> 
> - Guest access for BRBE registers and instructions has been blocked
> 
> - BRBE state save is not required for VHE host (EL2) guest (EL1) transition
> 
> - BRBE state is saved for NVHE host (EL1) guest (EL1) transition
> 
> -------------------------------- Testing ---------------------------------
> 
> - Cross compiled for both arm64 and arm32 platforms
> - Passes all branch tests with 'perf test branch' on arm64
> 
> -------------------------------- Questions -------------------------------
> 
> - Instead of configuring the BRBE HW with branch_sample_type from the last
>   event to be added on the PMU as proposed, could those be merged together
>   e.g all privilege requests ORed, to form a common BRBE configuration and
>   all events get branch records after a PMU interrupt ?
> 
