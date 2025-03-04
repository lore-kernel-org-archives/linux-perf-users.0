Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C781F12E8
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Mar 2025 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741071914; cv=none; b=paNhA1sVTrEZqu+t8TEmdk7W72bKsLQZh2Htj1LA2IeDSISerKBXKKZ9fYMSItZj0iiIIhASSYOa5mCivXGWr+fNfH+eN+4ahrT9/i5Vf2tbj1BtNuVNKudU6VqrCriBJlkXl9OEJVnGkfkq/uXdfE0D6Gmwuy9BaE9urOpOrb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741071914; c=relaxed/simple;
	bh=gJwcbqZGmwr0Xx2FUFlQA5X6ML1A5+VhLhXfaq+gc/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Ba0NEATtFcGrR82S0BgcDoVYa8ICZzw81IouYw2Q9t6gc7pEpQkuCmthAxajVNj6VE2TELjXISz5YeSCgTm9ZOAAZX3FZ6kL6KoAvgGLtknwRk/t0d5a/wl4bdn5/KP8fZDGYnsVJOnaImg8Wv7RPelH66MZplhSOshVfbT6vYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U7bzAOd0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U7bzAOd0"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22342c56242so117685ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Mar 2025 23:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741071911; x=1741676711; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3JvR8FxNRL+cWCmstDYOjM+Qki5xIGZoD4vNYEAWLw=;
        b=U7bzAOd0AQa74JJ3SGVVTJzXPJyVqvp27CzsWD04jaskwKZ5AexurnixVrrbl9JXza
         QnUxwVU449m/e7/DwAC20CL1utyVBTgdH28WD9VFyirUTT08xQ8MEVK4qFkd3d+fPhgq
         /XW+y1/f+z7FdsCxLwvmrTPQoXR6RLvZM35gr6Ig7pUfKlzuwTzVKPdQMQ9GD8i+5etm
         zj1764q9jm6PDIMho0t2ebxmtzrR4vT6c8KFREccn7fPDJo2ii9JOgH7mLOTaTV4Vayd
         MRPFLh/o6UnYe9M8X5XEq588kuzYxr3bmvRGx+ERceS7MyXYo/N9M2ws5oGuFaApcKZT
         ZMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741071911; x=1741676711;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3JvR8FxNRL+cWCmstDYOjM+Qki5xIGZoD4vNYEAWLw=;
        b=UJn9MtH7qii/tBMRrSa9Pxp8SJ0JDKDX2GAuiV2ss9BZxqo95SlpAvn7an7LvUGQIZ
         jiW/+chc3UjtDd1WJNnquFzL09qEg7NwEvD++wz+BBFJh5VtwBpXwwpI3pYc4WBefdqL
         WwiyORzV4cj0Ms/2s3D6d99naQQKVuGsdfclR8GIEc8BqwhV+MwAdemEaYBtcXw2tYSv
         wAon7b8e7R96pleHqj5t1dUTE6FGp8M9q7FuP8uNdOfcMc8dTszukhxMtNT6di0rdBUx
         TackTMEH+oBHG9JGHDXCh7YjWXmXuup9/4dCgQ2z4tlGR2Ozr6XO+7BP5b62AwiLNhaL
         JBTw==
X-Forwarded-Encrypted: i=1; AJvYcCWU2qJgybn8Kt+c+Lpx2FiOHb4whqheO00feGVIubHkkJG/H6t1XQdiTEZv8MNiK1YReSJdTyAzq1oVGRFTF7nd@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw5ff2lk3OCcRpE78HjB6Nx5OsuVhyY7PEbTwC2a8PpXBUVQGX
	mL8UZ2vgvWNMwIhDdeLUD0YszxRL7A/XAVUjjGQDqaHKyRb1bhfUf684xlbGxSIznE8y15sXME9
	ubt0uXtqjU/RShdytQqWcHa8A9UNp0Z3O9e0A
X-Gm-Gg: ASbGncuyBXXKPlsmU9T235XZ6uJ+S+ur4SZtXu6PJ6eHmM2sW57C8fKH2WKZ2NhaM0h
	vg2EJnDu2ss2pr0puSetUDGkIKzdXOzVJVAgal3nSQjpxH4+swIKEcQfOMxt7LXPDuJW5kw+dyi
	UOFgOfQjrM49P0fVeHJrL2A3/pR8E=
X-Google-Smtp-Source: AGHT+IEupcRqM8Vq6ECdiZG2rhJ+zCRym7mbbPqUL8mmzRnQN6EceWTSYAPo5ifpC6pvsOBjVYM/bwyz/L3Nbkb46ok=
X-Received: by 2002:a17:903:44d:b0:215:7ced:9d66 with SMTP id
 d9443c01a7336-223d9e003f4mr1996995ad.10.1741071910980; Mon, 03 Mar 2025
 23:05:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304050305.901167-1-irogers@google.com>
In-Reply-To: <20250304050305.901167-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Mar 2025 23:04:59 -0800
X-Gm-Features: AQ5f1Joy4icIYuqqbyMmGmOFRwOYLjNzkqxRwWJFEbT-XwnCdO9iuvX_ulJO_CQ
Message-ID: <CAP-5=fXFoawZnRD22iSev5FQnx3oyFOhrPf=gZbk84qGtr9NFA@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] perf: Support multiple system call tables in the build
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, guoren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 9:04=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> This work builds on the clean up of system call tables and removal of
> libaudit by Charlie Jenkins <charlie@rivosinc.com>.
>
> The system call table in perf trace is used to map system call numbers
> to names and vice versa. Prior to these changes, a single table
> matching the perf binary's build was present. The table would be
> incorrect if tracing say a 32-bit binary from a 64-bit version of
> perf, the names and numbers wouldn't match.
>
> Change the build so that a single system call file is built and the
> potentially multiple tables are identifiable from the ELF machine type
> of the process being examined. To determine the ELF machine type, the
> executable's maps are searched and the associated DSOs ELF headers are
> read. When this fails and when live, /proc/pid/exe's ELF header is
> read. Fallback to using the perf's binary type when unknown.
>
> Remove some runtime types used by the system call tables and make
> equivalents generated at build time.
>
> v4: Add reading the e_machine from the thread's maps dsos, only read
>     from /proc/pid/exe on failure and when live as requested by
>     Namhyung. Add patches to add dso comments and remove unused
>     dso_data variables that are unused without libunwind.

This has allowed `perf trace record` (not just perf trace) to work
with binaries with an e_machine that doesn't match that of the perf
binary. An example:

Before:
```
$ file ./a.out
a.out: ELF 32-bit LSB pie executable, Intel 80386, version 1 (SYSV),
dynamically linked, interpreter /lib/ld-linux.so.2
, BuildID[sha1]=3D3fcd28f85a27a3108941661a91dbc675c06868f9, for
GNU/Linux 3.2.0, not stripped
$ perf trace record -- ./a.out
...
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.059 MB perf.data (60 samples) ]
$ perf trace -i perf.data
         ? (         ): a.out/914959  ... [continued]: munmap())
                                    =3D 0
    0.019 ( 0.001 ms): a.out/914959 recvfrom(ubuf: 0x2, size:
4160602092, flags: DONTROUTE|CTRUNC|TRUNC|DONTWAIT|EOR|>
    0.034 ( 0.002 ms): a.out/914959 lgetxattr(name: 0x2000, value:
0x3, size: 34)                         =3D 4160352256
    0.043 ( 0.002 ms): a.out/914959 dup2(oldfd: -134405940, newfd: 4)
                                   =3D -1 ENOENT>
    0.047 ( 0.009 ms): a.out/914959 preadv(fd: 4294967196, vec:
0xf7fce47f, vlen: 557056, pos_h: 4160602092) =3D 3
    0.058 ( 0.004 ms): a.out/914959 lgetxattr(name: 0x1b5c2, value:
0x1, size: 2)                         =3D 4160237568
    0.063 ( 0.000 ms): a.out/914959 lstat(filename: 0x3, statbuf:
0x1b5c2)                                =3D 0
    0.071 ( 0.006 ms): a.out/914959 preadv(fd: 4294967196, vec:
0xf7f9f3e0, vlen: 557056, pos_h: 4160602092) =3D 3
    0.078 ( 0.001 ms): a.out/914959 close(fd: 3)
                                   =3D 512
    0.082 ( 0.002 ms): a.out/914959 lgetxattr(name: 0x23f8d0, value:
0x1, size: 2050)                     =3D 4157878272
    0.084 ( 0.006 ms): a.out/914959 lgetxattr(pathname: 0xf7d66000,
name: 0x18b000, value: 0x5, size: 2066) =3D 4158021>
    0.091 ( 0.002 ms): a.out/914959 lgetxattr(pathname: 0xf7ef1000,
name: 0x85000, value: 0x1, size: 2066) =3D 41596395>
    0.093 ( 0.003 ms): a.out/914959 lgetxattr(pathname: 0xf7f76000,
name: 0x3000, value: 0x3, size: 2066) =3D 4160184320
    0.099 ( 0.002 ms): a.out/914959 lgetxattr(pathname: 0xf7f79000,
name: 0x98d0, value: 0x3, size: 50)   =3D 4160196608
    0.106 ( 0.000 ms): a.out/914959 lstat(filename: 0x3)
                                   =3D 0
    0.112 ( 0.001 ms): a.out/914959 mq_timedreceive(mqdes: 4287979520,
u_msg_ptr: 0xf7f9fbb0, u_msg_prio: 0xf7fdbfec,>
    0.113 ( 0.000 ms): a.out/914959 mkdirat(dfd: -134609624, pathname:
0xf7fdc910, mode: IFSOCK|ISUID|IRUSR|IWGRP|0xf>
    0.114 ( 0.000 ms): a.out/914959 process_vm_writev(pid: -134609620,
lvec: 0xc, liovcnt: 4160604432, rvec: 0xf7fa04>
    0.154 ( 0.003 ms): a.out/914959 capget(header: 4160184320,
dataptr: 8192)                             =3D 0
    0.158 ( 0.002 ms): a.out/914959 capget(header: 1448792064,
dataptr: 4096)                             =3D 0
    0.163 ( 0.002 ms): a.out/914959 capget(header: 4160593920,
dataptr: 8192)                             =3D 0
    0.171 ( 0.001 ms): a.out/914959 getxattr(pathname: 0x3, name:
0xff955fe4, value: 0xf7f77e14, size: 1) =3D 0
    0.179 ( 0.005 ms): a.out/914959 fchmod(fd: -134729728, mode:
IFLNK|IFIFO|ISGID|IRWXU|IWOTH|0x10000)   =3D 0
    0.193 ( 0.008 ms): a.out/914959 preadv(fd: 4294967196, vec:
0x565ac008, pos_h: 4160192020)            =3D 3
    0.202 ( 0.007 ms): a.out/914959 close(fd: 3)
                                   =3D 1436
    0.209 ( 0.017 ms): a.out/914959 stat(filename: 0x1, statbuf:
0xff9552fc)                              =3D 1436
    0.234 (1000.083 ms): a.out/914959 readlinkat(buf: 0xff955224,
bufsiz: 4287975964)                       =3D 0
```

After:
```
$ file ./a.out
a.out: ELF 32-bit LSB pie executable, Intel 80386, version 1 (SYSV),
dynamically linked, interpreter /lib/ld-linux.so.2
, BuildID[sha1]=3D3fcd28f85a27a3108941661a91dbc675c06868f9, for
GNU/Linux 3.2.0, not stripped
$ perf trace record -- ./a.out
...
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.059 MB perf.data (60 samples) ]
$ perf trace -i perf.data
        ? (         ): a.out/908002  ... [continued]: execve())
                                   =3D 0
    0.019 ( 0.001 ms): a.out/908002 brk()
                                   =3D 0x57680000
    0.041 ( 0.003 ms): a.out/908002 access(filename: 0xf7f0b0cc, mode:
R)                                 =3D -1 ENOENT>
    0.046 ( 0.008 ms): a.out/908002 openat(dfd: CWD, filename:
0xf7f0747f, flags: RDONLY|CLOEXEC|LARGEFILE) =3D 3
    0.055 ( 0.001 ms): a.out/908002 statx(dfd: 3, filename:
0xf7f080f6, flags: NO_AUTOMOUNT|EMPTY_PATH, mask: TYPE|MO>
    0.061 ( 0.000 ms): a.out/908002 close(fd: 3)
                                   =3D 0
    0.070 ( 0.006 ms): a.out/908002 openat(dfd: CWD, filename:
0xf7ed83e0, flags: RDONLY|CLOEXEC|LARGEFILE) =3D 3
    0.077 ( 0.001 ms): a.out/908002 read(fd: 3, buf: 0xff80ea50,
count: 512)                              =3D 512
    0.079 ( 0.001 ms): a.out/908002 statx(dfd: 3, filename:
0xf7f080f6, flags: NO_AUTOMOUNT|EMPTY_PATH, mask: TYPE|MO>
    0.104 ( 0.000 ms): a.out/908002 close(fd: 3)
                                   =3D 0
    0.112 ( 0.000 ms): a.out/908002 set_tid_address(tidptr:
0xf7ed9528)                                   =3D 908002 (a>
    0.113 ( 0.000 ms): a.out/908002 set_robust_list(head: 0xf7ed952c,
len: 12)                            =3D 0 (swappe>
    0.114 ( 0.001 ms): a.out/908002 rseq(rseq: 0xf7ed9960, rseq_len:
32, sig: 1392848979)                 =3D 0 (swappe>
    0.153 ( 0.003 ms): a.out/908002 mprotect(start: 0xf7eaf000, len:
8192, prot: READ)                    =3D 0
    0.158 ( 0.002 ms): a.out/908002 mprotect(start: 0x565ef000, len:
4096, prot: READ)                    =3D 0
    0.163 ( 0.002 ms): a.out/908002 mprotect(start: 0xf7f13000, len:
8192, prot: READ)                    =3D 0
    0.177 ( 0.005 ms): a.out/908002 munmap(addr: 0xf7ebc000, len:
112066)                                 =3D 0
    0.189 ( 0.009 ms): a.out/908002 openat(dfd: CWD, filename:
0x565ee008)                                =3D 3
    0.198 ( 0.006 ms): a.out/908002 read(fd: 3, buf: 0xff80e56c,
count: 4096)                             =3D 1436
    0.205 ( 0.017 ms): a.out/908002 write(fd: 1, buf: , count: 1436)
                                   =3D 1436
    0.229 (1000.201 ms): a.out/908002 clock_nanosleep(rqtp:
0xff80e494, rmtp: 0xff80e48c)                   =3D 0
 1000.486 (         ): a.out/908002 exit_group()
```

Thanks,
Ian

> v3: Add Charlie's reviewed-by tags. Incorporate feedback from Arnd
>     Bergmann <arnd@arndb.de> on additional optional column and MIPS
>     system call numbering. Rebase past Namhyung's global system call
>     statistics and add comments that they don't yet support an
>     e_machine other than EM_HOST.
>
> v2: Change the 1 element cache for the last table as suggested by
>     Howard Chu, add Howard's reviewed-by tags.
>     Add a comment and apology to Charlie for not doing better in
>     guiding:
>     https://lore.kernel.org/all/20250114-perf_syscall_arch_runtime-v1-1-5=
b304e408e11@rivosinc.com/
>     After discussion on v1 and he agreed this patch series would be
>     the better direction.
>
> Ian Rogers (11):
>   perf dso: Move libunwind dso_data variables into ifdef
>   perf dso: kernel-doc for enum dso_binary_type
>   perf syscalltbl: Remove syscall_table.h
>   perf trace: Reorganize syscalls
>   perf syscalltbl: Remove struct syscalltbl
>   perf dso: Add support for reading the e_machine type for a dso
>   perf thread: Add support for reading the e_machine type for a thread
>   perf trace beauty: Add syscalltbl.sh generating all system call tables
>   perf syscalltbl: Use lookup table containing multiple architectures
>   perf build: Remove Makefile.syscalls
>   perf syscalltbl: Mask off ABI type for MIPS system calls
>
>  tools/perf/Makefile.perf                      |  10 +-
>  tools/perf/arch/alpha/entry/syscalls/Kbuild   |   2 -
>  .../alpha/entry/syscalls/Makefile.syscalls    |   5 -
>  tools/perf/arch/alpha/include/syscall_table.h |   2 -
>  tools/perf/arch/arc/entry/syscalls/Kbuild     |   2 -
>  .../arch/arc/entry/syscalls/Makefile.syscalls |   3 -
>  tools/perf/arch/arc/include/syscall_table.h   |   2 -
>  tools/perf/arch/arm/entry/syscalls/Kbuild     |   4 -
>  .../arch/arm/entry/syscalls/Makefile.syscalls |   2 -
>  tools/perf/arch/arm/include/syscall_table.h   |   2 -
>  tools/perf/arch/arm64/entry/syscalls/Kbuild   |   3 -
>  .../arm64/entry/syscalls/Makefile.syscalls    |   6 -
>  tools/perf/arch/arm64/include/syscall_table.h |   8 -
>  tools/perf/arch/csky/entry/syscalls/Kbuild    |   2 -
>  .../csky/entry/syscalls/Makefile.syscalls     |   3 -
>  tools/perf/arch/csky/include/syscall_table.h  |   2 -
>  .../perf/arch/loongarch/entry/syscalls/Kbuild |   2 -
>  .../entry/syscalls/Makefile.syscalls          |   3 -
>  .../arch/loongarch/include/syscall_table.h    |   2 -
>  tools/perf/arch/mips/entry/syscalls/Kbuild    |   2 -
>  .../mips/entry/syscalls/Makefile.syscalls     |   5 -
>  tools/perf/arch/mips/include/syscall_table.h  |   2 -
>  tools/perf/arch/parisc/entry/syscalls/Kbuild  |   3 -
>  .../parisc/entry/syscalls/Makefile.syscalls   |   6 -
>  .../perf/arch/parisc/include/syscall_table.h  |   8 -
>  tools/perf/arch/powerpc/entry/syscalls/Kbuild |   3 -
>  .../powerpc/entry/syscalls/Makefile.syscalls  |   6 -
>  .../perf/arch/powerpc/include/syscall_table.h |   8 -
>  tools/perf/arch/riscv/entry/syscalls/Kbuild   |   2 -
>  .../riscv/entry/syscalls/Makefile.syscalls    |   4 -
>  tools/perf/arch/riscv/include/syscall_table.h |   8 -
>  tools/perf/arch/s390/entry/syscalls/Kbuild    |   2 -
>  .../s390/entry/syscalls/Makefile.syscalls     |   5 -
>  tools/perf/arch/s390/include/syscall_table.h  |   2 -
>  tools/perf/arch/sh/entry/syscalls/Kbuild      |   2 -
>  .../arch/sh/entry/syscalls/Makefile.syscalls  |   4 -
>  tools/perf/arch/sh/include/syscall_table.h    |   2 -
>  tools/perf/arch/sparc/entry/syscalls/Kbuild   |   3 -
>  .../sparc/entry/syscalls/Makefile.syscalls    |   5 -
>  tools/perf/arch/sparc/include/syscall_table.h |   8 -
>  tools/perf/arch/x86/entry/syscalls/Kbuild     |   3 -
>  .../arch/x86/entry/syscalls/Makefile.syscalls |   6 -
>  tools/perf/arch/x86/include/syscall_table.h   |   8 -
>  tools/perf/arch/xtensa/entry/syscalls/Kbuild  |   2 -
>  .../xtensa/entry/syscalls/Makefile.syscalls   |   4 -
>  .../perf/arch/xtensa/include/syscall_table.h  |   2 -
>  tools/perf/builtin-trace.c                    | 290 +++++++++++-------
>  tools/perf/scripts/Makefile.syscalls          |  61 ----
>  tools/perf/scripts/syscalltbl.sh              |  86 ------
>  tools/perf/trace/beauty/syscalltbl.sh         | 274 +++++++++++++++++
>  tools/perf/util/dso.c                         |  54 ++++
>  tools/perf/util/dso.h                         |  56 ++++
>  tools/perf/util/syscalltbl.c                  | 148 ++++-----
>  tools/perf/util/syscalltbl.h                  |  22 +-
>  tools/perf/util/thread.c                      |  80 +++++
>  tools/perf/util/thread.h                      |  14 +-
>  56 files changed, 756 insertions(+), 509 deletions(-)
>  delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Makefile.syscall=
s
>  delete mode 100644 tools/perf/arch/alpha/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/arc/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/arc/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/arm/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/arm/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/arm/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Makefile.syscall=
s
>  delete mode 100644 tools/perf/arch/arm64/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/csky/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/csky/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Makefile.sys=
calls
>  delete mode 100644 tools/perf/arch/loongarch/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/mips/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/mips/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Makefile.syscal=
ls
>  delete mode 100644 tools/perf/arch/parisc/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Makefile.sysca=
lls
>  delete mode 100644 tools/perf/arch/powerpc/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Makefile.syscall=
s
>  delete mode 100644 tools/perf/arch/riscv/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/s390/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/s390/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/s390/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/sh/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/sh/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/sh/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Makefile.syscall=
s
>  delete mode 100644 tools/perf/arch/sparc/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/x86/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/x86/entry/syscalls/Makefile.syscalls
>  delete mode 100644 tools/perf/arch/x86/include/syscall_table.h
>  delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Kbuild
>  delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Makefile.syscal=
ls
>  delete mode 100644 tools/perf/arch/xtensa/include/syscall_table.h
>  delete mode 100644 tools/perf/scripts/Makefile.syscalls
>  delete mode 100755 tools/perf/scripts/syscalltbl.sh
>  create mode 100755 tools/perf/trace/beauty/syscalltbl.sh
>
> --
> 2.48.1.711.g2feabab25a-goog
>
