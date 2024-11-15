Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A7818871E
	for <linux-perf-users@vger.kernel.org>; Fri, 15 Nov 2024 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731697093; cv=none; b=PoDXMyMhMVqUuWaUAjeu/i018jDVYblOMeCwFd8jtV+5oAh57dssYZlLW91uz9zOpTiPQUYuOCkcH2zWurdzEFzt7eKqcmzZZ1XX75JPIMjA/KoXbV7NpZOw5mpFtAyn8XrJbA5whuA4QNCJWFq8o8bwHqyTbgxp2JaxeWQgRx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731697093; c=relaxed/simple;
	bh=KrhyjO33ThupBbnqrRTfxztSiUsXDj70GcuMwEDZmeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVhy8G6+lazDX26fTQ379l7K8qczYTEwQ7TSrK1OMf5kVXQKRLC1rXzQTTPyC5p3F7xLW2fftSNQl71l1BgjWLkIizWnr51y7C5MBa2PWw84Zw+v9rdvcdIUGDrpID5fd02Uotsel/re9Omp/mHscglFcEHdigElBYmpCgGBFiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SMt5K5NX; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SMt5K5NX"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so6025ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 15 Nov 2024 10:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731697091; x=1732301891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80PGuzrHXAm66euHvfJsgwFOI4nxtZeFwme2x5gfn88=;
        b=SMt5K5NXbAgR1ZBxZh6Io/eK03Ktdejcw7ca3fd3t0SrY3YC8FFhVU/b3f9SInCR0z
         lKkxm+w/pKT8Dlp2XuSZx/LeQ6SnMaODu3SceKzigYrLhmqKJ+UzVNTb8m/DP3YS7nYu
         KVX5mm01DtiR/nkrG4mlatAU/RAucjQLRhyxf0+OgTTleANcU6/n2naZL+yS+AKADkar
         c8ZjqnKAoXWEDy1jYG3J9BadYbJkpVTbJEuhjhvu4tDdNrsyUX0gRSmj4OGDfXRdEbrd
         P0jIH/e5pO3HKkGom5IM6e+WcDYJYwZekOarYetUCLB240JKvg/lwZOj4kxdljiFcSgU
         1XIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731697091; x=1732301891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80PGuzrHXAm66euHvfJsgwFOI4nxtZeFwme2x5gfn88=;
        b=VQ2sqFAqg+2oHclPHXz02uk5JiYXy7XkELeqTPH5Is3ciocwy6pa7OAl3BJUR2rmyi
         M0AKSWRq0PTfTP6dMhRjKE9azHiSazSeH6RmeQMZgQIwYhv8pAj+yE27H3W72WQUPKak
         xHKD85hjaPQB4Uq79gH2N55xc0WxrC8OXp0n6GokJc76YrI9M5yofQ0LqHYUEbEe33dj
         TJf/TEX+Gzl6dWnGzfK20fsrn0v/fuinWaIu9f6B85BnZL+bb7iKTcci034mgbiHc9OI
         6KKrUAIXVN4CMRlAtMzLDXsrma+6UMQt0YG9OC7bjTI/2ZuB65+jmohqFgQsxegoVzLd
         sV5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3q/GbFDMorlXGBzYdi4aUHhm0NcE48uBAV16HP61nLfYtjMki/hOf/fyuGybzSgt21Im2ZzZu3VdljZWRahyI@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg1VS7dhxMS908eaXYaryIXJmc2/zSw5Rg06YT0NDWuHxS84SJ
	inYaUZ7w+VFMTcitEMfgu+9tgGZzwvljb6YU2NDJsf5y8G+fjBVOx2nycxFEJ5FmwdtN8gwl5cB
	buzNjw9Dwhmt2J9aW21JRYEHQUKcvhhcZtBy/
X-Gm-Gg: ASbGncsmv/EVYa02m1b8fkE+8EYHXdLgFvec2yL+/KzLnR3CdyUHLUmEHhS2utYgIHT
	srag6bZ8KgeZaL1dvmfkALOIXm6TwF/lk
X-Google-Smtp-Source: AGHT+IFnY+LIlDAfB5Pm+G15TjoxMYR74ZP43lguL34LO9a7ABotmMVMvEPWcOYvOMTlZ3m4eULUKz5ADnLx6x+cyK8=
X-Received: by 2002:a05:6e02:1d9c:b0:3a0:9def:a87a with SMTP id
 e9e14a558f8ab-3a74f75d822mr980045ab.3.1731697090877; Fri, 15 Nov 2024
 10:58:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115091527.128923-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20241115091527.128923-1-jiapeng.chong@linux.alibaba.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 15 Nov 2024 10:57:59 -0800
Message-ID: <CAP-5=fXPe9277agFqyEQsOG8h_wM5zFh3Sz+NFpsacU+A5MOuA@mail.gmail.com>
Subject: Re: [PATCH -next] perf tests: Fix an incorrect type in append_script()
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 1:15=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> The return value from the call to readlink() is ssize_t. However, the
> return value is being assigned to an size_t variable 'len', so making
> 'len' an ssize_t.
>
> ./tools/perf/tests/tests-scripts.c:182:5-8: WARNING: Unsigned expression =
compared with zero: len < 0.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D11909
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/tests-scripts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-sc=
ripts.c
> index cf3ae0c1d871..1d5759d08141 100644
> --- a/tools/perf/tests/tests-scripts.c
> +++ b/tools/perf/tests/tests-scripts.c
> @@ -174,7 +174,7 @@ static void append_script(int dir_fd, const char *nam=
e, char *desc,
>         char filename[PATH_MAX], link[128];
>         struct test_suite *test_suite, **result_tmp;
>         struct test_case *tests;
> -       size_t len;
> +       ssize_t len;
>         char *exclusive;
>
>         snprintf(link, sizeof(link), "/proc/%d/fd/%d", getpid(), dir_fd);
> --
> 2.32.0.3.g01195cf9f
>
