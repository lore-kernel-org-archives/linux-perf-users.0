From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL] perf tools changes for v5.11
Date: Tue,  3 Nov 2020 16:44:41 -0300
Message-ID: <20201103194441.197821-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Jin Yao <yao.jin@linux.intel.com>, "Justin M . Forbes" <jforbes@fedoraproject.org>, Peter Zijlstra <peterz@infradead.org>, Song Liu <songliubraving@fb.com>, Stanislav Ivanichkin <sivanichkin@yandex-team.ru>, Tommi Rantala <tommi.t.rantala@nokia.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Linus,

	Please consider pulling, only fixes and a sync of the headers so
that the perf build is silent, please let me know if I made any other
mistake,

Best regards,

- Arnaldo

The following changes since commit b7cbaf59f62f8ab8f157698f9e31642bff525bd0:

  Merge branch 'akpm' (patches from Andrew) (2020-11-02 14:47:37 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.10-2020-11-03

for you to fetch changes up to 5d020cbd86204e51da05628623a6f9729d4b04c8:

  tools feature: Fixup fast path feature detection (2020-11-03 09:24:20 -0300)

----------------------------------------------------------------
perf tools updates for v5.10: 2nd batch.

- Fix visibility attribute in python module init code with newer gcc.

- Fix DRAM_BW_Use 0 issue for CLX/SKX in intel JSON vendor event files.

- Fix the build on new fedora by removing LTO compiler options when
  building perl support.

- Remove broken __no_tail_call attribute.

- Fix segfault when trying to trace events by cgroup.

- Fix crash with non-jited BPF progs.

- Increase buffer size in TUI browser, fixing format truncation.

- Fix printing of build-id for objects lacking one.

- Fix byte swapping for ino_generation field in MMAP2 perf.data records.

- Fix byte swapping for CGROUP perf.data records, for cross arch
  analysis of perf.data files.

- Fix the fast path of feature detection.

- Update kernel header copies.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Test results in the signed tag at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tag/?h=perf-tools-for-v5.10-2020-11-03

----------------------------------------------------------------
Arnaldo Carvalho de Melo (14):
      perf tools: Update copy of libbpf's hashmap.c
      tools headers UAPI: Update process_madvise affected files
      perf scripting python: Avoid declaring function pointers with a visibility attribute
      tools headers UAPI: Sync prctl.h with the kernel sources
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
      tools headers UAPI: Update fscrypt.h copy
      tools x86 headers: Update cpufeatures.h headers copies
      tools x86 headers: Update required-features.h header from the kernel
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools UAPI: Update copy of linux/mman.h from the kernel sources
      tools kvm headers: Update KVM headers from the kernel sources
      tools headers UAPI: Update tools's copy of linux/perf_event.h
      tools include UAPI: Update linux/mount.h copy
      tools feature: Fixup fast path feature detection

Jin Yao (1):
      perf vendor events: Fix DRAM_BW_Use 0 issue for CLX/SKX

Jiri Olsa (2):
      perf tools: Initialize output buffer in build_id__sprintf
      perf tools: Add missing swap for ino_generation

Justin M. Forbes (1):
      perf tools: Remove LTO compiler options when building perl support

Namhyung Kim (1):
      perf tools: Add missing swap for cgroup events

Peter Zijlstra (1):
      perf tools: Remove broken __no_tail_call attribute

Song Liu (1):
      perf hists browser: Increase size of 'buf' in perf_evsel__hists_browse()

Stanislav Ivanichkin (1):
      perf trace: Fix segfault when trying to trace events by cgroup

Tommi Rantala (1):
      perf tools: Fix crash with non-jited bpf progs

 tools/arch/arm64/include/uapi/asm/kvm.h            | 25 +++++++++
 tools/arch/s390/include/uapi/asm/sie.h             |  2 +-
 tools/arch/x86/include/asm/cpufeatures.h           |  6 ++-
 tools/arch/x86/include/asm/disabled-features.h     |  9 +++-
 tools/arch/x86/include/asm/msr-index.h             | 10 ++++
 tools/arch/x86/include/asm/required-features.h     |  2 +-
 tools/arch/x86/include/uapi/asm/kvm.h              | 20 ++++++++
 tools/arch/x86/include/uapi/asm/svm.h              | 13 +++++
 tools/build/feature/test-all.c                     |  1 -
 tools/include/linux/compiler-gcc.h                 | 12 -----
 tools/include/linux/compiler.h                     |  3 --
 tools/include/uapi/asm-generic/unistd.h            |  4 +-
 tools/include/uapi/drm/i915_drm.h                  | 59 ++++++++++++++++++++--
 tools/include/uapi/linux/fscrypt.h                 |  6 +--
 tools/include/uapi/linux/kvm.h                     | 19 +++++++
 tools/include/uapi/linux/mman.h                    |  1 +
 tools/include/uapi/linux/mount.h                   |  1 +
 tools/include/uapi/linux/perf_event.h              |  2 +-
 tools/include/uapi/linux/prctl.h                   |  9 ++++
 tools/include/uapi/linux/vhost.h                   |  4 ++
 tools/perf/Makefile.config                         |  1 +
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  | 11 ++--
 tools/perf/builtin-trace.c                         | 15 +++---
 .../arch/x86/cascadelakex/clx-metrics.json         |  2 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |  2 +-
 tools/perf/tests/dwarf-unwind.c                    | 10 ++--
 tools/perf/ui/browsers/hists.c                     |  2 +-
 tools/perf/util/build-id.c                         |  2 +
 tools/perf/util/hashmap.c                          |  3 ++
 tools/perf/util/hashmap.h                          | 12 +++++
 tools/perf/util/machine.c                          | 11 +++-
 .../util/scripting-engines/trace-event-python.c    |  7 +--
 tools/perf/util/session.c                          | 14 +++++
 tools/perf/util/symbol.c                           |  7 +++
 tools/perf/util/symbol.h                           |  2 +
 35 files changed, 257 insertions(+), 52 deletions(-)
