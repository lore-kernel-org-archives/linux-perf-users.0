Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B895A3115B0
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Nov 2025 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764164661; cv=none; b=eozmqspjFioBJtUEwMB2wUmeFndw/HkPJhlGzea13GJtbX0SGtI4VLMW74gTqM9qVAIVjATU666L3y5/gcxZJ8jcz+Xd/a8zgob6R692OLLLXYbBbxbC7qnXXePV8CTCHvc3cJ76pYGbJT06u6iCXNh3zeFl4aDx7/9CQ/C2Cjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764164661; c=relaxed/simple;
	bh=OinEP2nBkvRJjtwnumDs0EuFl5iL7UTvHQQD2DP4tgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzyPlA1sNnk+GWRExpuaWiefsVeSoKeI0p9wIgCH5vt6KsK59dYLFSXa8ogYjbe8USP8l5ZeaxJZzzrb4IqXGSeTzUsrPJXbesumPk4gfX5HG4eCSZHKAliFEuRlibs7XEMvPExN8pzNdRYBvugqWX9FuEpcMsF4ExHiY3lXWII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyiZKckf; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyiZKckf"
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-37cef3ccb82so30267541fa.2
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Nov 2025 05:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764164657; x=1764769457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6a4gnhgmRHJOeae2LdFLY8ekseQQFdFvdjLKlWENoW8=;
        b=OyiZKckfXIbZYkXAA4Vrksiu0OGaw5pqPrlHYXYTWa4hX0NThlyEGbFyuIyUuWEoGE
         X5z9xYq3WzXP2C+mJof3vPcd2MUlWVSy7zJYixK6cfAyE2mAqsHpRIxKibs5J7PJEH1t
         ve4yg5rtXHGOtzDFmkGpxAXGzflh/Ef5dpX3EiII+YUNhHh6LDb6/8XtDHKVqfWb8/BB
         7SDUwam1qcSchUf0U7x0L440yw/79D5DNzSfBGVMX/BkW6tb/Znzija3dqJxGfzPARvU
         wekKqx0ZtypByiqZPu0LeMnnYGBevROWFC9QoWm20/97lt89WsCs8DFH1YdA0QFK0q/9
         conA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764164657; x=1764769457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6a4gnhgmRHJOeae2LdFLY8ekseQQFdFvdjLKlWENoW8=;
        b=NN/7LLcQaSgR+pFLurrBJhzgrqaS33BKzRcyKsahV/jGAnnZMk0nHETKKWAorOZ7cR
         JiWK/PTfMXJhncpnVyog+/w+4v9e40TUGFKoz1LQxRNc2RNBrQ6Vqz8TVtd37FwkZEO4
         VYMHx8OFC/FxJtG5T+O1dP8vq3GeDnUusj8ZJ9bLbhLttzx/eqpPYTmregmhN3vGPDYP
         FKzPGaRMxyXrpJFFj+fMJe1UnpwZTduzTXblJjrt1vwb4C0ZWLJCmoISI8MKjQgDEM2O
         En7iKH7By1BT3JqqmCQfKGvSrqb9spCheyctju6BeDIYXAStF88AS5nwINIXI/f7BOQZ
         BJMA==
X-Forwarded-Encrypted: i=1; AJvYcCXjwYdh40y34rOaJGGT0Kqh5REFVVE08BuE+Rlre5fLpNRyGZntlEm0JqCtPdOnLUDZavQqeXYe0HNOh4bku6tL@vger.kernel.org
X-Gm-Message-State: AOJu0YwhgIO5Tu1wiYPYSK5u2ZpT03aJSa0B0BTr+BZHs4yd0Uz/h92F
	S9XEKYh9aXX7Swmrx42sbVd21sa7bpsx2zJKMvagd9i7sT9uerJN3MRt5pFkt+hzRjpRND0cXcx
	KHwkUm/+crrXbyeKhiBA4cOQf9iKN2RA=
X-Gm-Gg: ASbGncugMoecfCyPEsBESim3nUpvLHgsU8ew6S3UAyhPiZiP3TvjhpoUjnWa15kIy2e
	XmYLlb2Zub42SmbQGL0K8APaCd+g6BGKXDlJ4zynJIjZ0HhFwCs68xWmHSeKThnDHE7aCw5cZGx
	ktu+h9mP7SNFjwLgzuvcRbAMf2T2IrSNDVDeIinOv9+G6/4/yAqt4RzZjKsMJRNa1JwqJ9jArCA
	T0ae5SKrjBbLeh/0QavLVKpLFBkjfF2YjBoFmw/YwAqRgWyqW06/yLVO02ytc+XRKlzsn4=
X-Google-Smtp-Source: AGHT+IHGOEoDNCJlMlpV9U+/OELUJTxNWU/AK3YrXc13Owns4j33OaMP8OgtrVVUXZDytOy5glwGay4JJls6vOhQAL8=
X-Received: by 2002:a05:651c:41c6:b0:37b:970f:d33b with SMTP id
 38308e7fff4ca-37cd9174e1dmr53447121fa.3.1764164656369; Wed, 26 Nov 2025
 05:44:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHxFxR-8NRN0Fwj7jhD1KKACrb0PdUp1iOBKJ+xkxaNQn_tew@mail.gmail.com>
 <20251124073445.3709-1-hupu.gm@gmail.com> <aSVlQHJ9xcGcZULp@google.com>
 <CADHxFxRY5Vse0UnezDg8hCEgbVy5qXkoLbEMRGaA6pH5aLoNxA@mail.gmail.com>
 <CADHxFxSXMvmeL4afJPh9Ycs2ABrnOVHkxJ4pRBdhJRJWBAvnHA@mail.gmail.com> <20251125161026.GF724103@e132581.arm.com>
In-Reply-To: <20251125161026.GF724103@e132581.arm.com>
From: hupu <hupu.gm@gmail.com>
Date: Wed, 26 Nov 2025 21:44:02 +0800
X-Gm-Features: AWmQ_bk_-HMFGD8tBjl41Rb0c5E8ZPAPTNj-nbmxMWFdf9MJLNxvDkVgxylwHMc
Message-ID: <CADHxFxQ2kb2pRhn0-_PJwmo9pykHzDMJDPQay5GaqmmZF1nwSw@mail.gmail.com>
Subject: Re: [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leo,
Thank you for your reply.

On Wed, Nov 26, 2025 at 12:10=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On Tue, Nov 25, 2025 at 09:07:26PM +0800, hupu wrote:
>
> [...]
>
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -35,6 +35,9 @@ include ../scripts/utilities.mak
> >  #
> >  # Define EXTRA_CFLAGS=3D-m64 or EXTRA_CFLAGS=3D-m32 as appropriate for
> > cross-builds.
> >  #
> > +# Define EXTRA_BPF_FLAGS=3D"--sysroot=3D<path>" or other custom includ=
e paths for
> > +# cross-compiling BPF skeletons
> > +#
> >  # Define EXCLUDE_EXTLIBS=3D-lmylib to exclude libmylib from the auto-g=
enerated
> >  # EXTLIBS.
> >  #
> > @@ -1252,7 +1255,7 @@ endif
> >  $(SKEL_TMP_OUT)/%.bpf.o: $(OUTPUT)PERF-VERSION-FILE
> > util/bpf_skel/perf_version.h | $(SKEL_TMP_OUT)
> >  $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/v=
mlinux.h
> >   $(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=3Dbpf \
> > -   $(CLANG_OPTIONS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
> > +   $(CLANG_OPTIONS) $(EXTRA_BPF_FLAGS) $(BPF_INCLUDE) $(TOOLS_UAPI_INC=
LUDE) \
>
> I am concerned for this change.
>
> How can you only build eBPF skel program with "--sysroot" but not
> applying the same build env on perf binary and associated libs (libperf,
> bpftool, etc) ?
>
> For a convinced solution, I'd expect we can apply PKG_CONFIG_SYSROOT_DIR
> for both normal perf build and eBPF skel build.  More important, please
>

I understand your concern, and I will explain it with reference to the
current source code.


The eBPF skeleton is compiled via clang --target=3Dbpf, and its header
file search paths mainly come from BPF_INCLUDE and TOOLS_UAPI_INCLUDE.
It also uses '-idirafter' to include the host=E2=80=99s /usr/local/include =
and
/usr/include directories in the search path. This process is not
directly coupled with cross-compilation managed via pkg-config, which
means PKG_CONFIG_SYSROOT_DIR does not affect how the skeleton resolves
its headers.

1252 $(SKEL_TMP_OUT)/%.bpf.o: $(OUTPUT)PERF-VERSION-FILE
util/bpf_skel/perf_version.h | $(SKEL_TMP_OUT)
1253 $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF)
$(SKEL_OUT)/vmlinux.h
1254         $(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=3D=
bpf \
1255           $(CLANG_OPTIONS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
1256           -include $(OUTPUT)PERF-VERSION-FILE -include
util/bpf_skel/perf_version.h \
1257           -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@


I added some debugging output to inspect the contents of BPF_INCLUDE:

BPF_INCLUDE:
-I/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_sk=
el/.tmp/..
-I/home/hupu/work/code/explore/output/build-mainline/tools/perf/libbpf/incl=
ude
-idirafter /usr/lib/llvm-18/lib/clang/18/include
-idirafter /usr/local/include
-idirafter /usr/include


The perf binary and its associated libraries (such as libperf) are
built with the cross toolchain. Their dependency headers and library
paths are determined by CFLAGS/LDFLAGS and resolved via pkg-config. In
this case, PKG_CONFIG_SYSROOT_DIR is indeed the correct control point.

802 $(OUTPUT)perf: $(PERFLIBS) $(PERF_IN)
803         $(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) \
804                 $(PERF_IN) $(LIBS) -o $@

971 $(LIBPERF): FORCE | $(LIBPERF_OUTPUT)
972         $(Q)$(MAKE) -C $(LIBPERF_DIR) O=3D$(LIBPERF_OUTPUT) \
973                 DESTDIR=3D$(LIBPERF_DESTDIR) prefix=3D subdir=3D \
974                 $@ install_headers


From the current build logic, there is no strict requirement for the
skeleton and the perf binary to use exactly the same headers, because
we cannot guarantee that the headers in the host=E2=80=99s /usr/local/inclu=
de
and /usr/include are fully consistent with the kernel source.

If the goal is to enforce header consistency, my other proposed patch
=E2=80=94 =E2=80=9Cperf build: Use self-contained headers from kernel sourc=
e when
compiling=E2=80=9D =E2=80=94 explicitly ensures that the skeleton uses UAPI=
 headers
from the kernel source tree, thus aligning the skeleton=E2=80=99s headers w=
ith
those used by the perf binary.

Finally, introducing EXTRA_BPF_FLAGS offers a controlled, optional
extension point for the skeleton build, rather than solely passing
--sysroot. This allows users to add additional options such as -I or
-D to address specific include resolution needs in certain
environments. It is more flexible than hardcoding paths, and does not
modify the existing pkg-config managed search paths used for
user-space builds.


> for both normal perf build and eBPF skel build.  More important, please
> provide steps for how to build perf with a SDK.
>

(I apologize in advance =E2=80=94 I may paste some build log output below.
This could make the email appear somewhat cluttered, and may also
cause line wrapping or truncation in some mail clients.)

If EXTRA_BPF_FLAGS is not specified during the perf build (example
command shown below), the compilation will fail:
make perf ARCH=3Darm64 CROSS_COMPILE=3Daarch64-dumpstack-linux-gnu-
LDFLAGS=3D"-L/home/hupu/work/tools/x-tools/aarch64-dumpstack-linux-gnu/bin/=
../aarch64-dumpstack-linux-gnu/sysroot/usr/lib/aarch64-linux-gnu
-L/home/hupu/work/tools/x-tools/aarch64-dumpstack-linux-gnu/bin/../aarch64-=
dumpstack-linux-gnu/sysroot/usr/lib
-static"  O=3D/home/hupu/work/code/explore/output/build-mainline -j8


The full build failure log is as follows:

21:38:16 (00:00:00) - INFO  : Starting build perf tools for arm64 ...
21:38:16 (00:00:00) - INFO  : make perf ARCH=3Darm64
CROSS_COMPILE=3Daarch64-dumpstack-linux-gnu-
LDFLAGS=3D"-L/home/hupu/work/tools/x-tools/aarch64-dumpstack-linux-gnu/bin/=
../aarch64-dumpstack-linux-gnu/sysroot/usr/lib/aarch64-linux-gnu
-L/home/hupu/work/tools/x-tools/aarch64-dumpstack-linux-gnu/bin/../aarch64-=
dumpstack-linux-gnu/sysroot/usr/lib
-static"  O=3D/home/hupu/work/code/explore/output/build-mainline -j8
  BUILD:   Doing 'make -j4' parallel build
Warning: Kernel ABI header differences:
  diff -u tools/arch/arm64/include/asm/cputype.h
arch/arm64/include/asm/cputype.h
  diff -u tools/perf/trace/beauty/include/uapi/linux/mount.h
include/uapi/linux/mount.h
Makefile.config:590: No elfutils/debuginfod.h found, no debuginfo
server support, please install
libdebuginfod-dev/elfutils-debuginfod-client-devel or equivalent
Makefile.config:633: No sys/sdt.h found, no SDT events are defined,
please install systemtap-sdt-devel or systemtap-sdt-dev
Makefile.config:881: No 'Python.h' was found: disables Python support
- please install python-devel/python-dev
Makefile.config:989: No libllvm 13+ found, slower source file
resolution, please install llvm-devel/llvm-dev
Makefile.config:1099: No libbabeltrace found, disables 'perf data' CTF
format support, please install
libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:1142: No alternatives command found, you need to set
JDIR=3D to point to the root of your Java directory
Makefile.config:1173: libpfm4 not found, disables libpfm4 support.
Please install libpfm-devel or libpfm4-dev

Auto-detecting system features:
...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                               libpython: [ OFF ]
...                             libcapstone: [ on  ]
...                               llvm-perf: [ OFF ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ OFF ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

  GEN     /home/hupu/work/code/explore/output/build-mainline/tools/perf/com=
mon-cmds.h
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/dlf=
ilters/dlfilter-test-api-v0.o
  GEN     /home/hupu/work/code/explore/output/build-mainline/tools/perf/arc=
h/arm64/include/generated/asm/sysreg-defs.h
  PERF_VERSION =3D 6.18.rc7.g30f09200cc4a
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/dlf=
ilters/dlfilter-test-api-v2.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/dlf=
ilters/dlfilter-show-cycles.o
  MKDIR   /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
api/fd/
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
api/fd/array.o
  SYSHDR  /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/arch/arm64/include/generated/uapi/asm/unistd_64.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/include/perf/bpf_perf.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/include/perf/core.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/include/perf/cpumap.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/include/perf/threadmap.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/include/perf/evlist.h
  LD      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
api/fd/libapi-in.o
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/include/perf/evsel.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/include/perf/event.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/include/perf/mmap.h
  MKDIR   /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
api/fs/
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/include/internal/cpumap.h
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
api/fs/fs.o
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/include/internal/evlist.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
subcmd/include/subcmd/exec-cmd.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/include/internal/evsel.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
subcmd/include/subcmd/help.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/include/internal/lib.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/include/internal/mmap.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
subcmd/include/subcmd/pager.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/include/internal/rc_check.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
subcmd/include/subcmd/parse-options.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/include/internal/threadmap.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/include/internal/xyarray.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
subcmd/include/subcmd/run-command.h
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/core.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
subcmd/exec-cmd.o
  INSTALL libsubcmd_headers
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
api/include/api/cpu.h
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
api/cpu.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/cpumap.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
api/debug.o
  MKDIR   /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
api/fs/
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
api/fs/tracing_path.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
subcmd/help.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
api/fs/cgroup.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
api/str_error_r.o
  LD      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
api/fs/libapi-in.o
  INSTALL libperf_headers
  LD      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
api/libapi-in.o
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
api/include/api/debug.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
api/include/api/io.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
api/include/api/io_dir.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
api/include/api/fd/array.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
api/include/api/fs/fs.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
api/include/api/fs/tracing_path.h
  AR      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
api/libapi.a
  INSTALL libapi_headers
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/threadmap.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
symbol/kallsyms.o
  LD      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
symbol/libsymbol-in.o
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
symbol/include/symbol/kallsyms.h
  AR      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
symbol/libsymbol.a
  INSTALL libsymbol_headers
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
subcmd/pager.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/evsel.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
subcmd/parse-options.o
  GEN     /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/bpf_helper_defs.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/include/bpf/bpf.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/include/bpf/libbpf.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/include/bpf/btf.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/include/bpf/libbpf_common.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/include/bpf/libbpf_legacy.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/include/bpf/bpf_helpers.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/include/bpf/bpf_tracing.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/include/bpf/bpf_endian.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/include/bpf/bpf_core_read.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/include/bpf/skel_internal.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/include/bpf/libbpf_version.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/include/bpf/usdt.bpf.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/include/bpf/bpf_helper_defs.h
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/staticobjs/libbpf.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/evlist.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
subcmd/run-command.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
subcmd/sigchain.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
subcmd/subcmd-config.o
  LD      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
subcmd/libsubcmd-in.o
  AR      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
subcmd/libsubcmd.a
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/staticobjs/bpf.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/mmap.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/staticobjs/nlattr.o
  INSTALL libbpf_headers
  GEN     perf-archive
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/zalloc.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/staticobjs/btf.o
  GEN     perf-iostat
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/xyarray.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/lib.o
  LINK    /home/hupu/work/code/explore/output/build-mainline/tools/perf/dlf=
ilters/dlfilter-test-api-v0.so
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/staticobjs/libbpf_utils.o
  LD      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/libperf-in.o
  AR      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/libperf.a
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/staticobjs/netlink.o
  LINK    /home/hupu/work/code/explore/output/build-mainline/tools/perf/dlf=
ilters/dlfilter-test-api-v2.so
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/staticobjs/bpf_prog_linfo.o
  LINK    /home/hupu/work/code/explore/output/build-mainline/tools/perf/dlf=
ilters/dlfilter-show-cycles.so
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/staticobjs/libbpf_probes.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/staticobjs/hashmap.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/staticobjs/btf_dump.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/staticobjs/ringbuf.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/staticobjs/strset.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/staticobjs/linker.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/staticobjs/gen_loader.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/staticobjs/relo_core.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/staticobjs/usdt.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/staticobjs/zip.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/staticobjs/elf.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/staticobjs/features.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/staticobjs/btf_iter.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/staticobjs/btf_relocate.o
  LD      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/staticobjs/libbpf-in.o
  LINK    /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
bpf/libbpf.a

Auto-detecting system features:
...                         clang-bpf-co-re: [ on  ]
...                                    llvm: [ OFF ]
...                                  libcap: [ on  ]
...                                  libbfd: [ OFF ]

  MKDIR   /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/include/bpf
  MKDIR   /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/
  MKDIR   /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/hashmap.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/relo_core.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_internal.h
  GEN     /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/bpf_helper_defs.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/btf.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_common.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_legacy.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_helpers.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_tracing.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_endian.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_core_read.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/skel_internal.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_version.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/usdt.bpf.h
  INSTALL /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_helper_defs.h
  INSTALL libbpf_headers
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/bpf.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/nlattr.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/btf.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf_utils.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/netlink.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/bpf_prog_linfo.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf_probes.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/hashmap.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/btf_dump.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/ringbuf.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/strset.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/linker.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/gen_loader.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/relo_core.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/usdt.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/zip.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/elf.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/features.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/btf_iter.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/btf_relocate.o
  LD      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf-in.o
  LINK    /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/main.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/common.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/json_writer.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/gen.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/btf.o
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/sign.o
  LINK    /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bootstrap/bpftool
/usr/bin/ld: skipping incompatible
/home/hupu/work/tools/x-tools/aarch64-dumpstack-linux-gnu/bin/../aarch64-du=
mpstack-linux-gnu/sysroot/usr/lib/aarch64-linux-gnu/libelf.a
when searching for -lelf
/usr/bin/ld: skipping incompatible
/home/hupu/work/tools/x-tools/aarch64-dumpstack-linux-gnu/bin/../aarch64-du=
mpstack-linux-gnu/sysroot/usr/lib/aarch64-linux-gnu/libelf.a
when searching for -lelf
/usr/bin/ld: skipping incompatible
/home/hupu/work/tools/x-tools/aarch64-dumpstack-linux-gnu/bin/../aarch64-du=
mpstack-linux-gnu/sysroot/usr/lib/aarch64-linux-gnu/libz.a
when searching for -lz
/usr/bin/ld: skipping incompatible
/home/hupu/work/tools/x-tools/aarch64-dumpstack-linux-gnu/bin/../aarch64-du=
mpstack-linux-gnu/sysroot/usr/lib/aarch64-linux-gnu/libz.a
when searching for -lz
/usr/bin/ld: skipping incompatible
/home/hupu/work/tools/x-tools/aarch64-dumpstack-linux-gnu/bin/../aarch64-du=
mpstack-linux-gnu/sysroot/usr/lib/aarch64-linux-gnu/libcrypto.a
when searching for -lcrypto
/usr/bin/ld: skipping incompatible
/home/hupu/work/tools/x-tools/aarch64-dumpstack-linux-gnu/bin/../aarch64-du=
mpstack-linux-gnu/sysroot/usr/lib/aarch64-linux-gnu/libcrypto.a
when searching for -lcrypto
/usr/bin/ld: skipping incompatible
/home/hupu/work/tools/x-tools/aarch64-dumpstack-linux-gnu/bin/../aarch64-du=
mpstack-linux-gnu/sysroot/usr/lib/aarch64-linux-gnu/libzstd.a
when searching for -lzstd
/usr/bin/ld: skipping incompatible
/home/hupu/work/tools/x-tools/aarch64-dumpstack-linux-gnu/bin/../aarch64-du=
mpstack-linux-gnu/sysroot/usr/lib/aarch64-linux-gnu/libzstd.a
when searching for -lzstd
/usr/bin/ld: skipping incompatible
/home/hupu/work/tools/x-tools/aarch64-dumpstack-linux-gnu/bin/../aarch64-du=
mpstack-linux-gnu/sysroot/usr/lib/libc.a
when searching for -lc
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/lib=
crypto.a(libcrypto-lib-dso_dlfcn.o):
in function `dlfcn_globallookup':
(.text+0x1f): warning: Using 'dlopen' in statically linked
applications requires at runtime the shared libraries from the glibc
version used for linking
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/lib=
crypto.a(libcrypto-lib-bio_addr.o):
in function `BIO_lookup_ex':
(.text+0xdbc): warning: Using 'getaddrinfo' in statically linked
applications requires at runtime the shared libraries from the glibc
version used for linking
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/lib=
crypto.a(libcrypto-lib-bio_sock.o):
in function `BIO_gethostbyname':
(.text+0x85): warning: Using 'gethostbyname' in statically linked
applications requires at runtime the shared libraries from the glibc
version used for linking
  CLANG   /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bpf_prog_profiler.bpf.o
  CLANG   /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bperf_leader.bpf.o
  CLANG   /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bperf_follower.bpf.o
  CLANG   /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bperf_cgroup.bpf.o
In file included from <built-in>:2:
In file included from ./util/bpf_skel/perf_version.h:6:
In file included from
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel=
/.tmp/../vmlinux.h:7:
In file included from
/home/hupu/work/code/explore/linux-mainline/tools/include/uapi/linux/perf_e=
vent.h:19:
/usr/include/linux/ioctl.h:5:10: fatal error: 'asm/ioctl.h' file not found
    5 | #include <asm/ioctl.h>
      |          ^~~~~~~~~~~~~
In file included from <built-in>:2:
In file included from ./util/bpf_skel/perf_version.h:6:
In file included from
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel=
/.tmp/../vmlinux.h:7:
In file included from
/home/hupu/work/code/explore/linux-mainline/tools/include/uapi/linux/perf_e=
vent.h:19:
/usr/include/linux/ioctl.h:5:10: fatal error: 'asm/ioctl.h' file not found
    5 | #include <asm/ioctl.h>
      |          ^~~~~~~~~~~~~
In file included from <built-in>:2:
In file included from ./util/bpf_skel/perf_version.h:6:
In file included from
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel=
/.tmp/../vmlinux.h:7:
In file included from
/home/hupu/work/code/explore/linux-mainline/tools/include/uapi/linux/perf_e=
vent.h:19:
/usr/include/linux/ioctl.h:5:10: fatal error: 'asm/ioctl.h' file not found
    5 | #include <asm/ioctl.h>
      |          ^~~~~~~~~~~~~
1 error generated.
In file included from <built-in>:2:
In file included from ./util/bpf_skel/perf_version.h:6:
In file included from
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel=
/.tmp/../vmlinux.h:7:
In file included from
/home/hupu/work/code/explore/linux-mainline/tools/include/uapi/linux/perf_e=
vent.h:19:
/usr/include/linux/ioctl.h:5:10: fatal error: 'asm/ioctl.h' file not found
    5 | #include <asm/ioctl.h>
      |          ^~~~~~~~~~~~~
1 error generated.
make[3]: *** [Makefile.perf:1254:
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel=
/.tmp/bpf_prog_profiler.bpf.o]
Error 1
make[3]: *** Waiting for unfinished jobs....
make[3]: *** [Makefile.perf:1254:
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel=
/.tmp/bperf_leader.bpf.o]
Error 1
1 error generated.
make[3]: *** [Makefile.perf:1254:
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel=
/.tmp/bperf_follower.bpf.o]
Error 1
1 error generated.
make[3]: *** [Makefile.perf:1254:
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel=
/.tmp/bperf_cgroup.bpf.o]
Error 1
make[2]: *** [Makefile.perf:289: sub-make] Error 2
make[1]: *** [Makefile:76: all] Error 2
make: *** [Makefile:93: perf] Error 2




However, when applying the patch =E2=80=9Cperf build: Support passing extra
Clang options via EXTRA_BPF_FLAGS=E2=80=9D, running the following command
successfully builds perf:

make perf ARCH=3Darm64 CROSS_COMPILE=3Daarch64-dumpstack-linux-gnu-
EXTRA_BPF_FLAGS=3D"--sysroot=3D/home/hupu/work/tools/x-tools/aarch64-dumpst=
ack-linux-gnu/bin/../aarch64-dumpstack-linux-gnu/sysroot"
LDFLAGS=3D"-L/home/hupu/work/tools/x-tools/aarch64-dumpstack-linux-gnu/bin/=
../aarch64-dumpstack-linux-gnu/sysroot/usr/lib/aarch64-linux-gnu
-L/home/hupu/work/tools/x-tools/aarch64-dumpstack-linux-gnu/bin/../aarch64-=
dumpstack-linux-gnu/sysroot/usr/lib
-static"  O=3D/home/hupu/work/code/explore/output/build-mainline -j8



Similarly, when applying the patch =E2=80=9Cperf build: Use self-contained
headers from kernel source when compiling=E2=80=9D, perf can also be
successfully built without specifying EXTRA_BPF_FLAGS:

make perf ARCH=3Darm64 CROSS_COMPILE=3Daarch64-dumpstack-linux-gnu-
LDFLAGS=3D"-L/home/hupu/work/tools/x-tools/aarch64-dumpstack-linux-gnu/bin/=
../aarch64-dumpstack-linux-gnu/sysroot/usr/lib/aarch64-linux-gnu
-L/home/hupu/work/tools/x-tools/aarch64-dumpstack-linux-gnu/bin/../aarch64-=
dumpstack-linux-gnu/sysroot/usr/lib
-static"  O=3D/home/hupu/work/code/explore/output/build-mainline -j8



Therefore, both patches are valid approaches to successfully build perf.

Thanks,
hupu
