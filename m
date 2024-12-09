Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD65B19ADBA
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Dec 2024 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733774603; cv=none; b=JvR69dFMbwGkK2PXcQINIE7xw4nyaBBxnjI5GbSfzvaKyBtxV614qxF2bf/eZ/AB5lxBHwHbTM3usvfzy6hs5x47P2GzI6D7e3QBBNsJ/SZ9HuTf0FMR4Sky0D2D2VR74fEgoA5Kmj0Ss2BIEOVsqQ3NB58x0ldCib4PLqPfAzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733774603; c=relaxed/simple;
	bh=Cz5XsO+IzSqyXTwAmxCh6roFQ/+kI7mQYh/BmtGvC0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnmD/X4fx6HJFovfBK0cOJ+4JaoU8AjD4MxTgkp81S71HCSosiMNsm6uA3Csk9y5vBFFkB4uF0fCHNFUfmx6CTdDst4mt/LUMT+fcgpIH5CWKhSMZCvgwWuBWq/DQ6fvL3mk2BF54KTKHR8q0IR5x4Kg66sixth81hd/qzM81m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PiNbo2XI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PiNbo2XI"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso46495925e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Dec 2024 12:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733774600; x=1734379400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPYCrzZCCjzRvqgU1jegwSrHbG/9FN5wcwtsSBQ6V7k=;
        b=PiNbo2XIdpYiQZEWQm0Ruo09sYrLVZzv3HjwaYU77eqNls90O1wnTPQOy75lrjyWq9
         jCE3T/R3wPxohA80QUpCNkcMgzZ1Jv8iqm3PQ2clW9zFhM/FH8YuNjYyRXjxWsYZANHO
         ouStoUzLlFSmH6JxQANL0wfA1P071jV55Eq/yDYRTH/cpUjXVIhPReoReKBU8wBR1GB3
         r1mBWqRYB000v/LnXbcapBOdq45brts39hLU/ZRbETi6p8EkF0Um6AlJFVwqmTK0Anjs
         VOmwR06bffGAfVCLTnrYuax/bJDDKjF+HbWLKs9IqWYYJWZ9TvUZeJ0KGBItSI0o0Hio
         A4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733774600; x=1734379400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPYCrzZCCjzRvqgU1jegwSrHbG/9FN5wcwtsSBQ6V7k=;
        b=nddmyPSxoA/Ke+3nzPjZgwBvVyfDhPsayQ2nRhygT6TBd0DyN/wKEGOM+Xr95KZqPs
         Wj7Uu5UZ9bdBq8W3s/PQUKbdvRbp3Ib/B4SVXzwd3KYtb2bVszzsxeKruFsb3nkmULxp
         qvRJUE3zhzxDbLX0bCoxg1Hngx3Bl2KkXzjoE8fiqeXZJM+MkVqzujgGg8wE+euXHYtw
         aM2/6Oqq0fJaDBrjx+UFO4myZZUzegkDccj/sHpYl9L5LnzFScdmDsNjQZG+el6ABwGf
         Bw4bebKqJmNfLdoJbSwt8HvmMH40DON5BGdrVSf1zHNHGK6t3nEA7Qo9mDCKXeuVjbUw
         DPaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJeQQMAMoqX7MyUQjyl+My2zMrqUMo+VirznCuQ19NuukE4J8Cc7lV4fwweH4iVBUxo6Fp8k+D+Dr6RJV6BXzw@vger.kernel.org
X-Gm-Message-State: AOJu0YwWjE9hVu7Djjw58WVCsb+arnRaMereNqpTnrb8IfkyeiYkTj1b
	1pW0sIp7iW5ALEi8k820DY/bWzb1gEZiEJ5r6woGMfCGLDgLQMEWo7VyGUi3vZgPyCnkNpxlrZm
	P8I4A+PDpuCMJe9Us2AgblPtB4Msp9CM6SnVi
X-Gm-Gg: ASbGncuMfcZjh0GA2YiHqDJy/WHO/HCP39JcXSxuHRm/C9zn4mesMVN0SkTr6bBJWDI
	FCxTS/lJFRldlhNJOoxB44c1pFd4NkWFfCn1DK6mlwfd3iuKjnCqiX6SA3lQ3lyY=
X-Google-Smtp-Source: AGHT+IH/8wBZKbvAM3Kd6V9LDka0jhS1It9n6dZAYVNyDviCv3i8BEzSASKP4rp2lhRJmvibQoaIOefKkNTbClB5B+M=
X-Received: by 2002:a05:6000:18a5:b0:385:f6b9:e762 with SMTP id
 ffacd0b85a97d-386453fbc6emr1506784f8f.36.1733774600048; Mon, 09 Dec 2024
 12:03:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126212255.3793822-1-ctshao@google.com> <20241126212255.3793822-2-ctshao@google.com>
 <Z04dWxBBEfcXK8z5@google.com>
In-Reply-To: <Z04dWxBBEfcXK8z5@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Mon, 9 Dec 2024 12:03:08 -0800
Message-ID: <CAJpZYjWSGePB6GOJb=MeLzA4bMc9BwjbkbND0p1xfkmvPZfj=Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf lock: Fix parse_lock_type which only retrieve
 one lock flag
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Namhyung, please check my v4 patches here:
https://lore.kernel.org/linux-perf-users/20241209200104.870531-1-ctshao@goo=
gle.com/T/#t

On Mon, Dec 2, 2024 at 12:49=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Tue, Nov 26, 2024 at 01:22:54PM -0800, Chun-Tse Shao wrote:
> > `parse_lock_type` can only add the first lock flag in `lock_type_table`
> > given input `str`. For example, for `Y rwlock`, it only adds `rwlock:R`
> > into this perf session. Another example is for `-Y mutex`, it only adds
> > the mutex without `LCB_F_SPIN` flag. The patch fixes this issue, makes
> > sure both `rwlock:R` and `rwlock:W` will be added with `-Y rwlock`, and
> > so on.
> >
> > Testing:
> >   $ ./perf lock con -ab -Y mutex,rwlock -- perf bench sched pipe
> >   # Running 'sched/pipe' benchmark:
> >   # Executed 1000000 pipe operations between two processes
> >
> >        Total time: 8.425 [sec]
> >
> >          8.425402 usecs/op
> >            118688 ops/sec
> >    contended   total wait     max wait     avg wait         type   call=
er
> >
> >          194      1.68 ms     44.16 us      8.66 us        mutex   pipe=
_read+0x57
> >           10    423.03 us     44.27 us     42.30 us     rwlock:W   do_e=
xit+0x365
> >           54    254.67 us     58.87 us      4.72 us        mutex   pipe=
_write+0x50
> >           21    146.64 us     11.54 us      6.98 us        mutex   pipe=
_read+0x282
> >           10    141.27 us     20.62 us     14.13 us     rwlock:W   rele=
ase_task+0x6f
> >            5     58.92 us     16.37 us     11.78 us        mutex   do_e=
poll_wait+0x24d
> >            3     29.81 us     17.66 us      9.94 us        mutex   do_e=
poll_ctl+0x6c1
> >            4     26.82 us     11.02 us      6.70 us        mutex   do_e=
poll_wait+0x24d
> >            2     18.32 us     12.49 us      9.16 us     rwlock:W   do_e=
poll_wait+0x255
> >            1     11.34 us     11.34 us     11.34 us     rwlock:W   ep_d=
one_scan+0x2d
> >            1     11.02 us     11.02 us     11.02 us     rwlock:R   mm_u=
pdate_next_owner+0x4e
> >            1     10.60 us     10.60 us     10.60 us     rwlock:W   do_e=
poll_ctl+0xb65
> >            1      9.90 us      9.90 us      9.90 us     rwlock:W   do_e=
xit+0x365
> >
> > Fixes: d783ea8f62c4 ("perf lock contention: Simplify parse_lock_type()"=
)
>
> I think it won't apply to earlier kernels because you changed the field
> names in the previous commit.  I think you can switch the order of the
> commits so that we can have the fix first.
>
>
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> >  tools/perf/builtin-lock.c | 68 ++++++++++++++++++++++++++-------------
> >  1 file changed, 45 insertions(+), 23 deletions(-)
> >
> > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > index c528aff1c9d5..c1870c287580 100644
> > --- a/tools/perf/builtin-lock.c
> > +++ b/tools/perf/builtin-lock.c
> > @@ -1622,19 +1622,6 @@ static const char *get_type_lock_name(unsigned i=
nt flags)
> >       return "unknown";
> >  }
> >
> > -static unsigned int get_type_flag(const char *str)
> > -{
> > -     for (unsigned int i =3D 0; i < ARRAY_SIZE(lock_type_table); i++) =
{
> > -             if (!strcmp(lock_type_table[i].flags_name, str))
> > -                     return lock_type_table[i].flags;
> > -     }
> > -     for (unsigned int i =3D 0; i < ARRAY_SIZE(lock_type_table); i++) =
{
> > -             if (!strcmp(lock_type_table[i].lock_name, str))
> > -                     return lock_type_table[i].flags;
> > -     }
> > -     return UINT_MAX;
> > -}
> > -
> >  static void lock_filter_finish(void)
> >  {
> >       zfree(&filters.types);
> > @@ -2356,29 +2343,64 @@ static int parse_lock_type(const struct option =
*opt __maybe_unused, const char *
> >                          int unset __maybe_unused)
> >  {
> >       char *s, *tmp, *tok;
> > -     int ret =3D 0;
> >
> >       s =3D strdup(str);
> >       if (s =3D=3D NULL)
> >               return -1;
> >
> >       for (tok =3D strtok_r(s, ", ", &tmp); tok; tok =3D strtok_r(NULL,=
 ", ", &tmp)) {
> > -             unsigned int flags =3D get_type_flag(tok);
> > +             bool found =3D false;
> >
> > -             if (flags =3D=3D -1U) {
> > -                     pr_err("Unknown lock flags: %s\n", tok);
> > -                     ret =3D -1;
> > -                     break;
> > +             /* `tok` is a flags name if it contains ':'. */
> > +             if (strchr(tok, ':')) {
> > +                     for (unsigned int i =3D 0; i < ARRAY_SIZE(lock_ty=
pe_table); i++) {
> > +                             if (!strcmp(lock_type_table[i].flags_name=
, tok) &&
> > +                                 add_lock_type(lock_type_table[i].flag=
s)) {
> > +                                     found =3D true;
> > +                                     break;
> > +                             }
> > +                     }
> > +
> > +                     if (!found) {
> > +                             pr_err("Unknown lock flags name: %s\n", t=
ok);
> > +                             free(s);
> > +                             return -1;
> > +                     }
> > +
> > +                     continue;
> >               }
> >
> > -             if (!add_lock_type(flags)) {
> > -                     ret =3D -1;
> > -                     break;
> > +             /*
> > +              * Otherwise `tok` is a lock name.
> > +              * Single lock name could contain multiple flags.
> > +              */
> > +             /*
> > +              * By documentation, `percpu-rwmem` should be `pcpu-sem`.
> > +              * For backward compatibility, we replace `pcpu-sem` with=
 `percpu-rwmem`.
> > +              */
> > +             if (!strcmp(tok, "pcpu-sem"))
> > +                     tok =3D (char *)"percpu-rwsem";
>
> I think it's better to split the pcpu-sem part into a separate commit as
> it fixes a different issue.  Also you'd better merge the block commits.
>
> Thanks,
> Namhyung
>
>
> > +
> > +             for (unsigned int i =3D 0; i < ARRAY_SIZE(lock_type_table=
); i++) {
> > +                     if (!strcmp(lock_type_table[i].lock_name, tok)) {
> > +                             if (add_lock_type(lock_type_table[i].flag=
s)) {
> > +                                     found =3D true;
> > +                             } else {
> > +                                     free(s);
> > +                                     return -1;
> > +                             }
> > +                     }
> > +             }
> > +
> > +             if (!found) {
> > +                     pr_err("Unknown lock name: %s\n", tok);
> > +                     free(s);
> > +                     return -1;
> >               }
> >       }
> >
> >       free(s);
> > -     return ret;
> > +     return 0;
> >  }
> >
> >  static bool add_lock_addr(unsigned long addr)
> > --
> > 2.47.0.338.g60cca15819-goog
> >
