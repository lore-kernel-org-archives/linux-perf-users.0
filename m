Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE3620335
	for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621091; cv=none; b=t3xdO02LWK4WhendWWBY0E9OWgarlZoy9uiCZ2/EacXNKLFocuoQ3TOj4tjrUe1JCTASgP4D//p87q939nrtB2gacvBgdfHPZ6oxv40NMD6du40qDOI4OfgQAr3OdHT34HTrFFhGkBtOGXvFzOfuvJvsWE83rg16s9P2xhyny+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621091; c=relaxed/simple;
	bh=3pCCV3pIsPwoou09ayGUsRpQ+iP6dj5L6mBLbBQ9JQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJkr5ZEmT9NKY+nSZDK9Wnj05KDn8TMhUmNGQmQR0Gkq0X/Y8NlgL3mcd57eyTTMaDoeUwps6b1a0fa97W0HKx97u2+mBKgAks7PD9jDNX9HlxTb6a7j+Z4cAMYa9daYNZrj4Y3O/VrgrB0uTjdOvH4s8F1hnCa8WH37taljAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KYRUGNgf; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KYRUGNgf"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36c670757aaso348355ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 10:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715621089; x=1716225889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoSzKwBP/fkvEwEnZHAw4cEPWyEmks1QbjVuSI/cVOk=;
        b=KYRUGNgfjF2lNP2oYitbuLrhZ2bQkz7+sgZ7Z2Ro1SlwoBVJrZSPsJNiDIROfl82RG
         Iab9yclJso43dSo87ddG09iZiO7YnYCnzVOjopXfIZpp9OOEky9toKdAt+CaTfdng6nC
         55zaQ20LNcAnKvGBgIKyUXwP3DSH5Z2hsSBZrOeD6OQFByHqeKevazdHStdWypYFaveH
         wf+zTHxf/ExZBNuyoAAq1RV+HmpNNjkMNJ5TvClvUOLCHZ1pupPUU/bww+gudR4pfOcc
         /6LQGkCeZm69vioOdUM29TzWsg9AjF9h3sQDdeI4PIf1Xrt3Q3ZUyQVjD8yNG4ryo7qD
         aMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715621089; x=1716225889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoSzKwBP/fkvEwEnZHAw4cEPWyEmks1QbjVuSI/cVOk=;
        b=ap/en8l9TmmW57nma+UCq5+/JRvCTpQGIjBr2P6nWFAweZemMnpbHJxnGsl2pECr/b
         elX9RdIIXgkfLY6sXM4o0j9B7zCAOwzOQT53zsf/QMCbBSdZqERmeMLKw5MI7Ra747Fz
         TCBaZubEQ8kpNHRg45gyJic1lXjf8c8+r3e7gkMWPXKOvZGfC7Xe9FgGkkmzHxbaMimW
         OhtN4uKEdKIlxYtfn+HQCSYAyER7jAKH98pk+8a6jH2gxT7LEzAY3SDmAiC86im2Aw6O
         94y7HXWiq/tbeU6aSruizFlWC1Ip4Ao0vYtLMhJbGTVOP6ZKYMyidIxNRCDWS8cFk26S
         Hk7w==
X-Forwarded-Encrypted: i=1; AJvYcCXh9BluZkIylZgzeuZhmHUa4V7BlUhFZPeKdod/JIkH28nFGYUzN1jMbtWZaxORRxK2eiNdvAZ8zRbI9zzbyzG6viXmyrI9xPmfQ0n2+xIy6g==
X-Gm-Message-State: AOJu0YypT1YlqBRee+Ybc9spbE1RYH614vVMZawZdG6uIF7nCoD51/W7
	ETns3ZcoJBiMtP6iE9rPCPHv7LJVjVqY7M0L0Dq+QpSYNS+Yh/bGkFEt3XJ17jn1zE9HrWGfFb/
	Sitqq3Uq+T1a44rpwN7yQrgYwmjfARXfyDIQ/
X-Google-Smtp-Source: AGHT+IHYMU6jMsPSnXdaLeFXuYoMOdmfMivMi4lN+n7GoENybPVKoifn+Yb6ANHGycPGxZe62L1KTUIxRVVd8SHq6m4=
X-Received: by 2002:a92:cb85:0:b0:36c:cb38:a30c with SMTP id
 e9e14a558f8ab-36ccca86eb3mr4592855ab.11.1715621089034; Mon, 13 May 2024
 10:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZjssGrj+abyC6mYP@gmail.com> <CAP-5=fUvLiCDVDFFfJ78ng4T1FZ8j2N9Yt1sGTeGsupkbFEEug@mail.gmail.com>
 <ZkG4LWr7w11wQ/PR@gmail.com> <CAP-5=fVHrKcqwczoU1uMD4tP5DTVhfQ1T_hXnm_y5Ji3M6K_ag@mail.gmail.com>
 <ZkJK3x3zQ9a4wp8E@gmail.com>
In-Reply-To: <ZkJK3x3zQ9a4wp8E@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 May 2024 10:24:37 -0700
Message-ID: <CAP-5=fUh+GoqERAF-qf8zx4kwq2uzwR2Ugop5XOkPexYGAqF3A@mail.gmail.com>
Subject: Re: Makefile.perf:1149: *** Missing bpftool input for generating
 vmlinux.h. Stop.
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 10:16=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wro=
te:
>
>
> * Ian Rogers <irogers@google.com> wrote:
>
> > > Was this regression fix propagated to v6.9 in time?
> >
> > We switched to using the handwritten file in v6.4:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/tools/perf/util/bpf_skel/vmlinux.h?id=3Da887466562b425bd6183bf75b523c147=
7c9fd22d
>
> So there must be some different regression then, as this is readily
> reproducible for me on v6.9, as per the build log below - I simply
> Ctrl-C-ed a build, and the next build results in:
>
>   kepler:~/tip/tools/perf> make clean install
>   Makefile.perf:1149: *** Missing bpftool input for generating vmlinux.h.=
  Stop.
>   make: *** [Makefile:90: clean] Error 2
>   kepler:~/tip/tools/perf>
>
> Thanks,
>
>         Ingo
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D>
> kepler:~/tip/tools/perf> make clean install
>   CLEAN   x86
>   CLEAN   libapi
>   CLEAN   libbpf
>   CLEAN   libsubcmd
>   CLEAN   libsymbol
>   CLEAN   libperf
>   CLEAN   arm64-sysreg-defs
>   CLEAN   fixdep
>   CLEAN   feature-detect
>   CLEAN   python
>   CLEAN   bpf-skel
>   CLEAN   coresight
>   CLEAN   core-objs
>   CLEAN   core-progs
>   CLEAN   core-gen
>   CLEAN   Documentation
>   BUILD:   Doing 'make -j64' parallel build
>   HOSTCC  fixdep.o
>   HOSTLD  fixdep-in.o
>   LINK    fixdep
> Warning: Kernel ABI header differences:
>   diff -u tools/include/uapi/linux/vhost.h include/uapi/linux/vhost.h
>   diff -u tools/include/linux/bits.h include/linux/bits.h
>   diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/c=
pufeatures.h
>   diff -u tools/arch/x86/include/asm/irq_vectors.h arch/x86/include/asm/i=
rq_vectors.h
>   diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr=
-index.h
>   diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entr=
y/syscalls/syscall_64.tbl
>
>
>
>
>
> Auto-detecting system features:
> ...                                   dwarf: [ on  ]
> ...                      dwarf_getlocations: [ on  ]
> ...                                   glibc: [ on  ]
> ...                                  libbfd: [ on  ]
> ...                          libbfd-buildid: [ on  ]
> ...                                  libcap: [ on  ]
> ...                                  libelf: [ on  ]
> ...                                 libnuma: [ on  ]
> ...                  numa_num_possible_cpus: [ on  ]
> ...                                 libperl: [ on  ]
> ...                               libpython: [ on  ]
> ...                               libcrypto: [ on  ]
> ...                               libunwind: [ on  ]
> ...                      libdw-dwarf-unwind: [ on  ]
> ...                             libcapstone: [ on  ]
> ...                                    zlib: [ on  ]
> ...                                    lzma: [ on  ]
> ...                               get_cpuid: [ on  ]
> ...                                     bpf: [ on  ]
> ...                                  libaio: [ on  ]
> ...                                 libzstd: [ on  ]
>
>   GEN     common-cmds.h
>   CC      perf-read-vdso32
>   CC      perf-read-vdsox32
>   CC      jvmti/libjvmti.o
>   CC      dlfilters/dlfilter-test-api-v0.o
>   CC      dlfilters/dlfilter-test-api-v2.o
>   CC      jvmti/jvmti_agent.o
>   CC      dlfilters/dlfilter-show-cycles.o
>   CC      jvmti/libstring.o
>   CC      jvmti/libctype.o
>   GEN     /home/mingo/tip/tools/perf/arch/arm64/include/generated/asm/sys=
reg-defs.h
>   PERF_VERSION =3D 6.9.g16ae3bebb76c
>   INSTALL /home/mingo/tip/tools/perf/libsubcmd/include/subcmd/exec-cmd.h
>   INSTALL /home/mingo/tip/tools/perf/libsubcmd/include/subcmd/help.h
>   INSTALL /home/mingo/tip/tools/perf/libsubcmd/include/subcmd/pager.h
>   GEN     perf-archive
>   GEN     perf-iostat
>   INSTALL /home/mingo/tip/tools/perf/libsubcmd/include/subcmd/parse-optio=
ns.h
>   CC      /home/mingo/tip/tools/perf/libsubcmd/exec-cmd.o
>   INSTALL /home/mingo/tip/tools/perf/libsubcmd/include/subcmd/run-command=
.h
>   CC      /home/mingo/tip/tools/perf/libsubcmd/help.o
>   CC      /home/mingo/tip/tools/perf/libsubcmd/pager.o
>   CC      /home/mingo/tip/tools/perf/libsubcmd/parse-options.o
>   CC      /home/mingo/tip/tools/perf/libsubcmd/run-command.o
>   CC      /home/mingo/tip/tools/perf/libsubcmd/sigchain.o
>   CC      /home/mingo/tip/tools/perf/libsubcmd/subcmd-config.o
>   INSTALL libsubcmd_headers
>   GEN      doc.dep
>   INSTALL /home/mingo/tip/tools/perf/libapi/include/api/cpu.h
>   INSTALL /home/mingo/tip/tools/perf/libapi/include/api/debug.h
>   INSTALL /home/mingo/tip/tools/perf/libsymbol/include/symbol/kallsyms.h
>   INSTALL /home/mingo/tip/tools/perf/libapi/include/api/io.h
>   INSTALL /home/mingo/tip/tools/perf/libapi/include/api/fd/array.h
>   INSTALL /home/mingo/tip/tools/perf/libperf/include/perf/bpf_perf.h
>   LINK    dlfilters/dlfilter-show-cycles.so
>   INSTALL /home/mingo/tip/tools/perf/libapi/include/api/fs/fs.h
>   INSTALL /home/mingo/tip/tools/perf/libperf/include/perf/core.h
>   CC      /home/mingo/tip/tools/perf/libsymbol/kallsyms.o
>   INSTALL /home/mingo/tip/tools/perf/libperf/include/perf/cpumap.h
>   INSTALL /home/mingo/tip/tools/perf/libapi/include/api/fs/tracing_path.h
>   CC      /home/mingo/tip/tools/perf/libapi/cpu.o
>   MKDIR   /home/mingo/tip/tools/perf/libapi/fd/
>   INSTALL /home/mingo/tip/tools/perf/libperf/include/perf/threadmap.h
>   CC      /home/mingo/tip/tools/perf/libapi/debug.o
>   CC      /home/mingo/tip/tools/perf/libperf/core.o
>   INSTALL /home/mingo/tip/tools/perf/libperf/include/perf/evlist.h
>   MKDIR   /home/mingo/tip/tools/perf/libapi/fs/
>   INSTALL /home/mingo/tip/tools/perf/libperf/include/perf/evsel.h
>   CC      /home/mingo/tip/tools/perf/libperf/cpumap.o
>   CC      /home/mingo/tip/tools/perf/libapi/str_error_r.o
>   INSTALL /home/mingo/tip/tools/perf/libperf/include/perf/event.h
>   MKDIR   /home/mingo/tip/tools/perf/libapi/fs/
>   INSTALL /home/mingo/tip/tools/perf/libperf/include/perf/mmap.h
>   CC      /home/mingo/tip/tools/perf/libperf/threadmap.o
>   MKDIR   /home/mingo/tip/tools/perf/libapi/fs/
>   INSTALL /home/mingo/tip/tools/perf/libperf/include/internal/cpumap.h
>   CC      /home/mingo/tip/tools/perf/libperf/evsel.o
>   INSTALL /home/mingo/tip/tools/perf/libperf/include/internal/evlist.h
>   INSTALL /home/mingo/tip/tools/perf/libperf/include/internal/evsel.h
>   CC      /home/mingo/tip/tools/perf/libapi/fd/array.o
>   CC      /home/mingo/tip/tools/perf/libperf/evlist.o
>   CC      /home/mingo/tip/tools/perf/libapi/fs/fs.o
>   INSTALL /home/mingo/tip/tools/perf/libperf/include/internal/lib.h
>   INSTALL libsymbol_headers
>   CC      /home/mingo/tip/tools/perf/libperf/mmap.o
>   INSTALL /home/mingo/tip/tools/perf/libperf/include/internal/mmap.h
>   INSTALL /home/mingo/tip/tools/perf/libperf/include/internal/rc_check.h
>   CC      /home/mingo/tip/tools/perf/libapi/fs/tracing_path.o
>   INSTALL libapi_headers
>   CC      /home/mingo/tip/tools/perf/libperf/zalloc.o
>   INSTALL /home/mingo/tip/tools/perf/libperf/include/internal/threadmap.h
>   CC      /home/mingo/tip/tools/perf/libapi/fs/cgroup.o
>   INSTALL /home/mingo/tip/tools/perf/libperf/include/internal/xyarray.h
>   CC      /home/mingo/tip/tools/perf/libperf/xyarray.o
>   CC      /home/mingo/tip/tools/perf/libperf/lib.o
>   GEN     /home/mingo/tip/tools/perf/libbpf/bpf_helper_defs.h
>   INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/bpf.h
>   INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/libbpf.h
>   INSTALL libperf_headers
>   INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/btf.h
>   INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/libbpf_common.h
>   INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/libbpf_legacy.h
>   INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/bpf_helpers.h
>   INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/bpf_tracing.h
>   INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/bpf_endian.h
>   INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/bpf_core_read.h
>   INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/skel_internal.h
>   INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/libbpf_version.h
>   INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/usdt.bpf.h
>   LINK    dlfilters/dlfilter-test-api-v2.so
>   LINK    dlfilters/dlfilter-test-api-v0.so
>   LD      /home/mingo/tip/tools/perf/libapi/fd/libapi-in.o
>   INSTALL /home/mingo/tip/tools/perf/libbpf/include/bpf/bpf_helper_defs.h
>   MKDIR   /home/mingo/tip/tools/perf/libbpf/staticobjs/
>   MKDIR   /home/mingo/tip/tools/perf/libbpf/staticobjs/
>   MKDIR   /home/mingo/tip/tools/perf/libbpf/staticobjs/
>   MKDIR   /home/mingo/tip/tools/perf/libbpf/staticobjs/
>   MKDIR   /home/mingo/tip/tools/perf/libbpf/staticobjs/
>   MKDIR   /home/mingo/tip/tools/perf/libbpf/staticobjs/
>   INSTALL libbpf_headers
>   CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/netlink.o
>   CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/bpf.o
>   CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/libbpf.o
>   LD      /home/mingo/tip/tools/perf/libsymbol/libsymbol-in.o
>   CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/btf.o
>   CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/nlattr.o
>   CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/libbpf_errno.o
>   CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/str_error.o
>   CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/bpf_prog_linfo.o
>   CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/libbpf_probes.o
>   CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/hashmap.o
>   CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/btf_dump.o
>   CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/ringbuf.o
>   CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/strset.o
>   CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/linker.o
>   ASCIIDOC perf-annotate.xml
>   CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/gen_loader.o
>   CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/relo_core.o
>   CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/usdt.o
>   CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/zip.o
>   CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/elf.o
>   AR      /home/mingo/tip/tools/perf/libsymbol/libsymbol.a
>   CC      /home/mingo/tip/tools/perf/libbpf/staticobjs/features.o
>   LD      /home/mingo/tip/tools/perf/libapi/fs/libapi-in.o
>   LD      /home/mingo/tip/tools/perf/libapi/libapi-in.o
>   LD      /home/mingo/tip/tools/perf/libperf/libperf-in.o
>   AR      /home/mingo/tip/tools/perf/libperf/libperf.a
>   AR      /home/mingo/tip/tools/perf/libapi/libapi.a
>   LD      jvmti/jvmti-in.o
>   LINK    libperf-jvmti.so
>   LD      /home/mingo/tip/tools/perf/libsubcmd/libsubcmd-in.o
>   AR      /home/mingo/tip/tools/perf/libsubcmd/libsubcmd.a
>   ASCIIDOC perf-archive.xml
>   GEN     python/perf.cpython-311-x86_64-linux-gnu.so
>   ASCIIDOC perf-arm-spe.xml
>   ASCIIDOC perf-bench.xml
>   ASCIIDOC perf-buildid-cache.xml
>   ASCIIDOC perf-buildid-list.xml
>   ASCIIDOC perf-c2c.xml
>   ASCIIDOC perf-config.xml
>   ASCIIDOC perf-daemon.xml
>   ASCIIDOC perf-data.xml
>   ASCIIDOC perf-diff.xml
>   ASCIIDOC perf-dlfilter.xml
> ^Cmake[2]: *** [Makefile.perf:1121: /home/mingo/tip/tools/perf/util/bpf_s=
kel/.tmp/bootstrap/bpftool] Interrupt
> make[4]: *** [/home/mingo/tip/tools/build/Makefile.build:105: /home/mingo=
/tip/tools/perf/libbpf/staticobjs/libbpf.o] Interrupt
> make[3]: *** [Makefile:157: /home/mingo/tip/tools/perf/libbpf/staticobjs/=
libbpf-in.o] Interrupt
> interrupted
> make[2]: *** [Makefile.perf:868: /home/mingo/tip/tools/perf/libbpf/libbpf=
.a] Interrupt
> make[3]: *** [Makefile:275: perf-dlfilter.xml] Interrupt
> make[3]: *** [Makefile:275: perf-diff.xml] Interrupt
> make[2]: *** [Makefile.perf:1072: try-install-man] Interrupt
> make[2]: *** [Makefile.perf:681: python/perf.cpython-311-x86_64-linux-gnu=
.so] Interrupt
> make[1]: *** [Makefile.perf:264: sub-make] Interrupt
> make: *** [Makefile:113: install] Interrupt
>
> kepler:~/tip/tools/perf> make clean install
> Makefile.perf:1149: *** Missing bpftool input for generating vmlinux.h.  =
Stop.
> make: *** [Makefile:90: clean] Error 2
> kepler:~/tip/tools/perf>

Strange. I'll try to repro and update you.

Thanks,
Ian
