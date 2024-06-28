Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C105D8005B;
	Fri, 28 Jun 2024 22:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719612492; cv=none; b=qXX8M2yaUWZb5n4dtyK535apABWuXsj8UAj5G9iCoWxJpbdV3UWWw4jLZnRh5TgMZeARB0QT6RDV1LV1KR2f7yGlZKhYOKLhK3wKLAdf/UgRjRQslFnQIhWPW1TZg8/edN6Wx2lVoxPGuuzFCCLa6jImSfv+LFF9X0jilKkOAN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719612492; c=relaxed/simple;
	bh=SlYDa3nHU9cti55kEvXj2xLvOYUAo+BxcVz6vOdWyjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFKAHwoMMyPaek6S/ag0ZmpAsvLVOFkgVaimBNl3nAqQkHJ2i+50VebB/Clw65f3az2smvRW9qYqFoJUbXeazj+OMF5+uXWN9OtXx8iCc0uKbyFXLQRj3G0NCUpBN/dclcMLzJ4kVAkJqCp6g1fRYUR5FA/zTpzK9OGXP5W1OsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-707040e3018so763785a12.1;
        Fri, 28 Jun 2024 15:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719612490; x=1720217290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owuI9bhRt4SW/JGERO2LK5tci8DsNjEap5zwXWZimQw=;
        b=t9sRUrU7F3LTP9PCAvoPMzy0CmD5kD00UKR2hfw1LdeCtfghp9WIidsaFz5hBfLU9+
         6snO8fH0Yrvhe6Mf24jSkydY+w7xHPC40YEERUXSaSNRGErVSpZqqhaUud02V/FRFuax
         1/WHK2NtK3yjIOb/WBcs7G+MP8/JhyVPgtHlOrLHtO/kS6+d7MIBWAatWpCnAbsDbdPH
         wYmaRIAmarrg6qpA8cuW01IH/+OqY5B0YHhfeq6UOwZ5tf2QCPA3SSrBHx8yB2X/2ae6
         WBqLUiA/RAzHbDwcPHeDLuMzGDmhLqod7BAaCR9Yx6lwGnGB1dglB/RH9mIAGbxeRUv2
         y3pA==
X-Forwarded-Encrypted: i=1; AJvYcCVHe9YvpAl4M41UbnGyQeN79RZF+uFnc2aRdePHtxSoP4Opu9tSf77C3W+RMZjP0xea3Hc4zQrNQbxPAv6LfCYFYxGg6r1s7YkhDUpU2AFsTIzFRyPFRfpomeROi/Q7WQsSfildJUIgoChhIWFt1w==
X-Gm-Message-State: AOJu0Ywa+Ju3m7QpB2sQdFz+OxIL2t1XxXbX9aonzNnW94e0ppn4zZu3
	1FQGHguXE0MZsa4NyWtGxVEhvOr1ZfunBL+0AclDjWFtd2seb+eB4rA0tjlQZI4e5Znz+hXCmvV
	3BLrPKI3eyzpSxKzCTzz3VVZ5IXM=
X-Google-Smtp-Source: AGHT+IHSMx0Hds7q5w8G8pTdswpQ2/f9z7Hnq4U19v0U2ZxtS2QIqmkZVcn6xijglajyEmuKjacvsuKvmZrlbO9lY+I=
X-Received: by 2002:a05:6a20:841c:b0:1b2:3ab8:5194 with SMTP id
 adf61e73a8af0-1bcf7e7ee71mr25762059637.23.1719612489958; Fri, 28 Jun 2024
 15:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com> <Zn7x6u7cedoFIHSi@google.com>
 <CAP-5=fXQ3nFZQRMTd+7wp2jEecRt2ykJ57oBO2=qqbnEeyQRvA@mail.gmail.com>
In-Reply-To: <CAP-5=fXQ3nFZQRMTd+7wp2jEecRt2ykJ57oBO2=qqbnEeyQRvA@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 28 Jun 2024 15:07:58 -0700
Message-ID: <CAM9d7citDe_Es-j4AY0bowQkiiF016zZEZUPsWyakY7Rv_+V5Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/27] Constify tool pointers
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@arm.com>, Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 10:52=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Fri, Jun 28, 2024 at 10:25=E2=80=AFAM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> >
> > On Wed, Jun 26, 2024 at 01:36:02PM -0700, Ian Rogers wrote:
> > > struct perf_tool provides a set of function pointers that are called
> > > through when processing perf data. To make filling the pointers less
> > > cumbersome, if they are NULL perf_tools__fill_defaults will add
> > > default do nothing implementations.
> > >
> > > This change refactors struct perf_tool to have an init function that
> > > provides the default implementation. The special use of NULL and
> > > perf_tools__fill_defaults are removed. As a consequence the tool
> > > pointers can then all be made const, which better reflects the
> > > behavior a particular perf command would expect of the tool and to
> > > some extent can reduce the cognitive load on someone working on a
> > > command.
> >
> > I thought you actually wanted to make the tool const (rodata) but it
> > seems you leave it as is but treat it as const.
>
> So I think that is a next step on top of these changes but it would
> need something a bit special as we want to default initialize some
> fields but then initialize others. Something like (which wouldn't
> work):
>
> .tool =3D DEFAULT_TOOL_STUBS({
>                .sample         =3D process_sample_event,
>                .fork           =3D perf_event__process_fork,
>                .exit           =3D perf_event__process_exit,
>                .comm           =3D perf_event__process_comm,
>                .namespaces     =3D perf_event__process_namespaces,
>                .mmap           =3D build_id__process_mmap,
>                .mmap2          =3D build_id__process_mmap2,
>                .itrace_start   =3D process_timestamp_boundary,
>                .aux            =3D process_timestamp_boundary})
>
> Being const is just saying hey all these event callbacks aren't going
> to mutate the tool, something I wanted to rule out as part of a change
> I'm working on.
>
> > I'm curious if we can change the event delivery code something like:
> >
> >   if (tool->func)
> >       tool->func(...);
> >   else
> >       stub_func(...);
> >
> > Then probably we don't need to touch the tool and make it const.
> > Thoughts?
>
> It works but the approach needs to change all tool func callers. I
> think it is also more obvious as an API to have a default value and
> override it, rather than giving special properties to NULL that
> callers should adhere to - we're doing a kind of poor man's virtual
> method dispatch and you wouldn't typically expect a NULL check as part
> of that.

I guess we only have a few callers in util/session.c.

Thanks,
Namhyung
