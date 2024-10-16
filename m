Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497C514F114
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090533; cv=none; b=KQ0YgDpsKU2F3jhKCESEcxZ5f65Rl6NGYF6ilKQKImbCMbtoUuL/xXi99SUUyDwNhdJo2hffsNkbcKN4U1Wc1m6JM9KcSvGopiGaOmJBs9tD1qZ6+3r357ZMTU5AKdC+pX392lgmZL0Or42MTnKxbpQHj7bKbU1y05mBrNmMIr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090533; c=relaxed/simple;
	bh=lhStgkW1nOmPDE/zibhXWPJlliM/BQNg1rEJG90y3R8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgu8xdeNXlsiog28AlPkIYQO+LIkIBySvLpETfWwwEyI3R9MnpypqS7DttdW6eXYyLd1kmoZ6NwRdfHUfeezJShDY0z3k7WeCfVFxfUD3mANp6j9L7f7gNBpJ85PSCvmlOFnMbhEIhXWcBjn+msC8OkHsl7sN9VB7iW3xaMbo5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=agmDJ8UU; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="agmDJ8UU"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so171795ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 07:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729090531; x=1729695331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5ndcWCV7GBa6KmSNUJ6McmDrO0FkYlO8NF3CckatKQ=;
        b=agmDJ8UUPD8qZNqIasRUSLjKi62ccJvOmPjOG3xj/UGR39qJUXcCj8haLNpK/ixbW+
         7Lr26Ryq2MXUby2lHvqpKwAo34hE1QNc/XjTjMr1odgpiWpGqx1cgo6b0MCcwAJBIrri
         A6zgQ0ixMgA7/R3Hjeu1tBTNCYP+mga+cko1PoC9zmn0wkif/0nFLjFx9LhgO/ue/t2K
         j50Qu/Ql2VrJjCFATyBHmxoZTgOQHHmxwSz1WQ2J7u66ptLG//fK6IsyGDDIeWuW9Wt2
         3RjQ/ifz0N93Z5ZV1Nmgj7bz5BGcsFKlSV/R/pm7sxdXyvLnM+OrBQV8SYcJeB/Nk+Ka
         WPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729090531; x=1729695331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5ndcWCV7GBa6KmSNUJ6McmDrO0FkYlO8NF3CckatKQ=;
        b=cGwqfSk+Q05DjUUSSK/W4jKByL2yruorEJ10wuZHiXPvFTWoIH6ZEd9rL8TRfGhbrl
         W/RKplQqDQCh3suiXgUE7oNIb5Owy/kvG6YhxiaMVtVdS7wi26aeB1TrkikHVJl/zCby
         BH23xRVUK84j4zJ7VKs9T974u0wS7dZrnbZk/KdnafCBfORKqbjpQEQhe01pxQoZP6NO
         a7wfT3Tl3tEls9N79R9XN6/5RcWbhN8vGyAZVmEV8DIssPiVEyK/yejQjJ6FuW0pGs1O
         Fk5L7ZJPAVEqRVjrBZtn0miLUMQBK50s+xM7AA38xnI6n/5zEXsi6YE9qpgHej2Boc2h
         2n3g==
X-Forwarded-Encrypted: i=1; AJvYcCUgmzV6QiWRPQBl/J+5VSZ06ZKfdufhlThbGX6zzfFXzUyt+GJexyR3cdvpEvDTcnN+5c/tnyWoHVt4Ags12Dec@vger.kernel.org
X-Gm-Message-State: AOJu0Yx12iPXE2+HFe3lJPEqY1+3mOr7iD2kfrq5wCVMw/aVhmioY2gA
	r8VTIvL08wIav5pPnA3Rkgg8z0KIUUrLrncWZQJxD7AB4dnjBbp+5Wmb2PvG8Jmov3Zsws4RrEZ
	hQtLj8KAVzxLXEG6/3hiZyAYYO6JX0PaElzlo
X-Google-Smtp-Source: AGHT+IFAD0SSxWQ+/5diCeKc7c0u4sL0M9E0RTFkufYU9vk1dYWzrc01o217x2qTlswxzulprYDuCd9aEEc+tGDtBM8=
X-Received: by 2002:a05:6e02:13aa:b0:375:bb49:930d with SMTP id
 e9e14a558f8ab-3a3de7d22dfmr2880775ab.23.1729090531199; Wed, 16 Oct 2024
 07:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016065654.269994-1-namhyung@kernel.org> <c28ce930-9a70-4f23-9f6b-541c16c212e3@linaro.org>
In-Reply-To: <c28ce930-9a70-4f23-9f6b-541c16c212e3@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 16 Oct 2024 07:55:17 -0700
Message-ID: <CAP-5=fW3So87z8Q+J5eNf+a2PP2toDe3GX5HB7akecR7TBV__A@mail.gmail.com>
Subject: Re: [PATCH] perf test: Speed up some tests using perf list
To: James Clark <james.clark@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>, 
	German Gomez <german.gomez@arm.com>, Carsten Haitzler <carsten.haitzler@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 1:25=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 16/10/2024 7:56 am, Namhyung Kim wrote:
> > On my system, perf list is very slow to print the whole events.  I thin=
k
> > there's a performance issue in SDT and uprobes event listing.  I notice=
d
> > this issue while running perf test on x86 but it takes long to check
> > some CoreSight event which should be skipped quickly.
> >
> > Anyway, some test uses perf list to check whether the required event is
> > available before running the test.  The perf list command can take an
> > argument to specify event class or (glob) pattern.  But glob pattern is
> > only to suppress output for unmatched ones after checking all events.
> >
> > In this case, specifying event class is better to reduce the number of
> > events it checks and to avoid buggy subsystems entirely.
> >
> > No functional changes intended.
> >
> > Cc: German Gomez <german.gomez@arm.com>
> > Cc: Carsten Haitzler <carsten.haitzler@arm.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
>
> Reviewed-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

There's a nice better than >2x speed up waiting in too :-)
https://lore.kernel.org/lkml/20241011220354.756798-1-irogers@google.com/

Thanks,
Ian
