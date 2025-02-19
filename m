Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CF5286280
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 22:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740003719; cv=none; b=ekYIsFWZsfjnipQW7zzYnNG57O3h/+/H63PLsgqi9hrLF/97sCToB0Dbw5MfbeqFT8fcu9bQbebtdUxuzEjfBxyz1JgPSFLrn5v1LJTowDjv7Izh3pUsQI0wj+Yy243v169iR4nm5ClquhHY8HLn3xB8Gaxrm49Rh/hzQ6p2fUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740003719; c=relaxed/simple;
	bh=hBzqdCtneFuMsP5nyywi6NV/LjfslNsGNHUfZG0zYeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iynQymoSYTxLwYXqEzq3Z3RCNJbCTv83bdsqjgZzpRNio2O3VcA57IoVQQ3REe1zM1aU8ImaHGn+lLAYcWf4o/BvcoCl7GZJnL4++vlz63wNjmJze3ZlbWfSdOT11n01mYZaVY4oHmtjQL+dMmK9sEuBxIq4ZV4LSkrn5dA5ar8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yUCZljmb; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yUCZljmb"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d1925db9e7so44255ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 14:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740003717; x=1740608517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/ROFmG1Jh1Co292C4FfpRP7+qKcEhN1gIc1KL1r4xk=;
        b=yUCZljmbCoVyEhENZYWlRhcppKTvWCH0Pv9HOVMfm64xKa5uB3gunweFJq+C41bIhK
         0DLYmZyx+q7kHeSnnmupVVfDghXP2uBjAlsLbNnwk2jGJypirJNi5fJKFL30QIMlwW02
         cBu+L+hAC5WKjtucjJGJ9JYxoH4bHAPGwM8sj0Nj7+nAG4iUQtuf2rQ3B0zso1pQPi7n
         O8q6sPAYMETpc0VMW009zZh4RWi6pBqoyf+B6fd0yIK4AFWlIAzIlczdQt9vFTKtFu3X
         XpbkgSprvMPrbII9VzesnanPBBrEv4ecW7jb7zAqnpqU3m3FOnrnUDn9wYBsTJLNZ1uY
         mwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740003717; x=1740608517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/ROFmG1Jh1Co292C4FfpRP7+qKcEhN1gIc1KL1r4xk=;
        b=EToqz+Nhj+G5FGI3EiTrXtOHoFHmynbljyuCCiKWT9XNayaNCqyvFFg0X/E9aeDLa7
         cf6QEai20XfV0wpue556MV1J+S+eLRU2ehw+JxtLIQFOeBzMd62IYs19mnUalYZofXem
         +Ehh5dtqhSP4U6rcNByocmCdIEPV96/QP9JUIJT+sdTd0dszVv+YhnuRUQ+DJWW73eY3
         4zuNYhwO0uOi/sE5ec992wikVgoYRCEWkEfXV7ht8Gt0oIKNuA6zq4NWpxY0V9YdaOxs
         uu06VTuKfv5UzrKSdiiECedpH/pJrqYNp+1YDiiDqVPR+rKqNrMQAsCdu/Kze/gg1VLP
         bIXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPu93BQDiCSDV3VbdzPOEVffH6bGjd5odvj3F5k3fmVX0JQp7dO5wMvvlqDbTmQWDeOCAurFbm2Ja+HvdFDbs/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy4Y/UwAd+N0hHAQT31dmk6Y5k/nFRKb3bjJjjeDKVolC0oDkF
	jB8ecb6P2q5QhH3TAb3tQ+8s/OX5K4CLEPBRrZcX/jwkRms8cjgDYe8U4ys1CTBpKQpPAw/rBZj
	6OoPGrr82Sr63cBWDaqueF0oGX9cr9eZHYpdW
X-Gm-Gg: ASbGncuajink9L1FVZXcICu3f28j/ENxAJaJKqXuONNITFqBLkksNJ5yZ1RtWNt6O2A
	f5CLH7hJPyqZ6WPamhRMW3KdD4EVehjz/j+jrSkWlNVKWVBomJ7XuT++Mi8EIZpb/xfyMkSmvQ0
	LtXnEo8o3TnUqQTW1nQNZJQJA7zw==
X-Google-Smtp-Source: AGHT+IFnB7AqlGnSpuMhSJxw+n+pOt7uS6hOFOeecUVD5ZjeBpf9Rnf3XKizn5jw0YAsmldnOcaQqh795F1jYfDBTGM=
X-Received: by 2002:a05:6e02:3f86:b0:3d2:ae8a:8a47 with SMTP id
 e9e14a558f8ab-3d2c2513c78mr332625ab.29.1740003717097; Wed, 19 Feb 2025
 14:21:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207232452.994822-1-irogers@google.com> <20250207232452.994822-2-irogers@google.com>
 <Z7ZSVvmvYXD7Clnb@google.com>
In-Reply-To: <Z7ZSVvmvYXD7Clnb@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Feb 2025 14:21:45 -0800
X-Gm-Features: AWEUYZlP2XKMVI2rgRrnexGEW4wh8Pf7KLiW8EzVy3qAgYbeN4g1Huw6_anTKHI
Message-ID: <CAP-5=fWukOvV4EKbn1n=rhBO1LBf9m040=WXEweeFXAr3GCiQA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] tools lib api: Add io_dir an allocation free
 readdir alternative
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Sam James <sam@gentoo.org>, Jesper Juhl <jesperjuhl76@gmail.com>, 
	James Clark <james.clark@linaro.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Anne Macedo <retpolanne@posteo.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 1:51=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Feb 07, 2025 at 03:24:42PM -0800, Ian Rogers wrote:
> > glibc's opendir allocates a minimum of 32kb, when called recursively
> > for a directory tree the memory consumption can add up - nearly 300kb
> > during perf start-up when processing modules. Add a stack allocated
> > variant of readdir sized a little more than 1kb.
> >
> > As getdents64 may be missing from libc, add support using syscall.
> > Note, an earlier version of this patch had a feature test for
> > getdents64 but there were problems on certains distros where
> > getdents64 would be #define renamed to getdents breaking the code. The
> > syscall use was made uncondtional to work around this. There is
> > context in:
> > https://lore.kernel.org/lkml/20231207050433.1426834-1-irogers@google.co=
m/
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/api/Makefile |  2 +-
> >  tools/lib/api/io_dir.h | 93 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 94 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/lib/api/io_dir.h
> >
> > diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
> > index 7f6396087b46..8665c799e0fa 100644
> > --- a/tools/lib/api/Makefile
> > +++ b/tools/lib/api/Makefile
> > @@ -95,7 +95,7 @@ install_lib: $(LIBFILE)
> >               $(call do_install_mkdir,$(libdir_SQ)); \
> >               cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
> >
> > -HDRS :=3D cpu.h debug.h io.h
> > +HDRS :=3D cpu.h debug.h io.h io_dir.h
> >  FD_HDRS :=3D fd/array.h
> >  FS_HDRS :=3D fs/fs.h fs/tracing_path.h
> >  INSTALL_HDRS_PFX :=3D $(DESTDIR)$(prefix)/include/api
> > diff --git a/tools/lib/api/io_dir.h b/tools/lib/api/io_dir.h
> > new file mode 100644
> > index 000000000000..c84738923c96
> > --- /dev/null
> > +++ b/tools/lib/api/io_dir.h
> > @@ -0,0 +1,93 @@
> > +/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> > +/*
> > + * Lightweight directory reading library.
> > + */
> > +#ifndef __API_IO_DIR__
> > +#define __API_IO_DIR__
> > +
> > +#include <dirent.h>
> > +#include <fcntl.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <sys/stat.h>
> > +#include <sys/syscall.h>
> > +
> > +#if !defined(SYS_getdents64)
> > +#if defined(__x86_64__)
> > +#define SYS_getdents64 217
> > +#elif defined(__aarch64__)
> > +#define SYS_getdents64 61
> > +#endif
> > +#endif
> > +
> > +static inline ssize_t perf_getdents64(int fd, void *dirp, size_t count=
)
> > +{
> > +#ifdef MEMORY_SANITIZER
> > +     memset(dirp, 0, count);
> > +#endif
> > +     return syscall(SYS_getdents64, fd, dirp, count);
>
> Unfortunately this fails to build on my i386 vm (and probably other old
> archs don't have SYS_getdents64 yet).
>
>   In file included from util/pmus.c:6:
>   /build/libapi/include/api/io_dir.h: In function 'perf_getdents64':
>   /build/libapi/include/api/io_dir.h:28:24: error: 'SYS_getdents64' undec=
lared (first use in this function); did you mean 'perf_getdents64'?
>      28 |         return syscall(SYS_getdents64, fd, dirp, count);
>         |                        ^~~~~~~~~~~~~~
>         |                        perf_getdents64
>
> > +}
> > +#endif
>
> Maybe mismatched.

So even on 32-bit systems we want getdents64 as getdents encodes the
d_type at the end of dirent making it hard to index. On i386 we know
the number of the syscall for perf trace:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl?h=3Dperf-tools-next#n2=
35
So we can presumably change:
```
#if !defined(SYS_getdents64)
#if defined(__x86_64__)
#define SYS_getdents64 217
#elif defined(__aarch64__)
#define SYS_getdents64 61
#endif
#endif
```
to also have:
```
#elif defined(__i386__)
#define SYS_getdents64 220
```
Could you test this so that I don't need to resend 7 patches for each
architecture you test upon? The man page says <sys/syscall.h> and
<unistd.h> should be sufficient for the code to work, so I think
addressing this is adding workarounds for distros that aren't
conformant - ie its the distro's fault the code fails to compile and
not the tool's.

Thanks,
Ian

> Thanks,
> Namhyung
>
> > +
> > +struct io_dirent64 {
> > +     ino64_t        d_ino;    /* 64-bit inode number */
> > +     off64_t        d_off;    /* 64-bit offset to next structure */
> > +     unsigned short d_reclen; /* Size of this dirent */
> > +     unsigned char  d_type;   /* File type */
> > +     char           d_name[NAME_MAX + 1]; /* Filename (null-terminated=
) */
> > +};
> > +
> > +struct io_dir {
> > +     int dirfd;
> > +     ssize_t available_bytes;
> > +     struct io_dirent64 *next;
> > +     struct io_dirent64 buff[4];
> > +};
> > +
> > +static inline void io_dir__init(struct io_dir *iod, int dirfd)
> > +{
> > +     iod->dirfd =3D dirfd;
> > +     iod->available_bytes =3D 0;
> > +}
> > +
> > +static inline void io_dir__rewinddir(struct io_dir *iod)
> > +{
> > +     lseek(iod->dirfd, 0, SEEK_SET);
> > +     iod->available_bytes =3D 0;
> > +}
> > +
> > +static inline struct io_dirent64 *io_dir__readdir(struct io_dir *iod)
> > +{
> > +     struct io_dirent64 *entry;
> > +
> > +     if (iod->available_bytes <=3D 0) {
> > +             ssize_t rc =3D perf_getdents64(iod->dirfd, iod->buff, siz=
eof(iod->buff));
> > +
> > +             if (rc <=3D 0)
> > +                     return NULL;
> > +             iod->available_bytes =3D rc;
> > +             iod->next =3D iod->buff;
> > +     }
> > +     entry =3D iod->next;
> > +     iod->next =3D (struct io_dirent64 *)((char *)entry + entry->d_rec=
len);
> > +     iod->available_bytes -=3D entry->d_reclen;
> > +     return entry;
> > +}
> > +
> > +static inline bool io_dir__is_dir(const struct io_dir *iod, struct io_=
dirent64 *dent)
> > +{
> > +     if (dent->d_type =3D=3D DT_UNKNOWN) {
> > +             struct stat st;
> > +
> > +             if (fstatat(iod->dirfd, dent->d_name, &st, /*flags=3D*/0)=
)
> > +                     return false;
> > +
> > +             if (S_ISDIR(st.st_mode)) {
> > +                     dent->d_type =3D DT_DIR;
> > +                     return true;
> > +             }
> > +     }
> > +     return dent->d_type =3D=3D DT_DIR;
> > +}
> > +
> > +#endif
> > --
> > 2.48.1.502.g6dc24dfdaf-goog
> >
