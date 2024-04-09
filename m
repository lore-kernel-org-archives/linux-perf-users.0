Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A214613D631
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Apr 2024 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712678666; cv=none; b=Xmo8LUBYz7T2h59YPFZnCQI6Pf22lt2RhkZNE+L4yIx8ynh3Rd9wecutIbK2i7eXDGyjBY5IkKjV18+IDJO6rTYGFuvGXpxXABysuL+qibFWyB7mpGhVIy+5sIaCQblF97eWuLN6Q+lo98MHkzRfuE/9qn+119p3IlGZdrKgE5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712678666; c=relaxed/simple;
	bh=ol8O3/Qu+bjdL/dGoc/J7NHq0r7ACqYxDaVzpJ+SLaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GHgvW+v0+ePqaqV371/hQQgXkJnZ6TAH/cTuezO9TkIsPQRVlm94BPEn/bw5ocXEsqfPHWHtAAtf1U/uMeYVd8AMCEuSoXZLiqdz5xHHXrRkGPinqGuD3FDcMdOHey/qDloqffOZvvbzNnBIh5btfuUa8yhRKydQCnbs4spZRvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yi7EZlQ1; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yi7EZlQ1"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e44f82ff9cso122145ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Apr 2024 09:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712678664; x=1713283464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQUeK+ooPMeTOP4LmlA2cpGhF85DlqGUYugsLHSO63A=;
        b=yi7EZlQ1ZVXZJpmcQr5TIheiiWOjWiE/F3tFoe4nbwHOyrA3nGDgHB53QrZ8hpWj6I
         /gcrUiIDf+1ltNNN+akUmy0T4pbKAPtLG2MugOm2vDBnSarBc79jOWSdhuZYROQ8egdo
         JX9fC7Y3skqnbOKwhcF+p6N8ZMuKUevvbPaF6VtmEdWPhdvd+P4xRa42V0bav8mScECB
         5O0Z+A+I2jE8oYQ17qfgFTCbR2bU9T2JVOKkh++J6vlzXm8j06Y99R1OG4XkDwpd5xuW
         jZNfCdrlQXd13JHkF4SA4TMPeDfIl6BMD8BcPUsYFonjorxgfQRCTLjTNnA31uJlh85y
         5Mkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712678664; x=1713283464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQUeK+ooPMeTOP4LmlA2cpGhF85DlqGUYugsLHSO63A=;
        b=C1RJ27mQlWGEIvEYyJluQTBRVqEwAQlfqKXFFN1r/0pMX0v6ToNictd5sd2ZWwUhvC
         NnDPvdg7pJfmCUuKJ4wBDfLOOkP3DH6SWxWWEUdnJkevv+frBkLLgMBIEuarxQGPjs2w
         X97rrPq8tdiExALTSIelKHrw+a4tPoMbtAtafQqpb5V1DRnSQn6fs6xU2cTVMcL8sSeG
         R2SUMkTMzekjBX7lwEUS51i9LlHJUng9mPO4MuEod+5d3eghjQQM1BhHH5sELA5I9L5r
         JMe75HN5spdjBjAH36bSnV1H79PZYEKBEG6A0rbR4VAlg8iiI8fp1Q1FfDrDJZ5u6E6o
         EiuA==
X-Forwarded-Encrypted: i=1; AJvYcCWkL/rP0NefbCZs4x17jSDfbaMh2iaHYsi25OhOBzrRKDJzYApo6neBvCKskoP9+uxmmbt1NH3L9DoJEljU2CnsYzaPXMsIKssbcrGSQgGvzg==
X-Gm-Message-State: AOJu0Yxz6yG/JnKOYY7JtCBwGdPmOTZMYpTxCgZvCaBircmhdSVe//P1
	dG4reSCWNPKrXKGDu5Hh08uvcRauT2YSvImcqVPuTIQNtigttVLOAKV96yuriXnfjKYCb+66ktm
	EIywfdDzHet1IWTVHb+mM2tksj+P3idIRc5f6
X-Google-Smtp-Source: AGHT+IHstTaEeDKuv7ONHRg78iPJFI7H0d5nLLTLzLOPoqQiSgAOYfbfwB52cXWqX0xW6ysGQ0XXDmHjXvmHJe8WIAQ=
X-Received: by 2002:a17:902:d4c3:b0:1de:f0c7:108 with SMTP id
 o3-20020a170902d4c300b001def0c70108mr240871plg.6.1712678661668; Tue, 09 Apr
 2024 09:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406073804.1932415-1-irogers@google.com> <0d498870-b235-4860-9563-befcddf0ec3e@linux.intel.com>
 <CAP-5=fU=bEvzWw+62HxL=5kOSqQxaBYeDBomv8Fdu+R+fNv5sw@mail.gmail.com> <cd4b5229-b938-44ef-822a-68d29c463aa7@linux.intel.com>
In-Reply-To: <cd4b5229-b938-44ef-822a-68d29c463aa7@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 9 Apr 2024 09:04:06 -0700
Message-ID: <CAP-5=fUNTiju7sv5R3P+=rUm-BzL_HmaEicdhCuBVPKooPHWeA@mail.gmail.com>
Subject: Re: [PATCH v1] perf stat: Remove evlist__add_default_attrs use strings
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Kaige Ye <ye@kaige.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 9:00=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2024-04-09 11:20 a.m., Ian Rogers wrote:
> >>> +             ret =3D parse_events(evlist,
> >>> +                             "context-switches,"
> >>> +                             "cpu-migrations,"
> >>> +                             "page-faults,"
> >>> +                             "instructions,"
> >>> +                             "cycles,"
> >> "cycles",
> >> "instructions",
> >>
> >> It's better to keep the original order.
> > So the original order was:
> > "cycles,"
> > "stalled-cycles-frontend,"
> > "stalled-cycles-backend,"
> > "instructions"
> >
>
> Right. The stalled-* events are added between default_attrs0 and
> default_attrs1.
>
>
> > but many/most/all core PMUs don't provide the stalled-* events. At the
> > programmer level instructions is the most fundamental thing, so having
> > it last felt wrong hence moving it to be the first after the software
> > events. My thought was, if we're going to reorder things then let's
> > not do a half measure like:
> > "cycles,"
> > "instructions,"
> > "stalled-cycles-frontend,"
> > "stalled-cycles-backend"
> >
> > let's just put things into their best order. It is obviously easy to
> > change but having this way wasn't an accident. There's obviously
> > subjectivity about whether cycles is more fundamental than
> > instructions, my thought is that you get taught instructions first and
> > that these take some number of cycles to execute, hence thinking
> > instructions should have some priority in the output over cycles -
> > some people may not even know what cycles means, it is hard enough
> > when you do given the variety of different clocks =F0=9F=99=82
> >
>
> My concern is that there may be someone who still relies on the std
> output of perf stat default. So the output format/order matters for
> them. Their scripts probably be broken if the order is changed.

I think making everyone suffer for the case of a tool that may behave
in this way doesn't make sense. The tool should transition to not care
or to say the json output, or at least contribute a test. There is
precedent for this attitude, the default metrics for topdown removed
the event names in perf stat default output - no one screamed, and I
expect that to be the case here.

Thanks,
Ian

> Thanks,
> Kan
>
