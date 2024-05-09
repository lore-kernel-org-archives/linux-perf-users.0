Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1AA80055;
	Thu,  9 May 2024 21:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715291182; cv=none; b=EWLnaz67t/8mlxhAIvhP9VBI76JXFwFJKLb6RwxuXjlx9jP4lNIvyUf7xiqQQXHtXisNN3NBFKyfTg2q0UDNsMXlHvhMnvmhTgxCrsqQ7jFNkq5iN8aruPX76b9/xOGjilKb0irYWpu9NoO45WMSd7ebMZ6DIgjmAP+QXzVeLP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715291182; c=relaxed/simple;
	bh=8UzM3FGkl8GCgBxQhy6UPFhXu5cT+WzocPCZ+hTk82U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTPDCR3bddhArtO5EyVye1TLFTel4rzuS31FlOu42b/wMvkfKyRmCFkJktpAsrK3T43qb2gqwVndTv++Q+ESXyiRvMDAHW9sv/LRoHlTWTK9AaKOOWquRL53NcItUiU+BfLqDWqW16ThB5CcmGQLGr5Ty45A37XAto78Ux7JeGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ludwav+w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ludwav+w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED96C116B1;
	Thu,  9 May 2024 21:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715291182;
	bh=8UzM3FGkl8GCgBxQhy6UPFhXu5cT+WzocPCZ+hTk82U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ludwav+wcaIMFz6C51LBpG4b7j/9hMk6I413e6XpZPHK2FiQ2sWLraDdRxXBF8y0M
	 HRt4IoBqW3l/7rt8p4Aq0JFFDo/eKaCdq3TgbFlNe77HHYIgUooMapfXWgoiLAoAtg
	 OAeTkDtEUo8Q1SyHtXi/9XxCsiaGNWV9PcOXlFHNsvGBi1xF+9uZr/FgDYSU7eMbkv
	 wfxm0nTLRUZdfG2Ve8MbJVFwODHxC2h+ZgTJmwLyHPRx235FMuumWkNZAAEv0ra/4S
	 MzMsb0g0aZhZS7I3sUObex5Npg49ljdyQGi3Dla7DJGuK+TkGu7c15g9Y1ZWgAewli
	 xueo00wh2h19w==
Date: Thu, 9 May 2024 18:46:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>,
	Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] perf parse-events: pass parse_state to
 add_tracepoint
Message-ID: <Zj1EK8cO-Vxc-YuJ@x1>
References: <20240505-perf_digit-v2-0-6ece307fdaad@codewreck.org>
 <20240505-perf_digit-v2-1-6ece307fdaad@codewreck.org>
 <CAP-5=fUmeyd3BR7njJEDQ-=qkpvLPMoQO-7De+3mqLaSOoZZxw@mail.gmail.com>
 <Zj0--YbYSm-s9vRh@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zj0--YbYSm-s9vRh@x1>

On Thu, May 09, 2024 at 06:24:12PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, May 08, 2024 at 02:37:16PM -0700, Ian Rogers wrote:
> > On Sun, May 5, 2024 at 4:14 AM Dominique Martinet
> > <asmadeus@codewreck.org> wrote:
> > >
> > > The next patch will add another flag to parse_state that we will want to
> > > pass to evsel__nwetp_idx(), so pass the whole parse_state all the way
> > > down instead of giving only the index
> > 
> > Nit: evsel__newtp_idx typo
> > Fwiw, I think the idx value is possibly something to be done away
> > with. We renumber the evsels here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/parse-events.c?h=perf-tools-next#n2077
> > 
> > Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Fixed the typo.

But I'm removing the series due to it not passing:

⬢[acme@toolbox perf-tools-next]$ git log --oneline -1 ; time make -C tools/perf build-test
838f9d554bbe1636 (HEAD -> perf-tools-next) perf tracepoint: Don't scan all tracepoints to test if one exists
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
- tarpkg: ./tests/perf-targz-src-pkg .
                 make_static: cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1 -j28  DESTDIR=/tmp/tmp.JIPWT3E0yJ
cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1 -j28 DESTDIR=/tmp/tmp.JIPWT3E0yJ
  BUILD:   Doing 'make -j28' parallel build
  HOSTCC  fixdep.o
  HOSTLD  fixdep-in.o
  LINK    fixdep
Makefile.config:692: Warning: Disabled BPF skeletons as libelf is required by bpftool
Makefile.config:733: Disabling post unwind, no support found.
Makefile.config:801: No libcrypto.h found, disables jitted code injection, please install openssl-devel or libssl-dev
Makefile.config:813: slang not found, disables TUI support. Please install slang-devel, libslang-dev or libslang2-dev
Makefile.config:860: Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libperl-dev
Makefile.config:900: No 'Python.h' was found: disables Python support - please install python-devel/python-dev
Makefile.config:1000: No liblzma found, disables xz kernel module decompression, please install xz-devel/liblzma-dev
Makefile.config:1013: No libzstd found, disables trace compression, please install libzstd-dev[el] and/or set LIBZSTD_DIR
Makefile.config:1024: No libcap found, disables capability support, please install libcap-devel/libcap-dev
Makefile.config:1037: No numa.h found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev
Makefile.config:1096: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:1108: No libcapstone found, disables disasm engine support for 'perf script', please install libcapstone-dev/capstone-devel
Makefile.config:1173: libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev

Auto-detecting system features:
...                                   dwarf: [ OFF ]
...                      dwarf_getlocations: [ OFF ]
...                                   glibc: [ on  ]
...                                  libbfd: [ OFF ]
...                          libbfd-buildid: [ OFF ]
...                                  libcap: [ OFF ]
...                                  libelf: [ OFF ]
...                                 libnuma: [ OFF ]
...                  numa_num_possible_cpus: [ OFF ]
...                                 libperl: [ OFF ]
<SNIP>
 CC      tests/expr.o
  CC      util/mmap.o
  CC      util/memswap.o
  BISON   util/parse-events-bison.c
  CC      tests/backward-ring-buffer.o
  CC      util/print-events.o
  CC      tests/sdt.o
  CC      util/tracepoint.o
  CC      util/perf_regs.o
  CC      util/perf-regs-arch/perf_regs_aarch64.o
  CC      util/intel-pt-decoder/intel-pt-pkt-decoder.o
  GEN     pmu-events/pmu-events.c
  CC      util/perf-regs-arch/perf_regs_arm.o
  GEN     util/intel-pt-decoder/inat-tables.c
  CC      tests/is_printable_array.o
  CC      util/perf-regs-arch/perf_regs_csky.o
  CC      util/perf-regs-arch/perf_regs_loongarch.o
  CC      util/arm-spe-decoder/arm-spe-pkt-decoder.o
  CC      util/arm-spe-decoder/arm-spe-decoder.o
  CC      util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.o
  CC      tests/bitmap.o
  CC      tests/perf-hooks.o
  CC      util/perf-regs-arch/perf_regs_mips.o
  CC      util/intel-pt-decoder/intel-pt-log.o
  CC      tests/unit_number__scnprintf.o
  CC      util/perf-regs-arch/perf_regs_powerpc.o
  CC      tests/mem2node.o
  LD      util/arm-spe-decoder/perf-in.o
  CC      util/perf-regs-arch/perf_regs_riscv.o
  CC      util/perf-regs-arch/perf_regs_s390.o
  CC      util/perf-regs-arch/perf_regs_x86.o
  LD      util/scripting-engines/perf-in.o
  CC      util/path.o
  CC      tests/maps.o
  LD      util/hisi-ptt-decoder/perf-in.o
  CC      tests/time-utils-test.o
  CC      tests/genelf.o
  LD      util/perf-regs-arch/perf-in.o
  CC      tests/api-io.o
  CC      util/intel-pt-decoder/intel-pt-decoder.o
  CC      util/intel-pt-decoder/intel-pt-insn-decoder.o
  CC      util/print_binary.o
  CC      tests/demangle-java-test.o
  CC      util/print_insn.o
  CC      tests/demangle-ocaml-test.o
  CC      tests/pfm.o
  CC      tests/parse-metric.o
  LD      util/intel-pt-decoder/perf-in.o
  CC      util/rlimit.o
  CC      util/argv_split.o
  CC      util/rbtree.o
  CC      util/libstring.o
  CC      util/bitmap.o
  CC      util/hweight.o
  CC      util/smt.o
  CC      util/strbuf.o
  CC      tests/pe-file-parsing.o
  CC      util/string.o
  CC      util/strlist.o
  CC      tests/expand-cgroup.o
  CC      util/strfilter.o
  CC      tests/perf-time-to-tsc.o
  CC      util/top.o
  CC      util/usage.o
  CC      tests/dlfilter-test.o
  CC      tests/sigtrap.o
  CC      util/dso.o
  CC      tests/event_groups.o
  CC      util/dsos.o
  CC      tests/symbols.o
  CC      util/symbol.o
  CC      tests/util.o
  CC      util/symbol_fprintf.o
tests/parse-events.c:2274:26: error: ‘test__checkevent_tracepoint’ undeclared here (not in a function); did you mean ‘test__checkevent_breakpoint’?
 2274 |                 .check = test__checkevent_tracepoint,
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                          test__checkevent_breakpoint
make[6]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:105: tests/parse-events.o] Error 1
make[6]: *** Waiting for unfinished jobs....
  CC      util/map_symbol.o
  CC      util/color.o
  CC      util/color_config.o

