Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B5637B02E;
	Wed, 20 May 2026 21:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779311615; cv=none; b=BNmxv38vPmXYlFx1WrKE49pOrzc3DjnSTLPxKbggGhJ4pZ4KuPusmp1ebDZUJsty6nN7C07IM1DA5NypkwWinp6/MnErGizS82dwS2iHOFrejAu4reE0+iYBAFNJMazKKhgffB6J8CbyrsUImTsaf5FGdXc3hDMf6e/1Wx00IoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779311615; c=relaxed/simple;
	bh=ke8ixoyguChRZ9IqmR3zBR+sSovoN1kALB/yNDFKIWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPak+GUZsT/ZnulJBvj9qO8uDWVgj24mE5LunCfgGlQEmd06g+sGvv01p9g8gks4V6aSji9uEl3p+emyIIimOJcCOHdIcaoG+MA3bKe3U7b8LCCX9HJ3pipoMxEvRPilvA7sSeBIx5ZxVZfKYp7rde6KL4YyAryzp8uqzbmKOKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPdROupg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPdROupg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFFA1F000E9;
	Wed, 20 May 2026 21:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779311613;
	bh=I9IAqMQolUO24RzI+RM+vJtReK7XRtnYL+163im71aA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jPdROupgSANh30pIntC4TPZTmGxqa8faki7FDVYX9HvmcTRVACfv+4WBmkG/5ELuo
	 WiC2QtNBXOWVTbRTW0sP63qn9nW8KY4dyJt2yHjwAmGH+BAL3C0POirgQn4ocR/49o
	 n+ZijlMYn7NI8/bpnZR0Q2PFuE21nRCUJh+Dx1fZ/f26W1OVH9wH7AJdu4QJ56Ocm3
	 rEXo1+X/4A809dh/CBvTI1bNatdyRHNcyAF/rDArTeWNRQrGpse7o6bRKEPd/x6VYV
	 UWMghUHHXptDVi2CkU+7DRwCrWijeXKc0dscCfhZQnuYuevW1XhWqtRQpj0QUcIz8L
	 MPps3Sug5yp5A==
Date: Wed, 20 May 2026 18:13:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
	ak@linux.intel.com, alex@ghiti.fr,
	alexander.shishkin@linux.intel.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com,
	blakejones@google.com, ctshao@google.com,
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com,
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com,
	james.clark@linaro.org, jolsa@kernel.org,
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn,
	palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org,
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn,
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com,
	zhouquan@iscas.ac.cn
Subject: Re: [PATCH v14 00/32] perf tools: Add evsel to perf_sample
Message-ID: <ag4j-dzzaa2xMr4y@x1>
References: <20260512223001.2952848-1-irogers@google.com>
 <20260520190538.142018-1-irogers@google.com>
 <ag4IT7YfVyFjggK6@x1>
 <ag4PpWl-wV7SDpd5@x1>
 <CAP-5=fU3HG9Mh3g+9JUCgkcE-DhmW66JSBnU5K=33kpcwhN0Ug@mail.gmail.com>
 <ag4ecqF1PZg_u4Op@x1>
 <ag4e1BNQlZWVWISE@x1>
 <ag4f1iYyHdkpToXu@x1>
 <CAP-5=fWtx=B56xy+dDK33E8VTZ+4gBE=nLNf6ZdVZyQoAFLE6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWtx=B56xy+dDK33E8VTZ+4gBE=nLNf6ZdVZyQoAFLE6g@mail.gmail.com>

On Wed, May 20, 2026 at 02:01:03PM -0700, Ian Rogers wrote:
> On Wed, May 20, 2026 at 1:55 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Wed, May 20, 2026 at 05:51:36PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Wed, May 20, 2026 at 05:49:57PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > On Wed, May 20, 2026 at 01:40:48PM -0700, Ian Rogers wrote:
> > > > > On Wed, May 20, 2026 at 12:46 PM Arnaldo Carvalho de Melo
> > > > > <acme@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, May 20, 2026 at 04:15:30PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > > > On Wed, May 20, 2026 at 12:05:06PM -0700, Ian Rogers wrote:
> > > > > > > > Nearly all perf code ends up passing an evsel with the perf_sample,
> > > > > > > > which is problematic if you want to rewrite the evsel (such as with
> > > > > > > > off-CPU processing) because all uses of the evsel need to be fixed
> > > > > > > > up. Since the perf_sample now carries its own resolved evsel pointer,
> > > > > > > > passing evsel separately is redundant and error-prone (allowing
> > > > > > > > parameter divergence bugs).
> > > > > > > >
> > > > > > > > This series cleans up the redundant evsel parameter across all perf
> > > > > > > > tool subcommands and APIs, ensuring that tools uniformly retrieve
> > > > > > > > event attributes directly from the sample itself. This simplifies
> > > > > > > > function signatures and improves API consistency.
> > > > > > > >
> > > > > > > > Additionally, this series incorporates subsequent memory safety
> > > > > > > > improvements, robust bounds checking, and memory leak corrections
> > > > > > > > prompted by address sanitizers and Sashiko code reviews.
> > > > > > > >
> > > > > > > > The original combined RFC patch:
> > > > > > > > https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@google.com/
> > > > > > > > was split up per reviewer requests.
> > > > > > > >
> > > > > > > > v14:
> > > > > > > >  - Incorporate Acked-by tags from Namhyung Kim.
> > > > > > > >  - Re-polish and expand commit descriptions to provide thorough explanations
> > > > > > > >    of the changes and their rationale.
> > > > > > >
> > > > > > > Thanks, tentatively applying it to perf-tools-next, for v7.2.
> > > > > >
> > > > > > Had to apply a minor fixup for a conflict with anoter patch series from
> > > > > > you, the LBR one.
> > > > >
> > > > > Sorry for that and thanks for dealing with the conflict! Any chance
> > > > > you could push to tmp.perf-tools-next? I have some other series that
> > > > > will conflict and it would be nice to rebase those changes there.
> > > >
> > > > I just removed the last two patches, the ones for kwork, as:
> > > >
> > > > + make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= NO_LIBELF=1 -C tools/perf O=/tmp/build/perf
> > > > make: Entering directory '/git/perf-7.1.0-rc2/tools/perf'
> > > >   BUILD:   Doing 'make -j32' parallel build
> > > > Makefile.config:647: Warning: Disabled BPF skeletons as libelf is required by bpftool
> > > > Makefile.config:745: Disabling post unwind, no support found.
> > > > Makefile.config:856: Missing python setuptools, the python binding won't be built, please install python3-setuptools or equivalent
> > > > Makefile.config:1045: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> > > > Makefile.config:1110: libpfm4 not found, disables libpfm4 support. Please install libpfm-devel or libpfm4-dev
> > > > Makefile.config:1135: Rust is not found. Test workloads with rust are disabled.
> > > >
> > > > Auto-detecting system features:
> > > > ...                                   libdw: [ on  ]
> > > > ...                                   glibc: [ on  ]
> > > > ...                                  libelf: [ on  ]
> > > > ...                                 libnuma: [ on  ]
> > > > ...                  numa_num_possible_cpus: [ on  ]
> > > > ...                               libpython: [ on  ]
> > > > ...                             libcapstone: [ on  ]
> > > > ...                               llvm-perf: [ on  ]
> > > > ...                                    zlib: [ on  ]
> > > > ...                                    lzma: [ on  ]
> > > > ...                                     bpf: [ on  ]
> > > > ...                                  libaio: [ on  ]
> > > > ...                                 libzstd: [ on  ]
> > > > ...                              libopenssl: [ on  ]
> > > > ...                                    rust: [ OFF ]
> > > >
> > > >   CC      /tmp/build/perf/dlfilters/dlfilter-test-api-v0.o
> > > > <SNIP>
> > > >   LINK    /tmp/build/perf/perf
> > > > /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `work_pop_atom':
> > > > builtin-kwork.c:(.text+0x59c92): undefined reference to `work_exit'
> > > > /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `work_push_atom.constprop.0':
> > > > builtin-kwork.c:(.text+0x5aba8): undefined reference to `work_exit'
> > > > /usr/bin/ld: /tmp/build/perf/perf-in.o: in function `cmd_kwork':
> > > > (.text+0x5bb4b): undefined reference to `work_exit'
> > > > /usr/bin/ld: (.text+0x5bbae): undefined reference to `work_exit'
> > > > /usr/bin/ld: (.text+0x5c3b2): undefined reference to `work_exit'
> > > > collect2: error: ld returned 1 exit status
> > > > make[2]: *** [Makefile.perf:586: /tmp/build/perf/perf] Error 1
> > > > make[1]: *** [Makefile.perf:289: sub-make] Error 2
> > > > make: *** [Makefile:76: all] Error 2
> > > > make: Leaving directory '/git/perf-7.1.0-rc2/tools/perf'
> > > > + exit 1
> > > > toolsbuilder@five:~$
> > > >
> > > >
> > > > I'm doing some more tests, just a moment and I'll push what I have to
> > > > tmp.perf-tools-next.
> > >
> > > Also:
> > >
> > > toolsbuilder@five:~$ cat dm.log/almalinux\:8
> > > <SNIP>
> > > OLLECT_GCC=gcc
> > > COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-redhat-linux/8/lto-wrapper
> > > OFFLOAD_TARGET_NAMES=nvptx-none
> > > OFFLOAD_TARGET_DEFAULT=1
> > > Target: x86_64-redhat-linux
> > > Configured with: ../configure --enable-bootstrap --enable-languages=c,c++,fortran,lto --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --with-bugurl=http://bugs.almalinux.org/ --enable-shared --enable-threads=posix --enable-checking=release --enable-multilib --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-gcc-major-version-only --with-linker-hash-style=gnu --enable-plugin --enable-initfini-array --with-isl --disable-libmpx --enable-offload-targets=nvptx-none --without-cuda-driver --enable-gnu-indirect-function --enable-cet --with-tune=generic --with-arch_32=x86-64 --build=x86_64-redhat-linux
> > > Thread model: posix
> > > gcc version 8.5.0 20210514 (Red Hat 8.5.0-28) (GCC)
> > > + make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= -C tools/perf O=/tmp/build/perf
> > > make: Entering directory '/git/perf-7.1.0-rc2/tools/perf'
> > >   BUILD:   Doing 'make -j32' parallel build
> > > Makefile.config:1045: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
> > > Makefile.config:1061: No libcapstone found, disables disasm engine support for 'perf script', please install libcapstone-dev/capstone-devel
> > > Makefile.config:1110: libpfm4 not found, disables libpfm4 support. Please install libpfm-devel or libpfm4-dev
> > > Makefile.config:1135: Rust is not found. Test workloads with rust are disabled.
> > >
> > > Auto-detecting system features:
> > > ...                                   libdw: [ on  ]
> > > ...                                   glibc: [ on  ]
> > > ...                                  libelf: [ on  ]
> > > ...                                 libnuma: [ on  ]
> > > ...                  numa_num_possible_cpus: [ on  ]
> > > ...                               libpython: [ on  ]
> > > ...                             libcapstone: [ OFF ]
> > > ...                               llvm-perf: [ on  ]
> > > ...                                    zlib: [ on  ]
> > > ...                                    lzma: [ on  ]
> > > ...                                     bpf: [ on  ]
> > > ...                                  libaio: [ on  ]
> > > ...                                 libzstd: [ on  ]
> > > ...                              libopenssl: [ on  ]
> > > ...                                    rust: [ OFF ]
> > >
> > >   CC      /tmp/build/perf/dlfilters/dlfilter-test-api-v0.o
> > >   CC      /tmp/build/perf/dlfilters/dlfilter-test-api-v2.o
> > > <SNIP>
> > >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/cache.json
> > >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/counter.json
> > >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/floating-point.json
> > >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/frontend.json
> > >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/memory.json
> > >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/other.json
> > >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/pipeline.json
> > >   COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/virtual-memory.json
> > >   GEN     /tmp/build/perf/pmu-events/test-empty-pmu-events.c
> > > Traceback (most recent call last):
> > >   File "pmu-events/jevents.py", line 1524, in <module>
> > >     main()
> > >   File "pmu-events/jevents.py", line 1487, in main
> > >     with concurrent.futures.ProcessPoolExecutor(initializer=_init_worker, initargs=(_arch_std_events,)) as executor:
> > > TypeError: __init__() got an unexpected keyword argument 'initializer'
> > > make[3]: *** [pmu-events/Build:176: /tmp/build/perf/pmu-events/test-empty-pmu-events.c] Error 1
> > > make[3]: *** Deleting file '/tmp/build/perf/pmu-events/test-empty-pmu-events.c'
> > > make[2]: *** [Makefile.perf:554: /tmp/build/perf/pmu-events/pmu-events-in.o] Error 2
> > > make[2]: *** Waiting for unfinished jobs....
> >
> > But:
> >
> > toolsbuilder@five:~$ export BUILD_TARBALL=http://192.168.86.5/perf/perf-7.1.0-rc2.tar.xz
> > toolsbuilder@five:~$ time dm
> >    1     8.77 almalinux:8                   : FAIL gcc version 8.5.0 20210514 (Red Hat 8.5.0-28) (GCC)
> >    2    84.96 almalinux:9                   : Ok   gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-11) , clang version 20.1.8 (AlmaLinux OS Foundation 20.1.8-3.el9) flex 2.6.4
> >    3:  103.23 almalinux:9-i386              : Ok   gcc (GCC) 11.4.1 20231218 (Red Hat 11.4.1-3) , clang version 17.0.6 (AlmaLinux OS Foundation 17.0.6-5.el9) flex 2.6.4
> >    4    90.91 almalinux:10                  : Ok   gcc (GCC) 14.3.1 20250617 (Red Hat 14.3.1-2) , clang version 20.1.8 (AlmaLinux OS Foundation 20.1.8-1.el10.alma.1) flex 2.6.4
> >    5   118.21 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1 flex 2.6.4
> > ...
> 
> You can drop the parallelize jevent.py changes and I'll follow up.
> Sorry for the breakage.

It was just that almalinux:8 so far, its an old system, so I'm keeping
it to see what other systems fail, if any.

So far:

toolsbuilder@five:~$ export BUILD_TARBALL=http://192.168.86.5/perf/perf-7.1.0-rc2.tar.xz
toolsbuilder@five:~$ time dm
   1     8.77 almalinux:8                   : FAIL gcc version 8.5.0 20210514 (Red Hat 8.5.0-28) (GCC)
   2    84.96 almalinux:9                   : Ok   gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-11) , clang version 20.1.8 (AlmaLinux OS Foundation 20.1.8-3.el9) flex 2.6.4
   3: almalinux:9-i386WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
WARNING: image platform (linux/386) does not match the expected platform (linux/amd64)
   103.23 almalinux:9-i386              : Ok   gcc (GCC) 11.4.1 20231218 (Red Hat 11.4.1-3) , clang version 17.0.6 (AlmaLinux OS Foundation 17.0.6-5.el9) flex 2.6.4
   4    90.91 almalinux:10                  : Ok   gcc (GCC) 14.3.1 20250617 (Red Hat 14.3.1-2) , clang version 20.1.8 (AlmaLinux OS Foundation 20.1.8-1.el10.alma.1) flex 2.6.4
   5   118.21 alpine:3.16                   : Ok   gcc (Alpine 11.2.1_git20220219) 11.2.1 20220219 , Alpine clang version 13.0.1 flex 2.6.4
   6   106.13 alpine:3.17                   : Ok   gcc (Alpine 12.2.1_git20220924-r4) 12.2.1 20220924 , Alpine clang version 15.0.7 flex 2.6.4
   7   102.80 alpine:3.18                   : Ok   gcc (Alpine 12.2.1_git20220924-r10) 12.2.1 20220924 , Alpine clang version 16.0.6 flex 2.6.4
   8   114.48 alpine:3.19                   : Ok   gcc (Alpine 13.2.1_git20231014) 13.2.1 20231014 , Alpine clang version 17.0.5 flex 2.6.4
   9   109.53 alpine:3.20                   : Ok   gcc (Alpine 13.2.1_git20240309) 13.2.1 20240309 , Alpine clang version 17.0.6 flex 2.6.4
  10   116.20 alpine:3.22                   : Ok   gcc (Alpine 14.2.0) 14.2.0 , Alpine clang version 20.1.8 flex 2.6.4
  11   109.83 alpine:3.23                   : Ok   gcc (Alpine 15.2.0) 15.2.0 , Alpine clang version 21.1.2 flex 2.6.4
  12   119.23 alpine:edge                   : Ok   gcc (Alpine 14.2.0) 14.2.0 , Alpine clang version 19.1.4 flex 2.6.4
  13    93.22 amazonlinux:2023              : Ok   gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-5) , clang version 15.0.7 (AWS 15.0.7-3.amzn2023.0.4) flex 2.6.4
  14    93.40 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 20221121 (Red Hat 11.3.1-4) , clang version 15.0.6 (Amazon Linux 15.0.6-3.amzn2023.0.2) flex 2.6.4
  15   102.98 archlinux:base                : Ok   gcc (GCC) 15.2.1 20250813 , clang version 20.1.8 flex 2.6.4
  16     9.58 centos:stream                 : FAIL gcc version 8.5.0 20210514 (Red Hat 8.5.0-21) (GCC)
  17: clearlinux:latest

  COPY    /tmp/build/perf/ <- pmu-events/arch/x86/westmereex/virtual-memory.json
  GEN     /tmp/build/perf/pmu-events/test-empty-pmu-events.c
Traceback (most recent call last):
  File "pmu-events/jevents.py", line 1524, in <module>
    main()
  File "pmu-events/jevents.py", line 1487, in main
    with concurrent.futures.ProcessPoolExecutor(initializer=_init_worker, initargs=(_arch_std_events,)) as executor:
TypeError: __init__() got an unexpected keyword argument 'initializer'
make[3]: *** [pmu-events/Build:176: /tmp/build/perf/pmu-events/test-empty-pmu-events.c] Error 1
make[3]: *** Deleting file '/tmp/build/perf/pmu-events/test-empty-pmu-events.c'
make[2]: *** [Makefile.perf:554: /tmp/build/perf/pmu-events/pmu-events-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....

Auto-detecting system features:
...                         clang-bpf-co-re: [ on  ]
...                                    llvm: [ on  ]
...                                  libcap: [ on  ]
...                                  libbfd: [ on  ]

  MKDIR   /tmp/build/perf/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf


centos:stream is the bleeding edge, so I'll drop that as you suggested,
ok.

- Arnaldo
