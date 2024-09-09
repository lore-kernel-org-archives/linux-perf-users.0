Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC69B16D9AA;
	Mon,  9 Sep 2024 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902055; cv=none; b=O1vufhHHV8hGEMOdz6qFyZgwe5ZxIWMB6JAX19vLVa7dgsmVxSeTzqXxScXg6+VWIMFzRl/YoyIesVwbXuLVSIpXXKhf0/MJ/EppsFww5mrH41FZJ92L+qYHpfGYLlhXlXP5PVXVq9w50lkGZaUR3BNGzgFp2P5RaCkhyMwp5Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902055; c=relaxed/simple;
	bh=S426bUPARsq9NTxJ0DBKNwTgDZfR9yF4Kid7pwY/gWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDpCzJ5kHzWwHxWQin7eGGtlIkPPGKAnDS7mvEEF9Ct8Eh81eR0LiLI1zFdy1XEHsN0mivWdp7hDbqosld3LEjcFZnG66ucnkvx37c75vvxSzKcGYH8vGiEeRNQL1Wq7HpIwsJmGSGTAPK6vmIg6UPDloKjS0uKNbEceRU87TRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLEU2dGl; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLEU2dGl"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e1d4368ad91so1685986276.0;
        Mon, 09 Sep 2024 10:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725902053; x=1726506853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JIKKnEcR3APl+8mXJT7DcVCSwdv8kgxqoW4SkrHcUQ=;
        b=TLEU2dGlgl5UP+5gBHpzXrusguExW7U4bf/nCs0eaY7hDpNI7h7j3acus3FCn6f9ci
         /zmnBpjwDQmqyQGDWT/to4PPhn3fx1nroyDU/X94mpTgkHrVYYcX4cLCpKfQBJI+heqD
         y4kjSeeisuP4abKncRWirnJ2LpIou0f23DGfdO6rdjnLxeY4tTodGbkaHahLj2gDFsRk
         MMRXfiZTMmuVTYv3WYaZjhOq+j4nUSud4jTUVNL2ykIIdF5Y2ytDtkNTgQYsfd//I7lD
         X4/C0/yzuUzYeMtSpFPM5nlO5SJf9nmU6sz0dVyjZnsPeaNymVRG8ubAruD396yTZCZo
         rxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725902053; x=1726506853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8JIKKnEcR3APl+8mXJT7DcVCSwdv8kgxqoW4SkrHcUQ=;
        b=YUHCdWwQQvYe3XzXyWuR2ZqaXUBW/D/ym1qAQ0qKbMecpj0phEUplPZBxtJFEXdLvO
         HKbvuqyx0U2HziKi2GoaMubQUxDtOn4LtrTdLlryIAC+pRpBCcGR4Su9dGNpgjFbvHsK
         mwu36+iBLXUVL9qBMv1COAHiLFVWF4kFhCrYmFz9HE3QCbvSAWTd4SqWUhWr4oScXHVv
         mwZmk+Q7CT2arTZDnUgJslw3jEPBYsrhYtdBZ1ZDkQXLb7ZfFBSpxB9HbuR02ZIlr0lN
         UnfMzUl8Hxb13teV/iFrJuAOsoKuSKeAG7jOB1kpgcnF5KbpXwYAfxHhcCq0OqrXdXFO
         m02w==
X-Forwarded-Encrypted: i=1; AJvYcCURVxgEnhCm7EA3ZQUmOIK9nhlnpGEaFCpnyL5AYWoaZPkakaLKGs7VKmRAlQQx3IQatwcK9va/howJWBd0mTWjCg==@vger.kernel.org, AJvYcCXwdBnAXRPynZX3bj0w58827cSg33SIMQkL3xmkLFOvmv6IDAbPm7wcGx0u0bh7cpmsc4pKTNIiYuGHpkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeV06U634mEb0G5F2gY28VAai+6vM4rOsB8IOqEEMJsBUWhwzl
	70GHCIkr9K1RxU/7fJJvBs3NXTVP4DibsV9FZgHU7a82LF5LtNa8w354NxO4mSyN0zgl455z8aw
	UCTgexkXI/2KNzrWj6toB7OlWVyh84POyylI=
X-Google-Smtp-Source: AGHT+IEqt2nPf52OGV27M7hbOr/ogyuPioekY3brdJkm3tsrnwmseXjRnIa0ezGPgBYrDGytHBwT6QcQHeeuBIbkmjs=
X-Received: by 2002:a05:690c:4a12:b0:6d6:c5cd:bde0 with SMTP id
 00721157ae682-6db9541615cmr3471797b3.15.1725902052607; Mon, 09 Sep 2024
 10:14:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824163322.60796-1-howardchu95@gmail.com> <20240824163322.60796-6-howardchu95@gmail.com>
 <Zt8jTfzDYgBPvFCd@x1>
In-Reply-To: <Zt8jTfzDYgBPvFCd@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Mon, 9 Sep 2024 10:14:01 -0700
Message-ID: <CAH0uvohT6+d9uF=rDCgv6vTOWgsfoed=9R0Dt=kkctogJaqsEg@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] perf trace: Pretty print buffer data
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Arnaldo,

On Mon, Sep 9, 2024 at 9:33=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Sun, Aug 25, 2024 at 12:33:19AM +0800, Howard Chu wrote:
> > Define TRACE_AUG_MAX_BUF in trace_augment.h data, which is the maximum
> > buffer size we can augment. BPF will include this header too.
> >
> > Print buffer in a way that's different than just printing a string, we
> > print all the control characters in \digits (such as \0 for null, and
> > \10 for newline, LF).
> >
> > For character that has a bigger value than 127, we print the digits
> > instead of the character itself as well.
> >
> > Committer notes:
> >
> > Simplified the buffer scnprintf to avoid using multiple buffers as
> > discussed in the patch review thread.
> >
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Link: https://lore.kernel.org/r/20240815013626.935097-8-howardchu95@gma=
il.com
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/builtin-trace.c      | 33 +++++++++++++++++++++++++++++++++
> >  tools/perf/util/trace_augment.h |  6 ++++++
> >  2 files changed, 39 insertions(+)
> >  create mode 100644 tools/perf/util/trace_augment.h
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 048bcb92624c..470d74e3f875 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -65,6 +65,7 @@
> >  #include "syscalltbl.h"
> >  #include "rb_resort.h"
> >  #include "../perf.h"
> > +#include "trace_augment.h"
> >
> >  #include <errno.h>
> >  #include <inttypes.h>
> > @@ -852,6 +853,10 @@ static size_t syscall_arg__scnprintf_filename(char=
 *bf, size_t size,
> >
> >  #define SCA_FILENAME syscall_arg__scnprintf_filename
> >
> > +static size_t syscall_arg__scnprintf_buf(char *bf, size_t size, struct=
 syscall_arg *arg);
> > +
> > +#define SCA_BUF syscall_arg__scnprintf_buf
> > +
> >  static size_t syscall_arg__scnprintf_pipe_flags(char *bf, size_t size,
> >                                               struct syscall_arg *arg)
> >  {
> > @@ -1745,6 +1750,32 @@ static size_t syscall_arg__scnprintf_filename(ch=
ar *bf, size_t size,
> >       return 0;
> >  }
> >
> > +#define MAX_CONTROL_CHAR 31
> > +#define MAX_ASCII 127
> > +
> > +static size_t syscall_arg__scnprintf_buf(char *bf, size_t size, struct=
 syscall_arg *arg)
> > +{
> > +     struct augmented_arg *augmented_arg =3D arg->augmented.args;
> > +     unsigned char *orig =3D (unsigned char *)augmented_arg->value;
> > +     size_t printed =3D 0;
> > +     int consumed;
> > +
> > +     if (augmented_arg =3D=3D NULL)
> > +             return 0;
> > +
> > +     for (int j =3D 0; j < augmented_arg->size; ++j) {
> > +             bool control_char =3D orig[j] <=3D MAX_CONTROL_CHAR || or=
ig[j] >=3D MAX_ASCII;
> > +             /* print control characters (0~31 and 127), and non-ascii=
 characters in \(digits) */
> > +             printed +=3D scnprintf(bf + printed, size - printed, cont=
rol_char ? "\\%d" : "%c", (int)orig[j]);
> > +     }
> > +
> > +     consumed =3D sizeof(*augmented_arg) + augmented_arg->size;
> > +     arg->augmented.args =3D ((void *)arg->augmented.args) + consumed;
> > +     arg->augmented.size -=3D consumed;
> > +
> > +     return printed;
> > +}
> > +
> >  static bool trace__filter_duration(struct trace *trace, double t)
> >  {
> >       return t < (trace->duration_filter * NSEC_PER_MSEC);
> > @@ -1956,6 +1987,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fm=
t *arg, struct tep_format_field
> >                   ((len >=3D 4 && strcmp(field->name + len - 4, "name")=
 =3D=3D 0) ||
> >                    strstr(field->name, "path") !=3D NULL))
> >                       arg->scnprintf =3D SCA_FILENAME;
> > +             else if (strstr(field->type, "char *") && strstr(field->n=
ame, "buf"))
> > +                     arg->scnprintf =3D SCA_BUF;
>
> You can't really do this for things like 'read' as we would be printing
> whatever is in the buffer when we enter the syscall, right? As we can

No, we can't do it just now. Same with 'read family' such as
readlinkat, and getrandom.

> see testing after applying the following patch:
>
> root@number:~# perf trace -e read,write cat /etc/passwd > /dev/null
>      0.000 ( 0.004 ms): cat/291442 read(fd: 3, buf: \0\0\0\0\0\0\0\0\0\0\=
0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0, count: 832) =3D 832
>      0.231 ( 0.004 ms): cat/291442 read(fd: 3, buf: , count: 131072)     =
                                =3D 3224
>      0.236 ( 0.001 ms): cat/291442 write(fd: 1, buf: root:x:0:0:Super Use=
r:/root:/bin, count: 3224)      =3D 3224
>      0.239 ( 0.001 ms): cat/291442 read(fd: 3, buf: root:x:0:0:Super User=
:/root:/bin, count: 131072)     =3D 0
> root@number:~#
>
> So we can't really do it at this point, we have to do it, for now, by
> doing it on that syscall table initialization, for instance, for the
> 'write' syscall:
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 5f0877e891c2047d..1bcb45e737d830bf 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1379,6 +1379,8 @@ static const struct syscall_fmt syscall_fmts[] =3D =
{
>           .arg =3D { [2] =3D { .scnprintf =3D SCA_WAITID_OPTIONS, /* opti=
ons */ }, }, },
>         { .name     =3D "waitid",     .errpid =3D true,
>           .arg =3D { [3] =3D { .scnprintf =3D SCA_WAITID_OPTIONS, /* opti=
ons */ }, }, },
> +       { .name     =3D "write",      .errpid =3D true,
> +         .arg =3D { [1] =3D { .scnprintf =3D SCA_BUF, /* buf */ }, }, },
>  };
>
>  static int syscall_fmt__cmp(const void *name, const void *fmtp)
> @@ -1987,8 +1989,6 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt =
*arg, struct tep_format_field
>                     ((len >=3D 4 && strcmp(field->name + len - 4, "name")=
 =3D=3D 0) ||
>                      strstr(field->name, "path") !=3D NULL))
>                         arg->scnprintf =3D SCA_FILENAME;
> -               else if (strstr(field->type, "char *") && strstr(field->n=
ame, "buf"))
> -                       arg->scnprintf =3D SCA_BUF;
>                 else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(=
field->name, "addr"))
>                         arg->scnprintf =3D SCA_PTR;
>                 else if (strcmp(field->type, "pid_t") =3D=3D 0)
>
> With that we get:
>
> root@number:~# perf trace -e read,write cat /etc/passwd > /dev/null
>      0.000 ( 0.005 ms): cat/296870 read(fd: 3, buf: 0x7ffe9cb8df98, count=
: 832)                          =3D 832
>      0.268 ( 0.004 ms): cat/296870 read(fd: 3, buf: 0x7fa7d700a000, count=
: 131072)                       =3D 3224
>      0.273 ( 0.002 ms): cat/296870 write(fd: 1, buf: root:x:0:0:Super Use=
r:/root:/bin, count: 3224)      =3D
>      0.276 ( 0.001 ms): cat/296870 read(fd: 3, buf: 0x7fa7d700a000, count=
: 131072)                       =3D 0
> root@number:~#
>
> After the following patch is applied.

Thank you so much!
>
> - Arnaldo

Thanks,
Howard
