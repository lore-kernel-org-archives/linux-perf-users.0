Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D2D80BEE;
	Tue, 11 Jun 2024 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124612; cv=none; b=iGeOsMEyCVOedcfSQPTg2FdrKG0fbIAJjd4bSuaXLNvziQIw36+TpHbnzSDTVohpnEPzyPeRXCkru1pMAJo0cSIYzh+GQIDedhqkNRMxuePdxB9LHstMsclrhCCTZZIXMU/gkQu9BzxX1nlqfyeiGRh5aHJ2qFugsmIjnoNLoV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124612; c=relaxed/simple;
	bh=nXC05/2DJAwYBoUHyY+xX1rLV/tpXFAkZs1z94miDWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzTgVNMk+m2WPuD4k6/AOJeITWUwEYgQFa0i+ZfA+hL9ewTpUwadskoCzfLpfmACt+kyvUas9L0A3CMEaBKKt5Bx48+iUGczpIwdmOpLvYYlshRIl11etdB4BxVn20f2PVqx8gT0m7wKgS3sXG7Y9Mfii4i2MuVd5F4Z9Cl9Q1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4ecf11aa0d6so395161e0c.3;
        Tue, 11 Jun 2024 09:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718124609; x=1718729409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmMezwrC5bvtXnkcOWEuYA4Z8ryRN9EHWxOexMV7RXM=;
        b=KYLpHhwu+r3Wvfztqqap3z+000InoHM79ySb1EhgvbxntQVadJ6+BUOy72oUxuCbP4
         VtswoDTqKGQasWSHUNJeybEBYqo5HERhu5Z+Kho7cXFPDz7MzeMhP88WKu54T3bsxR9T
         BGPA69FUbxFmR95D6U3StN/w94Xyo9KIJDZD9vRbhtBONA/85VyQjQcstQVtvrZn0EKN
         PHo1jNu2vKba9rw4qJRuUOOJPJA2QwmGjh4i76XZ5YIYTpyf3D4QXvLB+Mh7IujmkQYr
         NhCeGReoQIADm5ZSW6vqVyjiBQ9wFMtSd3KGu5r2InNJZ2W6u6BklLZrUjBGd0hiWGDa
         a6UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBn1VlA7lbVmTHfgjjtpY+1Oa2fOp/y0GF4A5N4AzLEL7q87/2ozXiaf+RFuWRVoZjfcXdeYZcTBm6eFoFPIVe+6OVxcu7djyyJlOL9/oBAd16kXBW7b+fI2Z3JmlFQVko13xKN+9yIMWmT1B5ww==
X-Gm-Message-State: AOJu0YwmEPwYtKn5ZVZG0iUEGHL8xTVSjSS7STKszWhD7zQsrWS/mR0O
	D13N1CNWOJabZKsaOCkLbHV/NBoERLtmXfEGPm0t5eevcMy51gS6v0aGJjNL50hUDo6ZFB9DD3q
	CIRT7HPeIZ4625/ycH4Lq3RVwiwA=
X-Google-Smtp-Source: AGHT+IE9ZtnNneoTJn5ZzqaZMNi1/FtV5GFyS1Sgd38hG+C5SPxFHWjKUhBcbzXkvN/y3DdggYd2pbSUOs79oCIjDkI=
X-Received: by 2002:ac5:c9a4:0:b0:4d4:2fbc:e61f with SMTP id
 71dfb90a1353d-4eb562c2a7fmr10022119e0c.14.1718124609228; Tue, 11 Jun 2024
 09:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611052331.85715-1-weilin.wang@intel.com> <20240611052331.85715-7-weilin.wang@intel.com>
In-Reply-To: <20240611052331.85715-7-weilin.wang@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 11 Jun 2024 09:49:57 -0700
Message-ID: <CAM9d7chQFeqCFJAfnRFKkQkxyRtOotF3kE49tL47EuEEBC_RkA@mail.gmail.com>
Subject: Re: [RFC PATCH v12 6/8] perf stat: Add command line option for
 enabling tpebs recording
To: weilin.wang@intel.com
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jun 10, 2024 at 10:24=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> With this command line option, tpebs recording is turned off in perf stat=
 on
> default. It will only be turned on when this option is given in perf stat
> command.
>
> Exampe with --enable-tpebs-recording:
>
> perf stat -M tma_dtlb_store -a --enable-tpebs-recording sleep 1
>
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.000 MB - ]
>
>  Performance counter stats for 'system wide':
>
>        181,047,168      cpu_core/TOPDOWN.SLOTS/          #      0.6 %  tm=
a_dtlb_store
>          3,195,608      cpu_core/topdown-retiring/
>         40,156,649      cpu_core/topdown-mem-bound/
>          3,550,925      cpu_core/topdown-bad-spec/
>        117,571,818      cpu_core/topdown-fe-bound/
>         57,118,087      cpu_core/topdown-be-bound/
>             69,179      cpu_core/EXE_ACTIVITY.BOUND_ON_STORES/
>              4,582      cpu_core/MEM_INST_RETIRED.STLB_HIT_STORES/
>         30,183,104      cpu_core/CPU_CLK_UNHALTED.DISTRIBUTED/
>         30,556,790      cpu_core/CPU_CLK_UNHALTED.THREAD/
>            168,486      cpu_core/DTLB_STORE_MISSES.WALK_ACTIVE/
>                  0      MEM_INST_RETIRED.STLB_HIT_STORES:R

Here I guess we can expect a non-zero value, right?

>
>        1.003105924 seconds time elapsed
>
> Exampe without --enable-tpebs-recording:
>
> perf stat -M tma_dtlb_store -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>        181,047,168      cpu_core/TOPDOWN.SLOTS/          #      0.6 %  tm=
a_dtlb_store
>          3,195,608      cpu_core/topdown-retiring/
>         40,156,649      cpu_core/topdown-mem-bound/
>          3,550,925      cpu_core/topdown-bad-spec/
>        117,571,818      cpu_core/topdown-fe-bound/
>         57,118,087      cpu_core/topdown-be-bound/
>             69,179      cpu_core/EXE_ACTIVITY.BOUND_ON_STORES/
>              4,582      cpu_core/MEM_INST_RETIRED.STLB_HIT_STORES/
>         30,183,104      cpu_core/CPU_CLK_UNHALTED.DISTRIBUTED/
>         30,556,790      cpu_core/CPU_CLK_UNHALTED.THREAD/
>            168,486      cpu_core/DTLB_STORE_MISSES.WALK_ACTIVE/
>                  0      MEM_INST_RETIRED.STLB_HIT_STORES:R
>
>        1.003105924 seconds time elapsed
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/builtin-stat.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 14be132f7b6f..055139e44763 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1235,6 +1235,8 @@ static struct option stat_options[] =3D {

What's the base of your patchset?  I think we moved this to cmd_stat().
Please make sure to rebase on the perf-tools-next.


>                        "disable adding events for the metric threshold ca=
lculation"),
>         OPT_BOOLEAN(0, "topdown", &topdown_run,
>                         "measure top-down statistics"),
> +       OPT_BOOLEAN(0, "enable-tpebs-recording", &tpebs_recording,
> +                       "enable recording for tpebs when retire_latency r=
equired"),

Please update the documentation (man page) for this option.

Also I'm afraid it'd fail to build on non-x86 because tpebes_recording
is defined in intel-tpebs.c.

Thanks,
Namhyung


>         OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
>                         "Set the metrics level for the top-down statistic=
s (0: max level)"),
>         OPT_BOOLEAN(0, "smi-cost", &smi_cost,
> --
> 2.43.0
>
