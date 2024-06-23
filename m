Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764F812F59B;
	Sun, 23 Jun 2024 11:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719142473; cv=none; b=CpOOONqE6UalCP7dsFZJfljEnSKI7qWsCRcGyOe0Xi/lHtALx3YQp6U9CIsiE+EDMG4tj7edCqRrxo5cckeJfJv/gJIKD6q21nRjFHOUTO79zGNkJsTB6rW4cGzhTbZ7Xkk3nqVl0YnpNdeYEtYf+QFb6xp+hKfkBc9i4uHVcBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719142473; c=relaxed/simple;
	bh=C9Uwqe0T7pTQ1lwd77tS/Pe1vZuu34NIHkanfObGOhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AddOer0aUroi0KL7kvYG4wdzpJEHvFiWkCr0L5tJcXceOGYqEOZyXNwGVf6Gh330LTS15neXp4s09t7xkmkkcKPMtjEeCxqQcZeS1WIoOA77uopP7oqoYCtuaElv9pguBUDgagGE7//HbioO85A2BV3V7pI1g9JZPadCOjYJ03E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOprbGHH; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOprbGHH"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-632750bf73bso29781227b3.2;
        Sun, 23 Jun 2024 04:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719142470; x=1719747270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBEy3D8UH5fmGDCN0I9x8rXaodXECtvJMBA8R4Jv5oc=;
        b=eOprbGHHG8syBEBgCaG4lSYHjahhqWE9uP5Cv7kHBG1JTlmmhbwFCpp3CtWLeGNCs8
         i5lTwJs1M1XkAHzBn5hVRckpFWlR5dqzSMEx9Kc4YVvsZe0qcdRNM12wM072FPRFNQKf
         GEVuL5QJ6wjWqadUhHqBDF6J5gXGJlQqitB+6EfFFDM4DAurmilHvkRKTvG21iV3EWhR
         vu95XBcAXrBfazQOuit+WIcCQlqIaD3wphYs1TyNRliZtdrWaHNtmRVmXFDAbDg8I4Bb
         a8HWuRHvQhlx5s8KEFR6GHipfVF0MH4j/9IWAm+N1kZMapo66KnI34NBx98MZyPLXn/t
         II/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719142470; x=1719747270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBEy3D8UH5fmGDCN0I9x8rXaodXECtvJMBA8R4Jv5oc=;
        b=N5tKyfPPI/WZpFyzD6CJBR3/29wrjhWcmfXTlY3PuoBgvKoPDe7b5Z2uZ2n0mS0O8P
         vttmU0/dYKWgwRScMVA3yO4vEw9qaItMhTCuuVQXuirFabo6vjf9cY40w+ygyG9lnIqi
         DH9lFBs5MWyWKDSgh1VkXU2kfaYGNWIUL8zXrHPSE6yALD9EZ8DPR3z+1eEcnC7679PH
         jfR1wNT6pNoCqNNbAFHfj1fAtyV//2j6AHGbm7GtzmvVd73eS6QrjFA+66wrfQ9rtCtH
         wZNHIWlTqic061byTbJZVdaBJeJEgMvxNk1vgGckn3Ke/NEd3c+H1FIlrsbVofZGjVhE
         7Pwg==
X-Forwarded-Encrypted: i=1; AJvYcCW2PLIgQHuSVCjq9+jvIeEMiQRsq40LJVK49pPEneTm7EnnV4ZIdPXv/PQIZpKkzCUqbr/Pozm4Wr1K7/gArgHnJCQn2jvW708xQiqaU+/ty9eaoQVeftBZnnesPoYmxURhAcyLKoEaILmg72iMnw==
X-Gm-Message-State: AOJu0YxO6dh5Jy95SEc60XGxYHFL4yQdwkpfIJ2I1NGJxS5/jUuFHJHt
	H4mcAwRt8TSqCNSzIZ30SEVeb30VrFUGhs+Dfw1L1DtjUEezLmNAbqtUZjk1o0vDb6ijXGMFzYf
	FczhKjcIqxlC49fcvk5oJV087ky4=
X-Google-Smtp-Source: AGHT+IHfCr0OOjCA+ub1z5EK9NThsOCKK6ZX5+pNMOQx9Her+CGNFSLtw7SsY0bRMDUo9hZ7Vk84CPvZUtkWLwZlSWs=
X-Received: by 2002:a05:690c:6e0c:b0:627:a917:bae7 with SMTP id
 00721157ae682-643aad718ddmr25741177b3.30.1719142470302; Sun, 23 Jun 2024
 04:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619082042.4173621-1-howardchu95@gmail.com>
 <20240619082042.4173621-3-howardchu95@gmail.com> <ZnLgstTgrFRYu0aD@x1>
 <CAH0uvohKGrfwApZXfJZaWx4LQgPXct+uQ_N7snmqSo4VeCxVUA@mail.gmail.com>
 <CAH0uvohxZ16MFCG2g3my48yUtp9AHAiAZCPAmkT5bDtNM6sGhg@mail.gmail.com>
 <CAH0uvohe2WssHZGYNyMCq=xpasXOYxaznRsGPe49iYQBME8_QQ@mail.gmail.com>
 <ZnWCxgeFClpo2k3M@x1> <CAH0uvohMLkgRBF48evgU=-CMFsHsGZxKs3nA6bWSS_Vv-tqM=g@mail.gmail.com>
 <ZncX2JxXL0HJY7Rn@x1>
In-Reply-To: <ZncX2JxXL0HJY7Rn@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Sun, 23 Jun 2024 19:34:19 +0800
Message-ID: <CAH0uvohJX-DJwnmBVQ-81KtObPtVo5RCUHN_5odDxxhGKTw3Jg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] perf trace: Augment enum syscall arguments with BTF
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Arnaldo,

Your changes are very very good, thank you so much.

On Sun, Jun 23, 2024 at 2:28=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Sat, Jun 22, 2024 at 12:18:10AM +0800, Howard Chu wrote:
> > Hello Arnaldo,
> >
> > I think I need to add some explanations here, for the all-in-one patch
> > that I have on the tree.
> >
> > Firstly, no use_btf is passed when constructing syscall argument
> > format. We just write is_enum when the type is enum. This is because
> > we don't load btf when we are constructing the formats, we load
> > vmlinux when a tracepoint hits.
> >
> > before:
> >
> > } else if (strstr(field->type, "enum") && use_btf !=3D NULL) {
> > *use_btf =3D arg->is_enum =3D true;
> >
> > after:
> >
> > } else if (strstr(field->type, "enum")) {
> > arg->is_enum =3D true;
> >
> > Another confusing place is when we do the filtering. When a user
> > passes an enum name, say --filter=3D"mode=3D=3DHRTIMER_MODE_ABS", we do=
 not
> > know what 'HRTIMER_MODE_ABS' means. For this case, we have to load the
> > vmlinux BTF, and match the strings to get a value, not delaying till a
> > tracepoint hits.
>
> Right, I worked on your latest series before the combined patch, and to
> solve that at filter expansion time, I did:
>
> @@ -3861,9 +3903,16 @@ static int trace__expand_filter(struct trace *trac=
e __maybe_unused, struct evsel
>                         if (fmt->strtoul) {
>                                 u64 val;
>                                 struct syscall_arg syscall_arg =3D {
> -                                       .parm =3D fmt->parm,
> +                                       .trace =3D trace,
> +                                       .fmt   =3D fmt,
>                                 };
>
> +                               if (fmt->is_enum) {
> +                                       syscall_arg.parm =3D type;
> +                               } else {
> +                                       syscall_arg.parm =3D fmt->parm;
> +                               }
> +
>                                 if (fmt->strtoul(right, right_size, &sysc=
all_arg, &val)) {
>
>
> And then in the enum btf strtoul we can load the btf:
>
> +static bool syscall_arg__strtoul_btf_enum(char *bf, size_t size, struct =
syscall_arg *arg, u64 *val)
> +{
> +       const struct btf_type *bt;
> +       char *type =3D arg->parm;
> +       struct btf_enum *be;
> +       struct btf *btf;
> +
> +       trace__load_vmlinux_btf(arg->trace);
> +
> +       btf =3D arg->trace->btf;
> +       if (btf =3D=3D NULL)
> +               return false;
> +
> +       if (syscall_arg_fmt__cache_btf_enum(arg->fmt, btf, type) < 0)
> +               return false;
> +
> +       bt =3D arg->fmt->type;
> +       be =3D btf_enum(bt);
> +       for (int i =3D 0; i < btf_vlen(bt); ++i, ++be) {
> +               const char *name =3D btf__name_by_offset(btf, be->name_of=
f);
> +               int max_len =3D max(size, strlen(name));
> +
> +               if (strncmp(name, bf, max_len) =3D=3D 0) {
> +                       *val =3D be->val;
> +                       return true;
> +               }
> +       }
> +
> +       return false;
> +}
>
> And:
>
> +static int syscall_arg_fmt__cache_btf_enum(struct syscall_arg_fmt *arg_f=
mt, struct btf *btf, char *type)
> +{
> +       int id;
> +
> +       // Already cached?
> +       if (arg_fmt->type !=3D NULL)
> +               return 0;
> +
> +       type =3D strstr(type, "enum ");
> +       if (type =3D=3D NULL)
> +               return -1;
> +
> +       type +=3D 5; // skip "enum " to get the enumeration name
> +

The shifting of enum name before doing btf__type_by_id() is handled
perfectly. And the extra wrapper function trace__btf_scnprintf() makes
a lot of sense.

Just two tiny little things:

1) the `make NO_LIBBPF=3D1` and `make NO_LIBELF=3D1` won't build

builtin-trace.c: In function =E2=80=98syscall__scnprintf_args=E2=80=99:
builtin-trace.c:2258:28: error: expected expression before =E2=80=98)=E2=80=
=99 token
 2258 |                            )
      |                            ^

if (val =3D=3D 0 && !trace->show_zeros &&
    !(sc->arg_fmt && sc->arg_fmt[arg.idx].show_zero) &&
#ifdef HAVE_LIBBPF_SUPPORT
    !(sc->arg_fmt && sc->arg_fmt[arg.idx].strtoul =3D=3D STUL_BTF_TYPE)
#endif
   )
        continue;

The fix is simple, just change the above to:

if (val =3D=3D 0 && !trace->show_zeros &&
    !(sc->arg_fmt && sc->arg_fmt[arg.idx].show_zero)
#ifdef HAVE_LIBBPF_SUPPORT
    && !(sc->arg_fmt && sc->arg_fmt[arg.idx].strtoul =3D=3D STUL_BTF_TYPE)
#endif
   )
        continue;

2) In this version, we won't defer the loading of vmlinux BTF till an
enum-augmentable tracepoint hits. I'm sure you made this conscious
change, not that there's anything wrong with it, just want to point it
out for clarity.

Overall, it is a great revision. Man, what can I say, this patch is
better, simpler and it handles details very well. Thank you so much
for doing this.

Thanks,
Howard
