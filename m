From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL] perf tooling fixes for v5.8
Date: Thu, 18 Jun 2020 16:28:40 -0300
Message-ID: <20200618192840.4519-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Gaurav Singh <gaurav1086@gmail.com>, Hongbo Yao <yaohongbo@huawei.com>, Ian Rogers <irogers@google.com>, Milian Wolff <milian.wolff@kdab.com>, Steven Rostedt <rostedt@goodmis.org>, Sumanth Korikkar <sumanthk@linux.ibm.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Linus

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit 69119673bd50b176ded34032fadd41530fb5af21:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2020-06-16 17:44:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-2020-06-02

for you to fetch changes up to 6a1515c962b17e2596ae7b9f074fc5685d6b435b:

  perf build: Fix error message when asking for -fsanitize=address without required libraries (2020-06-18 10:34:31 -0300)

----------------------------------------------------------------
perf tooling fixes for v5.8:

- Update various UAPI headers, some automatically adding support for
  a new MSR and the faccess2 syscall.

- Fix corner case NULL deref in the histograms code.

- Fix corner case NULL deref in 'perf stat' aggregation code.

- Fix array pointer deref and old style declaration in the parsing of events.

- Fix segfault when processing ZSTD compressed perf.data files in 'perf script'
  due to lack of initialization of the ZSTD library.

- Handle __attribute__((user)) in libtraceevent fixing the parsing of syscall
  tracepoints with user buffers.

- Make libtraevent aware of __builtin_expect() appearing in tracepoint fields.

- Make the BPF prologue generation use bpf_probe_read_{user,kernel}().

- Fix the '@user' attribute parsing in kprobes variables in 'perf probe'.

- Fix error message when asking for -fsanitize=address without required libraries.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------

Arnaldo Carvalho de Melo (11):
      tools headers API: Update faccessat2 affected files
      tools arch x86 uapi: Synch asm/unistd.h with the kernel sources
      tools headers uapi: Sync linux/stat.h with the kernel sources
      perf beauty: Add support to STATX_MNT_ID in the 'statx' syscall 'mask' argument
      tools headers UAPI: Sync linux/fscrypt.h with the kernel sources
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
      tools headers UAPI: Sync kvm.h headers with the kernel sources
      Merge remote-tracking branch 'torvalds/master' into perf/urgent
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools include UAPI: Sync linux/vhost.h with the kernel sources
      tools headers UAPI: Sync linux/fs.h with the kernel sources

Gaurav Singh (1):
      perf report: Fix NULL pointer dereference in hists__fprintf_nr_sample_events()

Hongbo Yao (1):
      perf stat: Fix NULL pointer dereference

Ian Rogers (3):
      perf parse-events: Fix an incompatible pointer
      perf parse-events: Fix an old style declaration
      perf pmu: Remove unused declaration

Milian Wolff (1):
      perf script: Initialize zstd_data

Steven Rostedt (VMware) (3):
      tools lib traceevent: Add append() function helper for appending strings
      tools lib traceevent: Handle __attribute__((user)) in field names
      tools lib traceevent: Add handler for __builtin_expect()

Sumanth Korikkar (2):
      perf probe: Fix user attribute access in kprobes
      perf bpf: Fix bpf prologue generation

Tiezhu Yang (1):
      perf build: Fix error message when asking for -fsanitize=address without required libraries

 tools/arch/x86/include/asm/cpufeatures.h          |   2 +
 tools/arch/x86/include/asm/msr-index.h            |   4 +
 tools/arch/x86/include/uapi/asm/kvm.h             |  21 ++-
 tools/arch/x86/include/uapi/asm/unistd.h          |   9 +-
 tools/arch/x86/include/uapi/asm/vmx.h             |   3 +
 tools/include/uapi/asm-generic/unistd.h           |   4 +-
 tools/include/uapi/drm/i915_drm.h                 |  24 ++++
 tools/include/uapi/linux/fcntl.h                  |  10 ++
 tools/include/uapi/linux/fs.h                     |   1 +
 tools/include/uapi/linux/fscrypt.h                |   3 +-
 tools/include/uapi/linux/kvm.h                    |  14 ++
 tools/include/uapi/linux/stat.h                   |   8 +-
 tools/include/uapi/linux/vhost.h                  |   4 +
 tools/lib/traceevent/event-parse.c                | 168 ++++++++++++++--------
 tools/perf/Makefile.config                        |  12 ++
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 tools/perf/builtin-report.c                       |   3 +-
 tools/perf/builtin-script.c                       |   3 +
 tools/perf/trace/beauty/statx.c                   |   1 +
 tools/perf/util/bpf-prologue.c                    |  14 +-
 tools/perf/util/parse-events.y                    |   4 +-
 tools/perf/util/pmu.h                             |   1 -
 tools/perf/util/probe-event.c                     |   7 +-
 tools/perf/util/probe-file.c                      |   2 +-
 tools/perf/util/stat-display.c                    |   4 +-
 25 files changed, 250 insertions(+), 77 deletions(-)
