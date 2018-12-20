From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/63] perf/core improvements and fixes
Date: Thu, 20 Dec 2018 18:53:16 +0100
Message-ID: <20181220175316.GA128618@gmail.com>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Michael Petlan <mpetlan@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit ca46afdb2754dbb4a5d5772332fa16957d9bc618:
> 
>   Merge tag 'perf-core-for-mingo-4.21-20181217' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2018-12-18 14:39:00 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.21-20181218
> 
> for you to fetch changes up to 89a0948984896352cac1ebe079cb3d64d6c3adc6:
> 
>   tools uapi asm: Update asm-generic/unistd.h copy (2018-12-18 16:17:41 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Implement BPF based syscall filtering in 'perf trace', using BPF maps and
>   the augmented_raw_syscalls.c BPF proggie (Arnaldo Carvalho de Melo)
> 
> - Allow specifying in .perfconfig a set of events use in 'perf trace' in
>   addition to any other specified from the command line. This initially
>   will be used to always use the augmented_raw_syscalls.o precompiled
>   BPF program for getting pointer contents. (Arnaldo Carvalho de Melo)
> 
> - Allow fine grained control about how the syscall output should be
>   formatted. This will be used to allow producing the same output produced
>   by the 'strace' tool, to then use in regression tests comparing the
>   output of 'perf trace' with the one produced from 'strace' (Arnaldo Carvalho de Melo)
> 
> - Beautify the renameat2 olddirfd, newdirfd and flags arguments (Arnaldo Carvalho de Melo)
> 
> - Beautify arch_prctl 'code' syscall arg (Arnaldo Carvalho de Melo)
> 
> - Beautify fadvise64 'advice' syscall arg (Arnaldo Carvalho de Melo)
> 
> - Relax checks on perf-PID.map ownership, resulting in symbols in
>   executable anonymous maps setup by JITs in things like node.js to
>   be resolved in a 'perf top' session run by root without the need
>   for --force to be used (Arnaldo Carvalho de Melo)
> 
> - Update asm-generic/unistd.h copy (Arnaldo Carvalho de Melo)
> 
> - Do not use the first and last symbols when setting up address filters in
>   auxtrace, this fails when we don't have a symbol table, filter the entire
>   area based on the dso size. (Adrian Hunter)
> 
> - Do not use kernel headers to build libsubcmd, we shouldn't use
>   anything from outside tools/, fixes the build with the Android NDK (Arnaldo Carvalho de Melo)
> 
> - Add several prototypes for systems lacking those, such as open_memstream(),
>   sigqueue(), fixing warnings building with Android's bionic libc that were
>   preventing the use of -Werror there (Arnaldo Carvalho de Melo)
> 
> - Use LDFLAGS in the libtraceevent build commands, allowing developers
>   to override its values (Jiri Olsa)
> 
> - Link libperf-jvmti.so with LDFLAGS variable, allowing distro
>   packages to propagate its settings when building this library (Jiri Olsa)
> 
> - cs-etm (ARM CoreSight) fixes: (Leo Yan)
> 
>   - Correct packets swapping in cs_etm__flush()
>   - Avoid stale branch samples when flush packet
>   - Remove unused 'trace_on' in cs_etm_decoder
>   - Refactor enumeration cs_etm_sample_type
>   - Rename CS_ETM_TRACE_ON to CS_ETM_DISCONTINUITY
>   - Treat NO_SYNC element as trace discontinuity
>   - Treat EO_TRACE element as trace discontinuity
>   - Generate branch sample for exception packet
> 
> - Use shebangs in the 'perf test' shell scripts, making them identifiable as
>   shell scripts (Michael Petlan)
> 
> - Avoid segfaults caused by negated options in 'perf stat' (Michael Petlan)
> 
> - Fix processing of dereferenced args in bprintk events in libtracevent (Steven Rostedt)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (2):
>       perf dso: Export data_file_size() method there are no symbols
>       perf auxtrace: Alter addr_filter__entire_dso() to work if there are no symbols
> 
> Arnaldo Carvalho de Melo (48):
>       perf trace: Rename delivery functions to ease making ordered_events selectable
>       perf trace: Allow selecting use the use of the ordered_events code
>       perf trace beauty: Beautify renameat2's fd arg wrt AT_FDCWD
>       perf beauty: Add a string table generator for renameat2's flags constants
>       perf beauty: Wire up the renameat flags table generator to the Makefile
>       perf trace: Beautify renameat2's flags argument
>       perf trace beauty: renameat's newdirfd may also be AT_FDCWD
>       tools lib subcmd: Don't add the kernel sources to the include path
>       perf tools: Add missing sigqueue() prototype for systems lacking it
>       perf header: Fix up argument to ctime()
>       perf tools: Add missing open_memstream() prototype for systems lacking it
>       perf tools: Cast off_t to s64 to avoid warning on bionic libc
>       perf trace: Rename set_ev_qualifier_filter to clarify its a tracepoint filter
>       perf trace: Avoid using raw_syscalls in duplicity with eBPF augmentation
>       perf trace: Implement syscall filtering in augmented_syscalls
>       perf bpf: Move perf_event_output() from stdio.h to bpf.h
>       perf augmented_syscalls: Switch to using a struct for the syscalls map values
>       perf trace: Switch to using a struct for the aumented_raw_syscalls syscalls map values
>       perf augmented_raw_syscalls: Do not include stdio.h
>       perf trace: Allow specifying a set of events to add in perfconfig
>       perf trace: Allow configuring if zeroed syscall args should be printed
>       perf trace: Allow configuring if the syscall duration should be printed
>       perf config: Show the configuration when no arguments are provided
>       perf trace: Allow configuring default for perf_event_attr.inherit
>       perf trace: Allow configuring if the syscall start timestamp should be printed
>       perf trace: Allow suppressing the syscall argument names
>       perf trace: Make the alignment of the syscall args be configurable
>       perf trace: Enclose strings with double quotes
>       perf trace: Add a prefix member to the strarray class
>       perf trace: Allow asking for not suppressing common string prefixes
>       perf trace beauty: Print O_RDONLY when (flags & O_ACCMODE) == 0
>       perf trace: Add alignment spaces after the closing parens
>       perf augmented_raw_syscalls: Copy 'access' arg as well
>       perf trace: Enclose the errno strings with ()
>       perf trace: Show NULL when syscall pointer args are 0
>       tools include arch: Grab a copy of x86's prctl.h
>       perf beauty: Add a string table generator for x86's 'arch_prctl' codes
>       perf beauty: Wire up the x86_arch prctl code table generator
>       perf trace: Move strarrays to beauty.h for further reuse
>       perf trace: When showing string prefixes show prefix + ??? for unknown entries
>       perf trace beauty: Beautify arch_prctl()'s arguments
>       perf beauty mmap: Print PROT_READ before PROT_EXEC to match strace output
>       perf beauty mmap: Print mmap's 'offset' arg in hexadecimal
>       tools headers uapi: Grab a copy of fadvise.h
>       perf beauty: Add generator for fadvise64's 'advice' arg constants
>       perf trace: Wire up the fadvise 'advice' table generator
>       perf symbols: Relax checks on perf-PID.map ownership
>       tools uapi asm: Update asm-generic/unistd.h copy
> 
> Jiri Olsa (2):
>       tools lib traceevent: Use LDFLAGS in the build commands
>       perf tools: Link libperf-jvmti.so with LDFLAGS variable
> 
> Leo Yan (8):
>       perf cs-etm: Correct packets swapping in cs_etm__flush()
>       perf cs-etm: Avoid stale branch samples when flush packet
>       perf cs-etm: Remove unused 'trace_on' in cs_etm_decoder
>       perf cs-etm: Refactor enumeration cs_etm_sample_type
>       perf cs-etm: Rename CS_ETM_TRACE_ON to CS_ETM_DISCONTINUITY
>       perf cs-etm: Treat NO_SYNC element as trace discontinuity
>       perf cs-etm: Treat EO_TRACE element as trace discontinuity
>       perf cs-etm: Generate branch sample for exception packet
> 
> Michael Petlan (2):
>       perf tests: Use shebangs in the shell scripts
>       perf stat: Avoid segfaults caused by negated options
> 
> Steven Rostedt (VMware) (1):
>       tools lib traceevent: Fix processing of dereferenced args in bprintk events
> 
>  tools/arch/x86/include/uapi/asm/prctl.h            |  17 +
>  tools/include/uapi/asm-generic/unistd.h            |   4 +
>  tools/include/uapi/linux/fadvise.h                 |  22 ++
>  tools/lib/subcmd/Makefile                          |   2 -
>  tools/lib/traceevent/Makefile                      |   4 +-
>  tools/lib/traceevent/event-parse.c                 |   1 +
>  tools/perf/Documentation/perf-config.txt           |  32 ++
>  tools/perf/Documentation/perf-trace.txt            |   6 +
>  tools/perf/Makefile.config                         |   2 +
>  tools/perf/Makefile.perf                           |  27 +-
>  tools/perf/builtin-config.c                        |   7 +-
>  tools/perf/builtin-stat.c                          |   8 +-
>  tools/perf/builtin-timechart.c                     |   4 +
>  tools/perf/builtin-trace.c                         | 370 ++++++++++++++++-----
>  tools/perf/check-headers.sh                        |   2 +
>  tools/perf/examples/bpf/augmented_raw_syscalls.c   |  33 +-
>  tools/perf/include/bpf/bpf.h                       |   2 +
>  tools/perf/include/bpf/stdio.h                     |   3 -
>  tools/perf/tests/builtin-test.c                    |   3 +
>  tools/perf/tests/shell/probe_vfs_getname.sh        |   1 +
>  .../tests/shell/record+probe_libc_inet_pton.sh     |   1 +
>  .../tests/shell/record+script_probe_vfs_getname.sh |   1 +
>  tools/perf/tests/shell/trace+probe_vfs_getname.sh  |   1 +
>  tools/perf/trace/beauty/Build                      |   2 +
>  tools/perf/trace/beauty/arch_prctl.c               |  33 ++
>  tools/perf/trace/beauty/beauty.h                   |  36 +-
>  tools/perf/trace/beauty/clone.c                    |   7 +-
>  tools/perf/trace/beauty/eventfd.c                  |   4 +-
>  tools/perf/trace/beauty/fadvise.sh                 |  22 ++
>  tools/perf/trace/beauty/fcntl.c                    |  22 +-
>  tools/perf/trace/beauty/flock.c                    |   4 +-
>  tools/perf/trace/beauty/futex_op.c                 |   8 +-
>  tools/perf/trace/beauty/futex_val3.c               |   3 +-
>  tools/perf/trace/beauty/ioctl.c                    |  31 +-
>  tools/perf/trace/beauty/kcmp.c                     |   8 +-
>  tools/perf/trace/beauty/mmap.c                     |  22 +-
>  tools/perf/trace/beauty/mode_t.c                   |   4 +-
>  tools/perf/trace/beauty/mount_flags.c              |   8 +-
>  tools/perf/trace/beauty/msg_flags.c                |   4 +-
>  tools/perf/trace/beauty/open_flags.c               |  13 +-
>  tools/perf/trace/beauty/perf_event_open.c          |   4 +-
>  tools/perf/trace/beauty/pkey_alloc.c               |  14 +-
>  tools/perf/trace/beauty/prctl.c                    |  16 +-
>  tools/perf/trace/beauty/rename_flags.sh            |  15 +
>  tools/perf/trace/beauty/renameat.c                 |  19 ++
>  tools/perf/trace/beauty/sched_policy.c             |   6 +-
>  tools/perf/trace/beauty/seccomp.c                  |   8 +-
>  tools/perf/trace/beauty/signum.c                   |   4 +-
>  tools/perf/trace/beauty/sockaddr.c                 |   4 +-
>  tools/perf/trace/beauty/socket.c                   |   8 +-
>  tools/perf/trace/beauty/socket_type.c              |   4 +-
>  tools/perf/trace/beauty/statx.c                    |  10 +-
>  tools/perf/trace/beauty/waitid_options.c           |   4 +-
>  tools/perf/trace/beauty/x86_arch_prctl.sh          |  26 ++
>  tools/perf/util/auxtrace.c                         |  11 +-
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  42 ++-
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |  10 +-
>  tools/perf/util/cs-etm.c                           |  77 ++++-
>  tools/perf/util/dso.c                              |   6 +-
>  tools/perf/util/dso.h                              |   1 +
>  tools/perf/util/evlist.c                           |   4 +
>  tools/perf/util/header.c                           |   4 +-
>  tools/perf/util/s390-cpumsf.c                      |   2 +-
>  tools/perf/util/symbol.c                           |  11 -
>  64 files changed, 842 insertions(+), 252 deletions(-)
>  create mode 100644 tools/arch/x86/include/uapi/asm/prctl.h
>  create mode 100644 tools/include/uapi/linux/fadvise.h
>  create mode 100644 tools/perf/trace/beauty/arch_prctl.c
>  create mode 100755 tools/perf/trace/beauty/fadvise.sh
>  create mode 100755 tools/perf/trace/beauty/rename_flags.sh
>  create mode 100644 tools/perf/trace/beauty/renameat.c
>  create mode 100755 tools/perf/trace/beauty/x86_arch_prctl.sh

Pulled, thanks a lot Arnaldo!

	Ingo
