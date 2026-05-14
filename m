Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB41A19D07E
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780918; cv=pass; b=L5+C/yo7BF0EtQdGyqOGVVQAd7IEyaSlqkEGTcX483/4b+rXWI7retQNiV8DpyEIJttx+uasFDTVF7y89WpvF2psWHkpMuPvyrBt9xCXEAsl6+zc0LHZWnTJGBhm3i/0kifDZxtKBgjuRc5YkdVrK98KiLvdJWoNZfUOAUQdAH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780918; c=relaxed/simple;
	bh=0xSOdrXUtPCmWOkjcs1t9ql2rm2uWDReOae07gGFT1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDME588pHBBgDSZl5+XhQOBpACc1QF0D43V/2zHe3NpHk/3xtp0Ts3iPYDkforo04uKl9DB97VgjqJky18qpgvgHJ6dADzy/zyJ9FB7OhEiLEmXclQRbt1/f1YncDAxBxvto5twExNPj1HKuZ+nRNNQwTOM2aAcIAyamygWTQvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S2a2EluS; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S2a2EluS"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-133362c30cfso223c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 10:48:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778780916; cv=none;
        d=google.com; s=arc-20240605;
        b=jSSbBg0daxUCcKlUAkIuQnd/e1/R00v2KD4XNqkrSJcP16Q2P5lo1yNqB4pGqNNZjx
         4bMrzRp+49Nnxh6BUpF5Y1+8AbIt9P088hZqczwtYBhcjrws/F4f1En8MDl96UOi3fZM
         Z1JRwZDEjsYWtIeEU9zj7ARfygGgoLnqZdX/MbNMNDWmqzYoLtoYUxbBEybHjziVuL6y
         9pDhWA4m+MffFk4Sy4DwoZGmmBYcojmksn74DHUFW1PwaX4e/Ok1QUM8mqjdveFsAUmj
         MAYprWRW5ERDXXd92CTSv1SDwayvAz4dhu00IXLd4Pu0UMNVpAvFxY5+96ovBd7SmfcA
         6PKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P51y2SUZmYkTmBXt5UpXfBsLlNjMMFZVx/F0wH8/eLw=;
        fh=V+Hkd32G+1fsoXLAC5XrTcHIqDk8QPQqR/gg2XctWdc=;
        b=H37GQmreRt9hcfOX4rkbl8oJOnrB9JoSSJjBS7an1BmJNHQB9hFPHQNo33pmMKi2as
         6QQNvVP8M1XOyXnmkbUkli9nkx7lFa8fyIQkcsqeDmbIGQ2j3xIhWqPQdnNioz8xeI01
         P7wq449/kIkKCEk0zna0xc4KDRnso+o53qwYZHqdoE4/HIxUHVmULHltoaWJ6/LEiAdQ
         8aGraosr/yNg045ZzP1JWTFTv6NtroVwZosH4BFYaw5P2sTZhCxu++zpMcC0drzAJaQI
         vSUvRTAwnId4n8nTbux488LEda16bOZWyZcV/G/KzQqzdkX4ZXO5WLTOTytYDwi3wAPF
         6lZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778780916; x=1779385716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P51y2SUZmYkTmBXt5UpXfBsLlNjMMFZVx/F0wH8/eLw=;
        b=S2a2EluS6iPWXyKno+5WNKW+znBf3wCIRieYhUhtESCpXv+dFE5FyxKpWboM1cHh5/
         +TxPlyTjBKl6qiGIFe5bmYOvFEM3W0hKutE6F7V6TmPZKcVUJHOeinvhYSmQ+DUXkDBt
         kD4US/DcZir6VYCHXVeRdJvUvJvao0VfcXSYoGvgy8UF3bNBYHzdYIx3q5YzInkfCkIT
         HiFsvCAqe+vDNS4a0g8ffKxsCo3YwJONu7c+T6xM5cNKUHUs9ccVXQQzMW/QCqHe+x69
         sAQiaoDuHsqOCHycwBj8UhVQwfCQAzC8oyrWttI9uoALXqqju5PZ/Gstl34TUmBPaZwX
         u4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778780916; x=1779385716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P51y2SUZmYkTmBXt5UpXfBsLlNjMMFZVx/F0wH8/eLw=;
        b=m8GEglozoFVPd+Wi2JR9vdA1zRTcvmIFQgsQhwehDp/RtFAE81LS0wswD0QfRHGRbJ
         DoCiBNxMIlePyA9BRohMBEWUDFWYK/rgcd9hNNxnVsEpWJIkBhBu9yZ/sOp533dplzqX
         zyW8Z1getsOEQ7vYj5cyzd7sqnTZqFXTZ+Z36tz3YpV0fnRojSj6O6LsEqxVNDYr9Uvm
         Dtkei0xQWmsS1Z97Af4ELsAChOxNnHWwGLsGvuELajm75JQ4Ijhk8vBvaLm48LmF0MUA
         40UcGunj1NU3Ecbbq8bHNRW2XfM3AQ+0Oiu6+TSP8HunnhGbSM0JHcxIM1hkTUILG3Q5
         cYBw==
X-Forwarded-Encrypted: i=1; AFNElJ+9fZjtqOtWw8u6WMn5hpQKNp9A5YII/MGb5nxRotv85KHcS6jk60mKFhINTZQJEMIU2qbctjuqMuowXvZ2uo3E@vger.kernel.org
X-Gm-Message-State: AOJu0YyzwBGMtKEt5ajTCmki6AurXtSQy8WSdSZHwCBdfyijo8yQuuUM
	mYiTgdxsqGTzhpvD/mfRaHQg5m/2uJ8KvEnC0eeAbPJMp8baMrchCHv+q6hZJNTjQt9Kc7Og2ZV
	AFgTu27kvP/5zYI+scSBxGjfokZid4raHRNK+l24T
X-Gm-Gg: Acq92OFVDl4jrMfW2Ag1/xYcMkLpRfg6PGMGO1i58ZK+fFbMqzq+Df/dDGZMHfS6kld
	g9st0t9n//kCPK0ICtvkoC+aXGSHTtKykLpsLQZ6Bx6wAtkVJWed1EA/N3nDebBXZesPULxyNMx
	rjMKukn13Tis+mGTKx+1x5/6DF672A9e52CD/7SCl2fbLiCSftIHdSGqCSneFKL7aTKjfymDKLG
	/rG8xNJ0SyyQ4CMTOkzYc8iKdnyxhCbrRe/Go7f4r0R3bI82xKOkHNrDbKpnJS11KOoSPvvOWRT
	cvKc/VSjf4wYYMquWUZH+5fiAPHeYbRR4PB/+86ZP9QIAqw=
X-Received: by 2002:a05:7022:2590:b0:134:f1e8:e596 with SMTP id
 a92af1059eb24-1350462828dmr8137c88.23.1778780915290; Thu, 14 May 2026
 10:48:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414175855.2089482-1-irogers@google.com> <a33a42ae-253b-41ce-8a2d-9d9ae58372d2@amd.com>
In-Reply-To: <a33a42ae-253b-41ce-8a2d-9d9ae58372d2@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 14 May 2026 10:48:23 -0700
X-Gm-Features: AVHnY4I3wUZCuYkJ8SLIe1bYm3J2yhFX1BEXc-DEBwlEwYP38r21rPdIMvK0j1o
Message-ID: <CAP-5=fUMC-vWFvt3S0aNCqqSB=ka1FisUgRbJwBhoBKMYt_-nw@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmu-events AMD: Switch l2_itlb_misses to bp_l1_tlb_miss_l2_tlb_miss.all
To: Sandipan Das <sandipan.das@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 11:03=E2=80=AFPM Sandipan Das <sandipan.das@amd.com=
> wrote:
>
> On 14-04-2026 23:28, Ian Rogers wrote:
> > l2_itlb_misses is a valid legacy cache event name, hence allowing it
> > in all_events in metric.py. l2_itlb_misses was also a json event for
> > AMD zen1, zen2 and zen3. For zen4, zen5 and zen6 the checking that
> > metric events are within the json was skipping l2_itlb_misses as it is
> > a valid legacy event, however, the PMU driver lacks the event mapping
> > causing it to be a bad event when used in the metric. Add
> > bp_l1_tlb_miss_l2_tlb_miss.all as the l2 itlb miss event (bp =3D branch
> > predictor, the AMD way to say itlb), so that is used in preference to
> > l2_itlb_misses when the event exists. Remove l2_itlb_misses from
> > metric.py as the legacy event isn't used by any metrics and having it
> > is error prone for newer AMD zen models.
> >
> > Fixes: e596f329668e ("perf jevents: Add itlb metric group for AMD")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/pmu-events/amd_metrics.py | 2 +-
> >  tools/perf/pmu-events/metric.py      | 1 -
> >  2 files changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-even=
ts/amd_metrics.py
> > index 63e5098606c4..ee5381646a8d 100755
> > --- a/tools/perf/pmu-events/amd_metrics.py
> > +++ b/tools/perf/pmu-events/amd_metrics.py
> > @@ -287,7 +287,7 @@ def AmdDtlb() -> Optional[MetricGroup]:
> >  def AmdItlb():
> >      global _zen_model
> >      l2h =3D Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit"=
)
> > -    l2m =3D Event("l2_itlb_misses")
> > +    l2m =3D Event("bp_l1_tlb_miss_l2_tlb_miss.all", "l2_itlb_misses",)
> >      l2r =3D l2h + l2m
> >
> >      itlb_l1_mg =3D None
> > diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/me=
tric.py
> > index 0c41a502cf21..c1931b2a5170 100644
> > --- a/tools/perf/pmu-events/metric.py
> > +++ b/tools/perf/pmu-events/metric.py
> > @@ -25,7 +25,6 @@ def LoadEvents(directory: str) -> None:
> >        "cycles",
> >        "duration_time",
> >        "instructions",
> > -      "l2_itlb_misses",
> >    }
> >    for file in os.listdir(os.fsencode(directory)):
> >      filename =3D os.fsdecode(file)
>
> Reviewed-by: Sandipan Das <sandipan.das@amd.com>

Ping.

Thanks,
Ian
