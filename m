Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BB6249F5
	for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715622726; cv=none; b=BlcRedoTdPOfVzBFI7zKvo+S+7N8aWksbOh+Kj8EE6n0O8dJszcVPcBrNkGp2CJCSltVwNO2huK2icsZClpvebJ+8onCtYVaST7umdHPNfxKWz82nI6dNt5h46pTgewOcSgmxM8GBSjMIqW2psaEW9G939jsGaD3kdfaQPYfUIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715622726; c=relaxed/simple;
	bh=zW0eteEKw6tnLRjq1bjZLrFervoxzmjSUFiIs1ZHaG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7CwYeWZp97alCKYcLN4hvbiYQkoMC1VzJPQWhpIe4pj3Z3QH3bcwtvUyJfTpS6uJYIurmphaigwrruH6nV7aNaubXlKTsem5wbz0/EpY4kC7+1drvsOIDDVNclbX5Cui0hPrarOH8V5imCndmPJcRZzPKyA3xNgB37T0TPF/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2FLyoOVJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2FLyoOVJ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ee0ccf9c2fso319595ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 10:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715622723; x=1716227523; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tPz10VmNlST1d1aEfJ34rGggRdH6XoG8xRsfNO9GPiU=;
        b=2FLyoOVJ133Q5WYifET2YF+MAkQAO1Rbz2BTa0GwGxan6DeNhczOGYnk/GqwwYqzRi
         5mqI6wtGwQJBBoVzVThTgQ4nOGWbLJWFKAtqezs8OJ7bK/DZWjWgPmlHus3arTzCMNCb
         ZXSw4vjSgv+i2mAgHnWOhLpOECKXKF67SkW8xVOyNmraoPZUSXT12ulBCwnC/J2VLQbl
         qZGOlIsWq4OMdyxbcC3T5sa+INmiF1UMdXnS/A7XP3mO2eyD1f63EtcQSTtHtDM0EwWp
         i+OW5EDiFQBNRSQskH9vMLhzbDoz4dNHeCVPkCZGmbq5259b4TYH3SVVn/2/GdriwB4o
         Nc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715622723; x=1716227523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tPz10VmNlST1d1aEfJ34rGggRdH6XoG8xRsfNO9GPiU=;
        b=DFSrmycS8C48Sx4tXiftk00t71VU8hXnd5NlyhKUOKXkIEprrpcolIFoThdDgBrqeh
         oq9wSsWlyke/AdxZbbBlkDPYL22EVEpJzl1iUnKy8CujmzMEf/5WaBPqEV2PfFKY0QuR
         Sz8IFRMy2pH2HtEdvhfhXppN5U0xCLkH2xl84G6tEdBCUoUWdoef/+rI5OfD6pe2hwuJ
         SgkIqTxYzRlYpjSrBP1Yz/h8v7hrXuOZYwK69YoCv7qntDzt/WTn6TLxSrEutVZeiBPL
         spL88UV1vBuYTyFCqxFMTi3dxA8ogSD22RhIWPtgQUjgu6rdmS0hA5EkmKACYW8gpsMC
         2+dA==
X-Forwarded-Encrypted: i=1; AJvYcCWKzlT5rJKXPpBpPXi4aB2bcqc9X5sKSviiIW1DAABUvdIIjtXBu559DRHKx2UWyC6ee54hP+UDf0tF1tst3JXDjBM/jEBT1Y0X5gWrNluD5A==
X-Gm-Message-State: AOJu0YyFh0u863JEl4nK4cmgAzjk5O7jF3h8ewDeQx3Ab/YVwc/XWthS
	uWuxHhUyKhGmOmT3pMDw9QcvUIqruufxR2HeBTP5/HAlalRSK9Sr31sxZ86CR+/bL6wSfpI8RgF
	NaDVW/qhV8xpy58GNiDMWzwzrkCuAwUc2wDTs
X-Google-Smtp-Source: AGHT+IH4sxtz87l3HvsiQqlbIw5PgNTWQJVdkY2btw/FnjullTIC0NDEiyn899OSLmwyWVo7ixnqM+LLT+6pu71h8LQ=
X-Received: by 2002:a17:902:f607:b0:1eb:7756:55d0 with SMTP id
 d9443c01a7336-1f05f795288mr4083095ad.26.1715622722446; Mon, 13 May 2024
 10:52:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZjssGrj+abyC6mYP@gmail.com> <CAP-5=fUvLiCDVDFFfJ78ng4T1FZ8j2N9Yt1sGTeGsupkbFEEug@mail.gmail.com>
 <ZkG4LWr7w11wQ/PR@gmail.com> <CAP-5=fVHrKcqwczoU1uMD4tP5DTVhfQ1T_hXnm_y5Ji3M6K_ag@mail.gmail.com>
 <ZkJK3x3zQ9a4wp8E@gmail.com> <CAP-5=fUh+GoqERAF-qf8zx4kwq2uzwR2Ugop5XOkPexYGAqF3A@mail.gmail.com>
In-Reply-To: <CAP-5=fUh+GoqERAF-qf8zx4kwq2uzwR2Ugop5XOkPexYGAqF3A@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 May 2024 10:51:50 -0700
Message-ID: <CAP-5=fWXDPfNqLz6DHYe9+dev_e6X5TcTe_xzOOz27yDkT7o7A@mail.gmail.com>
Subject: Re: Makefile.perf:1149: *** Missing bpftool input for generating
 vmlinux.h. Stop.
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It is working at v6.9 for me
(git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git), no
bpftool in the path, bpftool is being built, etc. See below:

i@i:~/ingo/linux$ git checkout v6.9
HEAD is now at a38297e3fb01 Linux 6.9
i@i:~/ingo/linux$ which bpftool
i@i:~/ingo/linux$ cd tools/perf
i@i:~/ingo/linux/tools/perf$ make clean install
 CLEAN   x86
 CLEAN   libapi
 CLEAN   libbpf
 CLEAN   libsubcmd
 CLEAN   libsymbol
 CLEAN   libperf
 CLEAN   arm64-sysreg-defs
 CLEAN   fixdep
 CLEAN   feature-detect
 CLEAN   python
 CLEAN   bpf-skel
 CLEAN   coresight
 CLEAN   core-objs
 CLEAN   core-progs
 CLEAN   core-gen
 CLEAN   Documentation
 BUILD:   Doing 'make -j72' parallel build
 HOSTCC  fixdep.o
 HOSTLD  fixdep-in.o
 LINK    fixdep
Warning: Kernel ABI header differences:
 diff -u tools/include/uapi/linux/vhost.h include/uapi/linux/vhost.h
 diff -u tools/include/linux/bits.h include/linux/bits.h
 diff -u tools/arch/x86/include/asm/cpufeatures.h
arch/x86/include/asm/cpufeatures.h
 diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
Makefile.config:650: No libunwind found. Please install
libunwind-dev[el] >= 1.1 and/or set LIBUNWIND_DIR
Makefile.config:1095: No libcapstone found, disables disasm engine
support for 'perf script', please
install libcapstone-dev/capstone-devel

Auto-detecting system features:
...                                   dwarf: [ on  ]
...                      dwarf_getlocations: [ on  ]
...                                   glibc: [ on  ]
...                                  libbfd: [ on  ]
...                          libbfd-buildid: [ on  ]
...                                  libcap: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                               libunwind: [ OFF ]
...                      libdw-dwarf-unwind: [ on  ]
...                             libcapstone: [ OFF ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

 GEN     common-cmds.h
 CC      perf-read-vdsox32
 CC      perf-read-vdso32
 GEN     ~/ingo/linux/tools/perf/arch/arm64/include/generated/asm/sysreg-defs.h
 CC      jvmti/libjvmti.o
 CC      jvmti/jvmti_agent.o
 CC      dlfilters/dlfilter-test-api-v2.o
 CC      dlfilters/dlfilter-test-api-v0.o
 CC      jvmti/libstring.o
 CC      dlfilters/dlfilter-show-cycles.o
 CC      jvmti/libctype.o
 PERF_VERSION = 6.9.ga38297e3fb01
 GEN     perf-iostat
 GEN     perf-archive
 INSTALL ~/ingo/linux/tools/perf/libsubcmd/include/subcmd/exec-cmd.h
 INSTALL ~/ingo/linux/tools/perf/libsubcmd/include/subcmd/help.h
 INSTALL ~/ingo/linux/tools/perf/libsubcmd/include/subcmd/pager.h
 INSTALL ~/ingo/linux/tools/perf/libsubcmd/include/subcmd/parse-options.h
 INSTALL ~/ingo/linux/tools/perf/libsubcmd/include/subcmd/run-command.h
 CC      ~/ingo/linux/tools/perf/libsubcmd/exec-cmd.o
 CC      ~/ingo/linux/tools/perf/libsubcmd/pager.o
 CC      ~/ingo/linux/tools/perf/libsubcmd/help.o
 CC      ~/ingo/linux/tools/perf/libsubcmd/parse-options.o
 CC      ~/ingo/linux/tools/perf/libsubcmd/run-command.o
 CC      ~/ingo/linux/tools/perf/libsubcmd/subcmd-config.o
 CC      ~/ingo/linux/tools/perf/libsubcmd/sigchain.o
 INSTALL libsubcmd_headers
 GEN      doc.dep
 LINK    dlfilters/dlfilter-show-cycles.so
 INSTALL ~/ingo/linux/tools/perf/libperf/include/perf/bpf_perf.h
 INSTALL ~/ingo/linux/tools/perf/libperf/include/perf/core.h
 INSTALL ~/ingo/linux/tools/perf/libperf/include/perf/cpumap.h
 LINK    dlfilters/dlfilter-test-api-v2.so
 INSTALL ~/ingo/linux/tools/perf/libapi/include/api/cpu.h
 INSTALL ~/ingo/linux/tools/perf/libapi/include/api/debug.h
 INSTALL ~/ingo/linux/tools/perf/libperf/include/perf/threadmap.h
 INSTALL ~/ingo/linux/tools/perf/libperf/include/perf/evlist.h
 INSTALL ~/ingo/linux/tools/perf/libperf/include/perf/event.h
 INSTALL ~/ingo/linux/tools/perf/libperf/include/perf/evsel.h
 CC      ~/ingo/linux/tools/perf/libperf/core.o
 INSTALL ~/ingo/linux/tools/perf/libperf/include/perf/mmap.h
 INSTALL ~/ingo/linux/tools/perf/libperf/include/internal/cpumap.h
 INSTALL ~/ingo/linux/tools/perf/libapi/include/api/fs/fs.h
 INSTALL ~/ingo/linux/tools/perf/libapi/include/api/fs/tracing_path.h
 INSTALL ~/ingo/linux/tools/perf/libapi/include/api/io.h
 INSTALL ~/ingo/linux/tools/perf/libapi/include/api/fd/array.h
 INSTALL ~/ingo/linux/tools/perf/libperf/include/internal/evlist.h
 CC      ~/ingo/linux/tools/perf/libperf/threadmap.o
 CC      ~/ingo/linux/tools/perf/libperf/cpumap.o
 INSTALL ~/ingo/linux/tools/perf/libperf/include/internal/evsel.h
 INSTALL ~/ingo/linux/tools/perf/libperf/include/internal/lib.h
 CC      ~/ingo/linux/tools/perf/libapi/cpu.o
 MKDIR   ~/ingo/linux/tools/perf/libapi/fd/
 CC      ~/ingo/linux/tools/perf/libperf/evsel.o
 CC      ~/ingo/linux/tools/perf/libapi/debug.o
 INSTALL ~/ingo/linux/tools/perf/libperf/include/internal/rc_check.h
 CC      ~/ingo/linux/tools/perf/libperf/evlist.o
 INSTALL ~/ingo/linux/tools/perf/libperf/include/internal/threadmap.h
 INSTALL ~/ingo/linux/tools/perf/libperf/include/internal/xyarray.h
 INSTALL ~/ingo/linux/tools/perf/libsymbol/include/symbol/kallsyms.h
 CC      ~/ingo/linux/tools/perf/libapi/str_error_r.o
 INSTALL ~/ingo/linux/tools/perf/libperf/include/internal/mmap.h
 CC      ~/ingo/linux/tools/perf/libperf/zalloc.o
 CC      ~/ingo/linux/tools/perf/libperf/mmap.o
 MKDIR   ~/ingo/linux/tools/perf/libapi/fs/
 CC      ~/ingo/linux/tools/perf/libperf/xyarray.o
 CC      ~/ingo/linux/tools/perf/libapi/fd/array.o
 CC      ~/ingo/linux/tools/perf/libsymbol/kallsyms.o
 MKDIR   ~/ingo/linux/tools/perf/libapi/fs/
 MKDIR   ~/ingo/linux/tools/perf/libapi/fs/
 CC      ~/ingo/linux/tools/perf/libperf/lib.o
 INSTALL libperf_headers
 INSTALL libapi_headers
 CC      ~/ingo/linux/tools/perf/libapi/fs/fs.o
 INSTALL libsymbol_headers
 CC      ~/ingo/linux/tools/perf/libapi/fs/cgroup.o
 CC      ~/ingo/linux/tools/perf/libapi/fs/tracing_path.o
 LINK    dlfilters/dlfilter-test-api-v0.so
 GEN     ~/ingo/linux/tools/perf/libbpf/bpf_helper_defs.h
 INSTALL ~/ingo/linux/tools/perf/libbpf/include/bpf/bpf.h
 INSTALL ~/ingo/linux/tools/perf/libbpf/include/bpf/libbpf.h
 INSTALL ~/ingo/linux/tools/perf/libbpf/include/bpf/btf.h
 INSTALL ~/ingo/linux/tools/perf/libbpf/include/bpf/libbpf_common.h
 INSTALL ~/ingo/linux/tools/perf/libbpf/include/bpf/libbpf_legacy.h
 INSTALL ~/ingo/linux/tools/perf/libbpf/include/bpf/bpf_helpers.h
 INSTALL ~/ingo/linux/tools/perf/libbpf/include/bpf/bpf_tracing.h
 INSTALL ~/ingo/linux/tools/perf/libbpf/include/bpf/bpf_endian.h
 INSTALL ~/ingo/linux/tools/perf/libbpf/include/bpf/bpf_core_read.h
 INSTALL ~/ingo/linux/tools/perf/libbpf/include/bpf/skel_internal.h
 INSTALL ~/ingo/linux/tools/perf/libbpf/include/bpf/libbpf_version.h
 INSTALL ~/ingo/linux/tools/perf/libbpf/include/bpf/usdt.bpf.h
 LD      ~/ingo/linux/tools/perf/libapi/fd/libapi-in.o
 INSTALL ~/ingo/linux/tools/perf/libbpf/include/bpf/bpf_helper_defs.h
 MKDIR   ~/ingo/linux/tools/perf/libbpf/staticobjs/
 MKDIR   ~/ingo/linux/tools/perf/libbpf/staticobjs/
 MKDIR   ~/ingo/linux/tools/perf/libbpf/staticobjs/
 MKDIR   ~/ingo/linux/tools/perf/libbpf/staticobjs/
 INSTALL libbpf_headers
 MKDIR   ~/ingo/linux/tools/perf/libbpf/staticobjs/
 MKDIR   ~/ingo/linux/tools/perf/libbpf/staticobjs/
 MKDIR   ~/ingo/linux/tools/perf/libbpf/staticobjs/
 CC      ~/ingo/linux/tools/perf/libbpf/staticobjs/libbpf.o
 CC      ~/ingo/linux/tools/perf/libbpf/staticobjs/bpf.o
 CC      ~/ingo/linux/tools/perf/libbpf/staticobjs/nlattr.o
 CC      ~/ingo/linux/tools/perf/libbpf/staticobjs/btf.o
 CC      ~/ingo/linux/tools/perf/libbpf/staticobjs/bpf_prog_linfo.o
 CC      ~/ingo/linux/tools/perf/libbpf/staticobjs/libbpf_errno.o
 CC      ~/ingo/linux/tools/perf/libbpf/staticobjs/str_error.o
 CC      ~/ingo/linux/tools/perf/libbpf/staticobjs/netlink.o
 CC      ~/ingo/linux/tools/perf/libbpf/staticobjs/libbpf_probes.o
 CC      ~/ingo/linux/tools/perf/libbpf/staticobjs/hashmap.o
 ASCIIDOC perf-annotate.xml
 CC      ~/ingo/linux/tools/perf/libbpf/staticobjs/btf_dump.o
 CC      ~/ingo/linux/tools/perf/libbpf/staticobjs/ringbuf.o
 CC      ~/ingo/linux/tools/perf/libbpf/staticobjs/linker.o
 CC      ~/ingo/linux/tools/perf/libbpf/staticobjs/strset.o
 CC      ~/ingo/linux/tools/perf/libbpf/staticobjs/gen_loader.o
 CC      ~/ingo/linux/tools/perf/libbpf/staticobjs/relo_core.o
 CC      ~/ingo/linux/tools/perf/libbpf/staticobjs/usdt.o
 CC      ~/ingo/linux/tools/perf/libbpf/staticobjs/zip.o
 CC      ~/ingo/linux/tools/perf/libbpf/staticobjs/elf.o
 CC      ~/ingo/linux/tools/perf/libbpf/staticobjs/features.o
 LD      jvmti/jvmti-in.o
 LD      ~/ingo/linux/tools/perf/libapi/fs/libapi-in.o
 LD      ~/ingo/linux/tools/perf/libsymbol/libsymbol-in.o
 LINK    libperf-jvmti.so
 LD      ~/ingo/linux/tools/perf/libapi/libapi-in.o
 AR      ~/ingo/linux/tools/perf/libsymbol/libsymbol.a
 LD      ~/ingo/linux/tools/perf/libperf/libperf-in.o
 AR      ~/ingo/linux/tools/perf/libapi/libapi.a
 AR      ~/ingo/linux/tools/perf/libperf/libperf.a
 LD      ~/ingo/linux/tools/perf/libsubcmd/libsubcmd-in.o
 AR      ~/ingo/linux/tools/perf/libsubcmd/libsubcmd.a
 GEN     python/perf.cpython-311-x86_64-linux-gnu.so
 ASCIIDOC perf-archive.xml
 ASCIIDOC perf-arm-spe.xml
 ASCIIDOC perf-bench.xml
 ASCIIDOC perf-buildid-cache.xml
 ASCIIDOC perf-buildid-list.xml
 ASCIIDOC perf-c2c.xml
 ASCIIDOC perf-config.xml
 ASCIIDOC perf-daemon.xml

Auto-detecting system features:
...                         clang-bpf-co-re: [ on  ]
...                                    llvm: [ on  ]
...                                  libcap: [ on  ]
...                                  libbfd: [ on  ]

 MKDIR   ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/i
nclude/bpf
 MKDIR   ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/
 MKDIR   ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/
 INSTALL ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/hashmap.h
 INSTALL ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/relo_core.h
 INSTALL ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_internal.h
 GEN     ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/bpf_helper_defs.h
 INSTALL ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf.h
 INSTALL ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf.h
 INSTALL ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/btf.h
 INSTALL ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_common.h
 INSTALL ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_legacy.h
 INSTALL ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_helpers.h
 INSTALL ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_tracing.h
 INSTALL ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_endian.h
 INSTALL ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_core_read.h
 INSTALL ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/skel_internal.h
 INSTALL ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_version.h
 INSTALL ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/usdt.bpf.h
 INSTALL ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_helper_defs.h
 MKDIR   ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
 MKDIR   ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
 MKDIR   ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf.o
 INSTALL libbpf_headers
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/btf.o
 ASCIIDOC perf-data.xml
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf_errno.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/str_error.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/bpf.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/nlattr.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/netlink.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/bpf_prog_linfo.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf_probes.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/hashmap.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/btf_dump.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/ringbuf.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/strset.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/linker.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/gen_loader.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/relo_core.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/usdt.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/zip.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/elf.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/features.o
 ASCIIDOC perf-diff.xml
 ASCIIDOC perf-dlfilter.xml
 ASCIIDOC perf-evlist.xml
 ASCIIDOC perf-ftrace.xml
 LD      ~/ingo/linux/tools/perf/libbpf/staticobjs/libbpf-in.o
 LINK    ~/ingo/linux/tools/perf/libbpf/libbpf.a
 ASCIIDOC perf-help.xml
 ASCIIDOC perf-inject.xml
 ASCIIDOC perf-intel-pt.xml
 ASCIIDOC perf-iostat.xml
 ASCIIDOC perf-kallsyms.xml
 ASCIIDOC perf-kmem.xml
 ASCIIDOC perf-kvm.xml
 ASCIIDOC perf-kwork.xml
 ASCIIDOC perf-list.xml
 ASCIIDOC perf-lock.xml
 ASCIIDOC perf-mem.xml
 ASCIIDOC perf-probe.xml
 ASCIIDOC perf-record.xml
 ASCIIDOC perf-report.xml
 LD      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/s
taticobjs/libbpf-in.o
 LINK    ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/l
ibbpf.a
 ASCIIDOC perf-sched.xml
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/main.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/common.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/json_wri
ter.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/gen.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/btf.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/xlated_d
umper.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/btf_dump
er.o
 CC      ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/disasm.o
 ASCIIDOC perf-script-perl.xml
 ASCIIDOC perf-script-python.xml
 ASCIIDOC perf-script.xml
 ASCIIDOC perf-stat.xml
 ASCIIDOC perf-test.xml
 LINK    ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bootstrap/bpftool
 CLANG   ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bpf_prog_profiler.
bpf.o
 CLANG   ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o
 CLANG   ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bperf_follower.bpf
.o
 CLANG   ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bperf_cgroup.bpf.o
 CLANG   ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/func_latency.bpf.o
 CLANG   ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/off_cpu.bpf.o
 CLANG   ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/lock_contention.bp
f.o
 CLANG   ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/kwork_trace.bpf.o
 CLANG   ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/bench_uprobe.bpf.o
 CLANG   ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/sample_filter.bpf.
o
 CLANG   ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/kwork_top.bpf.o
 CLANG   ~/ingo/linux/tools/perf/util/bpf_skel/.tmp/augmented_raw_sysc
alls.bpf.o
 GENSKEL ~/ingo/linux/tools/perf/util/bpf_skel/bench_uprobe.skel.h
 GENSKEL ~/ingo/linux/tools/perf/util/bpf_skel/bperf_follower.skel.h
 GENSKEL ~/ingo/linux/tools/perf/util/bpf_skel/bperf_leader.skel.h
 GENSKEL ~/ingo/linux/tools/perf/util/bpf_skel/bpf_prog_profiler.skel.
h
 GENSKEL ~/ingo/linux/tools/perf/util/bpf_skel/func_latency.skel.h
 GENSKEL ~/ingo/linux/tools/perf/util/bpf_skel/sample_filter.skel.h
 GENSKEL ~/ingo/linux/tools/perf/util/bpf_skel/kwork_top.skel.h
 GENSKEL ~/ingo/linux/tools/perf/util/bpf_skel/bperf_cgroup.skel.h
 GENSKEL ~/ingo/linux/tools/perf/util/bpf_skel/augmented_raw_syscalls.
skel.h
 GENSKEL ~/ingo/linux/tools/perf/util/bpf_skel/off_cpu.skel.h
 GENSKEL ~/ingo/linux/tools/perf/util/bpf_skel/lock_contention.skel.h
 GENSKEL ~/ingo/linux/tools/perf/util/bpf_skel/kwork_trace.skel.h
 CC      builtin-bench.o
 CC      builtin-annotate.o
 CC      builtin-config.o
 CC      builtin-diff.o
 CC      builtin-evlist.o
 CC      builtin-ftrace.o
 CC      builtin-help.o
 CC      builtin-buildid-list.o
 CC      builtin-buildid-cache.o
 CC      builtin-kallsyms.o
 CC      builtin-list.o
 CC      builtin-record.o
 CC      builtin-report.o
 CC      builtin-stat.o
 TEST    pmu-events/metric_test.log
 CC      builtin-top.o
 CC      builtin-script.o
 CC      builtin-kvm.o
 CC      builtin-inject.o
 CC      builtin-mem.o
 CC      builtin-data.o
 CC      builtin-version.o
 CC      builtin-c2c.o
 CC      builtin-daemon.o
 CC      builtin-kmem.o
 CC      builtin-kwork.o
 CC      builtin-lock.o
 CC      builtin-sched.o
 CC      builtin-timechart.o
 CC      builtin-trace.o
 CC      trace/beauty/clone.o
 CC      bench/sched-messaging.o
 CC      builtin-probe.o
 CC      arch/common.o
 CC      trace/beauty/fcntl.o
 CC      perf.o
 CC      ui/setup.o
 CC      tests/builtin-test.o
 CC      bench/sched-pipe.o
 CC      tests/tests-scripts.o
 CC      bench/sched-seccomp-notify.o
 CC      trace/beauty/flock.o
 CC      ui/helpline.o
 CC      scripts/perl/Perf-Trace-Util/Context.o
 CC      ui/progress.o
 CC      tests/parse-events.o
 CC      trace/beauty/fspick.o
 CC      bench/syscall.o
 CC      scripts/python/Perf-Trace-Util/Context.o
 CC      ui/util.o
 CC      trace/beauty/fsmount.o
 CC      trace/beauty/ioctl.o
 CC      tests/attr.o
 CC      tests/dso-data.o
 CC      arch/x86/util/header.o
 CC      bench/mem-functions.o
 CC      arch/x86/tests/regs_load.o
 CC      arch/x86/util/tsc.o
 CC      arch/x86/util/pmu.o
 CC      bench/futex-hash.o
 CC      tests/vmlinux-kallsyms.o
 CC      trace/beauty/kcmp.o
 CC      ui/hist.o
 CC      trace/beauty/mount_flags.o
 CC      bench/futex-wake.o
 CC      ui/stdio/hist.o
 CC      tests/openat-syscall.o
 CC      arch/x86/tests/dwarf-unwind.o
 CC      util/arm64-frame-pointer-unwind-support.o
 ASCIIDOC perf-timechart.xml
 CC      util/addr_location.o
 CC      arch/x86/tests/arch-tests.o
 GEN     pmu-events/pmu-events.c
 CC      trace/beauty/move_mount.o
 CC      arch/x86/util/kvm-stat.o
 CC      trace/beauty/pkey_alloc.o
 CC      trace/beauty/arch_prctl.o
 CC      bench/futex-wake-parallel.o
 CC      tests/openat-syscall-all-cpus.o
 CC      arch/x86/util/perf_regs.o
 CC      arch/x86/util/topdown.o
 CC      util/annotate.o
 CC      ui/browser.o
 CC      util/block-info.o
 CC      bench/futex-requeue.o
 CC      arch/x86/tests/sample-parsing.o
 CC      ui/browsers/annotate.o
 CC      tests/openat-syscall-tp-fields.o
 CC      arch/x86/tests/hybrid.o
 CC      bench/futex-lock-pi.o
 CC      bench/epoll-wait.o
 ASCIIDOC perf-top.xml
 CC      ui/browsers/hists.o
 CC      util/block-range.o
 CC      util/build-id.o
 CC      arch/x86/tests/intel-pt-test.o
 CC      bench/epoll-ctl.o
 CC      trace/beauty/prctl.o
 CC      tests/mmap-basic.o
 CC      arch/x86/tests/bp-modify.o
 CC      arch/x86/util/machine.o
 CC      ui/tui/setup.o
 CC      arch/x86/tests/amd-ibs-via-core-pmu.o
 CC      ui/browsers/map.o
 CC      util/cacheline.o
 CC      ui/browsers/scripts.o
 CC      arch/x86/util/event.o
 CC      ui/tui/util.o
 CC      tests/perf-record.o
 CC      arch/x86/util/evlist.o
 CC      ui/browsers/header.o
 CC      ui/browsers/res_sample.o
 CC      arch/x86/util/mem-events.o
 CC      trace/beauty/renameat.o
 CC      trace/beauty/sockaddr.o
 CC      bench/synthesize.o
 CC      bench/kallsyms-parse.o
 CC      arch/x86/util/evsel.o
 CC      trace/beauty/socket.o
 CC      ui/tui/helpline.o
 CC      util/config.o
 CC      util/copyfile.o
 CC      trace/beauty/statx.o
 CC      bench/find-bit-bench.o
 CC      util/ctype.o
 CC      ui/tui/progress.o
 CC      util/db-export.o
 CC      bench/inject-buildid.o
 CC      util/env.o
 CC      arch/x86/util/iostat.o
 LD      scripts/python/Perf-Trace-Util/perf-in.o
 CC      bench/evlist-open-close.o
 CC      arch/x86/util/env.o
 CC      bench/breakpoint.o
 CC      util/event.o
 CC      arch/x86/util/dwarf-regs.o
 CC      trace/beauty/sync_file_range.o
 CC      tests/evsel-roundtrip-name.o
 CC      trace/beauty/timespec.o
 CC      bench/pmu-scan.o
 CC      bench/uprobe.o
 CC      util/evlist.o
 CC      tests/evsel-tp-sched.o
 CC      arch/x86/util/unwind-libdw.o
 CC      bench/mem-memcpy-x86-64-asm.o
 CC      util/sideband_evlist.o
 CC      tests/fdarray.o
 CC      arch/x86/util/auxtrace.o
 CC      tests/pmu.o
 CC      trace/beauty/tracepoints/x86_irq_vectors.o
 CC      arch/x86/util/archinsn.o
 LD      arch/x86/tests/perf-in.o
 CC      arch/x86/util/intel-pt.o
 CC      util/evsel.o
 CC      tests/pmu-events.o
 CC      bench/mem-memset-x86-64-asm.o
 CC      util/evsel_fprintf.o
 CC      trace/beauty/tracepoints/x86_msr.o
 CC      tests/hists_common.o
 CC      arch/x86/util/intel-bts.o
 CC      tests/hists_link.o
 CC      tests/hists_filter.o
 CC      util/perf_event_attr_fprintf.o
 CC      tests/hists_output.o
 CC      util/evswitch.o
 CC      util/find_bit.o
 CC      bench/numa.o
 CC      util/get_current_dir_name.o
 LD      ui/tui/perf-in.o
 CC      tests/hists_cumulate.o
 CC      util/levenshtein.o
 CC      tests/python-use.o
 CC      util/mmap.o
 CC      tests/bp_signal.o
 CC      util/memswap.o
 BISON   util/parse-events-bison.c
 CC      tests/bp_signal_overflow.o
 CC      util/print-events.o
 CC      tests/bp_account.o
 CC      util/tracepoint.o
 CC      tests/wp.o
 LD      trace/beauty/tracepoints/perf-in.o
 CC      tests/task-exit.o
 CC      util/perf_regs.o
 LD      trace/beauty/perf-in.o
 CC      util/perf-regs-arch/perf_regs_aarch64.o
 CC      tests/sw-clock.o
 CC      util/perf-regs-arch/perf_regs_arm.o
 CC      util/intel-pt-decoder/intel-pt-pkt-decoder.o
 ASCIIDOC perf-trace.xml
 CC      tests/mmap-thread-lookup.o
 CC      util/arm-spe-decoder/arm-spe-pkt-decoder.o
 CC      util/perf-regs-arch/perf_regs_csky.o
 GEN     util/intel-pt-decoder/inat-tables.c
 CC      util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.o
 CC      util/arm-spe-decoder/arm-spe-decoder.o
 CC      util/perf-regs-arch/perf_regs_loongarch.o
 CC      util/perf-regs-arch/perf_regs_mips.o
 CC      util/scripting-engines/trace-event-perl.o
 LD      scripts/perl/Perf-Trace-Util/perf-in.o
 CC      util/perf-regs-arch/perf_regs_powerpc.o
 CC      util/perf-regs-arch/perf_regs_riscv.o
 LD      scripts/perf-in.o
 CC      tests/thread-maps-share.o
 CC      util/scripting-engines/trace-event-python.o
 CC      util/path.o
 CC      util/perf-regs-arch/perf_regs_s390.o
 CC      util/print_binary.o
 CC      tests/switch-tracking.o
 CC      util/intel-pt-decoder/intel-pt-log.o
 CC      util/perf-regs-arch/perf_regs_x86.o
 CC      util/print_insn.o
 CC      tests/keep-tracking.o
 CC      util/intel-pt-decoder/intel-pt-decoder.o
 CC      util/rlimit.o
 CC      tests/code-reading.o
 CC      util/argv_split.o
 CC      util/rbtree.o
 CC      util/libstring.o
 CC      util/bitmap.o
 CC      tests/sample-parsing.o
 CC      util/hweight.o
 LD      util/hisi-ptt-decoder/perf-in.o
 CC      tests/parse-no-sample-id-all.o
 CC      util/smt.o
 CC      tests/kmod-path.o
 CC      util/strbuf.o
 CC      tests/thread-map.o
 CC      tests/topology.o
 CC      util/string.o
 CC      util/strlist.o
 CC      util/strfilter.o
 LD      util/perf-regs-arch/perf-in.o
 CC      util/top.o
 CC      tests/mem.o
 CC      tests/cpumap.o
 CC      tests/stat.o
 CC      util/usage.o
 CC      tests/event_update.o
 CC      util/dso.o
 CC      tests/event-times.o
 CC      tests/expr.o
 CC      util/dsos.o
 CC      tests/backward-ring-buffer.o
 CC      util/symbol.o
 CC      util/symbol_fprintf.o
 CC      tests/sdt.o
 CC      util/map_symbol.o
 CC      util/color.o
 CC      util/color_config.o
 LD      util/arm-spe-decoder/perf-in.o
 CC      tests/is_printable_array.o
 CC      util/metricgroup.o
 CC      util/header.o
 CC      util/callchain.o
 CC      tests/bitmap.o
 CC      util/values.o
 CC      tests/perf-hooks.o
 CC      util/debug.o
 CC      tests/unit_number__scnprintf.o
 CC      tests/mem2node.o
 CC      util/intel-pt-decoder/intel-pt-insn-decoder.o
 CC      util/fncache.o
 CC      tests/maps.o
 CC      tests/time-utils-test.o
 CC      util/machine.o
 CC      util/map.o
 CC      util/maps.o
 CC      tests/genelf.o
 CC      tests/api-io.o
 CC      util/pstack.o
 CC      tests/demangle-java-test.o
 CC      util/session.o
 CC      tests/demangle-ocaml-test.o
 CC      util/sample-raw.o
 CC      tests/pfm.o
 CC      util/s390-sample-raw.o
 CC      tests/parse-metric.o
 CC      util/amd-sample-raw.o
 CC      util/syscalltbl.o
 CC      tests/pe-file-parsing.o
 CC      util/ordered-events.o
 CC      util/namespaces.o
 CC      tests/expand-cgroup.o
 CC      util/comm.o
 CC      tests/perf-time-to-tsc.o
 CC      tests/dlfilter-test.o
 CC      util/thread.o
 CC      tests/sigtrap.o
 CC      util/threads.o
 CC      tests/event_groups.o
 CC      tests/symbols.o
 CC      util/thread_map.o
 CC      util/parse-events-bison.o
 BISON   util/pmu-bison.c
 CC      tests/util.o
 CC      tests/dwarf-unwind.o
 CC      util/pmus.o
 CC      tests/workloads/noploop.o
 CC      util/svghelper.o
 CC      util/trace-event-info.o
 CC      tests/workloads/thloop.o
 LD      arch/x86/util/perf-in.o
 CC      util/trace-event-scripting.o
 CC      util/trace-event.o
 LD      arch/x86/perf-in.o
 CC      tests/workloads/leafloop.o
 CC      util/trace-event-parse.o
 CC      util/trace-event-read.o
 CC      tests/workloads/sqrtloop.o
 CC      util/sort.o
 CC      tests/workloads/brstack.o
 LD      arch/perf-in.o
 CC      util/hist.o
 CC      tests/workloads/datasym.o
 CC      util/util.o
 CC      util/cpumap.o
 CC      util/affinity.o
 CC      util/cputopo.o
 CC      util/cgroup.o
 CC      util/target.o
 CC      util/rblist.o
 CC      util/intlist.o
 CC      util/vdso.o
 CC      util/counts.o
 CC      util/stat.o
 CC      util/stat-shadow.o
 CC      util/stat-display.o
 CC      util/perf_api_probe.o
 CC      util/record.o
 CC      util/srcline.o
 CC      util/srccode.o
 LD      tests/workloads/perf-in.o
 CC      util/synthetic-events.o
 CC      util/data.o
 CC      util/tsc.o
 CC      util/cloexec.o
 CC      util/call-path.o
 CC      util/rwsem.o
 CC      util/thread-stack.o
 CC      util/spark.o
 CC      util/topdown.o
 CC      util/iostat.o
 CC      util/stream.o
 CC      util/auxtrace.o
 CC      util/intel-pt.o
 CC      util/intel-bts.o
 CC      util/arm-spe.o
 CC      util/hisi-ptt.o
 CC      util/s390-cpumsf.o
 CC      util/cs-etm-base.o
 CC      util/parse-branch-options.o
 CC      util/dump-insn.o
 CC      util/parse-regs-options.o
 CC      util/parse-sublevel-options.o
 CC      util/term.o
 CC      util/help-unknown-cmd.o
 CC      util/dlfilter.o
 CC      util/mem-events.o
 CC      util/vsprintf.o
 CC      util/units.o
 ASCIIDOC perf-version.xml
 CC      util/time-utils.o
 BISON   util/expr-bison.c
 CC      util/branch.o
 CC      util/mem2node.o
 CC      util/clockid.o
 CC      util/list_sort.o
 CC      util/mutex.o
 CC      util/sharded_mutex.o
 CC      util/bpf_counter.o
 CC      util/bpf_map.o
 CC      util/bpf_ftrace.o
 CC      util/bpf_counter_cgroup.o
 CC      util/bpf_off_cpu.o
 BISON   util/bpf-filter-bison.c
 CC      util/bpf_lock_contention.o
 CC      util/bpf_kwork.o
 CC      util/bpf_kwork_top.o
 CC      util/probe-file.o
 ASCIIDOC perf.xml
 CC      util/symbol-elf.o
 CC      util/probe-event.o
 CC      util/probe-finder.o
 CC      util/dwarf-aux.o
 CC      util/dwarf-regs.o
 LD      bench/perf-in.o
 CC      util/debuginfo.o
 CC      util/annotate-data.o
 CC      util/unwind-libdw.o
 CC      util/data-convert-bt.o
 CC      util/data-convert-json.o
 CC      util/zlib.o
 CC      util/lzma.o
 CC      util/zstd.o
 CC      util/cap.o
 CXX     util/demangle-cxx.o
 CC      util/demangle-ocaml.o
 CC      util/demangle-java.o
 CC      util/demangle-rust.o
 CC      util/jitdump.o
 CC      util/genelf.o
 CC      util/genelf_debug.o
 CC      util/perf-hooks.o
 CC      util/bpf-event.o
 CC      util/bpf-utils.o
 CC      util/pfm.o
 XMLTO    perf-annotate.1
 FLEX    util/parse-events-flex.c
 LD      tests/perf-in.o
 FLEX    util/pmu-flex.c
 CC      util/pmu-bison.o
 FLEX    util/expr-flex.c
 CC      util/expr-bison.o
 FLEX    util/bpf-filter-flex.c
 XMLTO    perf-archive.1
 XMLTO    perf-arm-spe.1
 XMLTO    perf-bench.1
 CC      util/bpf-filter-bison.o
 XMLTO    perf-buildid-cache.1
 CC      util/parse-events.o
 XMLTO    perf-buildid-list.1
 CC      util/parse-events-flex.o
 XMLTO    perf-c2c.1
 XMLTO    perf-config.1
 XMLTO    perf-daemon.1
 XMLTO    perf-data.1
 XMLTO    perf-diff.1
 XMLTO    perf-dlfilter.1
 XMLTO    perf-evlist.1
 XMLTO    perf-ftrace.1
 XMLTO    perf-help.1
 XMLTO    perf-inject.1
 XMLTO    perf-intel-pt.1
 CC      util/pmu.o
 CC      util/pmu-flex.o
 XMLTO    perf-iostat.1
 XMLTO    perf-kallsyms.1
 CC      util/expr-flex.o
 XMLTO    perf-kmem.1
 CC      util/expr.o
 XMLTO    perf-kvm.1
 XMLTO    perf-kwork.1
 XMLTO    perf-list.1
 CC      util/bpf-filter.o
 XMLTO    perf-lock.1
 CC      util/bpf-filter-flex.o
 XMLTO    perf-mem.1
 XMLTO    perf-probe.1
 LD      util/scripting-engines/perf-in.o
 XMLTO    perf-record.1
 XMLTO    perf-report.1
 XMLTO    perf-sched.1
 XMLTO    perf-script-perl.1
 XMLTO    perf-script-python.1
 XMLTO    perf-script.1
 XMLTO    perf-stat.1
 XMLTO    perf-test.1
 XMLTO    perf-timechart.1
 XMLTO    perf-top.1
 XMLTO    perf-trace.1
 XMLTO    perf-version.1
 XMLTO    perf.1
 LD      ui/browsers/perf-in.o
 LD      ui/perf-in.o
 LD      util/intel-pt-decoder/perf-in.o
 INSTALL Documentation-man
 LD      util/perf-in.o
 LD      perf-in.o
 CC      pmu-events/pmu-events.o
 LD      pmu-events/pmu-events-in.o
 LINK    perf
 INSTALL binaries
 INSTALL tests
 INSTALL perf-read-vdso32
 INSTALL perf-read-vdsox32
 INSTALL libperf-jvmti.so
 INSTALL libexec
 INSTALL perf-archive
 INSTALL perf-iostat
 INSTALL strace/groups
 INSTALL perl-scripts
 INSTALL python-scripts
 INSTALL dlfilters
 INSTALL perf_completion-script
 INSTALL perf-tip
i@i:~/ingo/linux/tools/perf$ find .|grep bpftool
./util/bpf_skel/.tmp/FEATURE-DUMP.bpftool
./util/bpf_skel/.tmp/bootstrap/bpftool
