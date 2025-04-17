Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E18020FAB1;
	Thu, 17 Apr 2025 21:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744927131; cv=none; b=T+gHujW9gSqppCfmFrRrtStbtzxx9PUYFTiqB8zL9n+ffTAVi4noZ9LVr4rlfShHpo3zPibb5wSml4LB92qpOxvJ0WQkbE3iV3hxigzVfyaTHN/pP7bzVj9mEagpZUtts0g3fRS3+Jt44mjXz/SXAQNo6Xfftx+8KaIPfimjHTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744927131; c=relaxed/simple;
	bh=J9XB0Q4DA4mZ2mIvCD89MBke9cSxQDueC8x3saNRq/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncjOBvpqbM4zs5adoRaldAKFAfOH2uZs0Rrlom0EuHAZJNaHZkhuU64RZ5tYUWAHC72Z+nk2ZMlp2epmdFHBHmAKiE0ORsGEXTYG9mFWLPCH+5aZskg//bUY1WT6d0XDi1JmeupgE6t+HR2FcxQTTUjWynOqhSTto2DfIdTPJCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtaoKBki; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtaoKBki"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851D6C4CEE4;
	Thu, 17 Apr 2025 21:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744927131;
	bh=J9XB0Q4DA4mZ2mIvCD89MBke9cSxQDueC8x3saNRq/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VtaoKBkiUsJ/MFU64a9i4oQ2p0kidYkHz1gPMkUgno1/qUgr+MY2RR8krHUPh5ytl
	 JemV7UBuBlSNTXCl4kVbQIWtp72j2NmOc3DTA1b6sncUN8ImDnbo3FALwoFiWXh3Ei
	 g1ovCbNAnxEPI4phvjg8+qD6ZTcYrc2e3iUh0H3pQ+tLAPUx+uV50LejhQpfyhyE3+
	 VxfEbta+SnGWnSxQxPvfVNrsrTzpgKpfbX9HBTylDRdeUELCZpHQfN9YUI91bdvMS6
	 b9tcCxrWnatKqD3m7U05ZvGMrthqQScTnqPYYaouXiELv2de5cEbJZLlqe1xCJ7/id
	 47m/qV51JjKlg==
Date: Thu, 17 Apr 2025 18:58:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: arnaldo.melo@gmail.com, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Quentin Monnet <qmo@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] tools build: Remove libbfd from the set of expected
 libraries to build perf
Message-ID: <aAF5mIul8qhDUYz8@x1>
References: <aABlDyhAYz95vOM1@x1>
 <CAP-5=fXeykYoqLJ8t6Gq31cO8eYGOnppgc86PHfWnBoz4xgw-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXeykYoqLJ8t6Gq31cO8eYGOnppgc86PHfWnBoz4xgw-g@mail.gmail.com>

On Thu, Apr 17, 2025 at 08:49:35AM -0700, Ian Rogers wrote:
> On Wed, Apr 16, 2025 at 7:18 PM <arnaldo.melo@gmail.com> wrote:
> >
> > The tools/build/feature/test-all.c file tries to build with the most
> > common set of libraries expected to be present to build perf, and these
> > days libbfd (binutils) isn't one since it was made opt-in via
> > BUILD_NONDISTRO=1 on the make command line as it has license issues.
> >
> > Fix this by removing the tests from there.
> >
> > Fixes: dd317df072071903 ("perf build: Make binutil libraries opt in")
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Quentin Monnet <qmo@kernel.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks.
 
> There is a wider set of cleanups that remove BUILD_NONDISTRO and
> libbfd that I posted back in January:
> https://lore.kernel.org/lkml/20250122174308.350350-1-irogers@google.com/

I thought that discussion hadn't come to a conclusion, then I was in
vacation in January + LSFMM/BPF, lost track of it, will read your
message below and look at it again.

Its just that I recreated my toolbox container for building perf to a
fedora:42 based one and went on trying to build it from the base system
that gets installed in such containers till the point where I found the
above problem.

Now doing 'make -C tools/perf build-test' I'm getting this after the
above patch:

            make_nondistro_O: cd . && make BUILD_NONDISTRO=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.NssFD0ssxu DESTDIR=/tmp/tmp.oEuROiOLtI
cd . && make BUILD_NONDISTRO=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.NssFD0ssxu DESTDIR=/tmp/tmp.oEuROiOLtI
  BUILD:   Doing 'make -j32' parallel build
Warning: Kernel ABI header differences:
  diff -u tools/include/uapi/linux/bits.h include/uapi/linux/bits.h
  diff -u tools/include/linux/bits.h include/linux/bits.h
  diff -u tools/include/vdso/unaligned.h include/vdso/unaligned.h
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
Makefile.config:952: Old version of libbfd/binutils things like PE executable profiling will not be available
Makefile.config:968: No libllvm 13+ found, slower source file resolution, please install llvm-devel/llvm-dev
Makefile.config:1147: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel

  GEN     /tmp/tmp.NssFD0ssxu/common-cmds.h
<SNIP>
In file included from util/disasm_bpf.c:18:
/home/acme/git/perf-tools-next/tools/include/tools/dis-asm-compat.h:10:6: error: redeclaration of ‘enum disassembler_style’
   10 | enum disassembler_style {DISASSEMBLER_STYLE_NOT_EMPTY};
      |      ^~~~~~~~~~~~~~~~~~
In file included from util/disasm_bpf.c:15:
/usr/include/dis-asm.h:53:6: note: originally defined here
   53 | enum disassembler_style
      |      ^~~~~~~~~~~~~~~~~~
/home/acme/git/perf-tools-next/tools/include/tools/dis-asm-compat.h: In function ‘init_disassemble_info_compat’:
/home/acme/git/perf-tools-next/tools/include/tools/dis-asm-compat.h:50:9: error: too few arguments to function ‘init_disassemble_info’; expected 4, have 3
   50 |         init_disassemble_info(info, stream,
      |         ^~~~~~~~~~~~~~~~~~~~~
/usr/include/dis-asm.h:482:13: note: declared here
  482 | extern void init_disassemble_info (struct disassemble_info *dinfo, void *stream,
      |             ^~~~~~~~~~~~~~~~~~~~~
util/disasm_bpf.c: In function ‘symbol__disassemble_bpf’:
util/disasm_bpf.c:109:36: error: incompatible type for argument 1 of ‘disassembler’
  109 |         disassemble = disassembler(bfdf);
      |                                    ^~~~
      |                                    |
      |                                    bfd *
/usr/include/dis-asm.h:411:63: note: expected ‘enum bfd_architecture’ but argument is of type ‘bfd *’
  411 | extern disassembler_ftype disassembler (enum bfd_architecture arc,
      |                                         ~~~~~~~~~~~~~~~~~~~~~~^~~
util/disasm_bpf.c:109:23: error: too few arguments to function ‘disassembler’; expected 4, have 1
  109 |         disassemble = disassembler(bfdf);
      |                       ^~~~~~~~~~~~
/usr/include/dis-asm.h:411:27: note: declared here
  411 | extern disassembler_ftype disassembler (enum bfd_architecture arc,
      |                           ^~~~~~~~~~~~
make[6]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:86: /tmp/tmp.NssFD0ssxu/util/disasm_bpf.o] Error 1
make[6]: *** Waiting for unfinished jobs....
  CC      /tmp/tmp.NssFD0ssxu/bench/mem-memcpy-x86-64-asm.o
<SNIP>
make[5]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:142: util] Error 2
make[4]: *** [Makefile.perf:798: /tmp/tmp.NssFD0ssxu/perf-util-in.o] Error 2
make[4]: *** Waiting for unfinished jobs....
  LD      /tmp/tmp.NssFD0ssxu/tests/workloads/perf-test-in.o
  LD      /tmp/tmp.NssFD0ssxu/tests/perf-test-in.o
  LD      /tmp/tmp.NssFD0ssxu/perf-test-in.o
  LD      /tmp/tmp.NssFD0ssxu/perf-in.o
  CC      /tmp/tmp.NssFD0ssxu/pmu-events/pmu-events.o
  LD      /tmp/tmp.NssFD0ssxu/pmu-events/pmu-events-in.o
make[3]: *** [Makefile.perf:290: sub-make] Error 2
make[2]: *** [Makefile:76: all] Error 2
make[1]: *** [tests/make:341: make_nondistro_O] Error 1
make: *** [Makefile:109: build-test] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'

- Arnaldo

> These changes are carried in:
> https://github.com/googleprodkernel/linux-perf/commits/google_tools_master/
> The remaining use of libbfd for BPF JIT code disassembly is converted
> to using either capstone or LLVM:
> https://lore.kernel.org/lkml/20250122174308.350350-11-irogers@google.com/
> Namhyung had concerns over code like:
> https://github.com/googleprodkernel/linux-perf/blob/google_tools_master/tools/perf/util/capstone.c#L23-L132
> where structs and enums derived from pahole are declared rather than
> gathered from a #include. Doing things this way was deliberate in the
> patch series so that the code could assume capstone or llvm support
> may be present, falling back when not, and that the build wouldn't
> need to have support for a no header file option that could do nothing
> (this option would always be to try to fallback on dlopen and nobody
> could create a less enabled build by forgetting to have a header
> file). Theoretically the structs and defines, incorporated by way of
> pahole, could change and a header file dependency would be robust to
> this. In practice this would be an ABI incompatible change just as
> changing a function name looked up by dlsym would be. Namhyung took
> onboard my suggestion that we could reduce the set of structs/enums/..
> for capstone by disabling the `print_insn_x86` when using dlopen, but
> I think such a change should warn the user of reduced functionality,
> cleaning up the warning would just bring back the code as I had
> proposed:
> https://lore.kernel.org/lkml/CAP-5=fXL0hXFT+t6gHp2RFd4dKnebSkd+rewudpmdentKGPURw@mail.gmail.com/
> 
> I think the patch series should be a priority to land as:
> 1) there is substantial cleanup wrt libbfd, libiberty, .. with
> dependencies being factored out into their our C files;
> 2) the dependencies on libcapstone and libllvm are broken at build
> time, allowing distributions to ship perf with a more minimal set of
> dependencies and then later get the faster code or better support by
> installing the libraries - I think ideally we'd do the same for the
> libpython dependency as Namhyung has done in his uftrace;
> 3) the series adds BPF JIT disassembly.
> 
> Maybe this can be an occasion we respect the opinions of the patch
> author and land what may be just a good patch series, but not quite
> perfect to someone else's definition of perfect. We can always put
> patches on top to make things perfect and discuss the merits at that
> moment.
> 
> Thanks,
> Ian
> 
> > ---
> >  tools/build/Makefile.feature   | 12 ------------
> >  tools/build/feature/Makefile   |  2 +-
> >  tools/build/feature/test-all.c | 19 -------------------
> >  tools/perf/Makefile.config     |  1 +
> >  4 files changed, 2 insertions(+), 32 deletions(-)
> >
> > diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> > index 57bd995ce6afa318..da025a8040a9a154 100644
> > --- a/tools/build/Makefile.feature
> > +++ b/tools/build/Makefile.feature
> > @@ -42,17 +42,12 @@ endef
> >  #
> >  #   All the others should have lines in tools/build/feature/test-all.c like:
> >  #
> > -#    #define main main_test_disassembler_init_styled
> > -#    # include "test-disassembler-init-styled.c"
> > -#    #undef main
> > -#
> >  #    #define main main_test_libzstd
> >  #    # include "test-libzstd.c"
> >  #    #undef main
> >  #
> >  #    int main(int argc, char *argv[])
> >  #    {
> > -#      main_test_disassembler_four_args();
> >  #      main_test_libzstd();
> >  #      return 0;
> >  #    }
> > @@ -60,7 +55,6 @@ endef
> >  #    If the sample above works, then we end up with these lines in the FEATURE-DUMP
> >  #    file:
> >  #
> > -#    feature-disassembler-four-args=1
> >  #    feature-libzstd=1
> >  #
> >  FEATURE_TESTS_BASIC :=                  \
> > @@ -71,8 +65,6 @@ FEATURE_TESTS_BASIC :=                  \
> >          get_current_dir_name            \
> >          gettid                         \
> >          glibc                           \
> > -        libbfd                          \
> > -        libbfd-buildid                 \
> >          libelf                          \
> >          libelf-getphdrnum               \
> >          libelf-gelf_getnote             \
> > @@ -102,8 +94,6 @@ FEATURE_TESTS_BASIC :=                  \
> >          setns                          \
> >          libaio                         \
> >          libzstd                                \
> > -        disassembler-four-args         \
> > -        disassembler-init-styled       \
> >          file-handle
> >
> >  # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
> > @@ -119,8 +109,6 @@ FEATURE_TESTS_EXTRA :=                  \
> >           hello                          \
> >           libbabeltrace                  \
> >           libcapstone                    \
> > -         libbfd-liberty                 \
> > -         libbfd-liberty-z               \
> >           libopencsd                     \
> >           cxx                            \
> >           llvm                           \
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > index b8b5fb183dd40693..76724931f68e1b92 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -110,7 +110,7 @@ all: $(FILES)
> >  __BUILD = $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c,$(@F)) $(LDFLAGS)
> >    BUILD = $(__BUILD) > $(@:.bin=.make.output) 2>&1
> >    BUILD_BFD = $(BUILD) -DPACKAGE='"perf"' -lbfd -ldl
> > -  BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -DPACKAGE='"perf"' -lbfd -ldl -lz -llzma -lzstd
> > +  BUILD_ALL = $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=2 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) -lz -llzma -lzstd
> >
> >  __BUILDXX = $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.cpp,$(@F)) $(LDFLAGS)
> >    BUILDXX = $(__BUILDXX) > $(@:.bin=.make.output) 2>&1
> > diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
> > index 03ddaac6f4c4dfa2..1010f233d9c1ad49 100644
> > --- a/tools/build/feature/test-all.c
> > +++ b/tools/build/feature/test-all.c
> > @@ -66,14 +66,6 @@
> >  # include "test-libslang.c"
> >  #undef main
> >
> > -#define main main_test_libbfd
> > -# include "test-libbfd.c"
> > -#undef main
> > -
> > -#define main main_test_libbfd_buildid
> > -# include "test-libbfd-buildid.c"
> > -#undef main
> > -
> >  #define main main_test_backtrace
> >  # include "test-backtrace.c"
> >  #undef main
> > @@ -158,14 +150,6 @@
> >  # include "test-reallocarray.c"
> >  #undef main
> >
> > -#define main main_test_disassembler_four_args
> > -# include "test-disassembler-four-args.c"
> > -#undef main
> > -
> > -#define main main_test_disassembler_init_styled
> > -# include "test-disassembler-init-styled.c"
> > -#undef main
> > -
> >  #define main main_test_libzstd
> >  # include "test-libzstd.c"
> >  #undef main
> > @@ -193,8 +177,6 @@ int main(int argc, char *argv[])
> >         main_test_libelf_gelf_getnote();
> >         main_test_libelf_getshdrstrndx();
> >         main_test_libslang();
> > -       main_test_libbfd();
> > -       main_test_libbfd_buildid();
> >         main_test_backtrace();
> >         main_test_libnuma();
> >         main_test_numa_num_possible_cpus();
> > @@ -213,7 +195,6 @@ int main(int argc, char *argv[])
> >         main_test_setns();
> >         main_test_libaio();
> >         main_test_reallocarray();
> > -       main_test_disassembler_four_args();
> >         main_test_libzstd();
> >         main_test_libtraceevent();
> >         main_test_libtracefs();
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 9f08a6e96b351707..7e9aa3d910c2cdcc 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -917,6 +917,7 @@ ifneq ($(NO_JEVENTS),1)
> >  endif
> >
> >  ifdef BUILD_NONDISTRO
> > +  $(call feature_check,libbfd)
> >    ifeq ($(feature-libbfd), 1)
> >      EXTLIBS += -lbfd -lopcodes
> >    else
> > --
> > 2.49.0
> >
