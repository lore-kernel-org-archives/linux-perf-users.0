Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6BE26F2BE
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jun 2026 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782482074; cv=pass; b=QCPXjByhl+MZXT7Yk8peTFn3/aJWcDgpmloKkxxs7YIB0PJ2sZ+Kj/6qUjhO9kN85GvpUKEkXJ0bfSuCSYKXpFnDhNkmeuRHvT7ggb7cQieBprtd0IXUXzB8M+0PTdUkRLLJHZcJhL8WCCLvyhrnoAg1pc6ryHlkvgmIFZwERQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782482074; c=relaxed/simple;
	bh=2kujxcsx4SBcTF16/vnx9rx10+HFQ9s0MPTG4nlD3x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gCJ+x0LBadMnBymq6q2kYJeFmL781TtHkOQYMeHuESpi+L1iRmvoOOvgpLKtveFgQCgVW96DpBsvjTF+77jmOG+bdl+PJxyeN2hyrAMGs0mM+ncpjY0oazHjRQntJctBaaqfcbIcK/hVFMA0CRWTpaEMjsU9dgT8rQY88ABiKrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TT1s5t2I; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT1s5t2I"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8cc0ef7c306so10084966d6.3
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Jun 2026 06:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782482071; cv=none;
        d=google.com; s=arc-20260327;
        b=j2faIei4H/ANpE4R69rl6ciQLtOsBbfB/tX3Y/p7ZW4L/emi1IDS6rBNO+OgzMu/EH
         fOcbIJfJ/GofcYOVmeiQY+ApBNbnRscnUzrbwFcnyNVCZ6S1V64pf/RwGbBCneXqQNnQ
         WHbGsGTkijJu7uV7+GCZPemLSf7wXmDf7Q1xd/fZvxY5Jaky0HImtPotZ7HAd0kp4j+V
         DSmyA0o0I2z6VS6O7v07J5qEhFbr/W4OgzT7Fo888aedzCib7xRGdIKeAN3UsLqISYnr
         yXV13Obvt/1BSHKBr/7CxjszmAo1YKCKba9KhHdgCEx0364cfBzuRKxT3JCZW6kKYVUM
         J5tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VjHNiP0IoRwlBG7ewKYx5rusZ8lcYYfVVLXImxvlHaA=;
        fh=J/o4ro8HCPDj8spy4H/O0qnVXZ9BwjimlvMqTrRAaws=;
        b=AaBYPNFfmj4Sohi+EoDaz5qY9WH8vKrps+RMR2kaWL/rrWYsmwbV+AEW7XX/jGaacc
         X1iWyl+oOu3vG7WbtIzt0MOWQGnGX3BQPGgd+HRJIj8t7atDPlcJBfqhxWME9Xo6UIXf
         QtfXoBG8QIMY0p9sUw9TolPLnNmgudkoZqJtR7E7hHAoPJ9Fq3I0hFteJtNy1W+0di9y
         PJ9BoRE9o/1HRXNUbXeZiXGJ7rFOEywKbM1K1rQr+vvu2khMptqa+kAmbR5RX0IBFOTR
         oqDwRI0EQbM7z+rYTi/0jEwtgcmB+iGVGJQ4cswsOQzIxiizU4GKmnZtn5wyCbDRrbH2
         n6wA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782482071; x=1783086871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjHNiP0IoRwlBG7ewKYx5rusZ8lcYYfVVLXImxvlHaA=;
        b=TT1s5t2IU9+Tupjs+kUPHzL+pOfwb4yhqxVi5QJ+cpjgvnyLO8JPnj9HLeJSjqNkPI
         5Ws6uFVdYWs4QqQrjF15lLS5wt0X6h+CoX9nwKW/xvIWjbEb5yvbTk2HFbS1BOgq9oxJ
         37+1D9IBlLqWTQ7+zKwH3SDV5DQcvzXdS7MOkbcWQ7EdXRtp2KuIWoibLXoTYLEFdbQT
         5stVxEs7KOBgz/qp1tZO4mgVF4ynQayGIXbnouj0pv8Dz8uh8F1AbcnVYUpm8kMla+rd
         gqlEcOjmZIRboWl8MlLyzBn0arxgJFLtCU/iSeZmxcPLP9uhw/qlGpAo0ce3dRHoyRec
         h8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782482071; x=1783086871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VjHNiP0IoRwlBG7ewKYx5rusZ8lcYYfVVLXImxvlHaA=;
        b=fTCB9AXT1hNcTsMTLEfI+T7GaGoBdC65uKw+hTGFkMWKoo/KuPtfHvnsm6kVuio2cL
         QPIkS+XuTk7Z30MguU3W5/NdmZgx4rsLbonxp52c1PHsWyqemfLKzUsFq09edRs/rEdS
         QOX2OvNs7TtflMooyXLia3/nWxAHqpBtwZIrvjpREcL3DMsQ8kClbOta5Rcyf1c+G0X+
         5X71sTDZ29+mqh6ujgVCXGNQ6shi7gArTjfw795DoiNGezLDwK9GJm7q6mICYutS3vaZ
         YJTyNlo7VEjw/bed+ygJTtdlQAP02VLeeO2lwE1tL2ol8DGfFrJo2Tvj9tsgnTPsaIX4
         ZXdw==
X-Forwarded-Encrypted: i=1; AHgh+RoeWmZyCfjK5qMA5yCuvqmAhqAO4nR0hdOGP7IHqEiN3JNEp7q1sd17m1TDQUIl4Q6OCJJOQ39gd+d4akOiCAMS@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd8X8Gp2Wz8KyazrVZP1iyLkql+8+xXFvV/LfncA7iRMrS459Z
	znlza7jP91VSKbi0G1X5n0DnkUWq4jLwSyvrMFFCUjnFIQ7sj/G1r4Hvgnnh9UvQMsCiRkVL9cv
	JzfHX8G2n2yWvYMLe/yVW8bPwzqkRi+Q=
X-Gm-Gg: AfdE7cm4e/HZywUFxuJBj0amlETmd97aRVUDcI3dVsPYzgvxT2xtck21ptLdPGhB1a+
	phVtpacaVLbhSKzvWXlB0VmWP0MPKw7A6w20DUiI2z5sO47M3mgWrT+GHa00aTO0GuIn+Qsa3E+
	Cpe+uBnxG/U3lhtbdW0++n5Khob8bA8ag6T9fCrhUpHgoNSS082s5it7rNzTBZP87dUz9cjkxEY
	XneBIjHWt6LcAmjHHDPOeQC/wvliZya6vT4kSsPeeh0y2B8AUaJCA+iDkSqygr94+ko7pcQUhJ4
	i8RVwvUa9wlMEw/ZHMbFDwCR
X-Received: by 2002:a05:6214:3213:b0:8db:1179:d180 with SMTP id
 6a1803df08f44-8e6d8103a36mr123617816d6.23.1782482071286; Fri, 26 Jun 2026
 06:54:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622134933.35773-1-akinobu.mita@gmail.com>
 <20260622134933.35773-2-akinobu.mita@gmail.com> <CAP-5=fVyAskTbcB-pJbcNChq8GJnQ_098EfsnZzcO7O9A-8x4g@mail.gmail.com>
In-Reply-To: <CAP-5=fVyAskTbcB-pJbcNChq8GJnQ_098EfsnZzcO7O9A-8x4g@mail.gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Fri, 26 Jun 2026 22:54:20 +0900
X-Gm-Features: AVVi8CdklkvDlugov6HgfVnIoohUA6wCsjPFgkazexlVbIHTJ002frAvg-Q5_n8
Message-ID: <CAC5umyj6jXucmjUa2c-QMVxMZMV8wskzzcBAGTm4+C_HtuBTNw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] perf python: Add access to various members of evsel
To: Ian Rogers <irogers@google.com>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org, sj@kernel.org, 
	ravis.opensrc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B46=E6=9C=8824=E6=97=A5(=E6=B0=B4) 3:10 Ian Rogers <irogers@goog=
le.com>:
>
> On Mon, Jun 22, 2026 at 6:57=E2=80=AFAM Akinobu Mita <akinobu.mita@gmail.=
com> wrote:
> >
> > This change is necessary to specify the same PMU event selection as the
> > 'perf record' -e option from DAMON's userspace tools.
> >
> > For example, a Python script like the following will allow you to obtai=
n
> > the values to be set in the type, config, config1, and config2 members =
of
> > perf_event_attr by providing a symbolic event name.
> >
> > import perf
> >
> > if __name__ =3D=3D '__main__':
> >     evlist =3D perf.parse_events("cpu/mem-loads,ldlat=3D30/P")
> >     for evsel in evlist:
> >         print(f"{evsel}: type=3D{evsel.type} config=3D{evsel.config}",
> >               f"config1=3D{evsel.config1} config2=3D{evsel.config2}")
> >
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>
> Thanks Akinobu! I agree we should expose more parts of the evsel
> through the perf python API. I refactored this area recently so that
> we could better support perf.data file usage (the session API).
> There's a long series here that is merged enough to mean these changes
> will need a refactor too:
> https://lore.kernel.org/lkml/20260419235911.2186050-1-irogers@google.com/
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/python.c?h=3Dperf-tools-next#n2449
>
> The main change I made was avoiding copying evsels in the python API,
> as it adds many complications, and switching to reference counting.
> This means the Python `evsel` can no longer directly access inner
> variables and now requires an indirection. So in:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/python.c?h=3Dperf-tools-next#n2290
> ```
> static PyObject *pyrf_evsel__get_attr_config(PyObject *self, void
> *closure __maybe_unused)
> {
> struct pyrf_evsel *pevsel =3D (void *)self;
>
> CHECK_INITIALIZED(pevsel->evsel, "evsel");
>
> return PyLong_FromUnsignedLongLong(pevsel->evsel->core.attr.config);
> }
> ```
> Note how it is `evsel->core` rather than `evsel.core` as it was before.
>
> I believe you can copy-paste the code and tweak it for config1 and
> config2, but I'm afraid the previous evsel_attr_member_def approach
> won't work.

Thank you for letting me know.
I think I will be able to handle it once those improvements are merged.

> Thanks,
> Ian
>
> > ---
> >  tools/perf/util/python.c | 50 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > index cc1019d29a5d..3f108b405ee3 100644
> > --- a/tools/perf/util/python.c
> > +++ b/tools/perf/util/python.c
> > @@ -1241,11 +1241,60 @@ static PyMemberDef pyrf_evsel__members[] =3D {
> >         evsel_attr_member_def(sample_type, T_ULONGLONG, "attribute samp=
le_type."),
> >         evsel_attr_member_def(read_format, T_ULONGLONG, "attribute read=
_format."),
> >         evsel_attr_member_def(wakeup_events, T_UINT, "attribute wakeup_=
events."),
> > +       evsel_attr_member_def(config1, T_ULONGLONG, "attribute config1.=
"),
> > +       evsel_attr_member_def(config2, T_ULONGLONG, "attribute config2.=
"),
> >         { .name =3D NULL, },
> >  };
> >
> >  static const char pyrf_evsel__doc[] =3D PyDoc_STR("perf event selector=
 list object.");
> >
> > +static PyObject *pyrf_evsel__get_freq(struct pyrf_evsel *pevsel, void =
*closure)
> > +{
> > +       return PyLong_FromLong(pevsel->evsel.core.attr.freq);
> > +}
> > +
> > +static PyObject *pyrf_evsel__get_exclude_kernel(struct pyrf_evsel *pev=
sel,
> > +                                               void *closure)
> > +{
> > +       return PyLong_FromLong(pevsel->evsel.core.attr.exclude_kernel);
> > +}
> > +
> > +static PyObject *pyrf_evsel__get_exclude_hv(struct pyrf_evsel *pevsel,
> > +                                           void *closure)
> > +{
> > +       return PyLong_FromLong(pevsel->evsel.core.attr.exclude_hv);
> > +}
> > +
> > +static PyObject *pyrf_evsel__get_precise_ip(struct pyrf_evsel *pevsel,
> > +                                           void *closure)
> > +{
> > +       return PyLong_FromLong(pevsel->evsel.core.attr.precise_ip);
> > +}
> > +
> > +static PyGetSetDef pyrf_evsel__getset[] =3D {
> > +       {
> > +               .name   =3D "freq",
> > +               .get    =3D (getter)pyrf_evsel__get_freq,
> > +               .doc    =3D PyDoc_STR("freq"),
> > +       },
> > +       {
> > +               .name   =3D "exclude_kernel",
> > +               .get    =3D (getter)pyrf_evsel__get_exclude_kernel,
> > +               .doc    =3D PyDoc_STR("exclude_kernel"),
> > +       },
> > +       {
> > +               .name   =3D "exclude_hv",
> > +               .get    =3D (getter)pyrf_evsel__get_exclude_hv,
> > +               .doc    =3D PyDoc_STR("exclude_hv"),
> > +       },
> > +       {
> > +               .name   =3D "precise_ip",
> > +               .get    =3D (getter)pyrf_evsel__get_precise_ip,
> > +               .doc    =3D PyDoc_STR("precise_ip"),
> > +       },
> > +       { .name =3D NULL, },
> > +};
> > +
> >  static PyTypeObject pyrf_evsel__type =3D {
> >         PyVarObject_HEAD_INIT(NULL, 0)
> >         .tp_name        =3D "perf.evsel",
> > @@ -1255,6 +1304,7 @@ static PyTypeObject pyrf_evsel__type =3D {
> >         .tp_doc         =3D pyrf_evsel__doc,
> >         .tp_members     =3D pyrf_evsel__members,
> >         .tp_methods     =3D pyrf_evsel__methods,
> > +       .tp_getset      =3D pyrf_evsel__getset,
> >         .tp_init        =3D (initproc)pyrf_evsel__init,
> >         .tp_str         =3D pyrf_evsel__str,
> >         .tp_repr        =3D pyrf_evsel__str,
> > --
> > 2.43.0
> >
> >
