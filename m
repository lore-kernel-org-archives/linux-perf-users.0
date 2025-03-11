Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E7111A8
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 00:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741652941; cv=none; b=KQjGcoMRpH4JhfhLtvVIoJoJ2nRP4/XPFOoYsbVvCZ4k7eK3u6/kAW7u5bVtddQhZ0SIJ1zqqVxRPyTHn116qlkz3PniLmeCnEYWfuHkoASTldyzyfhyYP8baQ8GrClmo4y/DCdjYz8XYD7RTU51VbpvWp/LJ/9+RWT0Ab/93MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741652941; c=relaxed/simple;
	bh=H7jZ8AJWpuYWzp+yJpA8zo+LB4yon8C+Vs0avmU6EPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sm9FOlr8HVe+NF3xfqBGAm6Fnpc3sYpKipLInOeBo/Vrvbb7EEawG1sw3mvS8QnDAZ9a2x5WxqaKS7LpW7MAN/bfX+fVySCr27CkRwbjjf0mG2E2vnTO9q0cjmKZkQsuZBGiuMqa3rTh9uuUbLq0cfinnmfwL71a5qi5s4Zxe7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m6Sf/XFL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6Sf/XFL"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2240aad70f2so46155ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Mar 2025 17:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741652939; x=1742257739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UABuFrQuI44iACwIy3HnqNxQ3GKqEJj4Y7sE4lcn2r4=;
        b=m6Sf/XFLAKPAYy1UzTiQSR8adN0d2pYU9h1HDB8BVv50cfuXpoAhtW2o0e3Rf7KjDV
         88B8m2f3wQQGCjQ/aWdkcuJaxewb/7ayBbOm+JotKefzS6oPv+C/geu99ZoyrPHsF9kx
         Nro29Kzqleo4hm+atr4c/GPI/UlEv0bqq8DKjoxUOiT9x0P45pOuJCQkec7Z/VmMiWUP
         5k4g6/Nzy/hGm3x8shz5dSnl+GaRiQms+OGzJ0/119YIZAVmRfrFRj8CpI0pNL5KmK6X
         8TuAPmuJXHEeBEkpesJro2FiNWLCbTA9fct+QTcs+22HxILv/Ap9rciIyYhM6XesbbKd
         QM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741652939; x=1742257739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UABuFrQuI44iACwIy3HnqNxQ3GKqEJj4Y7sE4lcn2r4=;
        b=exTv5U0yFhLRxzXOcLQXKP4P3bgo2Jhdbfw89lbAJVr4D1JzkS7G+EdVwspQ0082g4
         TOQpa5W8Gw0xns8sRL/UkBCKDpR3yiR930pzT5RAX6PXuB5j/cNEX+dvxrTE+VN2I/TE
         c+3ykcoSny6eLzpVJ1WCGxxTUNdSuMrXeh1IiHKu144LrjIrtmdxZejQp7DEQ8tBhZc+
         YtzRYiS4K2YcN+JZzykYrIcAQ+F4sNUWhjAAihmNR+PKbRQm2goB/G+c72Mjx5gFQcOM
         EJnZ4AMPX12ggo1DIJuXmX1OGxFKw672rS4CDRQTJEiVKuHytji7vp1Jf0jJ+9Cd9eLd
         viaA==
X-Forwarded-Encrypted: i=1; AJvYcCVuoDSYt5iWUtFCmFO6mF7kbjq1zVur5JuuGuN2feK4ihH/GL9uH5WCRzTp+VOwn11wqeVOJ0F+r9uKMiyTzKD7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4lbW9/+9Y7odvWvtderfi/cwK84J3BKS7jH1/JJ5o7ncCWadu
	7eA0nDoKd8CsFB8eMskZ5WvnmGYLlKq2WenUDczSmknqUQa1Vw5RmSaBBLHOZXdHEM3xNRPBoyY
	rQUY33jROlG93NbBV9GZXICL4WEfJGg/tZqh0
X-Gm-Gg: ASbGncv9BvlV/yLw3E4QizsrxOfxtOxoWiWELuYAG7wi0XIgpZQYtivf+KpDoq+VK3A
	OtAgZHByTiWmkII77gtwf+7br+sZqOI+ojvQgJyIqayINK5ALgt5sH9xdHqpED9qoA4BOWWzjnR
	sWSea4QszaV5/jQguHbXAqYV7m5BE=
X-Google-Smtp-Source: AGHT+IGZFYC9l0qSMoTNOCNTKIWeDhgcqZC3Ph7NAr2gIW3VS6y0oQX5vid8Fwv244/bp66pOd+Sbl+r4VXrIV9rhcc=
X-Received: by 2002:a17:902:d4c6:b0:21b:b3c4:7e0a with SMTP id
 d9443c01a7336-225477f2f60mr5635095ad.13.1741652939394; Mon, 10 Mar 2025
 17:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com> <20250228222308.626803-7-irogers@google.com>
 <Z89jxAMEpYea9Qom@google.com>
In-Reply-To: <Z89jxAMEpYea9Qom@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 10 Mar 2025 17:28:48 -0700
X-Gm-Features: AQ5f1JpMTIqotVW_qaSlsLG95MiiipTuuoYyviXscstDHkVRcjpAY_dd3vnQQAc
Message-ID: <CAP-5=fXniy+Ye=xYdGzr4NKMjh=zQpgZuL=X3Y4DC6ATM5t5Pw@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] perf python: Add optional cpus and threads
 arguments to parse_events
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 3:12=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Feb 28, 2025 at 02:23:03PM -0800, Ian Rogers wrote:
> > Used for the evlist initialization.
> >
> > Reviewed-by: Howard Chu <howardchu95@gmail.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/python.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > index b600b6379b4e..4a3015e7dc83 100644
> > --- a/tools/perf/util/python.c
> > +++ b/tools/perf/util/python.c
> > @@ -1339,12 +1339,18 @@ static PyObject *pyrf__parse_events(PyObject *s=
elf, PyObject *args)
> >       struct evlist evlist =3D {};
> >       struct parse_events_error err;
> >       PyObject *result;
> > +     PyObject *pcpus =3D NULL, *pthreads =3D NULL;
> > +     struct perf_cpu_map *cpus;
> > +     struct perf_thread_map *threads;
> >
> > -     if (!PyArg_ParseTuple(args, "s", &input))
> > +     if (!PyArg_ParseTuple(args, "s|OO", &input, &pcpus, &pthreads))
> >               return NULL;
> >
> > +     threads =3D pthreads ? ((struct pyrf_thread_map *)pthreads)->thre=
ads : NULL;
> > +     cpus =3D pcpus ? ((struct pyrf_cpu_map *)pcpus)->cpus : NULL;
>
> I wonder if it needs any type checks before accessing them.

Agreed. We don't do it yet elsewhere:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/python.c?h=3Dperf-tools-next#n769
although there keywords potentially avoid ambiguity. Given this I
think improving the typing is follow up work.

Thanks,
Ian

> Thanks,
> Namhyung
>
> > +
> >       parse_events_error__init(&err);
> > -     evlist__init(&evlist, NULL, NULL);
> > +     evlist__init(&evlist, cpus, threads);
> >       if (parse_events(&evlist, input, &err)) {
> >               parse_events_error__print(&err, input);
> >               PyErr_SetFromErrno(PyExc_OSError);
> > --
> > 2.48.1.711.g2feabab25a-goog
> >
