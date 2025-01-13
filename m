Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B008204583
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 12:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736771135; cv=none; b=HKeDGBbUBlwlsKs+btcfDtOr/fg66wZMWJfg09Vq50/SmvlhCV0zD3YBZrRDMsZNxaa3jqmmU6csEGyZhgZ3rxKyIjVwQwK+PpyDFRkV7jr20r7NtevhnCAELPHM34mapKqeT6v6eT6C5aDK/6sRSV/IF85lkC8rfs6fNIuuPwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736771135; c=relaxed/simple;
	bh=RAOJuSjayWPQDs7oILktjx1PyK6wjZkRcBOAt+KAVNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nppnha47Xti9njh0q4ZcHyLELp6wPoSiFyGTEiGbdHk7zYA5KXuPSVl4zLqU2GQ9Uj/S81vbCNGNcQvENApj90PfeAjzEDevmpI0bNZrNzmvbO4s9lLrV5tQI+Sg83D5kokZu1qyYK+lJT8Lyhej2+eS9db97tvurGvjZ0MZswk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cb6lvZ8W; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cb6lvZ8W"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53ffaaeeb76so4203480e87.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 04:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736771131; x=1737375931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QPA9rYWDLBwtTLVL+VDbhbWGbkRHM8aCAEpCy806+Ck=;
        b=Cb6lvZ8WDYjO9XxCH+zXFwVFlPJm3mTNf6afWAzywkYqOcg6sRYmOMwVIaYDKg0aZx
         EMw2IXN2uRCTRVtDQAOOIwPbCfqADr63s2qELcfl3TZ+q+NaYbiKLBs9Y8DVnoly+oBH
         FoKADxaEhkEf51bZDWFzCLllS4mmjgD8sJc5ItLPRlqsvI2kD+RHsTkbsEiPRB9GZzcf
         rHj3xc5g2Em8rIOj+FaV0fyfd0NzXusUc+AESi4bfdRguf3uep4AscboRQauVfnBOsx6
         hyU9HcGAo/G6bkvHxXWsW6gDp8fLNo3cH1CA2G2I/zXHDjiuqJH68knzECSxjLa6gRkN
         kBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736771131; x=1737375931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPA9rYWDLBwtTLVL+VDbhbWGbkRHM8aCAEpCy806+Ck=;
        b=SidC5UrBUhxKoilV7ML0nSauHTo2qOebdRW5K5OyKEnNMsmMEgFAQ6P49QpTAy68hG
         KLesDDMmWYRcP4W2Pr+j49zjr8NiOxAfrSHVSUWZutXRWqYiHOKG3J9axPqv/enib4vr
         LvbPr2oPlEsyQAHPTZccdm7PUHVmd4J2RsDB5QsdH6BpV/lt29x7KIj761B4Cg9+Otl1
         Y1Xn4BYJtehNcj+yHQJBfDgfgJWFxN8o5IEGocqws5EkmtRVF3Typ/78JsmO2XEoE7s+
         PpHzV6IdgyozgBHOrHlqLZu9PyS/ihbpeJ1MXm1p7qsSWXcozjWsvMhjpJLjv/b++oLX
         qfNg==
X-Gm-Message-State: AOJu0YwlUfrqotL0KoSXvGAsO+vI+5bctqUAYOekdO+9CrsM7NR8PHrA
	FPvgjtZFZHPeLyff5u+bqBk26KvXG9Km+p79Fsg6CLPUYhhItGj17UxB8VZFUuN6CM5qvi6cwxB
	AMciV3BZPLiwfYIM8MbemFrkiGsoxUkQKBRrP
X-Gm-Gg: ASbGnctncG6+sGWtrVCErhwZKNsKz/PfVEROaYgXLn/g4zztBOS63VZN6vw2F41ePs5
	O3fDlFmxl2kwREy7j3z6AW8hQh+k3cwvHkHFzm7XMdEx/77WBsE6ZWtfgk0DnuGdxBE0N
X-Google-Smtp-Source: AGHT+IGZaVHHutYOxtKP9DfSn3K+YpCdeKsMo6L4iXAQj4rLpkEjG1sK172u+3EPLy7pWBuVIHfjDo52McA4Q326QWo=
X-Received: by 2002:a05:6512:2209:b0:540:2542:6081 with SMTP id
 2adb3069b0e04-542845ba4fcmr6124473e87.23.1736771131095; Mon, 13 Jan 2025
 04:25:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108082435.268431-1-dvyukov@google.com> <CACT4Y+an1LSY15f9MS_vnbaaeeqMf+k4-Dqqfu-zwcUAHFNk=w@mail.gmail.com>
In-Reply-To: <CACT4Y+an1LSY15f9MS_vnbaaeeqMf+k4-Dqqfu-zwcUAHFNk=w@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 13 Jan 2025 13:25:19 +0100
X-Gm-Features: AbW1kvZPVEXHBr-vGmoj1HX6r7qJwOWH4e9gSBD-LeF92Ml7vC-9TZX4e-uJn2I
Message-ID: <CACT4Y+b4WYa9TSqKtDKTJNgXth1U30=KddutfSdp5gmXVOV_jA@mail.gmail.com>
Subject: Re: [PATCH] tools/perf: Add wall-clock and parallelism profiling
To: namhyung@kernel.org, irogers@google.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 at 09:34, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, 8 Jan 2025 at 09:24, Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > There are two notions of time: wall-clock time and CPU time.
> > For a single-threaded program, or a program running on a single-core
> > machine, these notions are the same. However, for a multi-threaded/
> > multi-process program running on a multi-core machine, these notions are
> > significantly different. Each second of wall-clock time we have
> > number-of-cores seconds of CPU time.
> >
> > Currently perf only allows to profile CPU time. Perf (and all other
> > existing profilers to the best of my knowledge) does not allow profile
> > wall-clock time.
> >
> > Optimizing CPU overhead is useful to improve 'throughput', while
> > optimizing wall-clock overhead is useful to improve 'latency'.
> > These profiles are complementary and are not interchangeable.
> > Examples of where wall-clock profile is needed:
> >  - optimzing build latency
> >  - optimizing server request latency
> >  - optimizing ML training/inference latency
> >  - optimizing running time of any command line program
> >
> > CPU profile is useless for these use cases at best (if a user understands
> > the difference), or misleading at worst (if a user tries to use a wrong
> > profile for a job).
> >
> > This patch adds wall-clock and parallelization profiling.
> > See the added documentation and flags descriptions for details.
> >
> > Brief outline of the implementation:
> >  - add context switch collection during record
> >  - calculate number of threads running on CPUs (parallelism level)
> >    during report
> >  - divide each sample weight by the parallelism level
> > This effectively models that we were taking 1 sample per unit of
> > wall-clock time.
> >
> > The feature is added on an equal footing with the existing CPU profiling
> > rather than a separate mode enabled with special flags. The reasoning is
> > that users may not understand the problem and the meaning of numbers they
> > are seeing in the first place, so won't even realize that they may need
> > to be looking for some different profiling mode. When they are presented
> > with 2 sets of different numbers, they should start asking questions.
>
> Hi folks,
>
> Am I missing something and this is possible/known already?
>
> I understand this is a large change, and I am open to comments.
> I've also uploaded it to gerrit if you prefer to review there:
> https://linux-review.git.corp.google.com/c/linux/kernel/git/torvalds/linux/+/25608
>
> You may also checkout that branch and try it locally. It works on older kernels.
>
> What of this is testable within the current testing framework?
> Also how do I run tests? I failed to figure it out.
>
> Btw, the profile example in the docs is from a real kernel build on my machine.
> You can see how misleading the current profile is wrt latency.
>
> Or you can see what takes time in the perf make itself.
> (despite -j128, 73% of time was spent with 1 running thread,
> only a few percent of time was spent with high parallelism).
>
>   Wallclock  Overhead           Parallelism / Command
> -    73.64%     6.96%           1
>    +    28.53%     2.70%           cc1
>    +    17.93%     1.69%           python3
>    +    10.79%     1.02%           ld
> -     7.49%     1.42%           2
>    +     4.26%     0.81%           cc1
>    +     0.72%     0.14%           ld
>    +     0.68%     0.13%           cc1plus
> ...
> -     1.33%    15.74%           125
>    +     1.23%    14.50%           cc1
>    +     0.03%     0.33%           gcc
>    +     0.03%     0.32%           sh


> [PATCH] tools/perf: Add wall-clock and parallelism profiling

Note to myself: need to change the subject to "perf report:".
