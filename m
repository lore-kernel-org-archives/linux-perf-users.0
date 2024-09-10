Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1291217E00B;
	Tue, 10 Sep 2024 04:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725944355; cv=none; b=hlcJDTqgydI1qwsnc3IJxwIzgpzBgCVVcU0TQ4CXPpAHU6DcsVodQ7X90adgCHmkMZwVCNdD74e6J7caXSPb/vEJC+9B21feCtlbHZQWBQzfPrqFVI2higIHQQ7HYIvo2XLxTbArmLXHgrRA3a3p4Av2jXqsOIsvOPh3AoaFeXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725944355; c=relaxed/simple;
	bh=p9bVRyu5JdIICuXjwOQjoiePUgL/v/hx6vSkMuFy9tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xgu2QmbdtjduLDHRDKzqV+xcdQXNlLpxjuex/HOxlSM65RJuYId4QERpUXi5fQiSYwlrmG+XDgtjdrNXG+Ui8GDzKsDZ7yIGu8bTGmBdAmgNtckyd6R2F8gkJqSWqrOaQA8RUVxnuSuzg6w/J5dzGdVzrLzGwVuxIIEp9qfMLRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLi0t+LJ; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLi0t+LJ"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso4679890276.1;
        Mon, 09 Sep 2024 21:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725944353; x=1726549153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzP+62C3y/IYXvSNedyLGTDiD1IJok1EKNHx/SjUBQY=;
        b=aLi0t+LJuLLPtVfOpRYH+sN5Toy1QaL3IAoqU4zKLDJPVT677sJ6s5y3jXzmU6fTjN
         w+dgEFE1LJ1bIY3zkK/CkEcBOFEi90x7UDrBKkwaFO822j5M1ScyqKANjdeszXzsw8V/
         FTdOCYvZmI6MFGWRLRkO1j4V6sT4nSVy5OK0jB/IP2J7MxCqmwNzlAkWfaPWM8NX598w
         Nb7krLxcHlUCWlNotF+R2b0wm/0XUIlbevCp5ZyZeE5gsvEVFSzxT4A67tHdfuN3B6ki
         PnCmNBBmfGDJ40SWAV8g1kiJpUl34RJ3ZEW+5Y59JwBHyqcLluQQMYObRUkxVuG9/GCK
         sWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725944353; x=1726549153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzP+62C3y/IYXvSNedyLGTDiD1IJok1EKNHx/SjUBQY=;
        b=BmjKl5SyW2GnAQ5A07NPPGejADt8ZGjn9i7m0mCag6xsPL4dtetcSZ+mKL+cbu1NGi
         /1Cj/95hv7o9YgtDgIUjbe6YNGAoMZCBCiy1G+cJ3Ba0R6tf2RkfQrQeflw5UvQlyNAU
         3eVYj7WDi78fIJIaW035zTrpSYpFIURzxkEUkrV3Rxx/jKKtDhw9+zwrDdAVxFNfcs7g
         MgEMjUl3CM9LyrS/p2WXzhFqGEjphTTDuFuBTd7yuaGAzvLCs4/SVbrevRXpTVqAdW8J
         UHCVGLteliNSKz+4pTQ75MdQkYT1kXuDDaN9J7kO37aJf1Et2og0k2c4OcbcSYajkPNy
         sdCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUz+oInmBuFHG+QfQ9vv0llNQEM2M4/aHZRy26IEl1pRCDq5bIQuJy9izMIuTX5lnHVyuuBJbUgA1VR4Xk=@vger.kernel.org, AJvYcCWdg6G55ItBnJUQ0aaOtZB3bUqSLN9ilf3FKF4a76XJ8W3q+v1Ff1Y85jUXjE+3Al9G7YjPNhQPBof8+QQnAwZeeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRJ9gJckwAmGXHs7b+Dns0oRD33TOKhIXX/SUQj+ImgMKdDHs1
	s4mdNRcJjfnPwCzPfiN+vFHQtoFv2Uu0IR0HupPtqXW88uuWOd/0mBf8A4Y7v8erWBypyRojRbx
	NJBGOKr5/pJX31ARPVURw5N3WmLw=
X-Google-Smtp-Source: AGHT+IG3EX06yUdosk6U5mQYK6TC+81Ew1FOvhhJrFCHj9KN3zZBeDWITogN013m32sqVm5axlo/+Xr7ZfD9oVZKxtw=
X-Received: by 2002:a05:690c:ed2:b0:689:d89a:ece5 with SMTP id
 00721157ae682-6db44df53f8mr155877437b3.4.1725944352771; Mon, 09 Sep 2024
 21:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824163322.60796-1-howardchu95@gmail.com> <20240824163322.60796-3-howardchu95@gmail.com>
 <Zt9Qa_znFmHADff1@x1> <Zt9XCtTHeJ-1MCCl@x1>
In-Reply-To: <Zt9XCtTHeJ-1MCCl@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Mon, 9 Sep 2024 21:59:02 -0700
Message-ID: <CAH0uvojqOdfwZXtwvsaRgWF_-4TmFL6Mqyo=zX-2Czrm0_bhYg@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] perf trace: Add trace__bpf_sys_enter_beauty_map()
 to prepare for fetching data in BPF
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Arnaldo,

On Mon, Sep 9, 2024 at 1:14=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Mon, Sep 09, 2024 at 04:45:47PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Sun, Aug 25, 2024 at 12:33:16AM +0800, Howard Chu wrote:
> > > Set up beauty_map, load it to BPF, in such format: if argument No.3 i=
s a
> > > struct of size 32 bytes (of syscall number 114) beauty_map[114][2] =
=3D 32;
> > >
> > > if argument No.3 is a string (of syscall number 114) beauty_map[114][=
2] =3D
> > > 1;
> > >
> > > if argument No.3 is a buffer, its size is indicated by argument No.4 =
(of
> > > syscall number 114) beauty_map[114][2] =3D -4; /* -1 ~ -6, we'll read=
 this
> > > buffer size in BPF  */
> > >
> > > Committer notes:
> > >
> > > Moved syscall_arg_fmt__cache_btf_struct() from a ifdef
> > > HAVE_LIBBPF_SUPPORT to closer to where it is used, that is ifdef'ed o=
n
> > > HAVE_BPF_SKEL and thus breaks the build when building with
> > > BUILD_BPF_SKEL=3D0, as detected using 'make -C tools/perf build-test'=
.
> >
> > Here we have to have this:
>
> My pahole hat was not working, we have this:
>
> SYSCALL_DEFINE3(write, unsigned int, fd, const char __user *, buf,
>                 size_t, count)
> {
>         return ksys_write(fd, buf, count);
> }
>
> ssize_t ksys_pread64(unsigned int fd, char __user *buf, size_t count,
>                      loff_t pos)
>
>
> See that __user?

Yeah __user is a good tag. Can you please tell me what you mean here?
If I'm understanding correctly, you mean __user is a tag that
indicates the flow of buffer data is from user to kernel. But wouldn't
'const char' and 'char' work? (for read it's char, and write it's
const char) Okay, maybe you are referring to prctl syscall then we
really don't know where the data flows...

>
> That should be available in BTF as a tag and then we can use it... For
> now I'll continue adding a flag to the syscall_arg_fmt, as I have that
> much time before flying to Europe, but that is an avenue we _have_ to
> investigate and use that info.
>
> It will not cover all cases, and I think we'll even have to improve BTF
> in that regard with some sort of __user_maybe thing for args that get
> thing from userspace according to some other argument (you was overly
> clever on the heuristic to find the size of buffers, more on that at
> some point, but I'm running out of time).
>
> - Arnaldo
>
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index ba7b1338123dc5f1..588305b26a064edf 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -3572,6 +3572,10 @@ static int trace__bpf_sys_enter_beauty_map(struc=
t trace *trace, int key, unsigne
> >         for (i =3D 0, field =3D sc->args; field; ++i, field =3D field->=
next) {
> >                 struct_offset =3D strstr(field->type, "struct ");
> >
> > +               // XXX We're only collecting pointer payloads _from_ us=
er space
> > +               if (!sc->arg_fmt[i].from_user)
> > +                       continue;
> > +
> >                 if (field->flags & TEP_FIELD_IS_POINTER && struct_offse=
t) { /* struct */
> >                         struct_offset +=3D 7;
> >
> > I added some patches before this one that add that .from_user field and
> > marks the syscall args that flow from user to kernel space, we'll
> > probably need to tune that a bit, but then its "better" not to collect
> > old contents of buffers in syscalls that flows from kernel to userspace
> > than to lose the opportunity to collect data flowing from user to kerne=
l
> > space.
> >
> > I.e. its better to not show something useful than to show something
> > misleading/utterly bogus.

I agree. Less is better than useless.

Thanks,
Howard
> >
> > - Arnaldo
> >
> > > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: Ian Rogers <irogers@google.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: Kan Liang <kan.liang@linux.intel.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Link: https://lore.kernel.org/r/20240815013626.935097-4-howardchu95@g=
mail.com
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > ---
> > >  tools/perf/builtin-trace.c | 106 +++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 106 insertions(+)
> > >
> > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > > index d6ca541fdc78..c26eab196623 100644
> > > --- a/tools/perf/builtin-trace.c
> > > +++ b/tools/perf/builtin-trace.c
> > > @@ -113,6 +113,7 @@ struct syscall_arg_fmt {
> > >     bool       show_zero;
> > >  #ifdef HAVE_LIBBPF_SUPPORT
> > >     const struct btf_type *type;
> > > +   int        type_id; /* used in btf_dump */
> > >  #endif
> > >  };
> > >
> > > @@ -3446,6 +3447,23 @@ static int trace__set_ev_qualifier_tp_filter(s=
truct trace *trace)
> > >  }
> > >
> > >  #ifdef HAVE_BPF_SKEL
> > > +static int syscall_arg_fmt__cache_btf_struct(struct syscall_arg_fmt =
*arg_fmt, struct btf *btf, char *type)
> > > +{
> > > +       int id;
> > > +
> > > +   if (arg_fmt->type !=3D NULL)
> > > +           return -1;
> > > +
> > > +       id =3D btf__find_by_name(btf, type);
> > > +       if (id < 0)
> > > +           return -1;
> > > +
> > > +       arg_fmt->type    =3D btf__type_by_id(btf, id);
> > > +       arg_fmt->type_id =3D id;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  static struct bpf_program *trace__find_bpf_program_by_title(struct t=
race *trace, const char *name)
> > >  {
> > >     struct bpf_program *pos, *prog =3D NULL;
> > > @@ -3521,6 +3539,83 @@ static int trace__bpf_prog_sys_exit_fd(struct =
trace *trace, int id)
> > >     return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program_=
_fd(trace->skel->progs.syscall_unaugmented);
> > >  }
> > >
> > > +static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int =
key, unsigned int *beauty_array)
> > > +{
> > > +   struct tep_format_field *field;
> > > +   struct syscall *sc =3D trace__syscall_info(trace, NULL, key);
> > > +   const struct btf_type *bt;
> > > +   char *struct_offset, *tmp, name[32];
> > > +   bool can_augment =3D false;
> > > +   int i, cnt;
> > > +
> > > +   if (sc =3D=3D NULL)
> > > +           return -1;
> > > +
> > > +   trace__load_vmlinux_btf(trace);
> > > +   if (trace->btf =3D=3D NULL)
> > > +           return -1;
> > > +
> > > +   for (i =3D 0, field =3D sc->args; field; ++i, field =3D field->ne=
xt) {
> > > +           struct_offset =3D strstr(field->type, "struct ");
> > > +
> > > +           if (field->flags & TEP_FIELD_IS_POINTER && struct_offset)=
 { /* struct */
> > > +                   struct_offset +=3D 7;
> > > +
> > > +                   /* for 'struct foo *', we only want 'foo' */
> > > +                   for (tmp =3D struct_offset, cnt =3D 0; *tmp !=3D =
' ' && *tmp !=3D '\0'; ++tmp, ++cnt) {
> > > +                   }
> > > +
> > > +                   strncpy(name, struct_offset, cnt);
> > > +                   name[cnt] =3D '\0';
> > > +
> > > +                   /* cache struct's btf_type and type_id */
> > > +                   if (syscall_arg_fmt__cache_btf_struct(&sc->arg_fm=
t[i], trace->btf, name))
> > > +                           continue;
> > > +
> > > +                   bt =3D sc->arg_fmt[i].type;
> > > +                   beauty_array[i] =3D bt->size;
> > > +                   can_augment =3D true;
> > > +           } else if (field->flags & TEP_FIELD_IS_POINTER && /* stri=
ng */
> > > +               strcmp(field->type, "const char *") =3D=3D 0 &&
> > > +               (strstr(field->name, "name") ||
> > > +                strstr(field->name, "path") ||
> > > +                strstr(field->name, "file") ||
> > > +                strstr(field->name, "root") ||
> > > +                strstr(field->name, "key") ||
> > > +                strstr(field->name, "special") ||
> > > +                strstr(field->name, "type") ||
> > > +                strstr(field->name, "description"))) {
> > > +                   beauty_array[i] =3D 1;
> > > +                   can_augment =3D true;
> > > +           } else if (field->flags & TEP_FIELD_IS_POINTER && /* buff=
er */
> > > +                      strstr(field->type, "char *") &&
> > > +                      (strstr(field->name, "buf") ||
> > > +                       strstr(field->name, "val") ||
> > > +                       strstr(field->name, "msg"))) {
> > > +                   int j;
> > > +                   struct tep_format_field *field_tmp;
> > > +
> > > +                   /* find the size of the buffer that appears in pa=
irs with buf */
> > > +                   for (j =3D 0, field_tmp =3D sc->args; field_tmp; =
++j, field_tmp =3D field_tmp->next) {
> > > +                           if (!(field_tmp->flags & TEP_FIELD_IS_POI=
NTER) && /* only integers */
> > > +                               (strstr(field_tmp->name, "count") ||
> > > +                                strstr(field_tmp->name, "siz") ||  /=
* size, bufsiz */
> > > +                                (strstr(field_tmp->name, "len") && s=
trcmp(field_tmp->name, "filename")))) {
> > > +                                    /* filename's got 'len' in it, w=
e don't want that */
> > > +                                   beauty_array[i] =3D -(j + 1);
> > > +                                   can_augment =3D true;
> > > +                                   break;
> > > +                           }
> > > +                   }
> > > +           }
> > > +   }
> > > +
> > > +   if (can_augment)
> > > +           return 0;
> > > +
> > > +   return -1;
> > > +}
> > > +
> > >  static struct bpf_program *trace__find_usable_bpf_prog_entry(struct =
trace *trace, struct syscall *sc)
> > >  {
> > >     struct tep_format_field *field, *candidate_field;
> > > @@ -3625,7 +3720,9 @@ static int trace__init_syscalls_bpf_prog_array_=
maps(struct trace *trace)
> > >  {
> > >     int map_enter_fd =3D bpf_map__fd(trace->skel->maps.syscalls_sys_e=
nter);
> > >     int map_exit_fd  =3D bpf_map__fd(trace->skel->maps.syscalls_sys_e=
xit);
> > > +   int beauty_map_fd =3D bpf_map__fd(trace->skel->maps.beauty_map_en=
ter);
> > >     int err =3D 0;
> > > +   unsigned int beauty_array[6];
> > >
> > >     for (int i =3D 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
> > >             int prog_fd, key =3D syscalltbl__id_at_idx(trace->sctbl, =
i);
> > > @@ -3644,6 +3741,15 @@ static int trace__init_syscalls_bpf_prog_array=
_maps(struct trace *trace)
> > >             err =3D bpf_map_update_elem(map_exit_fd, &key, &prog_fd, =
BPF_ANY);
> > >             if (err)
> > >                     break;
> > > +
> > > +           /* use beauty_map to tell BPF how many bytes to collect, =
set beauty_map's value here */
> > > +           memset(beauty_array, 0, sizeof(beauty_array));
> > > +           err =3D trace__bpf_sys_enter_beauty_map(trace, key, (unsi=
gned int *)beauty_array);
> > > +           if (err)
> > > +                   continue;
> > > +           err =3D bpf_map_update_elem(beauty_map_fd, &key, beauty_a=
rray, BPF_ANY);
> > > +           if (err)
> > > +                   break;
> > >     }
> > >
> > >     /*
> > > --
> > > 2.45.2
