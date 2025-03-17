Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0819919F120
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742228577; cv=none; b=bnc0ieF2KPSN3UOyaccTVJSCNcqiHMOqU5PxU9vlNS7rUy1u5fYf6NN4tWhew6Jgr35apyv6EGkuRK9WFY+enbC5mUCWW1h9rGKIUxwJbOLG4bQj1sBFAkTiFRgplgC7YDqZH8R8jc6bkBzrxsczz5XsP9aJhNNskwpZpE5x1uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742228577; c=relaxed/simple;
	bh=APzyuFHBTGMrxfIH3Njwymc3R9+HIjMnH4ACe4NgVEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=RQbx9e1Mz8lKhmDLgjp7huUnjZm0MsPQIzuQnuh/YRTnQTf2P87/eEBnk3FtMt0FTAx8ehgOPuC3lqnJbZaHjlMF43MbxygBUMERd4go4Vtz5Q9rTYR0qL/ADIlIAJavDP6DAfeRX0SfFKW/ohFmGbPCm0tXMIFEbfPSTIvVqyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Za4XG4i/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Za4XG4i/"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2240aad70f2so51605ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 09:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742228575; x=1742833375; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cI/NBBP6a2u02KtJF9xtB6xkZu2x4DHKqcwXfazBTNw=;
        b=Za4XG4i/tBXvsijosDxpIGfZWwByPJcY1rSlycCEFVhoKoCdz1GUlggbJN1Ug4VbXQ
         01+qarvmmEeLmydmb6mEJ8obJZRBsODBTtF5BKj2s7VxNg0TpDz3FRETQuN3d4TW56yu
         pH95OyTqdI95x8OET+Xy2A1IvOl8jrXXYVoH8dqt4Yq3ZSs035neSA9sbDQccjGHFXx2
         RX7Q8eEUJqems2TdqbJ3c6WnqtldPOOB3AJuuXiarohcAv6KoVj/YGgZYhrkdvvoeBc7
         DJCRhJIkhglbpdNpUTMSq4yaJYqNxqmj5L9m9mjpHipT5VLVuVP0Tqtfj7b4x7aqce1F
         dFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742228575; x=1742833375;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cI/NBBP6a2u02KtJF9xtB6xkZu2x4DHKqcwXfazBTNw=;
        b=usU+Z2GFs7nIagf9ONSog2lxXZiw0EOsohcCZUH6JUTcRVhKvkNikK6cpXAZ5PVWH3
         dWmD6J6odNemHXw9A4Mk+nQlgG84fVGtyZb0U1hDxpFtll6M4huI13iBFUlhrOjQT0ur
         hjnn66iQyp9janko3sXnDTq8Fuj4i/qvgFzudWnxUnwF+BfMLkTzkB7S/l71ppgNvEk8
         /r7ZvI1n0uA1q5SW5dsqzA//6U7724LZtFYjWrobwlRFnNO/G9MvtGBuERYR4SV6S78z
         gBOE0dbal9RVehmaxfCIFBjRlHm6GL+TqBNxdTn8Q2XFesYYRMYmNL5vw1ddwiRwAUJk
         M2CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMvxW3zcbJziIjelIDLkosOHQfHOWb/G52cRwvqpAv3PRDhupJDAeDA46ltsutc6Q9+mzR5wuYhijFheB9A2Q4@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+cgqljikcczH+9dFyFYLim1yzk0Yv0g0iXbsqBn1SqQCDCZRG
	jcIms679p3JWd93qNcS1MP9f4o6tlC8ZrRlc4wbdytdBsxfvU3VYLi2q5dSmg11iJFLbfQn62gC
	tUXbJFK01XsCiUP5xsWniJ7ts9vjBGKq6gomQ
X-Gm-Gg: ASbGncv5L7jG1upJRdbDFcBfyA1e5YbI1tsHhJ5LOOIQQvu0yb58606eUTCD2udColJ
	0Qzm0BMzhPsPa33B3n+dspPEOJnYV6wC09UCAA2E6nZIL7j8gU+5aWLDyQdyW49PcgBK2GMGGUp
	D3xy4xZ9+H4oywu3oyxesLrNZitZNw3zksaS3iQRP97ODPgmatbORcVcc=
X-Google-Smtp-Source: AGHT+IFOK87UnBB0mY1F+kwN+ps4KiWKMyJmdvkSBPkz30vTxZyulOW1oKjCSKzg5kO5BmGcLLPbd+vuc37jIIarScI=
X-Received: by 2002:a17:902:c941:b0:224:a93:704d with SMTP id
 d9443c01a7336-225f3c0e8a9mr4510885ad.2.1742228575006; Mon, 17 Mar 2025
 09:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210183808.130522-1-irogers@google.com>
In-Reply-To: <20250210183808.130522-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Mar 2025 09:22:43 -0700
X-Gm-Features: AQ5f1Jpd8P2JoIcocmi63i50Kw3E17a21rJAClkYrXLfOfkrJ-R0y41DHRP2IFA
Message-ID: <CAP-5=fVH=HN0csS6cXLPAYdk7Vn-g8FSdKWkaHcjfYKRA1o1Ag@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add support for cpu event term
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 10:38=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Being able to set the cpu mask per event was discussed in the context
> of a sysfs event.cpus file is discussed here:
> https://lore.kernel.org/lkml/CAP-5=3DfXXuWchzUK0n5KTH8kamr=3DDQoEni+bUoo8=
f-4j8Y+eMBg@mail.gmail.com/
> Ultimately Kan preferred to have multiple PMUs with a cpumask each
> rather than an event.cpus file per event. It is still useful to have
> the cpu event term and so the sysfs part of the original patch series
> is dropped.
>
> v5: Purely a rebase.
> v4: Add the stat-display output change for zero counters Namhyung
>     requested as part of the series:
>     https://lore.kernel.org/lkml/Zvx9VbJWtmkcuSBs@google.com/
>     This skips zero values for CPUs not in the evsel's cpumask rather
>     than the evsel's PMU's cpumask.
> v3: Drop sysfs event.cpus file support patch from series.  Reference
>     to using cpu to modify uncore events is dropped from the commit
>     message. Reference counting issues on the cpumap are addressed.
> v2: Add support for multiple cpu terms on an event that are
>     merged. For example, an event of "l1d-misses/cpu=3D4,cpu=3D5/" will
>     now be opened on both CPU 4 and 5 rather than just CPU 4.
>
> Ian Rogers (4):
>   libperf cpumap: Add ability to create CPU from a single CPU number
>   perf stat: Use counter cpumask to skip zero values
>   perf parse-events: Set is_pmu_core for legacy hardware events
>   perf parse-events: Add "cpu" term to set the CPU an event is recorded

Ping.

Thanks,
Ian
