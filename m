Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B0618871F
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865587; cv=none; b=JMj9al+ZMWD/SG3DcPI/r4zberwnErS/2oIaJg4jkkc+e2VXDq24hf+j5pLe3/MP7WmpWbsMZKUn0hOqYqrGAle3GBsQfJIbUeSXqOLTUe46pno/rgrv9utwn+yfNWVRQ8sbzIYcV+m5RC6lIKur7vnazRRlWJeh8opo0NXodPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865587; c=relaxed/simple;
	bh=O7HbtLaXuilVB2OB2qtbyBs0ythTqJf9VhCdEjayb+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdkvFMwr0tbJElLZhULTzT6i3rtGtW61ZOaQ+1xLy6u0AmFlJBwjaU3CNR7vMTDTZzh1e+zhOsYPlnTSKgwCRztfBD0GtyQB0iKl1RmHIF1I4QVPX9Y2SzWs3KshMBxNkpZXwnldfSQQOU0vPNqXiMyw306xY9nXF1okMXKnS3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nGAxt0WT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nGAxt0WT"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-295c64cb951so249585ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Dec 2025 08:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764865585; x=1765470385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRuck0o/ayMMH0+PU5Oqx6DlMomqKFq4SofG0rr8euI=;
        b=nGAxt0WTopoGJ/JUJrCQL+Ghawm6umWU8fQ9P6BQhstS2ULKEkzPh3Fzjqn/wwZ9hR
         bnMUCwHasHnb707d1mSrzkiiOIQuRftC/51UsgKLvRiALyHRxrR//aA1YOBpnEX6NWJn
         PfcisAkNHVCjQoxtLbo4XaE2stCO/IDbrIcBtVw6rtT2K/PCvhLSbdcQKjH5U7kC0crY
         YHe+ppSXCQfQW6+QX6/X4gvQNJRuuxNh9h+b4ScL9ue9+dGoyyYUVv6OS3vaqPPZIQHg
         w+3ZC5cDhcY00v+bVEUUuXI8mZXkrkWguU9phrc5okM+kU4HwY2fQ/PQuId59rY27sQL
         LRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865585; x=1765470385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HRuck0o/ayMMH0+PU5Oqx6DlMomqKFq4SofG0rr8euI=;
        b=vOSIBSs0/M4F+7B8uIUQQxVQ85diBlEJ9wq2809s/bdLthNC2HkI2piWzerjbv7eqd
         rxJTKHe00XMTP6/GnzWsH7l4ouWN5OHB22l+znA9WGoWuJOHQmUBNz8HxW6PaAcKnxNL
         jWCAIRsC2FTkhXN70tGjawx0Ju/fghJTg7Dy1HVJjqMcIB71UOXcTYuKOPzVk6JpdgWU
         nn3xHkPoCdjkBKc3pdRkpAcHy+/E11T7SpeQYG2I3TyCtOG+DXu52X/2GCYU9AtUoMkT
         bZNU0fQ0+76swwwe93OaknKx9htxHnijtk17m2RPjZ+p07bpiQ27ZyzDfM9ivVTLpJBu
         +84w==
X-Forwarded-Encrypted: i=1; AJvYcCXAQmGNEOuLlfP9nF/DoIft7wFEr69ZAga8hwM2MaAhhc2qjB5slvyXARXFpQEJkbEVUhC71xgitB4fIsyPGbhC@vger.kernel.org
X-Gm-Message-State: AOJu0YxLhJrfBzd2S2OWe2J9LZI/qQLGaQOWidzd2cj7yZU9V+HuMRnY
	eYWVQ3U+LocEtjiKpYRuyYHdLJqKE//ymfOm0aY0K1EQX+5uZUbhfshFjnwVt2KSQRuttjf9Idj
	mjrV7lJs1Ftqw1Kfeusaq7J/Hnjha7qcIx3gsiMJA
X-Gm-Gg: ASbGnctKj0uRQJw/TepcImrRMn/iNI0kvxm49jWaznOizXk5cu4KmSBeuy1yStJkIeq
	ey97vIDXa2s45bLlG0HTr4hILX50+YtEjNp4oChIxaKrNyZxPsnSVG2Wq5ipsv75fcVPFpLeazG
	nEg8x3Ibx7PMiwn/6NVpgWTkNy1Eb1Sbhr9KNtCvztug4MGEn5wy4gLfCBOJQ1DE4AkMRwPMqhF
	MY2/iC9nX07HROyw4k+7Jl9tq74w8CMC4UJzedaxyGNXj5R4Umftxnj9SHJEhpCKh3KovEiLQKt
	AFoK3qWR+1XjQ1zbowdxZy1sQR8AWgkNw2rd
X-Google-Smtp-Source: AGHT+IFrb0RuEPaUjEFdKS6f7fL7lCYr2fjaMsenvp46rFkKzNePDRZK4iIIJl6ap0l1COIHrix7hLzBcIAbZGqxUak=
X-Received: by 2002:a17:902:e850:b0:26d:72f8:8cfa with SMTP id
 d9443c01a7336-29dbe8fede5mr730745ad.13.1764865585125; Thu, 04 Dec 2025
 08:26:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251204-james-parse-events-test-v1-0-e6f922ca395e@linaro.org> <20251204-james-parse-events-test-v1-2-e6f922ca395e@linaro.org>
In-Reply-To: <20251204-james-parse-events-test-v1-2-e6f922ca395e@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 4 Dec 2025 08:26:14 -0800
X-Gm-Features: AWmQ_bkL9oUGmakw_tPZ3cllyhPphZGPqF7gEYueTv6c6dnex7eRawFWEOAazeE
Message-ID: <CAP-5=fWvE1XSChS7mMxaFVi+y8A16gy4f=2bepKOZUpDK50+ew@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Add missing newlines in debug messages
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 1:11=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> These debug messages bleed into the next log line. Fix it by adding the
> missing newlines.
>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

I looked at the Fixes tag situation but there are a few different
patches that did this wrong. Given this is debug messages in a test,
backporting is a huge priority.

Thanks!
Ian

> ---
>  tools/perf/tests/parse-events.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-eve=
nts.c
> index 128d21dc389f..62aa40d8114a 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -2627,7 +2627,7 @@ static int test_events(const struct evlist_test *ev=
ents, int cnt)
>                 pr_debug("running test %d '%s'\n", i, e.name);
>                 test_ret =3D test_event(&e);
>                 if (test_ret !=3D TEST_OK) {
> -                       pr_debug("Event test failure: test %d '%s'", i, e=
.name);
> +                       pr_debug("Event test failure: test %d '%s'\n", i,=
 e.name);
>                         ret =3D combine_test_results(ret, test_ret);
>                 }
>         }
> @@ -2764,7 +2764,7 @@ static int test__pmu_events(struct test_suite *test=
 __maybe_unused, int subtest
>
>                         test_ret =3D test_event(&e);
>                         if (test_ret !=3D TEST_OK) {
> -                               pr_debug("Test PMU event failed for '%s'"=
, name);
> +                               pr_debug("Test PMU event failed for '%s'\=
n", name);
>                                 ret =3D combine_test_results(ret, test_re=
t);
>                         }
>
> @@ -2790,7 +2790,7 @@ static int test__pmu_events(struct test_suite *test=
 __maybe_unused, int subtest
>                         e.check =3D test__checkevent_pmu_events_mix;
>                         test_ret =3D test_event(&e);
>                         if (test_ret !=3D TEST_OK) {
> -                               pr_debug("Test PMU event failed for '%s'"=
, name);
> +                               pr_debug("Test PMU event failed for '%s'\=
n", name);
>                                 ret =3D combine_test_results(ret, test_re=
t);
>                         }
>                 }
>
> --
> 2.34.1
>
