Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D021A19AD80
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jul 2024 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721136849; cv=none; b=GIr64dMDZCeLolVYRmbVvNdDiwko1qsYLaZVBA2bVjKdRVYHOqQxJom6ToDeD3fAxMnEep6DMGUENvsQM1iruJ/NASbzownhbbfNbgqsD0m9xoC3sTskTb+BvSxDPQBrybBH20Q4GvCplYd1e3I/urmggrviNsyC6s8oolf+Efo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721136849; c=relaxed/simple;
	bh=+edc5xyo7SNQeaQNFbWXs+Tm3sUeDiyy8ZmXrozCLfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YtYmi1zVB/T/uYGsErtr7cqBF61tAAqaycSjHWbbkeR+rswZ6vOA93xPTNho/fVoEpprviTP5mpnbShn6VXS47qKxOvnd2CnUIgw33J3Qfrv7oCHZwa79vgjeN8Yz1pmzqOIEGqJGAPR9JFt38h4CbIXjp5Nf6MFNbBy0OhVgKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p5J4KK6c; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p5J4KK6c"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3815ad8adc9so166675ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Jul 2024 06:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721136847; x=1721741647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQBlIx+MbLsC+Vy1pbzJoOe43hAv765RYr7yJg8JEZ4=;
        b=p5J4KK6c44PFOrW5TB9xGYMxap0YMuV0/GDAt/EaGZfxDKTFukCdlaxCnO5YvBOxil
         oM3bujIsvroHTHDeQsjU7R/Wd0ESMe94MvUEUnoiGDMuurjyYK52194avHO0RFk+w1Ay
         mkHisRrO7hgpTZh9dWmXcMqW79k2I392/3UEN26D/gjN+i9P4gXGE/49r6zc+xBjYxLP
         1qdAW4ziKvCH/UDeM32tsFsaN/WT/uby8Q0c4Jm3ZSIkM+64eiqpQiO2pN0FGrk8HldH
         87p92FYSzCn32Zj2HtRVPWuAWGllSvYjKnO2xvzKKR6dmpR8fNnowuRLJ43kDbLnotB3
         Xwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721136847; x=1721741647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQBlIx+MbLsC+Vy1pbzJoOe43hAv765RYr7yJg8JEZ4=;
        b=h1rRg+YnDyBwHg4gMiM0+L+16yF2INhz5pIIg3eJjwuwR6vGNCIcUlPhCsJht8gg+v
         1J6pDOFqsnAGhMbQNBEng3GCZCr49N2nczsONAubGLcYV/GpSBBqzIH8pHE3JKNdh/dM
         kS1PUFWryqRJLoP/F67DqXktGtu4/39SHZ12VeZ0FMLQ4Jywfytv8ky31x0Sw8m7fHcR
         rKuz00vaWKcZmQxHMVQBvmVErYGjC0y/BywsOPLIyCgF16QuHyP/k9uW34tpEfNlARFw
         RasyOOMBLsclPmctFJKo7NCiGJL1PneTQybD0/M0bdAtUCQ8D+7PgmN2lLgr+9VPr/GP
         FAjQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0eqeFJbPxxIWTWEnBs7JSHwl9nuKTnIBF5DHq1950U/HZoH0AHWL0URuL/DgUBUrjSlk+eeLL1QmoLJBwm+nR0ZNlGNdLukiBj2yoVc3g7g==
X-Gm-Message-State: AOJu0Yw8H9+L9AnCq1fEjVNxqNvrLn1gFau8ZL8Szw4iriJ+VbD+9vDo
	/XctpprFNdeuqDxjjBHrxnAI7zpwyK/HGnbP96OpFwbX4XdmN8KLN36XwgkG14drFGaFpaFjSEM
	QkX2hF0+bRihMtvHkpr68jv/qLuV8wSoOJcJy
X-Google-Smtp-Source: AGHT+IGtFaWf50TIORBi/HuxOGMvmqdyJb2rTuRdSU75GpFxkoV0cPiqLMktwAAj9pa02+8lpPweTPaMd6nedQdhjkk=
X-Received: by 2002:a05:6e02:1fc8:b0:376:f79:1337 with SMTP id
 e9e14a558f8ab-393e7ddac7fmr2670755ab.1.1721136846711; Tue, 16 Jul 2024
 06:34:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716075347.969041-1-nichen@iscas.ac.cn>
In-Reply-To: <20240716075347.969041-1-nichen@iscas.ac.cn>
From: Ian Rogers <irogers@google.com>
Date: Tue, 16 Jul 2024 06:33:54 -0700
Message-ID: <CAP-5=fV8J1UE8gYgXL16ZqaVQ=cNLV2wrFWA4Z3e8HbTLoAxmQ@mail.gmail.com>
Subject: Re: [PATCH] perf inject: Convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 12:55=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote=
:
>
> Replace a comma between expression statements by a semicolon.
>
> Fixes: 97406a7e4fa6 ("perf inject: Add support for injecting guest sideba=
nd events")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-inject.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index a212678d47be..7b4a5d56d279 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -2069,7 +2069,7 @@ static int __cmd_inject(struct perf_inject *inject)
>                  */
>                 inject->tool.finished_init      =3D host__finished_init;
>                 /* Obey finished round ordering */
> -               inject->tool.finished_round     =3D host__finished_round,
> +               inject->tool.finished_round     =3D host__finished_round;
>                 /* Keep track of which CPU a VCPU is runnng on */
>                 inject->tool.context_switch     =3D host__context_switch;
>                 /*
> --
> 2.25.1
>
