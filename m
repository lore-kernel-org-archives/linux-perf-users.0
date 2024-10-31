Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9710815D1
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Oct 2024 04:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730348288; cv=none; b=N6kjAmGh8ulkyMEDj4/mv0iTn7E2qiObOpVTJENlyyKSZ6TOY2HyESEemKuikFIRKuOWFJrsZDY9cOm5fU0bvGaqEvUBzR4glt2V68o+5p+du4iEtN59iKElyvmP31xIPVSwRQr47cp6T95JHqJnVsRpAzZGwHnD6kYF48D0bOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730348288; c=relaxed/simple;
	bh=fTsV0Arf05s8ipgk8AIaMKQ3/ewrlFnnTjXlvrNkzSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVAmTRS12LxpUb71KhugUmswU5esu4nvE/ezO7s4pHsczHKuF5ewXSlQenaB6IhHZR0as/nM4DcxBT6HWyYKn2pkakpesFEjPcO++rM/GHm8zDEFuE2ZosdEQhWy2aB20+Rrt/V9HJCG4DpLdw/L5Jv6fkYlJIeZnKZurxKHbGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+ohxmP4; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+ohxmP4"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so42075ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 21:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730348284; x=1730953084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdr3ttCC1d0Nzs/hMGVxxTIcSH4KN8n2mVPMAeK2k48=;
        b=G+ohxmP4WKlGRiS9M2GrcuzxKJ8i1PRFdyPs3MKPDuiBl2zSyPyGVVSexmjbT5KYvO
         CAc8NSdtWJTH0QQOQDj/E9UZJrgiH6rJKUPaMqFKq1hizOxqaYu8ibk1o6qx3k/aqjDu
         d9WPFF3Xs3wi54mdb1IftYU/KMM50Gy1+CDnWurD5oaUlghQlOUnfuFzc2K2diAmRZyc
         viihuAottSV5RxHQOLn6adezcnzR10EK/oUeVncEEBvhqMSlvKxGpi4bYUWrln9kYVrA
         mMWsKhN3+1U0hGx3tKDwKpfhte7Zlczba1e6e8y7P5PqqcGiHxOxmmDPSpWLnM7xhfQV
         RZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730348284; x=1730953084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdr3ttCC1d0Nzs/hMGVxxTIcSH4KN8n2mVPMAeK2k48=;
        b=HKRWDp33Wj98dsDk4cD8mYwf2drHgGJt7NNnz9W0yUyN20GTLaPl4t2gRfSQHi+nUV
         joyjRbUaujccbzTFvAtpIIOVBnsWg2pHsI5en70B+lGJMVldYtEodu/kbjixWjDgT794
         1YaNd/Oqc1vu0EKezLkeoivzjXpwD2TWN1F+H4MMQts9f3NJjTCZQMQyJcn2Q1S9ElvP
         QmHDGkRmrhP8NTyT0QylWOIHQTbqMW7b6UHbWLXnOZWVqtztyii0+uffmHChCWGLUi5X
         jBbNKkdqUMUiPs4cgGhSQgZE8fhZJ1lbK5Psy4lPLxf2ujSGxqn/ScBjuNEGW6X0ebrH
         +F3Q==
X-Gm-Message-State: AOJu0YxR0Ds9fknKl2iQb9O7bsZ/4jnhY7FtMnIjDMeL/56eQcxXWVP8
	lkTYgDNUClbTS/NqQ7Tv4u9LDgDT9sdZIpGOEz/yZrSFuWQZ9LRQM6gVMmYXU0eLFtbY8HNh7SO
	0LQ9ZfYQPtc7TBf9Hz7hs7cgKXy3b151o679O
X-Gm-Gg: ASbGncu6Zx59qL9p6mNDhLLUe/lY5tzs3XqZ1zDEUOU0QgkBemmfdnC4peGMnLEfEdv
	RDqi7gxUOXhwX+JkGgx5f2+cNhZLYrxOM
X-Google-Smtp-Source: AGHT+IEwrxFNAf0lepdvSGEs2bsxhKvkMyAihkdfdeQcJc25/sLJ+asWr1d1F3cbpjuDCyizt+P0isZVi1H56joUzo8=
X-Received: by 2002:a05:6e02:1d97:b0:3a0:a224:eb2c with SMTP id
 e9e14a558f8ab-3a6a945307amr1291475ab.25.1730348283592; Wed, 30 Oct 2024
 21:18:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030113946.229361-1-james.clark@linaro.org> <20241030113946.229361-3-james.clark@linaro.org>
In-Reply-To: <20241030113946.229361-3-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 30 Oct 2024 21:17:52 -0700
Message-ID: <CAP-5=fWO3B9HT3oQ_7qtd=pQBpcUK7VRtcpLoBbKkGsnaH1YRA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf stat: Also hide metric-units from JSON when
 event didn't run
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	tim.c.chen@linux.intel.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 4:40=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> We decided to hide NULL metric-units rather than showing it as "(null)"
> when a dependent event for a metric doesn't exist. But on hybrid systems
> if the process doesn't hit a PMU you get an empty string metric unit
> instead. To make it consistent change all empty strings to NULL.
>
> Note that metric-threshold is already hidden in this case without this
> change.
>
> Where a process only runs on cpu_core and never hits cpu_atom:
> Before:
>  $ perf stat -j -- true
>  ...
>  {"counter-value" : "<not counted>", "unit" : "", "event" : "cpu_atom/bra=
nch-misses/", "event-runtime" : 0, "pcnt-running" : 0.00, "metric-value" : =
"0.000000", "metric-unit" : ""}
>  {"counter-value" : "6326.000000", "unit" : "", "event" : "cpu_core/branc=
h-misses/", "event-runtime" : 293786, "pcnt-running" : 100.00, "metric-valu=
e" : "3.553394", "metric-unit" : "of all branches", "metric-threshold" : "g=
ood"}
>  ...
>
> After:
>  ...
>  {"counter-value" : "<not counted>", "unit" : "", "event" : "cpu_atom/bra=
nch-misses/", "event-runtime" : 0, "pcnt-running" : 0.00}
>  {"counter-value" : "5778.000000", "unit" : "", "event" : "cpu_core/branc=
h-misses/", "event-runtime" : 282240, "pcnt-running" : 100.00, "metric-valu=
e" : "3.226797", "metric-unit" : "of all branches", "metric-threshold" : "g=
ood"}
>  ...
>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-display.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
> index a5d72f4a515c..0e16eecfbad8 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -854,7 +854,8 @@ static void printout(struct perf_stat_config *config,=
 struct outstate *os,
>
>         if (run =3D=3D 0 || ena =3D=3D 0 || counter->counts->scaled =3D=
=3D -1) {
>                 if (config->metric_only) {
> -                       pm(config, os, METRIC_THRESHOLD_UNKNOWN, "", "", =
0);
> +                       pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=
=3D*/NULL,
> +                          /*unit=3D*/NULL, /*val=3D*/0);
>                         return;
>                 }
>
> @@ -909,7 +910,7 @@ static void printout(struct perf_stat_config *config,=
 struct outstate *os,
>                         perf_stat__print_shadow_stats(config, counter, uv=
al, aggr_idx,
>                                                       &out, &config->metr=
ic_events);
>         } else {
> -               pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=3D*/NUL=
L, /*unit=3D*/"", /*val=3D*/0);
> +               pm(config, os, METRIC_THRESHOLD_UNKNOWN, /*format=3D*/NUL=
L, /*unit=3D*/NULL, /*val=3D*/0);
>         }
>
>         if (!config->metric_only) {
> --
> 2.34.1
>
