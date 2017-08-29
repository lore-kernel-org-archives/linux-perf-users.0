From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/18] perf/core improvements and fixes
Date: Tue, 29 Aug 2017 23:15:21 +0200
Message-ID: <20170829211521.qy37lwoavnliznjw@gmail.com>
References: <20170829194254.1338-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36476 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbdH2VP0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Aug 2017 17:15:26 -0400
Content-Disposition: inline
In-Reply-To: <20170829194254.1338-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexis Berlemont <alexis.berlemont@gmail.com>, Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>, Dave Hansen <dave.hansen@linux.intel.com>, David Ahern <dsahern@gmail.com>, David Carrillo-Cisneros <davidcc@google.com>, David Tolnay <dtolnay@gmail.com>, Hanjun Guo <guohanjun@huawei.com>, Hemant Kumar <hemant@linux.vnet.ibm.com>, Jack Henschel <jackdev@mailbox.org>, Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>, Jiri Olsa <jolsa@kernel.org>, Joe Mario <jmario@redhat.com>, Li Bin <huawei.libin@huawei.com>Ma


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit b00233b5306512a09e339d69ef5e390a77f2d302:
> 
>   perf/x86: Export some PMU attributes in caps/ directory (2017-08-25 11:04:20 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.14-20170829
> 
> for you to fetch changes up to b2f7605076d6cdd68162c42c34caadafbbe4c69f:
> 
>   perf symbols: Fix plt entry calculation for ARM and AARCH64 (2017-08-29 11:41:27 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> - Fix remote HITM detection for Skylake in 'perf c2c' (Jiri Olsa)
> 
> - Fixes for the handling of PERF_RECORD_READ records (Jiri Olsa)
> 
> - Fix kprobes blackist symbol lookup in 'perf probe' (Li Bin)
> 
> - The PLT header and entry sizes are not the same in !x86, fix it for ARM and
>   AARCH64 (Li Bin)
> 
> - Beautify pkey_{alloc,free,mprotect} arguments in 'perf trace' (Arnaldo Carvalho de Melo)
> 
> - Fix CC, AR, LD external definition, allow flex and bison to be
>   externally defined and other related Makefile fixes (David Carrillo-Cisneros)
> 
> - Sync cpu features kernel ABI headers with tooling headers (Arnaldo Carvalho de Melo)
> 
> - Fix path to PMU formats in 'perf stat' documentation (Jack Henschel)
> 
> - Fix static build with newer toolchains (Jiri Olsa)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (2):
>       tools headers: Sync cpu features kernel ABI headers with tooling headers
>       perf trace beauty: Beautify pkey_{alloc,free,mprotect} arguments
> 
> David Carrillo-Cisneros (5):
>       tools build tests: Don't hardcode gcc name
>       perf tools: Allow external definition of flex and bison binary names
>       tools lib: Allow external definition of CC, AR and LD
>       perf tools: Robustify detection of clang binary
>       perf tools: Pass full path of FEATURES_DUMP
> 
> Jack Henschel (1):
>       perf stat: Fix path to PMU formats in documentation
> 
> Jiri Olsa (8):
>       perf tools: Fix static build with newer toolchains
>       perf c2c: Fix remote HITM detection for Skylake
>       perf record: Set read_format for inherit_stat
>       perf report: Add dump_read function
>       perf values: Fix thread index bug
>       perf values: Fix allocation check
>       perf values: Zero value buffers
>       perf report: Group stat values on global event id
> 
> Li Bin (2):
>       perf probe: Fix kprobe blacklist checking condition
>       perf symbols: Fix plt entry calculation for ARM and AARCH64
> 
>  tools/arch/x86/include/asm/cpufeatures.h           |  5 +--
>  tools/arch/x86/include/asm/disabled-features.h     |  4 +-
>  tools/build/tests/ex/Makefile                      |  2 +-
>  tools/lib/api/Makefile                             |  8 ++--
>  tools/lib/subcmd/Makefile                          |  2 +-
>  tools/perf/Documentation/perf-stat.txt             |  4 +-
>  tools/perf/Makefile.config                         |  4 +-
>  tools/perf/Makefile.perf                           | 26 ++++++++---
>  tools/perf/builtin-report.c                        |  6 +--
>  tools/perf/builtin-trace.c                         |  8 ++++
>  tools/perf/trace/beauty/Build                      |  1 +
>  tools/perf/trace/beauty/beauty.h                   |  3 ++
>  tools/perf/trace/beauty/pkey_alloc.c               | 50 ++++++++++++++++++++++
>  .../perf/trace/beauty/pkey_alloc_access_rights.sh  | 10 +++++
>  tools/perf/util/evsel.c                            |  7 ++-
>  tools/perf/util/intel-pt-decoder/Build             |  2 +-
>  tools/perf/util/mem-events.c                       | 11 ++++-
>  tools/perf/util/probe-event.c                      |  2 +-
>  tools/perf/util/session.c                          | 25 +++++++++++
>  tools/perf/util/symbol-elf.c                       | 27 +++++++++---
>  tools/perf/util/values.c                           | 17 +++++---
>  tools/scripts/Makefile.include                     |  4 +-
>  22 files changed, 185 insertions(+), 43 deletions(-)
>  create mode 100644 tools/perf/trace/beauty/pkey_alloc.c
>  create mode 100755 tools/perf/trace/beauty/pkey_alloc_access_rights.sh

Pulled, thanks a lot Arnaldo!

	Ingo
