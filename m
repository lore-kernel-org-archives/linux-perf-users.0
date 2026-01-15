Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D462D73B8
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Jan 2026 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768474627; cv=none; b=DPF+tlgLeZVmZz2+TPHBFypzM91C9L/TGAeuT/3G5tFsFvlQ4gLny7ak+anUwLWWMEhLAGFVyRCalbVl56YOuNWlFUDzAJoud3fq5JXW5xF5XFLSyVC4EcWht5VAEEAFerSN18XA5AQjLSVsaLVuky+T+ISJMwjHMKmwDiiffRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768474627; c=relaxed/simple;
	bh=BFw2Sbo5XcdLVdeWIJdGY/VA3Zb0rYd7fqBOWX4+qDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xf7A+Ie0KgOISxMS9foX50gtaN6V6kNxTKdb2jTggXHft5RzRpLvmnpusJvhOZMfk6Z5q6nb8ziY9qqgkn6r4s4gdo3OnCFllLMsyxXrvIqvVhG01RpixDUAHIds/J20BW7wtoTg8rNbnJ7SfUHpSGV4b0kHaqEs7wu5dGouuVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RX0v6Q7o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RX0v6Q7o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E262AC2BCB1
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Jan 2026 10:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768474626;
	bh=BFw2Sbo5XcdLVdeWIJdGY/VA3Zb0rYd7fqBOWX4+qDw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RX0v6Q7o/N/Ws1XpTvUU5qcKvxnr7LGZc+S1IIPfEf3eywpDeDy2avrvuEgYN6Yr+
	 tL10J0pd89DxOzEF0280W2+Msq/e29FjIwoDMSFDOAt06qrtUJiy7Y8eldCY8YX5Jx
	 GyeTsfLH7X2XaidOuflctKtUNjbAq0s/3cxG9wpgyhazzbHVKNKP41Pg8W0hEPkv81
	 VAzkhgNJ5XoAPiEQ4CKS26vgyMC2GVeTkwXsVU8dGiSfQlD8MOBrt0mkCoGDSSdTzZ
	 8K2+x0IjjDaqIlhjwGDglTh9+8K2RS4BrHXBrFDlG/WXfIOmu9xkxoiVspeBQpdfmj
	 OToLCCtgsoByw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b872de50c91so120500766b.2
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Jan 2026 02:57:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW6rWWXA0vzwOL4Ws/OQEK3ys8HRF1es0ZTZNqLyC6x53Cab1WYqen0z5b/ztvWo8WcwERnUNqzxbJ3+YcsPfBJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy32Y+E3PRoWe8a1LyICexIDa6g4a0JTqHUkZmpEUXOBzSoynKX
	mEmWnoiF9glLxQ0Kw3GXxJsLUdo/cPuHZBeAL5L/9cbyoc3fFFB2K3OR6Yodk2LkJ9ZM2ylkv2H
	IJ+XbprqSe94yaWUBUCIJ8pjbwBLWF+o=
X-Received: by 2002:a17:907:97c2:b0:b87:322d:a8bc with SMTP id
 a640c23a62f3a-b8761110e67mr533768266b.31.1768474625379; Thu, 15 Jan 2026
 02:57:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109025312.226700-1-lisa@bytefly.space>
In-Reply-To: <20260109025312.226700-1-lisa@bytefly.space>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 15 Jan 2026 18:56:57 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7cr-jWtE32bzWEAJN-+QiHzWThjoFn+RoCeSXqHgsYeg@mail.gmail.com>
X-Gm-Features: AZwV_QhWtfujBmtH0zUD_xjQzQ8AEaaI426XP54ATPRee7Y8HWHlh6kUm7TXR24
Message-ID: <CAAhV-H7cr-jWtE32bzWEAJN-+QiHzWThjoFn+RoCeSXqHgsYeg@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch: Fix PMU counter allocation for mixed-type
 event groups
To: Lisa Robinson <lisa@bytefly.space>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, WANG Xuerui <kernel@xen0n.name>, dapeng1.mi@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Fri, Jan 9, 2026 at 10:53=E2=80=AFAM Lisa Robinson <lisa@bytefly.space> =
wrote:
>
> When validating a perf event group, validate_group() unconditionally
> attempts to allocate hardware PMU counters for the leader, sibling
> events and the new event being added.
>
> This is incorrect for mixed-type groups. If a PERF_TYPE_SOFTWARE event
> is part of the group, the current code still tries to allocate a hardware
> PMU counter for it, which can wrongly consume hardware PMU resources and
> cause spurious allocation failures.
>
> Fix this by only allocating PMU counters for hardware events during group
> validation, and skipping software events.
>
> A trimmed down reproducer is as simple as this:
>
>   #include <stdio.h>
>   #include <assert.h>
>   #include <unistd.h>
>   #include <string.h>
>   #include <sys/syscall.h>
>   #include <linux/perf_event.h>
>
>   int
>   main (int argc, char *argv[])
>   {
>         struct perf_event_attr attr =3D { 0 };
>         int fds[5];
>
>         attr.disabled =3D 1;
>         attr.exclude_kernel =3D 1;
>         attr.exclude_hv =3D 1;
>         attr.read_format =3D PERF_FORMAT_TOTAL_TIME_ENABLED |
>                 PERF_FORMAT_TOTAL_TIME_RUNNING | PERF_FORMAT_ID | PERF_FO=
RMAT_GROUP;
>         attr.size =3D sizeof (attr);
>
>         attr.type =3D PERF_TYPE_SOFTWARE;
>         attr.config =3D PERF_COUNT_SW_DUMMY;
>         fds[0] =3D syscall (SYS_perf_event_open, &attr, 0, -1, -1, 0);
>         assert (fds[0] >=3D 0);
>
>         attr.type =3D PERF_TYPE_HARDWARE;
>         attr.config =3D PERF_COUNT_HW_CPU_CYCLES;
>         fds[1] =3D syscall (SYS_perf_event_open, &attr, 0, -1, fds[0], 0)=
;
>         assert (fds[1] >=3D 0);
>
>         attr.type =3D PERF_TYPE_HARDWARE;
>         attr.config =3D PERF_COUNT_HW_INSTRUCTIONS;
>         fds[2] =3D syscall (SYS_perf_event_open, &attr, 0, -1, fds[0], 0)=
;
>         assert (fds[2] >=3D 0);
>
>         attr.type =3D PERF_TYPE_HARDWARE;
>         attr.config =3D PERF_COUNT_HW_BRANCH_MISSES;
>         fds[3] =3D syscall (SYS_perf_event_open, &attr, 0, -1, fds[0], 0)=
;
>         assert (fds[3] >=3D 0);
>
>         attr.type =3D PERF_TYPE_HARDWARE;
>         attr.config =3D PERF_COUNT_HW_CACHE_REFERENCES;
>         fds[4] =3D syscall (SYS_perf_event_open, &attr, 0, -1, fds[0], 0)=
;
>         assert (fds[4] >=3D 0);
>
>         printf ("PASSED\n");
>
>         return 0;
>   }
>
> Fixes: b37042b2bb7c ("LoongArch: Add perf events support")
> Signed-off-by: Lisa Robinson <lisa@bytefly.space>
> ---
> Changes in v3:
> - Fix typo.
> Changes in v2:
> - Factor out duplicated perf event type checks into an inline helper.
> ---
>  arch/loongarch/kernel/perf_event.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/arch/loongarch/kernel/perf_event.c b/arch/loongarch/kernel/p=
erf_event.c
> index 9d257c8519c9..e34a6fb33e11 100644
> --- a/arch/loongarch/kernel/perf_event.c
> +++ b/arch/loongarch/kernel/perf_event.c
> @@ -626,6 +626,18 @@ static const struct loongarch_perf_event *loongarch_=
pmu_map_cache_event(u64 conf
>         return pev;
>  }
>
> +static inline bool loongarch_pmu_event_requires_counter(const struct per=
f_event *event)
> +{
> +       switch (event->attr.type) {
> +       case PERF_TYPE_HARDWARE:
> +       case PERF_TYPE_HW_CACHE:
> +       case PERF_TYPE_RAW:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
>  static int validate_group(struct perf_event *event)
>  {
>         struct cpu_hw_events fake_cpuc;
> @@ -633,15 +645,18 @@ static int validate_group(struct perf_event *event)
>
>         memset(&fake_cpuc, 0, sizeof(fake_cpuc));
>
> -       if (loongarch_pmu_alloc_counter(&fake_cpuc, &leader->hw) < 0)
> +       if (loongarch_pmu_event_requires_counter(leader) &&
> +           loongarch_pmu_alloc_counter(&fake_cpuc, &leader->hw) < 0)
>                 return -EINVAL;
>
>         for_each_sibling_event(sibling, leader) {
> -               if (loongarch_pmu_alloc_counter(&fake_cpuc, &sibling->hw)=
 < 0)
> +               if (loongarch_pmu_event_requires_counter(sibling) &&
> +                   loongarch_pmu_alloc_counter(&fake_cpuc, &sibling->hw)=
 < 0)
>                         return -EINVAL;
>         }
>
> -       if (loongarch_pmu_alloc_counter(&fake_cpuc, &event->hw) < 0)
> +       if (loongarch_pmu_event_requires_counter(event) &&
> +           loongarch_pmu_alloc_counter(&fake_cpuc, &event->hw) < 0)
>                 return -EINVAL;
>
>         return 0;
> --
> 2.52.0
>
