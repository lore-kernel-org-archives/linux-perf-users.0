Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C23279799
	for <linux-perf-users@vger.kernel.org>; Thu, 22 May 2025 22:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747953180; cv=none; b=ZYUp26NJH734FrmaqFMoDvw1aCsRe04YPi2WdODRQmgo8xcJrC2mr+Eofw7tXrfXiCyahNlSonqNtfrGdfkg2gbaEfnqT+f5V8Fn1HcKqD2Gdc0ZSx9B2VjwPJQnqwG+I2/+HfG6C7Tir6PpBmUxbCc87ktArjeHftzqotGtXD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747953180; c=relaxed/simple;
	bh=DSj0JWO5RrhYzGO0QBnfZwAz8hQgZUwDb7KylG8IzGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E589o5q6kig6nKTWC4VLyr0y1gcXq8AAXFmDRmbIDQMwKAXWQHzI9h8gCaJ/JdA7MDD8KkfuXoMsE73IzV1rQFjhtQbzSuq85pqA+EWCNrMkeK7n/V1Ra8ZcJ3vgVT0UFv+nsWN8fW5fjPV4uT0kekg27E/yt4gB4f9q8Mt9GMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cCxdtNv3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cCxdtNv3"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-231f6c0b692so71695ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 May 2025 15:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747953178; x=1748557978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RmRB0fqSTOuTyY78I5eTVb85vo7bptv2pqd8FQvdRY=;
        b=cCxdtNv3VUQVShO3zoxZ1KQfgRri+eS4EORwb/KvEwpBZAMf63HtKrhIB8cFxX5+Rr
         MoBy7CZew5vvXKRGV6DDl01XoatgB5EfzxAm6Mg2cJU6eBPM6Jlis2rngdoM8VuXotCi
         40FxYHQKvRG3M/Zq+CDcgwfPyYvR8rf0kcJ8+xJiyMJJpFYSLEGWznuGcRYIszDZQfp3
         8mLmhYT7tr0E/5s2UDE8VePJqt3DELrcP/gj2B3GMPadEjjCWZoVdOLLmRqnkobbyUAY
         N3G7KKeloDb4tKIddbIZwwqIxljFPY+13PJodSFYKo/uRxbfVPOqMlbQHB34USBq9blU
         bPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747953178; x=1748557978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RmRB0fqSTOuTyY78I5eTVb85vo7bptv2pqd8FQvdRY=;
        b=Zn9patHeEq17W/peEMsafjAOAOnyafUbtciViQNDuTWD7NITntTQmkJSmu28JB4hIl
         zHTdREG34JK8RISlhxt6SYw54+9/Ciq45y/t5qRDBtkKvQLrVdMMi7+gRRSQRnPDj+Z5
         sjf5D0TDOfEVwj9NUVLICcIyT195jCEQWasZZTv2nu5SZnDrNOMoE17ZHBqDIwIRCsdB
         XFEjucojKs1uWyeYtsvPzo2FajfCDLQ64aGkYQQ9gIOt+662dEt4vGNsZhUVy++ck4EP
         a+SvOEa3ptn05Pu1l6GImebqUsb89mM0CnSamJRRqi3VhseTjUVcsPcDGiCCWrMH/+Mi
         UlUw==
X-Forwarded-Encrypted: i=1; AJvYcCUCIfPxnlq7/Fb9uVy+um5trXYBaQOmp8FrWA1tYN7lvvqfRHMyZp5NPWYrkVY5Pw+M+CkI9HE03vjaoXGdVBMh@vger.kernel.org
X-Gm-Message-State: AOJu0YxZFU4BufSjbO4mjZgcWg6zFo4evPoc7IjJLoxFk+kP3twWuMp2
	s61kjELC75H3mK+LOLWQ9qTZ7JvD/2kx7mVNbHED0OSwq92mZKCuAmqvOYp1Cy/LLih0it3IMjS
	jeVQ99fuSKO4PniZUIbr61XBH3V9hq6v+1iWaMGat
X-Gm-Gg: ASbGncu3YEpdPhLd+kxychmBeqXt7aCmFaUUxvqcrSXzLeIGIfMcAxrWA9PrBqsxv2n
	ntp8bqHDlQwIAqdD7MslQ0sAstWqpKoGDj1Dx0S3+fLGze23IDmpEeHdJHQW0dVvoLykSJc9Nmw
	aAc5Hycl/CKlvGvTTYl3Rdl+6rEuZVjEiVh6JHlJKAoEYfld4cXRvGQMTjBjNs0RlYRB6w1/jv
X-Google-Smtp-Source: AGHT+IE3MnhTu/78gELG+IyenO4eIP0fubMhBWb7snFDFsdyOkSdeuY/UxgDg61Z+cKSXoAFgTBmer4PiqQX2DA9cMg=
X-Received: by 2002:a17:902:d50e:b0:223:fd7e:84ab with SMTP id
 d9443c01a7336-233f32e6f22mr413555ad.24.1747953177521; Thu, 22 May 2025
 15:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519195148.1708988-1-irogers@google.com> <20250519195148.1708988-5-irogers@google.com>
 <aC-jR0b3mji4oJ7Q@x1>
In-Reply-To: <aC-jR0b3mji4oJ7Q@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 22 May 2025 15:32:44 -0700
X-Gm-Features: AX0GCFtN1Bvm75k1tWLq1Px3USKy8Q1nTbSOsheafjEiuvPYhPmskfhbEJhFRaY
Message-ID: <CAP-5=fXdpT3-=e4cqZN4fBJK1c4TnYC1ZVV5Q5zTjmf7T7Fffg@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] perf python: Add support for perf_counts_values to
 return counter data
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Gautam Menghani <gautam@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 3:20=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, May 19, 2025 at 12:51:41PM -0700, Ian Rogers wrote:
> > From: Gautam Menghani <gautam@linux.ibm.com>
> >
> > Add support for perf_counts_values struct to enable the python
> > bindings to read and return the counter data.
> >
> > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> > ---
> >  tools/perf/util/python.c | 92 +++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 91 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > index ead3afd2d996..1cbddfe77c7c 100644
> > --- a/tools/perf/util/python.c
> > +++ b/tools/perf/util/python.c
> > @@ -626,6 +626,92 @@ static int pyrf_thread_map__setup_types(void)
> >       return PyType_Ready(&pyrf_thread_map__type);
> >  }
> >
> > +struct pyrf_counts_values {
> > +     PyObject_HEAD
> > +
> > +     struct perf_counts_values values;
> > +};
> > +
> > +static const char pyrf_counts_values__doc[] =3D PyDoc_STR("perf counts=
 values object.");
> > +
> > +static void pyrf_counts_values__delete(struct pyrf_counts_values *pcou=
nts_values)
> > +{
> > +     Py_TYPE(pcounts_values)->tp_free((PyObject *)pcounts_values);
> > +}
> > +
> > +#define counts_values_member_def(member, ptype, help) \
> > +     { #member, ptype, \
> > +       offsetof(struct pyrf_counts_values, values.member), \
> > +       0, help }
> > +
> > +static PyMemberDef pyrf_counts_values_members[] =3D {
> > +     counts_values_member_def(val, Py_T_ULONG, "Value of event"),
> > +     counts_values_member_def(ena, Py_T_ULONG, "Time for which enabled=
"),
> > +     counts_values_member_def(run, Py_T_ULONG, "Time for which running=
"),
> > +     counts_values_member_def(id, Py_T_ULONG, "Unique ID for an event"=
),
> > +     counts_values_member_def(lost, Py_T_ULONG, "Num of lost samples")=
,
> > +     {NULL}
> > +};
>
> So the above is failing on a aarch64 debian (rpi5):
>
> acme@raspberrypi:~/git/perf-tools-next $ dpkg -S /usr/include/python3.11/=
structmember.h
> libpython3.11-dev:arm64: /usr/include/python3.11/structmember.h
> acme@raspberrypi:~/git/perf-tools-next $
>
> Where it only has:
>
> acme@raspberrypi:~/git/perf-tools-next $ grep -r Py_T_ULONG /usr/include/
> acme@raspberrypi:~/git/perf-tools-next $ grep -rw Py_T_ULONG /usr/include=
/
> acme@raspberrypi:~/git/perf-tools-next $ grep -rw T_ULONG /usr/include/
> /usr/include/python3.11/structmember.h:#define T_ULONG     12
> acme@raspberrypi:~/git/perf-tools-next $
>
> while on fedora 42 x86_64:
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ grep -rw Py_T_ULONG /usr/include=
/
> /usr/include/python3.13/descrobject.h:#define Py_T_ULONG     12
> /usr/include/python3.13/structmember.h:#define T_ULONG     Py_T_ULONG
> =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> So I'm making it use the T_ULONG and others as all the other PyMemberDef
> arrays in tools/perf/util/python.c, ok?

The fix makes sense to me. Checking the documentation it seems
Py_T_ULONG is preferred:
https://docs.python.org/3/c-api/structures.html#member-types
perhaps we can add:
```
#ifndef Py_T_ULONG
#define Py_T_ULONG T_ULONG
#endif
```
so that we use the approach matching the documentation while fixing
the RaspberryPi issue.

Thanks,
Ian

> - Arnaldo
>
> > +static PyObject *pyrf_counts_values_get_values(struct pyrf_counts_valu=
es *self, void *closure)
> > +{
> > +     PyObject *vals =3D PyList_New(5);
> > +
> > +     if (!vals)
> > +             return NULL;
> > +     for (int i =3D 0; i < 5; i++)
> > +             PyList_SetItem(vals, i, PyLong_FromLong(self->values.valu=
es[i]));
> > +
> > +     return vals;
> > +}
> > +
> > +static int pyrf_counts_values_set_values(struct pyrf_counts_values *se=
lf, PyObject *list,
> > +                                      void *closure)
> > +{
> > +     Py_ssize_t size;
> > +     PyObject *item =3D NULL;
> > +
> > +     if (!PyList_Check(list)) {
> > +             PyErr_SetString(PyExc_TypeError, "Value assigned must be =
a list");
> > +             return -1;
> > +     }
> > +
> > +     size =3D PyList_Size(list);
> > +     for (Py_ssize_t i =3D 0; i < size; i++) {
> > +             item =3D PyList_GetItem(list, i);
> > +             if (!PyLong_Check(item)) {
> > +                     PyErr_SetString(PyExc_TypeError, "List members sh=
ould be numbers");
> > +                     return -1;
> > +             }
> > +             self->values.values[i] =3D PyLong_AsLong(item);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static PyGetSetDef pyrf_counts_values_getset[] =3D {
> > +     {"values", (getter)pyrf_counts_values_get_values, (setter)pyrf_co=
unts_values_set_values,
> > +             "Name field", NULL},
> > +     {NULL}
> > +};
> > +
> > +static PyTypeObject pyrf_counts_values__type =3D {
> > +     PyVarObject_HEAD_INIT(NULL, 0)
> > +     .tp_name        =3D "perf.counts_values",
> > +     .tp_basicsize   =3D sizeof(struct pyrf_counts_values),
> > +     .tp_dealloc     =3D (destructor)pyrf_counts_values__delete,
> > +     .tp_flags       =3D Py_TPFLAGS_DEFAULT|Py_TPFLAGS_BASETYPE,
> > +     .tp_doc         =3D pyrf_counts_values__doc,
> > +     .tp_members     =3D pyrf_counts_values_members,
> > +     .tp_getset      =3D pyrf_counts_values_getset,
> > +};
> > +
> > +static int pyrf_counts_values__setup_types(void)
> > +{
> > +     pyrf_counts_values__type.tp_new =3D PyType_GenericNew;
> > +     return PyType_Ready(&pyrf_counts_values__type);
> > +}
> > +
> >  struct pyrf_evsel {
> >       PyObject_HEAD
> >
> > @@ -1475,7 +1561,8 @@ PyMODINIT_FUNC PyInit_perf(void)
> >           pyrf_evlist__setup_types() < 0 ||
> >           pyrf_evsel__setup_types() < 0 ||
> >           pyrf_thread_map__setup_types() < 0 ||
> > -         pyrf_cpu_map__setup_types() < 0)
> > +         pyrf_cpu_map__setup_types() < 0 ||
> > +         pyrf_counts_values__setup_types() < 0)
> >               return module;
> >
> >       /* The page_size is placed in util object. */
> > @@ -1520,6 +1607,9 @@ PyMODINIT_FUNC PyInit_perf(void)
> >       Py_INCREF(&pyrf_cpu_map__type);
> >       PyModule_AddObject(module, "cpu_map", (PyObject*)&pyrf_cpu_map__t=
ype);
> >
> > +     Py_INCREF(&pyrf_counts_values__type);
> > +     PyModule_AddObject(module, "counts_values", (PyObject *)&pyrf_cou=
nts_values__type);
> > +
> >       dict =3D PyModule_GetDict(module);
> >       if (dict =3D=3D NULL)
> >               goto error;
> > --
> > 2.49.0.1101.gccaa498523-goog
