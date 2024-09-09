Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B78282E2;
	Mon,  9 Sep 2024 17:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902267; cv=none; b=YkPW3bj5D60SjA4JRvHfvbChTsFtEJCZt79brzq/BJ+CFc6Smld0DVkGLS/skSJEdTJb1Z/lDB9kHFirkaqVg/SD8AAHaGyVTqXAWFIZIJahyC5IhRXrivj3RjpPjKIKP7s4YJ8vnik7UrdPbYy0I5jSJJ3dM0ijQ/1rFB5ZY3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902267; c=relaxed/simple;
	bh=tJnZ0MyCyvB6YXbCZujAhcaDHD/eOAYo73ue6WDv1Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VW/FZRYZv+lWOJ/HJ8BKgMNzRSN6yr9mtABh71NUpjZ3j8aRc+0gZzdc+tPQ/qeBN895lvtZBGEt4ecEXE10ncyR5jSwDruj6/TXhFIPv60q0z8tu4jLeXXhYE/7U9BW0tbRM2H0wSc5C5NouOJQ6Xrq0uXIRzaQgg+Mm1Slec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ModtjG1U; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ModtjG1U"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-68518bc1407so50619887b3.2;
        Mon, 09 Sep 2024 10:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725902265; x=1726507065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLjwZvtm9fDNmFus3AqmB0mN+HgGQoej9Lv75TKzLzs=;
        b=ModtjG1U7aFX0rX26SBNXvteQkw3x+mfYqUIAej27r7y59Nn6ZCtvzz1fGTg9Xw2b/
         iNb/YoQ6+h4Rezsmc9c3u9SRbD8VJ4cso8Ky5HjBdNja7tbiQOPCttsq+UdlG62WOqqw
         A7uJUvmwjpCFt9pxFjX/wEzh21R7OVQAY7KoWSFlrNG3VZVkIHDwiWEtfe8udfE4mEIV
         7X/12eucRAzAVPLWL867BlbWrLXA1MN8k+cbQ+e99NOOx+rpK89MBmo7+oACIU5dDiDn
         ktG3NQK4/vM50nbB2ID9nvgil5IWTwlrWl9R9uPNpByRnm8/fwFgVhu4WVEK+g0MLtPz
         2tKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725902265; x=1726507065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLjwZvtm9fDNmFus3AqmB0mN+HgGQoej9Lv75TKzLzs=;
        b=t4pUgYwWEV53WZDSFurJfEJY+8Q59Cqnpa6g1ivA+R7ClAQhO5OWjdVQwb/4/zvxrY
         reeWjMVs2P6O6ROdCG/R/0Rm6G+w16W75NTGQ0jHifE99UvdW3CpIx3biDlVn4L1XXMy
         15XRe54FG4wnc4v87HMwND4IGfFj1Vz7cJ0ZXJ1bI04u4gmZ+VZIE5SnPnY7UQlLs2L/
         q9KR0pkaVXHpvzQpuAwDQL9vctzlQyiA6QoVNnLwsAJMMDJkRcAacFnpe5Hu5YMt6qcc
         glmBEJUGScmHB9WxC1f0+sh4KcOjHGFluJiofh1UPuQcv55J+khQDhWPgVGF27o7azER
         UOxA==
X-Forwarded-Encrypted: i=1; AJvYcCU/D/GrWLZiwpArCpUtAPsT5pjB80DtdQkb9QoVF6bKyIRjB88zD9as9/FP0i6+axQdatXYxAyJ+Sn0jB+jaDxS6A==@vger.kernel.org, AJvYcCWzzJs89WoQk7VttfkGfHpUJOmK71+M43NlNy0oG9XHaUy/tajfP0XFf8ZbbSovgqyxIudbswa5MsUpStE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsw5n+yIQgCHZ0iPxDZNGeH8o3V1Onbqlbv6kbou2vQzYDh8zr
	uukmNGDJK9aQCj/PWx7T7Q9u019u+qim31UvnN/f+msOrwPwu8HJkdy13DXDRagiGFLDiyJ+rIZ
	MoIVdnzwVWSb5wD8AFzhEkKDSGgY=
X-Google-Smtp-Source: AGHT+IETKPuUGYlF0a95Dcrs0q8kYMg/nXPOO4xkyP4nywoxfffqTqNsXSFFkep26h1GjAoRE7CostnwyVE8fipdl0E=
X-Received: by 2002:a05:690c:2b83:b0:66a:ba89:d671 with SMTP id
 00721157ae682-6db45154999mr102218757b3.35.1725902264799; Mon, 09 Sep 2024
 10:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824163322.60796-1-howardchu95@gmail.com> <20240824163322.60796-6-howardchu95@gmail.com>
 <Zt8jTfzDYgBPvFCd@x1> <Zt8mMB7rkgSY1VSD@x1>
In-Reply-To: <Zt8mMB7rkgSY1VSD@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Mon, 9 Sep 2024 10:17:34 -0700
Message-ID: <CAH0uvojsnmgj-55ftARr9=6vPv55tvEtQtNp1yvUr7q46irY7Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] perf trace: Pretty print buffer data
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 9:45=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Mon, Sep 09, 2024 at 01:33:17PM -0300, Arnaldo Carvalho de Melo wrote:
> > >  static bool trace__filter_duration(struct trace *trace, double t)
> > >  {
> > >     return t < (trace->duration_filter * NSEC_PER_MSEC);
> > > @@ -1956,6 +1987,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_=
fmt *arg, struct tep_format_field
> > >                 ((len >=3D 4 && strcmp(field->name + len - 4, "name")=
 =3D=3D 0) ||
> > >                  strstr(field->name, "path") !=3D NULL))
> > >                     arg->scnprintf =3D SCA_FILENAME;
> > > +           else if (strstr(field->type, "char *") && strstr(field->n=
ame, "buf"))
> > > +                   arg->scnprintf =3D SCA_BUF;
> >
> > You can't really do this for things like 'read' as we would be printing
> > whatever is in the buffer when we enter the syscall, right? As we can
> > see testing after applying the following patch:
>
> This is also valid for the struct dumper, where I'll have to add some
> indication in the syscall_fmt table when the pointer should be read in
> the BPF augmenter, and thus we shouldn't bother to get it in the
> sys_enter if it is, say, fstat().

Yes you are right, problems with read buffers happen in structs too.
I'll get my read family patch out soon to ease your pain...

Thanks,
Howard
>
> - Arnaldo
>
> > root@number:~# perf trace -e read,write cat /etc/passwd > /dev/null
> >      0.000 ( 0.004 ms): cat/291442 read(fd: 3, buf: \0\0\0\0\0\0\0\0\0\=
0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0, count: 832) =3D 832
> >      0.231 ( 0.004 ms): cat/291442 read(fd: 3, buf: , count: 131072)   =
                                  =3D 3224
> >      0.236 ( 0.001 ms): cat/291442 write(fd: 1, buf: root:x:0:0:Super U=
ser:/root:/bin, count: 3224)      =3D 3224
> >      0.239 ( 0.001 ms): cat/291442 read(fd: 3, buf: root:x:0:0:Super Us=
er:/root:/bin, count: 131072)     =3D 0
> > root@number:~#
> >
> > So we can't really do it at this point, we have to do it, for now, by
> > doing it on that syscall table initialization, for instance, for the
> > 'write' syscall:
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 5f0877e891c2047d..1bcb45e737d830bf 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -1379,6 +1379,8 @@ static const struct syscall_fmt syscall_fmts[] =
=3D {
> >         .arg =3D { [2] =3D { .scnprintf =3D SCA_WAITID_OPTIONS, /* opti=
ons */ }, }, },
> >       { .name     =3D "waitid",     .errpid =3D true,
> >         .arg =3D { [3] =3D { .scnprintf =3D SCA_WAITID_OPTIONS, /* opti=
ons */ }, }, },
> > +     { .name     =3D "write",      .errpid =3D true,
> > +       .arg =3D { [1] =3D { .scnprintf =3D SCA_BUF, /* buf */ }, }, },
> >  };
> >
> >  static int syscall_fmt__cmp(const void *name, const void *fmtp)
> > @@ -1987,8 +1989,6 @@ syscall_arg_fmt__init_array(struct syscall_arg_fm=
t *arg, struct tep_format_field
> >                   ((len >=3D 4 && strcmp(field->name + len - 4, "name")=
 =3D=3D 0) ||
> >                    strstr(field->name, "path") !=3D NULL))
> >                       arg->scnprintf =3D SCA_FILENAME;
> > -             else if (strstr(field->type, "char *") && strstr(field->n=
ame, "buf"))
> > -                     arg->scnprintf =3D SCA_BUF;
> >               else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(=
field->name, "addr"))
> >                       arg->scnprintf =3D SCA_PTR;
> >               else if (strcmp(field->type, "pid_t") =3D=3D 0)
> >
> > With that we get:
> >
> > root@number:~# perf trace -e read,write cat /etc/passwd > /dev/null
> >      0.000 ( 0.005 ms): cat/296870 read(fd: 3, buf: 0x7ffe9cb8df98, cou=
nt: 832)                          =3D 832
> >      0.268 ( 0.004 ms): cat/296870 read(fd: 3, buf: 0x7fa7d700a000, cou=
nt: 131072)                       =3D 3224
> >      0.273 ( 0.002 ms): cat/296870 write(fd: 1, buf: root:x:0:0:Super U=
ser:/root:/bin, count: 3224)      =3D
> >      0.276 ( 0.001 ms): cat/296870 read(fd: 3, buf: 0x7fa7d700a000, cou=
nt: 131072)                       =3D 0
> > root@number:~#
> >
> > After the following patch is applied.
> >
> > - Arnaldo
