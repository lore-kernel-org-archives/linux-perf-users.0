Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C4A1A2C27
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jan 2025 19:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737142995; cv=none; b=lN+DNNwh2AxOF/OpJUW2K5QoOcoXO+leAr7RtI5lV4aD90BpgrotT3cU2eLTyaPH8e76aY/QKudUCKvgNEuF9STYAK2IkmJMycuATncv6y03vZ5VNDef6MGPsrgk8QA3Zy7o5Y9H5fZtXCx7UTPiK8d5SefNDrcQuMhZpRYLk8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737142995; c=relaxed/simple;
	bh=NuCeN92AyjA+w1lSIbRwJl5XIHjn4qU5QJSf4LBUsgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hq/3HYyRkCbvhZMiUVhiqT5f5nTiLqdGDscMANI/cPl+aNu6tgZVaR+6lWXvnbUocrAIoyH+oaquqyORSgKU4fjKCI2NXT9ENg8R55TuHJEAndGwNXwVnQuEGbQeRd820ob6XufORAcTNyzAn5h6d98jukR2kE08y9aeLC0te20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oI1ZyAW6; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oI1ZyAW6"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a814c54742so18905ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jan 2025 11:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737142992; x=1737747792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RR0pAit5l5JjU09a5qpEeKuUJzZFx80e1fusAeKDRK4=;
        b=oI1ZyAW6CEk2dihBLmmupp/XaXeOTI3+q46helKOc2AooNGEcFVrd0lYAT8KVBnQab
         7tZDlX6Lgc73T6DoMMrtdhl0zbEZ5B5qZe3bXwFoMVXefv+L1gsoPV0fJGIwceJT8xRu
         YfdwN+hrOTa+2DL/7wbSo6zMFUP192SrJGTAJS87qzFLr5u4vmmnR62P9H4p0KgdLJ9Z
         kZM+ocwbsit2N7Ou5lW0ZzvA0GesdO8KGuwtvCWtqi4YJBZ9GhuyYVASRK8tN/4JGVMJ
         +F2hNIm6tcla4uv2iUorYcu6eVAzmjXB1eIfBWZ41eVpkoE89lUojDFfkaAzIBoUIt5d
         +e5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737142992; x=1737747792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RR0pAit5l5JjU09a5qpEeKuUJzZFx80e1fusAeKDRK4=;
        b=OF6Kwx/bTcmnyXp5+NMWWGbLPdRlEaNGMLeIeXG5NsJXgCSUu5RlnReYCFNKRFA8fi
         MJ4REUskrtNNbZ+KSTB0epGbdyNk+tIi/QkZM2Mz7KfqytxPshEznDVpnsk1063P34jW
         VJK4b9RzDIgkxnjdG5wAUZLaDelCtGxH7TetfDInxv1pCTTR4wAOGs2GjWArplq6BuLb
         ONVcHZoZVA91aDJYg3fswnWuf5jBLOuGbVLHvKMlyihF05S0xbaQ+ha/yVv9nkHhjYTw
         6f6q6RXflZDuPtM9CvfFeMeRCDQ63eyKuAc9RYQdlD6eW99AnOidDAt3t8JQ/9P0Y8qi
         z0Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUWAcWclTtfBH4awv6DjxQOjXSdku6GYecszcmr+fSKGlW2EU1VeiI4rP8l/8sYd6d6sU+n0uz8sueFfmRYqclP@vger.kernel.org
X-Gm-Message-State: AOJu0Yyngb1q3d1QRythYc+8AwfQGgwjeMGsEc+8navJrMkGhT5GKyhq
	Hmg+OakoEMP5OsAF93f4Tsb31J74cT2dCHqjKEBZOD+1eI3CVQVN4Nk/CIwg2xBMPL1BM4AOryE
	e7ipcCak6yj3jzfvo5uJT4YPshyFpNZo0lfoq
X-Gm-Gg: ASbGncutk9ydrMZgBqzsElVUt1n8Q+psM2j5W4x+pkxKq4NoIiXCoNEBCRNZe8zAuc+
	vCKTNzYbhnFJvjwQ0Ujw6jfQuS7zOf2pt82mwH0U=
X-Google-Smtp-Source: AGHT+IF6EfUX1LvIboSfg2/1WdVKT3Y67XHpbSzKDBIysTJfcbiSfueWmKxGsSF7ZgI3xeW6fyUllhdQVGyLjCoJF/c=
X-Received: by 2002:a05:6e02:1c8d:b0:3a7:e616:8d2f with SMTP id
 e9e14a558f8ab-3cf7eb7f7fbmr184605ab.7.1737142992335; Fri, 17 Jan 2025
 11:43:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116064355.344245-1-irogers@google.com> <10984553-bf84-4bff-9129-4b31815e38d6@linux.intel.com>
 <3d87d244-a47b-4b70-90cd-710a38aa2431@linux.intel.com>
In-Reply-To: <3d87d244-a47b-4b70-90cd-710a38aa2431@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 17 Jan 2025 11:43:01 -0800
X-Gm-Features: AbW1kvZIb6Xk-ZiSH6qsxpwYM7paKXbFWZ45RmzO1zIY0WelB2w0ynb4OCEjMT4
Message-ID: <CAP-5=fWzoxFDqEvVzTWoj0RRTDCuHxmENAyWqshQu2NQZYoJZg@mail.gmail.com>
Subject: Re: [PATCH v2 00/23] Intel vendor events and TMA 5.01 metrics
To: "Liang, Kan" <kan.liang@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 11:10=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2025-01-17 11:03 a.m., Liang, Kan wrote:
> >
> >
> > On 2025-01-16 1:43 a.m., Ian Rogers wrote:
> >> Update the Intel vendor events to the latest.
> >> Update the metrics to TMA 5.01.
> >> Add Arrowlake and Clearwaterforest support.
> >> Add metrics for LNL and GNR.
> >> Address IIO uncore issue spotted on EMR, GRR, GNR, SPR and SRF.
> >>
> >> The perf json was generated using the script:
> >> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> >> with the generated json being in:
> >> https://github.com/intel/perfmon/tree/main/scripts/perf
> >>
> >> Thanks to Perry Taylor <perry.taylor@intel.com>, Caleb Biggers
> >> <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com> and
> >> Weilin Wang <weilin.wang@intel.com> for helping get this patch series
> >> together.
> >>
> >> v2: Fix hybrid and Co-authored-by tag issues reported by
> >>     Arnaldo. Updates to Lunarlake and Meteorlake events. Addition of
> >>     Clearwaterforest.
> >
> > Thanks Ian!
> >
> > Acked-by: Kan Liang <kan.liang@linux.intel.com>
> >
>
> Thanks Thomas to do more tests for the series.
>
> There is an issue for the FP_ARITH* related metrics on hybrid platforms.
> I have to take the acked-by back. Sorry for the noise.
>
> Here is the issue on ADL and ARL.
>
> $ sudo ./perf stat -M tma_info_inst_mix_iparith -a sleep 1
> Cannot resolve IDs for tma_info_inst_mix_iparith: INST_RETIRED.ANY /
> (FP_ARITH_INST_RETIRED.SCALAR + FP_ARITH_INST_RETIRED.VECTOR)
>
>
> The patch set add the tma_info_inst_mix_iparith for cpu_atom.
>
> +    {
> +        "BriefDescription": "Instructions per FP Arithmetic instruction
> (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR
> + FP_ARITH_INST_RETIRED.VECTOR)",
> +        "MetricGroup": "Flops;InsType;Inst_Metric",
> +        "MetricName": "tma_info_inst_mix_iparith",
> +        "MetricThreshold": "tma_info_inst_mix_iparith < 10",
> +        "PublicDescription": "Instructions per FP Arithmetic
> instruction (lower number means higher occurrence rate). Values < 1 are
> possible due to intentional FMA double counting. Approximated prior to BD=
W",
> +        "Unit": "cpu_atom"
> +    },
>
> However, the FP_ARITH_INST_RETIRED.SCALAR and
> FP_ARITH_INST_RETIRED.VECTOR event are only available for cpu_core.
>
> sudo ./perf stat -e FP_ARITH_INST_RETIRED.SCALAR -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>                  0      cpu_core/FP_ARITH_INST_RETIRED.SCALAR/
>
> There should be no such metric for cpu_atom.

Thanks Thomas and Kan!

The metric came from here:
https://github.com/intel/perfmon/blob/main/ADL/metrics/perf/alderlake_metri=
cs_goldencove_core_perf.json#L1243
and the event being in the cpu_core will explain why it passed the
sanity check that all events are in the event json.

I believe Caleb can address the issue. I think all the events need PMU
prefixes as happened previously here:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py#L153=
5

A few more kinks to resolve in the new TMA release process, thanks for
the testing!
Ian
