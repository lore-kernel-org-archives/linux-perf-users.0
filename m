Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1FF269CE1
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759239282; cv=none; b=REbwAr/vKV8Xv3z1bijiYLsZW7mH/kso9gOeo+BBP6mAvb0ka3fMJRrRSzj7mgELZ6xPG2j06uaaWT21Cd/fRU46tJbmzr+6nR+htzS0NpCs+8EZHDWFMI/8JjRqci+X4BRcPIcuFqk5hvV/QUQpRYzT5Aero6D89+L5mlNHNy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759239282; c=relaxed/simple;
	bh=QYA9ZS3nTBF31+lC8H1HhwMWJOz7p0DGAI957bXrWdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwpAmBjA2C5aZUYteKYzqutCBrwtFaoaBwraYsio2n2qzzAAUZhTUW5wZGRAhvyO6TifKnUfl072GyCcOwhEhdrEXRy6bxHaFexquUPIJCGIybgGbl7Rr5/DlEZN0LNO2T05N2RBflWbSlIiXdOGXq+56+T9FEzc7gonBRLCUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RRG+gCcX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RRG+gCcX"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27eeafd4882so239965ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Sep 2025 06:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759239280; x=1759844080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZQOSklwaJbj9QMf0lihBQFKqqaQfGKCx5cuxtJa5tc=;
        b=RRG+gCcX87TLkYmq5M1xZ7yHQILaJdy4kVnfrRj5J0vEtGhYqbbMyqicdetUnsa3Bf
         7FriTkM0eIh1kwA0xXbFNHoVb+5PKSNsqeXNY13qSkISJ1agtLx6SIh+8ZaC9/WThOYf
         rK250joDrnvTQiHXBtyxzBj/emireZoXqWgA6wM2K5/TVycCzaVSweopDgsM16de/GH6
         fFDntL4dU4+60imvjqQH6MN3PSF3KCiaLORvlpsjoCDMEJx7jmmfakShdAjxfwNivF0z
         nzUmjnukYmHB/T+NViiTPGZ/pq2jkGNXmyUkqPQakF4oFLjCdxWarl5IJf1W+klduvhm
         RLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759239280; x=1759844080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZQOSklwaJbj9QMf0lihBQFKqqaQfGKCx5cuxtJa5tc=;
        b=vh1fMUUMyPGyDjkqHaH51q3A3Vb2u4uBSbIrvTlT5t9uY/BE+0bsBcim4nWzdDQ5t7
         GECrZJ1/1oeC9uOpSIGpml1y3P04KnMPxWXLMuaEx4uSqgkeCVk9B1SYX6HnuRigL7va
         72QkNXzY2R06sVlNjPAa8CDZJunBtSNKLHUdM/d3t84yr0VuFzFn7Eb9jR3fQgbpRKxE
         krl4Xi+By20L5rx8oXOMxWMQ4IgpSHoDL7rurlORAuBzn/NVwnVKBvfnnP3eJqUJyi9I
         S6YLs7wb0o71a6Mb3CpvF8gEW1od2bmLsCwXx04FVqqEjmnyN1iH79wbZD6zywkTZ0Vg
         TQXA==
X-Forwarded-Encrypted: i=1; AJvYcCVcUVlX+z+1ngQ6MrauC4zRN/gSwCxepMFG9Wwcy2g5MGbPHc+IBYdjcxKYsK8b6b1BoKQJDUcImUtbXmcXJKAV@vger.kernel.org
X-Gm-Message-State: AOJu0YyKunD7wxiWf2DbwqcmWk/swwFdTv9GVaj7b1hAVQqhGMSzEkYC
	+7pC5UPVZ6rSKjQOqpIhkF8XIuiF3S8V4g+/ZxvqJQhr2XPae+zfRJeTxdTd5xg/wdQ+3hgos6X
	bEs8Ew9mUX4IzJCEm2ovcSuDbvBBcVOzUvflzuI3D
X-Gm-Gg: ASbGncsV9ird5CbUqWRvWkEE+mvy8RtPq0bPg6Ya4ilaTlSQU6uMY0BEgEYnAKygczl
	m6nFySrzDV76zSTyh2clu+a5xG8V/T1lh0fpuKNkVAxE3mvYG48Sb5Yz1Lsam6FXuBZwMJppIrN
	X4aykKcQdQe/p8dHiduqodQCqtT9WObkJqIrIejEW5g70/b+10Wi01CZIUcvUiLl32lnJ+FBv7C
	fxUG4MB7kh14PMqCZ//1vt6oVo8LagR5ByXLozm/1CGXbdcqbcYwn2J1s2+yMjI9orAH1fCqsU7
	gfs=
X-Google-Smtp-Source: AGHT+IHqisIbtiuNfwe6E2XyhxwiOfA4N7QX7pdJVONS1CfRxUb90g8yf5fvfGlC46BM8AA58DwsRsPF5r6X0yHekQI=
X-Received: by 2002:a17:903:2f08:b0:274:506d:7fea with SMTP id
 d9443c01a7336-28e641723demr3683925ad.5.1759239280084; Tue, 30 Sep 2025
 06:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <VI1PR02MB39525F61113D96E3671BFA1F9C1AA@VI1PR02MB3952.eurprd02.prod.outlook.com>
In-Reply-To: <VI1PR02MB39525F61113D96E3671BFA1F9C1AA@VI1PR02MB3952.eurprd02.prod.outlook.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 30 Sep 2025 06:34:28 -0700
X-Gm-Features: AS18NWBDNfMrvaXr5ucR3ZJBWu_057l2ITsOvsDbp7Wm-ryZHvd39gE4bNj8rcE
Message-ID: <CAP-5=fV+hfVLcmfPR-CKo7_ZB+AT7JpwV8rVVUAb7rmJNL705g@mail.gmail.com>
Subject: Re: inux-6.17/tools/perf/util/lzma.c:123: Strange return value ?
To: David Binderman <dcb314@hotmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"mark.rutland@arm.com" <mark.rutland@arm.com>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 3:19=E2=80=AFAM David Binderman <dcb314@hotmail.com=
> wrote:
>
> Hello there,
>
> Static analyser cppcheck says:
>
> linux-6.17/tools/perf/util/lzma.c:123:3: style: Non-boolean value returne=
d from function returning bool [returnNonBoolInBooleanFunction]
>
> Source code is
>
> bool lzma_is_compressed(const char *input)
> {
>     int fd =3D open(input, O_RDONLY);
>     const uint8_t magic[6] =3D { 0xFD, '7', 'z', 'X', 'Z', 0x00 };
>     char buf[6] =3D { 0 };
>     ssize_t rc;
>
>     if (fd < 0)
>         return -1;
>
> Suggest return either true or false.
>
> Also, there is a duplicate of this problem at file linux-6.17/tools/perf/=
util/zlib.c
> line 91.

Thanks, a fix was already committed to the next branch:
https://lore.kernel.org/lkml/20250822162506.316844-3-ysk@kzalloc.com/
and the fixes tags should mean it isn't long before it is backported
to the stable branches.

Ian

> Regards
>
> David Binderman
>
>
