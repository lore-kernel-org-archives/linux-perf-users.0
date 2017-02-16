From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/14] perf/core clang fixes
Date: Thu, 16 Feb 2017 20:54:06 +0100
Message-ID: <20170216195406.GA2010@gmail.com>
References: <20170215190424.18687-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36088 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932344AbdBPTyM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Feb 2017 14:54:12 -0500
Content-Disposition: inline
In-Reply-To: <20170215190424.18687-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Davidlohr Bueso <dbueso@suse.de>, Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>, Jakub Jelen <jjelen@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Here is a bunch of changes to allow buildint tools/perf/ with CC=clang,
> there are a few more to allow building the python code, but I already manage to
> finish the build without it.
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 277d6f1dcae09aed63cd4c7900a280b0e18cf2ca:
> 
>   Merge tag 'perf-core-for-mingo-4.11-20170213' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-02-14 07:29:38 +0100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.11-20170215
> 
> for you to fetch changes up to 34a0548f01626b01c9e98d9627812c3c9f6b6f7d:
> 
>   perf tools: Add missing parse_events_error() prototype (2017-02-15 11:20:49 -0300)
> 
> ----------------------------------------------------------------
> perf/core clang fixes:
> 
> Changes to make tools/{perf,lib/{bpf,traceevent,api}} build with
> CC=clang, to, for instance, take advantage of warnings (Arnaldo Carvalho de Melo):
> 
> - Conditionally request some warning options not available on clang
> 
> - Set the maximum optimization level to -O3 when using CC=clang, leave
>   the previous setting of -O6 otherwise.
> 
> - Make it an error to pass a signed value to OPTION_UINTEGER, so that
>   we can remove abs(unsigned int) calls in 'perf bench futex'.
> 
> - Make sure dprintf() is not defined before using that name in 'perf bench numa'
> 
> - Avoid using field after variable sized type, its a GNU extension, use
>   equivalent code.
> 
> - Fix some bugs where some variables could be used unitialized,
>   something not caught by gcc.
> 
> - Fix some spots where we were testing struct->array[] members against
>   NULL, it will always evaluate to 'true'.
> 
> - Add missing parse_events_error() prototype in the bison file.
> 
> There are still one problem when trying to build the python support, but
> this are the 'size' outputs for 'make -C tools/perf NO_LIBPYTHON' for
> gcc and clang builds:
> 
>   DW_AT_producer: clang version 4.0.0 (http://llvm.org/git/clang.git f5be8ba13adc4ba1011a7ccd60c844bd60427c1c) (ht
> 
>   $ size ~/bin/perf
>      text    data     bss     dec     hex     filename
>   3447514  831320 23901696  28180530  1ae0032 /home/acme/bin/perf
> 
>   DW_AT_producer: GNU C99 6.3.1 20161221 (Red Hat 6.3.1-1) -mtune=generic -march=x86-64 -ggdb3 -O6 -std=gnu99
> +-fno-omit-frame-pointer -funwind-tables -fstack-protector-all
> 
>   $ size ~/bin/perf
>      text    data     bss     dec     hex     filename
>   3671662  836480 23902752  28410894  1b1840e /home/acme/bin/perf
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (14):
>       tools: Suppress request for warning options not existent in clang
>       tools: Set the maximum optimization level according to the compiler being used
>       tools lib subcmd: Make it an error to pass a signed value to OPTION_UINTEGER
>       Revert "perf bench futex: Sanitize numeric parameters"
>       perf bench numa: Make sure dprintf() is not defined
>       perf tests: Synthesize struct instead of using field after variable sized type
>       perf record: Do not put a variable sized type not at the end of a struct
>       perf tools: Do not put a variable sized type not at the end of a struct
>       perf probe: Avoid accessing uninitialized 'map' variable
>       perf evsel: Do not put a variable sized type not at the end of a struct
>       perf intel pt decoder: clang has no -Wno-override-init
>       perf tools: Be consistent on the type of map->symbols[] interator
>       perf pmu: Fix check for unset alias->unit array
>       perf tools: Add missing parse_events_error() prototype
> 
>  tools/lib/api/Makefile                    |  8 +++-
>  tools/lib/subcmd/Makefile                 |  8 +++-
>  tools/lib/subcmd/parse-options.c          |  4 ++
>  tools/perf/Makefile.config                |  4 ++
>  tools/perf/bench/futex-hash.c             |  4 --
>  tools/perf/bench/futex-lock-pi.c          |  3 --
>  tools/perf/bench/futex-requeue.c          |  2 -
>  tools/perf/bench/futex-wake-parallel.c    |  4 --
>  tools/perf/bench/futex-wake.c             |  3 --
>  tools/perf/bench/futex.h                  |  4 --
>  tools/perf/bench/numa.c                   |  1 +
>  tools/perf/builtin-record.c               | 17 +++++----
>  tools/perf/tests/parse-no-sample-id-all.c | 19 ++++------
>  tools/perf/util/evsel.c                   | 62 ++++++++++++++-----------------
>  tools/perf/util/intel-pt-decoder/Build    |  6 ++-
>  tools/perf/util/machine.c                 |  4 +-
>  tools/perf/util/parse-events.c            | 15 +++-----
>  tools/perf/util/parse-events.y            |  2 +
>  tools/perf/util/pmu.c                     |  4 +-
>  tools/perf/util/probe-event.c             |  2 +-
>  tools/perf/util/session.c                 |  2 +-
>  tools/scripts/Makefile.include            |  5 ++-
>  22 files changed, 91 insertions(+), 92 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
