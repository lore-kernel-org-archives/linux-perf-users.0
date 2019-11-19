From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Date: Tue, 19 Nov 2019 13:00:34 +0100
Message-ID: <20191119120034.GA124098@gmail.com>
References: <20191119113245.19593-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191119113245.19593-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>, James Clark <james.clark@arm.com>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Masami Hiramatsu <mhiramat@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> 
> The following changes since commit e1e9b78d3957a267346a86c8f2c433f6a332af65:
> 
>   perf parse: Use YYABORT to clear stack after failure, plugging leaks (2019-11-12 08:34:16 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.5-20191119
> 
> for you to fetch changes up to a910e4666d61712840c78de33cc7f89de8affa78:
> 
>   perf parse: Report initial event parsing error (2019-11-18 19:14:29 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> x86/insn:
> 
>   Adrian Hunter:
> 
>   - Add some more Intel instructions to the opcode map:
> 
>         cldemote, encls, enclu, enclv, enqcmd, enqcmds, movdir64b,
>         movdiri, pconfig, tpause, umonitor, umwait, wbnoinvd.
> 
>   - The instruction decoding can be tested using the perf tools'
>     "x86 instruction decoder - new instructions" test as folllows:
> 
>     $ perf test -v "new " 2>&1 | grep -i cldemote
>     Decoded ok: 0f 1c 00                    cldemote (%eax)
>     Decoded ok: 0f 1c 05 78 56 34 12        cldemote 0x12345678
>     Decoded ok: 0f 1c 84 c8 78 56 34 12     cldemote 0x12345678(%eax,%ecx,8)
>     Decoded ok: 0f 1c 00                    cldemote (%rax)
>     Decoded ok: 41 0f 1c 00                 cldemote (%r8)
>     Decoded ok: 0f 1c 04 25 78 56 34 12     cldemote 0x12345678
>     Decoded ok: 0f 1c 84 c8 78 56 34 12     cldemote 0x12345678(%rax,%rcx,8)
>     Decoded ok: 41 0f 1c 84 c8 78 56 34 12  cldemote 0x12345678(%r8,%rcx,8)
>     $ perf test -v "new " 2>&1 | grep -i tpause
>     Decoded ok: 66 0f ae f3                 tpause %ebx
>     Decoded ok: 66 0f ae f3                 tpause %ebx
>     Decoded ok: 66 41 0f ae f0              tpause %r8d
> 
> callchains:
> 
>   Adrian Hunter:
> 
>   - Fix segfault in thread__resolve_callchain_sample().
> 
> perf probe:
> 
>   - Line fixes to show only lines where probes can be used with 'perf probe -L',
>     and when reporting them via 'perf probe -l'.
> 
>   - Support multiprobe events.
> 
> perf scripts python:
> 
>   Adrian Hunter:
> 
>   - Fix use of TRUE with SQLite < 3.23 in exported-sql-viewer.py.
> 
> perf maps:
> 
>   - Trim 'struct map' by removing the rb_node member for sorting
>     by map name, as that is only needed for processing kernel maps,
>     and only when classifying symbols by section at load time.
>     Sort them by name using qsort() and do lookups using bsearch()
>     when map_groups__find_by_name() is used.
> 
> perf parse:
> 
>   Ian Rogers:
> 
>   - Report initial event parsing error, providing a less cryptic message
>     to state that a PMU wasn't found in the system.
> 
> perf vendor events:
> 
>   James Clark:
> 
>   - Fix commas so that PMU event files for arm64, power8 and power nine
>     become valid JSON.
> 
> libtraceevent:
> 
>   Konstantin Khlebnikov:
> 
>   - Fix parsing of event %o and %X argument types.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------

>  66 files changed, 2888 insertions(+), 2366 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
