Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ED1286889;
	Wed, 28 May 2025 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748437951; cv=none; b=NNZsEU+EhuQDx95Ff94Vm3wzJ1hm3u3pue87XYqY6B6xdcw2xZYG52qpYSuyGrmqFDQ+mIS+hx3EtOB2RkCh9NPXsULkdYQFWxYtTw6aMvddAyCzmdpzg6pOufwgBMvo5SOP2b4IQIJvjnR6twZE4Te/VbnSeu5MaKeetf2nXUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748437951; c=relaxed/simple;
	bh=EqWt9GMIHdOPGRd1vILReywY43NpJizJom1wC9tnJ00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GV5swdJKqBO421TYEWrpkKtz5czRdlBDKU/cjFJwIHxXcNAs+w2DHxjccneFiQckV7KzlKwcMHIEh0qCCDs20xN45tCTf4AqePF4brQhjINl3hv6O+vX5mghldemHgZPJ8FjfTKp44swRLI71PN1RdMc2lrjAyXxjMbqH3dW6P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyFc8qUj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyFc8qUj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33A3C4CEE7;
	Wed, 28 May 2025 13:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748437951;
	bh=EqWt9GMIHdOPGRd1vILReywY43NpJizJom1wC9tnJ00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jyFc8qUjPnsNVR7Q8Cp7oZ9r80DMe+12qPnNn/dZflByBdp7etMcSobP1FC3W8/sX
	 rCeVIyHoIV1Qo6K75Oco+2Ko/69ndnZxnH6dlXBwE4KQzrJEBNmrqZgKKCOAWf1/+0
	 +lUEmdHKJK+W0eHJ6azAPKFVZun9AoSZadGYeAOfOsgXgzcdlm7XsQLyTSqj11bjVm
	 UfIjpwMMrZbEC7B1MT6QSd5oO4u2Na3hWUxzeoIqEgwqurxNE2zZJJZ1cL78qcNqy/
	 rmz/nf5hieZW+kYM4SyY/J1zl2TLhJo29lg5kROzucO611gPRxhAmjpn9Om6/jM8z6
	 pHk2i+4U+62QA==
Date: Wed, 28 May 2025 10:12:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Howard Chu <howardchu95@gmail.com>, Andi Kleen <ak@linux.intel.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Anne Macedo <retpolanne@posteo.net>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf machine: Factor creating a "live" machine
 out of dwarf-unwind
Message-ID: <aDcLvCHGtGRHoA08@x1>
References: <20250313052952.871958-1-irogers@google.com>
 <Z9Rk-YdoK-fK_62d@x1>
 <Z9SK96s4PAp680k6@x1>
 <Z9SLL50yuiLOGGYI@x1>
 <Z9oGI8G3cOoluIKf@google.com>
 <CAP-5=fWaTU7Ouj6ZnF2jaoiQbT_Niavx-JA=_bMdYRsr7T-P8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWaTU7Ouj6ZnF2jaoiQbT_Niavx-JA=_bMdYRsr7T-P8w@mail.gmail.com>

On Tue, May 27, 2025 at 02:17:40PM -0700, Ian Rogers wrote:
> On Tue, Mar 18, 2025 at 4:47 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > On Fri, Mar 14, 2025 at 05:01:51PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Fri, Mar 14, 2025 at 05:00:58PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > On Fri, Mar 14, 2025 at 02:18:49PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > On Wed, Mar 12, 2025 at 10:29:51PM -0700, Ian Rogers wrote:
> > > > > > Factor out for use in places other than the dwarf unwinding tests for
> > > > > > libunwind.

> > > > > Testing with another patchset being reviewed/tested, seems to work, if
> > > > > it showed the line number would be even better!

> > > > But it gets the lines, at least in this secoond attempt, after applying
> > > > Namhyungs fix for the previous problem (int16_t):

> > > Nevermind, this time I built with DEBUG=1, so DWARF, probably.

> > Can I get your Tested-by?
 
> Ping. Thanks,

⬢ [acme@toolbx perf-tools-next]$ git log --oneline -1 ; time make -C tools/perf build-test
⬢ [acme@toolbx perf-tools-next]$ git log --oneline -1 ; time make -C tools/perf build-test
9360bbbbbe349ad5 (HEAD -> perf-tools-next) perf test trace_summary: Skip --bpf-summary tests if no libbpf
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
- tarpkg: ./tests/perf-targz-src-pkg .
                 make_static: cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1 -j32  DESTDIR=/tmp/tmp.pLPZo5eOU4
              make_with_gtk2: cd . && make GTK2=1 -j32  DESTDIR=/tmp/tmp.UCW5KoJO7G
- /home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP: cd . && make FEATURE_DUMP_COPY=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP  feature-dump
cd . && make FEATURE_DUMP_COPY=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP feature-dump
       make_install_prefix_O: cd . && make install prefix=/tmp/krava FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.ltUruVMFZe DESTDIR=/tmp/tmp.SF7aKXi9C9
  failed to find: /tmp/krava/etc/bash_completion.d/perf
           make_no_scripts_O: cd . && make NO_LIBPYTHON=1 NO_LIBPERL=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.dDLcnrMf0E DESTDIR=/tmp/tmp.EPrIBPWlr1
                  make_doc_O: cd . && make doc FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.BzKY8ivHAr DESTDIR=/tmp/tmp.VzvzdPnp0f
       make_no_syscall_tbl_O: cd . && make FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.5kxtJHPWTs DESTDIR=/tmp/tmp.jE9lxo6oW9
<SNIP>
              make_minimal_O: cd . && make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_CAPSTONE=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.lElrNycGd2 DESTDIR=/tmp/tmp.d7wt9o5uE5
cd . && make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_CAPSTONE=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.lElrNycGd2 DESTDIR=/tmp/tmp.d7wt9o5uE5
  BUILD:   Doing 'make -j32' parallel build
Warning: Kernel ABI header differences:
  diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
Makefile.config:685: Warning: Disabled BPF skeletons as libelf is required by bpftool
Makefile.config:726: Disabling post unwind, no support found.
Makefile.config:863: Python support disabled by user
Makefile.config:968: No libllvm 13+ found, slower source file resolution, please install llvm-devel/llvm-dev

  GEN     /tmp/tmp.lElrNycGd2/common-cmds.h
  CC      /tmp/tmp.lElrNycGd2/dlfilters/dlfilter-test-api-v0.o
  CC      /tmp/tmp.lElrNycGd2/dlfilters/dlfilter-test-api-v2.o
<SNIP>
  CC      /tmp/tmp.lElrNycGd2/tests/dlfilter-test.o
  CC      /tmp/tmp.lElrNycGd2/util/tool.o
  CC      /tmp/tmp.lElrNycGd2/tests/sigtrap.o
  CC      /tmp/tmp.lElrNycGd2/tests/event_groups.o
  CC      /tmp/tmp.lElrNycGd2/util/sample.o
  CC      /tmp/tmp.lElrNycGd2/tests/symbols.o
  CC      /tmp/tmp.lElrNycGd2/util/sample-raw.o
  CC      /tmp/tmp.lElrNycGd2/util/s390-sample-raw.o
  CC      /tmp/tmp.lElrNycGd2/tests/util.o
util/debug.c: In function ‘__dump_stack’:
util/debug.c:323:17: error: implicit declaration of function ‘backtrace_symbols_fd’ [-Wimplicit-function-declaration]
  323 |                 backtrace_symbols_fd(stackdump, stackdump_size, fileno(file));
      |                 ^~~~~~~~~~~~~~~~~~~~
  CC      /tmp/tmp.lElrNycGd2/util/amd-sample-raw.o
make[6]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:85: /tmp/tmp.lElrNycGd2/util/debug.o] Error 1
make[6]: *** Waiting for unfinished jobs....
  CC      /tmp/tmp.lElrNycGd2/tests/hwmon_pmu.o
  CC      /tmp/tmp.lElrNycGd2/tests/tool_pmu.o
  MKDIR   /tmp/tmp.lElrNycGd2/tests/workloads/
  CC      /tmp/tmp.lElrNycGd2/tests/workloads/noploop.o
  CC      /tmp/tmp.lElrNycGd2/tests/workloads/thloop.o
  CC      /tmp/tmp.lElrNycGd2/tests/workloads/leafloop.o
  CC      /tmp/tmp.lElrNycGd2/tests/workloads/sqrtloop.o
  CC      /tmp/tmp.lElrNycGd2/tests/workloads/brstack.o
  CC      /tmp/tmp.lElrNycGd2/tests/workloads/datasym.o
  CC      /tmp/tmp.lElrNycGd2/tests/workloads/landlock.o
  LD      /tmp/tmp.lElrNycGd2/tests/workloads/perf-test-in.o
  LD      /tmp/tmp.lElrNycGd2/tests/perf-test-in.o
  LD      /tmp/tmp.lElrNycGd2/perf-test-in.o
  AR      /tmp/tmp.lElrNycGd2/libperf-test.a
  LD      /tmp/tmp.lElrNycGd2/perf-in.o
make[5]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:142: util] Error 2
make[4]: *** [Makefile.perf:798: /tmp/tmp.lElrNycGd2/perf-util-in.o] Error 2
make[4]: *** Waiting for unfinished jobs....
  CC      /tmp/tmp.lElrNycGd2/pmu-events/pmu-events.o
  LD      /tmp/tmp.lElrNycGd2/pmu-events/pmu-events-in.o
make[3]: *** [Makefile.perf:290: sub-make] Error 2
make[2]: *** [Makefile:76: all] Error 2
make[1]: *** [tests/make:341: make_minimal_O] Error 1
make: *** [Makefile:109: build-test] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'

real	3m7.724s
user	31m43.201s
sys	5m40.288s
⬢ [acme@toolbx perf-tools-next]$
