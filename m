Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795479790;
	b=bM7FbW5JencZ/0BpPyMu4lCscXAppExIq1fQFKByNbV2iqJHYd7ffqwACmQSwUG5GSjb
	 HtTSGQ/FgcJjCBQcxLDeGQwCup2LasCq3bGQ6wO4rtjCzFIGebxZbJn0S0/sgfUA4tNuu
	 SPbRaOTg5qQMOt/KnRDBvo1V0Bf7EVt6T/snWYuyeaMlx/L58bKZ+uLTaIfbgf22xCZJT
	 RLcZF4O+/D7cTRRqNpZuZ9EdNI03n5rCn3Nn+dBF47A2WhlDEnbH0IMm1I5aI3BogpZyW
	 1Z5SxpgTk9jvDDHSUgEuu3/uBy2fL34fpLICO+GnXhp2vJfx1Azy7Cjx40K06vqCPQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795479790;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kbmkzmWDCU5SUQXyQI5NqKhx27N0STwtCeoqyUH/E0k=;
	b=rbhbcd3hp/5D4lGzcxETfq1oAEqEDzl+GAgbVgkuhGdGdYKPKqs0YGOZxkPZHfYb68xR
	 eq4nqJPMVIskHHhNT0rWwrgFP59VGYtSSY4ykWrE9qOOzPPkh8hEv4G6WyMiKhPoxLCKG
	 9WFKzKLQIpID23XAftt60U/67FguJDgABFdxsbwTlKi1ItzdwgRU15sL/2gh/it9nZk5B
	 COqwwXpRV5U/OQ0lK0CckMRj0xZ9DDgQD2kW7DEyZ5QktGql+NAqcHdWsoZw8GCnmRNK1
	 DiC0/zEQeanccA0lpwWOKdOhMnI9m9/pF/J8MIJfx4uVkin9mIfowHYXmevnaPuTCYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ipgs6Nyg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ECA606A31E;
	Tue, 24 Nov 2026 00:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ipgs6Nyg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FA61F000CA;
	Tue, 24 Nov 2026 00:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795479790;
	bh=kbmkzmWDCU5SUQXyQI5NqKhx27N0STwtCeoqyUH/E0k=;
	h=From:To:Cc:Subject:Date;
	b=Ipgs6NyguWEdAXgnx4sDcc/C+k+AD9R27G6JWb5kMoT+mU4zPaF1FN7+hg1+R1sex
	 OdBNZdYGjuiRKP3/CdPTTwd0w16bHC3Kf7u3GMKL0Inv9zTUtz+uyNWvepc4lMoyzz
	 AOAIYBddX9Rqgo6Vk6fLr/Ztz6eW/61nfYdLfWLXqE7EArjfLBsFDNWUgzfc0/xfeB
	 Ay9tHvqPIdwV4LyuYcZOJkjRz6KYDF2oQPWoF+0FKWad/LnCmQwllyTSghysFFEi50
	 oWPNDbvYaMlWC7kjC7ZzoB4w6Xl0cXKlBodxXUTzPG6QcUkcVLncI5c8vAXFpPo8PM
	 2y1nCW/MFSJDg==
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mingwei Zhang <mizhang@google.com>,
	Jim Mattson <jmattson@google.com>,
	Zide Chen <zide.chen@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [RFC PATCH 00/26] KVM: x86/pmu: Dynamic mediated PMU context switching
Date: Tue, 24 Nov 2026 00:22:37 +0000
Message-ID: <20261124002303.1785363-1-yosry@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When KVM uses the mediated PMU, it loads the guest context and puts it around
the inner fastpath loop, causing an expensive switch on every slowpath VM-Exit.
On microbenchmarks like CPUID, this can result in up to 3x drop in throughput
even when the host is not using the core PMU. On more realistic benchmarks like
netperf TCP_RR, it results in up to ~15% regression (at least in some setups).

This series uses a dynamic scheme for PMU context switching instead. On
slowpath VM-Exit, KVM only puts the guest context if host perf has events
conflicting with the mediated PMU. Otherwise, the guest context remains loaded
until either the vCPU is put (e.g. on context switch or return to userspace),
or perf "reclaims" it. This recovers most/all performance (at least on CPUID
and netperf) with a mediated PMU in the absence of host events. See "KVM:
x86/pmu: Put the mediated PMU context lazily on slowpath VM-Exits" for exact
numbers.

The Perf Side
-------------

Perf reclaims the PMU before executing any remote call on a CPU if the guest
context is loaded, including installing events, enabling events, etc. This is
too conservative, as perf really only needs to reclaim the PMU before an event
is both installed and enabled, but it results in a simpler and more
future-proof implementation.

There are a couple of other hiccups that perf needs to deal with outside of
reclaiming on remote calls, namely:

1. Intel PT/BTS. These PMUs are not mediated, but they use the same PMI
delivery mechanism as the mediated core PMU (i.e. LVTPC). Since they are not
mediated, they are not scheduled out while the guest context is loaded, and
their PMIs can be delivered into the guest instead of the host. Today, BTS is
never active while the guest runs (KVM doesn't allow the guest to enable it,
and VM-Exit clears DEBUGCTL), so this is limited to short windows around
VM-Entry/VM-Exit. Intel PT (in system mode) keeps tracing while the guest runs,
so its PMIs raised while the guest is running are delivered to the guest.

Lazily putting the guest context would make this worse for both, as host code
with tracing enabled could run with the guest context loaded for much longer,
most notably for BTS, which would go from short windows around VM-Entry/VM-Exit
to all of slowpath VM-Exit handling. To avoid that, this series tracks PMUs
that share the same PMI mechanism, and having events on any of them prompts KVM
to give up the PMU on slowpath VM-Exits, keeping the status quo.

Long-term, perhaps it would be better to schedule out Intel PT events while
the guest context is loaded, or somehow demux the PMIs?

2. Handling bpf_get_branch_snapshot() while the guest context is loaded (a
pre-existing bug that is more exposed by this series).

3. Clearing dirty counters when events are mmap()'d or the rdpmc attribute is
updated, which needs to reclaim the PMU first if the guest context is loaded.

NOTE: The first 5 patches fix pre-existing problems (or prepare for those
fixes) that are relevant to the series (or the dynamic switch makes them worse),
but they can be merged independently.

The KVM Side
------------

The main change is needing to access guest PMU registers in hardware while the
guest context is loaded. More specifically, the currently virtualized registers
fall into one of two categories:

1. Registers that can be read from software but must be written to hardware
(i.e. are always up-to-date in software). This includes registers that are
always intercepted or sync'd on every VM-exit, namely control registers:
eventsel, fixed_ctr_ctrl, and GLOBAL_CTRL.

2. Registers that must be read and written from hardware (i.e. software can
always be stale). This includes registers that can be updated by the guest or
hardware while the guest runs, namely counters and GLOBAL_STATUS.

Additionally, KVM needs to keep the physical and virtual LVTPC in sync while
the guest context is loaded.

KVM accessing registers in hardware as needed allows it to handle fastpath
instruction emulation with a mediated PMU, so this restriction is dropped.

Testing
-------

This was tested by new (AI-generated) extensions to PMU selftests that mostly
act as regression tests for the existing PMU, a selftest-style stress test, and
stressing perf with a real Linux VM. The selftests will be cleaned up and sent
out separately.

The full KVM x86 selftests and kvm-unit-tests were also run on Intel and AMD,
with no new failures compared to the base kernel.

Testing was done with Zide's "KVM: SVM: Drop counter MSR checks in
amd_is_valid_msr()" [1] applied, as without it saving vCPU state on AMD fails
when the guest has fewer counters than the host (KVM_GET_MSRS fails on the
unexposed counter MSRs).

[1] https://lore.kernel.org/r/20261112203227.289379-2-zide.chen@intel.com

Yosry Ahmed (26):
  perf/core: Fix lockless time read for exclude_guest events
  perf/core: Don't subtract guest time for events that keep counting
  perf/core: Move is_guest_mediated_pmu_loaded() to the header
  perf/x86: Use irqsave guard in branch stack snapshotting callbacks
  perf/x86: Don't snapshot the branch stack while a guest PMU is loaded
  perf/core: Guard against accessing guest mediated vPMU state
  perf: Add a guest callback to reclaim the mediated PMU
  perf/core: Reclaim the mediated PMU before executing remote calls
  perf/x86: Reclaim the mediated PMU before clearing dirty counters
  perf: Track mediated PMU conflicts
  KVM: x86/pmu: Move PMC MSR and type helpers earlier
  KVM: x86/pmu: Access PMCs in hardware if the mediated PMU context is
    loaded
  KVM: x86/pmu: Compute eventsel_hw from eventsel when reprogramming
  KVM: x86/pmu: Zero eventsel_hw for counters that can't count
  KVM: x86/pmu: Write PMU controls to hardware on reprogram if loaded
  KVM: x86/pmu: Write GLOBAL_CTRL to hardware if the guest context is
    loaded
  KVM: x86/pmu: Ignore reserved bits on writes to GLOBAL_STATUS_CLR
  KVM: x86/pmu: Access GLOBAL_STATUS in hardware if the guest context is
    loaded
  KVM: x86/pmu: Sync the guest's LVTPC to hardware if the guest context
    is loaded
  KVM: x86/pmu: Check for a mediated PMU before loading/putting its
    context
  KVM: x86/pmu: Make loading/putting the mediated PMU context idempotent
  KVM: x86/pmu: Put the mediated PMU context lazily on slowpath VM-Exits
  KVM: x86/pmu: Add stats for mediated PMU context switches
  KVM: VMX: WARN if the Intel PT PMI handler runs for a mediated PMU
  KVM: x86/pmu: WARN if a mediated PMI arrives outside of guest IRQ
    handling
  KVM: x86/pmu: Allow emulation in the fastpath with a mediated PMU

 arch/x86/events/amd/core.c      |  12 ++-
 arch/x86/events/core.c          |   8 ++
 arch/x86/events/intel/bts.c     |   3 +-
 arch/x86/events/intel/core.c    |  31 ++++--
 arch/x86/events/intel/pt.c      |   3 +-
 arch/x86/include/asm/kvm_host.h |   3 +
 arch/x86/kvm/lapic.c            |   4 +
 arch/x86/kvm/msrs.c             |   3 -
 arch/x86/kvm/pmu.c              | 180 ++++++++++++++++++++++++--------
 arch/x86/kvm/pmu.h              |  78 ++++++++++----
 arch/x86/kvm/svm/pmu.c          |  13 ++-
 arch/x86/kvm/vmx/pmu_intel.c    |  15 +--
 arch/x86/kvm/vmx/vmx.c          |  10 ++
 arch/x86/kvm/x86.c              |  25 +++--
 include/linux/kvm_host.h        |   5 +-
 include/linux/perf_event.h      |  34 ++++++
 kernel/events/core.c            | 168 +++++++++++++++++++++++------
 virt/kvm/kvm_main.c             |   5 +-
 18 files changed, 464 insertions(+), 136 deletions(-)


base-commit: cbe54fc3462b3949ab27b9ae81fb9ddb509040c7
-- 
2.56.1.809.ga0b61035b5-goog

