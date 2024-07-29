Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C35154C19
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264788; cv=none; b=DqNNLRoRP1QMfDCZkeYeTYem97NUoVQLBLzycDsGd9MO6oqtymHr9i1hJeqfA3Pc5H9/X+ZcERwgskNaKVcomC3l9MIhKWNeJT1eu5Chj7rBTF39+t3+7R+66zmyFC4U9pK0Lt6rCixn7O/4hTcutp+oiOIfa2X6EfDDA6XhkN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264788; c=relaxed/simple;
	bh=1jqQctM2a+S+lyJbT7V/HPsKNox1qfH+F+rAd8K6hZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taiSI20Nx2wISZO68UNgqnuHAEEJ7p65z/FJzjLvPqzoGpZFlkQN/grK/gr+mzO31crcMUgIf68RALjbLRj9ZzHbOh56rZRA1Gp1HKQu04qNyICTN+PRkBv5O9q1ITJLfg3U/AnekANgc21YKDavX5vCty1598ormnjKp5ZSakw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uEtwpnbZ; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uEtwpnbZ"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3993fddea13so285495ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 07:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722264786; x=1722869586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9K9fhpcFFyliwAIwtK/bwTIbpmSXLXKLb0zgxn5arM=;
        b=uEtwpnbZeXyftztXESR2gTXxplX6ZXHm3qhrKbG2zMeHSUilr6gzTlfZ6nWmVFrN5f
         JOHFTs9tvM2PIE46qKLxFQtQxaCrbLIJxgpOJ9R/dyMY80MOL1QrvMa3j+6wC7rO4Pxx
         xlf3An8kXw8mUB1xcGRpTGZ7CE0TMjr20g30ObvS8r7Wx/farBNrnTLIpS5Vm6vJOLru
         8fGS/oYmSjKIOZzDYLjhrqbBhp+2wwN6UdD0okZhqbL9qBbw6OAZTqGQ7ApYqgNqCTlF
         ytMeO2vWS9kUOBixmjwwTmfKF1XoHmXVm6x2HREDn2V7fKe54Qm+EcYMKjReSgNiCHXm
         QxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722264786; x=1722869586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9K9fhpcFFyliwAIwtK/bwTIbpmSXLXKLb0zgxn5arM=;
        b=N4Wc3Rm/xPmBxXw8A6+AMzAIJEr1WeMn8B4JGi1UFL4xSjCnqL7YLfGCcsSraXzuiw
         s86vHcFSa/NtpiUNl2aoE9uBLN4205IyxsNpRwHxui3c9qBL9WoGIJa7Sbkb5mzviaEq
         rLFwzeNe3qHSXvAVcAOcsGnZXZ+u8fniYV9eKwX1VSgM7swcgwhLTnRJziyVeaSieR3l
         +WaDZolhBBnt2OHdH8Wk33857wnuA22qWQWXA+MbvxH7607ZEeyEP9/rXx09SDnI+qgd
         JFQ8M0lgtdcw+BLjegyP8obzO9CIyU8Cm8niSR4BwV+1ob4cwEJHA422cRrbRvbjkxr9
         Iltw==
X-Forwarded-Encrypted: i=1; AJvYcCXma+VF/WW5js9gwCCbD+OHCLNDFIeLCEhxlFAFKCpxdtlX5DUHOVEtd5T56CQwu/SBNGAc/MSHyp7JXXidWwCxa5hiLOuMuIosF1urri0D9g==
X-Gm-Message-State: AOJu0YzDyvddR5kggZlEfIld4BVQLX8+4oiQQLWTSy0qsIWRNCFhyVVu
	lan6xGnTX4DYmT4+xRC3mfViN1XSyfgbp5eEiuJl0FwZYcHLSKIybObX3ELQRd+gX3stsGndgk3
	BDwLekFkkMd3Tp24yU0nGCnUsk+96ytUMeY+a
X-Google-Smtp-Source: AGHT+IFHH53OjdvvY6abM1KuykhTshVGRqx85vpCme4XgZS/mGrELULyrbRiwMenTyQvf9NV/0FWpW2As9XJg0+07jY=
X-Received: by 2002:a92:c56f:0:b0:377:15c7:1aa0 with SMTP id
 e9e14a558f8ab-39b038c4e4bmr1725ab.25.1722264785831; Mon, 29 Jul 2024 07:53:05
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727175919.1041468-1-linux@treblig.org>
In-Reply-To: <20240727175919.1041468-1-linux@treblig.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 29 Jul 2024 07:52:53 -0700
Message-ID: <CAP-5=fW+VbDaFV+YQCMMKYzrraMLLuVqb=BChL0o=-D5Y=4N_w@mail.gmail.com>
Subject: Re: [PATCH] perf test pmu: Remove unused test_pmus
To: linux@treblig.org
Cc: kan.liang@linux.intel.com, acme@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 27, 2024 at 10:59=E2=80=AFAM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> Commit aa1551f299ba ("perf test pmu: Refactor format test and exposed
> test APIs") added the 'test_pmus' list, but didn't use it.
> (It seems to put them on the other_pmus list?)
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Strange that the compiler doesn't warn about unused stuff like this,
we get unused variables within a function and unused static
functions...

Reviewed-by: Ian Rogers <irogers@google.com>

Possibly:
Fixes: aa1551f299ba ("perf test pmu: Refactor format test and exposed
test APIs")

Thanks,
Ian

> ---
>  tools/perf/tests/pmu.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
> index 40132655ccd1..0b2f04a55d7b 100644
> --- a/tools/perf/tests/pmu.c
> +++ b/tools/perf/tests/pmu.c
> @@ -18,9 +18,6 @@
>  #include <sys/stat.h>
>  #include <sys/types.h>
>
> -/* Fake PMUs created in temp directory. */
> -static LIST_HEAD(test_pmus);
> -
>  /* Cleanup test PMU directory. */
>  static int test_pmu_put(const char *dir, struct perf_pmu *pmu)
>  {
> --
> 2.45.2
>
