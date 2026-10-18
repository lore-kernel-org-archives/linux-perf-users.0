Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C96C3DF01F
	for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 20:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792355639; cv=pass; b=Y2PqWj1dQMDuWqaMlbhEPtgoKfbbEAJXMOSGb/L2eDFq//rHEOT3c7aEwFRHegengivoYcv8VWwS9w3DpPS5zXPJG6VwJGEDJLMqZ4NdXavONqf2jjg3IKSWb2PVr3JL4KtzFG2CCgUKKsLgieDsq+53SI05e3wJZdqV5RFrRwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792355639; c=relaxed/simple;
	bh=RFgQrkdBBoSzqRJg6uyFYGy9xtoJxOpfXrhpBF3Bg9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cwk1TskfZLSGdbPWZ80eXcyKQNvK97b4lFyu0sAgVVNkxOoVu7aIpznJYg1Iqk7iov8FPSfoyYG4siDFfkHjxVP7rNZH5VG7diGAp+smjZ7rSOHsDV5v+TAQXDJTbERegQtSkWPttw2it7uMrJNPvVgClaoU+3mbvM17mbsx8rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LVZIIG+q; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LVZIIG+q"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-535f598d126so206071cf.1
        for <linux-perf-users@vger.kernel.org>; Sun, 18 Oct 2026 13:33:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792355637; cv=none;
        d=google.com; s=arc-20260327;
        b=Ce8mVO9VPze0K+t5dbWujsdqri4IiSqtwA2LLX5GtfZhdbFaLPH1sThDDHIucyS/lg
         d9nKpbWnbYW8rqNGIBYMDLXwaiI1qD75BFwWUvJ9DOo0OtlUlZOv0YV/fT/FqEaNcQ1i
         pSsEclFXZUW9E78nWEKJEINUpRsX1IlE9vOsmi+MxFSFtxBf1gigiJC8iDEkDhoXVpJJ
         mlc+t6rI4hIqCafbCQ971LQZZo2YYKEFUgH7CocO0sa83LTn6RslKJQ+2F1Tgx1Mqar2
         iZ3R0kQ+DzLsj82O7QadBWekOuv8OaH9VLcgSnvIfvi3rYCQXH/EnZYcYb1oD2C8iru0
         6SVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U0yEFYFRImHyutXHpD0puy2q2sce26+Y2mx28kTrK4Y=;
        fh=XCFfzey97WbAZs6ZPG5O+My1Ie0KHLjKIwRNvW8ENVI=;
        b=H/+/Oq7fgKJDVlqAuto/gmsa+rk3Ay6zzFXg31JdO8IJBEIAVew0Oa3bl6EmkQrKaZ
         v5MLWxMGMs0kVzPqFtu5tWCxb3HVFbUNsIwqahPZldG/CKqIPAH9ZsKJCtp7XTeaYD1E
         d+v500f5m0NV/MbAToYTJ7K0RV8WDA5l8r4CwE8BZUXYaPTq+eqHplu7FYKKFavBrKL0
         alG/dyz7bYUkdjaMf0khgKGRdLovJhVT1zNTkUZQFF3DyiLjRCaKG7TNgq6432SbJfW7
         luFDvBmfylbr7uwxaSjsfwI3FQI55Dcn4XOtUu0PhhFstf+fbC10vfkW7oBMEaXcS0XJ
         W50A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792355637; x=1792960437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U0yEFYFRImHyutXHpD0puy2q2sce26+Y2mx28kTrK4Y=;
        b=LVZIIG+qqnAcURfmMEeonWIDylU9U8tcAr+Wdd5p5JSTNgUlE28fOCnGufZuqr5xF7
         tUv9CBXdcxVlvHTIdkVNgzpc2h055kF9YoYuwoi0qobCrABIayOesUpsltb8sU9r0/qV
         PzQipiGAkEHN3ep+52S97/XhS0VFF4EBHr4g2op5xlLSuVwpUbc90dm0p9YO/wwuPvxG
         kVkZWCEIHeXXjkdijauV8aEI0y011C51Rc4vJWkrfvZsSEAJ8Hpe04U4a03RSvR8I8Vz
         fN9c8s5MwLQ8gxpIA91xDQW9tIYFSk6ICgGhsmdRsclTho/jzbzAkbgslbjHOBdcw9jA
         0inQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792355637; x=1792960437;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U0yEFYFRImHyutXHpD0puy2q2sce26+Y2mx28kTrK4Y=;
        b=lCvqSjJXm9dSdchbjFkGCtbDIHcz1ORbwHKcq7d7ZNiwCMEGX3maIrg/pRp2WbzgcR
         W9hcbCl6ZAgUFBGr9o49INsIQHwCzMMoD2bm9Aed1HYTJMRZJNk8ai9oxzJib2Rt9/Ma
         hbyd+DMkEc0D8DatwoS2nqnUaPxV3PMbrHVduMTMO0MnKYdm8BY+lhoEzPr8a+Xd8ful
         XHBnj9ob7nieNPSxHHDh1mPhoy0/DoPD5FZVFh9o972uUrG74s6yk8XiZWN4MFHatMqj
         48+yvuMIVVEOh2DW/1XR0ulISg1wBhBozzOWhj7cdxeGRGNfGGKDU/LWK9Y2egBE/ugg
         LDnw==
X-Forwarded-Encrypted: i=1; AKwUvByALUNbh5w+LpraOnX2AsuQaomTYtIp/fwlU/YORQCvZ0//HXsSCRlC5WbEYCwipDHJd/wXQq3s1O4fRacwtUzM@vger.kernel.org
X-Gm-Message-State: AFq9FYLnmDFQPaqSYri5EQiJnU4gvEP/NzNpl0LnmleideEyZHcaaDM9
	WlcvkjjIdAmjjV71MbDKC8bUfDRu0MUbEFpnjSvOdqEvguc+9yzHLlUp+twuPUrU/Snw2IqAR0t
	5fVNgvaUzxDJdamgdBkNQNEfuTwXjU7jbaAs4iEry
X-Gm-Gg: AYBFou3A+OKH+GXmqV+DrlOltxAM5v1RrHqWAuH5Tv2MbxnmIpnyNy2EjH9gcj3uSty
	6Q972WAR4ZuzJijoWlI1CeEKXSU1n8NVllZKEzqBWrLFcKFGFApAft+ejOL+2Ozfl9aSDCZ9G43
	aNvM+fTBYZfcSw6PZbovjV6qaK9ByvdAZTO6QBa/OYaeZsd/BAOsdk4frjfBZXJgmo1y7gkO34x
	1xJlQwUxgN6YO5d2z9uE3Wf8BKFVBoUb1ozfsrxyoeDQcxKwQ41KgAywLhRCWWZGT4BIsdTXuXW
	1YrJwLTK8uZc3sPRdlBJB080QEeA+xko7Ethz6nXkg2J5yWlqqPgJKxn
X-Received: by 2002:a05:622a:15c2:b0:534:d386:c3f1 with SMTP id
 d75a77b69052e-53646271decmr27164221cf.9.1792355636727; Sun, 18 Oct 2026
 13:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261018163741.850434-1-namhyung@kernel.org> <20261018163741.850434-2-namhyung@kernel.org>
In-Reply-To: <20261018163741.850434-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sun, 18 Oct 2026 13:33:45 -0700
X-Gm-Features: AclHuK8V4M0U4M5iq4S8ju7FIqL_Da28CgHw9_xNkRgcxcyq4pB9WpORoP3ni7Y
Message-ID: <CAP-5=fWt5r++c1=BnM+459WsiZiwvihGpcjZ+j5_6Kr4P7sDUw@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] perf test: Make sure maps to have a machine
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 9:37=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It's be easier if we could guarantee that maps always have a machine.
> IIUC this is true for all real use cases, but only the test code has
> an exception.  Let's get rid of it and make sure they have machines.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/maps.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
> index 2c05d62f40dcdf72..f40b68f5fa5fe2c1 100644
> --- a/tools/perf/tests/maps.c
> +++ b/tools/perf/tests/maps.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <inttypes.h>
> +#include <unistd.h>
>  #include <linux/compiler.h>
>  #include <linux/kernel.h>
>  #include "tests.h"
> @@ -100,8 +101,12 @@ static int test__maps__merge_in(struct test_suite *t=
 __maybe_unused, int subtest
>         };
>         struct map *map_kcore1, *map_kcore2, *map_kcore3;
>         int ret;
> -       struct maps *maps =3D maps__new(NULL);
> +       struct machine *machine =3D machine__new_live(/*host_env=3D*/NULL=
,
> +                                                   /*kernel_maps=3D*/fal=
se,
> +                                                   getpid());
> +       struct maps *maps =3D maps__new(machine);
>
> +       TEST_ASSERT_VAL("failed to create machine", machine);
>         TEST_ASSERT_VAL("failed to create maps", maps);
>
>         for (i =3D 0; i < ARRAY_SIZE(bpf_progs); i++) {
> @@ -159,6 +164,7 @@ static int test__maps__merge_in(struct test_suite *t =
__maybe_unused, int subtest
>         map__zput(map_kcore1);
>         map__zput(map_kcore2);
>         map__zput(map_kcore3);
> +       machine__delete(machine);
>         return TEST_OK;
>  }
>
> @@ -189,8 +195,12 @@ static int test__maps__fixup_overlap_and_insert(stru=
ct test_suite *t __maybe_unu
>         struct map *map_split, *map_eclipse;
>         int ret;
>         unsigned int i;
> -       struct maps *maps =3D maps__new(NULL);
> +       struct machine *machine =3D machine__new_live(/*host_env=3D*/NULL=
,
> +                                                   /*kernel_maps=3D*/fal=
se,
> +                                                   getpid());

For completeness should we pass in a host_env like in builtin-top.c?
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/builtin-top.c?h=3Dperf-tools-next#n1661

Thanks,
Ian

> +       struct maps *maps =3D maps__new(machine);
>
> +       TEST_ASSERT_VAL("failed to create machine", machine);
>         TEST_ASSERT_VAL("failed to create maps", maps);
>
>         for (i =3D 0; i < ARRAY_SIZE(initial_maps); i++) {
> @@ -230,6 +240,7 @@ static int test__maps__fixup_overlap_and_insert(struc=
t test_suite *t __maybe_unu
>         TEST_ASSERT_VAL("eclipse check failed", !ret);
>
>         maps__zput(maps);
> +       machine__delete(machine);
>         return TEST_OK;
>  }
>
> --
> 2.56.0.176.g3575e65682-goog
>
