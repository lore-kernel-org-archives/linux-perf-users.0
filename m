Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B347E401A33
	for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511438; cv=none; b=DRWorMC0BEBgVsZqGT0D4TAtvAB5/0+DGpB+wXQpxwcEr9kRVqGfrZg3t0vaRiEsQX/eAI6flEnqo5snbG4kNq92QXss+ufQsIX37P+sLIBqfKOFWzmKkBLEhL4wAxFXv2ZpptkI0V+49pPVHRyzYsHYt3fAkSwGMvpGGa+URjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511438; c=relaxed/simple;
	bh=c0RkyRD1+LsDGq+lgiZuLPBDy9Zez13veFxZm7K1y9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWpUpE8yconPuP9AGhTSHDAP4xIRAKEglwxG/jxzJ8Bq1b417zj1M4HdtE9Nl36LlocStRxewMN9Jc5wsR+8R+xVm4qEGhXXU+azH5MYCqcN3UYyMaYeplqEIBIn4KXS5DB9WM8VugSxEilXQGmRv13oKJPamE86x44yy25DZ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sg1IZZ6P; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sg1IZZ6P"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45562c41ec7so1495928f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 07:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778511435; x=1779116235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QyL9i2Ps9ihe0zv6AT1n4AgSwB0/Wr45TQsgHUUycf0=;
        b=sg1IZZ6PXi6pcPOTM5qx3w57DRFG5bm/bSxvlk5sx0X3+XfvjsCelO5RC5jHf/2gDL
         bTQ3YRIsPFS7YiQUxtrG2iuKOOSg3o4IdO4cBbXPm40HWz0FcuwIs+GQGLQ1wOIja7ni
         yxCf4uoa+t2zCl9QUhZPWPWb7ECWb7xk7kbBIYDgGrr6ADJ9lQsV4ykaRDvIsLAYZWv6
         Q7q3K4gIOiRI8ZWVT5hElTheqqfCYtiy1m24d5MqYJW2uJTBGl4kQyf2Q7wiQJWfrkg/
         LDG52X8nrLAV1LaCV6LnN4ARFSPEZjyjdj42gNxAV/PntELAwJLRoomLMiEMrTAicBVc
         jn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778511435; x=1779116235;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QyL9i2Ps9ihe0zv6AT1n4AgSwB0/Wr45TQsgHUUycf0=;
        b=UYbkBYR7l8LZCv5/CwBGlMX3LBX8CJScD1k4Hjsm8mwK8IrwKo8+SHtnk856BkRh4e
         m/R5Zo8aLHOEfLO+CQTzIe/Lldj/TI0052Zh2oj/gSxeJ8xccFunNzka1RBo/8AZYHZ1
         kCXVagyAgKNG+zz1MYl/3drrJOg8tqeDaJjtaezJz1v3tm8pGKO4gw6blEmYdJOX9mOQ
         22mro3Tz7sR1M38LSMhXn/ZCI29yEDHXZ3KgIwWNSFh8/pvrIrc7WVbwPuVhPVq2gx+g
         2+4kL9aQOr156SUUHPyuOgo/Eh/1z7sgYSaWhJ1nuoBGBcoFDkaZpDlxp2Q5LScWVb3F
         q+8A==
X-Forwarded-Encrypted: i=1; AFNElJ/CWTfSMiuZPYBYRVNuSkyojdJdOF8q3/AgxnKnTw66R12EKWyL/ZGn0Pv4Bao3CQ1AAQCtNcZkmfqQxAXfpoCU@vger.kernel.org
X-Gm-Message-State: AOJu0Yy93Y+McjrDRhXxhnrxuRZl4GW5EVnDQh4v1ViQK23HkRgjleb6
	9TTYsFc8p/m+lEKs+Je/v1vfDaXGEeoAkRvuvfFbPTQYjEQED0SqoD2UwIeso+zBmjo=
X-Gm-Gg: Acq92OHn8wM18D5bCEhn6dUKSF8PIAM38GTi4m6wphjyjVjrbMv2PXu5wwhF9/ps2TA
	CydlOe5D688c2K22C+gKAiHvdLNnCyc4MldRTd+6mjsPhLX537A2LwmUjo3ezRvg2KPsaKaZat4
	y2vJoH4lrmiQXN5oEbIpcpKieMf2Qt9ER50hW+WfvgKcAXyaIoLH4tqry7Gc/2UCPahmsvG9ohM
	L/qYrcgk/A4cM2qDCfRWT8q5i83ziiN/UtOTDGmbUJMNuXd49FkR2YLxO+ejGFOtRHvOSvriRUS
	cxuAAFFsJ+TbuuAb695PPo1+V0yIfUSjGdCzl/DqXILfNikAEkE/eGgY+Tw2QG+5kRkdkZv9t66
	IArYYvo/upjYL0AWBL5LHNy7SSUV5OAEI/QqnR2ididIsv4eiRBRlABMFUHg9aRK00u3GaL8Cxy
	3zxwpskgXQ0AdiioaizUKxjvvSbOnEU36ofdpMUGo=
X-Received: by 2002:a5d:64e8:0:b0:449:9aee:4573 with SMTP id ffacd0b85a97d-4515ad768e3mr41131274f8f.18.1778511435091;
        Mon, 11 May 2026 07:57:15 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491f8d4c3sm25577709f8f.34.2026.05.11.07.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 07:57:14 -0700 (PDT)
Message-ID: <18d747ea-660a-4ae6-b8b8-365d745352ce@linaro.org>
Date: Mon, 11 May 2026 15:57:13 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/20] ARM64 PMU Partitioning
To: Colton Lewis <coltonlewis@google.com>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Mingwei Zhang <mizhang@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Mark Rutland <mark.rutland@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260504211813.1804997-1-coltonlewis@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260504211813.1804997-1-coltonlewis@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/05/2026 10:17 pm, Colton Lewis wrote:
> This series creates a new PMU scheme on ARM, a partitioned PMU that
> allows reserving a subset of counters for more direct guest access,
> significantly reducing overhead. More details, including performance
> benchmarks, can be read in the v1 cover letter linked below.
> 
> An overview of what this series accomplishes was presented at KVM
> Forum 2025. Slides [1] and video [2] are linked below.
> 
> After a few false starts, meeting with Will Deacon and Mark Rutland to
> discuss implementation ideas, and a few more false starts, I finally
> have an implementation of dynamic counter reservation that works
> without disrupting host perf too much. Now the host only loses access
> to the guest counters when a vCPU resides on the CPU.
> 
> The key was creating perf_pmu_resched_update, which behaves exactly
> like perf_pmu_resched except it takes a callback to call in between
> when the perf events are scheduled out and when they are scheduled
> back in. That allows us to update the PMU's available counters when we
> know they are not currently in use without needing to expose private
> perf core functions and triple check they are not being called in a
> way that violates existing assumptions.
> 
> Because this introduces a possibility of perf reschedule during vCPU
> load, I've optimized to only do that operation if there are host
> events occupying the intended guest counters at the time of the load.
> 
> The kernel command line parameter for the driver still exists, but now
> only defines an upper limit of counters the guest might use rather
> than taking those counters from the host permanently.
> 
> v7:
> 
> * Implement dynamic counter reservation as described above. One side
>    effect is the PMUv3 driver now needs much fewer changes to enforce
>    the boundary.
> 
> * Move register accesses out of fast path for non-FGT hardware. The
>    performance impact was negligible and this moves bloat out of the
>    fast path and allows a more reliable design with more code sharing.
> 
> * Make PMCCNTR a special case in the context swap again because trying
>    to access it with PMXEVCNTR is undefined.
> 
> * Fix a bug where kvm_pmu_guest_counter_mask was using & instead of |.
> 
> * Re-expose the dedicated instruction counter to the host since it was
>    decided the guest will not own it.
> 
> * Change the global armv8pmu_reserved_host_counters to
>    armv8pmu_is_partitoned because it was only used in boolean checks.
> 
> * Fix typo in vcpu attribute commit so the spelling of the flag in the
>    commit message matches the code.
> 
> * Rebase to v7.0-rc7
> 
> v6:
> https://lore.kernel.org/kvmarm/20260209221414.2169465-1-coltonlewis@google.com/
> 
> v5:
> https://lore.kernel.org/kvmarm/20251209205121.1871534-1-coltonlewis@google.com/
> 
> v4:
> https://lore.kernel.org/kvmarm/20250714225917.1396543-1-coltonlewis@google.com/
> 
> v3:
> https://lore.kernel.org/kvm/20250626200459.1153955-1-coltonlewis@google.com/
> 
> v2:
> https://lore.kernel.org/kvm/20250620221326.1261128-1-coltonlewis@google.com/
> 
> v1:
> https://lore.kernel.org/kvm/20250602192702.2125115-1-coltonlewis@google.com/
> 
> [1] https://gitlab.com/qemu-project/kvm-forum/-/raw/main/_attachments/2025/Optimizing__itvHkhc.pdf
> [2] https://www.youtube.com/watch?v=YRzZ8jMIA6M&list=PLW3ep1uCIRfxwmllXTOA2txfDWN6vUOHp&index=9
> 
> Colton Lewis (19):
>    arm64: cpufeature: Add cpucap for HPMN0
>    KVM: arm64: Reorganize PMU functions
>    perf: arm_pmuv3: Generalize counter bitmasks
>    perf: arm_pmuv3: Check cntr_mask before using pmccntr
>    perf: arm_pmuv3: Add method to partition the PMU
>    KVM: arm64: Set up FGT for Partitioned PMU
>    KVM: arm64: Add Partitioned PMU register trap handlers
>    KVM: arm64: Set up MDCR_EL2 to handle a Partitioned PMU
>    KVM: arm64: Context swap Partitioned PMU guest registers
>    KVM: arm64: Enforce PMU event filter at vcpu_load()
>    perf: Add perf_pmu_resched_update()
>    KVM: arm64: Apply dynamic guest counter reservations
>    KVM: arm64: Implement lazy PMU context swaps
>    perf: arm_pmuv3: Handle IRQs for Partitioned PMU guest counters
>    KVM: arm64: Detect overflows for the Partitioned PMU
>    KVM: arm64: Add vCPU device attr to partition the PMU
>    KVM: selftests: Add find_bit to KVM library
>    KVM: arm64: selftests: Add test case for Partitioned PMU
>    KVM: arm64: selftests: Relax testing for exceptions when partitioned
> 
> Marc Zyngier (1):
>    KVM: arm64: Reorganize PMU includes
> 
>   arch/arm/include/asm/arm_pmuv3.h              |  18 +
>   arch/arm64/include/asm/arm_pmuv3.h            |  12 +-
>   arch/arm64/include/asm/kvm_host.h             |  17 +-
>   arch/arm64/include/asm/kvm_types.h            |   6 +-
>   arch/arm64/include/uapi/asm/kvm.h             |   2 +
>   arch/arm64/kernel/cpufeature.c                |   8 +
>   arch/arm64/kvm/Makefile                       |   2 +-
>   arch/arm64/kvm/arm.c                          |   2 +
>   arch/arm64/kvm/config.c                       |  41 +-
>   arch/arm64/kvm/debug.c                        |  31 +-
>   arch/arm64/kvm/pmu-direct.c                   | 494 ++++++++++++
>   arch/arm64/kvm/pmu-emul.c                     | 674 +----------------
>   arch/arm64/kvm/pmu.c                          | 701 ++++++++++++++++++
>   arch/arm64/kvm/sys_regs.c                     | 250 ++++++-
>   arch/arm64/tools/cpucaps                      |   1 +
>   arch/arm64/tools/sysreg                       |   6 +-
>   drivers/perf/arm_pmuv3.c                      | 111 ++-
>   include/kvm/arm_pmu.h                         | 110 +++
>   include/linux/perf/arm_pmu.h                  |   3 +
>   include/linux/perf/arm_pmuv3.h                |  14 +-
>   include/linux/perf_event.h                    |   3 +
>   kernel/events/core.c                          |  28 +-
>   tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>   .../selftests/kvm/arm64/vpmu_counter_access.c | 112 ++-
>   tools/testing/selftests/kvm/lib/find_bit.c    |   1 +
>   25 files changed, 1861 insertions(+), 787 deletions(-)
>   create mode 100644 arch/arm64/kvm/pmu-direct.c
>   create mode 100644 tools/testing/selftests/kvm/lib/find_bit.c
> 
> 
> base-commit: 591cd656a1bf5ea94a222af5ef2ee76df029c1d2
> --
> 2.54.0.545.g6539524ca2-goog

I tested it a bit and ran the kselftests and it all seems to be working 
ok. Some of the critical sashiko comments look like they are worth 
looking into though: 
https://sashiko.dev/#/patchset/20260504211813.1804997-1-coltonlewis%40google.com

For example writing to PMCR_EL0.P from EL2 resets the host's counters, 
even if it's KVM doing it after trapping a write from the guest.

