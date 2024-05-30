Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16BB14388A
	for <linux-perf-users@vger.kernel.org>; Thu, 30 May 2024 04:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717043312; cv=none; b=P3yikF5a68454wjYLPEAFFLbkgWOB8TD1gozRBIV7h1/Wx/9H6ucUx/DrHx6IYS9VOmljnPMFeBNAET8cengh3U5qYlvquKY+ZCpqLvL2gf4YlICV0fwpRLh/W/qD/omJVtgGwt5AK6S6Ju5GqmJ3lIv+KZhsys83EDAvS3CaDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717043312; c=relaxed/simple;
	bh=BHLHJaqbbt4ke7IER+yzv55fyfrG/4/E7NBcbfL6gWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAZyfB1yjK07ZK132uNaBmL+6ezUw5MGmEOa8kyuGyOY2dlEtfJLTkqvzW7MPHXHJIZKclUZFxVRr42fLCHLjbC6kqyvQzzOWuzMgWX45KTaWR3KkF1SXY6/W3m3h7CUCaQkIE4CeSnO4yQOQE1D6dR7tyNn6+oMYQ1NLULlwwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2fd2niU2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2fd2niU2"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f47f07acd3so4361345ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 May 2024 21:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717043309; x=1717648109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jwi6ZQ7mtIYeDEXm9k34lGUda1tlEQnKHG/NuMJtSY8=;
        b=2fd2niU2JEObSjAEYWZY8OS+O6aZ0wa6q3bWvMKr8oQTqpNX7ZtzdN/SeslfAnnaHP
         GN7cDzBjclXal1KVa/4ObbMIRWQlCzRSaGka51aYT9G1+ummgQt8iU6spoKKL1/OZ+YH
         VvtcS19N2D2PwIkBhyqPyKGx29AP739FgXRx7WaXnSxPPfyO8HX6YhzoP867uLz9BpER
         NaoH/k3WO+il/4BxH29q3tOOxfe6Wl5jM++JackqhNZs/t2JpmvaqQM6ZXX9YvKxFGXG
         Pg3oxU/YzVAz5imWu9l2PS/o9M5Wlf8rfz+HWlrUBed5CyFy70vN89XNIyY7uqDCxJFO
         W/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717043309; x=1717648109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwi6ZQ7mtIYeDEXm9k34lGUda1tlEQnKHG/NuMJtSY8=;
        b=dJ1BjJlzXDR3nc6eN6EEoWrEYkvdCLkOW6x9mZLdEJ9nHd/B5NPGkP7AQF0cQ2cwhJ
         3tj7kl5o6u4GEEna52CDprZ2iUiTlTFnQiCOFl+tCG43ve/OI3tQpluCBh0QYE5JgE/6
         W4T1/pkf78lBXv/xtuWDQlEBNePhz6hdFDIsgsPV9vwR+tSLglR32xoL4Rv3kUG+FxSL
         yfmkFE5V8MsY4cxRCxH3U5ONqYFFLqf47nlUMK9CVAtMu3798qWbJf2sJOAPyio7ETVg
         WQfJpFxrzK5vAjQTCJBWvZ/nKudUpmLc6ULKPsjrTOBaIo2dfNC+0fAgrqJYvMaH0w2u
         41JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDtCaGjKQfDp3Mbm8hZyObAdqN7r6JcRXfZrvBAW9RhRDE3muJrjGv5d0FDG+Om3+JOWKoPUrSsGypH7G+AgIHGiWxUa5ulSqtQtRSOC0oxA==
X-Gm-Message-State: AOJu0YxZs2LL0cewJTtBmqsBieVQUQsKV83esdAN9V8UUuC1JjEubbAD
	c5/sEguhpjmh8G2kT1FiGGYtE9lfCfWBt4MTzSkLO6vJgg9KpVYbEeD1toWo3Q==
X-Google-Smtp-Source: AGHT+IETdd05jc/bfH0wK84I6K22q7Ags9KDneuFIGMnyeMIbGfg9dscsm67W1fDpDJwK7IRW3jkkA==
X-Received: by 2002:a17:902:daca:b0:1f4:8ad1:369c with SMTP id d9443c01a7336-1f6195f90e6mr12152085ad.28.1717043308904;
        Wed, 29 May 2024 21:28:28 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f4720a26bdsm86765245ad.218.2024.05.29.21.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 21:28:28 -0700 (PDT)
Date: Thu, 30 May 2024 04:28:24 +0000
From: Mingwei Zhang <mizhang@google.com>
To: "Ma, Yongwei" <yongwei.ma@intel.com>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Zhang, Xiong Y" <xiong.y.zhang@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Liang, Kan" <kan.liang@intel.com>,
	Zhenyu Wang <zhenyuw@linux.intel.com>,
	Manali Shukla <manali.shukla@amd.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Jim Mattson <jmattson@google.com>,
	"Eranian, Stephane" <eranian@google.com>,
	Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	"gce-passthrou-pmu-dev@google.com" <gce-passthrou-pmu-dev@google.com>,
	"Alt, Samantha" <samantha.alt@intel.com>,
	"Lv, Zhiyuan" <zhiyuan.lv@intel.com>,
	"Xu, Yanfei" <yanfei.xu@intel.com>, maobibo <maobibo@loongson.cn>,
	Like Xu <like.xu.linux@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v2 00/54] Mediated Passthrough vPMU 2.0 for x86
Message-ID: <ZlgAaCPQvVcV-9SG@google.com>
References: <20240506053020.3911940-1-mizhang@google.com>
 <BL1PR11MB53685328CBAA3E444370D7AC89F12@BL1PR11MB5368.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB53685328CBAA3E444370D7AC89F12@BL1PR11MB5368.namprd11.prod.outlook.com>

On Tue, May 28, 2024, Ma, Yongwei wrote:
> > In this version, we added the mediated passthrough vPMU support for AMD.
> > This is 1st version that comes up with a full x86 support on the vPMU new
> > design.
> > 
> > Major changes:
> >  - AMD support integration. Supporting guest PerfMon v1 and v2.
> >  - Ensure !exclude_guest events only exist prior to mediate passthrough
> >    vPMU loaded. [sean]
> >  - Update PMU MSR interception according to exposed counters and pmu
> >    version. [mingwei reported pmu_counters_test fails]
> >  - Enforce RDPMC interception unless all counters exposed to guest. This
> >    removes a hack in RFCv1 where we pass through RDPMC and zero
> >    unexposed counters. [jim/sean]
> >  - Combine the PMU context switch for both AMD and Intel.
> >  - Because of RDPMC interception, update PMU context switch code by
> >    removing the "zeroing out" logic when restoring the guest context.
> >    [jim/sean: intercept rdpmc]
> > 
> > Minor changes:
> >  - Flip enable_passthrough_pmu to false and change to a vendor param.
> >  - Remove "Intercept full-width GP counter MSRs by checking with perf
> >    capabilities".
> >  - Remove the write to pmc patch.
> >  - Move host_perf_cap as an independent variable, will update after
> >    https://lore.kernel.org/all/20240423221521.2923759-1-
> > seanjc@google.com/
> > 
> > TODOs:
> >  - Simplify enabling code for mediated passthrough vPMU.
> >  - Further optimization on PMU context switch.
> > 
> > On-going discussions:
> >  - Final name of mediated passthrough vPMU.
> >  - PMU context switch optimizations.
> > 
> > Testing:
> >  - Testcases:
> >    - selftest: pmu_counters_test
> >    - selftest: pmu_event_filter_test
> >    - kvm-unit-tests: pmu
> >    - qemu based ubuntu 20.04 (guest kernel: 5.10 and 6.7.9)
> >  - Platforms:
> >    - genoa
> >    - skylake
> >    - icelake
> >    - sapphirerapids
> >    - emeraldrapids
> > 
> > Ongoing Issues:
> >  - AMD platform [milan]:
> >   - ./pmu_event_filter_test error:
> >     - test_amd_deny_list: Branch instructions retired = 44 (expected 42)
> >     - test_without_filter: Branch instructions retired = 44 (expected 42)
> >     - test_member_allow_list: Branch instructions retired = 44 (expected 42)
> >     - test_not_member_deny_list: Branch instructions retired = 44 (expected
> > 42)
> >  - Intel platform [skylake]:
> >   - kvm-unit-tests/pmu fails with two errors:
> >     - FAIL: Intel: TSX cycles: gp cntr-3 with a value of 0
> >     - FAIL: Intel: full-width writes: TSX cycles: gp cntr-3 with a value of 0
> > 
> > Installation guidance:
> >  - echo 0 > /proc/sys/kernel/nmi_watchdog
> >  - modprobe kvm_{amd,intel} enable_passthrough_pmu=Y 2>/dev/null
> > 
> > v1: https://lore.kernel.org/all/20240126085444.324918-1-
> > xiong.y.zhang@linux.intel.com/
> > 
> > 
> > Dapeng Mi (3):
> >   x86/msr: Introduce MSR_CORE_PERF_GLOBAL_STATUS_SET
> >   KVM: x86/pmu: Introduce macro PMU_CAP_PERF_METRICS
> >   KVM: x86/pmu: Add intel_passthrough_pmu_msrs() to pass-through PMU
> >     MSRs
> > 
> > Kan Liang (3):
> >   perf: Support get/put passthrough PMU interfaces
> >   perf: Add generic exclude_guest support
> >   perf/x86/intel: Support PERF_PMU_CAP_PASSTHROUGH_VPMU
> > 
> > Manali Shukla (1):
> >   KVM: x86/pmu/svm: Wire up PMU filtering functionality for passthrough
> >     PMU
> > 
> > Mingwei Zhang (24):
> >   perf: core/x86: Forbid PMI handler when guest own PMU
> >   perf: core/x86: Plumb passthrough PMU capability from x86_pmu to
> >     x86_pmu_cap
> >   KVM: x86/pmu: Introduce enable_passthrough_pmu module parameter
> >   KVM: x86/pmu: Plumb through pass-through PMU to vcpu for Intel CPUs
> >   KVM: x86/pmu: Add a helper to check if passthrough PMU is enabled
> >   KVM: x86/pmu: Add host_perf_cap and initialize it in
> >     kvm_x86_vendor_init()
> >   KVM: x86/pmu: Allow RDPMC pass through when all counters exposed to
> >     guest
> >   KVM: x86/pmu: Introduce PMU operator to check if rdpmc passthrough
> >     allowed
> >   KVM: x86/pmu: Create a function prototype to disable MSR interception
> >   KVM: x86/pmu: Avoid legacy vPMU code when accessing global_ctrl in
> >     passthrough vPMU
> >   KVM: x86/pmu: Exclude PMU MSRs in vmx_get_passthrough_msr_slot()
> >   KVM: x86/pmu: Add counter MSR and selector MSR index into struct
> >     kvm_pmc
> >   KVM: x86/pmu: Introduce PMU operation prototypes for save/restore PMU
> >     context
> >   KVM: x86/pmu: Implement the save/restore of PMU state for Intel CPU
> >   KVM: x86/pmu: Make check_pmu_event_filter() an exported function
> >   KVM: x86/pmu: Allow writing to event selector for GP counters if event
> >     is allowed
> >   KVM: x86/pmu: Allow writing to fixed counter selector if counter is
> >     exposed
> >   KVM: x86/pmu: Exclude existing vLBR logic from the passthrough PMU
> >   KVM: x86/pmu: Introduce PMU operator to increment counter
> >   KVM: x86/pmu: Introduce PMU operator for setting counter overflow
> >   KVM: x86/pmu: Implement emulated counter increment for passthrough
> > PMU
> >   KVM: x86/pmu: Update pmc_{read,write}_counter() to disconnect perf API
> >   KVM: x86/pmu: Disconnect counter reprogram logic from passthrough PMU
> >   KVM: nVMX: Add nested virtualization support for passthrough PMU
> > 
> > Sandipan Das (11):
> >   KVM: x86/pmu: Do not mask LVTPC when handling a PMI on AMD platforms
> >   x86/msr: Define PerfCntrGlobalStatusSet register
> >   KVM: x86/pmu: Always set global enable bits in passthrough mode
> >   perf/x86/amd/core: Set passthrough capability for host
> >   KVM: x86/pmu/svm: Set passthrough capability for vcpus
> >   KVM: x86/pmu/svm: Set enable_passthrough_pmu module parameter
> >   KVM: x86/pmu/svm: Allow RDPMC pass through when all counters exposed
> >     to guest
> >   KVM: x86/pmu/svm: Implement callback to disable MSR interception
> >   KVM: x86/pmu/svm: Set GuestOnly bit and clear HostOnly bit when guest
> >     write to event selectors
> >   KVM: x86/pmu/svm: Add registers to direct access list
> >   KVM: x86/pmu/svm: Implement handlers to save and restore context
> > 
> > Sean Christopherson (2):
> >   KVM: x86/pmu: Set enable bits for GP counters in PERF_GLOBAL_CTRL at
> >     "RESET"
> >   KVM: x86: Snapshot if a vCPU's vendor model is AMD vs. Intel
> >     compatible
> > 
> > Xiong Zhang (10):
> >   perf: core/x86: Register a new vector for KVM GUEST PMI
> >   KVM: x86: Extract x86_set_kvm_irq_handler() function
> >   KVM: x86/pmu: Register guest pmi handler for emulated PMU
> >   perf: x86: Add x86 function to switch PMI handler
> >   KVM: x86/pmu: Manage MSR interception for IA32_PERF_GLOBAL_CTRL
> >   KVM: x86/pmu: Switch IA32_PERF_GLOBAL_CTRL at VM boundary
> >   KVM: x86/pmu: Switch PMI handler at KVM context switch boundary
> >   KVM: x86/pmu: Grab x86 core PMU for passthrough PMU VM
> >   KVM: x86/pmu: Call perf_guest_enter() at PMU context switch
> >   KVM: x86/pmu: Add support for PMU context switch at VM-exit/enter
> > 
> >  arch/x86/events/amd/core.c               |   3 +
> >  arch/x86/events/core.c                   |  41 ++++-
> >  arch/x86/events/intel/core.c             |   6 +
> >  arch/x86/events/perf_event.h             |   1 +
> >  arch/x86/include/asm/hardirq.h           |   1 +
> >  arch/x86/include/asm/idtentry.h          |   1 +
> >  arch/x86/include/asm/irq.h               |   2 +-
> >  arch/x86/include/asm/irq_vectors.h       |   5 +-
> >  arch/x86/include/asm/kvm-x86-pmu-ops.h   |   6 +
> >  arch/x86/include/asm/kvm_host.h          |  10 ++
> >  arch/x86/include/asm/msr-index.h         |   2 +
> >  arch/x86/include/asm/perf_event.h        |   4 +
> >  arch/x86/include/asm/vmx.h               |   1 +
> >  arch/x86/kernel/idt.c                    |   1 +
> >  arch/x86/kernel/irq.c                    |  36 ++++-
> >  arch/x86/kvm/cpuid.c                     |   4 +
> >  arch/x86/kvm/cpuid.h                     |  10 ++
> >  arch/x86/kvm/lapic.c                     |   3 +-
> >  arch/x86/kvm/mmu/mmu.c                   |   2 +-
> >  arch/x86/kvm/pmu.c                       | 168 ++++++++++++++++++-
> >  arch/x86/kvm/pmu.h                       |  47 ++++++
> >  arch/x86/kvm/svm/pmu.c                   | 112 ++++++++++++-
> >  arch/x86/kvm/svm/svm.c                   |  23 +++
> >  arch/x86/kvm/svm/svm.h                   |   2 +-
> >  arch/x86/kvm/vmx/capabilities.h          |   1 +
> >  arch/x86/kvm/vmx/nested.c                |  52 ++++++
> >  arch/x86/kvm/vmx/pmu_intel.c             | 192 ++++++++++++++++++++--
> >  arch/x86/kvm/vmx/vmx.c                   | 197 +++++++++++++++++++----
> >  arch/x86/kvm/vmx/vmx.h                   |   3 +-
> >  arch/x86/kvm/x86.c                       |  47 +++++-
> >  arch/x86/kvm/x86.h                       |   1 +
> >  include/linux/perf_event.h               |  18 +++
> >  kernel/events/core.c                     | 176 ++++++++++++++++++++
> >  tools/arch/x86/include/asm/irq_vectors.h |   3 +-
> >  34 files changed, 1120 insertions(+), 61 deletions(-)
> > 
> > 
> > base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
> > --
> > 2.45.0.rc1.225.g2a3ae87e7f-goog
> > 
> Hi Mingwei,
> Regarding the ongoing issue you mentioned on Intel Skylake platform, I tried to reproduce it .However, these two cases could PASS on my Skylake machine. Could you double check it with the latest kvm-unit-tests or share me your SKL CPU model?
> 
> CPU model on my SKL :
> 	 'Intel(R) Xeon(R) Gold 6140 CPU @ 2.30GHz'.
> Passthrough PMU status:
> 	$cat /sys/module/kvm_intel/parameters/enable_passthrough_pmu
> 	$Y
> Kvm-unit-tests:
> 	https://gitlab.com/kvm-unit-tests/kvm-unit-tests.git
> Result:
> 	PASS: Intel: TSX cycles: gp cntr-3 with a value of 37
> 	PASS: Intel: full-width writes: TSX cycles: gp cntr-3 with a value of 36
> 
That is good to see. We (me and my colleague) can reproduce the issue
from my side. This might be related with the host setup instead of our
code. Will figure it out.

Thanks.
-Mingwei


> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> 
> Thanks and Best Regards,
> Yongwei Ma
