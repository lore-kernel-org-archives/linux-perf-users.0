Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B953E9C1E
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 04:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791951687; cv=pass; b=FrbQOeSnxZu6hgCHQVEOADoEiVOehoMvhT16qNDCLj4e86HDeBZxdhS6mWfylin8me53ec0iRYT629PWb5qL7G+vSZpYbhLX6omnDXT1gE71Of1O7sLTVuvT6kmQXPFnBy281z4De6m2dWKJ8zUOmR/WmcjYUZ3+Cl21xSYTMCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791951687; c=relaxed/simple;
	bh=cn63L5SFcW4uv11BCKaKFb7NgF9TokUcHR2wfHkyl4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGj+Eg3rbvjW3RHuNYUGuAjJnvWx8ucJ9Kso3Vov9dGi047vmCb6n+DXDRPl4e20qrMw8gSVl3mxBIpOdLeROMCCns5x2+baSwQOLxCNnsaBjH83oXKG01XyfcMCpXz4NfEnloSjYoHdbpxD7yLLw/iq2jErZxf16mzNRdoXYXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ckamKxOS; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ckamKxOS"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-535f598d126so389221cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 21:21:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791951684; cv=none;
        d=google.com; s=arc-20260327;
        b=mYX4xwH5tYFfLgWNCycV6KmUM5UrOo7pmUOFDItzrrWKXmiAn4U7bQyniuzREpVRUc
         KrQkuc/3fA7bEfZOPaTooTxinP6URKDZnZGq+z0YMha8zbqiHXkxGP+ZP5NC+ee9x4qY
         NI5jaH1GNw7PKW8OovPgZey6aSOEaWR0dtvnc2noFbgr34xt0v7s9T+M5q9ShgrgNEHM
         rC30z2DnpBsX7SYgO540v5oJ4UWt1mr/y8Me4iXaFkbyTnqnLPG1/BX7/ZieBuRp+WIT
         1L5CQIw2M4kpAy0ooamHu9UPEoNeIPFxhZv21Qffx8TcJE8a3b0nX50VhUp2Llf2M1LQ
         hrmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2grbJw/Issi66ell9ynhnVcAT71hGUf9xcfUvHsRTPI=;
        fh=QpXAQNgx3iPo/MBQlXG/U49jvdHKKn2o36XKkDt+AiE=;
        b=Dj7eAhyb4FFx/j0m8fbO1Zhcmo9jBi1c/WYjejTyQAKd+YYPpfiHldpmp1BvxqpK27
         iVOM2BBfHCB2it/g/MhRIC+90ZRVX6zQueo5TxC5rWXic4sQ/PxDfK9r1AS4AHJd113B
         mW53TPXuLkCn35JY9f8Ox+1hpZOp+Thv1cD3vfhTYHINNI6PgP/L5qmFKy1hpX2KXToX
         cCr74D4AhHQJ9ckJZrcNqEzhQ+pUamZDbFpGQ8CryM9shyn3ju+RZPPsJmDcQoc6s4Xi
         QXeg+1nF/RmpvsPgU3zLBCJxGQB/22/S+0b6V/mmDOHAE4i1mbyPlzMH4OMPNhmv9g0i
         uXGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791951684; x=1792556484; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2grbJw/Issi66ell9ynhnVcAT71hGUf9xcfUvHsRTPI=;
        b=ckamKxOSS5ZVtXVHuveq7kbmhD7Qt8WJ8Uz3xyC39ype1k2EXlMS0MNODY3n5qf5Y9
         Ok524oLIvlOHC8coZJJs84BnbCbwFMtU3Z8Q8GtJLtAKGauwU3JXowqGgMr7RCJglBnF
         ZCzVsTkeWyzGxVo/2H2U74scwQbkbHivz/hXZC3H1aj0SYV6eH4dpTal8Q+jkyOJWpwY
         txSANywoEhEYX5dpvCCDHm7HQRgJLhK1vnjdXYcYmu0BP7jJPsWmfi6z7XF5hpWDhDYo
         gsSQmpdu1vSMjQBeK/soP2rXjFJo4Z0eyOmTaIedSVl6OPx1O02TmGkA4p7QJzzETq2E
         EaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791951684; x=1792556484;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2grbJw/Issi66ell9ynhnVcAT71hGUf9xcfUvHsRTPI=;
        b=HcNRqK7wxELmJqa0JAVsQ36wNZNnGXpQ5lK7bJzX0tX2VYOjEwd54+v6FiLe4uPCp/
         9v2N8cWRh2Bva5QC6gAK0cPDuc+5Fcql+gLdVQFsjeJvAHYPLETp6fLiBhE6Xod0SX7a
         OCcfvbGjW9/8Sm9D+XpXT1J7e/FHJZMr0LSikUJRFGLHqeeh0Ck5ciLuPTJr9BVrrnHr
         tWxPtzmCFIkr2+On4DRbusmwaMKU4nk1tKz49ci/dNP1OXOlN7jZPENuSQ4KCHDE/yu7
         +2PFpLeTLhXCM3DZuDSMw5b/2EPI4a5qeFX8u6bB2HoyxEfGiZEW/YtLYfCE7hv8o8No
         8eJw==
X-Forwarded-Encrypted: i=1; AKwUvBzX5Xsgdy2eUCLLINwcbqwXJcIjM63QmrpkdSFooYsYidpo0g66j7NXl64Sesp6adXd7cto786SOq4Afkyru7kc@vger.kernel.org
X-Gm-Message-State: AFq9FYKzFeV1vn/ekcJ8KOzubdaeBdOqWHNVR6GeY6PuW7mwARw4sSuU
	Nd6aQ1t8oBLM6ZjvW6wVmfyWHHJRLHT9zGzVBv/qq3yehRcvjHssfw4BBt/uYQJFdOxN0+35yPY
	jT2gdLPr3o2UG/J39dVCPd9iD9L9vt6BA3IsVM3SE
X-Gm-Gg: AYBFou2a4ejtDtSGF6EcIpjgGWHf3LIlC1GtHLetoe7bjam7DUxAOtczAGF6URqqYAg
	rmAIxsqem5Or+MkzB/NXJ6jkvSs3S6kEBR6qjxC2JbAvx3EwyfIHGyMG3qviQrfhkJYLF9ax9Nl
	4FaapZ0jELG8axbhhugr8ZqFPODaHmSruPiiBWVbAmf6xzW/44mm4pIl/hhLlJf6CvDjIRijLxH
	T+xssqlAopnJPJ3bdA5AhfUEB6LqH37W95Rjcp16MfhiMM2tAJmClKbKEUnToP/+nk8caBxCcTP
	Gq4dgrLM0GcB19WHhg/S2to2BuIPQb1sfJb9feWTouAy+MhkzXVj9lQ=
X-Received: by 2002:a05:622a:4cca:b0:535:852e:a94a with SMTP id
 d75a77b69052e-53602372601mr6443441cf.7.1791951683567; Tue, 13 Oct 2026
 21:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006-james-perf-timechart-mypy-v1-0-e2c7edf4dd31@linaro.org>
In-Reply-To: <20261006-james-perf-timechart-mypy-v1-0-e2c7edf4dd31@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Oct 2026 21:21:12 -0700
X-Gm-Features: AclHuK9WIXj2sByPsg3xQovB10FYGg7q3yTP2FKnRU4saVxapsfo9MvVb8B-joc
Message-ID: <CAP-5=fVypGeXuKw1vJMaqGhpUtF3vqPcdKpo+Q61qZHGKSj2Ew@mail.gmail.com>
Subject: Re: [PATCH 0/2] perf timechart/treport: Fix mypy errors
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Alice Rogers <alice.mei.rogers@gmail.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 6:03=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> Two small adjustments to silence Mypy static checks.
>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
> James Clark (2):
>       perf timechart: Fix task row type narrowing in goto_task()
>       perf treport: Fix profile builder type narrowing in progress callba=
ck
>
>  tools/perf/python/treport.py    | 5 +++--
>  tools/perf/python/ttimechart.py | 5 ++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> ---
> base-commit: 1dc462fc214907671600172280c2e79ef9fe6fcf
> change-id: 20261006-james-perf-timechart-mypy-e0069393c0ef
>
> Best regards,
> --
> James Clark <james.clark@linaro.org>
>
