From: Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v1 0/5] perf kvm: Add stat support on arm64
Date: Wed, 12 Jun 2019 09:08:41 +0000
Message-ID: <1560330526-15468-1-git-send-email-yuzenghui@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: christoffer.dall@arm.com, marc.zyngier@arm.com, acme@redhat.com, peterz@infradead.org, mingo@redhat.com, ganapatrao.kulkarni@cavium.com, catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, wanghaibin.wang@huawei.com, xiexiangyou@huawei.com, linuxarm@huawei.com, Zenghui Yu <yuzenghui@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

'perf kvm stat report/record' generates a statistical analysis of KVM
events and can be used to analyze guest exit reasons. This series tries
to add stat support on arm64 (Port perf-kvm-stat to arm64 - this is
already supported on x86).

"record" enables recording of two pair of tracepoints:
 - "kvm:kvm_entry" and "kvm:kvm_exit"
 - "kvm:kvm_trap_enter" and "kvm:kvm_trap_exit"
"report" reports statistical analysis of guest exit&trap events.

To record kvm events on the host:
 # perf kvm stat record -a

To report kvm VM EXIT events:
 # perf kvm stat report --event=vmexit

To report kvm VM TRAP (synchronous exceptions) events:
 # perf kvm stat report --event=trap

More information can be found at tools/perf/Documentation/perf-kvm.txt.

* Patch 1-2 touch KVM/ARM side, with #1 is cleanup and #2 is preparation
  for perf-kvm-stat support.
* Patch 3-5 touch perf side.
* Patch 3 adds support for get_cpuid() function on arm64. *RFC!*
* Patch 4 adds support for perf-kvm-stat on arm64, with VM-EXIT events.
* Patch 5 adds support to report TRAP-EVENT events.

Any suggestions, comments and test results will be appreciated.

Thanks,
zenghui

---

Zenghui Yu (5):
  KVM: arm/arm64: Remove kvm_mmio_emulate tracepoint
  KVM: arm/arm64: Adjust entry/exit and trap related tracepoints
  perf tools arm64: Add support for get_cpuid() function
  perf,kvm/arm64: Add stat support on arm64
  perf,kvm/arm64: perf-kvm-stat to report VM TRAP

 arch/arm64/kvm/handle_exit.c                     |   3 +
 arch/arm64/kvm/trace.h                           |  35 +++++++
 tools/perf/arch/arm64/Makefile                   |   2 +
 tools/perf/arch/arm64/util/Build                 |   1 +
 tools/perf/arch/arm64/util/aarch64_guest_exits.h |  91 +++++++++++++++++
 tools/perf/arch/arm64/util/header.c              |  74 +++++++++-----
 tools/perf/arch/arm64/util/kvm-stat.c            | 125 +++++++++++++++++++++++
 virt/kvm/arm/arm.c                               |   4 +-
 virt/kvm/arm/trace.h                             |  42 ++------
 9 files changed, 317 insertions(+), 60 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/aarch64_guest_exits.h
 create mode 100644 tools/perf/arch/arm64/util/kvm-stat.c

-- 
1.8.3.1
