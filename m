Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0340E218584
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 18:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753294892; cv=none; b=T8HHZjfXgm7AQJiE0+c+8PBZDQwn6jal/imfx+6om0cR93bRm8pwQr5pd7/7yxA3N44AUErfB2KSDbQeYMVR4kplVSH/wNgEir+NMmRq6ujHkyZENnEB2iXE0kcNG3cdVwjyO8i7/rKba7zY5pDC3oQKWOVbqajvwAcLMXnY63E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753294892; c=relaxed/simple;
	bh=x/f9IRuutxykfXqdhJQOESHNxKfFRj+OQF7+8Xsi5iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxVY+SJ7xnIu2FUQGlPa2p7NUO+GqCEG8pMx/QeXRnoJ4QmDjhZlRgL7koQQOSD9Hos7xbPsnt95X5XRmJ6YKc1ngn3n2BNGxPZ59Y+6FBavLBKT5XEj6WKXJIAqioIdqRpA97Ng1XzH04ML4fMDFI5D8wmtCqgx0oBNqOZ4fxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KyKzs9QZ; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KyKzs9QZ"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3e283b2d065so25035ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 11:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753294890; x=1753899690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZ1mEiwCWRTYXkSoTNUc0GD/vI93aJ+12BCapC+1BjI=;
        b=KyKzs9QZFijiU12NfaAV4399RE9t29oM4+xtAN75dIlZ9A9oDoN1NPD/qL8sjdpZv2
         CBboGDJhdN6jAVQBGlP1oz3F+wAd5114/9M0sYd+NoGkeJjSZdhhAol9qjtmnH7EubTk
         GSAy1VXmn1BPb1DhPr0mm5SEJIp8I7sVNSbo8SRHCem7y9MbYBNYafPfY+GvZVBFL102
         uirotl0BofF/GcQKiKr6X/uezcMwqBhb7MXV/JIWZip4ZMBGhArDhkQ49IMim9tZuE/K
         yCxeXAO6uFgjs7Dt/PnOXE3UgXtlmddsKtCbak77JKBcEQcnVcHOjpqWrXHD83sp1Olt
         5ROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753294890; x=1753899690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZ1mEiwCWRTYXkSoTNUc0GD/vI93aJ+12BCapC+1BjI=;
        b=NJqXN13RuXV6h1dc/mN7OZK0UgStASnerbo7BDCHyXKYS3WIEjTNz7zpSGZvrK5U8D
         3Zs20hZO/g/0vukCM5MlKtVvbUv3yTHGFzeW5u8WSR0xctiBfs2ymY1u3oe4E3ul4iqV
         ptnhe3qgmudFddi+lD2qIGIINUeXQno7xfmpMJyGrNCa0aYVDmU/xvRdEMLKCEzoIDL0
         aEUsDElENc8u4mN/p+8ClWaidC5Vlv+6FESlNySbGRiDEjA8mI6rC2hs05ZXNhK48oCG
         Amuo5z5V1fuZyMIf3rbJLRwgqBVobDiDGKSWv+A2SkYu8mxgJjez+io/XNSZDHEfgfLK
         EK8g==
X-Forwarded-Encrypted: i=1; AJvYcCWvRd6RxP3N/h6Yr965NAg9JW4O3orT5vftzWPIdHdLBMlS00izwcyFgDEq13Ht6e+atskGB0vvWPqRWr0P7smP@vger.kernel.org
X-Gm-Message-State: AOJu0YyU3TOd8GbHRymRMVFjxv4V5Vq/JCntoLf1GMW1Mwdfu68aJHJE
	aG4HBKE1+StJkX8jaOX8E5eJzgqaDFhtpEU86xE5sap6kOZarZrCMtPu//kUFWS1JvSFofLl9Yh
	fJgYF3qIufZkHs/4bB7a962ksOPo95TFtVbixx6Sz
X-Gm-Gg: ASbGnctEfS0VEbpy6Sm9sK8sOgJaa4mfS0VX4jkjRtkpGHtk7Mci5cosbVeUE3iwLxQ
	kpzh6BoML44HQzH1qQvjD2z50bP1BdmG0yRrriA5jGOqKqiMjJz+tSk6q0rbac2hu3rKjgbPwwU
	4OmZZJRY73IRb4b0Qd/WmQ6e2fxQjoxe2lC0gFRLR4QiZlb5dQIiysGzIzGTZqLtzB5/GjoUgWI
	RMxb5HMJNbmW0ZjLVtJubnYDHLQ1qsdaSt+
X-Google-Smtp-Source: AGHT+IHqmXfCM/EX0UmPWRDWW0pZtA/fTrJTv/qu9dbk1MufwPFd2Dkshn9UT6yLQfswZ6HMg5S/ms+kgNYYEyYUXEc=
X-Received: by 2002:a05:6e02:378f:b0:3e2:c639:8279 with SMTP id
 e9e14a558f8ab-3e3b64c0974mr266085ab.20.1753294889714; Wed, 23 Jul 2025
 11:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com> <20250714164405.111477-2-irogers@google.com>
 <aIEmK1Ekly_HUJvV@google.com>
In-Reply-To: <aIEmK1Ekly_HUJvV@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Jul 2025 11:21:18 -0700
X-Gm-Features: Ac12FXzL_ebj06u9FHjMPYfp1dXDwRW9s3Yop9iiUU4T-Uxt6PSsK3CaksJYluE
Message-ID: <CAP-5=fWQQoo9OQhiQEyAGvUm-LVs7vpkbvEdnw7OO+KGBXiHqA@mail.gmail.com>
Subject: Re: [PATCH v7 01/16] perf python: Add more exceptions on error paths
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 11:13=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Mon, Jul 14, 2025 at 09:43:49AM -0700, Ian Rogers wrote:
> > Returning NULL will cause the python interpreter to fail but not
> > report an error. If none wants to be returned then Py_None needs
> > returning. Set the error for the cases returning NULL so that more
> > meaningful interpreter behavior is had.
>
> It looks like you are adding error messages for the failure cases, not
> adding new exceptions, right?  IIUC returning NULL in pyrf_event__new()
> ends up having PyErr_NoMemory().  Then now it has different messages?

This change doesn't alter the exception if there already is one. There
are lots of cases where NULL is being returned for an error but that
causes the python interpreter to fail/crash. This patch is just adding
the exceptions and still returning NULL, previously set exceptions are
left alone. With the exceptions returned the python interpreter does
something more useful than fail/crash :-)

> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/python.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > index 2f28f71325a8..02544387f39d 100644
> > --- a/tools/perf/util/python.c
> > +++ b/tools/perf/util/python.c
> > @@ -475,13 +475,19 @@ static PyObject *pyrf_event__new(const union perf=
_event *event)
> >       if ((event->header.type < PERF_RECORD_MMAP ||
> >            event->header.type > PERF_RECORD_SAMPLE) &&
> >           !(event->header.type =3D=3D PERF_RECORD_SWITCH ||
> > -           event->header.type =3D=3D PERF_RECORD_SWITCH_CPU_WIDE))
> > +           event->header.type =3D=3D PERF_RECORD_SWITCH_CPU_WIDE)){
> > +             PyErr_Format(PyExc_TypeError, "Unexpected header type %u"=
,
> > +                          event->header.type);
> >               return NULL;
> > +     }
> >
> >       // FIXME this better be dynamic or we need to parse everything
> >       // before calling perf_mmap__consume(), including tracepoint fiel=
ds.
> > -     if (sizeof(pevent->event) < event->header.size)
> > +     if (sizeof(pevent->event) < event->header.size) {
> > +             PyErr_Format(PyExc_TypeError, "Unexpected event version: =
%zd < %u",
>
> Maybe "Unexpected event size" instead?

I think size is more accurate to the code, version is more useful to
the user. I believe there is existing use of the event size being used
as a quasi version number, so I think this description is consistent.
If you feel strongly I can change it.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +                          sizeof(pevent->event), event->header.size);
> >               return NULL;
> > +     }
> >
> >       ptype =3D pyrf_event__type[event->header.type];
> >       pevent =3D PyObject_New(struct pyrf_event, ptype);
> > @@ -1199,8 +1205,10 @@ static PyObject *pyrf_evlist__read_on_cpu(struct=
 pyrf_evlist *pevlist,
> >               return NULL;
> >
> >       md =3D get_md(evlist, cpu);
> > -     if (!md)
> > +     if (!md) {
> > +             PyErr_Format(PyExc_TypeError, "Unknown CPU '%d'", cpu);
> >               return NULL;
> > +     }
> >
> >       if (perf_mmap__read_init(&md->core) < 0)
> >               goto end;
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >
