Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AB219E81F
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Oct 2025 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759343354; cv=none; b=DKQ1JIUHozfVhcsSTdFW9zLTt41JkEBBrwbj4RAiL3dQnv+c7Y4cIO33xhFErUKhso7WMqGP2mvZQo9bUbGBYWugaPjSn5xDGaLdrM7YIMOWH3ZAY+JKewUxk6vaSoRu5Sow9iJWTmXDpze3Mwyz4H10bBV+om5V+MwprvTTvMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759343354; c=relaxed/simple;
	bh=2c8vydE0j87T+FcdTUxthuP+NglO3VV4kLkIFoVtjWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQ083YOCL7ZeRqpSESogZwaxtUuVaGSc894pi//vTTLBvxxM7zC2uenOKwtDbcvgLJ5kNaCJzNqh7eyRxls6tGwob3nppeUPtb2m7b5I5UGeqqiFc9HSw7LaMpPuEytdek5jJLXynVg0AiQ8c39BquZ0B7UHlx4A9k4OPtfmOog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a8xZiLX1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a8xZiLX1"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2681645b7b6so23225ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Oct 2025 11:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759343352; x=1759948152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sFyW1u/7NQyxS9RW2mJInFdcUP7OWrs8+QrbdBdhZc=;
        b=a8xZiLX1wpas0TmhRFEMUj9CDtr5QM/ehjsMzYYb1xo3HWb3JilTIz4NNQCkob0eHS
         zOO2ZKnG2Kp/2CgbvPLmryrJYOIcMuvlSGI2oj2UpogMSb3cOiDuTbfu3XzxIcHfPh5a
         HzIB+V71A+J+nQHELSiD0KGcrAd69oZWq40B2GAFvqyAvgAt5WN2XUXZc8rEODMC7mD9
         m3rD713MNqUGKaJ70UZVtfco4y8u0E9goIVHTGcZSjraQ8YkEAdMZTKXVA4P5vikBXrP
         jEWt8yLcsCR81zqw4DKjM7tSVnzym3Me7Hi9PK9uedGcfj2uKmbGYs9U25pdMj/CDyZb
         N/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759343352; x=1759948152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sFyW1u/7NQyxS9RW2mJInFdcUP7OWrs8+QrbdBdhZc=;
        b=QWvWZVGkBjs2zIdgdttyctTBUqzy6ca8wzvMKhqrkIQg7Z4xLnbqfpW5P/VfcrhPiE
         5626mYPjjCIOKfK/r++kcCAgpoRwG8WV9OybZ5jRWjfcBcu9UPIe8WE9lGTxzLQB2gR0
         pouFFO6iZbJN3aihXnPLm76Y8PRvriZzZiCVw7zwjLDfq6ND90ivHAwrInQDyrFJCinr
         pwY0scEaefpiWKTF8Ostam2F/vcArl0MHIpIflvzSKVbbptqpfvn4w+pK4tF4IYE2Y9C
         6qidusGZUprDQmMEFj9O8rWvhjDdkXFIDy7eWJJFXgoIm74wDCSSLbV3Pw/lMTI4hVXS
         elZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7mBFSPU/C2F6KvklPsmpLbkHRh68D6vKthsO1XdEEamXUuj6vKTtbb8y4RQpXQxxXlI9ENSs0OyIVN5bvPd/N@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr9tNUKPHRK0Hfxfy9ilym0ZFG7SJyieyaSxKkpDyYoUPZF1qr
	7tS9GRFg/NCQFg5eNYmsWtRyKpEzOl+o/lMBm4WQge37GNIWffRKWh/Jj4u9Tb3P4MTdsXCXATp
	bYU1wTLxdXm2uPboXNO3BeQI0dnPSOKwX6qmr0ybX
X-Gm-Gg: ASbGncsdDxJ+Ff1XQUUN+For7VJnr8sC9nLSv4BUVzDybU2IvOJte+TrCLIkfcyYTsv
	RV53JtUjAS6xdc9GsQzRJIwJXN5qYAraBl42D5Jubjm13WvGMrCp4ERoMV/vFXYdFKmSOBvZz9/
	38n3ExOSCOAAv4hNp2IurcymkaNDKzsSUXaLrhJvlSEkwdyRkvzAL5RovF0QR7XdMcaBXNQ8AZs
	HpLo5rZplt/2TPAu6zwjPSTgCOP6BZKV2hCUG2uEQxkqCZ3zBhfgNbzY2KZPrdI0lA3I8/h
X-Google-Smtp-Source: AGHT+IHRK1oSaJYeZTutaeOHMNBmswKw5Ta59S5jssXGLeK3yX/NcJR/iXqcSgW8S6E2nWJ913NqPBCv2Egy1EX0ZtY=
X-Received: by 2002:a17:903:3c2f:b0:264:1805:df20 with SMTP id
 d9443c01a7336-28e8d954347mr597755ad.4.1759343351170; Wed, 01 Oct 2025
 11:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903184248.695267-1-irogers@google.com> <CAP-5=fV-3d1EzYfZq6s9M2NrLFFVOrWOTx_k5tByScA4Sfqq-g@mail.gmail.com>
 <aN0vu4yoVWjmTbtJ@x1> <CAP-5=fX46C2A22B1TBSgNb0BR1BumvqQeZvaFbU=9OqHmYPqrQ@mail.gmail.com>
 <aN1xiDKUpNw83h8B@x1>
In-Reply-To: <aN1xiDKUpNw83h8B@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Oct 2025 11:29:00 -0700
X-Gm-Features: AS18NWCocfBeNVJIfR9A0FtB4zrLhjvYZ5y1o6oRjlzwuHyCmI9jqKvhuwN7VCU
Message-ID: <CAP-5=fW_zZ8GuWYb5gn7skijz1igQawztfew9puVZGSKTyWaAg@mail.gmail.com>
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

On Wed, Oct 1, 2025 at 11:23=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, Oct 01, 2025 at 07:55:12AM -0700, Ian Rogers wrote:
> > On Wed, Oct 1, 2025 at 6:42=E2=80=AFAM Arnaldo Carvalho de Melo <acme@k=
ernel.org> wrote:
> > >
> > > On Tue, Sep 30, 2025 at 01:02:55PM -0700, Ian Rogers wrote:
> > > > On Wed, Sep 3, 2025 at 11:42=E2=80=AFAM Ian Rogers <irogers@google.=
com> wrote:
> > > > >
> > > > > The 'import perf' test needs to set up a path to the python modul=
e as
> > > > > well as to know the python command to invoke. These are hard code=
d at
> > > > > build time to be build a directory and the python used in the bui=
ld,
> > > > > which is less than desirable. Avoid the hard coded values by reus=
ing
> > > > > the existing shell script python setup and determine a potential =
built
> > > > > python module via the path of the perf executable.
> > > > >
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > >
> > > > Ping.
> > >
> > > There is another patch in this area to make it work, right?
> > >
> > > After applying this one I get a failure, only when I set PYTHONPATH i=
t
> > > works:
> > >
> > > =E2=AC=A2 [acme@toolbx perf-tools-next]$ export PYTHONPATH=3D/tmp/bui=
ld/perf-tools-next/python_ext_build/lib/
> > > =E2=AC=A2 [acme@toolbx perf-tools-next]$ perf test -v pytho
> > > Couldn't bump rlimit(MEMLOCK), failures may take place when creating =
BPF maps, etc
> > >  88: 'import perf' in python                                         =
: Ok
> > > =E2=AC=A2 [acme@toolbx perf-tools-next]$
> >
> > Hmm.. if you are running from the install directory then I guess the
> > assumption should be that the install bin directory is in the PATH,
> > lib in LD_LIBRARY_PATH and PYTHONPATH set up for the directory too? We
> > could have the script look for a python module going from ..../bin to
> > ..../lib and fix the PYTHONPATH for you. Wdyyt?
>
> I reported it more in the sense that something that was working before
> stopped working but having not yet tried to see why it stopped working.

Not working is not good. I'm not sure what I should do for the fix.
Aside from cleanup I was hoping we could get this working so that we
could start testing things like ilist.py that depend on the python
module.

> Another thing that I just noticed that may be related:
>
>   35    97.47 fedora:rawhide                : Ok   gcc (GCC) 15.2.1 20250=
924 (Red Hat 15.2.1-2) , clang version 21.1.2 (Fedora 21.1.2-1.fc44) flex 2=
.6.4
>   36    36.81 gentoo:stage3                 : Ok   gcc (Gentoo 13.3.1_p20=
240614 p17) 13.3.1 20240614  flex 2.6.4
>   37    77.37 manjaro:base                  : FAIL clang version 16.0.6
>       AR      /tmp/build/perf/libpmu-events.a
>       LINK    /tmp/build/perf/perf
>       GEN     /tmp/build/perf/python/perf.cpython-311-x86_64-linux-gnu.so
>     /tmp/build/perf/python_ext_build/tmp/git/perf-6.17.0-rc6/tools/perf/u=
til/python.o: file not recognized: file format not recognized
>     clang-16: error: linker command failed with exit code 1 (use -v to se=
e invocation)
>     error: command '/usr/sbin/clang' failed with exit code 1
>     cp: cannot stat '/tmp/build/perf/python_ext_build/lib/perf*.so': No s=
uch file or directory
>     make[2]: *** [Makefile.perf:747: /tmp/build/perf/python/perf.cpython-=
311-x86_64-linux-gnu.so] Error 1
>     make[1]: *** [Makefile.perf:289: sub-make] Error 2
>     make: *** [Makefile:76: all] Error 2
>     make: Leaving directory '/git/perf-6.17.0-rc6/tools/perf'
>     + exit 1

Hmm.. maybe that relates to Leo's changes. He modified the clang
options in setup.py which this aligns with.

Thanks,
Ian

>   38   130.27 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0=
 , clang version 15.0.7 flex 2.6.4
>   39   119.76 opensuse:15.5                 : Ok   gcc (SUSE Linux) 7.5.0=
 , clang version 15.0.7 flex 2.6.4
>   40   120.03 opensuse:15.6                 : Ok   gcc (SUSE Linux) 7.5.0=
 , clang version 17.0.6 flex 2.6.4o
>
> - Arnaldo
