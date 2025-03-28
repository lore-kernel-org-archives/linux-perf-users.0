Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20B519ABAC;
	Fri, 28 Mar 2025 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743143553; cv=none; b=YV0l8svAXrSiB1iaXTonTuZjOUciEjkUbHwdq0AxfSsRedKSMPKnxvbTQWuXgNHmvUOFbAE1lt2auDi0Y+LxnxwM3nyf6W2O/xgxQ/iUk0p0nxUxe93rdkZP2juAKz0aMJv4ECrbIZ3/+j+tjzMhEA4/7UheYz/EVHnWbYHVOBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743143553; c=relaxed/simple;
	bh=DfmqjKDuUF3ZLFVDT/FzBTxmNISnOJqOyXO6h1ICoJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oiW+r3IavXCmtl49vOGE4A098A5fqg7zf8oUSv2JBxeECmTjk31eaDl5BAtPAgkQDAS6+0MM+8VOyMU7R8qJ22Yu2yuNrYRJ88Bo4hin2ER9h02F3m/k/oByF7klmsyzpBdT6PeG6U0EFLAcPR75geYPLoRjK1cmPe8NL15GdCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7eeGZS+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7eeGZS+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB33EC4CEE4;
	Fri, 28 Mar 2025 06:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743143553;
	bh=DfmqjKDuUF3ZLFVDT/FzBTxmNISnOJqOyXO6h1ICoJU=;
	h=From:To:Cc:Subject:Date:From;
	b=I7eeGZS+s8WpCV8S+D8BCUD1lqI82iQo8fc/3BZVTLir9WdIPVLtqDwuTr6Dow4U/
	 6fL1O33NO982IS/ODdaviwdYHiLDij5pA7i2QRkUMTWLe7c5zOG85tsrbacXHnIk48
	 r8XdnkJO3fXI0v56ts15QeEd3i6OegqDI0jk3L9xHZfrbEHE6okK3KVvdxO268Suni
	 oe5tcPc5+6biZhB/JBt59DiDvKyJHkkZuT/JCQMwmjaDH6n3cX7hTN2UuKL/P+VhJ3
	 LNfSbrQNaO0OfanwZ3NE89y/dwbQGUTPDZb5C8yYXYVrwAkYyjot6pR826CIocAu4t
	 m/ccSSN+FSFJw==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: [GIT PULL] perf-tools updates for v6.15
Date: Thu, 27 Mar 2025 23:32:24 -0700
Message-ID: <20250328063228.3824573-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v6.15.
We have a couple of interesting changes in this release, it'd be great
if you could play with them and give some feedback.

Thanks,
Namhyung


The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.15-2025-03-27

for you to fetch changes up to 35d13f841a3d8159ef20d5e32a9ed3faa27875bc:

  perf bpf-filter: Fix a parsing error with comma (2025-03-24 17:29:58 -0700)

----------------------------------------------------------------
perf tools changes for v6.15

perf record
-----------
* Introduce latency profiling using scheduler information.  The latency
  profiling is to show impacts on wall-time rather than cpu-time.  By
  tracking context switches, it can weight samples and find which part
  of the code contributed more to the execution latency.

  The value (period) of the sample is weighted by dividing it by the
  number of parallel execution at the moment.  The parallelism is
  tracked in perf report with sched-switch records.  This will reduce
  the portion that are run in parallel and in turn increase the portion
  of serial executions.

  For now, it's limited to profile processes, IOW system-wide profiling
  is not supported.  You can add --latency option to enable this.

    $ perf record --latency -- make -C tools/perf

  I've run the above command for perf build which adds -j option to
  make with the number of CPUs in the system internally.  Normally
  it'd show something like below:

    $ perf report -F overhead,comm
    ...
    #
    # Overhead  Command
    # ........  ...............
    #
        78.97%  cc1
         6.54%  python3
         4.21%  shellcheck
         3.28%  ld
         1.80%  as
         1.37%  cc1plus
         0.80%  sh
         0.62%  clang
         0.56%  gcc
         0.44%  perl
         0.39%  make
	 ...

  The cc1 takes around 80% of the overhead as it's the actual compiler.
  However it runs in parallel so its contribution to latency may be less
  than that.  Now, perf report will show both overhead and latency (if
  --latency was given at record time) like below:

    $ perf report -s comm
    ...
    #
    # Overhead   Latency  Command
    # ........  ........  ...............
    #
        78.97%    48.66%  cc1
         6.54%    25.68%  python3
         4.21%     0.39%  shellcheck
         3.28%    13.70%  ld
         1.80%     2.56%  as
         1.37%     3.08%  cc1plus
         0.80%     0.98%  sh
         0.62%     0.61%  clang
         0.56%     0.33%  gcc
         0.44%     1.71%  perl
         0.39%     0.83%  make
	 ...

  You can see latency of cc1 goes down to around 50% and python3 and ld
  contribute a lot more than their overhead.  You can use --latency
  option in perf report to get the same result but ordered by latency.

    $ perf report --latency -s comm

perf report
-----------
* As a side effect of the latency profiling work, it adds a new output
  field 'latency' and a sort key 'parallelism'.  The below is a result
  from my system with 64 CPUs.  The build was well-parallelized but
  contained some serial portions.

    $ perf report -s parallelism
    ...
    #
    # Overhead   Latency  Parallelism
    # ........  ........  ...........
    #
        16.95%     1.54%           62
        13.38%     1.24%           61
        12.50%    70.47%            1
        11.81%     1.06%           63
         7.59%     0.71%           60
         4.33%    12.20%            2
         3.41%     0.33%           59
         2.05%     0.18%           64
         1.75%     1.09%            9
         1.64%     1.85%            5
         ...

* Support Feodra mini-debuginfo which is a LZMA compressed symbol table
  inside ".gnu_debugdata" ELF section.

perf annotate
-------------
* Add --code-with-type option to enable data-type profiling with the
  usual annotate output.  Instead of focusing on data structure, it
  shows code annotation together with data type it accesses in case the
  instruction refers to a memory location (and it was able to resolve
  the target data type).  Currently it only works with --stdio.

    $ perf annotate --stdio --code-with-type
    ...
     Percent |      Source code & Disassembly of vmlinux for cpu/mem-loads,ldlat=30/pp (18 samples, percent: local period)
    ----------------------------------------------------------------------------------------------------------------------
             : 0                0xffffffff81050610 <__fdget>:
        0.00 :   ffffffff81050610:        callq   0xffffffff81c01b80 <__fentry__>           # data-type: (stack operation)
        0.00 :   ffffffff81050615:        pushq   %rbp              # data-type: (stack operation)
        0.00 :   ffffffff81050616:        movq    %rsp, %rbp
        0.00 :   ffffffff81050619:        pushq   %r15              # data-type: (stack operation)
        0.00 :   ffffffff8105061b:        pushq   %r14              # data-type: (stack operation)
        0.00 :   ffffffff8105061d:        pushq   %rbx              # data-type: (stack operation)
        0.00 :   ffffffff8105061e:        subq    $0x10, %rsp
        0.00 :   ffffffff81050622:        movl    %edi, %ebx
        0.00 :   ffffffff81050624:        movq    %gs:0x7efc4814(%rip), %rax  # 0x14e40 <current_task>              # data-type: struct task_struct* +0
        0.00 :   ffffffff8105062c:        movq    0x8d0(%rax), %r14         # data-type: struct task_struct +0x8d0 (files)
        0.00 :   ffffffff81050633:        movl    (%r14), %eax              # data-type: struct files_struct +0 (count.counter)
        0.00 :   ffffffff81050636:        cmpl    $0x1, %eax
        0.00 :   ffffffff81050639:        je      0xffffffff810506a9 <__fdget+0x99>
        0.00 :   ffffffff8105063b:        movq    0x20(%r14), %rcx          # data-type: struct files_struct +0x20 (fdt)
        0.00 :   ffffffff8105063f:        movl    (%rcx), %eax              # data-type: struct fdtable +0 (max_fds)
        0.00 :   ffffffff81050641:        cmpl    %ebx, %eax
        0.00 :   ffffffff81050643:        jbe     0xffffffff810506ef <__fdget+0xdf>
        0.00 :   ffffffff81050649:        movl    %ebx, %r15d
        5.56 :   ffffffff8105064c:        movq    0x8(%rcx), %rdx           # data-type: struct fdtable +0x8 (fd)
	...

  The "# data-type:" part was added with this change.  The first few
  entries are not very interesting.  But later you can it accesses
  a couple of fields in the task_struct, files_struct and fdtable.

perf trace
----------
* Support syscall tracing for different ABI.  For example it can trace
  system calls for 32-bit applications on 64-bit kernel transparently.

* Add --summary-mode=total option to show global syscall summary.  The
  default is 'thread' to show per-thread syscall summary.

Python support
--------------
* Add more interfaces to 'perf' module to parse events, and config,
  enable or disable the event list properly so that it can implement
  basic functionalities purely in Python.  There is an example code
  for these new interfaces in python/tracepoint.py.

* Add mypy and pylint support to enable build time checking.  Fix
  some code based on the findings from these tools.

Internals
---------
* Introduce io_dir__readdir() API to make directory traveral (usually
  for proc or sysfs) efficient with less memory footprint.

JSON vendor events
------------------
* Add events and metrics for ARM Neoverse N3 and V3
* Update events and metrics on various Intel CPUs
* Add/update events for a number of SiFive processors

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Anubhav Shelat (1):
      perf script: force stdin for flamegraph in live mode

Arnaldo Carvalho de Melo (13):
      perf maps: Introduce map__set_kmap_maps() for kernel maps
      perf maps: Set the kmaps for newly created/added kernel maps
      perf maps: Add missing map__set_kmap_maps() when replacing a kernel map
      libapi: Add missing header with NAME_MAX define to io_dir.h
      perf units: Fix insufficient array space
      perf hist stdio: Do bounds check when printing callchains to avoid UB with new gcc versions
      perf libunwind: Fixup conversion perf_sample->user_regs to a pointer
      perf python: Fixup description of sample.id event member
      perf python: Remove some unused macros (_PyUnicode_FromString(arg), etc)
      perf python tracepoint.py: Change the COMM using setproctitle if available
      perf python: Decrement the refcount of just created event on failure
      perf python: Don't keep a raw_data pointer to consumed ring buffer space
      perf python: Check if there is space to copy all the event

Athira Rajeev (4):
      perf probe: Pick the correct dwarf die while adding probe points
      perf trace: Add missing perf_tool__init()
      perf annotate: Add annotation_options.disassembler_used
      perf annotate: Return errors from disasm_line__parse_powerpc()

Benjamin Peterson (1):
      perf trace: Fix return value of trace__fprintf_tp_fields

Chun-Tse Shao (4):
      perf lock: Add bpf maps for owner stack tracing
      perf lock: Retrieve owner callstack in bpf program
      perf lock: Make rb_tree helper functions generic
      perf lock: Report owner stack in usermode

Colin Ian King (1):
      perf test: Fix spelling mistake "sythesizing" -> "synthesizing"

Dapeng Mi (2):
      perf x86/topdown: Fix topdown leader sampling test error on hybrid
      perf x86 evlist: Update comments on topdown regrouping

Dirk Gouders (1):
      perf bench sched pipe: fix enforced blocking reads in worker_thread

Dmitry Vyukov (10):
      perf report: Add machine parallelism
      perf report: Add parallelism sort key
      perf report: Switch filtered from u8 to u16
      perf report: Add parallelism filter
      perf report: Add latency output field
      perf report: Add --latency flag
      perf report: Add latency and parallelism profiling documentation
      perf test: Add tests for latency and parallelism profiling
      perf hist: Shrink struct hist_entry size
      perf report: Fix input reload/switch with symbol sort key

Dr. David Alan Gilbert (6):
      perf tools: Deadcode removal
      perf util: Remove unused perf_color_default_config
      perf util: Remove unused pstack__pop
      perf util: Remove unused perf_data__update_dir
      perf util: Remove unused perf_pmus__default_pmu_name
      perf util: Remove unused perf_config__refresh

Eric Lin (5):
      perf vendor events riscv: Update SiFive Bullet events
      perf vendor events riscv: Add SiFive Bullet version 0x07 events
      perf vendor events riscv: Add SiFive Bullet version 0x0d events
      perf vendor events riscv: Add SiFive P550 events
      perf vendor events riscv: Add SiFive P650 events

Feng Yang (1):
      perf kwork: Remove unreachable judgments

Gabriele Monaco (2):
      perf ftrace latency: variable histogram buckets
      perf ftrace latency: allow to hide empty buckets

Greg Kroah-Hartman (1):
      perf tools: Fix up some comments and code to properly use the event_source bus

Holger Hoffstätte (1):
      perf build: filter all combinations of -flto for libperl

Ian Rogers (88):
      perf evsel: Add pmu_name helper
      perf stat: Fix find_stat for mixed legacy/non-legacy events
      perf test: Extra verbosity and hypervisor skip for tpebs test
      perf evsel: Reduce scanning core PMUs in is_hybrid
      perf pmus: Restructure pmu_read_sysfs to scan fewer PMUs
      perf pmu: Rename name matching for no suffix or wildcard variants
      perf stat: Don't merge counters purely on name
      perf stat: Changes to event name uniquification
      perf vendor events: Update Alderlake events/metrics
      perf vendor events: Update AlderlakeN events/metrics
      perf vendor events: Add Arrowlake events/metrics
      perf vendor events: Update Broadwell events/metrics
      perf vendor events: Update BroadwellDE events/metrics
      perf vendor events: Update BroadwellX events/metrics
      perf vendor events: Update CascadelakeX events/metrics
      perf vendor events: Add Clearwaterforest events
      perf vendor events: Update EmeraldRapids events/metrics
      perf vendor events: Update GrandRidge events/metrics
      perf vendor events: Update/add Graniterapids events/metrics
      perf vendor events: Update Haswell events/metrics
      perf vendor events: Update HaswellX events/metrics
      perf vendor events: Update Icelake events/metrics
      perf vendor events: Update IcelakeX events/metrics
      perf vendor events: Update/add Lunarlake events/metrics
      perf vendor events: Update Meteorlake events/metrics
      perf vendor events: Update Rocketlake events/metrics
      perf vendor events: Update Sapphirerapids events/metrics
      perf vendor events: Update Sierraforest events/metrics
      perf vendor events: Update Skylake metrics
      perf vendor events: Update SkylakeX events/metrics
      perf vendor events: Update Tigerlake events/metrics
      perf test stat_all_metrics: Ensure missing events fail test
      perf sample: Make user_regs and intr_regs optional
      tools build: Fix a number of Wconversion warnings
      perf parse-events: Tidy name token matching
      tools lib api: Add io_dir an allocation free readdir alternative
      perf maps: Switch modules tree walk to io_dir__readdir
      perf pmu: Switch to io_dir__readdir
      perf header: Switch mem topology to io_dir__readdir
      perf events: Remove scandir in thread synthesis
      perf parse-events: Switch tracepoints to io_dir__readdir
      perf hwmon_pmu: Switch event discovery to io_dir__readdir
      perf machine: Reuse module path buffer
      perf cpumap: Reduce cpu size from int to int16_t
      tools/x86: Fix linux/unaligned.h include path in lib/insn.c
      perf test: Fix leak in "Synthesize attr update" test
      perf tests: Fix data symbol test with LTO builds
      perf mem: Don't leak mem event names
      perf debug: Avoid stack overflow in recursive error message
      perf evlist: Add success path to evlist__create_syswide_maps
      perf evsel: tp_format accessing improvements
      perf python: Add evlist enable and disable methods
      perf python: Add member access to a number of evsel variables
      perf python: Add optional cpus and threads arguments to parse_events
      perf python: Update ungrouped evsel leader in clone
      perf python: Avoid duplicated code in get_tracepoint_field
      perf python: Add evlist all_cpus accessor
      perf python: Add evlist.config to set up record options
      perf python tracepoint: Switch to using parse_events
      perf tools: Improve handling of hybrid PMUs in perf_event_attr__fprintf
      perf parse-events: Corrections to topdown sorting
      perf test stat: Additional topdown grouping tests
      perf test: Fixes to variable expansion and stdout for diff test
      perf test: Add pipe output testing for annotate
      perf mutex: Add annotations for LOCKS_EXCLUDED and LOCKS_RETURNED
      perf dso: Use lock annotations to fix asan deadlock
      perf test dso-data: Correctly free test file in read test
      perf cpumap: Increment reference count for online cpumap
      perf dso: Move libunwind dso_data variables into ifdef
      perf dso: kernel-doc for enum dso_binary_type
      perf syscalltbl: Remove syscall_table.h
      perf trace: Reorganize syscalls
      perf syscalltbl: Remove struct syscalltbl
      perf dso: Add support for reading the e_machine type for a dso
      perf thread: Add support for reading the e_machine type for a thread
      perf trace beauty: Add syscalltbl.sh generating all system call tables
      perf syscalltbl: Use lookup table containing multiple architectures
      perf build: Remove Makefile.syscalls
      perf syscalltbl: Mask off ABI type for MIPS system calls
      perf trace: Make syscall table stable
      perf trace: Fix BTF memory leak
      perf trace: Fix evlist memory leak
      tools/build: Don't pass test log files to linker
      perf build: Rename TEST_LOGS to SHELL_TEST_LOGS
      perf build: Add mypy build tests
      perf build: Add pylint build tests
      perf test: Address attr.py mypy error
      perf python: Fix setup.py mypy errors

Ilkka Koskinen (2):
      perf vendor events arm64: AmpereOne/AmpereOneX: Mark LD_RETIRED impacted by errata
      perf vendor events arm64 AmpereOneX: Fix frontend_bound calculation

James Clark (11):
      perf vendor events arm64: Add N3 events/metrics
      perf vendor events arm64: Add V3 events/metrics
      perf: Always feature test reallocarray
      perf tests: Fix Tool PMU test segfault
      perf list: Also append PMU name in verbose mode
      perf pmu: Dynamically allocate tool PMU
      perf pmu: Don't double count common sysfs and json events
      perf list: Document -v option deduplication feature
      perf stat: Fix non-uniquified hybrid legacy events
      perf: intel-tpebs: Fix incorrect usage of zfree()
      libperf: Don't remove -g when EXTRA_CFLAGS are used

Kan Liang (1):
      perf tools: Add skip check in tool_pmu__event_to_str()

Krzysztof Łopatowski (1):
      perf tools: Improve startup time by reducing unnecessary stat() calls

Leo Yan (14):
      perf tools: Fix compilation error on arm64
      perf arm-spe: Report error if set frequency
      perf script: Make printing flags reliable
      perf script: Refactor sample_flags_to_name() function
      perf script: Separate events from branch types
      perf script: Add not taken event for branches
      perf script: Add not taken event for branch stack
      perf arm-spe: Fix load-store operation checking
      perf arm-spe: Extend branch operations
      perf arm-spe: Decode transactional event
      perf arm-spe: Fill branch operations and events to record
      perf arm-spe: Set sample flags with supplement info
      perf arm-spe: Add branch stack
      perf arm-spe: Support previous branch target (PBT) address

Likhitha Korrapati (1):
      perf tools: Fix is_compat_mode build break in ppc64

Luca Ceresoli (1):
      perf build: Fix in-tree build due to symbolic link

Marcus Meissner (1):
      perf tools: annotate asm_pure_loop.S

Namhyung Kim (39):
      Merge tag 'v6.14-rc1' into perf-tools-next
      perf trace: Allocate syscall stats only if summary is on
      perf trace: Convert syscall_stats to hashmap
      perf tools: Get rid of now-unused rb_resort.h
      perf trace: Add --summary-mode option
      perf tools: Use symfs when opening debuginfo by path
      perf tools: Fix compile error on sample->user_regs
      perf script: Fix hangup in offline flamegraph report
      perf report: Switch data file correctly in TUI
      perf report: Support switching data w/ and w/o callchains
      perf annotate-data: Handle direct use of stack pointer without fbreg
      perf tools: Skip BPF sideband event for userspace profiling
      perf test: Add --metric-only to perf stat output tests
      perf test: Skip perf probe tests when running as non-root
      perf test: Skip perf trace tests when running as non-root
      perf test: Add trace record and replay test
      perf test: Add timeout to datasym workload
      perf test: Simplify data symbol test
      perf machine: Fixup kernel maps ends after adding extra maps
      perf maps: Fixup maps_by_name when modifying maps_by_address
      perf machine: Fix insertion of PERF_RECORD_KSYMBOL related kernel maps
      perf report: Do not process non-JIT BPF ksymbol events
      perf report: Use map_symbol__copy() when copying callchains
      perf report: Fix memory leaks in the hierarchy mode
      perf ftrace: Fix latency stats with BPF
      perf ftrace: Remove an unnecessary condition check in BPF
      perf ftrace: Use atomic inc to update histogram in BPF
      perf annotate-data: Add annotated_data_type__get_member_name()
      perf annotate: Remove unused len parameter from annotation_line__print()
      perf annotate: Pass annotation_options to annotation_line__print()
      perf annotate: Pass hist_entry to annotate functions
      perf annotate: Factor out __hist_entry__get_data_type()
      perf annotate: Implement code + data type annotation
      perf annotate: Add --code-with-type option.
      perf sort: Keep output fields in the same level
      perf report: Allow hierarchy mode for --children
      perf report: Disable children column for data type profiling
      perf report: Fix a memory leak for perf_env on AMD
      perf bpf-filter: Fix a parsing error with comma

Samuel Holland (2):
      perf vendor events riscv: Rename U74 to Bullet
      perf vendor events riscv: Remove leading zeroes

Stephen Brennan (4):
      perf tools: Add dummy functions for !HAVE_LZMA_SUPPORT
      perf tools: Add LZMA decompression from FILE
      perf symbol: Support .gnu_debugdata for symbols
      perf dso: fix dso__is_kallsyms() check

Thomas Falcon (2):
      perf report: Fix sample number stats for branch entry mode
      perf script: Fix output type for dynamically allocated core PMU's

Thomas Richter (6):
      perf test: Fix perf record test for precise_max
      perf test: Use cycles event in perf record test for leader_sampling
      perf test: Fix Hwmon PMU test endianess issue
      perf bench: Fix perf bench syscall loop count
      perf pmu: Handle memory failure in tool_pmu__new()
      perf trace: Fix wrong size to bpf_map__update_elem call

Veronika Molnarova (1):
      perf test stat_all_pmu.sh: Correctly check 'perf stat' result

Yangyu Chen (1):
      perf vendor events arm64: Fix incorrect CPU_CYCLE in metrics expr

Yujie Liu (2):
      perf script: Fix typo in branch event mask
      perf script: Update brstack syntax documentation

 tools/arch/x86/lib/insn.c                          |    2 +-
 tools/build/Makefile.build                         |    6 +-
 tools/build/feature/test-backtrace.c               |    2 +-
 tools/build/feature/test-bpf.c                     |    2 +-
 tools/build/feature/test-glibc.c                   |    2 +-
 tools/build/feature/test-libdebuginfod.c           |    2 +-
 tools/build/feature/test-libdw.c                   |    2 +-
 tools/build/feature/test-libelf-gelf_getnote.c     |    2 +-
 tools/build/feature/test-libelf.c                  |    2 +-
 tools/build/feature/test-lzma.c                    |    2 +-
 tools/lib/api/Makefile                             |    2 +-
 tools/lib/api/io_dir.h                             |  105 +
 tools/lib/perf/Makefile                            |   12 +-
 tools/lib/perf/cpumap.c                            |    8 +-
 tools/lib/perf/include/perf/cpumap.h               |    3 +-
 tools/perf/Build                                   |   32 +-
 .../callchain-overhead-calculation.txt             |    5 +-
 .../Documentation/cpu-and-latency-overheads.txt    |   85 +
 tools/perf/Documentation/intel-hybrid.txt          |   12 +-
 tools/perf/Documentation/perf-annotate.txt         |    4 +
 tools/perf/Documentation/perf-list.txt             |    4 +-
 tools/perf/Documentation/perf-lock.txt             |    5 +-
 tools/perf/Documentation/perf-record.txt           |    4 +
 tools/perf/Documentation/perf-report.txt           |   54 +-
 tools/perf/Documentation/perf-script.txt           |   23 +-
 tools/perf/Documentation/perf-trace.txt            |    4 +
 tools/perf/Documentation/tips.txt                  |    4 +
 tools/perf/Makefile.config                         |   12 +-
 tools/perf/Makefile.perf                           |   26 +-
 tools/perf/arch/alpha/entry/syscalls/Kbuild        |    2 -
 .../arch/alpha/entry/syscalls/Makefile.syscalls    |    5 -
 tools/perf/arch/alpha/include/syscall_table.h      |    2 -
 tools/perf/arch/arc/entry/syscalls/Kbuild          |    2 -
 .../perf/arch/arc/entry/syscalls/Makefile.syscalls |    3 -
 tools/perf/arch/arc/include/syscall_table.h        |    2 -
 tools/perf/arch/arm/entry/syscalls/Kbuild          |    4 -
 .../perf/arch/arm/entry/syscalls/Makefile.syscalls |    2 -
 tools/perf/arch/arm/include/syscall_table.h        |    2 -
 tools/perf/arch/arm/tests/dwarf-unwind.c           |    2 +-
 tools/perf/arch/arm/util/pmu.c                     |    5 +-
 tools/perf/arch/arm/util/unwind-libdw.c            |    2 +-
 tools/perf/arch/arm64/entry/syscalls/Kbuild        |    3 -
 .../arch/arm64/entry/syscalls/Makefile.syscalls    |    6 -
 tools/perf/arch/arm64/include/syscall_table.h      |    8 -
 tools/perf/arch/arm64/tests/dwarf-unwind.c         |    2 +-
 tools/perf/arch/arm64/util/arm-spe.c               |   21 +
 tools/perf/arch/arm64/util/unwind-libdw.c          |    2 +-
 tools/perf/arch/csky/entry/syscalls/Kbuild         |    2 -
 .../arch/csky/entry/syscalls/Makefile.syscalls     |    3 -
 tools/perf/arch/csky/include/syscall_table.h       |    2 -
 tools/perf/arch/csky/util/unwind-libdw.c           |    2 +-
 tools/perf/arch/loongarch/entry/syscalls/Kbuild    |    2 -
 .../loongarch/entry/syscalls/Makefile.syscalls     |    3 -
 tools/perf/arch/loongarch/include/syscall_table.h  |    2 -
 tools/perf/arch/loongarch/util/unwind-libdw.c      |    2 +-
 tools/perf/arch/mips/entry/syscalls/Kbuild         |    2 -
 .../arch/mips/entry/syscalls/Makefile.syscalls     |    5 -
 tools/perf/arch/mips/include/syscall_table.h       |    2 -
 tools/perf/arch/parisc/entry/syscalls/Kbuild       |    3 -
 .../arch/parisc/entry/syscalls/Makefile.syscalls   |    6 -
 tools/perf/arch/parisc/include/syscall_table.h     |    8 -
 tools/perf/arch/powerpc/entry/syscalls/Kbuild      |    3 -
 .../arch/powerpc/entry/syscalls/Makefile.syscalls  |    6 -
 tools/perf/arch/powerpc/include/syscall_table.h    |    8 -
 tools/perf/arch/powerpc/tests/dwarf-unwind.c       |    2 +-
 tools/perf/arch/powerpc/util/header.c              |    4 +-
 tools/perf/arch/powerpc/util/unwind-libdw.c        |    2 +-
 tools/perf/arch/riscv/entry/syscalls/Kbuild        |    2 -
 .../arch/riscv/entry/syscalls/Makefile.syscalls    |    4 -
 tools/perf/arch/riscv/include/syscall_table.h      |    8 -
 tools/perf/arch/riscv/util/unwind-libdw.c          |    2 +-
 tools/perf/arch/s390/entry/syscalls/Kbuild         |    2 -
 .../arch/s390/entry/syscalls/Makefile.syscalls     |    5 -
 tools/perf/arch/s390/include/syscall_table.h       |    2 -
 tools/perf/arch/s390/util/unwind-libdw.c           |    2 +-
 tools/perf/arch/sh/entry/syscalls/Kbuild           |    2 -
 .../perf/arch/sh/entry/syscalls/Makefile.syscalls  |    4 -
 tools/perf/arch/sh/include/syscall_table.h         |    2 -
 tools/perf/arch/sparc/entry/syscalls/Kbuild        |    3 -
 .../arch/sparc/entry/syscalls/Makefile.syscalls    |    5 -
 tools/perf/arch/sparc/include/syscall_table.h      |    8 -
 tools/perf/arch/x86/Build                          |    6 +-
 tools/perf/arch/x86/annotate/instructions.c        |   22 +-
 tools/perf/arch/x86/entry/syscalls/Kbuild          |    3 -
 .../perf/arch/x86/entry/syscalls/Makefile.syscalls |    6 -
 tools/perf/arch/x86/include/syscall_table.h        |    8 -
 tools/perf/arch/x86/tests/Build                    |    6 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c           |    2 +-
 tools/perf/arch/x86/util/evlist.c                  |   42 +-
 tools/perf/arch/x86/util/iostat.c                  |    2 +-
 tools/perf/arch/x86/util/topdown.c                 |    2 +-
 tools/perf/arch/x86/util/unwind-libdw.c            |    2 +-
 tools/perf/arch/xtensa/entry/syscalls/Kbuild       |    2 -
 .../arch/xtensa/entry/syscalls/Makefile.syscalls   |    4 -
 tools/perf/arch/xtensa/include/syscall_table.h     |    2 -
 tools/perf/bench/sched-pipe.c                      |   15 +-
 tools/perf/bench/syscall.c                         |   22 +-
 tools/perf/builtin-annotate.c                      |   19 +-
 tools/perf/builtin-c2c.c                           |    4 +-
 tools/perf/builtin-ftrace.c                        |   71 +-
 tools/perf/builtin-list.c                          |   11 +-
 tools/perf/builtin-lock.c                          |   56 +-
 tools/perf/builtin-mem.c                           |   12 +-
 tools/perf/builtin-record.c                        |   27 +-
 tools/perf/builtin-report.c                        |   77 +-
 tools/perf/builtin-script.c                        |   55 +-
 tools/perf/builtin-stat.c                          |    2 +-
 tools/perf/builtin-top.c                           |   13 +-
 tools/perf/builtin-trace.c                         |  584 +++--
 tools/perf/pmu-events/Build                        |   25 +-
 .../arch/arm64/ampere/ampereone/memory.json        |    4 +-
 .../arch/arm64/ampere/ampereonex/memory.json       |    4 +-
 .../arch/arm64/ampere/ampereonex/metrics.json      |   10 +-
 .../pmu-events/arch/arm64/arm/neoverse-n3/bus.json |   18 +
 .../arch/arm64/arm/neoverse-n3/exception.json      |   62 +
 .../arch/arm64/arm/neoverse-n3/fp_operation.json   |   22 +
 .../arch/arm64/arm/neoverse-n3/general.json        |   10 +
 .../arch/arm64/arm/neoverse-n3/l1d_cache.json      |   50 +
 .../arch/arm64/arm/neoverse-n3/l1i_cache.json      |   14 +
 .../arch/arm64/arm/neoverse-n3/l2_cache.json       |   78 +
 .../arch/arm64/arm/neoverse-n3/l3_cache.json       |   26 +
 .../arch/arm64/arm/neoverse-n3/ll_cache.json       |   22 +
 .../arch/arm64/arm/neoverse-n3/memory.json         |   54 +
 .../arch/arm64/arm/neoverse-n3/metrics.json        |  457 ++++
 .../arch/arm64/arm/neoverse-n3/retired.json        |   90 +
 .../pmu-events/arch/arm64/arm/neoverse-n3/spe.json |   42 +
 .../arch/arm64/arm/neoverse-n3/spec_operation.json |   90 +
 .../arch/arm64/arm/neoverse-n3/stall.json          |   86 +
 .../pmu-events/arch/arm64/arm/neoverse-n3/sve.json |   50 +
 .../pmu-events/arch/arm64/arm/neoverse-n3/tlb.json |   74 +
 .../arch/arm64/arm/neoverse-n3/trace.json          |   42 +
 .../arch/arm64/arm/neoverse-v3/brbe.json           |    6 +
 .../pmu-events/arch/arm64/arm/neoverse-v3/bus.json |   18 +
 .../arch/arm64/arm/neoverse-v3/exception.json      |   62 +
 .../arch/arm64/arm/neoverse-v3/fp_operation.json   |   22 +
 .../arch/arm64/arm/neoverse-v3/general.json        |   40 +
 .../arch/arm64/arm/neoverse-v3/l1d_cache.json      |   74 +
 .../arch/arm64/arm/neoverse-v3/l1i_cache.json      |   62 +
 .../arch/arm64/arm/neoverse-v3/l2_cache.json       |   78 +
 .../arch/arm64/arm/neoverse-v3/ll_cache.json       |   10 +
 .../arch/arm64/arm/neoverse-v3/memory.json         |   58 +
 .../arch/arm64/arm/neoverse-v3/metrics.json        |  457 ++++
 .../arch/arm64/arm/neoverse-v3/retired.json        |   98 +
 .../pmu-events/arch/arm64/arm/neoverse-v3/spe.json |   42 +
 .../arch/arm64/arm/neoverse-v3/spec_operation.json |  126 +
 .../arch/arm64/arm/neoverse-v3/stall.json          |  124 +
 .../pmu-events/arch/arm64/arm/neoverse-v3/sve.json |   50 +
 .../pmu-events/arch/arm64/arm/neoverse-v3/tlb.json |  138 +
 .../arch/arm64/common-and-microarch.json           |  310 +++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |    2 +
 tools/perf/pmu-events/arch/riscv/mapfile.csv       |    6 +-
 .../bullet-07/cycle-and-instruction-count.json     |   12 +
 .../arch/riscv/sifive/bullet-07/firmware.json      |    1 +
 .../arch/riscv/sifive/bullet-07/instruction.json   |    1 +
 .../arch/riscv/sifive/bullet-07/memory.json        |    1 +
 .../arch/riscv/sifive/bullet-07/microarch.json     |   62 +
 .../arch/riscv/sifive/bullet-07/watchpoint.json    |   42 +
 .../bullet-0d/cycle-and-instruction-count.json     |    1 +
 .../arch/riscv/sifive/bullet-0d/firmware.json      |    1 +
 .../arch/riscv/sifive/bullet-0d/instruction.json   |    1 +
 .../arch/riscv/sifive/bullet-0d/memory.json        |    1 +
 .../arch/riscv/sifive/bullet-0d/microarch.json     |   72 +
 .../arch/riscv/sifive/bullet-0d/watchpoint.json    |    1 +
 .../riscv/sifive/{u74 => bullet}/firmware.json     |    0
 .../arch/riscv/sifive/bullet/instruction.json      |   92 +
 .../arch/riscv/sifive/bullet/memory.json           |   32 +
 .../arch/riscv/sifive/bullet/microarch.json        |   57 +
 .../arch/riscv/sifive/p550/firmware.json           |    1 +
 .../arch/riscv/sifive/p550/instruction.json        |    1 +
 .../pmu-events/arch/riscv/sifive/p550/memory.json  |   47 +
 .../arch/riscv/sifive/p550/microarch.json          |    1 +
 .../sifive/p650/cycle-and-instruction-count.json   |    1 +
 .../arch/riscv/sifive/p650/firmware.json           |    1 +
 .../arch/riscv/sifive/p650/instruction.json        |    1 +
 .../pmu-events/arch/riscv/sifive/p650/memory.json  |   57 +
 .../arch/riscv/sifive/p650/microarch.json          |   62 +
 .../arch/riscv/sifive/p650/watchpoint.json         |    1 +
 .../arch/riscv/sifive/u74/instructions.json        |   92 -
 .../pmu-events/arch/riscv/sifive/u74/memory.json   |   32 -
 .../arch/riscv/sifive/u74/microarch.json           |   57 -
 .../pmu-events/arch/x86/alderlake/adl-metrics.json |  914 ++++---
 .../perf/pmu-events/arch/x86/alderlake/cache.json  |  292 ++-
 .../arch/x86/alderlake/floating-point.json         |   19 +-
 .../pmu-events/arch/x86/alderlake/frontend.json    |   19 -
 .../perf/pmu-events/arch/x86/alderlake/memory.json |   32 +-
 .../arch/x86/alderlake/metricgroups.json           |   10 +-
 .../perf/pmu-events/arch/x86/alderlake/other.json  |   92 +-
 .../pmu-events/arch/x86/alderlake/pipeline.json    |  127 +-
 .../arch/x86/alderlake/virtual-memory.json         |   33 +
 .../arch/x86/alderlaken/adln-metrics.json          |   85 +-
 .../perf/pmu-events/arch/x86/alderlaken/cache.json |  227 +-
 .../arch/x86/alderlaken/floating-point.json        |   17 +-
 .../pmu-events/arch/x86/alderlaken/memory.json     |   20 +
 .../perf/pmu-events/arch/x86/alderlaken/other.json |   81 +-
 .../pmu-events/arch/x86/alderlaken/pipeline.json   |   97 +-
 .../arch/x86/alderlaken/virtual-memory.json        |   30 +
 .../pmu-events/arch/x86/arrowlake/arl-metrics.json | 2749 ++++++++++++++++++++
 .../perf/pmu-events/arch/x86/arrowlake/cache.json  | 1491 +++++++++++
 .../arch/x86/arrowlake/floating-point.json         |  532 ++++
 .../pmu-events/arch/x86/arrowlake/frontend.json    |  609 +++++
 .../perf/pmu-events/arch/x86/arrowlake/memory.json |  387 +++
 .../arch/x86/arrowlake/metricgroups.json           |  150 ++
 .../perf/pmu-events/arch/x86/arrowlake/other.json  |  279 ++
 .../pmu-events/arch/x86/arrowlake/pipeline.json    | 2308 ++++++++++++++++
 .../arch/x86/arrowlake/uncore-cache.json           |   20 +
 .../arch/x86/arrowlake/uncore-interconnect.json    |   47 +
 .../arch/x86/arrowlake/uncore-memory.json          |  160 ++
 .../x86/{haswell => arrowlake}/uncore-other.json   |    2 +-
 .../arch/x86/arrowlake/virtual-memory.json         |  522 ++++
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json |  312 ++-
 .../perf/pmu-events/arch/x86/broadwell/cache.json  |   10 +-
 .../pmu-events/arch/x86/broadwell/frontend.json    |    4 +-
 .../perf/pmu-events/arch/x86/broadwell/memory.json |    8 +-
 .../arch/x86/broadwell/metricgroups.json           |    5 +
 .../pmu-events/arch/x86/broadwell/pipeline.json    |   10 +-
 .../arch/x86/broadwellde/bdwde-metrics.json        |  256 +-
 .../pmu-events/arch/x86/broadwellde/cache.json     |   10 +-
 .../pmu-events/arch/x86/broadwellde/frontend.json  |    4 +-
 .../pmu-events/arch/x86/broadwellde/memory.json    |    6 +-
 .../arch/x86/broadwellde/metricgroups.json         |    5 +
 .../pmu-events/arch/x86/broadwellde/pipeline.json  |   10 +-
 .../arch/x86/broadwellde/uncore-cache.json         |   28 +-
 .../arch/x86/broadwellde/uncore-interconnect.json  |   16 +-
 .../arch/x86/broadwellx/bdx-metrics.json           |  344 +--
 .../perf/pmu-events/arch/x86/broadwellx/cache.json |   10 +-
 .../pmu-events/arch/x86/broadwellx/frontend.json   |    4 +-
 .../pmu-events/arch/x86/broadwellx/memory.json     |    6 +-
 .../arch/x86/broadwellx/metricgroups.json          |    5 +
 .../pmu-events/arch/x86/broadwellx/pipeline.json   |   10 +-
 .../arch/x86/broadwellx/uncore-cache.json          |   28 +-
 .../arch/x86/broadwellx/uncore-interconnect.json   |   36 +-
 .../arch/x86/broadwellx/uncore-memory.json         |    1 +
 .../arch/x86/cascadelakex/clx-metrics.json         |  767 +++---
 .../arch/x86/cascadelakex/metricgroups.json        |    9 +-
 .../arch/x86/cascadelakex/uncore-cache.json        |   60 +-
 .../arch/x86/cascadelakex/uncore-interconnect.json |   11 -
 .../arch/x86/clearwaterforest/cache.json           |  144 +
 .../arch/x86/clearwaterforest/counter.json         |    7 +
 .../arch/x86/clearwaterforest/frontend.json        |   18 +
 .../arch/x86/clearwaterforest/memory.json          |   22 +
 .../arch/x86/clearwaterforest/other.json           |   22 +
 .../arch/x86/clearwaterforest/pipeline.json        |  113 +
 .../arch/x86/clearwaterforest/virtual-memory.json  |   29 +
 .../pmu-events/arch/x86/emeraldrapids/cache.json   |   28 +-
 .../arch/x86/emeraldrapids/emr-metrics.json        |  976 +++----
 .../arch/x86/emeraldrapids/frontend.json           |   19 -
 .../pmu-events/arch/x86/emeraldrapids/memory.json  |   15 +-
 .../arch/x86/emeraldrapids/metricgroups.json       |   10 +-
 .../arch/x86/emeraldrapids/pipeline.json           |   23 -
 .../arch/x86/emeraldrapids/uncore-io.json          |  218 +-
 .../arch/x86/grandridge/grr-metrics.json           |  284 +-
 .../pmu-events/arch/x86/grandridge/pipeline.json   |    3 +-
 .../arch/x86/grandridge/uncore-cache.json          |    4 +-
 .../arch/x86/grandridge/uncore-interconnect.json   |   60 +
 .../pmu-events/arch/x86/grandridge/uncore-io.json  |  214 +-
 .../arch/x86/grandridge/uncore-memory.json         |    2 +-
 .../pmu-events/arch/x86/graniterapids/cache.json   |  130 +-
 .../pmu-events/arch/x86/graniterapids/counter.json |   24 +-
 .../arch/x86/graniterapids/frontend.json           |   24 +-
 .../arch/x86/graniterapids/gnr-metrics.json        | 2325 +++++++++++++++++
 .../pmu-events/arch/x86/graniterapids/memory.json  |  121 +-
 .../arch/x86/graniterapids/metricgroups.json       |  145 ++
 .../pmu-events/arch/x86/graniterapids/other.json   |  109 +
 .../arch/x86/graniterapids/pipeline.json           |   40 +-
 .../arch/x86/graniterapids/uncore-cache.json       |   48 +-
 .../arch/x86/graniterapids/uncore-cxl.json         |    2 -
 .../x86/graniterapids/uncore-interconnect.json     |   87 +
 .../arch/x86/graniterapids/uncore-io.json          |  280 +-
 .../arch/x86/graniterapids/uncore-memory.json      |  122 +-
 .../arch/x86/graniterapids/uncore-power.json       |   98 +
 .../pmu-events/arch/x86/haswell/hsw-metrics.json   |  260 +-
 tools/perf/pmu-events/arch/x86/haswell/memory.json |    2 +-
 .../pmu-events/arch/x86/haswell/metricgroups.json  |    5 +
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |  296 ++-
 .../pmu-events/arch/x86/haswellx/metricgroups.json |    5 +
 .../pmu-events/arch/x86/haswellx/uncore-cache.json |   28 +-
 .../arch/x86/haswellx/uncore-interconnect.json     |   38 +-
 tools/perf/pmu-events/arch/x86/icelake/cache.json  |   34 +-
 .../perf/pmu-events/arch/x86/icelake/frontend.json |   17 -
 .../pmu-events/arch/x86/icelake/icl-metrics.json   |  849 +++---
 tools/perf/pmu-events/arch/x86/icelake/memory.json |   13 +-
 .../pmu-events/arch/x86/icelake/metricgroups.json  |   10 +-
 .../perf/pmu-events/arch/x86/icelake/pipeline.json |   30 +-
 .../arch/x86/icelake/uncore-interconnect.json      |   76 -
 .../pmu-events/arch/x86/icelake/uncore-other.json  |    2 +-
 .../arch/x86/icelake/virtual-memory.json           |   18 +
 tools/perf/pmu-events/arch/x86/icelakex/cache.json |   41 +-
 .../pmu-events/arch/x86/icelakex/frontend.json     |   17 -
 .../pmu-events/arch/x86/icelakex/icx-metrics.json  |  852 +++---
 .../perf/pmu-events/arch/x86/icelakex/memory.json  |   13 +-
 .../pmu-events/arch/x86/icelakex/metricgroups.json |   10 +-
 .../pmu-events/arch/x86/icelakex/pipeline.json     |   30 +-
 .../perf/pmu-events/arch/x86/lunarlake/cache.json  | 1352 +++++++++-
 .../arch/x86/lunarlake/floating-point.json         |  484 ++++
 .../pmu-events/arch/x86/lunarlake/frontend.json    |  654 ++++-
 .../pmu-events/arch/x86/lunarlake/lnl-metrics.json | 2730 +++++++++++++++++++
 .../perf/pmu-events/arch/x86/lunarlake/memory.json |  262 +-
 .../arch/x86/lunarlake/metricgroups.json           |  150 ++
 .../perf/pmu-events/arch/x86/lunarlake/other.json  |  496 +++-
 .../pmu-events/arch/x86/lunarlake/pipeline.json    | 2105 +++++++++++++--
 .../arch/x86/lunarlake/uncore-memory.json          |   36 +
 .../arch/x86/lunarlake/virtual-memory.json         |  428 +++
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   42 +-
 .../perf/pmu-events/arch/x86/meteorlake/cache.json |  109 +-
 .../pmu-events/arch/x86/meteorlake/frontend.json   |   30 +-
 .../pmu-events/arch/x86/meteorlake/memory.json     |   22 +-
 .../arch/x86/meteorlake/metricgroups.json          |   10 +-
 .../arch/x86/meteorlake/mtl-metrics.json           | 1048 +++++---
 .../perf/pmu-events/arch/x86/meteorlake/other.json |   54 +
 .../pmu-events/arch/x86/meteorlake/pipeline.json   |   89 +-
 .../arch/x86/meteorlake/uncore-other.json          |    2 +-
 .../perf/pmu-events/arch/x86/rocketlake/cache.json |   34 +-
 .../pmu-events/arch/x86/rocketlake/frontend.json   |   17 -
 .../pmu-events/arch/x86/rocketlake/memory.json     |   13 +-
 .../arch/x86/rocketlake/metricgroups.json          |   10 +-
 .../pmu-events/arch/x86/rocketlake/pipeline.json   |   30 +-
 .../arch/x86/rocketlake/rkl-metrics.json           |  849 +++---
 .../arch/x86/rocketlake/uncore-interconnect.json   |   10 -
 .../arch/x86/rocketlake/uncore-other.json          |    2 +-
 .../arch/x86/rocketlake/virtual-memory.json        |   18 +
 .../pmu-events/arch/x86/sapphirerapids/cache.json  |   30 +-
 .../arch/x86/sapphirerapids/frontend.json          |   19 -
 .../pmu-events/arch/x86/sapphirerapids/memory.json |   15 +-
 .../arch/x86/sapphirerapids/metricgroups.json      |   10 +-
 .../arch/x86/sapphirerapids/pipeline.json          |   23 -
 .../arch/x86/sapphirerapids/spr-metrics.json       |  908 ++++---
 .../arch/x86/sapphirerapids/uncore-io.json         |  138 +-
 .../pmu-events/arch/x86/sierraforest/cache.json    |  130 +-
 .../pmu-events/arch/x86/sierraforest/counter.json  |   24 +-
 .../pmu-events/arch/x86/sierraforest/frontend.json |    8 +
 .../pmu-events/arch/x86/sierraforest/other.json    |   20 +
 .../pmu-events/arch/x86/sierraforest/pipeline.json |   46 +-
 .../arch/x86/sierraforest/srf-metrics.json         |  308 +--
 .../arch/x86/sierraforest/uncore-cache.json        |   61 +-
 .../arch/x86/sierraforest/uncore-cxl.json          |    2 -
 .../arch/x86/sierraforest/uncore-interconnect.json |   87 +
 .../arch/x86/sierraforest/uncore-io.json           |  280 +-
 .../arch/x86/sierraforest/uncore-memory.json       |  122 +-
 .../arch/x86/sierraforest/uncore-power.json        |   98 +
 .../pmu-events/arch/x86/skylake/metricgroups.json  |    9 +-
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |  684 +++--
 .../pmu-events/arch/x86/skylakex/metricgroups.json |    9 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |  740 +++---
 .../pmu-events/arch/x86/skylakex/uncore-cache.json |   60 +-
 .../arch/x86/skylakex/uncore-interconnect.json     |   11 -
 .../perf/pmu-events/arch/x86/tigerlake/cache.json  |   45 +-
 .../pmu-events/arch/x86/tigerlake/frontend.json    |   17 -
 .../perf/pmu-events/arch/x86/tigerlake/memory.json |   13 +-
 .../arch/x86/tigerlake/metricgroups.json           |   10 +-
 .../pmu-events/arch/x86/tigerlake/pipeline.json    |   30 +-
 .../pmu-events/arch/x86/tigerlake/tgl-metrics.json |  745 +++---
 .../arch/x86/tigerlake/uncore-interconnect.json    |    4 +-
 .../arch/x86/tigerlake/uncore-other.json           |    2 +-
 .../arch/x86/tigerlake/virtual-memory.json         |   18 +
 tools/perf/pmu-events/empty-pmu-events.c           |    8 +-
 tools/perf/pmu-events/jevents.py                   |    8 +-
 tools/perf/python/tracepoint.py                    |   29 +-
 tools/perf/scripts/Build                           |   26 +
 tools/perf/scripts/Makefile.syscalls               |   61 -
 tools/perf/scripts/python/bin/flamegraph-report    |    2 +-
 tools/perf/scripts/syscalltbl.sh                   |   86 -
 tools/perf/tests/Build                             |   32 +-
 tools/perf/tests/code-reading.c                    |   12 +-
 tools/perf/tests/dso-data.c                        |   28 +-
 tools/perf/tests/dwarf-unwind.c                    |    6 +-
 tools/perf/tests/event_update.c                    |    1 +
 tools/perf/tests/hwmon_pmu.c                       |   16 +-
 tools/perf/tests/mmap-basic.c                      |    3 +
 tools/perf/tests/mmap-thread-lookup.c              |    4 +-
 tools/perf/tests/openat-syscall-tp-fields.c        |    4 +-
 tools/perf/tests/parse-no-sample-id-all.c          |    6 +-
 tools/perf/tests/perf-record.c                     |    2 +
 tools/perf/tests/perf-time-to-tsc.c                |    2 +
 tools/perf/tests/pmu.c                             |   85 +-
 tools/perf/tests/sample-parsing.c                  |   62 +-
 tools/perf/tests/shell/annotate.sh                 |   56 +-
 tools/perf/tests/shell/base_report/setup.sh        |   18 +-
 tools/perf/tests/shell/base_report/test_basic.sh   |   52 +
 .../shell/coresight/asm_pure_loop/asm_pure_loop.S  |    2 +
 tools/perf/tests/shell/diff.sh                     |   12 +-
 tools/perf/tests/shell/lib/attr.py                 |    8 +-
 .../perf/tests/shell/lib/perf_json_output_lint.py  |    7 +
 tools/perf/tests/shell/lib/stat_output.sh          |    8 +
 tools/perf/tests/shell/perftool-testsuite_probe.sh |    1 +
 tools/perf/tests/shell/probe_vfs_getname.sh        |    1 +
 .../tests/shell/record+probe_libc_inet_pton.sh     |    1 +
 .../tests/shell/record+script_probe_vfs_getname.sh |    1 +
 tools/perf/tests/shell/record.sh                   |   53 +-
 tools/perf/tests/shell/record_bpf_filter.sh        |    4 +-
 tools/perf/tests/shell/stat+csv_output.sh          |    2 +
 tools/perf/tests/shell/stat+json_output.sh         |    9 +
 tools/perf/tests/shell/stat+std_output.sh          |    8 +
 tools/perf/tests/shell/stat.sh                     |   83 +-
 tools/perf/tests/shell/stat_all_metrics.sh         |    8 +-
 tools/perf/tests/shell/stat_all_pmu.sh             |   48 +-
 tools/perf/tests/shell/test_data_symbol.sh         |   32 +-
 tools/perf/tests/shell/test_stat_intel_tpebs.sh    |   89 +-
 .../tests/shell/test_uprobe_from_different_cu.sh   |   11 +-
 tools/perf/tests/shell/trace+probe_vfs_getname.sh  |    1 +
 tools/perf/tests/shell/trace_btf_enum.sh           |    1 +
 tools/perf/tests/shell/trace_btf_general.sh        |    1 +
 tools/perf/tests/shell/trace_exit_race.sh          |    1 +
 tools/perf/tests/shell/trace_record_replay.sh      |   21 +
 tools/perf/tests/sw-clock.c                        |    3 +
 tools/perf/tests/switch-tracking.c                 |   14 +-
 tools/perf/tests/tool_pmu.c                        |    4 +-
 tools/perf/tests/workloads/datasym.c               |   34 +-
 tools/perf/trace/beauty/Build                      |    6 +-
 tools/perf/trace/beauty/syscalltbl.sh              |  274 ++
 tools/perf/ui/browsers/hists.c                     |   27 +-
 tools/perf/ui/hist.c                               |  117 +-
 tools/perf/ui/stdio/hist.c                         |    4 +
 tools/perf/util/Build                              |   32 +-
 tools/perf/util/addr_location.c                    |    1 +
 tools/perf/util/addr_location.h                    |    6 +-
 tools/perf/util/annotate-data.c                    |   49 +-
 tools/perf/util/annotate-data.h                    |   13 +
 tools/perf/util/annotate.c                         |  267 +-
 tools/perf/util/annotate.h                         |    9 +-
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  |   23 +-
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  |   11 +-
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     |   14 +-
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |   12 +-
 tools/perf/util/arm-spe.c                          |  167 +-
 .../perf/util/arm64-frame-pointer-unwind-support.c |   29 +-
 tools/perf/util/auxtrace.c                         |   15 +-
 tools/perf/util/bpf-filter.l                       |    2 +-
 tools/perf/util/bpf_ftrace.c                       |   14 +-
 tools/perf/util/bpf_lock_contention.c              |   85 +-
 tools/perf/util/bpf_skel/func_latency.bpf.c        |   28 +-
 tools/perf/util/bpf_skel/kwork_trace.bpf.c         |    2 +-
 tools/perf/util/bpf_skel/lock_contention.bpf.c     |  245 +-
 tools/perf/util/bpf_skel/lock_data.h               |    7 +
 tools/perf/util/branch.h                           |    3 +-
 tools/perf/util/callchain.c                        |   10 +-
 tools/perf/util/color.h                            |    5 -
 tools/perf/util/color_config.c                     |   11 -
 tools/perf/util/comm.c                             |    2 +
 tools/perf/util/compress.h                         |   20 +
 tools/perf/util/config.c                           |    6 -
 tools/perf/util/config.h                           |    1 -
 tools/perf/util/cpumap.c                           |   70 +-
 tools/perf/util/cs-etm.c                           |   31 +-
 tools/perf/util/data.c                             |   20 -
 tools/perf/util/data.h                             |    1 -
 tools/perf/util/debug.c                            |    2 +-
 tools/perf/util/debuginfo.c                        |    6 +-
 tools/perf/util/disasm.c                           |   27 +-
 tools/perf/util/dso.c                              |  166 +-
 tools/perf/util/dso.h                              |   82 +-
 tools/perf/util/env.c                              |    2 +-
 tools/perf/util/event.c                            |   11 +
 tools/perf/util/event.h                            |   12 +-
 tools/perf/util/events_stats.h                     |    2 +
 tools/perf/util/evlist.c                           |   32 +-
 tools/perf/util/evlist.h                           |    1 +
 tools/perf/util/evsel.c                            |   51 +-
 tools/perf/util/evsel.h                            |    2 +
 tools/perf/util/expr.c                             |    2 +
 tools/perf/util/ftrace.h                           |    2 +
 tools/perf/util/header.c                           |   33 +-
 tools/perf/util/hist.c                             |  108 +-
 tools/perf/util/hist.h                             |   32 +-
 tools/perf/util/hwmon_pmu.c                        |   56 +-
 tools/perf/util/hwmon_pmu.h                        |   16 +
 tools/perf/util/intel-bts.c                        |    4 +-
 tools/perf/util/intel-pt.c                         |  136 +-
 tools/perf/util/intel-tpebs.c                      |    2 +-
 tools/perf/util/jitdump.c                          |   10 +-
 tools/perf/util/lock-contention.h                  |    7 +
 tools/perf/util/lzma.c                             |   29 +-
 tools/perf/util/machine.c                          |   92 +-
 tools/perf/util/machine.h                          |    8 +-
 tools/perf/util/maps.c                             |   58 +-
 tools/perf/util/mem-events.c                       |   74 +-
 tools/perf/util/mem-events.h                       |    3 +-
 tools/perf/util/mmap.c                             |   15 +-
 tools/perf/util/mmap.h                             |    3 -
 tools/perf/util/mutex.h                            |    8 +
 tools/perf/util/parse-events.c                     |  179 +-
 tools/perf/util/parse-events.l                     |   51 +-
 tools/perf/util/perf_event_attr_fprintf.c          |  124 +-
 tools/perf/util/pmu.c                              |  315 ++-
 tools/perf/util/pmu.h                              |   12 +-
 tools/perf/util/pmus.c                             |  202 +-
 tools/perf/util/pmus.h                             |    1 -
 tools/perf/util/probe-finder.c                     |   21 +-
 tools/perf/util/probe-finder.h                     |    1 +
 tools/perf/util/pstack.c                           |   14 -
 tools/perf/util/pstack.h                           |    1 -
 tools/perf/util/python.c                           |  160 +-
 tools/perf/util/rb_resort.h                        |  146 --
 tools/perf/util/s390-cpumsf.c                      |    6 +-
 tools/perf/util/sample.c                           |   43 +
 tools/perf/util/sample.h                           |   11 +-
 .../util/scripting-engines/trace-event-python.c    |   29 +-
 tools/perf/util/session.c                          |  106 +-
 tools/perf/util/session.h                          |    1 +
 tools/perf/util/setup.py                           |   10 +-
 tools/perf/util/sort.c                             |  152 +-
 tools/perf/util/sort.h                             |    3 +-
 tools/perf/util/stat-display.c                     |  111 +-
 tools/perf/util/stat-shadow.c                      |    3 +-
 tools/perf/util/stat.c                             |   13 +-
 tools/perf/util/symbol-elf.c                       |  133 +-
 tools/perf/util/symbol.c                           |   36 +
 tools/perf/util/symbol_conf.h                      |    8 +-
 tools/perf/util/synthetic-events.c                 |   46 +-
 tools/perf/util/syscalltbl.c                       |  148 +-
 tools/perf/util/syscalltbl.h                       |   22 +-
 tools/perf/util/thread.c                           |   80 +
 tools/perf/util/thread.h                           |   14 +-
 tools/perf/util/tool_pmu.c                         |   35 +-
 tools/perf/util/tool_pmu.h                         |    2 +-
 tools/perf/util/trace-event-scripting.c            |  116 +-
 tools/perf/util/trace-event.h                      |    2 +
 tools/perf/util/units.c                            |    2 +-
 tools/perf/util/unwind-libdw.c                     |    9 +-
 tools/perf/util/unwind-libunwind-local.c           |   28 +-
 519 files changed, 39386 insertions(+), 9914 deletions(-)
 create mode 100644 tools/lib/api/io_dir.h
 create mode 100644 tools/perf/Documentation/cpu-and-latency-overheads.txt
 delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/alpha/include/syscall_table.h
 delete mode 100644 tools/perf/arch/arc/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/arc/include/syscall_table.h
 delete mode 100644 tools/perf/arch/arm/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/arm/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/arm/include/syscall_table.h
 delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/arm64/include/syscall_table.h
 delete mode 100644 tools/perf/arch/csky/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/csky/include/syscall_table.h
 delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/loongarch/include/syscall_table.h
 delete mode 100644 tools/perf/arch/mips/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/mips/include/syscall_table.h
 delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/parisc/include/syscall_table.h
 delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/powerpc/include/syscall_table.h
 delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/riscv/include/syscall_table.h
 delete mode 100644 tools/perf/arch/s390/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/s390/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/s390/include/syscall_table.h
 delete mode 100644 tools/perf/arch/sh/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/sh/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/sh/include/syscall_table.h
 delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/sparc/include/syscall_table.h
 delete mode 100644 tools/perf/arch/x86/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/x86/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/x86/include/syscall_table.h
 delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Kbuild
 delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/xtensa/include/syscall_table.h
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/fp_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/general.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/l1d_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/l1i_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/l2_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/l3_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/ll_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/retired.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/spe.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/spec_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/stall.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/sve.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/tlb.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/trace.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/brbe.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/fp_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/general.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/l1d_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/l1i_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/l2_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/ll_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/retired.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/spe.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/spec_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/stall.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/sve.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/tlb.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/cycle-and-instruction-count.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/firmware.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/instruction.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/microarch.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/watchpoint.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/cycle-and-instruction-count.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/firmware.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/instruction.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/microarch.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/watchpoint.json
 rename tools/perf/pmu-events/arch/riscv/sifive/{u74 => bullet}/firmware.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/microarch.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/firmware.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p550/memory.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/microarch.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/cycle-and-instruction-count.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/firmware.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p650/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p650/microarch.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/watchpoint.json
 delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/instructions.json
 delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json
 delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/arl-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/uncore-memory.json
 rename tools/perf/pmu-events/arch/x86/{haswell => arrowlake}/uncore-other.json (90%)
 create mode 100644 tools/perf/pmu-events/arch/x86/arrowlake/virtual-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/virtual-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/gnr-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/lnl-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/uncore-memory.json
 delete mode 100644 tools/perf/scripts/Makefile.syscalls
 delete mode 100755 tools/perf/scripts/syscalltbl.sh
 create mode 100755 tools/perf/tests/shell/trace_record_replay.sh
 create mode 100755 tools/perf/trace/beauty/syscalltbl.sh
 delete mode 100644 tools/perf/util/rb_resort.h
 create mode 100644 tools/perf/util/sample.c
