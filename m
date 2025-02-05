Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3FC1FDE38;
	Wed,  5 Feb 2025 00:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738715092; cv=none; b=ARzPLgm4Eug5YOeEkrgSNUN8nojmOmkyQEFRt8i9wrR9xLJy8oAqb2eeW+jcUOEEhtd73VLcIQKed8M3GYhgOmXcDHOfQ4Qp9nzUEJS4ON7Oo7Q6QblUcVuyIY/C8r69Ot6kli1Hs6FHiXUGROjPMIBh9J1DWRQokhIC0mBhwaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738715092; c=relaxed/simple;
	bh=bNP0C/mvlwdXsFn2VUm9f134dzLyjeX0pTFQ8C0k5pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQZZJKo9yo8idZWFeWdZv6vq8BihwjzCJ7xSb8hqw94um+LT5hUXMmyp1/7HKXuniCWEWI6xmdS0qFFnczV7w9Wg71HnTe4qyx04KNYIg1qb6NM2IPmPhCW2YIqYrYZmJrK1QZ0u9jdCjxgs3DCPIyAXixNkXbSpdy7eyioU1Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8KHi7Gi; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8KHi7Gi"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e3c8ae3a3b2so5561941276.0;
        Tue, 04 Feb 2025 16:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738715089; x=1739319889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pV+yVg74O6M+JjWsYidBH2vKWaB+LVbg5Losiv7J8Tk=;
        b=k8KHi7GigfAnZrt+VbuBTJJyXaJnvWV9yF2kWlaCAs1qKV2n//Ymsyqq5BxIXeVyrA
         OGozsDXGxnAQ0WIEHiQGLIhh1/AiEWxDQ0APcVIliXmWphqqdJEsyHfVwo/9UDbLhExk
         +Ws0W7pzofXaYImmyefvv0H9j20AZ3Qmzr4SQ4sMAi/yverH6nLY5HlDnyKvMXoQe9S0
         Ej8DpdQtIWiDgqH07o5k69OZYxShPIOPa7kD7WxSk2PwsrNC4G3xTkPy7DVkl/tmCcY5
         PjrDN1uMAZoCjdTTwVGKZvA/I0mzuFBZl1BkmzGheiHrsMsZRT9PisRN2UzN98E+K0iJ
         tYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738715089; x=1739319889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pV+yVg74O6M+JjWsYidBH2vKWaB+LVbg5Losiv7J8Tk=;
        b=smsaFCZ2tVo9D4pNSiCL9NjzpEcSEcbNgMf4pL0NoGxfoNkTZGzmAKFqaUsSURgeGd
         Uwfm15eFVZYP4xXxcIAdFE8JvVfyPZ7vxdLSaHgJFUJI5fkoKioIYNfk3pXBDuX7+WyW
         QXOdoLtv2EfW8J8dfPsvJpHBghUwLghrQs4/1MByjhFAqCTXnxcgIkty0q3A/jo4xy4R
         xh0OvQ1GubJ1n83g4jsrn2MEtlMSD/iPwlNo09l9pdER0afhPD9avjLeeC26/FS3GQRG
         aJiRwCTBY9PcgLl07PH+HSMGkHS1OlDDjY+5EPxUJMrt4qpejushvc7pLrf1OU9/jOrP
         +Hkw==
X-Forwarded-Encrypted: i=1; AJvYcCVXodo9c9xoobLN8VCVpbNkfi7273LVHS43OVg7E3HaQ+Vv+Pp2X12hnqC0v97oMz6p6IinoQKrrcgsy634FbTROA==@vger.kernel.org, AJvYcCW6iK/XgUZdkEVz3dOyI4WI3NrG+ZyGabK2ZqKUVth18GlzCL1yp3OSrJ+9sa/rF4nNv6FfVbeNrau7@vger.kernel.org, AJvYcCW9GCDFB4dZGa/JFU8PtJqBOBdqhQH/2chDgzPHyGG18wOxdBcYZwx+Mf/8we+ONIboZxr/IXfDlG4gokoI@vger.kernel.org
X-Gm-Message-State: AOJu0Yztc3etZtvfyGNihG9rQEMv96kAbi0dCkJOHwJmhhS9VgpQtsTY
	VhlZxvpldMJOnoM/7V0AiepPdsHjw0fULGHfrP+o4bHbW9lQ6DCR/Tqh4e+fDnyjYbn0lHGU1qh
	3lLC1mAe3aYtb9AspUyKAYqw/geQ=
X-Gm-Gg: ASbGnct175F25eSchlsL7EqAAqyPM0O+HlLXak8alACjOH+PVtx+Cb85qVJftPWfzLr
	XpPsv6qqJveuNucDh51psVYAni3v1lRO4sHR83CTsZ0Ihx/v6GdXT4nd+clYRC4BjUUGhi08=
X-Google-Smtp-Source: AGHT+IFlsq7s2GXQcMJV9ME/Neo9VjBp8UIKcRBwptanpGVug8P8PrIq9QJK6U7+DKwL96DfTVdCKiUymMLMc3Gqjc4=
X-Received: by 2002:a05:690c:4c09:b0:6f9:7e35:67a3 with SMTP id
 00721157ae682-6f989f58ad8mr9941447b3.28.1738715089289; Tue, 04 Feb 2025
 16:24:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201071455.718247-1-irogers@google.com> <20250201071455.718247-7-irogers@google.com>
In-Reply-To: <20250201071455.718247-7-irogers@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Tue, 4 Feb 2025 16:24:38 -0800
X-Gm-Features: AWEUYZnskUbLhOOdO0dxqAGDHNNLRcx4pR85s1wteJQdCeOlkqATDMc8AaJSwc0
Message-ID: <CAH0uvoiAAYcKOUVMd9saq7FabroD-VcWdD2JTxQ5ZRf2OHkh=w@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] perf syscalltbl: Use lookup table containing
 multiple architectures
To: Ian Rogers <irogers@google.com>
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

Hello,

On Fri, Jan 31, 2025 at 11:15=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> Switch to use the lookup table containing all architectures rather
> than tables matching the perf binary.
>
> This fixes perf trace when executed on a 32-bit i386 binary on an
> x86-64 machine. Note in the following the system call names of the
> 32-bit i386 binary as seen by an x86-64 perf.
>
> Before:
> ```
>          ? (         ): a.out/447296  ... [continued]: munmap())         =
                                  =3D 0
>      0.024 ( 0.001 ms): a.out/447296 recvfrom(ubuf: 0x2, size: 4160585708=
, flags: DONTROUTE|CTRUNC|TRUNC|DONTWAIT|EOR|WAITALL|FIN|SYN|CONFIRM|RST|ER=
RQUEUE|NOSIGNAL|WAITFORONE|BATCH|SOCK_DEVMEM|ZEROCOPY|FASTOPEN|CMSG_CLOEXEC=
|0x91f80000, addr: 0xe30, addr_len: 0xffce438c) =3D 1475198976
>      0.042 ( 0.003 ms): a.out/447296 lgetxattr(name: "", value: 0x3, size=
: 34)                             =3D 4160344064
>      0.054 ( 0.003 ms): a.out/447296 dup2(oldfd: -134422744, newfd: 4)   =
                                  =3D -1 ENOENT (No such file or directory)
>      0.060 ( 0.009 ms): a.out/447296 preadv(fd: 4294967196, vec: (struct =
iovec){.iov_base =3D (void *)0x2e646c2f6374652f,.iov_len =3D (__kernel_size=
_t)7307199665335594867,}, vlen: 557056, pos_h: 4160585708) =3D 3
>      0.074 ( 0.004 ms): a.out/447296 lgetxattr(name: "", value: 0x1, size=
: 2)                              =3D 4160237568
>      0.080 ( 0.001 ms): a.out/447296 lstat(filename: "", statbuf: 0x193f6=
)                                 =3D 0
>      0.089 ( 0.007 ms): a.out/447296 preadv(fd: 4294967196, vec: (struct =
iovec){.iov_base =3D (void *)0x3833692f62696c2f,.iov_len =3D (__kernel_size=
_t)3276497845987585334,}, vlen: 557056, pos_h: 4160585708) =3D 3
>      0.097 ( 0.002 ms): a.out/447296 close(fd: 3</proc/447296/status>)   =
                                  =3D 512
>      0.103 ( 0.002 ms): a.out/447296 lgetxattr(name: "", value: 0x1, size=
: 2050)                           =3D 4157935616
>      0.107 ( 0.007 ms): a.out/447296 lgetxattr(pathname: "", name: "", va=
lue: 0x5, size: 2066)             =3D 4158078976
>      0.116 ( 0.003 ms): a.out/447296 lgetxattr(pathname: "", name: "", va=
lue: 0x1, size: 2066)             =3D 4159639552
>      0.121 ( 0.003 ms): a.out/447296 lgetxattr(pathname: "", name: "", va=
lue: 0x3, size: 2066)             =3D 4160184320
>      0.129 ( 0.002 ms): a.out/447296 lgetxattr(pathname: "", name: "", va=
lue: 0x3, size: 50)               =3D 4160196608
>      0.138 ( 0.001 ms): a.out/447296 lstat(filename: "")                 =
                                  =3D 0
>      0.145 ( 0.002 ms): a.out/447296 mq_timedreceive(mqdes: 4291706800, u=
_msg_ptr: 0xf7f9ea48, msg_len: 134616640, u_msg_prio: 0xf7fd7fec, u_abs_tim=
eout: (struct __kernel_timespec){.tv_sec =3D (__kernel_time64_t)-5781740277=
77317696,.tv_nsec =3D (long long int)4160349376,}) =3D 0
>      0.148 ( 0.001 ms): a.out/447296 mkdirat(dfd: -134617816, pathname: "=
 =EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD=E2=96=92=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=E2=96=92=EF=BF=BD=EF=BF=BD=EF=BF=BD", mode: IFREG|ISUID|=
IRUSR|IWGRP|0xf7fd0000) =3D 447296
>      0.150 ( 0.001 ms): a.out/447296 process_vm_writev(pid: -134617812, l=
vec: (struct iovec){.iov_base =3D (void *)0xf7f9e9c8f7f9e4c0,.iov_len =3D (=
__kernel_size_t)4160349376,}, liovcnt: 4160588048, rvec: (struct iovec){}, =
riovcnt: 4160585708, flags: 4291707352) =3D 0
>      0.197 ( 0.004 ms): a.out/447296 capget(header: 4160184320, dataptr: =
8192)                             =3D 0
>      0.202 ( 0.002 ms): a.out/447296 capget(header: 1448669184, dataptr: =
4096)                             =3D 0
>      0.208 ( 0.002 ms): a.out/447296 capget(header: 4160577536, dataptr: =
8192)                             =3D 0
>      0.220 ( 0.001 ms): a.out/447296 getxattr(pathname: "", name: "c=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD", value: 0xf7f77e34, si=
ze: 1)  =3D 0
>      0.228 ( 0.005 ms): a.out/447296 fchmod(fd: -134729728, mode: IRUGO|I=
WUGO|IFREG|IFIFO|ISVTX|IXUSR|0x10000) =3D 0
>      0.240 ( 0.009 ms): a.out/447296 preadv(fd: 4294967196, vec: 0x5658e0=
08, pos_h: 4160192052)            =3D 3
>      0.250 ( 0.008 ms): a.out/447296 close(fd: 3</proc/447296/status>)   =
                                  =3D 1436
>      0.260 ( 0.018 ms): a.out/447296 stat(filename: "", statbuf: 0xffce32=
ac)                               =3D 1436
>      0.288 (1000.213 ms): a.out/447296 readlinkat(buf: 0xffce31d4, bufsiz=
: 4291703244)                       =3D 0
> ```
>
> After:
> ```
>          ? (         ): a.out/442930  ... [continued]: execve())         =
                                  =3D 0
>      0.023 ( 0.002 ms): a.out/442930 brk()                               =
                                  =3D 0x57760000
>      0.052 ( 0.003 ms): a.out/442930 access(filename: 0xf7f5af28, mode: R=
)                                 =3D -1 ENOENT (No such file or directory)
>      0.059 ( 0.009 ms): a.out/442930 openat(dfd: CWD, filename: "/etc/ld.=
so.cache", flags: RDONLY|CLOEXEC|LARGEFILE) =3D 3
>      0.078 ( 0.001 ms): a.out/442930 close(fd: 3</proc/442930/status>)   =
                                  =3D 0
>      0.087 ( 0.007 ms): a.out/442930 openat(dfd: CWD, filename: "/lib/i38=
6-linux-", flags: RDONLY|CLOEXEC|LARGEFILE) =3D 3
>      0.095 ( 0.002 ms): a.out/442930 read(fd: 3</proc/442930/status>, buf=
: 0xffbdbb70, count: 512)         =3D 512
>      0.135 ( 0.001 ms): a.out/442930 close(fd: 3</proc/442930/status>)   =
                                  =3D 0
>      0.148 ( 0.001 ms): a.out/442930 set_tid_address(tidptr: 0xf7f2b528) =
                                  =3D 442930 (a.out)
>      0.150 ( 0.001 ms): a.out/442930 set_robust_list(head: 0xf7f2b52c, le=
n: 12)                            =3D
>      0.196 ( 0.004 ms): a.out/442930 mprotect(start: 0xf7f03000, len: 819=
2, prot: READ)                    =3D 0
>      0.202 ( 0.002 ms): a.out/442930 mprotect(start: 0x5658e000, len: 409=
6, prot: READ)                    =3D 0
>      0.207 ( 0.002 ms): a.out/442930 mprotect(start: 0xf7f63000, len: 819=
2, prot: READ)                    =3D 0
>      0.230 ( 0.005 ms): a.out/442930 munmap(addr: 0xf7f10000, len: 103414=
)                                 =3D 0
>      0.244 ( 0.010 ms): a.out/442930 openat(dfd: CWD, filename: 0x5658d00=
8)                                =3D 3
>      0.255 ( 0.007 ms): a.out/442930 read(fd: 3</proc/442930/status>, buf=
: 0xffbdb67c, count: 4096)        =3D 1436
>      0.264 ( 0.018 ms): a.out/442930 write(fd: 1</dev/pts/4>, buf: , coun=
t: 1436)                          =3D 1436
>      0.292 (1000.173 ms): a.out/442930 clock_nanosleep(rqtp: { .tv_sec: 1=
7866546940376776704, .tv_nsec: 4159878336 }, rmtp: 0xffbdb59c) =3D 0
>   1000.478 (         ): a.out/442930 exit_group()                        =
                                  =3D ?
> ```
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/syscalltbl.c | 89 ++++++++++++++++++++++++++----------
>  1 file changed, 64 insertions(+), 25 deletions(-)
>
> diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
> index 760ac4d0869f..572083ba1efe 100644
> --- a/tools/perf/util/syscalltbl.c
> +++ b/tools/perf/util/syscalltbl.c
> @@ -15,16 +15,39 @@
>  #include <string.h>
>  #include "string2.h"
>
> -#if __BITS_PER_LONG =3D=3D 64
> -  #include <asm/syscalls_64.h>
> -#else
> -  #include <asm/syscalls_32.h>
> -#endif
> +#include "trace/beauty/generated/syscalltbl.c"
>
> -const char *syscalltbl__name(int e_machine __maybe_unused, int id)
> +static const struct syscalltbl *find_table(int e_machine)
>  {
> -       if (id >=3D 0 && id <=3D (int)ARRAY_SIZE(syscall_num_to_name))
> -               return syscall_num_to_name[id];
> +       static const struct syscalltbl *last_table;
> +       static int last_table_machine =3D EM_NONE;
> +
> +       /* Tables only exist for EM_SPARC. */
> +       if (e_machine =3D=3D EM_SPARCV9)
> +               e_machine =3D EM_SPARC;
> +
> +       if (last_table_machine =3D=3D e_machine && e_machine !=3D EM_NONE=
)

I don't think it should be && e_machine !=3D EM_NONE. last_table_machine
=3D=3D e_machine =3D=3D EM_NONE could mean last_table being uninitialized, =
but
what if the called *is* trying to search for e_machine =3D=3D EM_NONE? Now
perf will need to traverse the whole syscalltbls array just to find
the last EM_NONE table.

My suggestion is:

static const struct syscalltbl *last_table =3D NULL;

and then:

if (last_table_machine =3D=3D e_machine && last_table)
    return last_table;

Thanks,
Howard

> +               return last_table;
> +
> +       for (size_t i =3D 0; i < ARRAY_SIZE(syscalltbls); i++) {
> +               const struct syscalltbl *entry =3D &syscalltbls[i];
> +
> +               if (entry->e_machine !=3D e_machine && entry->e_machine !=
=3D EM_NONE)
> +                       continue;
> +
> +               last_table =3D entry;
> +               last_table_machine =3D e_machine;
> +               return entry;
> +       }
> +       return NULL;
> +}
> +
> +const char *syscalltbl__name(int e_machine, int id)
> +{
> +       const struct syscalltbl *table =3D find_table(e_machine);
> +
> +       if (table && id >=3D 0 && id < table->num_to_name_len)
> +               return table->num_to_name[id];
>         return NULL;
>  }
>
> @@ -41,38 +64,54 @@ static int syscallcmpname(const void *vkey, const voi=
d *ventry)
>         return strcmp(key->name, key->tbl[*entry]);
>  }
>
> -int syscalltbl__id(int e_machine __maybe_unused, const char *name)
> +int syscalltbl__id(int e_machine, const char *name)
>  {
> -       struct syscall_cmp_key key =3D {
> -               .name =3D name,
> -               .tbl =3D syscall_num_to_name,
> -       };
> -       const int *id =3D bsearch(&key, syscall_sorted_names,
> -                               ARRAY_SIZE(syscall_sorted_names),
> -                               sizeof(syscall_sorted_names[0]),
> -                               syscallcmpname);
> +       const struct syscalltbl *table =3D find_table(e_machine);
> +       struct syscall_cmp_key key;
> +       const int *id;
> +
> +       if (!table)
> +               return -1;
> +
> +       key.name =3D name;
> +       key.tbl =3D table->num_to_name;
> +       id =3D bsearch(&key, table->sorted_names, table->sorted_names_len=
,
> +                    sizeof(table->sorted_names[0]), syscallcmpname);
>
>         return id ? *id : -1;
>  }
>
> -int syscalltbl__num_idx(int e_machine __maybe_unused)
> +int syscalltbl__num_idx(int e_machine)
>  {
> -       return ARRAY_SIZE(syscall_sorted_names);
> +       const struct syscalltbl *table =3D find_table(e_machine);
> +
> +       if (!table)
> +               return 0;
> +
> +       return table->sorted_names_len;
>  }
>
> -int syscalltbl__id_at_idx(int e_machine __maybe_unused, int idx)
> +int syscalltbl__id_at_idx(int e_machine, int idx)
>  {
> -       return syscall_sorted_names[idx];
> +       const struct syscalltbl *table =3D find_table(e_machine);
> +
> +       if (!table)
> +               return -1;
> +
> +       assert(idx >=3D 0 && idx < table->sorted_names_len);
> +       return table->sorted_names[idx];
>  }
>
> -int syscalltbl__strglobmatch_next(int e_machine __maybe_unused, const ch=
ar *syscall_glob, int *idx)
> +int syscalltbl__strglobmatch_next(int e_machine, const char *syscall_glo=
b, int *idx)
>  {
> -       for (int i =3D *idx + 1; i < (int)ARRAY_SIZE(syscall_sorted_names=
); ++i) {
> -               const char *name =3D syscall_num_to_name[syscall_sorted_n=
ames[i]];
> +       const struct syscalltbl *table =3D find_table(e_machine);
> +
> +       for (int i =3D *idx + 1; table && i < table->sorted_names_len; ++=
i) {
> +               const char *name =3D table->num_to_name[table->sorted_nam=
es[i]];
>
>                 if (strglobmatch(name, syscall_glob)) {
>                         *idx =3D i;
> -                       return syscall_sorted_names[i];
> +                       return table->sorted_names[i];
>                 }
>         }
>
> --
> 2.48.1.362.g079036d154-goog
>
