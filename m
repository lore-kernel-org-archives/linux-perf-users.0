Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623621D1301
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Aug 2024 05:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724994202; cv=none; b=fVM2UsItwoMVrYlr0i6x1XiG2eqIIzrodoxb+vVJcEPIsSMgre7uLSmX9RF1lSR1dgJa+vvPE8gSDfKtzBeCv58BKSKUC+cfeJh+NjlD3NThkwUlELmb7V3yGMwOaX466FZdr4y/+Df3yOhLyPS0Bbz0uarpCmYtFkT7guQhzCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724994202; c=relaxed/simple;
	bh=mQ1V9vtht8gvS/gPKViWliFRq0kasHUtQt+/GmxDbOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YZfVLN6K+4zu8j4+9NHdx16tZnHDXWPiUnfNlQwVLIeqcVVuOMj/Oxdmxxomcjz2NZo427JgwUzaAWN/tOadXH4I7SHY2QR1u8rJVHxEEJ/r7QdFFtPVfIITu1Kh02sFHhH1vRR7ezS/OL+bXRXYRWDQB+OurjKVfK9D64hu0KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tNed384F; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tNed384F"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-202018541afso89015ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Aug 2024 22:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724994200; x=1725599000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raUxZzvhZbS9A+c7y+jcXcysIHOB5XgejC1F0pUBzyE=;
        b=tNed384FKLVbWEiCd9Y3sd1cGeyiHYhXFb4BCC7i8kAa+PlCDewIDSQBWTygGMeGo0
         0fOZFmM/JntlcGeq0GbV7T4R6HWUsNAunU/jgxs4cwt64c7WIwUWKLgXiNSjpKLO6ts1
         WQBU1scIkos2xVEYLwJHYS/3DV7WoonWAcz0J5M3wJXK8W5Es41kIfT/ggvwqvz5mUOb
         lkFMg3rUlqizl+Lawk/j9BlwxThpE0hqzmblIqWF5qa5ZISVQTj1r86UFQmrgmsHU0SS
         K8CygBabFv3bniYcdogA9NlCTqZnysL6QajyDIhUizSbiZdZ5o9IbEb//DHLl2LvUCbs
         HEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724994200; x=1725599000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=raUxZzvhZbS9A+c7y+jcXcysIHOB5XgejC1F0pUBzyE=;
        b=BRyBHsALaqQDfkEvy4w8Hk3qJIE7kJpuSE5QMtXjUU1Eg7uZP3X3qEK3gcrxDmCbal
         YHsTAPgPIIkLtiOonAAaF7DZRaNtL1leB4wzb40aa9cXeIy+MPdSZaYBWQmjCF7q3v3t
         anUcWbmDqF/eQgk4H72/A0iv0zx0bMJlnD1vbT1b0NApCQ1yBUMe1vim4+nZJloO66Fk
         3kbR2RBl18c1jNDRgdHZ/1tmgGt3HQ6Sdzx/U6mTYH3NXNLAXdO/FGPVUNfWqeEfHtHO
         pVNy9km5P9dOZM1egaryblX0VpUV9AZaKNM0PG7GGGPuhyZcB+rbH09VY2Hn+b9gjVhi
         uYrA==
X-Forwarded-Encrypted: i=1; AJvYcCUPSczyPGZv2OwArbYuNSz5VMxSnacfY6cbmLwIgMxczTD8ihCL/MfiehwcwjtKiIGOvVr2QBePhrd0BZVOw4J7@vger.kernel.org
X-Gm-Message-State: AOJu0YysADdU4qS5VbotvUjIWELo5xflOWR283xNHsV/KiAJmjMr3PBh
	tXDf4PsU5DfqYsViZThB5aP0eKronyt+UZzoU88ZQ4yz/JTHNlQjYKDqxKfaD0NDLPvgNgjrQG/
	M3l1GP9UaNuYNtHD59qzwVaFM3FzSs4k2juT7
X-Google-Smtp-Source: AGHT+IHSUgg6ATJs7pnQKAKrK3/YGT4kkwVUjAvIhYMGjl3dGcnJIlbuCCn8fVpCtRLJb3OAylI3L1uxPcskCqldDH8=
X-Received: by 2002:a17:903:189:b0:1fb:563:3c25 with SMTP id
 d9443c01a7336-20523a48c6emr1825065ad.18.1724994199104; Thu, 29 Aug 2024
 22:03:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829150154.37929-1-irogers@google.com> <20240829150154.37929-6-irogers@google.com>
 <ZtDMf886_1vXWt49@x1> <CAP-5=fURe7yVy6OGWdKn1eSzsdfZPyvvc5fRMPeNAjukaWOe1w@mail.gmail.com>
 <ZtDg2BAI0V5zKpjn@x1> <CAP-5=fXa0r7sD9xbtBVbJQFgnq=3i-cnj6gUX9tze0JyhLhvZw@mail.gmail.com>
 <ZtFNGuwj0WzRQ8fd@google.com>
In-Reply-To: <ZtFNGuwj0WzRQ8fd@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 29 Aug 2024 22:03:06 -0700
Message-ID: <CAP-5=fUjjOLJ2fUd5gN7SbS0Apgtqft0RCP1HpghFxRt==LOCg@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] perf header: Allow attributes to be written after data
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nick Terrell <terrelln@fb.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 9:39=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Aug 29, 2024 at 02:42:38PM -0700, Ian Rogers wrote:
> > On Thu, Aug 29, 2024 at 1:58=E2=80=AFPM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Thu, Aug 29, 2024 at 01:12:32PM -0700, Ian Rogers wrote:
> > > > On Thu, Aug 29, 2024 at 12:31=E2=80=AFPM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > >
> > > > > On Thu, Aug 29, 2024 at 08:01:51AM -0700, Ian Rogers wrote:
> > > > > > With a file, to write data an offset needs to be known. Typical=
ly data
> > > > > > follows the event attributes in a file. However, if processing =
a pipe
> > > > > > the number of event attributes may not be known. It is convenie=
nt in
> > > > > > that case to write the attributes after the data. Expand
> > > > > > perf_session__do_write_header to allow this when the data offse=
t and
> > > > > > size are known.
> > > > > >
> > > > > > This approach may be useful for more than just taking a pipe fi=
le to
> > > > > > write into a data file, `perf inject --itrace` will reserve and
> > > > > > additional 8kb for attributes, which would be unnecessary if th=
e
> > > > > > attributes were written after the data.
> > > > > >
> > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > > ---
> > > > > >  tools/perf/util/header.c | 106 +++++++++++++++++++++++++------=
--------
> > > > > >  1 file changed, 67 insertions(+), 39 deletions(-)
> > > > > >
> > > > > > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.=
c
> > > > > > index 65c9086610cb..4eb39463067e 100644
> > > > > > --- a/tools/perf/util/header.c
> > > > > > +++ b/tools/perf/util/header.c
> > > > > > @@ -3676,32 +3676,50 @@ int perf_header__write_pipe(int fd)
> > > > > >  static int perf_session__do_write_header(struct perf_session *=
session,
> > > > > >                                        struct evlist *evlist,
> > > > > >                                        int fd, bool at_exit,
> > > > > > -                                      struct feat_copier *fc)
> > > > > > +                                      struct feat_copier *fc,
> > > > > > +                                      bool write_attrs_after_d=
ata)
> > > > > >  {
> > > > > >       struct perf_file_header f_header;
> > > > > > -     struct perf_file_attr   f_attr;
> > > > > >       struct perf_header *header =3D &session->header;
> > > > > >       struct evsel *evsel;
> > > > > >       struct feat_fd ff =3D {
> > > > > >               .fd =3D fd,
> > > > > >       };
> > > > > > -     u64 attr_offset;
> > > > > > +     u64 attr_offset =3D sizeof(f_header), attr_size =3D 0;
> > > > > >       int err;
> > > > > >
> > > > > > -     lseek(fd, sizeof(f_header), SEEK_SET);
> > > > > > +     if (write_attrs_after_data && at_exit) {
> > > > > > +             /*
> > > > > > +              * Write features at the end of the file first so=
 that
> > > > > > +              * attributes may come after them.
> > > > > > +              */
> > > > > > +             if (!header->data_offset && header->data_size) {
> > > > > > +                     pr_err("File contains data but offset unk=
nown\n");
> > > > > > +                     err =3D -1;
> > > > > > +                     goto err_out;
> > > > > > +             }
> > > > > > +             header->feat_offset =3D header->data_offset + hea=
der->data_size;
> > > > > > +             err =3D perf_header__adds_write(header, evlist, f=
d, fc);
> > > > > > +             if (err < 0)
> > > > > > +                     goto err_out;
> > > > > > +             attr_offset =3D lseek(fd, 0, SEEK_CUR);
> > > > > > +     } else {
> > > > > > +             lseek(fd, attr_offset, SEEK_SET);
> > > > > > +     }
> > > > > >
> > > > > >       evlist__for_each_entry(session->evlist, evsel) {
> > > > > > -             evsel->id_offset =3D lseek(fd, 0, SEEK_CUR);
> > > > > > -             err =3D do_write(&ff, evsel->core.id, evsel->core=
.ids * sizeof(u64));
> > > > > > -             if (err < 0) {
> > > > > > -                     pr_debug("failed to write perf header\n")=
;
> > > > > > -                     free(ff.buf);
> > > > > > -                     return err;
> > > > > > +             evsel->id_offset =3D attr_offset;
> > > > > > +             /* Avoid writing at the end of the file until the=
 session is exiting. */
> > > > > > +             if (!write_attrs_after_data || at_exit) {
> > > > > > +                     err =3D do_write(&ff, evsel->core.id, evs=
el->core.ids * sizeof(u64));
> > > > > > +                     if (err < 0) {
> > > > > > +                             pr_debug("failed to write perf he=
ader\n");
> > > > > > +                             goto err_out;
> > > > > > +                     }
> > > > > >               }
> > > > > > +             attr_offset +=3D evsel->core.ids * sizeof(u64);
> > > > >
> > > > > So in the past we were using lseek(fd, 0, SEEK_CUR) to set the
> > > > > evsel->id_offset, now you're assuming that do_write will honour t=
he size
> > > > > parameter, i.e. write evsel->core.ids * sizeof(u64), but:
> > > > >
> > > > > /* Return: 0 if succeeded, -ERR if failed. */
> > > > > int do_write(struct feat_fd *ff, const void *buf, size_t size)
> > > > > {
> > > > >         if (!ff->buf)
> > > > >                 return __do_write_fd(ff, buf, size);
> > > > >         return __do_write_buf(ff, buf, size);
> > > > > }
> > > > >
> > > > > And then:
> > > > >
> > > > > static int __do_write_fd(struct feat_fd *ff, const void *buf, siz=
e_t size)
> > > > > {
> > > > >         ssize_t ret =3D writen(ff->fd, buf, size);
> > > > >
> > > > >         if (ret !=3D (ssize_t)size)
> > > > >                 return ret < 0 ? (int)ret : -1;
> > > > >         return 0;
> > > > > }
> > > > >
> > > > > I see that writen calls ion that even has a BUG_ON() if it doesn'=
t write
> > > > > exactly the requested size bytes, I got distracted with __do_writ=
e_fd
> > > > > extra check that ret !=3D size returning ret if not negative...
> > > > >
> > > > > I.e. your code _should_ be equivalent due to the check in ion(), =
and
> > > > > taking that as an assumption you reduce the number of lseek sysca=
lls,
> > > > > which is a good thing...
> > > > >
> > > > > I was just trying to see that the !write_attrs_after_data case wa=
s
> > > > > _exactly_ the same as before, which it doesn't look like it is :-=
\
> > > >
> > > > I'm not seeing the difference. Before:
> > >
> > > You noticed the difference: before we used lseek to get the current
> > > offset to use, afterwards we moved to doing plain math.
> > >
> > > So I had to check if we could assume that, and with the current code
> > > structure, yes, we can assume that, so seems safe, but it is differen=
t
> > > and if the assumption somehow breaks, as the code in __do_write_fd()
> > > guard against (unneeded at the moment as ion has even a BUG_ON for th=
at
> > > not to happen), then the offset will not be where the data is.
> > >
> > > Using lseek() is more costly (syscalls) but it is the ultimate answer=
 to
> > > get where in the file the current offset is.
> > >
> > > So that is the difference I noticed.
> > >
> > > Doing multiple things in the same patch causes these reviewing delays=
,
> > > doubts, its something we discussed multiple times in the past, and th=
at
> > > continue to cause these discussions.
> >
> > Right, but it is something of an unfortunate coincidence of how the
> > code is structured. The fact that writing the header updates
> > data_offset which is a thing that other things depend upon while
> > depending on its value itself, etc. - ie the function does more than
> > just a write, it also sometimes computes the layout, has inbuilt
> > assumptions on the values lseek will return, and so on. To get to this
> > final structure took a fair few iterations and I've separated this
> > change out from the bulk in the next change to keep the patch size
> > down. I could have done a patch switching from lseeks to math, then a
> > patch to add write_attrs_after_data. It probably would have yielded
> > about 4 lines of shared code, more lines that would have been deleted,
> > while creating quite a bit of work for me. Ideally when these
> > functions were created there would have been far more liberal use of
> > things like immutability, so side-effects are minimized. Yes I could
> > refactor everything, but time..
>
> Maybe I'm too naive but can we skip header updates on pipe data?  I'm
> curious if this makes sense..
>
> Thanks,
> Namhyung
>
>
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index a7c859db2e15..b36f84f29295 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2341,6 +2341,9 @@ int cmd_inject(int argc, const char **argv)
>         if (ret)
>                 goto out_delete;
>
> +       if (data.is_pipe)
> +               inject.is_pipe =3D true;
> +

I'm not sure what you are saying. We can't know definitively if the
input is a pipe style file or pipe until the header is read, which is
part of session__new and something we pass whether we want to repipe
the header or not. So we've made a decision or not to repipe but
opening the header may change the decision that was already made. As
you say we can opportunistically just copy/repipe the header if we
know the input and output types match, but:
1) generating the header isn't that much work,
2) if the header needs to change for extra attributes, such as with
some of the auxiliary flags, then the repiped header was no good
anyway.
Trying to keep header repiping alive for inject, the only use, is
weird given all the gotchas. I think it is simpler to open, know what
we're dealing with, then generate the output header accordingly -
possibly synthesizing events for the attributes in the case of file to
pipe.

Thanks,
Ian

>         if (!data.is_pipe && inject.output.is_pipe) {
>                 ret =3D perf_header__write_pipe(perf_data__fd(&inject.out=
put));
>                 if (ret < 0) {
>
