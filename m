Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7139A18CBFB
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Apr 2025 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743717251; cv=none; b=Jckl1uS3Y00aMONnlUQXiNeCUQpEJ3S/5QavfTGIA2ghG+rtYgoHAYDDuwkwJQT8tBAy1fpJwZxuTb3PbxoR4fIiQTBqfyp4D2GoavsDj4vUjCjp9KF0lW9i72JggRgJDPXWkXQXUq3BH2bQTEvi93NV69SIJ8wdizKp7e5ALRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743717251; c=relaxed/simple;
	bh=Zorq4tfBnBxbbHts98Mgzhn0BJooRVRBhU2HN84gMNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GGui+Ka4QbkzzpOPa0qReycwqQJ63/NuhbSIFbKGByiua9sIxMW25C0JHIegQFqVKACwGRaZKgPWKwTdbTxyY12w9ZOat1ZHsLVu5K6tBOgdSlbclxs8am4x8RQ0p0+2WbWp6i/ld0cWC+iZDG8K3uAiY7DJxho1AAhyDhUTp0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D1qUld2N; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D1qUld2N"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2240aad70f2so77625ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Apr 2025 14:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743717249; x=1744322049; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rK5qPDgvAhys1k6qbeaADQ2R+ajOm7raTMVCCFCPI54=;
        b=D1qUld2NzKCb7N0R4rIe4cXsdon/8P10mrEVoErI97B4EsoCcLZByNmPhAK/26XWRD
         BKbtLTCOF0YsSuoyvJc9ff6oo9eSjs1DJviLl9g+3S/1FjBZZDC1M8G0nKOcyuQ29Il8
         ++sAgS7BYMesMXM3n/glZQrESXKN7BrjxgzIacklra7uI/IzZ9SdtLOZyFelIDdoUtxS
         vPZxR4DMDT+SbRtugXLKPfn2iaOoez5SnRIMVhN5dxu9iDvU/fUoA1yCedOw8Xmrubya
         Y98lxUFZcdkXmcJAZOZKJPNdHaYIRyNvBFUAKFan7RmLgDMB0yuADqRQ63nbXKM69SY9
         +j1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743717249; x=1744322049;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rK5qPDgvAhys1k6qbeaADQ2R+ajOm7raTMVCCFCPI54=;
        b=sLZ18SPS6ahFw8mdDCPdoA4eZAiORPmy1Ep/akthGRtII/+1KEwMuY+lKLybv4cRIc
         C65jWPB0SfztWy7Ny5mIN3difdajDQ7NcnaGKZkI9Jt4BesCsH/uDIAKONBGr6btiI3q
         DG/YLGrxtxCt/vnuiPHNYMc5WggQqdRUbiiniafmDVHQ+VpvSpNPcE4wxdB+s+R+sccu
         DfKw4vwGKGlP+xEbR/6tky8TXR8gEHHjslOvk1qWPcolI6Ft3p/waLT9IJYdmaR/gOq4
         axFfzMeEodbfpQTqkwDymHyciqkfO7kWrXDwtcKjYWeXd9l/jU5/WZEIl+Ny1FyLprPb
         Kheg==
X-Forwarded-Encrypted: i=1; AJvYcCVy2+kD1GG8jK610m3zbtVFH1FFubvYOiq1iPkhZe5i46jFl3bZPuIVm1xe6U4yX91UatFbzd9ufopVJQJyMmuB@vger.kernel.org
X-Gm-Message-State: AOJu0YwjMlqV9/L/KcGxF8BB9BH21vo3JbWjqZ6Yw7kAwQWanXCzAMP+
	feb5lp9MLUuIx0KEdvGiblsbpZHuoXDW124lbZRbIL/1ZHD7UnctUOSzi5Y4gA5uJU8U/qWPX/I
	xEgAAJQ2Lk8kZJro4SxOaDr9gWKQVf7FWvQ4u
X-Gm-Gg: ASbGncvjcqVSH2q3y2NpikoexP3dp0XcR2+mYqT6LsQcW+7mXrnLbyiRkSGqJUwL3K+
	S3Ip6+JvM6YSmk5gXj6c6vQM/46sbLC6bc5egOjN7m5PdjpuUoW9wbk3Zk0imyVeGAoQKLL6kY2
	JSErqvWwG81Wjc/8aVT0bEzZlL5lqT7N5IbNzyoSL9y5ymroc8qckIVQ==
X-Google-Smtp-Source: AGHT+IE8hli2cwmBOYnuZl9Y0z26+XxYb00ecwO3Bhyit5DVDAbl0YKGDMXKsyg9+8mpPQKFlW8YJydvxUYSO/TEbt8=
X-Received: by 2002:a17:903:1c9:b0:21f:3e29:9cd1 with SMTP id
 d9443c01a7336-22a8b6b2aa4mr342215ad.1.1743717249394; Thu, 03 Apr 2025
 14:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402183806.3947021-1-irogers@google.com>
In-Reply-To: <20250402183806.3947021-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 3 Apr 2025 14:53:58 -0700
X-Gm-Features: AQ5f1Jqda-Rwv-Gl_E_R0J0SF5BsOC2s-WrgNbz21Q4xNj59MZ8sxSLFfcgno6Q
Message-ID: <CAP-5=fW5XP23KsF3VGp-xRutkbfk2a66h92jx9d6=ocf69FV=Q@mail.gmail.com>
Subject: Re: [PATCH v1] perf jevents: Allow duplicate metrics with different PMUs
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Falcon <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 11:38=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On hybrid machines the same metric may appear for cpu_atom and
> cpu_core as well as being referenced from other metrics. The same
> named metrics are required but on differing PMUs are required. Update
> the jevents.py to handle this.
>
> On (hybrid) Alderlake before:
> ```
> $ perf stat -M tma_fp_divider -a sleep 1
> event syntax error: '.._ACTIVE!3/,tma_core_bound/metric-id=3Dtma_core_bou=
nd/,tma_backend_bound/metric-id=3Dtma_..'
>                                   \___ Bad event or PMU
> ```
>
> After:
> ```
> $ perf stat -M tma_fp_divider -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>      1,257,833,472      cpu_core/TOPDOWN.SLOTS/          #      0.0 %  tm=
a_fp_divider
>             45,870      cpu_core/ARITH.FPDIV_ACTIVE/
>        187,096,541      cpu_core/topdown-retiring/
>        199,533,380      cpu_core/topdown-mem-bound/
>        107,164,806      cpu_core/topdown-bad-spec/
>        214,281,782      cpu_core/CPU_CLK_UNHALTED.THREAD/
>          1,588,539      cpu_core/ARITH.DIV_ACTIVE/
>        538,842,818      cpu_core/topdown-fe-bound/
>        431,005,264      cpu_core/topdown-be-bound/
> ```
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/jevents.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 36a5e5fa2a54..89f1ace2a697 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -481,7 +481,8 @@ def add_events_table_entries(item: os.DirEntry, topic=
: str) -> None:
>    for e in read_json_events(item.path, topic):
>      if e.name:
>        _pending_events.append(e)
> -    if e.metric_name and not any(e.metric_name =3D=3D x.metric_name for =
x in _pending_metrics):
> +    if e.metric_name and not any(e.metric_name =3D=3D x.metric_name and
> +                                 e.pmu =3D=3D x.pmu for x in _pending_me=
trics):

This was triggered by this patch carried in Google's tree but not yet
merged into perf-tools-next:
https://lore.kernel.org/lkml/20240926173554.404411-10-irogers@google.com/
So please ignore.

Thanks,
Ian

>        _pending_metrics.append(e)
>
>
> --
> 2.49.0.504.g3bcea36a83-goog
>
