Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668D417D8BB
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jul 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358731; cv=none; b=t616o6XchBmefs3V8oaehIDP2ug05xfs2IGbngywENiCJwpllZ+azzVdRIBsPhHHdQTlunGAyWFJn5DGf8hR4oyMD+fPNWfoXRTsRNrjrOnvQm0KnHxM1mMZfPAyTcirTzV4Zk/oBE9WGHhMDI16fC0ue/LK4U99MWQ3YAX9oVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358731; c=relaxed/simple;
	bh=MakCGp2MWoAV0Xc0eI7OesuYOc4aL/IhFc+YGoVClfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVzwRWQIPDXugR+HG6SndAV3p9sjSUdl5uEkF4WRFtJIb2wxdHNLSi91S3CdTmrfDsSSgEHpg4Bag9dnSIab5FL30azcHW0gZ7D+GLoufV3ZIa8a6zlWR+qdWKw4kLVYYPVaCUEOUe+BVHumm4ynEKp32utlI61su48j3Lym1/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jl9l2M87; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jl9l2M87"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc4aff530dso6015ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Jul 2024 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722358729; x=1722963529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVx5Mo1cNi2O2SneJHVsg+dKHPp4XLpaPWsYQ7yBQn4=;
        b=jl9l2M87d/q5Ua7i0XjNUaTg+HCoNtS9kGbINJ/rlkQIPlQO5/Gf3Qv16MEc4tzJIf
         5CW3b6r5nMFjt0B8WOI27SC5MluCZM+Zk5jkzn3yYq1k6wuvdVY+Lvem3jJA32HmADkS
         ldmc2dIyjo/zZ2jZ6MrnzaBfURsaIEIMPG1F/FQbQUoenWhmVWjxf2LO9zoo8SNjK9qU
         YS79aAGlIFeQoIxHyN/T90066JTGM1g9rwUtTDmBEqB16/nhguDvkJ5s8iWmiaRIG3Ok
         2TLrt8CUQxc5I5K97rDQMJYod5IjRnzwjxten3T0lrX7fex3XaxtsidpPAulKiMz/fPw
         y1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722358729; x=1722963529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVx5Mo1cNi2O2SneJHVsg+dKHPp4XLpaPWsYQ7yBQn4=;
        b=UE3+aEDhAPEFOrPIVOyHuPSpfMEeB7OWAjumxSQQYFO4piBrJyp9fE4cuY+JhZMtue
         xUjkIwFyp+4ZlHv/4hB9RfPxwfXZrZ05hCoOWC/tJe4D/oRg49k/uSW8ysAtmZvdKcUP
         JbZGh2KW7fenI+ja7hxtm7rOTPSLkap+UQ+LlVb457MBcLdCeYqTfr3uDgvrw/3dVctI
         CksIifEzhOWxY2Jc8kguT7MifDRgVTQtA7R3Al0b5/ZUeCG16qT/3tD//yuCoBrFb78a
         KBH3Dno3dzVpxYATkLLyGzZggDXr5W37g0nR/+EvWvinEVG3Ho7auRPQWTtAkImeIJa1
         WCPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHkOGvWLIPUoRaHUi4v2QcFMWHAl1lkevd46iH5SSSSURLJV15uSUdXH+wcSvuGxbmXPawPQl0xuzWdSQf6tjOXeSkQltyMnSBrmXh6jSkWA==
X-Gm-Message-State: AOJu0YxIzgpAxGDWm/32ghPbNJGY/FgfCtXK9yqpxocrE1l8wxcNOz+5
	rlUXd4hsTlKTvvkptd5xUsB/Wlb0E1rJE6sJ5K2nERJRr7mvQnJFcmnw2utBpT83lZFxwqOOhmi
	NtzJTOWGlEYCPTJZyiKuku4BR54qBM4vgQkO4
X-Google-Smtp-Source: AGHT+IHWa3ie9Q2PNThh8ofQ9H8dtp0S/XjFcJgO/021VlJ48CH8lxwBbO7gPRgQ4MD6TOY1mSNEoi6JZ+e8wyYUvxs=
X-Received: by 2002:a17:902:e546:b0:1fb:172a:f3d4 with SMTP id
 d9443c01a7336-1ff3784b8abmr3152005ad.8.1722358728382; Tue, 30 Jul 2024
 09:58:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729181931.2870851-1-irogers@google.com> <ZqkWoQEyJcU5xBZG@google.com>
In-Reply-To: <ZqkWoQEyJcU5xBZG@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Jul 2024 09:58:27 -0700
Message-ID: <CAP-5=fUcuG7M6R80uwviwP2j62KDceDRRQM=Qf721bPBK1KYWg@mail.gmail.com>
Subject: Re: [PATCH v2] perf cap: Tidy up and improve capability testing
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Leo Yan <leo.yan@linux.dev>, Changbin Du <changbin.du@huawei.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 9:36=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Jul 29, 2024 at 11:19:31AM -0700, Ian Rogers wrote:
> > Remove dependence on libcap. libcap is only used to query whether a
> > capability is supported, which is just 1 capget system call.
> >
> > If the capget system call fails, fall back on root permission
> > checking. Previously if libcap fails then the permission is assumed
> > not present which may be pessimistic/wrong.
> >
> > Add a used_root out argument to perf_cap__capable to say whether the
> > fall back root check was used. This allows the correct error message,
> > "root" vs "users with the CAP_PERFMON or CAP_SYS_ADMIN capability", to
> > be selected.
> >
> > Tidy uses of perf_cap__capable so that tests aren't repeated if capget
> > isn't supported, to reduce calls or refactor similar to:
> > https://lore.kernel.org/lkml/20240729004127.238611-3-namhyung@kernel.or=
g/
>
> I'm not familiar with the capability so it's hard to review the code but
> it'd be better to split the code for perf_cap__capable() and its usage.

There's an API change, passing the out arg if root checking was used,
so this would turn into a mess.

> > ---
> > v2: fix syscall number and '>' should have been '>=3D'
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Makefile.config  | 11 -------
> >  tools/perf/builtin-ftrace.c | 44 ++++++++++++--------------
> >  tools/perf/util/Build       |  2 +-
> >  tools/perf/util/cap.c       | 63 ++++++++++++++++++++++++++-----------
> >  tools/perf/util/cap.h       | 23 ++------------
> >  tools/perf/util/symbol.c    |  8 ++---
> >  tools/perf/util/util.c      | 12 +++++--
> >  7 files changed, 81 insertions(+), 82 deletions(-)
[snip]
> > --- a/tools/perf/util/cap.c
> > +++ b/tools/perf/util/cap.c
[snip]
> > +bool perf_cap__capable(int cap, bool *used_root)
> > +{
> > +     struct __user_cap_header_struct header =3D {
> > +             .version =3D _LINUX_CAPABILITY_VERSION_3,
> > +             .pid =3D getpid(),
> > +     };
> > +     struct __user_cap_data_struct data[MAX_LINUX_CAPABILITY_U32S];
> > +     __u32 cap_val;
> > +
> > +     *used_root =3D false;
> > +     while (syscall(SYS_capget, &header, &data[0]) =3D=3D -1) {
> > +             /* Retry, first attempt has set the header.version correc=
tly. */
> > +             if (errno =3D=3D EINVAL && header.version !=3D _LINUX_CAP=
ABILITY_VERSION_3 &&
> > +                 header.version =3D=3D _LINUX_CAPABILITY_VERSION_1)
>
> It seems you can just check it with _VERSION1.

Similarly not familiar. Basically there used to be a data struct of 3
u32s in v1, v2 shouldn't exist, v3 turned the data from an array of
structs of size [1] to [2]. v3 has been present for 16 years as shown
by its magic number 0x20080522 (v2.6.26 iirc - can't find the comment
again). It seems a pretty safe bet that v3 is the version being used.
In old kernels if the versions don't match they just return EINVAL and
you have to try again like this loop:
https://fossd.anu.edu.au/linux/v2.6.14/source/kernel/capability.c#L43
```
if (get_user(version, &header->version))
  return -EFAULT;

if (version !=3D _LINUX_CAPABILITY_VERSION) {
  if (put_user(_LINUX_CAPABILITY_VERSION, &header->version))
    return -EFAULT;
   return -EINVAL;
}
```
So testing v3 is almost certainly what we want, what's going to work
and avoids a loop. In newer kernels the EINVAL isn't returned for a
mismatch and the code just does the right thing for whatever version
is requested.

> But I'm not sure about what this code does.  Who set the version
> correctly?  Is there any chance for an infinite loop?

The system call could return EINVAL with _LINUX_CAPABILITY_VERSION_1
and set the header.version to _LINUX_CAPABILITY_VERSION_1 again and
return EINVAL again, the kernel would be broken but it would lead to
an infinite loop.

Thanks,
Ian
