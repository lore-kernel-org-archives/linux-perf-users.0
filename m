Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F57C469843
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 17:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344740; cv=pass; b=Mi7Owfv00Xc6BGCAYLV1mWam8jC3KxRh8XVCBBvathBfOSTCReuontnLfYsgpeOqfoJ/tfQ6x4XT9dz3Jzcj5miwyS9aAYOTISOETPpXsKKHrWLG1fQwQStZR0FX4ufIAccBDHbt4NYc+ZxWo8uqKrFxBpjCGuFPyMPa8hd0Tk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344740; c=relaxed/simple;
	bh=sUMqvC5AxnRhcFPpF5VCR3EA6/ATmrvnssOKfCWAu3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAktnP1pvDLLzRqthyXXgrnm2HmDqOyz1iBwg5eUepJ6M5kuXy2o91dRSFE6vPCXdHoPJcMZ1WYiRL/QfA6dXMa0umX4gEKTEq8BNrOvsKbuDOnCt2Nxw6aetI8obGi9YyGswDlcq+2v08wqOUQ6ceLeLrZkYwhCs33Wn1l8uuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=afjEFFjo; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="afjEFFjo"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso1042794a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 10:05:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785344739; cv=none;
        d=google.com; s=arc-20260327;
        b=Og9Lo1qvv9XHjmNlhoO8xsZWtA7C7yOUdnG/q7QXMh9MCr0dgm8p81JDeeSvz7ANti
         M1uiwzbBb67zmf43DA0bdlzDddlve6vhVp9dEezz/Cb26o9egLrJdR5L6WRfDfhaPZ7T
         YGcBFIXoh4dmLT3W1hOuGPzmOXeUpAC4Rk0GeHSncrw6PXxL2Z+nr7DLDh2F9BwlRuGW
         2zkhml5wT68EFZ8I3/Ox3QfnC/31g3kSejBtbL1vepxZVHMIZTJkrYaOQhUNcXNrrGoZ
         pnd4nvYt1lNe1Vb+XHxz7GfGKfJ8L4PpFKBqlt6a9JCVrurN2jexKD33/X7GG+hmYuAQ
         Z/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/2VxnQOZXSN9pFBIZmUaMPaaSxxN8CmWTGgqGJT6EMo=;
        fh=RwcWUXCRqesV050RpG7MV9GhJ84LoBA+Vi6G+SArJbw=;
        b=mquQ6ZF3qTb5E4dHRf40Hozik4PX4OQCAuN4rDUpNVd7UosldosFrNAdSFxnV1yuj9
         j45FasrVXdqE0RLQWDYuxVC0023x4jwfPnlRlqKhX/40mPDPUXJVigTKXPxYv4Ikijxq
         49nKBYOTsOLYRvwwwq6O7gVT0s6qC8L17qMI2E4Mqtgc98A1AL2AZbMbHJnMHC09LVWv
         vg4dopL4rOMCxgwyAIlYLXhhk29SaXVwSAPDzXLY1Lf9xGWthAXjFnWO6+py200IyY1/
         VG8vqveqcNs7FRMhnQN/VIc6MAtvcGObnxH1p9ocVbUI8A9GB7JhqOMkyS0Qf4/RowNT
         fR4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785344739; x=1785949539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/2VxnQOZXSN9pFBIZmUaMPaaSxxN8CmWTGgqGJT6EMo=;
        b=afjEFFjokBzB3fWTYFwqzSHQCCZjvsw5RL1yM5rDI0IgpN78UHg8bLxe1ieg0urF7F
         yEb6pUHRFNMzgsP4DNvD3IWAkQ62NSznKjy8uiWFKUkgqJz7y1mqQAPYjTIsZk6mrzSg
         bXk2R3iUhj2HMgajoVUA78HAjw0m6jqL4fpFX7vhsvuvZqrm4scF7ZUJZRQWVWAXsBBN
         YgBxx8EEpWqLPhHRX5MQtiGXUZORkU6IEuo4+C7mPxUj+m1TzqkQjkZsasH8z03uD2Sk
         wUjYt3FmazsNGrAF9m5ldXWjCMKKgPygPWzZHww0ZHqCp5lgNF5KJZFJwEkOtuxouk+q
         bAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785344739; x=1785949539;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/2VxnQOZXSN9pFBIZmUaMPaaSxxN8CmWTGgqGJT6EMo=;
        b=nWfgSKXhPxyToO6TeXwiTmhkugQkObuROaLr39hENjZDT1OeFp/f2vxSa5ji7RyX9K
         KIHX2xWwelUW8NDmhXxM96F7WuKbj3vukaWe8FF/5WKS7BI5+EXpUYVhZjKHfo5/aenf
         igSAYUW6Fs20JVfLGByfgbGP0lnCW3mYN/UAomAQ1E5TcpQiwok8lid0Y5TIRkcnp8Xn
         FidPKckHVIcZ823CrFOZvifFyldIIuCqNKh3/oShlBc6Goyh/PGBtCraE08ZjL8V4fdz
         nvLWJeomOIFJBJQCbbDJS8fB79FCqE1vjWTdm+tbigMNgdqlxrAO+GsGEVFa09meRer8
         ce/Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr3/kn6zz+gwfvhfcvL+IM2fXJifX3+Uxr1tqtycTGrMhnbpoznOuVzsILW+ync5VJYIS5mVWe9zo2nqZjju+sI@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp3lpKh2KgyWLk9e/+vwhKQ02ob9BMkBia2xD5LNLC5DX46a0J
	a+1NaMZlxYHOJWGm9I/JE3CEYrFz8Z3/+bfoipQlj53DWMkh2EkW7imav76yeLjQT259A7kogXp
	2CRPKW8IV25oaBkqJMPNr6hxTQSYKGSVXUdMNqb0O2gtRcIMPvVSbnhm49aI=
X-Gm-Gg: AR+sD10X1pzV9PMnDywHFwlA26Vm3r7xpcBK78eAiaACG4lQPTVGNSrobrEC68bti/P
	SH8LKuwiOPvPscBuyT0XGUKQoDyXLVKO1wZHxm7DebuxCAb+6f2xPA5gxdzbUwFd9jnwy7Zhnv9
	mDn1qh/y7GRAIfpJO8LHFFpW8ghLv2xfLMwLGbljkSORm2tke6LGFsh4lCGVW2GCHvVPPEizoYr
	x6DM12j2iUJBCcCF6oJCrUSpfpwceUN3UONVhZwRpnhs/PJ9o3gBcx+WUnI0oCR0JO8gijeV5Pw
	8rIUH9WSjOyVE9lsTAVcWeZsZHvEXVhwRRoRHQ6G2u+jPaG5W4zXyWJFgIztEi395tm7yOLltzs
	=
X-Received: by 2002:a17:90b:5864:b0:38e:c7b0:84ad with SMTP id
 98e67ed59e1d1-38f6a1becc7mr7396319a91.0.1785344737925; Wed, 29 Jul 2026
 10:05:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715203055.2981363-1-ctshao@google.com> <CAP-5=fWByxhcT0RY_NgXeFADEg4zUiWBbBrEHXMLV3pjqAQ97Q@mail.gmail.com>
 <amGusmHqiinoxh8T@google.com>
In-Reply-To: <amGusmHqiinoxh8T@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Wed, 29 Jul 2026 10:05:01 -0700
X-Gm-Features: AUfX_mw-2Jcdp3xvt0c1v9S_CpT8JRENxWqNcJJZiWqOF23FNcPtLDRx6VcVoAI
Message-ID: <CAJpZYjUBAFk6wkHST67dJuh-gkO+S6siuZucXf_0nh9bdMupsw@mail.gmail.com>
Subject: Re: [PATCH v2] perf stat: Include PMU name and split uncore events
 per PMU in metric-only JSON output
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 11:03=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Wed, Jul 15, 2026 at 08:15:46PM -0700, Ian Rogers wrote:
> > On Wed, Jul 15, 2026 at 1:30=E2=80=AFPM Chun-Tse Shao <ctshao@google.co=
m> wrote:
> > >
> > > When running `perf stat` with `-A` (--no-aggr) and `--metric-only` in
> > > JSON output mode (`-j`), `perf stat` evaluates metric expressions
> > > across all matching PMUs (including uncore PMUs like `uncore_iio_0`,
> > > `uncore_iio_1`, etc.).
> > >
> > > However, `perf stat` previously formatted JSON output by printing onl=
y
> > > "cpu" : "<id>" and grouping all metric values on a single line per CP=
U
> > > without identifying which PMU instance evaluated each metric. As a
> > > result, when an uncore event spans multiple PMU boxes, `perf stat`
> > > printed repeated, ambiguous metric keys without PMU names.
> > >
> > > Fix this by:
> > > 1. Including "pmu" : "<pmu_name>" in print_aggr_id_json when evsel->p=
mu
> > >    is a non-core or hybrid PMU in AGGR_NONE mode (-A).
> > > 2. Starting a new JSON metric line in AGGR_NONE mode (-A) whenever th=
e
> > >    underlying PMU instance changes across PMU events.
> > > 3. Updating perf_json_output_lint.py to recognize the new "pmu" key i=
n
> > >    the JSON test suite.
> > >
> > > Example output:
> > >   $ perf stat -M iio_bandwidth_read -a -A --metric-only -j -I 1000
> > >   {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_0", "MB=
/s  iio_bandwidth_read" : "0.0"}
> > >   {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_1", "MB=
/s  iio_bandwidth_read" : "0.1"}
> > >   {"interval" : 1.000314908, "cpu" : "0", "pmu" : "uncore_iio_11", "M=
B/s  iio_bandwidth_read" : "0.0"}
> > >   ...
> > >   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_0", "M=
B/s  iio_bandwidth_read" : "0.0"}
> > >   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_1", "M=
B/s  iio_bandwidth_read" : "0.0"}
> > >   {"interval" : 1.000314908, "cpu" : "56", "pmu" : "uncore_iio_11", "=
MB/s  iio_bandwidth_read" : "0.0"}
> > >
> > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > > Assisted-by: Gemini:gemini-3.1-pro-preview
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
> >
> > Nit: It may be nice to include the before output (i.e., without the
> > PMU showing that differentiation isn't possible) in the commit
> > message.
>
> Hi CT, can you please update the commit message?  It'd be very helpful
> for others to understand the problem.
>
> Thanks,
> Namhyung
>

Thanks for your feedback, please check the v3 patch:
lore.kernel.org/20260729170416.41904-1-ctshao@google.com
