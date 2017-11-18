From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/83] perf/core improvements and fixes
Date: Sat, 18 Nov 2017 09:06:01 +0100
Message-ID: <20171118080601.edexrazr2qddpzio@gmail.com>
References: <20171117201601.24110-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37589 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163011AbdKRIGG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 18 Nov 2017 03:06:06 -0500
Content-Disposition: inline
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Andrei Vagin <avagin@openvz.org>, Bram Stolk <b.stolk@gmail.com>, David Ahern <dsahern@gmail.com>, Donald Stence <dstence@us.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@intel.com>, kernel-team@lge.com, Kim Phillips <kim.phillips@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>, Pet


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 7862edc4191123f9c7e7ec0a7b356d332a61c41e:
> 
>   Merge remote-tracking branch 'torvalds/master' into perf/core (2017-11-13 09:39:12 -0300)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.15-20171117
> 
> for you to fetch changes up to 05d3f1a1d5a3d37ca4b591d5524f5a5b159d0564:
> 
>   perf tools: Move symbol__calc_percent() call to outside symbol__disassemble() (2017-11-17 12:16:26 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Optimize sample parsing for ordering events, where we don't need to parse
>   all the PERF_SAMPLE_ bits, just the ones leading to the timestamp needed
>   to reorder events (Jiri Olsa)
> 
> - Use a dummy event to ask for PERF_RECORD_{MMAP,COMM,EXEC} with
>   'perf record --delay', when the events asked by the user will only be
>   enabled after the workload is started and the requested delay passes,
>   so we need to add the dummy event and have it .enabled_on_exec. This
>   then allows us to resolve symbols for the DSO executable MMAPs setup
>   while we wait for the delay (Arnaldo Carvalho de Melo)
> 
> - Synchronize kcmp.h and prctl.h ABI headers wrt SPDX tags (Arnaldo Carvalho de Melo)
> 
> - Generalize the annotation code to support other source information
>   besides objdump/DWARF obtained ones, starting with python scripts,
>   that will is slated to be merged soon (Jiri Olsa)
> 
> - Advance the source code lines to right after the column with the
>   address in asm lines (Jiri Olsa)
> 
> - Fix terminal dimensions resizing signal handling in 'perf top --stdio' (Jiri Olsa)
> 
> - Improve error messages for PMU events (Kim Phillips)
> 
> - Fix 'perf record' -c/-F options for cpu event aliases (Andi Kleen)
> 
> - Enable type checking for perf_evsel_config_term types (Andi Kleen)
> 
> - Call machine__exit() at 'perf trace' exit, so as to remove temporary
>   files related to VDSO (Andrei Vagin)
> 
> - Add "reject" option to parse-events.l, fixing the build with newer
>   flex releases. Noticed with flex 2.6.4 on Alpine Linux 3.6 and Edge (Jiri Olsa)
> 
> - Document some missing perf.data headers (Andi Kleen)
> 
> - Allow printing period for non freq mod groups (Andi Kleen)
> 
> - Do not warn the user about kernel.kptr_restrict when not sampling the
>   kernel (Arnaldo Carvalho de Melo)
> 
> - Fix bug in 'perf help' introduced during conversion to strstart() (Namhyung Kim)
> 
> - Do not truncate ASM instruction mnemonics at 6 characters in the annotation
>   output, PowerPC has long ones (Ravi Bangoria)
> 
> - Document some missing command line options (Sihyeon Jang)
> 
> - Update POWER9 vendor event tables (Sukadev Bhattiprolu)
> 
> - Fix 'perf test' shell entries on s390x, where the 'openat' syscall
>   is used instead of 'open' in one of the tests and
> 
> - No need to use overwrite mmap mode in 'perf test', those tests
>   do not generate massive amount of events to fill the ring buffer (Wang Nan)
> 
> - Add missing command line options (mostly --force/-f) to the man pages (Sihyeon Jang)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andi Kleen (4):
>       perf record: Fix -c/-F options for cpu event aliases
>       perf evsel: Enable type checking for perf_evsel_config_term types
>       perf tools: Document some missing perf.data headers
>       perf script: Allow printing period for non freq mode groups
> 
> Andrei Vagin (1):
>       perf trace: Fix an exit code of trace__symbols_init
> 
> Arnaldo Carvalho de Melo (10):
>       perf evlist: Set the correct idx when adding dummy events
>       perf record: Generate PERF_RECORD_{MMAP,COMM,EXEC} with --delay
>       tools headers: Synchronize kernel ABI headers wrt SPDX tags
>       perf evsel: Fix up leftover perf_evsel_stat usage via evsel->priv
>       perf script: Fix --per-event-dump for auxtrace synth evsels
>       perf machine: Guard against NULL in machine__exit()
>       perf evlist: Add helper to check if attr.exclude_kernel is set in all evsels
>       perf report: Ignore kptr_restrict when not sampling the kernel
>       perf record: Ignore kptr_restrict when not sampling the kernel
>       perf top: Ignore kptr_restrict when not sampling the kernel
> 
> Jiri Olsa (46):
>       perf annotate: Add annotation_line struct
>       perf annotate: Move line/offset into annotation_line struct
>       perf annotate: Move ipc/cycles into annotation_line struct
>       perf annotate: Add symbol__annotate function
>       perf annotate: Add struct annotate_args
>       perf annotate: Add arch into struct annotate_args
>       perf annotate: Add map into struct annotate_args
>       perf annotate: Add offset/line/line_nr into struct annotate_args
>       perf annotate: Add evsel into struct annotation_line_args
>       perf annotate: Add annotation_line__next function
>       perf annotate: Add annotation_line__add function
>       perf annotate: Move rb_node to struct annotation_line
>       perf annotate: Add annotation_line__(new|delete) functions
>       perf annotate: Add annotated_source__purge function
>       perf annotate: Add samples into struct annotation_line
>       perf annotate: Add symbol__calc_percent function
>       perf annotate: Add symbol__calc_lines function
>       perf annotate: Remove disasm__calc_percent() from disasm_line__print()
>       perf annotate: Remove disasm__calc_percent() from annotate_browser__calc_percent()
>       perf annotate: Remove disasm__calc_percent function
>       perf annotate: Remove struct source_line
>       perf annotate: Add annotation_line__print function
>       perf annotate: Factor annotation_line__print from disasm_line__print
>       perf annotate browser: Use samples data from struct annotation_line
>       perf annotate browser: Do not pass nr_events in disasm_rb_tree__insert
>       perf annotate browser: Rename struct browser_disasm_line to browser_line
>       perf annotate browser: Rename disasm_line__browser to browser_line
>       perf annotate browser: Change selection to struct annotation_line
>       perf annotate browser: Change offsets to struct annotation_line
>       perf annotate browser: Use struct annotation_line in browser_line
>       perf annotate browser: Use struct annotation_line in find functions
>       perf annotate browser: Use struct annotation_line in browser top
>       perf annotate browser: Add disasm_line__write function
>       perf annotate: Align source and offset lines
>       perf tools: Use shell function for perl cflags retrieval
>       perf: Fix header.size for namespace events
>       perf callchain: Reset cursor arg instead of callchain_cursor
>       perf evsel: Centralize perf_sample initialization
>       perf evlist: Add perf_evlist__parse_sample_timestamp function
>       perf ordered_events: Pass timestamp arg in perf_session__queue_event
>       perf tools: Optimize sample parsing for ordered events
>       perf top: Fix window dimensions change handling
>       perf top: Use signal interface for SIGWINCH handler
>       perf top: Fix crash when annotating symbol
>       perf tools: Change (symbol|annotation)__calc_percent return type to void
>       perf tools: Move symbol__calc_percent() call to outside symbol__disassemble()
> 
> Kim Phillips (2):
>       perf c2c: Fix spelling mistakes in browser help text
>       perf evsel: Say which PMU Hardware event doesn't support sampling/overflow-interrupts
> 
> Namhyung Kim (1):
>       perf help: Fix a bug during strstart() conversion
> 
> Ravi Bangoria (1):
>       perf annotate: Do not truncate instruction names at 6 chars
> 
> Seonghyun Park (1):
>       perf tests: Add missing WRITE_ASS for new fields of perf_event_attr
> 
> Sihyeon Jang (9):
>       perf top: Document missing options
>       perf top: Remove a duplicate word
>       perf lock: Document missing options
>       perf inject: Document missing options
>       perf trace: Document missing option, colons
>       perf timechart: Document missing --force option
>       perf sched: Document missing --force option
>       perf evlist: Document missing --force option
>       perf buildid-cache: Document missing --force option
> 
> Sukadev Bhattiprolu (1):
>       perf vendor events powerpc: Update POWER9 events
> 
> Thomas Richter (2):
>       perf test shell: Fix check open filename arg using 'perf trace' on s390x
>       perf test shell: Fix test case probe libc's inet_pton on s390x
> 
> Thomas-Mich Richter (1):
>       perf buildid-cache: Update help text for purge command
> 
> Wang Nan (4):
>       perf tests: Set evlist of test__backward_ring_buffer() to !overwrite
>       perf tests: Set evlist of test__sw_clock_freq() to !overwrite
>       perf tests: Set evlist of test__basic_mmap() to !overwrite
>       perf tests: Set evlist of test__task_exit() to !overwrite
> 
>  kernel/events/core.c                               |   5 +-
>  tools/include/uapi/linux/kcmp.h                    |   1 +
>  tools/include/uapi/linux/prctl.h                   |   1 +
>  tools/perf/Documentation/perf-buildid-cache.txt    |   3 +
>  tools/perf/Documentation/perf-evlist.txt           |   4 +
>  tools/perf/Documentation/perf-inject.txt           |   4 +
>  tools/perf/Documentation/perf-lock.txt             |   4 +
>  tools/perf/Documentation/perf-sched.txt            |   4 +
>  tools/perf/Documentation/perf-timechart.txt        |   4 +-
>  tools/perf/Documentation/perf-top.txt              |   6 +
>  tools/perf/Documentation/perf-trace.txt            |  16 +-
>  tools/perf/Documentation/perf.data-file-format.txt |  23 +
>  tools/perf/Makefile.config                         |   2 +-
>  tools/perf/builtin-buildid-cache.c                 |   4 +-
>  tools/perf/builtin-c2c.c                           |   8 +-
>  tools/perf/builtin-help.c                          |   4 +-
>  tools/perf/builtin-kvm.c                           |   8 +-
>  tools/perf/builtin-record.c                        |  42 +-
>  tools/perf/builtin-report.c                        |   3 +
>  tools/perf/builtin-script.c                        |  36 +-
>  tools/perf/builtin-top.c                           |  44 +-
>  tools/perf/builtin-trace.c                         |   6 +-
>  .../perf/pmu-events/arch/powerpc/power9/cache.json |   5 -
>  .../pmu-events/arch/powerpc/power9/frontend.json   |   7 +-
>  .../pmu-events/arch/powerpc/power9/marked.json     |  27 +-
>  .../perf/pmu-events/arch/powerpc/power9/other.json | 276 +++------
>  .../pmu-events/arch/powerpc/power9/pipeline.json   |  14 +-
>  tools/perf/pmu-events/arch/powerpc/power9/pmc.json |   2 +-
>  .../arch/powerpc/power9/translation.json           |   5 -
>  tools/perf/tests/attr.c                            |   6 +
>  tools/perf/tests/backward-ring-buffer.c            |   2 +-
>  tools/perf/tests/mmap-basic.c                      |   2 +-
>  .../perf/tests/shell/trace+probe_libc_inet_pton.sh |   7 +-
>  tools/perf/tests/shell/trace+probe_vfs_getname.sh  |   6 +-
>  tools/perf/tests/sw-clock.c                        |   2 +-
>  tools/perf/tests/task-exit.c                       |   2 +-
>  tools/perf/ui/browsers/annotate.c                  | 401 +++++++------
>  tools/perf/ui/gtk/annotate.c                       |  25 +-
>  tools/perf/util/annotate.c                         | 651 +++++++++++----------
>  tools/perf/util/annotate.h                         |  76 +--
>  tools/perf/util/evlist.c                           |  25 +-
>  tools/perf/util/evlist.h                           |   6 +
>  tools/perf/util/evsel.c                            |  92 ++-
>  tools/perf/util/evsel.h                            |  10 +-
>  tools/perf/util/machine.c                          |   5 +-
>  tools/perf/util/ordered-events.c                   |   3 +-
>  tools/perf/util/ordered-events.h                   |   2 +-
>  tools/perf/util/parse-events.c                     |   2 +
>  tools/perf/util/parse-events.h                     |   3 +
>  tools/perf/util/pmu.c                              |   5 +
>  tools/perf/util/session.c                          |  45 +-
>  tools/perf/util/session.h                          |   2 +-
>  52 files changed, 1028 insertions(+), 920 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
