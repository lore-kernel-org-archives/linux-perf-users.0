Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77727450F2
	for <linux-perf-users@vger.kernel.org>; Mon,  5 May 2025 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746478952; cv=none; b=YpugTTNG+OlultnzV+YX1412wP4/mlPOmpr45nhptGOX9Za6q/YXxc1svj0PKIH4XTk1WkOQD+221+ubSPgxsXYXmWFovFP8/fU6E2jNDikEJA8e+NEqqYXN2XLI2xcR0F/3b0AvXEwkgET/oJFWSaEYy9Dp9TTl6USic8yZvEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746478952; c=relaxed/simple;
	bh=HRglVARIR6s7RVWqhuWUuqfWy72BHg5jQVngdbDKS08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WirgG7YqxHFLPFAekEVJ8zmh8X+edYx/XetJ0+jlQVpkGtid7DjHVDs/ddMpB6G/nuazWc23a6xEfk5zJ+VxovDfbfsc0DahcyI3TsMoViZfB29aWcDreHHVUevhKbQNVRORbWqlg2gdzK+3dB6vI5XLVzcymYJtiM/9wcYExvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SWNvKeru; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SWNvKeru"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d44cb27ef4so10565ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 05 May 2025 14:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746478949; x=1747083749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfTq/NM7F4E9QDRvn+svqfb4fl714MQcUHP6WgqkNOo=;
        b=SWNvKeruKTzqpZkdYuwsHJMVaEMBkU50iM0W6wLXVAZhbvXRFyQSa4/Ezs1sVfMLLW
         VYBAmUEYOygLz+7O1ltdZut6nEEUZ/B8TYcfkGCp7Frt52cg3B/0okZC/YoDp1tHz5O5
         kehajBUxnCeVBGdz3Ub5iLeRwq6SAnymMuq+wndjc8klassJp3I/v2z3Dw+Ux3ceSYka
         o8R7+N1cSJTjrd+m3KWoDZR6aw2VQUQJJ1UGXJ7WHp0mFO3Q7DwdPNRz4r3w+rnlJ4kX
         0qi8ByD7lsFnmDcawAhzFqv/iZiQhPYzXY5/AoOfqxt26pBaqTU5/+JgsZlyhlSH02HQ
         uGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746478949; x=1747083749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfTq/NM7F4E9QDRvn+svqfb4fl714MQcUHP6WgqkNOo=;
        b=g0mIebBkVhNFiNnq7BRvw6DudssNr3paAmIEwJMS4vN4ScdKTS65Hld9oh6vHU4GHH
         OpAL0FNKHOBHusVsq8MggsmziwIEPQY5D/n+yGlyEc4IFALYzte/07iMMBYyDN3IGhVO
         bqAJxcOEqR3oztM0gidlWnBCADmx/4i2GIiQmRqED7UgRu4B+5GKlDjfd4RPv3cGFZ56
         SfaEFoMx/AKtx+Ukc5aXFYVEe4HcRo5y98iKzvdHzYfJAukC8OSPIOVxltBk9G6uIUbM
         Q1bYEXbnbkw9zhPBiOp2LAg1NRivYmSGNKK0voJPcIBNcWSk0JgQtG0NcTFo8S1w/3WA
         NzSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSLzrbFKKXC/Lc93cbbrnBaCAWDsLjujBi5fnMjm3O5HV2U7ZsKrgrF24x5GFRI1gNgfWZcSvIINS77ZM8MW9d@vger.kernel.org
X-Gm-Message-State: AOJu0YxiZSJMq6xgQK9cA9iUxFOfLy7rl7CVHbsw5Pj0yHHYcfjg52sp
	TXIXgYpv7HVWd80wdY8qq2i8C3tQFe5VR1Ks2eNkFN/LLd+saX6T3Cea/fxfwU58FOBaSumrm5B
	Zfv8/skLFdY0GmcfENtYVIk4LAtDUQyyTeVxN
X-Gm-Gg: ASbGncuhWf/UtEJdPm225/cEuWjs4dWKQx01lErNTcbiCB4bp7B9o+7XifGpIL/K+CA
	Mf26553/cAtBBYvlgoU+kpPZ81jlQ+O/ZiGBYfK33cQLgMme6yJCUyJL63M5QrdVwsr0ge7V08f
	TnOK14tM1X1UbE4y2VT/arAdShw+zW4EGi+TpDWCVwtmcd792/j3Q=
X-Google-Smtp-Source: AGHT+IFrGFD2S6wJ3YfWfBvDNL5C/Rp9fbcbeJBi0Vx5UH45RAa965d61PNqdu/D7r+Q0YcRvreRYVuJiS2f2sNBytE=
X-Received: by 2002:a05:6e02:198d:b0:3d9:66a3:66fa with SMTP id
 e9e14a558f8ab-3da6d5a8464mr169035ab.21.1746478949286; Mon, 05 May 2025
 14:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501093633.578010-1-gautam@linux.ibm.com> <20250501093633.578010-4-gautam@linux.ibm.com>
 <CAP-5=fX1qodprWrwK7yq2WYZNnLtiEe_rjvw0aJ7gXY2ma+Hzw@mail.gmail.com> <wu4cq5jilwtwdle2xuj5vuzz2cc6hx4whrbshkiw2pregk4xdi@lj7i53kssgur>
In-Reply-To: <wu4cq5jilwtwdle2xuj5vuzz2cc6hx4whrbshkiw2pregk4xdi@lj7i53kssgur>
From: Ian Rogers <irogers@google.com>
Date: Mon, 5 May 2025 14:02:18 -0700
X-Gm-Features: ATxdqUHurjOGKk1Z3bfM5EM_EPzgB5jiYiMmVzWCs1OTe4lsYo7mc6rHh-HKn8c
Message-ID: <CAP-5=fV-XKf78FajY5FDzXRQNZ5f_VWx9wwLU1g2JJEFvyjVCw@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf python: Add evlist close and next methods
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 4:49=E2=80=AFAM Gautam Menghani <gautam@linux.ibm.co=
m> wrote:
>
> On Thu, May 01, 2025 at 08:49:08AM -0700, Ian Rogers wrote:
> > On Thu, May 1, 2025 at 2:37=E2=80=AFAM Gautam Menghani <gautam@linux.ib=
m.com> wrote:
> > >
> > > Add support for the evlist close and next methods. The next method
> > > enables iterating over the evsels in an evlist.
> > >
> > > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> > > ---
> > >  tools/perf/util/python.c | 47 ++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 47 insertions(+)
> > >
> > > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > > index 5a4d2c9aaabd..599cb37600f1 100644
> > > --- a/tools/perf/util/python.c
> > > +++ b/tools/perf/util/python.c
> > > @@ -1163,6 +1163,16 @@ static PyObject *pyrf_evlist__open(struct pyrf=
_evlist *pevlist,
> > >         return Py_None;
> > >  }
> > >
> > > +static PyObject *pyrf_evlist__close(struct pyrf_evlist *pevlist)
> > > +{
> > > +       struct evlist *evlist =3D &pevlist->evlist;
> > > +
> > > +       evlist__close(evlist);
> > > +
> > > +       Py_INCREF(Py_None);
> > > +       return Py_None;
> > > +}
> > > +
> > >  static PyObject *pyrf_evlist__config(struct pyrf_evlist *pevlist)
> > >  {
> > >         struct record_opts opts =3D {
> > > @@ -1202,6 +1212,31 @@ static PyObject *pyrf_evlist__enable(struct py=
rf_evlist *pevlist)
> > >         return Py_None;
> > >  }
> > >
> > > +static PyObject *pyrf_evlist__next(struct pyrf_evlist *pevlist,
> > > +                                  PyObject *args, PyObject *kwargs)
> > > +{
> > > +       struct evlist *evlist =3D &pevlist->evlist;
> > > +       PyObject *py_evsel;
> > > +       struct perf_evsel *pevsel;
> > > +       struct evsel *evsel;
> > > +       struct pyrf_evsel *next_evsel =3D PyObject_New(struct pyrf_ev=
sel, &pyrf_evsel__type);
> > > +       static char *kwlist[] =3D { "evsel", NULL };
> > > +
> > > +       if (!PyArg_ParseTupleAndKeywords(args, kwargs, "O", kwlist,
> > > +                                        &py_evsel))
> > > +               return NULL;
> > > +
> > > +       pevsel =3D (py_evsel =3D=3D Py_None) ? NULL : &(((struct pyrf=
_evsel *)py_evsel)->evsel.core);
> > > +       pevsel =3D perf_evlist__next(&(evlist->core), pevsel);
> > > +       if (pevsel !=3D NULL) {
> > > +               evsel =3D container_of(pevsel, struct evsel, core);
> > > +               next_evsel =3D container_of(evsel, struct pyrf_evsel,=
 evsel);
> > > +               return (PyObject *) next_evsel;
> > > +       }
> > > +
> > > +       return Py_None;
> > > +}
> > > +
> >
> > Thanks for this! Have you looked at the existing iteration support?
> > There's an example here:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/python/tracepoint.py?h=3Dperf-tools-next#n26
> > ```
> >     for ev in evlist:
> >         ev.sample_type =3D ev.sample_type & ~perf.SAMPLE_IP
> >         ev.read_format =3D 0
> > ```
> > In the next patch you have:
> > ```
> >         evsel =3D evlist.next(None)
> >         while evsel !=3D None:
> >             counts =3D evsel.read(0, 0)
> >             print(counts.val, counts.ena, counts.run)
> >             evsel =3D evlist.next(evsel)
> > ```
> > I believe the former looks better. It also isn't clear to me if next
> > belongs on evlist or evsel.
>
> Yes, the existing support would be the right way, I missed that. Will fix=
 in
> v2.
>
> and regarding the next() function, I think we should keep it for evlist
> because for the C code it's defined in the context of evlist, so would
> avoid confusion. But since it is not needed for the iteration, should
> I keep it in v2?

So the perf code is following the kernel style and using invasive data
structures a lot. The kernel does this as memory allocation is a pain
and can fail causing complicated error paths. It gets kind of crazy,
if you look at perf_event in the kernel it has like 11 invasive data
structures:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/include/linux/perf_event.h?h=3Dperf-tools-next#n706
```
struct perf_event {
struct list_head event_entry;
struct list_head sibling_list;
struct list_head active_list;
struct rb_node group_node;
struct list_head migrate_entry;
struct hlist_node hlist_entry;
struct list_head active_entry;
struct list_head child_list;
struct list_head owner_entry;
struct list_head rb_entry;
struct list_head sb_list;
};
```
Managed languages like Python don't tend to use invasive data
structures and I'm not sure exposing next in this way makes sense. We
may want to use an array for evlist in the future, which we've done in
the past to make reference count accounting easier, for example:
https://lore.kernel.org/r/20240210031746.4057262-2-irogers@google.com
But if next is exposed then we'd need to support that for scripts that
may be using it. I think it is easier to avoid the problem by just not
adding the function.

Thanks,
Ian

> Thanks,
> Gautam
