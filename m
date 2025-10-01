Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E15A2765CA
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Oct 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759330526; cv=none; b=B6hQlpOh5mLE+Xk1Sl3tGQRI7nwE23WddWiPkZyXoVbkPkTFAgGJPGUN+sprKSfVS1wpxgqtn7SgWk5sPuWOg0L93gTXk99s9xpBT/EZSs2Uyf4MaNbtv+n9G6lcKi0iaFVK02nqD5kGcYDtdhgwYaU6jAJJkxUFCavuvEhy+/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759330526; c=relaxed/simple;
	bh=xRD2yXCXkLLbqYulxTrjbbgrREUpLwVSGR2doQPspRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFWlxDVGBHltYqpB2+SKwLd/RDgzHNqKQT/5fFkKnwEAQTfiC7aQKzYLTTkxORFyBJXqFtL0J71hiATNFCazknLAXVLRN/tDQE3iYwvnCuprGIa+qmiav14CSk7vj8m6Mjb/Nu15PiTmoQoCKNKRoGWLJENe9ng34S67k+OBiYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xbMcAANL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xbMcAANL"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2681645b7b6so158395ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Oct 2025 07:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759330524; x=1759935324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhsPaQ7p5WJkNBSgyD9D5tQQAYbvt5dtrgNCJ2qJKok=;
        b=xbMcAANLZI359WFs51DcVTeWPiaZg0Lrgvt7PT+IesUgR8ovUQ4jItapG8pPHR0zXV
         U5S6JYych/IdYh6jZtCZUprJlc6gAUZuZYBuSA6D7UzzQJ7MOcaMgFhEJrpVNUifK0Vs
         F01XKk719G7pML26cuoM1y4wBmwSNiEfbMv2BkXx/pKSTYndrP5jN0VuaHemXhGpRRg0
         4Fjk9i1h5OQqtk8YkJ+vNuoOYGtaVyB2Vw32Nf33dhJsd4/aNeeA6mgHmiVOFJZt4MHh
         gO3SWckzv0AuKwaGoaOFydXI4roDz9LLUSku5/7v8WLFoq9KYBrHLc/6zdJJVM4IbRiX
         e/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759330524; x=1759935324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhsPaQ7p5WJkNBSgyD9D5tQQAYbvt5dtrgNCJ2qJKok=;
        b=pw3GP2WAEkw8E790+lb9lsVl3gbhsGg5MncLBiXg022kXk6msRK6CcWI5mBB6PvGx/
         eX4E9cKvXy8JWHHvknLkDhV3NFr2hMk8oF5KDq7yb5wlkiMnu7FQgL59VtWIzf/UJd9T
         4gq1bwLbESwU2olnZz7ZsuP8WAUpveez8g6/eQpVpFPDhkefZpvUnVyIPcFb0cErIrpQ
         kkFnt/Bu4eNVPCqd2yl9YWQpIFJI/iCLUTBKzaPdjCllfZjzzuQt4/Z4hjVK5quI3WsH
         rLpZKaA9zPHODK6HvnSpcQhrhlcs7+XBf8ENJMvCySAtRWT4/Pk+w+uplnf7lTl03Ypi
         mwrw==
X-Forwarded-Encrypted: i=1; AJvYcCW4gNPxPOtVwZqi+IKv/gbgM7cC67ffk4ENUKT8VI0a+KJbgfulkuSDDDXPsq958oMsRVZKf3DINDEqq2Y4BxUw@vger.kernel.org
X-Gm-Message-State: AOJu0YwZI5XXySLS/YIYO/dr1oeBM5MyxZtiUP4tk0Y8qXDl/jHyn6SE
	ZcOZ9lRQ4rBTJnsY01ieCKsKjCGqbvdS+78nQWHfMw2rKwW2Edi1Si19C0VDnKOSYVwgFbyjqgw
	og9nbLdxyFA3edJhr1HQ/TV4Zxn14XWHhTJRQqPvH
X-Gm-Gg: ASbGncs/hUBFWN9iRYU4scf3hNs7NCinD+D+i6q7i8I5CNaFL1XmZpthqukp3TrknE2
	OdxwX5up6PDI+wpyrAgK9tlCcdXtPiYxvUbKderdLny/CaRG1bGJ2o41cCWyW1pUd/wLhIHfgJ6
	IIL6cId6vOgPMnXWJ4//L0tT0LUBjp0Gh7NbeTwCkVMe+8ANzUZPtirHwneSdSzCRqCHxL/hhjM
	8kAHdncdznCIbYUMW0MYXEpSTPc+QB6bhiKmaCbNBd1kxK7k0IMHFQwsBQ6br8ixI2A8nnvNfGw
	ZIM=
X-Google-Smtp-Source: AGHT+IHZApbTn2f8Bc144Vyi9JnUaoYvu+ZyiBe9lrNyNM4HMnH2M4tmU1Rh4Q39Zpi9EiQr52wtOZChi17BNfYcfio=
X-Received: by 2002:a17:902:ce0e:b0:24b:1741:1a4c with SMTP id
 d9443c01a7336-28e7fcf1f70mr5037765ad.0.1759330524045; Wed, 01 Oct 2025
 07:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903184248.695267-1-irogers@google.com> <CAP-5=fV-3d1EzYfZq6s9M2NrLFFVOrWOTx_k5tByScA4Sfqq-g@mail.gmail.com>
 <aN0vu4yoVWjmTbtJ@x1>
In-Reply-To: <aN0vu4yoVWjmTbtJ@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Oct 2025 07:55:12 -0700
X-Gm-Features: AS18NWCNLhCWzmWSoLRCUJqGjooqnlqXjwFfo3FV6h1-TZfeczc5cdnkqfDu6Kk
Message-ID: <CAP-5=fX46C2A22B1TBSgNb0BR1BumvqQeZvaFbU=9OqHmYPqrQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf test: Add an 'import perf' test shell script
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Collin Funk <collin.funk1@gmail.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 6:42=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Tue, Sep 30, 2025 at 01:02:55PM -0700, Ian Rogers wrote:
> > On Wed, Sep 3, 2025 at 11:42=E2=80=AFAM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > The 'import perf' test needs to set up a path to the python module as
> > > well as to know the python command to invoke. These are hard coded at
> > > build time to be build a directory and the python used in the build,
> > > which is less than desirable. Avoid the hard coded values by reusing
> > > the existing shell script python setup and determine a potential buil=
t
> > > python module via the path of the perf executable.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Ping.
>
> There is another patch in this area to make it work, right?
>
> After applying this one I get a failure, only when I set PYTHONPATH it
> works:
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ export PYTHONPATH=3D/tmp/build/p=
erf-tools-next/python_ext_build/lib/
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ perf test -v pytho
> Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF =
maps, etc
>  88: 'import perf' in python                                         : Ok
> =E2=AC=A2 [acme@toolbx perf-tools-next]$

Hmm.. if you are running from the install directory then I guess the
assumption should be that the install bin directory is in the PATH,
lib in LD_LIBRARY_PATH and PYTHONPATH set up for the directory too? We
could have the script look for a python module going from ..../bin to
..../lib and fix the PYTHONPATH for you. Wdyyt?

Thanks,
Ian

> - Arnaldo
>
>
>
> > Thanks,
> > Ian
> >
> > > ---
> > >  tools/perf/tests/shell/python-use.sh | 36 ++++++++++++++++++++++++++=
++
> > >  1 file changed, 36 insertions(+)
> > >  create mode 100755 tools/perf/tests/shell/python-use.sh
> > >
> > > diff --git a/tools/perf/tests/shell/python-use.sh b/tools/perf/tests/=
shell/python-use.sh
> > > new file mode 100755
> > > index 000000000000..fd2ee5390060
> > > --- /dev/null
> > > +++ b/tools/perf/tests/shell/python-use.sh
> > > @@ -0,0 +1,36 @@
> > > +#!/bin/bash
> > > +# 'import perf' in python
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Just test if we can load the python binding.
> > > +set -e
> > > +
> > > +shelldir=3D$(dirname "$0")
> > > +# shellcheck source=3Dlib/setup_python.sh
> > > +. "${shelldir}"/lib/setup_python.sh
> > > +
> > > +MODULE_DIR=3D$(dirname "$(which perf)")/python
> > > +
> > > +if [ -d "$MODULE_DIR" ]
> > > +then
> > > +    CMD=3D$(cat <<EOF
> > > +import sys
> > > +sys.path.insert(0, '$MODULE_DIR')
> > > +import perf
> > > +print('success!')
> > > +EOF
> > > +    )
> > > +else
> > > +    CMD=3D$(cat <<EOF
> > > +import perf
> > > +print('success!')
> > > +EOF
> > > +    )
> > > +fi
> > > +
> > > +echo -e "Testing 'import perf' with:\n$CMD"
> > > +
> > > +if ! echo "$CMD" | $PYTHON | grep -q "success!"
> > > +then
> > > +  exit 1
> > > +fi
> > > +exit 0
> > > --
> > > 2.51.0.338.gd7d06c2dae-goog
> > >
