Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974A92620E7
	for <linux-perf-users@vger.kernel.org>; Fri, 16 May 2025 17:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747415443; cv=none; b=uHokDMoqQQWQb6Q4yS30j5ot1a2r8KNfKR+GXsGGZqx2cayQJmCarGhbSP8VXlnhRtkKXqNMv2pa/VtA6RA7VlC47vU0KsGxUtEjryu9H/AX4+SnjrCV4xblcgyflMwpn4pxXeP/keX3BQ/axRXrEwc3XBU9uvRAmPZ3ez5Wpck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747415443; c=relaxed/simple;
	bh=G6qWcf2f0b0ZiprK6YnOZRU4oWNHGHo/J34bbeqy3AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2G2f15dQWWEjXl9nbUcKxN//ndYOMv6O3QfQxMzl1WEfSVBEMAijgdvmjqqziSAUaoYPEviJAXJgxxdQHECjddPom4bfakFzAw7vQFXPvT00LE8OK3/qRNNz8Ccpno4/vKjjFSEMwxjHYPEEVjlR2Rm21odiPobZ3S4Q0QZD14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k5fcNovM; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k5fcNovM"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6000f2f217dso3614875a12.1
        for <linux-perf-users@vger.kernel.org>; Fri, 16 May 2025 10:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747415440; x=1748020240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gerRkJKHTQKNvQo9k3X99QHawPSXLzta86cYlEnhtcc=;
        b=k5fcNovMyxgMBUQASf44vbsDXb/ZiOxy1rXPzsFaCG/jn664RFBwRzlFHXgMzH+9WA
         VSTeoRSgiHLzWrb89vLuoVadP/YK40ePAulRKCgO8uwFGKx869VCclu4DGNwn1GCvRA9
         DO16Cs0uwm865qX92l3l5t+KSJAyiQSNFedEWe15NEwApFdnSz6HrKL72fLQXcJUsTkc
         liA1xxpwQI1R8RSjCHy7ZW/OhFe4RbqOxuA23ecOhDOpryRcee3E338Q+yE9FnuAJfPp
         p9Yzs38i9bA7uRFgdNvekujhCkfIrvuTDJnIY5jV3PZKgaiwf4szcUkTd6PiBLakH97L
         3FJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747415440; x=1748020240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gerRkJKHTQKNvQo9k3X99QHawPSXLzta86cYlEnhtcc=;
        b=qm0e5EJ4wTDDR/BASn2iR3CvtKtPg53VwApb7xtlR+kdzGVm2dhxBALSBiBetmgWFE
         SVpELzGNqeV6nnl61IDLlojamlPzsJ7gd7SzaCEWcvkOkbw0SeHM+svTLkAHYpGlx7mz
         cCDMcLmoXfBuxI2GvN3wAQSmo9oVnronDRAUrsOmTA80m8Gs0DJfLqdYmVXI5r7+cJje
         qeFlU41WiDE3PkcZG6JIh8wWy7E0VOhZOdp4j70wHKUJOd7pqTeTp+vM2lb+3YjXpk/z
         2BIEm4uHsAL+/GFSFlNROMWXlTHCQJSJK60gDfuk3geeFpH3V1m03y+MhfzmLj0OUjRD
         tNag==
X-Forwarded-Encrypted: i=1; AJvYcCU+DEU77WCNb567vJhMOzcpf6KOABAeTdzRr8PSOWNZdC35CtLKyVnENnhyOG82jUNyAWKoFpRBIcMCJpB2iXKM@vger.kernel.org
X-Gm-Message-State: AOJu0YyVx9WlfBsBlN3lyRmncj9INI1f1Auvh8RdnuBSxgWpSG8Pe/5h
	fnglbRk6ZMDPgHxx8sJdVkRfCrmSq2/8plSfB3/xf4dIry8zhQ6w6QZtRlL/xuTPkp9Giu85xjR
	Ps8qrq+vfWdKTXfSU9SbRUhKZ6HBs7ZbNn96QZalK
X-Gm-Gg: ASbGncvn+MnpyibdoEJoJXU3jez2q8LmNfM0Ix3tp4tlGk9CLciD2T968YX0WkDNo/F
	Y9zRiMZ/MenUhSRf8Xi4EbFD3mxtnQyAua2G3hWzN0jiXQX1FR4a88Qj7FQ1pn/c+JMIzKD9ZMD
	fbrTGJRma6whCDz0xU3Ml7EODtGkBRo6ca7w5A4b+cWA==
X-Google-Smtp-Source: AGHT+IH3dUSAi6c1I9L11RyH3JvAS1lfke58i5i+2bvcKcpNPnFkk++9/uDN4MZ8LU+4SM8H+CNaUrMhVbgkifEKQaU=
X-Received: by 2002:a17:907:980d:b0:ad2:3f1f:7965 with SMTP id
 a640c23a62f3a-ad52d43838fmr435418166b.4.1747415439480; Fri, 16 May 2025
 10:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303183646.327510-1-ctshao@google.com> <Z9TXabugl374M3bA@google.com>
 <Z9hFJtEKfsGGUDMg@x1> <Z9hLKsZOfouM3K7H@x1> <Z9hR8M-SQ5TD2qMX@google.com>
 <Z9iHiTv_ud6GEhJh@x1> <CAJpZYjXwUz7x1XUF7AzgYR6PZo_igrwK9BkxGx_3N0pCs1YRvw@mail.gmail.com>
 <Z9iY7HFebiSaWZJQ@x1> <Z9kBAhEKKphn8JL6@google.com>
In-Reply-To: <Z9kBAhEKKphn8JL6@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Fri, 16 May 2025 10:10:27 -0700
X-Gm-Features: AX0GCFuxZaVWDjQvfXAkXFtuvUXS80ty4Z15Tq9hfM3hchhkS1MSN6mO7AulQsg
Message-ID: <CAJpZYjVeMrjN09kaVCBs97q8_hnsgwwo7s0C0ctL5Kt0_FknBQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf record: Add 8-byte aligned event type PERF_RECORD_COMPRESSED2
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, peterz@infradead.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, terrelln@fb.com, leo.yan@arm.com, 
	james.clark@linaro.org, christophe.leroy@csgroup.eu, ben.gainey@arm.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping.

For suggestions from Namhyung and Arnaldo, it was merged in:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/co=
mmit/?h=3Dperf-tools-next&id=3Db1b26ce8bb0eab1d058353ab6fa1a2b652a9a020

Thanks,
CT

On Mon, Mar 17, 2025 at 10:13=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> On Mon, Mar 17, 2025 at 06:49:32PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Mar 17, 2025 at 02:45:39PM -0700, Chun-Tse Shao wrote:
> > > On Mon, Mar 17, 2025 at 1:35=E2=80=AFPM Arnaldo Carvalho de Melo
> > > <acme@kernel.org> wrote:
> > > >
> > > > On Mon, Mar 17, 2025 at 09:46:40AM -0700, Namhyung Kim wrote:
> > > > > On Mon, Mar 17, 2025 at 01:17:46PM -0300, Arnaldo Carvalho de Mel=
o wrote:
> > > > > > On Mon, Mar 17, 2025 at 12:52:09PM -0300, Arnaldo Carvalho de M=
elo wrote:
> > > > > > > Checking the discussion and the patch.
> > > > > >
> > > > > > My first impression yesterday when I saw this on the smartphone=
 was: how
> > > > > > will an old perf binary handle the new PERF_RECORD_COMPRESSED2?=
 Will it
> > > > > > ignore it while emitting a warning, since it can be skipped and=
 then
> > > > > > what we will get a partial view?
> > > > > >
> > > > > > Having some session output showing how an older perf binary han=
dles
> > > > > > PERF_RECORD_COMPRESS2 would be informative.
> > > > >
> > > > > I think it'll show the below warning:
> > > > >
> > > > >   <offset> [<size>]: failed to process type: 83
> > > >
> > > > Right that is what I got:
> > > >
> > > > =E2=AC=A2 [acme@toolbox perf-tools-next]$ perf.old script -i /tmp/p=
erf.data.ck8
> > > > 0xbf0 [0x250]: failed to process type: 83 [Invalid argument]
> > > > =E2=AC=A2 [acme@toolbox perf-tools-next]$
> > > >
> > > > I think we should change that to something more informative, like:
> > > >
> > > > 0xbf0 [0x250]: failed to process unknown type 83, please update per=
f.
>
> That would be nice, but there are cases it can fail even without new
> record formats.  So it should also check if the type number is greater
> than or equal to the max.
>
> > > >
> > > > And then does it stop at that record it doesn't grok?
> > > >
> > > >         if ((skip =3D perf_session__process_event(session, event, h=
ead, "pipe")) < 0) {
> > > >                 pr_err("%#" PRIx64 " [%#x]: failed to process type:=
 %d\n",
> > > >                        head, event->header.size, event->header.type=
);
> > > >                 err =3D -EINVAL;
> > > >                 goto out_err;
> > > >         }
> > > >
> > > >         head +=3D size;
> > > >
> > > > So we're stopping there.
> > > >
> > > > Maybe we can just warn and skip?
> > >
> > > Thank you Arnaldo, it is a good suggestion and I will work on this la=
ter.
> >
> > Thank you for considering that, really appreciated!
>
> It would be hard to process misaligned data though.  Probably we also
> want to add a check to make sure it's properly aligned.
>
> Thanks,
> Namhyung
>
> >
> > perf deals with so much stuff and code flux that all the help that we
> > can get is what is needed for it to continue to be relevant and useful.
> >
> > After all what is the point of a tool that produces bad results? :-)
> >
> > - Arnaldo
> >
> > > -CT
> > >
> > > >
> > > > Anyway, the series as is seems ok.
> > > >
> > > > I'll test a bit more and send my Tested-by
> > > >
> > > > - Arnaldo
