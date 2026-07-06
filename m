Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423F342377E
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361096; cv=pass; b=qLjyWdHklvJQc8v0rVolclUrvPJiMRVQFNuMHRyHoTRpw7cNhfE0vHEIk4ILBFwFd5iug2EX+LXZGYCjfQpfgft2Zr6guEcS6fT0k18LSsIANqLtyaJDnXNESj1ii9BxniI+jXXwnRk3UeV/aD4KOMNdQ4Kt0A6FuSP5Dj+pvew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361096; c=relaxed/simple;
	bh=kob7UNeXDMxiK8gaaEvzrwnTszFE3zYGzNRfXWALVck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYZa0/VBM6rO8GQvldFDXIod8WyMGpAczlMYBSQeP39Bub54Y/3VTka8ckw7CUlhcuAPCO3N5KfG/2DFCZK0J8vQcstNVIn4NE15Wcs+KPZRYoSEe9xMnOy/fADUmGjXCL4dYhPh4I1XhJERd9xZhkZEMRafXb5vrcoqZk0r9gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uwHHwP7r; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uwHHwP7r"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cab97c86bdso24345ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jul 2026 11:04:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783361095; cv=none;
        d=google.com; s=arc-20260327;
        b=Gc5yRA33iwF76hShmgoBS/ffPxMbb7mbDZVfXHS8C5wLobjD56YtFLAfSkUug2zQCV
         FmpZ31z9dZXpILz2hxHH/qEFF6v47RjiCP1yEo3OGynogR+9DWfhCuQP5f8ahDjR0a9B
         qPf6MjVjLhtRFXr4pnboj0+Z8xqMoK7bS2OSOTvvbLD7THMs3grXcdQJvm1+935Sg/Au
         PTqXmAITdTs/82WjRFU20RDD4drt41yxnQt8AMOovLZiD2BDjMAE89VzIXKAkcDxI2Za
         nZVNTNfbvCb8kmV8DjVztw3t93EWxyNxhsNOVKU4CCEo8bSIcMr/Sp/ENyZUUWfsR1it
         bbTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D4hH2tSHLRwnjeY3g2Qt5LKpVkqtRcTfmJ8wJ7jtyIw=;
        fh=DDcXsTWG4O6kGzE98fVvX40HQOeqnhni4UtZCoq0IFg=;
        b=d0Tn+KUdpx+g0lfMRhQm9sX7lvK/DIt7O+ht3mLEo0kCaT8GesiiNJ9joCoivJe6lw
         Bvz0ZSfM5i34AvjM7fE1n3MxEfoeVX6+l3bWpyX0Irinkpd0AtKTu7IhhLyzzh81kaa5
         cyQAh2H+vlsSS2CcxicomKIggyT+PRB2dEyrvozkE2jtSQYDr3gqM8JBYJJehU+RBXh/
         SlWhTmyS93Pagshhe6WFHfVbs+XgAkD7eOzGtJWFFiYY059L9JOYm654wCsRgS90Jd06
         /GccMCH1ZbcSWbHPb0G7ERxOGIBRPOg31Jq83v3xI+TCJ1D0TIrRLVYY/Qyr/fpC+N01
         7u3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783361095; x=1783965895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D4hH2tSHLRwnjeY3g2Qt5LKpVkqtRcTfmJ8wJ7jtyIw=;
        b=uwHHwP7r1BjcCxJVzaRriZNPgJkZRlkhRIsy/3Thq5nOC4mkzLSLgs2IpuTvqz+5kn
         brsF6zZKvFXgGMaMKco8tnY9/THf6GRYxznDM60CcRB9vgp+jv5IX2NzpMQop/6lsyZ8
         TvuLrIF4VN21KT3l3UmM5rvo2DuPUNg3Nz1T6hHNwU8pomwSJ9OHF1/OASWMXD0jxU6p
         emnxjXslzmoKm4BMn1er+XEjUsHrBj4z0XAA9LqeFfGdAuC732Kt9A2B5hkBMTYlJ2n6
         YHw8H0q1lsbuCs7CQZQ6ct3XCJ/bRsrOTw97OzYSwUPcYOPbt+B5ClEW4SzPFREE1Hpe
         v2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783361095; x=1783965895;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D4hH2tSHLRwnjeY3g2Qt5LKpVkqtRcTfmJ8wJ7jtyIw=;
        b=P21GWbQUsA2ZpSSWaqvNoEVcB2B3OC4BHGc3UBMiX0HgvBBUTBUlgTV/vpt+Sqk4RG
         6B7LwJ8M8KQaGQITGY9Hjk4SIN8KsekWTHS5OxjIvzW3Xaj7a0auctI0RoYs/bG3MrBz
         H617431lhnhzUj7glGfHCrYVkNVNYtdutQmXfENCbTRdoMyxqEyEJ8cRjyWGyiD7x5Cu
         Zm5kY2p7ZTmgLMMwmBVZwNNyC8HwccIaXfpcCWhsbwo0iX4A9MVMJLDI/uU/ehjpUp2W
         fRIksgnN/A7IV/hUIqCW+CqR14OGT4ho7Zw9dK5CIe+OcYPx3/Hru78FVbeD1f9AXHU+
         Dzzg==
X-Forwarded-Encrypted: i=1; AHgh+Roy5orNM5aCw+EI+XvErfRk3bVda8DIPkHRa4ZPxSsi4L5iQPCqLwUP+wSFGG8pBT2RUfbcIvi3Ey1FElAuKIsx@vger.kernel.org
X-Gm-Message-State: AOJu0YxhycvAdUfmngO9TYwRTxaQE127NFPKOtSauem9TJGmOVkIphPR
	CVtg45jsC5GA4t0ggwte5YOAVfB6tKag6TBearng2qmm6Jz7/csmwXXCkjSzBn3WMFyAzjFINyt
	M4VrBuzqF92K8Ef9yLM4m/EsqcqXFvYIYX2Gwo9fA
X-Gm-Gg: AfdE7ckqyXAPxchZjAO16WI6pbrzJlpWd7/cqqzX6Q5DKFVm2pifjyXtbqf2CHUopih
	Y7qp/JnZ1dSkvVmMOV7FSuN8tgvX4a8+DnZagzYGuOiWReMbJKupgozZtK9BCWbQ8DG2fADpxsI
	zMKHzz7Q3602qlxoJgFt83mLVstnySZMhOvGhHW8Z99O6fRPRdPIu6ICOAf8WIcs8pvwfZWwpDz
	Lii4rB2AsVCN+pZYOS6EswlwkXuv1X3UBdyVbNhBv8rZSF6BliAAULDLYPqjSDIMiHrOLI0njRO
	za7H1sPAlB8Q/Ynco1w/E+qHTnS3oSQqYn8atw==
X-Received: by 2002:a17:902:d54b:b0:2ca:4f6f:c34d with SMTP id
 d9443c01a7336-2ccc4659513mr577305ad.9.1783361089260; Mon, 06 Jul 2026
 11:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706175624.692736-1-nazar.kazakov@codethink.co.uk>
In-Reply-To: <20260706175624.692736-1-nazar.kazakov@codethink.co.uk>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Jul 2026 11:04:36 -0700
X-Gm-Features: AVVi8CejJrBmmeU3lipZeu6mJm0T90YChAFaJHihB11zqx_cwwJQJGuVsA4Ts7w
Message-ID: <CAP-5=fWXhESb=4TMyt2X9oM64h5xwpNf7VGqXCs+NbPr8zeuGA@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: make events order more deterministic
To: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ben Dooks <ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 10:57=E2=80=AFAM Nazar Kazakov
<nazar.kazakov@codethink.co.uk> wrote:
>
> Some of the events have the same name, but differing descriptions. This
> leads to a non-deterministic sorting order, so fix by adding the
> description field to the order.
>
> Signed-off-by: Nazar Kazakov <nazar.kazakov@codethink.co.uk>

This shouldn't be an issue; can you give an example? I mean, with:
$ perf stat -e event1,event1 true
There's only one meaning for what event1 is. There is wildcard
support, but that's not the same as having the same event more than
once, differing only by description. Note, I deliberately use events
with perf stat in the example because the metrics build on the regular
event parsing code.

Thanks,
Ian

> ---
>  tools/perf/pmu-events/metric.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metr=
ic.py
> index a91ccb5977f0..b3ab78a0ecb2 100644
> --- a/tools/perf/pmu-events/metric.py
> +++ b/tools/perf/pmu-events/metric.py
> @@ -623,7 +623,7 @@ class Metric:
>
>    def __lt__(self, other):
>      """Sort order."""
> -    return self.name < other.name
> +    return self.name < other.name or self.description < other.descriptio=
n
>
>    def AddToMetricGroup(self, group):
>      """Callback used when being added to a MetricGroup."""
> --
> 2.54.0
>
