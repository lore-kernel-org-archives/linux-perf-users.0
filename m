From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v14 1/1] perf tools: add support for libpfm4
Date: Fri, 29 May 2020 11:06:28 -0700
Message-ID: <CAP-5=fX5rqFiEiDcWVOdzY68AX=-ZjDL1WgeUC+7TdvT6Yi+hA@mail.gmail.com>
References: <20200505182943.218248-1-irogers@google.com> <20200505182943.218248-2-irogers@google.com>
 <CAP-5=fWn1=DtZyfGtYEFd=-zDY1O+9A1fcG_3bDKsuoQDZ4i=Q@mail.gmail.com>
 <20200529172310.GE537@kernel.org> <20200529173608.GA31795@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200529173608.GA31795@kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Igor Lubashev <ilubashe@akamai.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiwei Sun <jiwei.sun@windriver.com>, yuzhoujian <yuzhoujian>
List-Id: linux-perf-users.vger.kernel.org

On Fri, May 29, 2020 at 10:36 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, May 29, 2020 at 02:23:10PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, May 29, 2020 at 10:03:51AM -0700, Ian Rogers escreveu:
> > > On Tue, May 5, 2020 at 11:29 AM Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > From: Stephane Eranian <eranian@google.com>
> > > >
> > > > This patch links perf with the libpfm4 library if it is available
> > > > and LIBPFM4 is passed to the build. The libpfm4 library
> > > > contains hardware event tables for all processors supported by
> > > > perf_events. It is a helper library that helps convert from a
> > > > symbolic event name to the event encoding required by the
> > > > underlying kernel interface. This library is open-source and
> > > > available from: http://perfmon2.sf.net.
> > > >
> > > > With this patch, it is possible to specify full hardware events
> > > > by name. Hardware filters are also supported. Events must be
> > > > specified via the --pfm-events and not -e option. Both options
> > > > are active at the same time and it is possible to mix and match:
> > > >
> > > > $ perf stat --pfm-events inst_retired:any_p:c=1:i -e cycles ....
> > > >
> > > > Signed-off-by: Stephane Eranian <eranian@google.com>
> > > > Reviewed-by: Ian Rogers <irogers@google.com>
> > >
> > > Ping.
> >
> > Check my tmp.perf/core branch, I had to make some adjustments, mostly in
> > the 'perf test' entries as I merged a java demangle test that touched
> > the same files,
> >
> > I'm now doing the build tests.
>
> Talking about build  tests, you forgot to add it there, like I did
> below, I'll eventually do it, as it is opt-in, no biggie at this point.
>
> I'll install libpfm-devel that is in fedora and do further tests, later
> today.

Sorry for that, tbh I wasn't sure what to do. When I test locally I
make sure the build is and isn't adding libpfm into the man pages, the
libpfm tests pass, some command line uses. It'd be great to automate
this as it is not something you'd want to do for every patch and there
is some build sensitivity that potentially could break it.

Thanks,
Ian

> - Arnaldo
>
> commit a01c205e3c4cd6d134317413f2dc3129c4ab7a5a
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Fri May 29 11:31:23 2020 -0300
>
>     perf build: Add NO_SYSCALL_TABLE=1 to the build tests
>
>     So that we make sure that even on x86-64 and other architectures where
>     that is the default method we test build the fallback to libaudit that
>     other architectures use.
>
>     I.e. now this line got added to:
>
>       $ make -C tools/perf build-test
>       <SNIP>
>            make_no_syscall_tbl_O: cd . && make NO_SYSCALL_TABLE=1 FEATURES_DUMP=/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP -j12 O=/tmp/tmp.W0HtKR1mfr DESTDIR=/tmp/tmp.lNezgCVPzW
>       <SNIP>
>       $
>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Ingo Molnar <mingo@kernel.org>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index 29ce0da7fca6..a4ffa3c7fcb6 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -88,6 +88,7 @@ make_no_libbpf_DEBUG := NO_LIBBPF=1 DEBUG=1
>  make_no_libcrypto   := NO_LIBCRYPTO=1
>  make_with_babeltrace:= LIBBABELTRACE=1
>  make_no_sdt        := NO_SDT=1
> +make_no_syscall_tbl := NO_SYSCALL_TABLE=1
>  make_with_clangllvm := LIBCLANGLLVM=1
>  make_tags           := tags
>  make_cscope         := cscope
> @@ -113,7 +114,7 @@ make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1
>  make_minimal        += NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1
>  make_minimal        += NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1
>  make_minimal        += NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
> -make_minimal        += NO_LIBCAP=1
> +make_minimal        += NO_LIBCAP=1 NO_SYSCALL_TABLE=1
>
>  # $(run) contains all available tests
>  run := make_pure
> @@ -146,6 +147,7 @@ run += make_no_libbionic
>  run += make_no_auxtrace
>  run += make_no_libbpf
>  run += make_no_libbpf_DEBUG
> +run += make_no_syscall_tbl
>  run += make_with_babeltrace
>  run += make_with_clangllvm
>  run += make_help
