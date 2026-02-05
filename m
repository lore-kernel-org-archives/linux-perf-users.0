Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49447423A6C
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2026 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770311269; cv=pass; b=Oz9lm9p3ommCvOGfEo6H21Y5wWtyWPzZrx3WkbJDGDHj0vAG/ehSFLI//V8tWPfZ0K0WtI5xGj2LoPQsXUCUTbG/w3Zi5SM0Zwi290fC7LWCJbuAC6LRuUEy3EVTVVKhmNeXS9UUGyqJz3uJLLdRbo6/ugLT5mEgr2Zhgt49wIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770311269; c=relaxed/simple;
	bh=wJUjVosdPoaexMQWFbWzBOvZc65QoaGkPE9wKPHfPAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pa2C914Wrj0p9SpYc25qt3rFQBdGnHXN4+CxFOlSR58vGpzQrmMp1zSyE07NRCF8nzkL+tuec+39RuwO4kVKjUGTbtjc6VI8il0pOJ8pguM3SSBaxJT4nzIjubGgPmVdnFVs81835IJfkE654x6gCbb23S5XRRNXqn6udL71ISc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t6o9Qrmk; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t6o9Qrmk"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a885af8ee7so90405ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2026 09:07:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770311268; cv=none;
        d=google.com; s=arc-20240605;
        b=XXNS5oQTTMNJp61P+Gl9kKPCs70WAexVCcen5P3k939jhUxpAia7qllV8cEVurZJGI
         Vl0wRqkmpOVqzNxBck3EBAZTxveQ24Gf/2aJPwUNsgu2sbRaKzkt5KrTvyhSaoMAlnME
         fLhc1Jcl9iB8HiX3v29VhW5+A8i97OFC6DU8sRpvb9rtu9VH71rThnJROHT5hybUpJYo
         myuyx70fBSKjI+IWPVH0cXPPiEwTPJxDSvCnAZcNcwBf57T5uszIvhgIlIoPRAifFWun
         ZlslWDxNA3oqyObWPEyY/Oe3siKGVftJOHJBWVdDCg7ExCH9nl4wRw//pJNLcIZRFaDW
         uTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R5c24g4KP4Wt1/ocPE7u7UxpNOgBwfFwhbdZbQP7sEw=;
        fh=YhRQtDhdg7obqJeWa8x0cHQ3SkP44RPMS4W/DnKdpx0=;
        b=iS3oZSEBQr8zeM+1GkkHrE2xSejtK4Q9yfZd3Fw/gNxURYeUMATgQovfNSzL1hwgWJ
         vclmQSPStWjZTfawFPJGB71Bhnk/anrPUB2rbKx1TyUoMXj58CYPrpdlLeXDAkGqBZmm
         uwWqMm7GDMySsf7oLT2u3S0CvIoI/vfM44p2eoPkDBsndSoY6e7kYNxOQw1B39AiB7Qi
         iMqiJFslwGXp+0hx1NPJlQdIgUlWz8pyH1pbGgwFmkT1qK1WotgmjkTfRD5D/SplQsPt
         SikukJ8RXV6sKcgMR/mhEY7uJytRHKLaSdy954T3rHBw3MB5c0fccbNBOU0KwFhA0TIX
         Sv5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770311268; x=1770916068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5c24g4KP4Wt1/ocPE7u7UxpNOgBwfFwhbdZbQP7sEw=;
        b=t6o9QrmkuCEd4wL23K87+Xm9q8Gs69F7qUcQVKtwzCweMsQjGSpvMSKROg14qX5fV7
         lzfSYHpKHKV7ESGgGatsnq2oDeX36gkTcbn+qsTVrEpa+LWXnZ5I4u+xiqnwQidxwAn2
         xyMcTGlpNwfZz5h1wnc48pbUKz0Md4hZWg0E4BPYBmdL/tEcpXFIJU4xiXuFrFsyBUQQ
         stJGc3vUdJBIsjJgI6ruPOuyhKPnsdhZ78U7gdwgh3YxlI2vT8WTYB6IbPGR47F6cQ/S
         fxwnxgZRqpi1+EszSCzT0FZaAwEL1u2ZzLyFgs/CKVF4r2DQJjN1Ah1vaj4+n3NApBi3
         GhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770311268; x=1770916068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R5c24g4KP4Wt1/ocPE7u7UxpNOgBwfFwhbdZbQP7sEw=;
        b=wrj2KGooy1iKxU4RmxjVU4H+pNpD3nCjseJEjDxLdUXR52dH0CEEyQgSC4magzlDCh
         KZf2A3+EnlHrMTkv+OeGAkuKjh9cX6esy7rjNOhWcWMMvhEbA7DIukiemgTO6raMFZ+o
         KJx1ClgdPLgflW+M9RI+IBmUdsIa+nzV/wJ3MJD/4C1aYq8V4JrIA0qGpmVkh6MKka+L
         /NtEZmiTJo20QkSCnAl/eSla2/gam9jF7vXXuohjJvgRPyhY9makNhEXdztHV1t4VCC6
         bIK5yOwa0fqsFacaTkou8BbIHJUVLYhZftLPXYf/HXfRR9HDlG3Jqp5DeTo7VJleoI7Q
         nmSA==
X-Forwarded-Encrypted: i=1; AJvYcCXyNNZ1qE68kFL5OVnuUrVMfZOdWckpK9ouLjh9KIAUBqr+LjmlgtEU+v9lER/1Ok7Afyww9yd4TQWWk5/5T16m@vger.kernel.org
X-Gm-Message-State: AOJu0YyH7vxzlXgmn/dP4IHQlmn62DbKI40PKuZVgLQ3Os9vXYv/exV8
	kaqcw+Bh/ZoQ94y8IU/Wcl37Giyk1YvOpb/fKlWtyi0YaUnvaMERfzHwfUEDpLHx2H2hELxUwd2
	tNAoqSQrKcoJ55BZTpucoRBhv7ydAZiwjHNnqvx7yOX1y3wH67bTOnK0trFY=
X-Gm-Gg: AZuq6aIBHntAjv4EiHcbnkc7GceB4r9YBnKusYjuhl4DWWKcdWBNHvN3UL3FwCqV/n/
	/TW53ac+9x5wSVzuz21WixBBiUapUj13soBdi8LiCGRIz0dLBtqjmc/lp56Ne2GNA1qCfIbUdDo
	mZsmYnvNngTozoYs1aVXxFVTKrbJdWQq+08Qsxz1FjvZP97TsnpOY9qNHtN56FzqJVTTe13J8xt
	8bOIkmdUNmcCbRfIzw3cxGshcyhUmYlb4OJoFmeroxx2c/Ca+Zdbg3vLJMgo7S1pEJz/lScPq9I
	TW2letsx9s4WovJiJqNkMhkLYA==
X-Received: by 2002:a17:903:2ac7:b0:2a8:ffed:4663 with SMTP id
 d9443c01a7336-2a94193ed57mr3591145ad.12.1770311267891; Thu, 05 Feb 2026
 09:07:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204-perf_improve_log_for_open_event_failures-v1-1-150245792810@arm.com>
 <CAP-5=fUQxuVK+6GObmqVdBmTLzu06FyNaLdLsW6tcgNv5=7gxw@mail.gmail.com> <20260205103036.GF3481290@e132581.arm.com>
In-Reply-To: <20260205103036.GF3481290@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 5 Feb 2026 09:07:35 -0800
X-Gm-Features: AZwV_QjD8Yd0BT18ZhnL_wg0tYTGJHiAsM_HZIAx4m0yXzZkE74awCvETKZ0ojw
Message-ID: <CAP-5=fUwDRxEyEL5A44wAr2RwOhRN6x9ePntpTzWGThyHqFQiw@mail.gmail.com>
Subject: Re: [PATCH] perf record: Make logs more readable for event open failures
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 2:30=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On Wed, Feb 04, 2026 at 09:29:14AM -0800, Ian Rogers wrote:
>
> [...]
>
> > > This commit restores evsel__open_strerror() to generate a readable er=
ror
> > > message and print it out:
>
> > Lgtm and sorry for making things worse - I believe it was motivated by
> > trying to avoid spammy warnings.
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks for review, Ian.
>
> Just wander if we can go a bit further.  My understanding is that now we =
only
> handle the special case of duplicate "cycles" naming on Arm/Arm64, it is
> not necessarily to tolerate other failure cases.
>
> So could we report errors and directly bail out for other PMU event failu=
re?
> This somehow reverts to old neat log rather the duplicated error logs for
> each events.  Something like:
>
> ---8<---
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 2584d0d8bc82..ca7d6805840a 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1404,10 +1404,21 @@ static int record__open(struct record *rec)
>                         }
>  #endif
>                         if (report_error || verbose > 0) {
> +                               evsel__open_strerror(pos, &opts->target, =
errno, msg, sizeof(msg));
>                                 ui__error("Failure to open event '%s' on =
PMU '%s' which will be "
>                                           "removed.\n%s\n",
>                                           evsel__name(pos), evsel__pmu_na=
me(pos), msg);
> +
> +                               /*
> +                                * Only tolerate Arm cycle failures and b=
ail out
> +                                * on any other event failures.
> +                                */
> +                               if (report_error) {
> +                                       rc =3D -errno;
> +                                       goto out;
> +                               }
>                         }
>
>
> If this is okay for you, I can send a updated patch.

My main concern is to not have a code path for ARM that we can't test
on x86. Currently opening an uncore event with a core event on x86
exercises same the cycles event problem as on ARM. The logic I worry
about bit rotting is the evlist clean up, etc:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/builtin-record.c?h=3Dperf-tools-next#n1422
If your concern is log spam then we could by default make report_error
true only when no other errors have been reported, but then we may go
on to do the record and be missing removed events that weren't warned
about unless you are in verbose mode.
I think in your patch you'd need to save the errno value to avoid it
being clobbered.

Thanks,
Ian

> Thanks,
> Leo
