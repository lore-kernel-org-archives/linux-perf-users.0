Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AA82E92BB
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753369520; cv=none; b=cUvRyEmM+KJuo3Ol9OSwkbzvIlkStRLcB/F1WoM+f7SiNPvCZwNiJ1cV1TtiqUX2AQZygPpp0fh2M4XE8HL4USTuJDT/E59gqcddxnrghtdNJYJpDCL44sI7CiEvXGDUXAim3LwkVZZgXnusH7n2aB44lpS/rftIdxB/NFaHcSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753369520; c=relaxed/simple;
	bh=XS49UAWaM6g57Ov/kyZQ0TdAaGw+pgSYdI+CbbjwHDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBMjAoPwigGw0+pYiZpucEqUHWuizgnFcGkUkqDHZ1PfEW8+yt3JRfxATtj8hkoA9F338GZBK2ILlFUBM5M53dpoctNlsmnOBsYJrt/fa2kaMRO4ziHz3Q3aiVNRl161a1w5jPtOOBQifGnKcs1qdLt7p2XvvjIP+wd/Q5gpgLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UPoZHjCq; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UPoZHjCq"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3e283b2d065so210565ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 08:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753369518; x=1753974318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvJko2i1qJQeNj8KL/Ae2uOExbpWlktOcGSi8mGX7iw=;
        b=UPoZHjCqjEFexTCuQKfpeVA2SCOIq5J+ZbBnTsd5M65PpwzgMcQrXzLaRJwHFftdUo
         KqrWDS7Xse5JnDL3pD3Y51rMg1CWNU87QHRHxu6VCPwTMLpBIEM64ubeUOR3YPp8DTZQ
         jNJ5tLAhHRvOQ5zvjDOUxG6RAvakrQ8UfiY2p9rpf0tXqCqVjVW9FuopKXY5jTHnVTJq
         ePNMH89UjJwhQAvkn4pId8vjcU4WTx6EJ/eqjyWpvR1tQQHPNb9p8FTeKAnIQjBs+VXv
         hWW8DdioAsMHMIVtnaIUJCrjUqR/oTUvtuFXyR0GiHDDFny5G+uQdK0vUx+pfKmRKQEB
         GzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753369518; x=1753974318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvJko2i1qJQeNj8KL/Ae2uOExbpWlktOcGSi8mGX7iw=;
        b=u1TranA7pcJGUfpY7drpDmWO501fCz7kY7/KkFD5dzLhunN3HuYKrfWbCs7sNRPkRW
         PbmrjUJZa1h5Ik1lCKYq1zq8e78lQs30QEXB68lp6GxX5M3M73dY4C8GVKvOIFSwyJqN
         A8gfgcckuHbBpTcUth6puSqZVYDKQKYmH/GX8bzxk6a9jf1psE0+ris+IOqQc+U+zRV0
         y5ckI16x4ATELQ6Ri1c/fs+DA5KLP+c1o7g6eDrXbbYNZ22soPDRMdgX3kRkmdYf9d+e
         RN1QD+SPZedIxmx6N/Z5WCVQXtLwaufzFDtx7niV8ZOUIIIMJE0sIT6x7XIBwhya9Em7
         tdOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSWsRVQcx62KSb/X4DYXzdRe1vE95NGiCsytc5oqCHsO78FmS/LQzwNP3XjS3YCDxMBlMuilQuCfDzwSEadb+g@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ1fjc3qHCrvH7MPt80S6WbqKWc0MoZAWYtUFw0pd28APi5C2s
	q/ftLYw4xuNwZIilYJuZDN45aWbQem3+UtWmRYzKI70vsL4wfxieQm6/0o28P5Tf4EyZjpWs8Fa
	KtkiYHZXf4fon16uRuo//qmIxjvMzHoGn0cYnZYyM
X-Gm-Gg: ASbGncvkY+pNfzB55ggx/bPGQ/M3h2gFNFdn3EFTkus2aKX525Rl83ZO3wSI+CvgN8i
	iWkSX4bOSozJ+5Ojv+T77Hrpf3EiPdK7b3EbPGAQ8RGdakRuvwWCdTYUP/CFBGTzrW7QvFm9zOo
	wghInfgEHvYPmYJ/gM6SMPKSVSsPKiM407uA+g3ocvnbAEuCr/spIETewQ5mmtK5eX+2rLmdPEF
	s0qokH+8BPAYVKf7uaSnF57P860CNe1LhyL
X-Google-Smtp-Source: AGHT+IFlvgfC1WSKV++RmyX0sLt7P/0dcLE8O0wKmgO0LT0s4nsCS+0JUzGQFSrFE6LkHFpTjI6fgghCvV1uSGLyR6k=
X-Received: by 2002:a05:6e02:1a6a:b0:3e2:865b:6b62 with SMTP id
 e9e14a558f8ab-3e3b7324babmr3227455ab.1.1753369516998; Thu, 24 Jul 2025
 08:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723232217.516179-1-irogers@google.com> <20250723232217.516179-2-irogers@google.com>
 <aIGBAQv2Cn9qGqP1@google.com>
In-Reply-To: <aIGBAQv2Cn9qGqP1@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 24 Jul 2025 08:05:05 -0700
X-Gm-Features: Ac12FXwiaiafw1HYwJqDKYeKgUMZ_hcmmEdj70cxz9U-2F3-RpBomriDPMoKJF0
Message-ID: <CAP-5=fV96=Vtgzu6quGC5pHHL8JECHtvXzUJJgOxzc15=fKJRA@mail.gmail.com>
Subject: Re: [PATCH v8 01/16] perf python: Add more exceptions on error paths
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
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 5:40=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Jul 23, 2025 at 04:22:02PM -0700, Ian Rogers wrote:
> > Returning NULL will cause the python interpreter to fail but not
> > report an error. If none wants to be returned then Py_None needs
> > returning. Set the error for the cases returning NULL so that more
> > meaningful interpreter behavior is had.
>
> Nit: I still don't get what "add more exceptions" means.  What I'm
> seeing is adding more error messages.  Also returning NULL from this
> function won't pass it to the interpreter as the convert checks the
> return value.

So it isn't error messages, calling for example:

  PyErr_Format(PyExc_TypeError, "Unexpected header type %u",
event->header.type);

is like setting errno as in there is a global/thread-local current
exception object. When this is set/pending, returning any value will
cause the interpreter to throw an exception on return, so NULL is an
okay return value - normally for returning NULL you need to return
Py_NONE. Anyway, the old code was returning NULL but without the errno
like exception object set and so the interpreter was crashing/failing.

> But anyway, looks good to me.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
