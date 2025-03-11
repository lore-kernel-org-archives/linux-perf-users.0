Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FA62B9CD
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 00:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741654202; cv=none; b=glcTFJWwl//WlrUmsQ8wLKm/KXM621Iqhe9eazYoCkK90mzK0PU8lg/EQ32AGOUtsAmMxbCwRc8Uw1g/6gS7rlw+l4RlG6pZjxMqtzT97NXjUEa2VeTF4Lv8VyUR2jzD/XZv2bkZbXf7XjZwwbliLzmRZTUGwXOjgUTMsy8rmiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741654202; c=relaxed/simple;
	bh=WtPsxI1mF4Fib2DjqG5aZoiAI/3+o8KEkEiK2O4adpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKnOnvTohjmg1FRHNRTfw+jCqY1ItpkKjo1hfJXoxMwIT6HbMgKHdMOBKRtfJnoM82uFQT3XWS9wgkLvvY80Oaez+HqcGAHc1JulID5W5H6fEkYQN8FKJx2D2LJgicn4lR9JYmK+sIC/SPxhQ4KGfKwRg7igf7t7BjtyLNMqbGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=npmzZEd/; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="npmzZEd/"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-225489a0ae6so45165ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Mar 2025 17:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741654200; x=1742259000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UG8l3rw6w9CG+I5rCOCbRTQtWDKiaYPahM4qkw1drI=;
        b=npmzZEd/Dx18md7aAbJWfRUXMtI2YnsGbFy/brZ3M8yS3Kxz7go38yCEQF1lvi+lJd
         Q0Ky6XFEuzbEwOf1YGNB0BEjFX2QOMtBaF2OTmEmZ4ZpIwXHoCZ9Q5Ymr966DQAB1z5T
         xq4aOTt4+lnOEP+/M3I+r/rgz6ptQ8ro2prlIjJnT6Qn/ZUHd7j2xrUro5ebknSDGOOP
         FukWxjOiog+Np5S8Ae3j8lu53OJ1Sg5D4kDHFQR4BgYJBABbpVJYNwP+xSOmJgQTnvdg
         odMZoDvpuzAUvsiae4VJj2QnUt20N2RtcMXyUbvpKTOPO+DIVp5E23wZMn829dmQalFV
         yW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741654200; x=1742259000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UG8l3rw6w9CG+I5rCOCbRTQtWDKiaYPahM4qkw1drI=;
        b=btRANXrL4GA6reWs+1HEEesSKsE1jnxNlz0SzdhjO7fUVwoFoB0l850ESujI6EcmFq
         KaOExnpAgvtPRLlpLQ7zZHI+S8f3otKYBRg+HPNlQOWcS76hla57uPt+U7pDgqsrIPKS
         X9NVEXuoTftyPVwO78Yx+tIEW8bhYj0kLF3qCmmpVzW0MD+RugCTy34PAQDfsN3xz/l1
         AU1n7rkuQt5sqi3cS9eyzUSDVq2V6mT9ZuEyWVMf6cUGDIjuU6MWzTQNa1tJIS0Aseqc
         Pl2caJMBuYJz/92QFaqLCsdIUrY9QpgE6iHkI/3fBmpOUINAh4avbO1PigVh6eEEkt7K
         1/tw==
X-Forwarded-Encrypted: i=1; AJvYcCUUFLEwErNaHnuA4TNf8NsWQgeQQqFQ3Pjs/g5wgHF8dDV0I2PpixFMRn6R4JN7kVaj3YdHV+5YrHsOVLuP3FeI@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXTD1ZCA7C3LTg/9rrwO1zDX7lopq0XzVby3KEMTsg2f4pPnE
	rh62TLNbjtbHaZjr/AihuqZmnPHvDW8Wkxa+htSi5sHXabc2V1WBeL1TnK205QjiFxNI2B/FKZc
	h1nfl8Yc/Q189KjBMuOqJ8iC9eTZ1YjxHsmME
X-Gm-Gg: ASbGncvTrXPPqNq+PyJFQ1F8R3N+q2c5Sh7Ply46bQDIixJ0aOzEggj9hRpxOt7DMZZ
	Avl/w94T1FE9WVn4wEbVXZz2MkkOOz1aks9uBdNkxXmM4naSifMkbVEynpnakXQXJXDSGHKTZb3
	lkZ9FvhVZydwUSbcNziBlCY6O4TL0=
X-Google-Smtp-Source: AGHT+IGUkygBX681xnbfirGOTjQluV+0g5jegoBPrwfvr9MndofFJ0GXNxXRPycRCA3k/vgWPNtPC+irlc8ALtVcmqk=
X-Received: by 2002:a17:902:e801:b0:215:f0c6:4dbf with SMTP id
 d9443c01a7336-225416231b2mr6556665ad.14.1741654200354; Mon, 10 Mar 2025
 17:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311000416.817631-1-namhyung@kernel.org>
In-Reply-To: <20250311000416.817631-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 10 Mar 2025 17:49:48 -0700
X-Gm-Features: AQ5f1Jq8mMPoQKD-wR3efNTTSPJME4zCkdfDivNpUiKdeNqml3I0fbO2xhFEuO0
Message-ID: <CAP-5=fWSU8m1eae=5GFTpVTz1CPtwv=eDmivT1v14VjT40SptA@mail.gmail.com>
Subject: Re: [PATCH] perf report: Fix a memory leak for perf_env on AMD
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 5:04=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The env.pmu_mapping can be leaked when it reads data from a pipe on AMD.
> For a pipe data, it reads the header data including pmu_mapping from
> PERF_RECORD_HEADER_FEATURE runtime.  But it's already set in:
>
>   perf_session__new()
>     __perf_session__new()
>       evlist__init_trace_event_sample_raw()
>         evlist__has_amd_ibs()
>           perf_env__nr_pmu_mappings()
>
> Then it'll overwrite that when it processes the HEADER_FEATURE record.
> Here's a report from address sanitizer.
>
>   Direct leak of 2689 byte(s) in 1 object(s) allocated from:
>     #0 0x7fed8f814596 in realloc ../../../../src/libsanitizer/lsan/lsan_i=
nterceptors.cpp:98
>     #1 0x5595a7d416b1 in strbuf_grow util/strbuf.c:64
>     #2 0x5595a7d414ef in strbuf_init util/strbuf.c:25
>     #3 0x5595a7d0f4b7 in perf_env__read_pmu_mappings util/env.c:362
>     #4 0x5595a7d12ab7 in perf_env__nr_pmu_mappings util/env.c:517
>     #5 0x5595a7d89d2f in evlist__has_amd_ibs util/amd-sample-raw.c:315
>     #6 0x5595a7d87fb2 in evlist__init_trace_event_sample_raw util/sample-=
raw.c:23
>     #7 0x5595a7d7f893 in __perf_session__new util/session.c:179
>     #8 0x5595a7b79572 in perf_session__new util/session.h:115
>     #9 0x5595a7b7e9dc in cmd_report builtin-report.c:1603
>     #10 0x5595a7c019eb in run_builtin perf.c:351
>     #11 0x5595a7c01c92 in handle_internal_command perf.c:404
>     #12 0x5595a7c01deb in run_argv perf.c:448
>     #13 0x5595a7c02134 in main perf.c:556
>     #14 0x7fed85833d67 in __libc_start_call_main ../sysdeps/nptl/libc_sta=
rt_call_main.h:58
>
> Let's free the existing pmu_mapping data if any.

Can we simplify `evlist__has_amd_ibs` as there seems no reason to be
creating/parsing strings. For example:
```
bool evlist__has_amd_ibs(struct evlist *evlist)
{
   return perf_pmus__find("ibs_op") !=3D NULL ||
perf_pmus__find("ibs_fetch") !=3D NULL;
}
```

Similarly the variables `ibs_fetch_type` and `ibs_op_type` can be
found with `perf_pmus__find("ibs_op")->type` and
`perf_pmus__find("ibs_op")->type` respectively. It probably makes more
sense to just cache access to the PMUs rather than do the finds all
the time.

I wonder there is a problem with the pmus alternative that currently
the pmus are global and not part of say the session, not loaded from
the perf.data file, etc. So use on a different machine than the
recording could be broken by what I suggest. I guess then, just
throwing in the free is simplest.

Thanks,
Ian



> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/header.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 1900965f87527948..e3cdc3b7b4ab2409 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2770,6 +2770,8 @@ static int process_pmu_mappings(struct feat_fd *ff,=
 void *data __maybe_unused)
>                 free(name);
>                 pmu_num--;
>         }
> +       /* AMD may set it by evlist__has_amd_ibs() from perf_session__new=
() */
> +       free(ff->ph->env.pmu_mappings);
>         ff->ph->env.pmu_mappings =3D strbuf_detach(&sb, NULL);
>         return 0;
>
> --
> 2.49.0.rc0.332.g42c0ae87b1-goog
>
