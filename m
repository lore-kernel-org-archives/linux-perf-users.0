Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3B5143874
	for <linux-perf-users@vger.kernel.org>; Thu, 16 May 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715875856; cv=none; b=STc1eSMZdIHPZpQipYG8hJn0XESUAjgVK78gvTM//07JolgCtTj1a+RQvsjawsA213vi4w350m/7X97RrfCfsDA2GwEULhiJkVO8qTzVAoT/gX0LpM5jwgKjKMRa4XeUTDKdzC+zGM1moHwQRJDJwbx5tomMNKhZ8MNOBWoH+QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715875856; c=relaxed/simple;
	bh=riGo2bNvIkmqF3bNt1u4SZ23kWVRfhNb6lvtp2o9/WY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reN1wAG4miwCYcEEiPhKdWQDkhc/M7C7yN5+rwvfRPsbmMrn/udP/z9sbnRxO4kJW0JPdowhRiYrV+3mlId2q5n5PngE4Ab77ZupGve/VUFYrage37D174C4B7NPr12N4mEcpYlIoJgNO9XtuCd3Coq9VpeN7OaPiQCFoWsLJJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T+j/Xi7l; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T+j/Xi7l"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36c6056f7bdso45545ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 16 May 2024 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715875854; x=1716480654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eh9JXAGNMN/0z68DknuGCigjQIyZqXfKROEQRYbok9g=;
        b=T+j/Xi7l9NE/UwDcGQ8Ti68dY0Xyu4Y7Dto+oiOjxUxU/6UmHGoCKYTF68eumos6Df
         6WyfsLpp/dtKJtAph60TKHExrddZaYj0xodUsp9Nf4cj1pirjPbUN6FXrGokPEXjblGH
         67ItGxseiXz8CDfoLGBfATrpXBEZuEJtodCQJvxDFt014cO8EmwA/GmuAWfcH9KYQY6a
         +nYAOxUc82Ru8hkoeTuvVVDRw4C8BsoIJ0NNda7wBAXoCflNtG5ln+E67FZabm7RYAYD
         I9opmvfX5nlGhTI/uNl5mpShUzPSzFBRcCtAI8b5Y0n1nIaeEufgn3/5wZR3yjRywWyL
         U7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715875854; x=1716480654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eh9JXAGNMN/0z68DknuGCigjQIyZqXfKROEQRYbok9g=;
        b=N3S0ivICCCoJQtoW4bnxR/hCcMlMm7pufiSYTHB47m0Hd+adjQbWdRO7TtPWO5BkiJ
         z58aARcZB9JwKI787q1AMhHnMEbezOk+QqUylFfLvWKnncjUQPZ6kFPrjpSq+/R6jsGp
         oqFaepZY4YDRE4TnFbZLRX/2bnSyWC07TKM6OocsjiZU858SoWg73MlmNNseUFjxNvVC
         fytjbrGBOB3/fWfxFCedmZ8Hl+j2e1Ymc7bZxx+lm181Z8Gogq670FT277HXtJbpQ1/5
         yHeAGRzFG7deCKtu5ibw5GFuhtIgC0khaDqQ8alCuBkOHaSPmlosbAyQVX991GbfSmMF
         2+gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYWk2XOM8ZLnfHLNQiFUd/33+b2CiTJDFUIlfkCR7HAW63wuS5UsFJOHd2yieEq1PxVZwV/YfYU2nuUlnqPMp2UxlmvUWMrCf8suxnklvrAg==
X-Gm-Message-State: AOJu0Yw5y9UyOWsl697KbhvxiXoqwLTZt4ctYr7vyv2Wqgm/AgT7MUfa
	+ka2FLtUmiE9anT+1vRzK0qziCptxHUKF//wkHnLF/7aeC/rlJArUXce7l8EEFqR2NlLRpRFYQn
	bugBE5lR2dN82reDQTZZuPwb8gZkdEc7rNEco
X-Google-Smtp-Source: AGHT+IH+ZoiqTvEd2yFP85WOiWgnLAh9kWUCfjs5Qah2sxJ7a8/GgFvYV/yhPeSnRHlAVR7Dxx2kmTxoi7JNOMu5G0c=
X-Received: by 2002:a05:6e02:190c:b0:36c:7f13:e4a1 with SMTP id
 e9e14a558f8ab-36cccb4f6a6mr17620175ab.21.1715875854150; Thu, 16 May 2024
 09:10:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515054443.2824147-1-weilin.wang@intel.com> <20240515054443.2824147-2-weilin.wang@intel.com>
In-Reply-To: <20240515054443.2824147-2-weilin.wang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 16 May 2024 09:10:42 -0700
Message-ID: <CAP-5=fVJmJ0MapzadOcBfQj69FKhaFA9YtonMy4W7kUfDSXS9Q@mail.gmail.com>
Subject: Re: [RFC PATCH v8 1/7] perf Document: Add TPEBS to Documents
To: weilin.wang@intel.com
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 10:44=E2=80=AFPM <weilin.wang@intel.com> wrote:
>
> From: Weilin Wang <weilin.wang@intel.com>
>
> TPEBS is a new feature in next generation of Intel PMU. It will be used i=
n new
> TMA releases. Adding related introduction to documents while adding new c=
ode to
> support it in perf stat.
>
> Signed-off-by: Weilin Wang <weilin.wang@intel.com>
> ---
>  tools/perf/Documentation/perf-list.txt |  1 +
>  tools/perf/Documentation/topdown.txt   | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Document=
ation/perf-list.txt
> index 6bf2468f59d3..dea005410ec0 100644
> --- a/tools/perf/Documentation/perf-list.txt
> +++ b/tools/perf/Documentation/perf-list.txt
> @@ -72,6 +72,7 @@ counted. The following modifiers exist:
>   W - group is weak and will fallback to non-group if not schedulable,
>   e - group or event are exclusive and do not share the PMU
>   b - use BPF aggregration (see perf stat --bpf-counters)
> + R - retire latency value of the event
>
>  The 'p' modifier can be used for specifying how precise the instruction
>  address should be. The 'p' modifier can be specified multiple times:
> diff --git a/tools/perf/Documentation/topdown.txt b/tools/perf/Documentat=
ion/topdown.txt
> index ae0aee86844f..e6c4424e8bf2 100644
> --- a/tools/perf/Documentation/topdown.txt
> +++ b/tools/perf/Documentation/topdown.txt
> @@ -325,6 +325,24 @@ other four level 2 metrics by subtracting correspond=
ing metrics as below.
>      Fetch_Bandwidth =3D Frontend_Bound - Fetch_Latency
>      Core_Bound =3D Backend_Bound - Memory_Bound
>
> +TPEBS in TopDown
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +TPEBS is one of the features provided by the next generation of Intel PM=
U. The

As this documentation will live a while "next generation" could become
ambiguous. I think it would be better to mention core ultra or some
other term to more specifically describe which PMUs have TPEBS.

> +TPEBS feature adds a 16 bit retire latency field in the Basic Info group=
 of the
> +PEBS record. It records the Core cycles since the retirement of the prev=
ious
> +instruction to the retirement of current instruction. Please refer to Se=
ction
> +8.4.1 of "Intel=C2=AE Architecture Instruction Set Extensions Programmin=
g Reference"
> +for more details about this feature.

Perhaps capture that this is placed in the perf event sample in the
weights section as TPEBS isn't exposed except within the kernel PMU
driver.

> +
> +In the most recent release of TMA, the metrics begin to use event retire=
_latency
> +values in some of the metrics=E2=80=99 formulas on processors that suppo=
rt TPEBS feature.
> +For previous generations that do not support TPEBS, the values are stati=
c and
> +predefined per processor family by the hardware architects. Due to the d=
iversity
> +of workloads in execution environments, retire latency values measured a=
t real
> +time are more accurate. Therefore, new TMA metrics that use TPEBS will p=
rovide
> +more accurate performance analysis results.

Do you want to capture what the value will be when there hasn't been a
sample? This corner case could be considered broken in the new
approach.

Thanks,
Ian

> +
>
>  [1] https://software.intel.com/en-us/top-down-microarchitecture-analysis=
-method-win
>  [2] https://sites.google.com/site/analysismethods/yasin-pubs
> --
> 2.43.0
>
