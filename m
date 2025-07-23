Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6340B273D65
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753309461; cv=none; b=Rb0A/V1vkLUF9rePr7TiIcAs6VYp92ySulaMHw5O7MAXChPBSlBz0lk+1068mP6z5sdqmmbeWhEWpTyHTzcscyC5bix6/PBw6RYFT3RDKUuCiajB8d8pLppZtPDRJ62FY/oTVFYr67+UmCZMsxkk3HzBEaY7jyh36P2mXR8V+uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753309461; c=relaxed/simple;
	bh=QZl+aj0jdfz6G6uJ4x4gxugiCYDMM6YaxpQVndTOsVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0DMt7E1lHUWbnZksEHVDp6VlOQw2hJCbXoJCmDUKTFaUccqiSC5s6VvptPDiZPpkP63pQP5HpWsKt6i4cXRznZcwVGF4Cy+db4F/OaKfussPjY+m2q9GZq8nbRgJQXb82a65GmURSMjxc2r64N+ryCx99Td1YIgOwOXOxYf0U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tBRVQMBV; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tBRVQMBV"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3df371e1d29so36145ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 15:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753309456; x=1753914256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/c99hzy9f0/KLwI1t6QNyCBJcre+wNLwofDjJBXPRs=;
        b=tBRVQMBVDVjHZQO261cR0AGgNoCGZKKiZCtMkIfxfVA7geCSuWyl0XO3D3Zz0KhWYI
         1loJnpMrDZrOrvsE6xkC5299meRBsXRniUcNEFuNCf/Xh+naWh2S2ZuLGEe2ZDKmHBIJ
         F6cOZW0QQjkW2N4IT/ugytMK57drmMgn/R5tp/NJaKhKTr9p1SrLHhuwCldS4YKEzpAy
         2K77QOIj0rKW5Q/ULR3Uym5TT3q1m9jayoQMt3cDHcPWCtboAlxXVMZIQ5+WNTPeRxG/
         OYCe/KbDiFDRj/CmcigHxcP7IbqagLTd9Rt52uVLY2AxxNLgEUQIaZ0DH0NX0NYMrt/O
         fGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753309456; x=1753914256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/c99hzy9f0/KLwI1t6QNyCBJcre+wNLwofDjJBXPRs=;
        b=QKyBJR/lq2dxAjvdi9Ns+duIo0u76fx3+kY3tlMCaTFztD8BQeQlZ3fSWZpenzJgvZ
         xRba3CjjBRXqVM+z1QtsF64KDdBPhdFBa5ddJo+mRU2ygInM0uRo5dA7cRp1me4OqwBs
         Hy4FUU89OK86GftgzTbnPio2mSMpw/hOMxrsJ53xSKOcMbrOnzLsVXduc9xG5iFMMPPX
         7aDu930ebbWU8+BfOry2GX1SFN5uR1tJ04HQiwaon9bCrHYVsOOITZ5SV4nHdo0PidPN
         IyO56GH9urj6rROvxTMXZtlU8/uff62vYTrmWIoOuJxwVcT3bprttaIbGDz1aR/k47g1
         u//g==
X-Forwarded-Encrypted: i=1; AJvYcCXkp+7l//EilCbE7IXanKf/AEvF89g52pVvCRN9mQj+z7ptdIujLiR4bRXin6/JqqG6wdKFz5bag/6XH8u0IwxR@vger.kernel.org
X-Gm-Message-State: AOJu0YxDuQcRfWR+a2vomncIcDYqcirxShLzqHHij0rgfY8+s4edTBr2
	TahT7j2dXIB1jAutancSaVkY54wtW7cZJTre3K3CoZJdpfBp2tqm/mgQ5P61CM4KkWyOdg3dRA7
	WLUvvMgwMdtzrg6tc2ebJ1/U3eI0Rx7B7No3dL+X4
X-Gm-Gg: ASbGncssIr7oylREb9tPwQgVRYmpxJPZSx+BI1lsdgNvq6c18Ue31+oG5UNFhSoq6TI
	3BZldTxilwMFFmrrNfLuRyUezfSB8Q8czKBC7ChaZnM0TpnYGVAR/Arq4FMdLEt40xDl5fWD/fE
	8DeWQPdbBtXvjqlo5EuUBKrpUXmloyBrgq5JMV7PSe5xvfWEu1FtSM6ve+f/ZMUzcO36XwbZ/TQ
	6D1mOVeHFWzAmA1TmfI+Ds3j1RQkkTxcupe
X-Google-Smtp-Source: AGHT+IEKdVNnHlUVJYqAzTrXSgC3eTihvKZPzpz9CHNj/OkdLzBJoUrZGNaFlqwcJY3jwVvyx6LDsWnsl6B0Ho91vJY=
X-Received: by 2002:a05:6e02:3f0d:b0:3e3:a51f:dd71 with SMTP id
 e9e14a558f8ab-3e3b740b1eemr532755ab.27.1753309456145; Wed, 23 Jul 2025
 15:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com> <20250714164405.111477-2-irogers@google.com>
 <aIEmK1Ekly_HUJvV@google.com> <CAP-5=fWQQoo9OQhiQEyAGvUm-LVs7vpkbvEdnw7OO+KGBXiHqA@mail.gmail.com>
In-Reply-To: <CAP-5=fWQQoo9OQhiQEyAGvUm-LVs7vpkbvEdnw7OO+KGBXiHqA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Jul 2025 15:24:04 -0700
X-Gm-Features: Ac12FXxB9xzulQIVtlmJKWbQTIWlguHhPzyoltH2j09OZqPzlCdKAEB6-uylqtU
Message-ID: <CAP-5=fVy1bMvMOWSKom10ivTbP_+baWk1=N7jjr4ye+LbM+bbQ@mail.gmail.com>
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

On Wed, Jul 23, 2025 at 11:21=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Wed, Jul 23, 2025 at 11:13=E2=80=AFAM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> >
> > On Mon, Jul 14, 2025 at 09:43:49AM -0700, Ian Rogers wrote:
> > > Returning NULL will cause the python interpreter to fail but not
> > > report an error. If none wants to be returned then Py_None needs
> > > returning. Set the error for the cases returning NULL so that more
> > > meaningful interpreter behavior is had.
> >
> > It looks like you are adding error messages for the failure cases, not
> > adding new exceptions, right?  IIUC returning NULL in pyrf_event__new()
> > ends up having PyErr_NoMemory().  Then now it has different messages?
>
> This change doesn't alter the exception if there already is one. There
> are lots of cases where NULL is being returned for an error but that
> causes the python interpreter to fail/crash. This patch is just adding
> the exceptions and still returning NULL, previously set exceptions are
> left alone. With the exceptions returned the python interpreter does
> something more useful than fail/crash :-)
>
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/python.c | 14 +++++++++++---
> > >  1 file changed, 11 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > > index 2f28f71325a8..02544387f39d 100644
> > > --- a/tools/perf/util/python.c
> > > +++ b/tools/perf/util/python.c
> > > @@ -475,13 +475,19 @@ static PyObject *pyrf_event__new(const union pe=
rf_event *event)
> > >       if ((event->header.type < PERF_RECORD_MMAP ||
> > >            event->header.type > PERF_RECORD_SAMPLE) &&
> > >           !(event->header.type =3D=3D PERF_RECORD_SWITCH ||
> > > -           event->header.type =3D=3D PERF_RECORD_SWITCH_CPU_WIDE))
> > > +           event->header.type =3D=3D PERF_RECORD_SWITCH_CPU_WIDE)){
> > > +             PyErr_Format(PyExc_TypeError, "Unexpected header type %=
u",
> > > +                          event->header.type);
> > >               return NULL;
> > > +     }
> > >
> > >       // FIXME this better be dynamic or we need to parse everything
> > >       // before calling perf_mmap__consume(), including tracepoint fi=
elds.
> > > -     if (sizeof(pevent->event) < event->header.size)
> > > +     if (sizeof(pevent->event) < event->header.size) {
> > > +             PyErr_Format(PyExc_TypeError, "Unexpected event version=
: %zd < %u",
> >
> > Maybe "Unexpected event size" instead?
>
> I think size is more accurate to the code, version is more useful to
> the user. I believe there is existing use of the event size being used
> as a quasi version number, so I think this description is consistent.
> If you feel strongly I can change it.

Actually I was thinking of the attribute size, let me fix this.

Thanks,
Ian

> Thanks,
> Ian
>
> > Thanks,
> > Namhyung
> >
> >
> > > +                          sizeof(pevent->event), event->header.size)=
;
> > >               return NULL;
> > > +     }
> > >
> > >       ptype =3D pyrf_event__type[event->header.type];
> > >       pevent =3D PyObject_New(struct pyrf_event, ptype);
> > > @@ -1199,8 +1205,10 @@ static PyObject *pyrf_evlist__read_on_cpu(stru=
ct pyrf_evlist *pevlist,
> > >               return NULL;
> > >
> > >       md =3D get_md(evlist, cpu);
> > > -     if (!md)
> > > +     if (!md) {
> > > +             PyErr_Format(PyExc_TypeError, "Unknown CPU '%d'", cpu);
> > >               return NULL;
> > > +     }
> > >
> > >       if (perf_mmap__read_init(&md->core) < 0)
> > >               goto end;
> > > --
> > > 2.50.0.727.gbf7dc18ff4-goog
> > >
