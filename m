Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC872770B
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Feb 2025 05:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738732666; cv=none; b=OE9js89W0qcbzoQSumbjw/zax8dKfuHT/5E2R937SF+V26snC8xp14JxEWapREVbvTMx5GOdTGdJIgvKyRc5CePDSfK8LqxYbrNUjpDVpnl3x6BoWF8vBb15g80ljuxqE6s1ybYqfcX4J1EJeCsIZ6Q3GSYrbZZ3caIDswXQ4tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738732666; c=relaxed/simple;
	bh=Chy2x7VQAnWc+n/BOReHxmlc0WFyMV0I80HNUn8XL/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwMv6FZJ7M3Uena6/yH8skaJ/wvQKyNZm10pF1hqwmc+S/m5PVPVUIayWTHnRY4wyigH7ndW84tK5YghN+mrh1ITxzAiqSFgSQkUZQ2O1nw3/KmasDM5DatBDONy1xXZ69vcmuifzJJ9KfQHTQtRh/5eZ3O5CAVd3wypsyQgJbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vLEmO9g+; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vLEmO9g+"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so214985ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Feb 2025 21:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738732664; x=1739337464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6VkJiHrbbbiMXK+JGzdxYkUUTdtB+kySQbb5/AnBMY=;
        b=vLEmO9g+OiOgPBEgjt/yA7daLM/+ttOSyliQktsO9I7XHqktCITjzO1t57T+Mxw5mL
         TNRxsifGwtmq1v+qVDoDsOQu1maB3FiqZ+jSpOgvXuLz/Do1f9UGhBNhHSgEaDZ2BwZT
         4EODlcy5Z2kaGvs+al+uNsl4+bdC1sry8/QCJSzh9Kd/7PfxQhsqVlMLB/noDjH0eJ52
         WeWYV2DodWhGq64votj9bJ9Q56SbUw4rmWPDQupmn4Bz1hvPMnQk2EndKb7b4ls3XTW7
         PTsEwP8l727v8WCuTCiCIpvDFMd/POBs5sOr2U5u2cGeyEtZjQSoBd+NYgow9IJ52F0/
         wbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738732664; x=1739337464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6VkJiHrbbbiMXK+JGzdxYkUUTdtB+kySQbb5/AnBMY=;
        b=kmYPA9y0rzqWpsfdQxUedYoB8/j+c3hHIjU6XxRHAry9zhllMVAO6wmbTKNd1VDTSl
         wzbY8uj8vY9uSjVYWG/gEM+ZZTaGOsljeEq825BkZE99WI+7YDjMPHQEqLgR52SrftzX
         Oou/gzKaU1Z4aP8eeU++LZZ1te9cJsaEntXdsejp/Jcr7v4XauoxCZOGXr7WBdST+lWU
         JP0MJQptoDAAHPIlgNNcElvMQzBFTjhEdMRyW5ykts0efwDvayOpfgLeAy+497Po3I1T
         JErs3oqoOAidOfHvdU2pQjtouC8mrJd6tcOubcC6gHmSzDNfkqcEqzGiTI913J9UjTJn
         07yg==
X-Forwarded-Encrypted: i=1; AJvYcCWOQ0dJOOkAYTzQpqeAvIQaJGKzQB8taPaBcg/x/bB2orAG88CQuO2ejuyY8QDdeVGif4OLpq3vCHMan/biuypz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0r3pmXDB7Davcu840+A37mxl06B47d+yzQ0LBGfvxM4NrZNfh
	O8hOzioqfB+6RH66W6fF1ArxHjElO7cUsAmLGhsMs4Fjz+pkS33fhonyjMLIGVd29wtqC58+jNa
	kn6gTwcADlowLiCWaHPNmOKrZfHeWde41YExs
X-Gm-Gg: ASbGncv9DCy033ybfqfAKMQuF6Y7sgTe8V4/RzrmFz0lqSCSLb4T1mVShvKC/DlMTk7
	tmzo3p6nccIMKnYb23OuhmrXPS0boOHXM8UAwOlJhqiR1ILbRyVC3b4kV2RzVU/SpzxB7VrqT3A
	==
X-Google-Smtp-Source: AGHT+IHl43XIfltfroT4EjSgvT6hOpSgzPYI/2ybrdT40o1qTAC93Bg80SiKQtuZ3DF01gNUQSS3XhZ1wvdntIpiYP8=
X-Received: by 2002:a05:6e02:747:b0:3a7:e3b3:2e3 with SMTP id
 e9e14a558f8ab-3d040f54185mr6074905ab.17.1738732663644; Tue, 04 Feb 2025
 21:17:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201071455.718247-1-irogers@google.com> <20250201071455.718247-7-irogers@google.com>
 <CAH0uvoiAAYcKOUVMd9saq7FabroD-VcWdD2JTxQ5ZRf2OHkh=w@mail.gmail.com>
In-Reply-To: <CAH0uvoiAAYcKOUVMd9saq7FabroD-VcWdD2JTxQ5ZRf2OHkh=w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Feb 2025 21:17:32 -0800
X-Gm-Features: AWEUYZlH2MGjNuj5WJ1EYAmYujPw2uUlEhGiKDZ_YCUl2QUP1jM32KceJo_gAPs
Message-ID: <CAP-5=fXV6Jyd6pN7nWWy2mg1XUzbx4x=GNekyEWh9wgPDiF2kg@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] perf syscalltbl: Use lookup table containing
 multiple architectures
To: Howard Chu <howardchu95@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 4:24=E2=80=AFPM Howard Chu <howardchu95@gmail.com> w=
rote:
>
> Hello,
>
> On Fri, Jan 31, 2025 at 11:15=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Switch to use the lookup table containing all architectures rather
> > than tables matching the perf binary.
> >
> > This fixes perf trace when executed on a 32-bit i386 binary on an
> > x86-64 machine. Note in the following the system call names of the
> > 32-bit i386 binary as seen by an x86-64 perf.
> >
> > Before:
> > ```
> >          ? (         ): a.out/447296  ... [continued]: munmap())       =
                                    =3D 0
> >      0.024 ( 0.001 ms): a.out/447296 recvfrom(ubuf: 0x2, size: 41605857=
08, flags: DONTROUTE|CTRUNC|TRUNC|DONTWAIT|EOR|WAITALL|FIN|SYN|CONFIRM|RST|=
ERRQUEUE|NOSIGNAL|WAITFORONE|BATCH|SOCK_DEVMEM|ZEROCOPY|FASTOPEN|CMSG_CLOEX=
EC|0x91f80000, addr: 0xe30, addr_len: 0xffce438c) =3D 1475198976
> >      0.042 ( 0.003 ms): a.out/447296 lgetxattr(name: "", value: 0x3, si=
ze: 34)                             =3D 4160344064
> >      0.054 ( 0.003 ms): a.out/447296 dup2(oldfd: -134422744, newfd: 4) =
                                    =3D -1 ENOENT (No such file or director=
y)
> >      0.060 ( 0.009 ms): a.out/447296 preadv(fd: 4294967196, vec: (struc=
t iovec){.iov_base =3D (void *)0x2e646c2f6374652f,.iov_len =3D (__kernel_si=
ze_t)7307199665335594867,}, vlen: 557056, pos_h: 4160585708) =3D 3
> >      0.074 ( 0.004 ms): a.out/447296 lgetxattr(name: "", value: 0x1, si=
ze: 2)                              =3D 4160237568
> >      0.080 ( 0.001 ms): a.out/447296 lstat(filename: "", statbuf: 0x193=
f6)                                 =3D 0
> >      0.089 ( 0.007 ms): a.out/447296 preadv(fd: 4294967196, vec: (struc=
t iovec){.iov_base =3D (void *)0x3833692f62696c2f,.iov_len =3D (__kernel_si=
ze_t)3276497845987585334,}, vlen: 557056, pos_h: 4160585708) =3D 3
> >      0.097 ( 0.002 ms): a.out/447296 close(fd: 3</proc/447296/status>) =
                                    =3D 512
> >      0.103 ( 0.002 ms): a.out/447296 lgetxattr(name: "", value: 0x1, si=
ze: 2050)                           =3D 4157935616
> >      0.107 ( 0.007 ms): a.out/447296 lgetxattr(pathname: "", name: "", =
value: 0x5, size: 2066)             =3D 4158078976
> >      0.116 ( 0.003 ms): a.out/447296 lgetxattr(pathname: "", name: "", =
value: 0x1, size: 2066)             =3D 4159639552
> >      0.121 ( 0.003 ms): a.out/447296 lgetxattr(pathname: "", name: "", =
value: 0x3, size: 2066)             =3D 4160184320
> >      0.129 ( 0.002 ms): a.out/447296 lgetxattr(pathname: "", name: "", =
value: 0x3, size: 50)               =3D 4160196608
> >      0.138 ( 0.001 ms): a.out/447296 lstat(filename: "")               =
                                    =3D 0
> >      0.145 ( 0.002 ms): a.out/447296 mq_timedreceive(mqdes: 4291706800,=
 u_msg_ptr: 0xf7f9ea48, msg_len: 134616640, u_msg_prio: 0xf7fd7fec, u_abs_t=
imeout: (struct __kernel_timespec){.tv_sec =3D (__kernel_time64_t)-57817402=
7777317696,.tv_nsec =3D (long long int)4160349376,}) =3D 0
> >      0.148 ( 0.001 ms): a.out/447296 mkdirat(dfd: -134617816, pathname:=
 " =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD=E2=96=92=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=E2=96=92=EF=BF=BD=EF=BF=BD=EF=BF=BD", mode: IFREG|ISU=
ID|IRUSR|IWGRP|0xf7fd0000) =3D 447296
> >      0.150 ( 0.001 ms): a.out/447296 process_vm_writev(pid: -134617812,=
 lvec: (struct iovec){.iov_base =3D (void *)0xf7f9e9c8f7f9e4c0,.iov_len =3D=
 (__kernel_size_t)4160349376,}, liovcnt: 4160588048, rvec: (struct iovec){}=
, riovcnt: 4160585708, flags: 4291707352) =3D 0
> >      0.197 ( 0.004 ms): a.out/447296 capget(header: 4160184320, dataptr=
: 8192)                             =3D 0
> >      0.202 ( 0.002 ms): a.out/447296 capget(header: 1448669184, dataptr=
: 4096)                             =3D 0
> >      0.208 ( 0.002 ms): a.out/447296 capget(header: 4160577536, dataptr=
: 8192)                             =3D 0
> >      0.220 ( 0.001 ms): a.out/447296 getxattr(pathname: "", name: "c=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD", value: 0xf7f77e34, si=
ze: 1)  =3D 0
> >      0.228 ( 0.005 ms): a.out/447296 fchmod(fd: -134729728, mode: IRUGO=
|IWUGO|IFREG|IFIFO|ISVTX|IXUSR|0x10000) =3D 0
> >      0.240 ( 0.009 ms): a.out/447296 preadv(fd: 4294967196, vec: 0x5658=
e008, pos_h: 4160192052)            =3D 3
> >      0.250 ( 0.008 ms): a.out/447296 close(fd: 3</proc/447296/status>) =
                                    =3D 1436
> >      0.260 ( 0.018 ms): a.out/447296 stat(filename: "", statbuf: 0xffce=
32ac)                               =3D 1436
> >      0.288 (1000.213 ms): a.out/447296 readlinkat(buf: 0xffce31d4, bufs=
iz: 4291703244)                       =3D 0
> > ```
> >
> > After:
> > ```
> >          ? (         ): a.out/442930  ... [continued]: execve())       =
                                    =3D 0
> >      0.023 ( 0.002 ms): a.out/442930 brk()                             =
                                    =3D 0x57760000
> >      0.052 ( 0.003 ms): a.out/442930 access(filename: 0xf7f5af28, mode:=
 R)                                 =3D -1 ENOENT (No such file or director=
y)
> >      0.059 ( 0.009 ms): a.out/442930 openat(dfd: CWD, filename: "/etc/l=
d.so.cache", flags: RDONLY|CLOEXEC|LARGEFILE) =3D 3
> >      0.078 ( 0.001 ms): a.out/442930 close(fd: 3</proc/442930/status>) =
                                    =3D 0
> >      0.087 ( 0.007 ms): a.out/442930 openat(dfd: CWD, filename: "/lib/i=
386-linux-", flags: RDONLY|CLOEXEC|LARGEFILE) =3D 3
> >      0.095 ( 0.002 ms): a.out/442930 read(fd: 3</proc/442930/status>, b=
uf: 0xffbdbb70, count: 512)         =3D 512
> >      0.135 ( 0.001 ms): a.out/442930 close(fd: 3</proc/442930/status>) =
                                    =3D 0
> >      0.148 ( 0.001 ms): a.out/442930 set_tid_address(tidptr: 0xf7f2b528=
)                                   =3D 442930 (a.out)
> >      0.150 ( 0.001 ms): a.out/442930 set_robust_list(head: 0xf7f2b52c, =
len: 12)                            =3D
> >      0.196 ( 0.004 ms): a.out/442930 mprotect(start: 0xf7f03000, len: 8=
192, prot: READ)                    =3D 0
> >      0.202 ( 0.002 ms): a.out/442930 mprotect(start: 0x5658e000, len: 4=
096, prot: READ)                    =3D 0
> >      0.207 ( 0.002 ms): a.out/442930 mprotect(start: 0xf7f63000, len: 8=
192, prot: READ)                    =3D 0
> >      0.230 ( 0.005 ms): a.out/442930 munmap(addr: 0xf7f10000, len: 1034=
14)                                 =3D 0
> >      0.244 ( 0.010 ms): a.out/442930 openat(dfd: CWD, filename: 0x5658d=
008)                                =3D 3
> >      0.255 ( 0.007 ms): a.out/442930 read(fd: 3</proc/442930/status>, b=
uf: 0xffbdb67c, count: 4096)        =3D 1436
> >      0.264 ( 0.018 ms): a.out/442930 write(fd: 1</dev/pts/4>, buf: , co=
unt: 1436)                          =3D 1436
> >      0.292 (1000.173 ms): a.out/442930 clock_nanosleep(rqtp: { .tv_sec:=
 17866546940376776704, .tv_nsec: 4159878336 }, rmtp: 0xffbdb59c) =3D 0
> >   1000.478 (         ): a.out/442930 exit_group()                      =
                                    =3D ?
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/syscalltbl.c | 89 ++++++++++++++++++++++++++----------
> >  1 file changed, 64 insertions(+), 25 deletions(-)
> >
> > diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.=
c
> > index 760ac4d0869f..572083ba1efe 100644
> > --- a/tools/perf/util/syscalltbl.c
> > +++ b/tools/perf/util/syscalltbl.c
> > @@ -15,16 +15,39 @@
> >  #include <string.h>
> >  #include "string2.h"
> >
> > -#if __BITS_PER_LONG =3D=3D 64
> > -  #include <asm/syscalls_64.h>
> > -#else
> > -  #include <asm/syscalls_32.h>
> > -#endif
> > +#include "trace/beauty/generated/syscalltbl.c"
> >
> > -const char *syscalltbl__name(int e_machine __maybe_unused, int id)
> > +static const struct syscalltbl *find_table(int e_machine)
> >  {
> > -       if (id >=3D 0 && id <=3D (int)ARRAY_SIZE(syscall_num_to_name))
> > -               return syscall_num_to_name[id];
> > +       static const struct syscalltbl *last_table;
> > +       static int last_table_machine =3D EM_NONE;
> > +
> > +       /* Tables only exist for EM_SPARC. */
> > +       if (e_machine =3D=3D EM_SPARCV9)
> > +               e_machine =3D EM_SPARC;
> > +
> > +       if (last_table_machine =3D=3D e_machine && e_machine !=3D EM_NO=
NE)
>
> I don't think it should be && e_machine !=3D EM_NONE. last_table_machine
> =3D=3D e_machine =3D=3D EM_NONE could mean last_table being uninitialized=
, but
> what if the called *is* trying to search for e_machine =3D=3D EM_NONE? No=
w
> perf will need to traverse the whole syscalltbls array just to find
> the last EM_NONE table.
>
> My suggestion is:
>
> static const struct syscalltbl *last_table =3D NULL;
>
> and then:
>
> if (last_table_machine =3D=3D e_machine && last_table)
>     return last_table;

Agreed this is better. I'll add it in v2 with your tags :-)

Thanks,
Ian

> > +               return last_table;
> > +
> > +       for (size_t i =3D 0; i < ARRAY_SIZE(syscalltbls); i++) {
> > +               const struct syscalltbl *entry =3D &syscalltbls[i];
> > +
> > +               if (entry->e_machine !=3D e_machine && entry->e_machine=
 !=3D EM_NONE)
> > +                       continue;
> > +
> > +               last_table =3D entry;
> > +               last_table_machine =3D e_machine;
> > +               return entry;
> > +       }
> > +       return NULL;
> > +}
> > +
> > +const char *syscalltbl__name(int e_machine, int id)
> > +{
> > +       const struct syscalltbl *table =3D find_table(e_machine);
> > +
> > +       if (table && id >=3D 0 && id < table->num_to_name_len)
> > +               return table->num_to_name[id];
> >         return NULL;
> >  }
> >
> > @@ -41,38 +64,54 @@ static int syscallcmpname(const void *vkey, const v=
oid *ventry)
> >         return strcmp(key->name, key->tbl[*entry]);
> >  }
> >
> > -int syscalltbl__id(int e_machine __maybe_unused, const char *name)
> > +int syscalltbl__id(int e_machine, const char *name)
> >  {
> > -       struct syscall_cmp_key key =3D {
> > -               .name =3D name,
> > -               .tbl =3D syscall_num_to_name,
> > -       };
> > -       const int *id =3D bsearch(&key, syscall_sorted_names,
> > -                               ARRAY_SIZE(syscall_sorted_names),
> > -                               sizeof(syscall_sorted_names[0]),
> > -                               syscallcmpname);
> > +       const struct syscalltbl *table =3D find_table(e_machine);
> > +       struct syscall_cmp_key key;
> > +       const int *id;
> > +
> > +       if (!table)
> > +               return -1;
> > +
> > +       key.name =3D name;
> > +       key.tbl =3D table->num_to_name;
> > +       id =3D bsearch(&key, table->sorted_names, table->sorted_names_l=
en,
> > +                    sizeof(table->sorted_names[0]), syscallcmpname);
> >
> >         return id ? *id : -1;
> >  }
> >
> > -int syscalltbl__num_idx(int e_machine __maybe_unused)
> > +int syscalltbl__num_idx(int e_machine)
> >  {
> > -       return ARRAY_SIZE(syscall_sorted_names);
> > +       const struct syscalltbl *table =3D find_table(e_machine);
> > +
> > +       if (!table)
> > +               return 0;
> > +
> > +       return table->sorted_names_len;
> >  }
> >
> > -int syscalltbl__id_at_idx(int e_machine __maybe_unused, int idx)
> > +int syscalltbl__id_at_idx(int e_machine, int idx)
> >  {
> > -       return syscall_sorted_names[idx];
> > +       const struct syscalltbl *table =3D find_table(e_machine);
> > +
> > +       if (!table)
> > +               return -1;
> > +
> > +       assert(idx >=3D 0 && idx < table->sorted_names_len);
> > +       return table->sorted_names[idx];
> >  }
> >
> > -int syscalltbl__strglobmatch_next(int e_machine __maybe_unused, const =
char *syscall_glob, int *idx)
> > +int syscalltbl__strglobmatch_next(int e_machine, const char *syscall_g=
lob, int *idx)
> >  {
> > -       for (int i =3D *idx + 1; i < (int)ARRAY_SIZE(syscall_sorted_nam=
es); ++i) {
> > -               const char *name =3D syscall_num_to_name[syscall_sorted=
_names[i]];
> > +       const struct syscalltbl *table =3D find_table(e_machine);
> > +
> > +       for (int i =3D *idx + 1; table && i < table->sorted_names_len; =
++i) {
> > +               const char *name =3D table->num_to_name[table->sorted_n=
ames[i]];
> >
> >                 if (strglobmatch(name, syscall_glob)) {
> >                         *idx =3D i;
> > -                       return syscall_sorted_names[i];
> > +                       return table->sorted_names[i];
> >                 }
> >         }
> >
> > --
> > 2.48.1.362.g079036d154-goog
> >
