Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1181BA29E
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Aug 2024 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962367; cv=none; b=DkTgRW1HggWqvSd94qHiNX66rfeJ2urFZqpjtUhrrDnA+UNQhfcwoUKMV7lPE46O1+FnCTABm3PHG44GDRuB5gNaL1Q3wFnXZBCdGd9J0UdFwSxiBTwgc5Zgr20jWRPLrxyYlcR+RiHORcvaGa/uq2YECy4HDwynSpdSAC87C0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962367; c=relaxed/simple;
	bh=5D4Lj5C0znq6BFzanw8MlfV/z4qw3LEp1BcZZR90qN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALwviGQKI7J7o4eG96vjL1GKP7FadjkYh+8KX4r1BunvDLnuuzoVutyQ7ko1cqBSOv99txQrD370lEnTECK6m+MYv5BlUhj/7uM3gnhwa3Ky+C3hlsjdcYm8it9HSL6NtxYB4RJUQ98Mb6oyil54XbNiCxsV+CLiIlPyCPZRpt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0qZMf8yn; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0qZMf8yn"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-456871a4d8fso71641cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Aug 2024 13:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724962364; x=1725567164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naElkzVOShHXah2bqvjs/sl388+77kkg3g9M3zMR4VY=;
        b=0qZMf8ynswltjbwfPEYdByLxfsMqeDHH7TfRyn5ZBVHYaQ2ZikpdFUBz9X6ZSZq/2h
         SKc4vlhmA+sPdx4NYCfjmPWqgzrmklfS8V53FSB03JQ2lZcwLatGzvsJjEJDiLOPI+Hy
         BVHVeVnTWQYPtwHimNCfQqxtbap6vKa8oAnicpCKUCDnJSCh02wvMy6f4t5/dlJ0Jm5A
         eUuBsMk2mtaE21ZBj91haD+Cy6wC72+VGp0Fm/gAvotd3qXLkRqur9e3shxJb9PDKWhm
         3QqH/Cp/ia77C1Tmzl2YGLmYH6BQrqASZokegERxpBUCMnD+hMAjBkU3PrOrIsUMVD+H
         KHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724962364; x=1725567164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naElkzVOShHXah2bqvjs/sl388+77kkg3g9M3zMR4VY=;
        b=gzF0Z6uB3NLkS+nsRdwhx2qvhY3dtrImz6IMPO55eAv6iSNxg13mpb7sC5ms2ZW2iQ
         9WAQ4FlBOcZ9IQxFLJxCwWglLIIjv5FZ3bdrWPhJSlVxR345Dc5LMN3sw+xnnIrp+ZiE
         6soEqgxnkHnuNVna/T/4zhquidGMZPRIiea0ADZcysJHh8UlSOjSrJKyld9dgEIpYwts
         81xonozfYnV9s+Gz20MQuV6cdwmnMfmzjd7ZNJErbLhWOqhwIvPRkjzJ7P6JoSOlraqw
         YggMMY8IBUQXOYR5Mt85Vf+45kEzI1BHrb8cKfjbJimuCqg9v8fhpZUkKhgfXYQ1LWyk
         tkbA==
X-Forwarded-Encrypted: i=1; AJvYcCXbPC5f+Opy1jzkXqHtQF4u+3lC+O4Cy7dmVxvUZCOBJtf6Udz7SPeact8hbMeLEo1+c0DroRvXtIn/GORZ9Fyc@vger.kernel.org
X-Gm-Message-State: AOJu0YxF/ednwF1PZNEXtLxRoYohaZTBNrwGgOKI66Zk+w+wIf0xOtxA
	LBI3lRS5HugFM7yMKt+SzuZGAVtiK7r3rbZ285focnuiWTTapYLZpaMEfNm0M/8Iv/sgk4dEU5N
	AcFFhdGpFQ7xKb2yrkOKUkRHKxY3Kut5F5yuy
X-Google-Smtp-Source: AGHT+IGiO1o1/oof0RiruYThCoj6A5IcXgZhALusWYd395E0M71S7VsDC5/bd6apsZJnhu+vnDTtgcMMqXNn3OXhBMc=
X-Received: by 2002:a05:622a:281:b0:446:64ad:ee91 with SMTP id
 d75a77b69052e-4568aace6a3mr567661cf.20.1724962363590; Thu, 29 Aug 2024
 13:12:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829150154.37929-1-irogers@google.com> <20240829150154.37929-6-irogers@google.com>
 <ZtDMf886_1vXWt49@x1>
In-Reply-To: <ZtDMf886_1vXWt49@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 Aug 2024 13:12:32 -0700
Message-ID: <CAP-5=fURe7yVy6OGWdKn1eSzsdfZPyvvc5fRMPeNAjukaWOe1w@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] perf header: Allow attributes to be written after data
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nick Terrell <terrelln@fb.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 12:31=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Aug 29, 2024 at 08:01:51AM -0700, Ian Rogers wrote:
> > With a file, to write data an offset needs to be known. Typically data
> > follows the event attributes in a file. However, if processing a pipe
> > the number of event attributes may not be known. It is convenient in
> > that case to write the attributes after the data. Expand
> > perf_session__do_write_header to allow this when the data offset and
> > size are known.
> >
> > This approach may be useful for more than just taking a pipe file to
> > write into a data file, `perf inject --itrace` will reserve and
> > additional 8kb for attributes, which would be unnecessary if the
> > attributes were written after the data.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/header.c | 106 +++++++++++++++++++++++++--------------
> >  1 file changed, 67 insertions(+), 39 deletions(-)
> >
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index 65c9086610cb..4eb39463067e 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -3676,32 +3676,50 @@ int perf_header__write_pipe(int fd)
> >  static int perf_session__do_write_header(struct perf_session *session,
> >                                        struct evlist *evlist,
> >                                        int fd, bool at_exit,
> > -                                      struct feat_copier *fc)
> > +                                      struct feat_copier *fc,
> > +                                      bool write_attrs_after_data)
> >  {
> >       struct perf_file_header f_header;
> > -     struct perf_file_attr   f_attr;
> >       struct perf_header *header =3D &session->header;
> >       struct evsel *evsel;
> >       struct feat_fd ff =3D {
> >               .fd =3D fd,
> >       };
> > -     u64 attr_offset;
> > +     u64 attr_offset =3D sizeof(f_header), attr_size =3D 0;
> >       int err;
> >
> > -     lseek(fd, sizeof(f_header), SEEK_SET);
> > +     if (write_attrs_after_data && at_exit) {
> > +             /*
> > +              * Write features at the end of the file first so that
> > +              * attributes may come after them.
> > +              */
> > +             if (!header->data_offset && header->data_size) {
> > +                     pr_err("File contains data but offset unknown\n")=
;
> > +                     err =3D -1;
> > +                     goto err_out;
> > +             }
> > +             header->feat_offset =3D header->data_offset + header->dat=
a_size;
> > +             err =3D perf_header__adds_write(header, evlist, fd, fc);
> > +             if (err < 0)
> > +                     goto err_out;
> > +             attr_offset =3D lseek(fd, 0, SEEK_CUR);
> > +     } else {
> > +             lseek(fd, attr_offset, SEEK_SET);
> > +     }
> >
> >       evlist__for_each_entry(session->evlist, evsel) {
> > -             evsel->id_offset =3D lseek(fd, 0, SEEK_CUR);
> > -             err =3D do_write(&ff, evsel->core.id, evsel->core.ids * s=
izeof(u64));
> > -             if (err < 0) {
> > -                     pr_debug("failed to write perf header\n");
> > -                     free(ff.buf);
> > -                     return err;
> > +             evsel->id_offset =3D attr_offset;
> > +             /* Avoid writing at the end of the file until the session=
 is exiting. */
> > +             if (!write_attrs_after_data || at_exit) {
> > +                     err =3D do_write(&ff, evsel->core.id, evsel->core=
.ids * sizeof(u64));
> > +                     if (err < 0) {
> > +                             pr_debug("failed to write perf header\n")=
;
> > +                             goto err_out;
> > +                     }
> >               }
> > +             attr_offset +=3D evsel->core.ids * sizeof(u64);
>
> So in the past we were using lseek(fd, 0, SEEK_CUR) to set the
> evsel->id_offset, now you're assuming that do_write will honour the size
> parameter, i.e. write evsel->core.ids * sizeof(u64), but:
>
> /* Return: 0 if succeeded, -ERR if failed. */
> int do_write(struct feat_fd *ff, const void *buf, size_t size)
> {
>         if (!ff->buf)
>                 return __do_write_fd(ff, buf, size);
>         return __do_write_buf(ff, buf, size);
> }
>
> And then:
>
> static int __do_write_fd(struct feat_fd *ff, const void *buf, size_t size=
)
> {
>         ssize_t ret =3D writen(ff->fd, buf, size);
>
>         if (ret !=3D (ssize_t)size)
>                 return ret < 0 ? (int)ret : -1;
>         return 0;
> }
>
> I see that writen calls ion that even has a BUG_ON() if it doesn't write
> exactly the requested size bytes, I got distracted with __do_write_fd
> extra check that ret !=3D size returning ret if not negative...
>
> I.e. your code _should_ be equivalent due to the check in ion(), and
> taking that as an assumption you reduce the number of lseek syscalls,
> which is a good thing...
>
> I was just trying to see that the !write_attrs_after_data case was
> _exactly_ the same as before, which it doesn't look like it is :-\

I'm not seeing the difference. Before:
```
lseek(fd, sizeof(f_header), SEEK_SET);
evlist__for_each_entry(session->evlist, evsel) {
    evsel->id_offset =3D lseek(fd, 0, SEEK_CUR); // Initially at sizeof(f_h=
eader)
...
    err =3D do_write(&ff, evsel->core.id, evsel->core.ids *
sizeof(u64));  // offset has advanced by "evsel->core.ids *
sizeof(u64)" bytes
...
}
```
After:
```
u64 attr_offset =3D sizeof(f_header)
...
else {
    lseek(fd, attr_offset, SEEK_SET);
}

evlist__for_each_entry(session->evlist, evsel) {
    evsel->id_offset =3D attr_offset;
...
    err =3D do_write(&ff, evsel->core.id, evsel->core.ids * sizeof(u64));
...
    attr_offset +=3D evsel->core.ids * sizeof(u64);
}
```

The reason for using math rather than lseek (apart from reducing
syscalls) is that if we're writing the header at the beginning of
generating a file (usually done more to compute the
header->data_offset), we can't use lseek if writing at the end as we
don't know where the end of the data will be yet and don't write out
the bytes.

Thanks,
Ian

> - Arnaldo
>
> >       }
> >
> > -     attr_offset =3D lseek(ff.fd, 0, SEEK_CUR);
> > -
> >       evlist__for_each_entry(evlist, evsel) {
> >               if (evsel->core.attr.size < sizeof(evsel->core.attr)) {
> >                       /*
> > @@ -3711,40 +3729,46 @@ static int perf_session__do_write_header(struct=
 perf_session *session,
> >                        */
> >                       evsel->core.attr.size =3D sizeof(evsel->core.attr=
);
> >               }
> > -             f_attr =3D (struct perf_file_attr){
> > -                     .attr =3D evsel->core.attr,
> > -                     .ids  =3D {
> > -                             .offset =3D evsel->id_offset,
> > -                             .size   =3D evsel->core.ids * sizeof(u64)=
,
> > +             /* Avoid writing at the end of the file until the session=
 is exiting. */
> > +             if (!write_attrs_after_data || at_exit) {
> > +                     struct perf_file_attr f_attr =3D {
> > +                             .attr =3D evsel->core.attr,
> > +                             .ids  =3D {
> > +                                     .offset =3D evsel->id_offset,
> > +                                     .size   =3D evsel->core.ids * siz=
eof(u64),
> > +                             }
> > +                     };
> > +                     err =3D do_write(&ff, &f_attr, sizeof(f_attr));
> > +                     if (err < 0) {
> > +                             pr_debug("failed to write perf header att=
ribute\n");
> > +                             goto err_out;
> >                       }
> > -             };
> > -             err =3D do_write(&ff, &f_attr, sizeof(f_attr));
> > -             if (err < 0) {
> > -                     pr_debug("failed to write perf header attribute\n=
");
> > -                     free(ff.buf);
> > -                     return err;
> >               }
> > +             attr_size +=3D sizeof(struct perf_file_attr);
> >       }
> >
> > -     if (!header->data_offset)
> > -             header->data_offset =3D lseek(fd, 0, SEEK_CUR);
> > +     if (!header->data_offset) {
> > +             if (write_attrs_after_data)
> > +                     header->data_offset =3D sizeof(f_header);
> > +             else
> > +                     header->data_offset =3D attr_offset + attr_size;
> > +     }
> >       header->feat_offset =3D header->data_offset + header->data_size;
> >
> > -     if (at_exit) {
> > +     if (!write_attrs_after_data && at_exit) {
> > +             /* Write features now feat_offset is known. */
> >               err =3D perf_header__adds_write(header, evlist, fd, fc);
> > -             if (err < 0) {
> > -                     free(ff.buf);
> > -                     return err;
> > -             }
> > +             if (err < 0)
> > +                     goto err_out;
> >       }
> >
> >       f_header =3D (struct perf_file_header){
> >               .magic     =3D PERF_MAGIC,
> >               .size      =3D sizeof(f_header),
> > -             .attr_size =3D sizeof(f_attr),
> > +             .attr_size =3D sizeof(struct perf_file_attr),
> >               .attrs =3D {
> >                       .offset =3D attr_offset,
> > -                     .size   =3D evlist->core.nr_entries * sizeof(f_at=
tr),
> > +                     .size   =3D attr_size,
> >               },
> >               .data =3D {
> >                       .offset =3D header->data_offset,
> > @@ -3757,21 +3781,24 @@ static int perf_session__do_write_header(struct=
 perf_session *session,
> >
> >       lseek(fd, 0, SEEK_SET);
> >       err =3D do_write(&ff, &f_header, sizeof(f_header));
> > -     free(ff.buf);
> >       if (err < 0) {
> >               pr_debug("failed to write perf header\n");
> > -             return err;
> > +             goto err_out;
> > +     } else {
> > +             lseek(fd, 0, SEEK_END);
> > +             err =3D 0;
> >       }
> > -     lseek(fd, header->data_offset + header->data_size, SEEK_SET);
> > -
> > -     return 0;
> > +err_out:
> > +     free(ff.buf);
> > +     return err;
> >  }
> >
> >  int perf_session__write_header(struct perf_session *session,
> >                              struct evlist *evlist,
> >                              int fd, bool at_exit)
> >  {
> > -     return perf_session__do_write_header(session, evlist, fd, at_exit=
, NULL);
> > +     return perf_session__do_write_header(session, evlist, fd, at_exit=
, /*fc=3D*/NULL,
> > +                                          /*write_attrs_after_data=3D*=
/false);
> >  }
> >
> >  size_t perf_session__data_offset(const struct evlist *evlist)
> > @@ -3793,7 +3820,8 @@ int perf_session__inject_header(struct perf_sessi=
on *session,
> >                               int fd,
> >                               struct feat_copier *fc)
> >  {
> > -     return perf_session__do_write_header(session, evlist, fd, true, f=
c);
> > +     return perf_session__do_write_header(session, evlist, fd, true, f=
c,
> > +                                          /*write_attrs_after_data=3D*=
/false);
> >  }
> >
> >  static int perf_header__getbuffer64(struct perf_header *header,
> > --
> > 2.46.0.295.g3b9ea8a38a-goog
