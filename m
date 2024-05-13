Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CC2208CB;
	Mon, 13 May 2024 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715620582; cv=none; b=s3O6yz8B3wZlVfY35A7WhrTH7E12nJ0kADkbo4p02AecSs7xtHfikP3Si924sKWE2oDCzai/6Uj1IWMB+Vuvb4PY1KAui4E8BIrBpVOtsEG2TNY71qUKf/hRWLBrLpwx4Q7JTSczxax3Cbz0I3d6ak14htgYhh3t5LosUOjIgkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715620582; c=relaxed/simple;
	bh=InOgwPC4x2W6ulPcGKnk0LOcS0n5bek7LE9N3+UdeCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkKqsEsqcR92EinCi8kO5VpRDB516M6v7id/EGjHqDPk7rQWpuPy0MbyfTfPUp3Cr7hY1JmbjtYHiBpuZ9qu+dUD75IKb8ljseRwkmLjth/jNB6FHi9MF/1fTrEw/cBbsxXy/tqc8lktUJV8LqIv6CpkgTy3xnKMaw1foMO3Ktk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Odzow2Fa; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Odzow2Fa"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e576057c2bso34227101fa.1;
        Mon, 13 May 2024 10:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715620578; x=1716225378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIFXqa1t1NtXSBY7MBsXME9e/2zOPJpnns4yRQDxwuA=;
        b=Odzow2Fahqf30JtY5nURUWRzKDmwBCO/sznkWOTOXV9TXyXL1IqQiFdSmS/dO7SOD3
         yPOFUTGuBhb6hErGSjaph1oLOnHyiEV+arboPc3hMbjZsM1OBGhRSLqWi2S/L2ICxz/i
         kBc2DC8gdjWiyL9feLG/hjigXEK8twD3iFfFXG+h3DuadJaU/qBQoa28PISY15CncJiD
         VZB03KIJruclzf/TL9L4JXH+MKTb3fcZ8MggmsdLBcxIt8jNimuPxn/427qNZw5B6aqs
         Kkc1/e0BgLsSsMM1Qyiw4o6ceHi8/TyH2xUFCIsTku3t25z68m9WSrGsMMwgPQIfSWbe
         rSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715620578; x=1716225378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIFXqa1t1NtXSBY7MBsXME9e/2zOPJpnns4yRQDxwuA=;
        b=p5FVYNs+hNYHzOZnoB1w14K2dKAP+pt0p2xXoZymNat2L5msg9k/Q8LSKPw0d52RCq
         ztd/JYfQqe4mPwBPdTEqH5Zx+wt0/JORugM1wqDkQy5PHU1p3UscfvxwPEN9XZo+lWoy
         gbP6lm1tqHrqhjJ/rWsHvvl29eM0gzinkrkOQdrHZw6XX6U7fUIGm98vaN3cw6SjjVqy
         CiIP/Bg4DdOXuew9L4WTHXb7wEdZ3slqFM9qupZecBQWldZOzMZ20GiQU8S4iJkodoru
         bYVWojGb1LAoNVxJWbmT91KM+XezIkBVsZKlISAcoRSGs75HJ605wjq6zwa9eK/n0Lqb
         3r4g==
X-Forwarded-Encrypted: i=1; AJvYcCXNpq5sHqA3b5vuuJaU9n5DqmNW20opBEBIKnv0podvKtdZcM5X5aV8PHCOmv2Nsgf8HS9BT2t88+FIyLSZ7OqPls8rzs5bIhwclkrTN7ZQ9uLBX8ilXoOM7nzrieDm4i9LSCalsQ4rDW4VzgcWrw==
X-Gm-Message-State: AOJu0Yw6Qbs+7uDB0SUo1wkm/2Ha2EYG+BiCKk3ZRM2f6aqJMgh5fQuE
	UfvUT/slYJNI77lUx2n+YmKxUy+ZDtuqbcwq4TzAjMQ+1u9vBSZk
X-Google-Smtp-Source: AGHT+IEkizxzff3FOtyaWuc90FliClt5+ngPC3OuU/fPekt63VvJvWHCrPdC/md8juqcWihcEy24iA==
X-Received: by 2002:ac2:58ea:0:b0:51e:233f:767 with SMTP id 2adb3069b0e04-5221027861fmr6674367e87.45.1715620577856;
        Mon, 13 May 2024 10:16:17 -0700 (PDT)
Received: from gmail.com (1F2EF402.unconfigured.pool.telekom.hu. [31.46.244.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01968sm619833766b.166.2024.05.13.10.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 10:16:17 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 13 May 2024 19:16:15 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: Makefile.perf:1149: *** Missing bpftool input for generating
 vmlinux.h. Stop.
Message-ID: <ZkJK3x3zQ9a4wp8E@gmail.com>
References: <ZjssGrj+abyC6mYP@gmail.com>
 <CAP-5=fUvLiCDVDFFfJ78ng4T1FZ8j2N9Yt1sGTeGsupkbFEEug@mail.gmail.com>
 <ZkG4LWr7w11wQ/PR@gmail.com>
 <CAP-5=fVHrKcqwczoU1uMD4tP5DTVhfQ1T_hXnm_y5Ji3M6K_ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVHrKcqwczoU1uMD4tP5DTVhfQ1T_hXnm_y5Ji3M6K_ag@mail.gmail.com>


* Ian Rogers <irogers@google.com> wrote:

> > Was this regression fix propagated to v6.9 in time?
> 
> We switched to using the handwritten file in v6.4:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/tools/perf/util/bpf_skel/vmlinux.h?id=a887466562b425bd6183bf75b523c1477c9fd22d

So there must be some different regression then, as this is readily 
reproducible for me on v6.9, as per the build log below - I simply 
Ctrl-C-ed a build, and the next build results in:

  kepler:~/tip/tools/perf> make clean install
  Makefile.perf:1149: *** Missing bpftool input for generating vmlinux.h.  Stop.
  make: *** [Makefile:90: clean] Error 2
  kepler:~/tip/tools/perf> 

Thanks,

	Ingo

=========>
kepler:~/tip/tools/perf> make clean install
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
  BUILD:   Doing 'make -j64' parallel build
  HOSTCC  fixdep.o
  HOSTLD  fixdep-in.o
  LINK    fixdep
Warning: Kernel ABI header differences:
  diff -u tools/include/uapi/linux/vhost.h include/uapi/linux/vhost.h
  diff -u tools/include/linux/bits.h include/linux/bits.h
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
  diff -u tools/arch/x86/include/asm/irq_vectors.h arch/x86/include/asm/irq_vectors.h
  diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
  diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl





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
...                               libunwind: [ on  ]
...                      libdw-dwarf-unwind: [ on  ]
...                             libcapstone: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

  GEN     common-cmds.h
  CC      perf-read-vdso32
  CC      perf-read-vdsox32
  CC      jvmti/libjvmti.o
  CC      dlfilters/dlfilter-test-api-v0.o
  CC      dlfilters/dlfilter-test-api-v2.o
  CC      jvmti/jvmti_agent.o
  CC      dlfilters/dlfilter-show-cycles.o
  CC      jvmti/libstring.o
  CC      jvmti/libctype.o
  GEN     /home/mingo/tip/tools/perf/arch/arm64/include/generated/asm/sysreg-defs.h
  PERF_VERSION = 6.9.g16ae3bebb76c
  INSTALL /home/mingo/tip/tools/perf/libsubcmd/include/subcmd/exec-cmd.h
  INSTALL /home/mingo/tip/tools/perf/libsubcmd/include/subcmd/help.h
  INSTALL /home/mingo/tip/tools/perf/libsubcmd/include/subcmd/pager.h
  GEN     perf-archive
  GEN     perf-iostat
  INSTALL /home/mingo/tip/tools/perf/libsubcmd/include/subcmd/parse-options.h
  CC      /home/mingo/tip/tools/perf/libsubcmd/exec-cmd.o
  INSTALL /home/mingo/tip/tools/perf/libsubcmd/include/subcmd/run-command.h
  CC      /home/mingo/tip/tools/perf/libsubcmd/help.o
  CC      /home/mingo/tip/tools/perf/libsubcmd/pager.o
  CC      /home/mingo/tip/tools/perf/libsubcmd/parse-options.o
  CC      /home/mingo/tip/tools/perf/libsubcmd/run-command.o
  CC      /home/mingo/tip/tools/perf/libsubcmd/sigchain.o
  CC      /home/mingo/tip/tools/perf/libsubcmd/subcmd-config.o
  INSTALL libsubcmd_headers
  GEN      doc.dep
  INSTALL /home/mingo/tip/tools/perf/libapi/include/api/cpu.h
  INSTALL /home/mingo/tip/tools/perf/libapi/include/api/debug.h
  INSTALL /home/mingo/tip/tools/perf/libsymbol/include/symbol/kallsyms.h
  INSTALL /home/mingo/tip/tools/perf/libapi/include/api/io.h
  INSTALL /home/mingo/tip/tools/perf/libapi/include/api/fd/array.h
  INSTALL /home/mingo/tip/tools/perf/libperf/include/perf/bpf_perf.h
  LINK    dlfilters/dlfilter-show-cycles.so
  INSTALL /home/mingo/tip/tools/perf/libapi/include/api/fs/fs.h
  INSTALL /home/mingo/tip/tools/perf/libperf/include/perf/core.h
  CC      /home/mingo/tip/tools/perf/libsymbol/kallsyms.o
  INSTALL /home/mingo/tip/tools/perf/libperf/include/perf/cpumap.h
  INSTALL /home/mingo/tip/tools/perf/libapi/include/api/fs/tracing_path.h
  CC      /home/mingo/tip/tools/perf/libapi/cpu.o
  MKDIR   /home/mingo/tip/tools/perf/libapi/fd/
  INSTALL /home/mingo/tip/tools/perf/libperf/include/perf/threadmap.h
  CC      /home/mingo/tip/tools/perf/libapi/debug.o
  CC      /home/mingo/tip/tools/perf/libperf/core.o
  INSTALL /home/mingo/tip/tools/perf/libperf/include/perf/evlist.h
  MKDIR   /home/mingo/tip/tools/perf/libapi/fs/
  INSTALL /home/mingo/tip/tools/perf/libperf/include/perf/evsel.h
  CC      /home/mingo/tip/tools/perf/libperf/cpumap.o
  CC      /home/mingo/tip/tools/perf/libapi/str_error_r.o
  INSTALL /home/mingo/tip/tools/perf/libperf/include/perf/event.h
  MKDIR   /home/mingo/tip/tools/perf/libapi/fs/
  INSTALL /home/mingo/tip/tools/perf/libperf/include/perf/mmap.h
  CC      /home/mingo/tip/tools/perf/libperf/threadmap.o
  MKDIR   /home/mingo/tip/tools/perf/libapi/fs/
  INSTALL /home/mingo/tip/tools/perf/libperf/include/internal/cpumap.h
  CC      /home/mingo/tip/tools/perf/libperf/evsel.o
  INSTALL /home/mingo/tip/tools/perf/libperf/include/internal/evlist.h
  INSTALL /home/mingo/tip/tools/perf/libperf/include/internal/evsel.h
  CC      /home/mingo/tip/tools/perf/libapi/fd/array.o
  CC      /home/mingo/tip/tools/perf/libperf/evlist.o
  CC      /home/mingo/tip/tools/perf/libapi/fs/fs.o
  INSTALL /home/mingo/tip/tools/perf/libperf/include/internal/lib.h
  INSTALL libsymbol_headers
  CC      /home/mingo/tip/tools/perf/libperf/mmap.o
  INSTALL /home/mingo/tip/tools/perf/libperf/include/internal/mmap.h
  INSTALL /home/mingo/tip/tools/perf/libperf/include/internal/rc_check.h
  CC      /home/mingo/tip/tools/perf/libapi/fs/tracing_path.o
  INSTALL libapi_headers
  CC      /home/mingo/tip/tools/perf/libperf/zalloc.o
  INSTALL /home/mingo/tip/tools/perf/libperf/include/internal/threadmap.h
  CC      /home/mingo/tip/tools/perf/libapi/fs/cgroup.o
  INSTALL /home/mingo/tip/tools/perf/libperf/include/internal/xyarray.h
  CC      /home/mingo/tip/tools/perf/libperf/xyarray.o
  CC      /home/mingo/tip/tools/perf/libperf/lib.o
  GEN     /home/mingo/tip/tools/perf/libbpf/bpf_helper_defs.h
  INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/bpf.h
  INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/libbpf.h
  INSTALL libperf_headers
  INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/btf.h
  INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/libbpf_common.h
  INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/libbpf_legacy.h
  INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/bpf_helpers.h
  INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/bpf_tracing.h
  INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/bpf_endian.h
  INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/bpf_core_read.h
  INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/skel_internal.h
  INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/libbpf_version.h
  INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/usdt.bpf.h
  LINK    dlfilters/dlfilter-test-api-v2.so
  LINK    dlfilters/dlfilter-test-api-v0.so
  LD      /home/mingo/tip/tools/perf/libapi/fd/libapi-in.o
  INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/bpf_helper_defs.h
  MKDIR   /home/mingo/tip/tools/perf/libbpf/staticobjs/
  MKDIR   /home/mingo/tip/tools/perf/libbpf/staticobjs/
  MKDIR   /home/mingo/tip/tools/perf/libbpf/staticobjs/
  MKDIR   /home/mingo/tip/tools/perf/libbpf/staticobjs/
  MKDIR   /home/mingo/tip/tools/perf/libbpf/staticobjs/
  MKDIR   /home/mingo/tip/tools/perf/libbpf/staticobjs/
  INSTALL libbpf_headers
  CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/netlink.o
  CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/bpf.o
  CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/libbpf.o
  LD      /home/mingo/tip/tools/perf/libsymbol/libsymbol-in.o
  CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/btf.o
  CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/nlattr.o
  CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/libbpf_errno.o
  CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/str_error.o
  CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/bpf_prog_linfo.o
  CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/libbpf_probes.o
  CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/hashmap.o
  CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/btf_dump.o
  CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/ringbuf.o
  CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/strset.o
  CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/linker.o
  ASCIIDOC perf-annotate.xml
  CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/gen_loader.o
  CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/relo_core.o
  CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/usdt.o
  CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/zip.o
  CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/elf.o
  AR      /home/mingo/tip/tools/perf/libsymbol/libsymbol.a
  CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/features.o
  LD      /home/mingo/tip/tools/perf/libapi/fs/libapi-in.o
  LD      /home/mingo/tip/tools/perf/libapi/libapi-in.o
  LD      /home/mingo/tip/tools/perf/libperf/libperf-in.o
  AR      /home/mingo/tip/tools/perf/libperf/libperf.a
  AR      /home/mingo/tip/tools/perf/libapi/libapi.a
  LD      jvmti/jvmti-in.o
  LINK    libperf-jvmti.so
  LD      /home/mingo/tip/tools/perf/libsubcmd/libsubcmd-in.o
  AR      /home/mingo/tip/tools/perf/libsubcmd/libsubcmd.a
  ASCIIDOC perf-archive.xml
  GEN     python/perf.cpython-311-x86_64-linux-gnu.so
  ASCIIDOC perf-arm-spe.xml
  ASCIIDOC perf-bench.xml
  ASCIIDOC perf-buildid-cache.xml
  ASCIIDOC perf-buildid-list.xml
  ASCIIDOC perf-c2c.xml
  ASCIIDOC perf-config.xml
  ASCIIDOC perf-daemon.xml
  ASCIIDOC perf-data.xml
  ASCIIDOC perf-diff.xml
  ASCIIDOC perf-dlfilter.xml
^Cmake[2]: *** [Makefile.perf:1121: /home/mingo/tip/tools/perf/util/bpf_skel/.tmp/bootstrap/bpftool] Interrupt
make[4]: *** [/home/mingo/tip/tools/build/Makefile.build:105: /home/mingo/tip/tools/perf/libbpf/staticobjs/libbpf.o] Interrupt
make[3]: *** [Makefile:157: /home/mingo/tip/tools/perf/libbpf/staticobjs/libbpf-in.o] Interrupt
interrupted
make[2]: *** [Makefile.perf:868: /home/mingo/tip/tools/perf/libbpf/libbpf.a] Interrupt
make[3]: *** [Makefile:275: perf-dlfilter.xml] Interrupt
make[3]: *** [Makefile:275: perf-diff.xml] Interrupt
make[2]: *** [Makefile.perf:1072: try-install-man] Interrupt
make[2]: *** [Makefile.perf:681: python/perf.cpython-311-x86_64-linux-gnu.so] Interrupt
make[1]: *** [Makefile.perf:264: sub-make] Interrupt
make: *** [Makefile:113: install] Interrupt

kepler:~/tip/tools/perf> make clean install
Makefile.perf:1149: *** Missing bpftool input for generating vmlinux.h.  Stop.
make: *** [Makefile:90: clean] Error 2
kepler:~/tip/tools/perf> 

