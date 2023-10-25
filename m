Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD5215AE5
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1DsJB2Dx"
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C60113D
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 15:15:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so2043a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 15:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698272123; x=1698876923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqlUerMhKr5CWZt1rOp12v/eNu4IVxFKhBW0DqHNmOI=;
        b=1DsJB2DxjwFBAt7mdBYt8TTK8BUFt2WAt4iUXrAICUWGbq4CCy5zA64Hn+KcWeYl2g
         zoghAIDykRovVcVyERtdO4t2GQEJB+T6d/AmDEla1GrBejBI0zjuKLBN/RU3VehFt5Ra
         J0JYW2WxTz6BV8TlpKX33xuj1/++wHbEnCEdqkX09TAOLf3OR5ujZMZZ8Fax9KP5pj9p
         ZtRrgViyID7D27KDmE1CZA8xiYAmim26nEkpuXeKhDdEAq2+xGE4jyThLhPL+3FhH7cz
         /BWcJdos8I3C0HDap12opuBIkRRySOjYRDmOhM7m5+4lSfv9+wPtp0vkTN6ZV/BHr8+u
         vL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698272123; x=1698876923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqlUerMhKr5CWZt1rOp12v/eNu4IVxFKhBW0DqHNmOI=;
        b=WoMSCf+xgXpXq9DYRM46AVZeOwzhGfZrRwe+zWyesoepgco5FbZ9bLjWiiKynrY8d8
         LFV9+8p5Z7qaejv1gTFBKAEv99hnvzeQEFZWe5b1LAZUeAzL7aF1G01BkevKCKCRYq4u
         e29WClkifddHObfCqNyRDAYY2G0oVyeRP7FW0N9JkzHBddUhjjsjfjOOvZEtQQQ+8dmk
         yUE9CI4uS0Kwlsan5Sf64SDvxc4+uSf7iNEeAcbuL+E5YQe5YmV2m69PvgmNAv/lcyLS
         qfzAhcRertUyoSXG0MUsO4rkpwj4+f+8TQw8QjeD8sSzlJeDQpXLsjm3xR03B8eNCVCw
         qG+A==
X-Gm-Message-State: AOJu0YyNaxAjb+NF3UtE5YGkVBfxWnzg+ArjBZmNbw/koBZpkGsVwxhP
	llFvuwN5pe2Sr9SpzWcDXpgqU5a/1L3id2UqSlWGJQ==
X-Google-Smtp-Source: AGHT+IETcTXYzELVRryiBLJWvLn4rAixpPuHPMQIORlnjCN40JmjFtMdpEJ6S6zV06rUmIgFJVFcwLxlykM4J5OfSno=
X-Received: by 2002:a05:6402:114a:b0:540:e63d:3cfb with SMTP id
 g10-20020a056402114a00b00540e63d3cfbmr164427edw.3.1698272122491; Wed, 25 Oct
 2023 15:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com> <20231024222353.3024098-19-irogers@google.com>
 <CAM9d7chKwxnCe=FDCxyuui5S8yp4=3xYytShCi9QTGzjK1yqZw@mail.gmail.com>
In-Reply-To: <CAM9d7chKwxnCe=FDCxyuui5S8yp4=3xYytShCi9QTGzjK1yqZw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Oct 2023 15:15:10 -0700
Message-ID: <CAP-5=fXvdtfez7421aR4RtZQdPtUizmrD1ELa_fsPNAd5=qY-A@mail.gmail.com>
Subject: Re: [PATCH v3 18/50] tools lib api: Add io_dir an allocation free
 readdir alternative
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Leo Yan <leo.yan@linaro.org>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, James Clark <james.clark@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	German Gomez <german.gomez@arm.com>, Changbin Du <changbin.du@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 11:43=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Tue, Oct 24, 2023 at 3:24=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > glibc's opendir allocates a minimum of 32kb, when called recursively
> > for a directory tree the memory consumption can add up - nearly 300kb
> > during perf start-up when processing modules. Add a stack allocated
> > variant of readdir sized a little more than 1kb.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/api/Makefile |  2 +-
> >  tools/lib/api/io_dir.h | 72 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 73 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/lib/api/io_dir.h
> >
> > diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
> > index 044860ac1ed1..186aa407de8c 100644
> > --- a/tools/lib/api/Makefile
> > +++ b/tools/lib/api/Makefile
> > @@ -99,7 +99,7 @@ install_lib: $(LIBFILE)
> >                 $(call do_install_mkdir,$(libdir_SQ)); \
> >                 cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
> >
> > -HDRS :=3D cpu.h debug.h io.h
> > +HDRS :=3D cpu.h debug.h io.h io_dir.h
> >  FD_HDRS :=3D fd/array.h
> >  FS_HDRS :=3D fs/fs.h fs/tracing_path.h
> >  INSTALL_HDRS_PFX :=3D $(DESTDIR)$(prefix)/include/api
> > diff --git a/tools/lib/api/io_dir.h b/tools/lib/api/io_dir.h
> > new file mode 100644
> > index 000000000000..8a70c0718df5
> > --- /dev/null
> > +++ b/tools/lib/api/io_dir.h
> > @@ -0,0 +1,72 @@
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
> > +
> > +struct io_dirent64 {
> > +       ino64_t        d_ino;    /* 64-bit inode number */
> > +       off64_t        d_off;    /* 64-bit offset to next structure */
> > +       unsigned short d_reclen; /* Size of this dirent */
> > +       unsigned char  d_type;   /* File type */
> > +       char           d_name[NAME_MAX + 1]; /* Filename (null-terminat=
ed) */
> > +};
> > +
> > +struct io_dir {
> > +       int dirfd;
> > +       ssize_t available_bytes;
> > +       struct io_dirent64 *next;
> > +       struct io_dirent64 buff[4];
> > +};
> > +
> > +static inline void io_dir__init(struct io_dir *iod, int dirfd)
> > +{
> > +       iod->dirfd =3D dirfd;
> > +       iod->available_bytes =3D 0;
> > +}
> > +
> > +static inline void io_dir__rewinddir(struct io_dir *iod)
> > +{
> > +       lseek(iod->dirfd, 0, SEEK_SET);
> > +       iod->available_bytes =3D 0;
> > +}
> > +
> > +static inline struct io_dirent64 *io_dir__readdir(struct io_dir *iod)
> > +{
> > +       struct io_dirent64 *entry;
> > +
> > +       if (iod->available_bytes <=3D 0) {
> > +               ssize_t rc =3D getdents64(iod->dirfd, iod->buff, sizeof=
(iod->buff));
> > +
> > +               if (rc <=3D 0)
> > +                       return NULL;
> > +               iod->available_bytes =3D rc;
> > +               iod->next =3D iod->buff;
> > +       }
> > +       entry =3D iod->next;
> > +       iod->next =3D (struct io_dirent64 *)((char *)entry + entry->d_r=
eclen);
>
> Any chance of unaligned access?

It's a funny one. io_dirent64 has a fixed size but then the reclen can
be within that size as 256 bytes may not be used for the name.  As the
name is chars then unalignment is possible, but libc doesn't worry
about unaligned access, so my take is the kernel is padding the reclen
to always be 8 byte aligned.

>
> > +       iod->available_bytes -=3D entry->d_reclen;
> > +       return entry;
> > +}
> > +
> > +static inline bool io_dir__is_dir(const struct io_dir *iod, const stru=
ct io_dirent64 *dent)
> > +{
> > +       if (dent->d_type =3D=3D DT_UNKNOWN) {
> > +               struct stat st;
> > +
> > +               if (fstatat(iod->dirfd, dent->d_name, &st, /*flags=3D*/=
0))
> > +                       return false;
> > +
> > +               return S_ISDIR(st.st_mode);
>
> You may want to save the type if it's a DIR.

Sure. Fwiw, we shouldn't take this code path as the DT_UNKNOWN is only
used by some fairly obscure file systems.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +       }
> > +       return dent->d_type =3D=3D DT_DIR;
> > +}
> > +
> > +#endif
> > --
> > 2.42.0.758.gaed0368e0e-goog
> >
