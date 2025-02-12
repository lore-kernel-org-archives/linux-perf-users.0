Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5D925D52C
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382500; cv=none; b=LmqjpxvmEIyd5WdXN1BkiauDJecCfH7o0A9fDvXjRj5YeTgsGyotu/Sh7jBy7oocen4r74cRJl2Xj4nqZzQ/wESP3ymBuJYnL4B0yqEnSnSGXhruOzariP5NQv1c4yGYiegU5Rnt/isMt5xWGIGCqN2BkhfU4K/tXRYYnP+4Muw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382500; c=relaxed/simple;
	bh=L0jdKS1YiQB1xypxo06sYem+JAjwxJlfR149uzO62Fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gtLyp+qxsWXRlXLzqBTiwb6fLNi+EdoNY1BLXxJ7bENHoMuhxMEL0sinh4Kh4DhYy2M5fKAg9I/uo8Xu0pISbmGl+c9XtVlndcIJZMgnJJ8HNUEKIf5OMeNFP0f3OndGtrdu1z+6sLo8BymOzU3iFUS93T6+PWQNokF9HDrS4Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jGOSbwVD; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jGOSbwVD"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d147331fb5so201335ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 09:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739382496; x=1739987296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt7D4r1xEvWIWLzWgdvMdCOaHSAzfJA8cSi5o7NwZf8=;
        b=jGOSbwVDFPBqmhS1Q4xZ+WBjPh+YvXXBVlC7RhJP909M6HoFsATuF6RV+retJ1WI5x
         ny93qD66kfer11j6B/do4RQabZ78RIMvyreHmoZSZaLzk0AYmbS3BmeQj/Xsc6e92+n1
         /FL+zQUO6EzFfRXVWfFkUbUDlYUQcTvq+LlZVHL1398zRmpd8f4EtX6ixoGKPkS1V43q
         DOh85/fMV+ciGeHWiV3bPBVJLXvTTjuGYo/mLnnnO7v1svRaokGEJiUdJDFh/P810fZ1
         v1rKaBYFqdwilq+8cwFocBfWbkufDp+yJSX/ZMijeKjjJezxFZVrsLc7pdoLdSpW1IVT
         +c4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739382496; x=1739987296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dt7D4r1xEvWIWLzWgdvMdCOaHSAzfJA8cSi5o7NwZf8=;
        b=HpWnC4Y0Bljatm2rl5WMFwls4fH5lf4WVrNbWJtduZJiRz5emuvpFnoXTQwNcJZk6h
         uAz1UXqWNDNQGVJ90QHPCC7DnDj677JqWDifKy29i84dO60N9ru/8HcWeY7+yb9AVFAc
         peDVlfzbLLK2ze9pYa2443n0BwXu71PWTNPEF35pKtkAgXA2/NxBHhTCtdPOvdn09jaw
         Yhk1vSqq8s49mo1y/VQOlsRw9SGE9S06nJOualvYdOgKOs9b5BpkmhLk/HnHCsc/00WN
         3WR0pY/fAgnthxvzCYWvwdKY4cEqN5g88nKcXoZVx8fA6Ke3jVLQjer83hDPvkqkl9xL
         v9hQ==
X-Gm-Message-State: AOJu0YykSO6pm/Jj3Ko/AhAfuxkSBOs0qgQNwZ5M6BQJXI2EAh3alcxT
	7eOxa5ED2bbW34Ck94wRizzcipYmh7nyjWr/enzG3nFAC9ZA0A3qVWt/4jhV9SyR2a8F3522FHo
	qcYUwLcfbHvHAYQ777pXfCS6Fj0Orbf59xpzV
X-Gm-Gg: ASbGncu9Dr24peMG3gsFBnZ2JpAQxOKezACkHOi6A5gzh/ffbQIGRoJOOpLa3i5UZav
	hu+yLKpej03EoVlWW0C0LWgsmqp+2aC6vY6V+Qp4GFhQC/BkS1ZIMS/I6zXJmzjKxjJZW2qFA9z
	eL+YZMfzp20eBxGAJCp31LBaxV
X-Google-Smtp-Source: AGHT+IH9RKm27XQbmHh58Pz+JCF0bZ7NSN+BmwBjNae4zPcqJENouojrXcqIdDizAMwgnFBU+h3t7OTAv2/bkF7zBKQ=
X-Received: by 2002:a05:6e02:1388:b0:3d0:55b1:44fd with SMTP id
 e9e14a558f8ab-3d17cdf5082mr4193115ab.20.1739382496456; Wed, 12 Feb 2025
 09:48:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212122413.1184503-1-james.clark@linaro.org>
In-Reply-To: <20250212122413.1184503-1-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Feb 2025 09:48:05 -0800
X-Gm-Features: AWEUYZnS5MVynzktqK-HyVROJHhiEXTDykfpawL-S_AXrMzRAvSLdhv-ssUJVoU
Message-ID: <CAP-5=fWywDB40-RgV8LaPqsoffOLdDcYkUB_LHoPvV=R8yas4w@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Fix non-uniquified hybrid legacy events
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, Robin.Murphy@arm.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 4:24=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> Legacy hybrid events have attr.type =3D=3D PERF_TYPE_HARDWARE, so they lo=
ok
> like plain legacy events if we only look at attr.type. But legacy events
> should still be uniquified if they were opened on a non-legacy PMU.
> Previously we looked at the PMU type to determine legacy vs hybrid
> events here so revert this particular check to how it was before the
> linked fixes commit.
>
> counter->pmu doesn't need to be null checked twice, in fact it is
> required for any kind of uniquification so make that a separate check.
>
> This restores PMU names on hybrid systems and also changes "perf stat
> metrics (shadow stat) test" from a FAIL back to a SKIP (on hybrid). The
> test was gated on "cycles" appearing alone which doesn't happen on
> here.
>
> Before:
>
>   $ perf stat -- true
>   ...
>      <not counted>      instructions:u                           (0.00%)
>            162,536      instructions:u            # 0.58  insn per cycle
>   ...
>
> After:
>
>  $ perf stat -- true
>  ...
>      <not counted>      cpu_atom/instructions/u                  (0.00%)
>            162,541      cpu_core/instructions/u   # 0.62  insn per cycle
>  ...
>
> Fixes: 357b965deba9 ("perf stat: Changes to event name uniquification")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/stat-display.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index e65c7e9f15d1..eae34ba95f59 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -1688,12 +1688,17 @@ static void evsel__set_needs_uniquify(struct evse=
l *counter, const struct perf_s
>                 return;
>         }
>
> -       if  (counter->core.attr.type < PERF_TYPE_MAX && counter->core.att=
r.type !=3D PERF_TYPE_RAW) {
> +       if (!counter->pmu) {

Thanks James, I wish I had a hybrid laptop so I didn't keep breaking
things like this. I'm uncomfortable using an evsel having/not-having a
PMU as an indication of whether uniquification is necessary. It is
kind of a side-effect of parsing whether the PMU variable is non-NULL,
it'd kind of be nice to stop things using `evsel->pmu` directly and
switch them to `evsel__find_pmu(evsel)`, in the future maybe legacy
events will get the core PMU, a tracepoint PMU, etc. so we'd never
expect this variable to be NULL.

Your commit message gives me enough to think about what the issue is,
so let me give it some thought.

Thanks!
Ian

> +               /* evsel__uniquify_counter() uses counter->pmu for the na=
me */
> +               return;
> +       }
> +
> +       if (counter->pmu->type < PERF_TYPE_MAX && counter->pmu->type !=3D=
 PERF_TYPE_RAW) {
>                 /* Legacy event, don't uniquify. */
>                 return;
>         }
>
> -       if (counter->pmu && counter->pmu->is_core &&
> +       if (counter->pmu->is_core &&
>             counter->alternate_hw_config !=3D PERF_COUNT_HW_MAX) {
>                 /* A sysfs or json event replacing a legacy event, don't =
uniquify. */
>                 return;
> --
> 2.34.1
>
