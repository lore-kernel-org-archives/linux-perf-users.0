Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59271214818
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739990461; cv=none; b=T3Tc0fIr5Ha6jSXoBLEODXKUgkzlpt6P2qNzghZqlQ2wK/m/ZdHJdA/8VZM3GFVIR67bbz8Dm5xeeuFBvuCkUIzgo61ECGGvXLsZC4gfQ0zqBirbl+8Gpw7/zdWhyZfVFyCk+w4MKPdHHiurKOqiSIEPY5SHMZdiKmORakcYLA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739990461; c=relaxed/simple;
	bh=IIN8sKn/JkDRZScgnbnPLuVy4gfcXsV2gLrZze5I2Mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbrvMNWUW0F+A3C/DhN20xYTQYmNOlFUVCXIrVWxiBoNOLlIzV2VWlT9pN+og6P/tADSCqshNMOYnxWmMofoCfqgSBvq0iSHQ9jzKhp005c2c65WNmFiGCtIkQHJFr/B1d4+LvMn2Ga0NKQO19sYDEc647ccI9wqQ7ONnDhovj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QNYBxTzX; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QNYBxTzX"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d2ad29f630so10335ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 10:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739990459; x=1740595259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjgEu2TRsYI02/jRPOsG5EqdBzkt36nQ7A/SJ6c3ACM=;
        b=QNYBxTzXrRZNuTZLasN9hgu1C7D7u9MS4CbS0FwNQELeZuCNiGed+E/rlWn2dxiTIR
         3TcbV95dW13O4hcxaJ5iw1enBsw/X9I2oBMhbdRTBv5g4D+XGcAz9Kci2OVWLZHk7epl
         UqEyaWX6Dy006rcbk37KPR9+aQsLRtZ867H0RcIwbibXqiHnbyuy8KPg6Id9clwg/sHY
         RymgulGMPp6aaXlHrBkjsaLpu1Yzm13yISMmLHNxSUZJ03ZjyKSNG93nzV/bPVlOmYE8
         LOXNoUu5ApkggQHHd97lzRqq/+/8iQf1mvT0GKZSJzqLM3HCtX4A7El9dmu/LxdbkQHO
         HXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739990459; x=1740595259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjgEu2TRsYI02/jRPOsG5EqdBzkt36nQ7A/SJ6c3ACM=;
        b=MpYFwfwfN9zero/pAwc2Yfa2Qbxtc5e4ZBAWmYN9jEwnK8HaOLDKzhO/YLlubOZPHA
         /RtwYDLCu5oTlXDTpc7KE7w279eroj3ohvO/N31o2ue1h/imTKWfRSgVSsf71JeLLHd3
         AyNJoRwf3pZRQYxW6EGnNROatsWuhE1CtqZMBUHmzVkEKC6tmW0FTXjAbb5nqw/yenqw
         CikmJ0tm7Uo6BxM03/l6Rs9gaK2lNHre8anQwKeL1ssNSi0i37p+GO9lmfZxu24GiaUk
         8jK0EPCnu3JCCtQA6FozVKnBOfMGNWhWRyQ95RKLSJAsLJGYRioElAhpgZliY3w8ZrS4
         P5dg==
X-Gm-Message-State: AOJu0Yxk+WjdbgASG26qtTDTp422xrGWhVlhl65kYXFJaSDOdd2y9nHe
	cPyTjZvIgwfDUX6Q/dd44+lPIsp58S4LBttmdqYVNBWOvQzAvHRvH13YshFGvLRuuf2gin58bHQ
	vOOrX+j9NRqDwjNpjTuu67ANIC3VxFPmrtWek
X-Gm-Gg: ASbGncsLVvkGTz33Rncjt7pPU9tJ9qveIj6+LcBS0g2kijb6+eTQfJgjINWIrPiOgJN
	gm6lokHlucNprFXDqr0bpOZCBEUtK8IAISqP4US/Dg1oHAuv2oqH7j+bOp2fypWKkGAzJFtT7cz
	++KnyD43SLqRuFM1YyzCwWn+tlkg==
X-Google-Smtp-Source: AGHT+IGpPLVjc/OqETD6R/4xC9CMaRClq2o7VPxZDVl2rJvmK/PatKKc7hT6bfH+UPDEtkyAPAGcviZQPAyjdHiSaL0=
X-Received: by 2002:a05:6e02:13ab:b0:3d0:4ff1:1d5f with SMTP id
 e9e14a558f8ab-3d2c08b03eamr88855ab.2.1739990459119; Wed, 19 Feb 2025 10:40:59
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219151622.1097289-1-james.clark@linaro.org>
In-Reply-To: <20250219151622.1097289-1-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Feb 2025 10:40:46 -0800
X-Gm-Features: AWEUYZkt4FMpT-EvL9wUxnZYAA1ze4S4h5OH5p0tAT8wjiwP1FOTcyW9pvnQBqc
Message-ID: <CAP-5=fXRgsjh8_U=WhAM_Q6jd2JBxtFmDkHgCpXbWh=YTZgVDQ@mail.gmail.com>
Subject: Re: [PATCH] perf list: Also append PMU name in verbose mode
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org, cyy@cyyself.name, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 7:17=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> When listing in verbose mode, the long description is used but the PMU
> name isn't appended. There doesn't seem to be a reason to exclude it
> when asking for more information, so use the same print block for both
> long and short descriptions.
>
> Before:
>   $ perf list -v
>   ...
>   inst_retired
>        [Instruction architecturally executed]
>
> After:
>   $ perf list -v
>   ...
>    inst_retired
>        [Instruction architecturally executed. Unit: armv8_cortex_a57]
>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-list.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 9e7fdfcdd7ff..c19826f218a0 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -163,11 +163,10 @@ static void default_print_event(void *ps, const cha=
r *topic, const char *pmu_nam
>         } else
>                 fputc('\n', fp);
>
> -       if (long_desc && print_state->long_desc) {
> -               fprintf(fp, "%*s", 8, "[");
> -               wordwrap(fp, long_desc, 8, pager_get_columns(), 0);
> -               fprintf(fp, "]\n");
> -       } else if (desc && print_state->desc) {
> +       if (long_desc && print_state->long_desc)
> +               desc =3D long_desc;
> +
> +       if (desc && (print_state->desc || print_state->long_desc)) {
>                 char *desc_with_unit =3D NULL;
>                 int desc_len =3D -1;
>
> --
> 2.34.1
>
