Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844AC16BE2A
	for <linux-perf-users@vger.kernel.org>; Fri, 15 Nov 2024 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731661122; cv=none; b=aqCIlkhdNfnwrU5y3mJX5xLVOb6zYQRJvCsCdBc6J8fj7xtBwrv/YaOU1NRGHddrRRHbvV972wk7N6ZLony7nvjuT8ER1ogsAqW8lrgnH4N5DzH9HiFMgjs/DBi7JdSfDosq/dAjDUAn395SeXHl3318JVKkxX9K5D4Hz7hDze0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731661122; c=relaxed/simple;
	bh=F3rRncaUFSz9KP2PlIjJuXzmKCqopKWTS/4zd03MHGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/8loZ3MGL25T63eUNLYZZdvnUhndXzGfwpvlrm7LXv/z73enFgMpL9t8ryZOPHvV6wJ0zBB0thisXhw8KW2ivNZGKoYL3UiYI81PNC2L4LD0r+NW2nMIFVkRDUmfJdCW/BIpGwQJP4r18kjA/aegQjTJFI048eriJthUCJKTZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wl903H78; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wl903H78"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d18dff41cdso9769846d6.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Nov 2024 00:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731661119; x=1732265919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hTvd7b7485gQg20w2FAWXSpxL11RTvbkKInFvBAaKs=;
        b=Wl903H78aJl7TNRfLjTYsdxha2YKdeQl+Q/DtZGZqSVb6tfo1p8atrTpWUCQ4REanH
         PfntYv8nSmDqdIJ3IZcc+weqOkR9fCncHbPbifWP8r0OkqAw9BwK+SPO1uyLwdMlKSTX
         nT4L6TJuQkpLn3CvIG39FhdVtAMXIrGAgaVCTK2iWSXNZy3fO/kh6WrQM3qu8sYW56qv
         1Kd8yPe+82s1JhKUxCTqwyB6sL16WvOjav8o1ssQBZJCD72j0Cr3pxK9h5xGsITAW2Wt
         HaBRleCcRjCm2XYbrkZo1VtIIfTHMTSKaUncjzC7VmYE7LcJYKsBv4m5BhCJqBoo4+UR
         w1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731661119; x=1732265919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hTvd7b7485gQg20w2FAWXSpxL11RTvbkKInFvBAaKs=;
        b=GFgZV0SWfeklqFI/1kuhPIN7MXG7OXvXfZg3+CzCDlAdlzf2Re3bFd+GQxyYGpn8py
         /4nZ3giYpHICZf+8zaEA/DpkuWiOnz1X7fWHqeycNq81eJPfHyYUfQGndYLe7whEXz4R
         UTWrM7eDMgYUuk+v7KaQru0ujmPzFggfbXIfkxSVrHoR9hHR1WMZd1qXjRxH4yGxjDKh
         AyLXDbyZLk3bzq2tfHwoZ9GiHdbqc3ZpEnrTBLfCZPZuAikNAECI+GW3LPOECtx0vzMI
         wIeLSGFvNNyiCJGlN9SYMrwnaYoIVHJzUwN1gLAY0PKHy9iHlutUuqXpPSzcwxUC/SJX
         Yu4w==
X-Gm-Message-State: AOJu0Yy8mG6Y1X885IdO7KvQ6xvfiIYqXYPXu0EJwJijElLS0GfQJ5/U
	Dbib1ie3Jc+kUaaBiwSgU7ysHurbjobfxYWe6PmWZ33/Rpi775saCjTckOwMYDGNMwLO+C7WwZM
	a9dtR89uVBEUrXIWhDddeaI6pDI8=
X-Google-Smtp-Source: AGHT+IGk7L2guSjwMLTec3GYLi2TMWpWIK31awknw01jt4/X9tfHKS0TKMSnmWxHA376GihaZQbzItXarvBs/fcfTAw=
X-Received: by 2002:a05:6214:2c0c:b0:6d3:f8bf:b700 with SMTP id
 6a1803df08f44-6d3fb7b0116mr23897206d6.2.1731661118605; Fri, 15 Nov 2024
 00:58:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1731300662-5325-mlmmj-28e386a1@vger.kernel.org>
 <CACvH6ToqaADXOrJh8UpapnGtVkn3W+HYQ7kHK8ByQgin4jnFBg@mail.gmail.com> <CAP-5=fUACPpVUGunmADUd0OccamKAO=kDv4eb6u9q4XRCFwZdA@mail.gmail.com>
In-Reply-To: <CAP-5=fUACPpVUGunmADUd0OccamKAO=kDv4eb6u9q4XRCFwZdA@mail.gmail.com>
From: Deva Narayana Babu <dnb.ranjikaa@gmail.com>
Date: Fri, 15 Nov 2024 14:28:02 +0530
Message-ID: <CACvH6Tqbe9UMP44SJFXTU1SK70W1d34+zBsFwf8EejtjZ2XoCw@mail.gmail.com>
Subject: Re: HTML message rejected: Building perf from source, with changes in
 source code
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 10:08=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Thu, Nov 14, 2024 at 8:00=E2=80=AFAM Deva Narayana Babu
> <dnb.ranjikaa@gmail.com> wrote:
> >
> > Subject: Building perf from source, with changes in source code
> >
> > I use kernel `6.6.55` so when I tried to build perf from source, I was
> > getting the following error, and when I changed some code(diff output
> > given below) the build happened. Is this a bug?
> > =E2=9E=9C  perf make
> >             [....]
> >   CC      util/synthetic-events.o
> >   CC      util/data.o
> > util/thread.c: In function =E2=80=98thread__free_stitch_list=E2=80=99:
> > util/thread.c:481:17: error: implicit declaration of function
> > =E2=80=98map_symbol__exit=E2=80=99; did you mean =E2=80=98symbol__exit=
=E2=80=99?
> > [-Werror=3Dimplicit-function-declaration]
> >   481 |                 map_symbol__exit(&pos->cursor.ms);
> >       |                 ^~~~~~~~~~~~~~~~
> >       |                 symbol__exit
> > util/machine.c: In function =E2=80=98save_lbr_cursor_node=E2=80=99:
> > util/machine.c:2540:9: error: implicit declaration of function
> > =E2=80=98map_symbol__exit=E2=80=99; did you mean =E2=80=98symbol__exit=
=E2=80=99?
> > [-Werror=3Dimplicit-function-declaration]
> >  2540 |         map_symbol__exit(&lbr_stitch->prev_lbr_cursor[idx].ms);
> >       |         ^~~~~~~~~~~~~~~~
> >       |         symbol__exit
> >   CC      util/tsc.o
> >   CC      util/cloexec.o
> >   CC      util/call-path.o
> >   CC      util/rwsem.o
> >   CC      util/thread-stack.o
> >   CC      util/spark.o
> > cc1: all warnings being treated as errors
> >   CC      util/topdown.o
> > make[4]: *** [/home/dmacs/Downloads/linux-6.6.55/tools/build/Makefile.b=
uild:98:
> > util/thread.o] Error 1
> > make[4]: *** Waiting for unfinished jobs....
> > cc1: all warnings being treated as errors
> > make[4]: *** [/home/dmacs/Downloads/linux-6.6.55/tools/build/Makefile.b=
uild:97:
> > util/machine.o] Error 1
> > make[3]: *** [/home/dmacs/Downloads/linux-6.6.55/tools/build/Makefile.b=
uild:150:
> > util] Error 2
> > make[2]: *** [Makefile.perf:666: perf-in.o] Error 2
> > make[1]: *** [Makefile.perf:242: sub-make] Error 2
> > make: *** [Makefile:70: all] Error 2
> >
> >
> >  On inspection I found that the function/macro has been used but has
> > not been defined anywhere so I followed the compiler's directive and I
> > changed the function name to what was mentioned and `perf` got built.
> > The diff is given below:
> >
> > =E2=9E=9C  tools diff -r /home/dmacs/src/linux-6.6.55/tools/perf/ ./per=
f
> > Binary files /home/dmacs/src/linux-6.6.55/tools/perf/pmu-events/__pycac=
he__/metric.cpython-310.pyc
> > and ./perf/pmu-events/__pycache__/metric.cpython-310.pyc differ
> > diff --color -r /home/dmacs/src/linux-6.6.55/tools/perf/util/machine.c
> > ./perf/util/machine.c
> > 2540c2540
> > < symbol__exit();
> > ---
> > > map_symbol__exit(&lbr_stitch->prev_lbr_cursor[idx].ms);
> > 2841c2841
> > < symbol__exit();
> > ---
> > > map_symbol__exit(&stitch_node->cursor.ms);
> > diff --color -r /home/dmacs/src/linux-6.6.55/tools/perf/util/thread.c
> > ./perf/util/thread.c
> > 481c481
> > < symbol__exit();
> > ---
> > > map_symbol__exit(&pos->cursor.ms);
> > 492c492
> > < symbol__exit();
> > ---
> > > map_symbol__exit(&lbr_stitch->prev_lbr_cursor[i].ms);
>
> These errors are usually the result of a header file not being
> included. Perhaps you have an unusual build configuration that is
> causing the #include to be missed due to #ifdefs. This is a bug but I
> can't see why it would happen from your output. Which branch are you
> building? Development is happening in the perf-tools-next branch here:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/
> It would be nice to see the feature detection part of the build log.
>
> I remember Howard Chu creating docs covering topics like this. We
> should link them into the wiki:
> https://perfwiki.github.io/main/
>
> Thanks,
> Ian

I downloaded the source files from kernel.org, and custom built it. I
did not choose any branch specifically.
This is the initial part of the build log including feature detection.
=E2=9E=9C  perf make
  BUILD:   Doing 'make -j6' parallel build
  HOSTCC  fixdep.o
  HOSTLD  fixdep-in.o
  LINK    fixdep
Warning: Kernel ABI header differences:
  diff -u tools/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h
  diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
  diff -u tools/include/uapi/linux/mount.h include/uapi/linux/mount.h
  diff -u tools/arch/x86/include/asm/disabled-features.h
arch/x86/include/asm/disabled-features.h
  diff -u tools/arch/x86/include/asm/required-features.h
arch/x86/include/asm/required-features.h
  diff -u tools/arch/x86/include/asm/cpufeatures.h
arch/x86/include/asm/cpufeatures.h
  diff -u tools/arch/x86/include/asm/msr-index.h
arch/x86/include/asm/msr-index.h
  diff -u tools/arch/x86/include/uapi/asm/prctl.h
arch/x86/include/uapi/asm/prctl.h
  diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h
arch/arm64/include/uapi/asm/perf_regs.h
  diff -u tools/arch/s390/include/uapi/asm/kvm.h
arch/s390/include/uapi/asm/kvm.h
  diff -u tools/include/uapi/asm-generic/unistd.h
include/uapi/asm-generic/unistd.h
  diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
  diff -u tools/arch/x86/lib/memset_64.S arch/x86/lib/memset_64.S
  diff -u tools/arch/arm64/include/asm/cputype.h
arch/arm64/include/asm/cputype.h
  diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
arch/powerpc/kernel/syscalls/syscall.tbl
  diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl
arch/s390/kernel/syscalls/syscall.tbl
  diff -u tools/perf/trace/beauty/include/linux/socket.h include/linux/sock=
et.h

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
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

  GEN     common-cmds.h
  PERF_VERSION =3D 6.6.55
  CC      jvmti/libjvmti.o
  GEN     perf-archive
  GEN     perf-iostat
  CC      dlfilters/dlfilter-test-api-v0.o
  CC      jvmti/jvmti_agent.o
  CC      dlfilters/dlfilter-test-api-v2.o
  CC      jvmti/libstring.o
  CC      dlfilters/dlfilter-show-cycles.o
  CC      jvmti/libctype.o
  MKDIR   /home/dmacs/Downloads/linux-6.6.55/tools/perf/libapi/fd/
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libapi/fd/array.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/core.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/cpumap.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libsubcmd/exec-cmd.=
o
  LD      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libapi/fd/libapi-in=
.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libsubcmd/help.o
  MKDIR   /home/dmacs/Downloads/linux-6.6.55/tools/perf/libapi/fs/
  LD      jvmti/jvmti-in.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libapi/fs/fs.o
  MKDIR   /home/dmacs/Downloads/linux-6.6.55/tools/perf/libapi/fs/
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libapi/fs/tracing_p=
ath.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libapi/fs/cgroup.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/threadmap.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libsymbol/kallsyms.=
o
  GEN     /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/bpf_helper_d=
efs.h
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/evsel.o
  LD      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libapi/fs/libapi-in=
.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libapi/cpu.o
  LD      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libsymbol/libsymbol=
-in.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libapi/debug.o
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libsymbol/include/s=
ymbol/kallsyms.h
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/evlist.o
  AR      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libsymbol/libsymbol=
.a
  INSTALL libsymbol_headers
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libapi/str_error_r.=
o
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/include/bpf/=
bpf.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/include/bpf/=
libbpf.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/include/bpf/=
btf.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/include/bpf/=
libbpf_common.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/include/bpf/=
libbpf_legacy.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/include/bpf/=
bpf_helpers.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/include/bpf/=
bpf_tracing.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libapi/include/api/=
cpu.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libapi/include/api/=
debug.h
  LINK    libperf-jvmti.so
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libapi/include/api/=
io.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/include/bpf/=
bpf_endian.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libapi/include/api/=
fd/array.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/include/bpf/=
bpf_core_read.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/include/bpf/=
skel_internal.h
  LD      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libapi/libapi-in.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/mmap.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libsubcmd/pager.o
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/include/per=
f/bpf_perf.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/include/bpf/=
libbpf_version.h
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/zalloc.o
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/include/bpf/=
usdt.bpf.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libapi/include/api/=
fs/fs.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libapi/include/api/=
fs/tracing_path.h
  AR      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libapi/libapi.a
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/xyarray.o
  INSTALL libapi_headers
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/lib.o
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/include/bpf/=
bpf_helper_defs.h
  INSTALL libbpf_headers
  MKDIR   /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/staticobjs/
  LINK    dlfilters/dlfilter-test-api-v0.so
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/staticobjs/l=
ibbpf.o
  LINK    dlfilters/dlfilter-test-api-v2.so
  MKDIR   /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/staticobjs/
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/staticobjs/b=
pf.o
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libsubcmd/include/s=
ubcmd/exec-cmd.h
  LINK    dlfilters/dlfilter-show-cycles.so
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/include/per=
f/core.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libsubcmd/include/s=
ubcmd/help.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libsubcmd/include/s=
ubcmd/pager.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libsubcmd/include/s=
ubcmd/parse-options.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/include/per=
f/cpumap.h
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/staticobjs/n=
lattr.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libsubcmd/parse-opt=
ions.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libsubcmd/run-comma=
nd.o
  LD      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/libperf-in.=
o
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/include/per=
f/threadmap.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/include/per=
f/evlist.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/include/per=
f/evsel.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/include/per=
f/event.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/include/per=
f/mmap.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/include/int=
ernal/cpumap.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/include/int=
ernal/evlist.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/include/int=
ernal/evsel.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/include/int=
ernal/lib.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/include/int=
ernal/mmap.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/include/int=
ernal/rc_check.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/include/int=
ernal/threadmap.h
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/include/int=
ernal/xyarray.h
  AR      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libperf/libperf.a
  INSTALL libperf_headers
  INSTALL /home/dmacs/Downloads/linux-6.6.55/tools/perf/libsubcmd/include/s=
ubcmd/run-command.h
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libsubcmd/sigchain.=
o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/staticobjs/b=
tf.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libsubcmd/subcmd-co=
nfig.o
  INSTALL libsubcmd_headers
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/staticobjs/l=
ibbpf_errno.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/staticobjs/s=
tr_error.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/staticobjs/n=
etlink.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/staticobjs/b=
pf_prog_linfo.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/staticobjs/l=
ibbpf_probes.o
  LD      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libsubcmd/libsubcmd=
-in.o
  AR      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libsubcmd/libsubcmd=
.a
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/staticobjs/h=
ashmap.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/staticobjs/b=
tf_dump.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/staticobjs/r=
ingbuf.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/staticobjs/s=
trset.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/staticobjs/l=
inker.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/staticobjs/g=
en_loader.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/staticobjs/r=
elo_core.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/staticobjs/u=
sdt.o
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/staticobjs/z=
ip.o
  GEN     python/perf.cpython-310-x86_64-linux-gnu.so
  CC      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/staticobjs/e=
lf.o
  LD      /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/staticobjs/l=
ibbpf-in.o
  LINK    /home/dmacs/Downloads/linux-6.6.55/tools/perf/libbpf/libbpf.a
  CC      builtin-bench.o
  CC      builtin-annotate.o
  CC      builtin-config.o
  CC      builtin-diff.o
  TEST    pmu-events/metric_test.log
  CC      builtin-evlist.o
  CC      builtin-ftrace.o
  CC      builtin-help.o
  GEN     pmu-events/pmu-events.c
  CC      builtin-buildid-list.o
  CC      builtin-buildid-cache.o
  CC      builtin-kallsyms.o
  CC      builtin-list.o
  CC      builtin-record.o
  CC      builtin-report.o
  CC      builtin-stat.o
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
  CC      trace/beauty/fcntl.o
  CC      trace/beauty/flock.o
  CC      bench/sched-messaging.o
  CC      trace/beauty/fsmount.o
  CC      trace/beauty/fspick.o
  CC      trace/beauty/ioctl.o
  CC      bench/sched-pipe.o
  CC      trace/beauty/kcmp.o
  CC      bench/sched-seccomp-notify.o
  CC      bench/syscall.o
  CC      trace/beauty/mount_flags.o
  CC      trace/beauty/move_mount.o
  CC      bench/mem-functions.o
  CC      bench/futex-hash.o
  CC      trace/beauty/pkey_alloc.o
  CC      tests/builtin-test.o
  CC      bench/futex-wake.o
  CC      trace/beauty/arch_prctl.o
  CC      tests/builtin-test-list.o
  CC      trace/beauty/prctl.o
  CC      trace/beauty/renameat.o
  CC      tests/parse-events.o
  CC      trace/beauty/sockaddr.o
  CC      bench/futex-wake-parallel.o
  CC      trace/beauty/socket.o
  CC      tests/dso-data.o
  CC      trace/beauty/statx.o
  CC      bench/futex-requeue.o
  CC      trace/beauty/sync_file_range.o
  CC      trace/beauty/timespec.o
  CC      bench/futex-lock-pi.o
  CC      bench/epoll-wait.o
  CC      pmu-events/pmu-events.o
  CC      trace/beauty/tracepoints/x86_irq_vectors.o
  CC      trace/beauty/tracepoints/x86_msr.o
  CC      tests/attr.o
  LD      trace/beauty/tracepoints/perf-in.o
  LD      trace/beauty/perf-in.o
  CC      util/arm64-frame-pointer-unwind-support.o
  CC      bench/epoll-ctl.o
  CC      util/addr_location.o
  CC      bench/synthesize.o
  CC      util/annotate.o
  CC      arch/common.o
  CC      arch/x86/util/header.o
  CC      bench/kallsyms-parse.o
  CC      bench/find-bit-bench.o
  CC      tests/vmlinux-kallsyms.o
  CC      arch/x86/util/tsc.o
  CC      bench/inject-buildid.o
  CC      arch/x86/util/pmu.o
  CC      util/block-info.o
  CC      tests/openat-syscall.o
  CC      arch/x86/util/kvm-stat.o
  CC      bench/evlist-open-close.o
  CC      tests/openat-syscall-all-cpus.o
  CC      arch/x86/util/perf_regs.o
  CC      tests/openat-syscall-tp-fields.o
  CC      bench/breakpoint.o
  CC      bench/pmu-scan.o
  CC      arch/x86/util/topdown.o
  CC      arch/x86/util/machine.o
  CC      bench/uprobe.o
  CC      tests/mmap-basic.o
  CC      arch/x86/tests/regs_load.o
  CC      arch/x86/tests/dwarf-unwind.o
  CC      arch/x86/util/event.o
  CC      bench/mem-memcpy-x86-64-asm.o
  CC      bench/mem-memset-x86-64-asm.o
  CC      arch/x86/tests/arch-tests.o
  CC      arch/x86/tests/sample-parsing.o
  CC      arch/x86/util/evlist.o
  CC      bench/numa.o
  CC      tests/perf-record.o
  CC      arch/x86/util/mem-events.o
  CC      arch/x86/tests/hybrid.o
  CC      arch/x86/util/evsel.o
  CC      tests/evsel-roundtrip-name.o
  CC      arch/x86/util/iostat.o
  CC      arch/x86/tests/intel-pt-test.o
  CC      tests/evsel-tp-sched.o
  CC      tests/fdarray.o
  CC      arch/x86/tests/bp-modify.o
  CC      util/block-range.o
  CC      arch/x86/util/env.o
  CC      tests/pmu.o
  CC      arch/x86/tests/amd-ibs-via-core-pmu.o
  CC      arch/x86/util/dwarf-regs.o
  CC      util/build-id.o
  CC      tests/pmu-events.o
  LD      bench/perf-in.o
  LD      arch/x86/tests/perf-in.o
  CC      arch/x86/util/unwind-libunwind.o
  CC      tests/hists_common.o
  CC      tests/hists_link.o
  CC      arch/x86/util/auxtrace.o
  CC      tests/hists_filter.o
  CC      util/cacheline.o
  CC      arch/x86/util/archinsn.o
  LD      pmu-events/pmu-events-in.o
  CC      arch/x86/util/intel-pt.o
  CC      arch/x86/util/intel-bts.o
  CC      tests/hists_output.o
  CC      tests/hists_cumulate.o
  CC      ui/setup.o
  CC      util/config.o
  CC      ui/helpline.o
  CC      util/copyfile.o
  CC      ui/progress.o
  CC      ui/util.o
  CC      util/ctype.o
  CC      util/db-export.o
  CC      ui/hist.o
  CC      ui/stdio/hist.o
  CC      tests/python-use.o
  CC      tests/bp_signal.o
  LD      arch/x86/util/perf-in.o
  LD      arch/x86/perf-in.o
  LD      arch/perf-in.o
  CC      tests/bp_signal_overflow.o
  CC      util/env.o
  CC      tests/bp_account.o
  CC      scripts/perl/Perf-Trace-Util/Context.o
  CC      scripts/python/Perf-Trace-Util/Context.o
  CC      tests/wp.o
  CC      tests/task-exit.o
  LD      scripts/python/Perf-Trace-Util/perf-in.o
  CC      tests/sw-clock.o
  CC      util/event.o
  CC      builtin-probe.o
  CC      tests/mmap-thread-lookup.o
  LD      scripts/perl/Perf-Trace-Util/perf-in.o
  LD      scripts/perf-in.o
  CC      tests/thread-maps-share.o
  CC      ui/browser.o
  CC      tests/switch-tracking.o
  CC      tests/keep-tracking.o
  CC      tests/code-reading.o
  CC      tests/sample-parsing.o
  CC      util/evlist.o
  CC      tests/parse-no-sample-id-all.o
  CC      perf.o
  CC      tests/kmod-path.o
  CC      tests/thread-map.o
  CC      ui/browsers/annotate.o
  CC      ui/tui/setup.o
  CC      tests/topology.o
  CC      tests/mem.o
  CC      ui/tui/util.o
  CC      ui/tui/helpline.o
  CC      util/sideband_evlist.o
  CC      util/evsel.o
  CC      tests/cpumap.o
  CC      ui/tui/progress.o
  CC      util/evsel_fprintf.o
  LD      ui/tui/perf-in.o
  CC      tests/stat.o
  CC      tests/event_update.o
  CC      tests/event-times.o
  CC      tests/expr.o
  CC      ui/browsers/hists.o
  CC      ui/browsers/map.o
  CC      tests/backward-ring-buffer.o
  CC      ui/browsers/scripts.o
  CC      util/perf_event_attr_fprintf.o
  CC      tests/sdt.o
  CC      ui/browsers/header.o
  CC      tests/is_printable_array.o
  CC      util/evswitch.o
  CC      tests/bitmap.o
  CC      ui/browsers/res_sample.o
  CC      tests/perf-hooks.o
  CC      util/find_bit.o
  CC      util/get_current_dir_name.o
  CC      util/levenshtein.o
  CC      tests/unit_number__scnprintf.o
  CC      tests/mem2node.o
  CC      tests/maps.o
  CC      tests/time-utils-test.o
  CC      util/mmap.o
  CC      tests/genelf.o
  CC      tests/api-io.o
  CC      tests/demangle-java-test.o
  CC      tests/demangle-ocaml-test.o
  CC      util/memswap.o
  CC      tests/pfm.o
  CC      tests/parse-metric.o
  BISON   util/parse-events-bison.c
  CC      util/print-events.o
  CC      tests/pe-file-parsing.o
  CC      tests/expand-cgroup.o
  CC      tests/perf-time-to-tsc.o
  CC      tests/dlfilter-test.o
  CC      util/tracepoint.o
  CC      util/perf_regs.o
  CC      tests/sigtrap.o
  CC      util/perf-regs-arch/perf_regs_aarch64.o
  CC      util/perf-regs-arch/perf_regs_arm.o
  CC      util/intel-pt-decoder/intel-pt-pkt-decoder.o
  CC      util/perf-regs-arch/perf_regs_csky.o
  CC      util/perf-regs-arch/perf_regs_loongarch.o
  CC      util/perf-regs-arch/perf_regs_mips.o
  CC      tests/event_groups.o
  CC      tests/symbols.o
  CC      util/perf-regs-arch/perf_regs_powerpc.o
  CC      util/arm-spe-decoder/arm-spe-pkt-decoder.o
  CC      util/perf-regs-arch/perf_regs_riscv.o
  CC      util/perf-regs-arch/perf_regs_s390.o
  GEN     util/intel-pt-decoder/inat-tables.c
  CC      tests/util.o
  CC      tests/dwarf-unwind.o
  CC      util/perf-regs-arch/perf_regs_x86.o
  LD      ui/browsers/perf-in.o
  LD      ui/perf-in.o
  CC      util/arm-spe-decoder/arm-spe-decoder.o
  CC      util/intel-pt-decoder/intel-pt-log.o
  CC      util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.o
  LD      util/perf-regs-arch/perf-in.o
  CC      util/intel-pt-decoder/intel-pt-decoder.o
  CC      util/scripting-engines/trace-event-perl.o
  LD      util/hisi-ptt-decoder/perf-in.o
  CC      util/path.o
  CC      tests/workloads/noploop.o
  LD      util/arm-spe-decoder/perf-in.o
  CC      util/scripting-engines/trace-event-python.o
  CC      util/print_binary.o
  CC      tests/workloads/thloop.o
  CC      util/rlimit.o
  CC      tests/workloads/leafloop.o
  CC      tests/workloads/sqrtloop.o
  CC      util/argv_split.o
  CC      util/rbtree.o
  CC      tests/workloads/brstack.o
  CC      tests/workloads/datasym.o
  CC      util/intel-pt-decoder/intel-pt-insn-decoder.o
  LD      tests/workloads/perf-in.o
  LD      tests/perf-in.o
  CC      util/libstring.o
  CC      util/bitmap.o
  CC      util/hweight.o
  CC      util/smt.o
  CC      util/strbuf.o
  CC      util/string.o
  CC      util/strlist.o
  CC      util/strfilter.o
  CC      util/top.o
  CC      util/usage.o
  CC      util/dso.o
  CC      util/dsos.o
  CC      util/symbol.o
  LD      util/scripting-engines/perf-in.o
  CC      util/symbol_fprintf.o
  CC      util/color.o
  CC      util/color_config.o
  CC      util/metricgroup.o
  CC      util/header.o
  CC      util/callchain.o
  LD      util/intel-pt-decoder/perf-in.o
  CC      util/values.o
  CC      util/debug.o
  CC      util/fncache.o
  CC      util/machine.o
  CC      util/map.o
util/machine.c: In function =E2=80=98save_lbr_cursor_node=E2=80=99:
util/machine.c:2540:9: error: implicit declaration of function
=E2=80=98map_symbol__exit=E2=80=99; did you mean =E2=80=98symbol__exit=E2=
=80=99?
[-Werror=3Dimplicit-function-declaration]
 2540 |         map_symbol__exit(&lbr_stitch->prev_lbr_cursor[idx].ms);
      |         ^~~~~~~~~~~~~~~~
      |         symbol__exit
  CC      util/maps.o
  CC      util/pstack.o
  CC      util/session.o
  CC      util/sample-raw.o
  CC      util/s390-sample-raw.o
  CC      util/amd-sample-raw.o
  CC      util/syscalltbl.o
  CC      util/ordered-events.o
  CC      util/namespaces.o
  CC      util/comm.o
  CC      util/thread.o
  CC      util/thread_map.o
  CC      util/parse-events-bison.o
util/thread.c: In function =E2=80=98thread__free_stitch_list=E2=80=99:
util/thread.c:481:17: error: implicit declaration of function
=E2=80=98map_symbol__exit=E2=80=99; did you mean =E2=80=98symbol__exit=E2=
=80=99?
[-Werror=3Dimplicit-function-declaration]
  481 |                 map_symbol__exit(&pos->cursor.ms);
      |                 ^~~~~~~~~~~~~~~~
      |                 symbol__exit
  BISON   util/pmu-bison.c
cc1: all warnings being treated as errors
  CC      util/pmus.o
make[4]: *** [/home/dmacs/Downloads/linux-6.6.55/tools/build/Makefile.build=
:98:
util/thread.o] Error 1
make[4]: *** Waiting for unfinished jobs....
cc1: all warnings being treated as errors
make[4]: *** [/home/dmacs/Downloads/linux-6.6.55/tools/build/Makefile.build=
:97:
util/machine.o] Error 1
make[3]: *** [/home/dmacs/Downloads/linux-6.6.55/tools/build/Makefile.build=
:150:
util] Error 2
make[2]: *** [Makefile.perf:666: perf-in.o] Error 2
make[1]: *** [Makefile.perf:242: sub-make] Error 2
make: *** [Makefile:72: all] Error 2
