Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7C03B28F
	for <linux-perf-users@vger.kernel.org>; Fri, 24 May 2024 04:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716526037; cv=none; b=U6j0TVhMEqv1CN/2kNP3Nnvx4o2OYomdZJOhiM/CVmrYe69hve0u/RYgt8N9AV+RJCYbn5xpt0avQz51uxD+zp+kcvTa2z1mbaW+eIT0/GclRn16TKKyNF4b6LOeqajvF9Wjbaiz5xvND2XbQZuQLIEroxZNoZm44xEfLFPcZWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716526037; c=relaxed/simple;
	bh=I2/x+KnmvFX3d9VHFjWihBA46JsKDMU7fWgzkkSQye4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=elZgWIbPAbGMH10gRgdOQRN4YypIVQjyzo9oAQ3Z3U6vkElnX9MPInaeA4kUp3Bo4ceRWumbCgdmRqEddzATikvTt1bkv6116O9t65vIRlCHvCuRwhHXlhn9Fv5S3/v10LjV0PRZLD3zl7rDyw6UD5XKRzkz+4JlYRLHCWlUNAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=me6BO6t3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="me6BO6t3"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f3310a2f0dso66595ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 May 2024 21:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716526035; x=1717130835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3ETX8R5dt64Y8KD9VavcrPaoSjT+tQS13gpCD8a92c=;
        b=me6BO6t3AzqJ+piBJ9FS/t3aJZtQt6g6UYlriXmnf1zVUlwvPtOBT/JRSru/KesE2D
         kV2oUIxq/3XOamSOY/fnLQZ3t+9azFuXp6C2alvdFhl4PovoHiRp6Dd2nGa3E4FBYVim
         w4iZqD0TfnDK0xz/Yt4vUy5yfNZK6+EnZs2VNI76D1fYGXSMPpieUAC5+MiXmuxDPgBE
         PEmOmMrK1kkTkIb+bf6zjxUr+Aw1dmSh6KsJp7SiZRuTrTOp88SerwZ3PE30g8DNiTHw
         v0T1Z041U3ZQGMzIVmW0L5UllUA8cgYGf5G3oFQ+Lavj383QlCBYxxl5SAVzLWtYiwdf
         Ym+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716526035; x=1717130835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3ETX8R5dt64Y8KD9VavcrPaoSjT+tQS13gpCD8a92c=;
        b=D3ncrjy5K6Aa95zfLL86CKhqRaCbFGIASLWGiMchCbapoHjoT6i6amaP23cPsHdhid
         cUjhjFUTSoSd8AzG1mdy2YQsCOCyQb4d6lo6Q5skqhNRjmQxsGKVgx6Z5B10AWVnjzxG
         YN1BwkwPVcQ14ynSmQQCrwI42OXXMx2gd/5SM1cZgimrHiMGi1vpQq1KoHOiozwldoAR
         iGQk8u1x+o7LXDXo++34WWvgcxmG9cUTTTFtwmuR0+Y0LEeelmEOprCAnbVjJ4rl6H2f
         srSH8Rsc4Pa1LVm6fzm1hFsfgVFVYF5D1zSCE0cwnsaka9LUBd87gokUMv6YlAT8vdwA
         JdQw==
X-Forwarded-Encrypted: i=1; AJvYcCUg2uOUkRZuaFYThKSeSMvuCAxYss8U1+FsIZfMyWPP+b+RSEzfUhNBYdBPslWhBMLOalNtd378g0OfDQxeJcwhAOx/sW5V12mx+NwHAip0vQ==
X-Gm-Message-State: AOJu0YwqEsrqBmCDzEdMn3S8qNiufR9FlCIWuqLQCeOy9RO7BfklTD7s
	2zb50B9oUQ1AFHX613PgUpS2DI9JVkWInIopk/ZdIq688v3II84WxQGHggo14+NQpsOGScXi/lx
	alK+0D75JF7yCMKE5oyxd/N2B3wFxKOfXJHw8
X-Google-Smtp-Source: AGHT+IEnDxHqN9Qskzl7NBvX9dcVe3SETwJUrzLmIQeE3VFqa5PtLSaOtC9LAT8c3VNNJvZdHpcLw8SyH2GPt4Uz0ss=
X-Received: by 2002:a17:902:e9d5:b0:1e0:a7ee:18b2 with SMTP id
 d9443c01a7336-1f44c4cbd03mr979415ad.15.1716526034931; Thu, 23 May 2024
 21:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240519181716.4088459-1-irogers@google.com> <CAM9d7chxsyZ+vnPXj0gc-mbADzwzQYi3qUwUohW-7He5KwMvHg@mail.gmail.com>
In-Reply-To: <CAM9d7chxsyZ+vnPXj0gc-mbADzwzQYi3qUwUohW-7He5KwMvHg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 23 May 2024 21:47:02 -0700
Message-ID: <CAP-5=fXME3cjNK-P9qk+kY0dA1Xkwvz6Su=99nY7CgcKrQTb2w@mail.gmail.com>
Subject: Re: [PATCH v1] tools api io: Move filling the io buffer to its own function
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 4:25=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Sun, May 19, 2024 at 11:17=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> >
> > In general a read fills 4kb so filling the buffer is a 1 in 4096
> > operation, move it out of the io__get_char function to avoid some
> > checking overhead and to better hint the function is good to inline.
> >
> > For perf's IO intensive internal (non-rigorous) benchmarks there's a
> > near 8% improvement to kallsyms-parsing with a default build.
>
> Oh, is it just from removing the io->eof check?  Otherwise I don't
> see any difference.

I was hoping that by moving the code out-of-line then the hot part of
the function could be inlined into things like reading the hex
character. I didn't see that, presumably there are too many callers
and so that made the inliner think sharing would be best even though
the hot code is a compare, pointer dereference and an increment. I
tried forcing inlining but it didn't seem to win over just having the
code out-of-line. The eof check should be very well predicted. The
out-of-line code was branched over forward, which should be 1
mispredict but again not a huge deal. I didn't do a more thorough
analysis as I still prefer to have the cold code out-of-line.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Before:
> > ```
> > $ perf bench internals all
> > Computing performance of single threaded perf event synthesis by
> > synthesizing events on the perf process itself:
> >   Average synthesis took: 146.322 usec (+- 0.305 usec)
> >   Average num. events: 61.000 (+- 0.000)
> >   Average time per event 2.399 usec
> >   Average data synthesis took: 145.056 usec (+- 0.155 usec)
> >   Average num. events: 329.000 (+- 0.000)
> >   Average time per event 0.441 usec
> >
> >   Average kallsyms__parse took: 162.313 ms (+- 0.599 ms)
> > ...
> > Computing performance of sysfs PMU event scan for 100 times
> >   Average core PMU scanning took: 53.720 usec (+- 7.823 usec)
> >   Average PMU scanning took: 375.145 usec (+- 23.974 usec)
> > ```
> > After:
> > ```
> > $ perf bench internals all
> > Computing performance of single threaded perf event synthesis by
> > synthesizing events on the perf process itself:
> >   Average synthesis took: 127.829 usec (+- 0.079 usec)
> >   Average num. events: 61.000 (+- 0.000)
> >   Average time per event 2.096 usec
> >   Average data synthesis took: 133.652 usec (+- 0.101 usec)
> >   Average num. events: 327.000 (+- 0.000)
> >   Average time per event 0.409 usec
> >
> >   Average kallsyms__parse took: 150.415 ms (+- 0.313 ms)
> > ...
> > Computing performance of sysfs PMU event scan for 100 times
> >   Average core PMU scanning took: 47.790 usec (+- 1.178 usec)
> >   Average PMU scanning took: 376.945 usec (+- 23.683 usec)
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/api/io.h | 69 +++++++++++++++++++++++++---------------------
> >  1 file changed, 38 insertions(+), 31 deletions(-)
> >
> > diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> > index 84adf8102018..d3eb04d1bc89 100644
> > --- a/tools/lib/api/io.h
> > +++ b/tools/lib/api/io.h
> > @@ -43,48 +43,55 @@ static inline void io__init(struct io *io, int fd,
> >         io->eof =3D false;
> >  }
> >
> > -/* Reads one character from the "io" file with similar semantics to fg=
etc. */
> > -static inline int io__get_char(struct io *io)
> > +/* Read from fd filling the buffer. Called when io->data =3D=3D io->en=
d. */
> > +static inline int io__fill_buffer(struct io *io)
> >  {
> > -       char *ptr =3D io->data;
> > +       ssize_t n;
> >
> >         if (io->eof)
> >                 return -1;
> >
> > -       if (ptr =3D=3D io->end) {
> > -               ssize_t n;
> > -
> > -               if (io->timeout_ms !=3D 0) {
> > -                       struct pollfd pfds[] =3D {
> > -                               {
> > -                                       .fd =3D io->fd,
> > -                                       .events =3D POLLIN,
> > -                               },
> > -                       };
> > -
> > -                       n =3D poll(pfds, 1, io->timeout_ms);
> > -                       if (n =3D=3D 0)
> > -                               errno =3D ETIMEDOUT;
> > -                       if (n > 0 && !(pfds[0].revents & POLLIN)) {
> > -                               errno =3D EIO;
> > -                               n =3D -1;
> > -                       }
> > -                       if (n <=3D 0) {
> > -                               io->eof =3D true;
> > -                               return -1;
> > -                       }
> > +       if (io->timeout_ms !=3D 0) {
> > +               struct pollfd pfds[] =3D {
> > +                       {
> > +                               .fd =3D io->fd,
> > +                               .events =3D POLLIN,
> > +                       },
> > +               };
> > +
> > +               n =3D poll(pfds, 1, io->timeout_ms);
> > +               if (n =3D=3D 0)
> > +                       errno =3D ETIMEDOUT;
> > +               if (n > 0 && !(pfds[0].revents & POLLIN)) {
> > +                       errno =3D EIO;
> > +                       n =3D -1;
> >                 }
> > -               n =3D read(io->fd, io->buf, io->buf_len);
> > -
> >                 if (n <=3D 0) {
> >                         io->eof =3D true;
> >                         return -1;
> >                 }
> > -               ptr =3D &io->buf[0];
> > -               io->end =3D &io->buf[n];
> >         }
> > -       io->data =3D ptr + 1;
> > -       return *ptr;
> > +       n =3D read(io->fd, io->buf, io->buf_len);
> > +
> > +       if (n <=3D 0) {
> > +               io->eof =3D true;
> > +               return -1;
> > +       }
> > +       io->data =3D &io->buf[0];
> > +       io->end =3D &io->buf[n];
> > +       return 0;
> > +}
> > +
> > +/* Reads one character from the "io" file with similar semantics to fg=
etc. */
> > +static inline int io__get_char(struct io *io)
> > +{
> > +       if (io->data =3D=3D io->end) {
> > +               int ret =3D io__fill_buffer(io);
> > +
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +       return *io->data++;
> >  }
> >
> >  /* Read a hexadecimal value with no 0x prefix into the out argument he=
x. If the
> > --
> > 2.45.0.rc1.225.g2a3ae87e7f-goog
> >
