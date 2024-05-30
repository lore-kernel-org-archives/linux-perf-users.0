Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56499335A7
	for <linux-perf-users@vger.kernel.org>; Thu, 30 May 2024 17:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088522; cv=none; b=TMA9/ySNaeiizE3KqGmyOm9GcpAetfQKRVCMNmJ1kZsNsPMXpxiTwSb6AiY8Cw0IIdrgsVaQSveuINdhtgxAjxbHHbdatgUGEaQ62hQEtCr3tEDalrn624r4Yn+17kHsXklXHuP3NKPQY5x9hDoYaRFq743ynFQzteWLETZHctI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088522; c=relaxed/simple;
	bh=Gqy/sZ3D2l/jo2B+eHz+uLxuyS7+sy8fk7hAzmAFXHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYIdjFmsqZq26eEvokGKJwrv/SY1zDg04IYlqvEVXFa5DI9e/oJdJMnQWFWTlWI+AdF+ueMpDYWS/pqH3BufrgWTxKIF8TcZo07jgcrapvvsEhlSXaSxafpDlilCnlwnC6tWUc36kT0Rp7dF1rIx0MICNqi6b4mfnk8c0F+GWdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jQNbUlNO; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jQNbUlNO"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43dfe020675so11161cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 30 May 2024 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717088520; x=1717693320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+MrYC3M359zN++AcvPSJthoFBLMWtCnEv2B4iFCbx8=;
        b=jQNbUlNOGp1VIeOwe7XhrQrUkKwf/mvh0G8YLfAgi38OG9+evDVUvXrYta7rIUS1Oa
         8sJn66T4Hv70e/EvatABRO6xqMshj9HqZi/CScf6mVLwCWdQJcVqbAXl6ROu9gNHsEDv
         iJk0B2E7HMSkGDGs+5dOitBGqGoZJvgEp3XrsW0AjsRiU73YLjpaekJ0+Bcp7IOcMpkS
         D2ou+sYKlSa4MH2qEIZo6uhMkKb0jkMjSYvwyqQC1xX6+SkBvvnDIvWMGHezSWESl8pp
         h+ZFC5DQb74LCv9BEUEqkNh05KHJK8v7yHZD1UABZsyROK+G6155rsyjrfUNyTSloYYy
         8eBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717088520; x=1717693320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+MrYC3M359zN++AcvPSJthoFBLMWtCnEv2B4iFCbx8=;
        b=VfHeCFsc5/g3oUcY+Bp+Khhfj4iMzxqhUmruex56ZwV1EeWmbwi5teWvQYRHuLgRf3
         YenM3we0I/lXgvpiu4uTLYQRFW/Mh86oRT3w2WGW5LTKSz9sDWpDklRnr94Sve04f2wJ
         k4L+5zP0t2JnA74z+WJ+igNbQZocPbvcDhADUY1c05YeZW1KWGx1uTmfRxU2Dk6uTHbJ
         lWfnyFWa4PT3fuPBZfvMaodalhSwwN6I83yBl4lRo5waF5MUUTlBw7CUKl2HKiC+z0Go
         qKoYpYb6D2qhUWCgJJ8K/AaqHbL53Ub7CUQc8TT/cvOIqJmNJJ/fJ6JyV0LSpa/oAUi5
         r8zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSAXkrO+QAahWm86Dnc0k/6g0qUkyBmfg66wxItnxUYAkQFHR/ZhQXzRD6c/4CUDhd83UjkdOwC6D/YMqE+SzKC07/XWc5zzhWjezegz9Ffg==
X-Gm-Message-State: AOJu0YxhsvtHFzEbBzv5HozeS3zkme/wBki1NLUw9lAk9Jsrn+T3cOl/
	hXE3Qs+XxbDYjawxxC9tsXzJQhIcPnlReYQ0nGqbjrPxkAN7m95osvWmwghy8HQANDTQ6E8ncY/
	ANr674EfuckZjF2LrSqdD/x2VmqmXLaodEbaM
X-Google-Smtp-Source: AGHT+IESwOyb8Fu+cuoP33CBCWGRmvM3tUIbJvUHi9lhnICwbUxtHAj53g8OQ+2W4m2QjcMyfdvUNrVNWUg3UJstZNY=
X-Received: by 2002:a05:622a:544e:b0:43a:b51c:46ca with SMTP id
 d75a77b69052e-43feb5182fdmr3288611cf.29.1717088519844; Thu, 30 May 2024
 10:01:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240519181716.4088459-1-irogers@google.com> <CAM9d7chxsyZ+vnPXj0gc-mbADzwzQYi3qUwUohW-7He5KwMvHg@mail.gmail.com>
 <CAP-5=fXME3cjNK-P9qk+kY0dA1Xkwvz6Su=99nY7CgcKrQTb2w@mail.gmail.com> <CAM9d7ch7GidVscUxQh+CZRuo1U1KiDiFiuOZN3FnqbrPDbaVNw@mail.gmail.com>
In-Reply-To: <CAM9d7ch7GidVscUxQh+CZRuo1U1KiDiFiuOZN3FnqbrPDbaVNw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 30 May 2024 10:01:47 -0700
Message-ID: <CAP-5=fV9a2CrM0suQ7_VgG=6DoAAi+A6JyTK=kVivNmSZmg7aQ@mail.gmail.com>
Subject: Re: [PATCH v1] tools api io: Move filling the io buffer to its own function
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 9:44=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, May 23, 2024 at 9:47=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Thu, May 23, 2024 at 4:25=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Sun, May 19, 2024 at 11:17=E2=80=AFAM Ian Rogers <irogers@google.c=
om> wrote:
> > > >
> > > > In general a read fills 4kb so filling the buffer is a 1 in 4096
> > > > operation, move it out of the io__get_char function to avoid some
> > > > checking overhead and to better hint the function is good to inline=
.
> > > >
> > > > For perf's IO intensive internal (non-rigorous) benchmarks there's =
a
> > > > near 8% improvement to kallsyms-parsing with a default build.
> > >
> > > Oh, is it just from removing the io->eof check?  Otherwise I don't
> > > see any difference.
> >
> > I was hoping that by moving the code out-of-line then the hot part of
> > the function could be inlined into things like reading the hex
> > character. I didn't see that, presumably there are too many callers
> > and so that made the inliner think sharing would be best even though
> > the hot code is a compare, pointer dereference and an increment. I
> > tried forcing inlining but it didn't seem to win over just having the
> > code out-of-line. The eof check should be very well predicted. The
> > out-of-line code was branched over forward, which should be 1
> > mispredict but again not a huge deal. I didn't do a more thorough
> > analysis as I still prefer to have the cold code out-of-line.
>
> Ok, I don't see much difference with this change.  But the change itself
> looks fine.
>
> Thanks,
> Namhyung
>
>
> Before:
>
> # Running internals/synthesize benchmark...
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>   Average synthesis took: 237.274 usec (+- 0.066 usec)
>   Average num. events: 24.000 (+- 0.000)
>   Average time per event 9.886 usec
>   Average data synthesis took: 241.126 usec (+- 0.087 usec)
>   Average num. events: 128.000 (+- 0.000)
>   Average time per event 1.884 usec
>
> # Running internals/kallsyms-parse benchmark...
>   Average kallsyms__parse took: 184.374 ms (+- 0.022 ms)
>
> # Running internals/inject-build-id benchmark...
>   Average build-id injection took: 20.096 msec (+- 0.115 msec)
>   Average time per event: 1.970 usec (+- 0.011 usec)
>   Average memory usage: 11574 KB (+- 29 KB)
>   Average build-id-all injection took: 13.477 msec (+- 0.100 msec)
>   Average time per event: 1.321 usec (+- 0.010 usec)
>   Average memory usage: 11160 KB (+- 0 KB)
>
> # Running internals/evlist-open-close benchmark...
>   Number of cpus:    64
>   Number of threads:    1
>   Number of events:    1 (64 fds)
>   Number of iterations:    100
> evlist__open: Permission denied
>
> # Running internals/pmu-scan benchmark...
> Computing performance of sysfs PMU event scan for 100 times
>   Average core PMU scanning took: 135.880 usec (+- 0.249 usec)
>   Average PMU scanning took: 816.745 usec (+- 48.293 usec)
>
>
> After:
>
> # Running internals/synthesize benchmark...
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>   Average synthesis took: 235.711 usec (+- 0.067 usec)
>   Average num. events: 24.000 (+- 0.000)
>   Average time per event 9.821 usec
>   Average data synthesis took: 240.992 usec (+- 0.058 usec)
>   Average num. events: 128.000 (+- 0.000)
>   Average time per event 1.883 usec
>
> # Running internals/kallsyms-parse benchmark...
>   Average kallsyms__parse took: 179.664 ms (+- 0.043 ms)

So this is still 2%. I was building without options like DEBUG=3D1
enabled, so perhaps that'd explain the difference. Anyway, if you're
more comfortable with a commit message saying a 2% performance win I
don't mind it being updated or I can upload a v2. It's likely this is
being over-thought given the change :-)

Thanks,
Ian

> # Running internals/inject-build-id benchmark...
>   Average build-id injection took: 19.901 msec (+- 0.117 msec)
>   Average time per event: 1.951 usec (+- 0.011 usec)
>   Average memory usage: 12163 KB (+- 10 KB)
>   Average build-id-all injection took: 13.627 msec (+- 0.086 msec)
>   Average time per event: 1.336 usec (+- 0.008 usec)
>   Average memory usage: 11160 KB (+- 0 KB)
>
> # Running internals/evlist-open-close benchmark...
>   Number of cpus:    64
>   Number of threads:    1
>   Number of events:    1 (64 fds)
>   Number of iterations:    100
> evlist__open: Permission denied
>
> # Running internals/pmu-scan benchmark...
> Computing performance of sysfs PMU event scan for 100 times
>   Average core PMU scanning took: 136.540 usec (+- 0.294 usec)
>   Average PMU scanning took: 819.415 usec (+- 48.437 usec)
