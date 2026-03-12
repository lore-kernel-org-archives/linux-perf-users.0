Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FDE399358
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 04:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773290707; cv=pass; b=HbjtiMbcOpd2Uzlpnu+67PA/1auUMtKe3dC6IjhMOpUDULjyx6pmEud1abT5Pm3O2rT4UTl+4EVUOqIqbgMF0BZIvdTrZqEL9brZe0l2XryuUYicgjZMmCt0Ae/BWokxefKxUfD21pL7FpMLQ70RA9S9MaR0tNSKQ+dXV0ByOYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773290707; c=relaxed/simple;
	bh=3rJjZgUqKZ6MSvcvalny4V7s3v6fjQAzRKX/u54oxTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7MvMhkoaap4wJT54uJ6y0RtfPLaM8a71O1+j1XKZfJLccrWoO9qEp/VQaIfnuex1I1IwEHH8iFHAgHXp2jF5/qA8zlrAvEDCfTGIOMHA+3bMPlzuBAKc3UM0WvMGHjqf8aLuvJzmRNFWVlYIv65dtVtGPqVsGxh3B1nB+nr2N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cI9Hncsn; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cI9Hncsn"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aea4ebb048so40135ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 21:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773290705; cv=none;
        d=google.com; s=arc-20240605;
        b=GLUxz5cjjvAdCOXdZnoQh+pmp5F+TfUwSvfctq6tk8fAwWWHYW0GDYEgDA+V022gSG
         YKFusZ4s0eX9P3h33y22XNscFCZj8c96DUbPYKuRfsbGTxxcKlef+2sA523KwK1TTtXC
         ssinGqtXVx6eoLr+hs31KWnTPBFlh0RQyYtGu37ut31QWO5NRp37HidQV0h6XqIaddhk
         YHIUWZx13IqBWaoTjt0BAVyNyEWtck4EVu52tRenzKI6HrDojTIIQz1qZvGHGMRU0hrl
         UMXCjzGdElbP9/6gWXvi0fi7XF9n7YC+6BCJveGnJr4uvsTHj/DDU6L8nra/9GMbmHv3
         5OBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HgMcmH9Gwpqc1HHx5dKj3Q/o1wWVuLoyfj8Tus3Dc5M=;
        fh=p5VfifAfALA0RyFNOaPYxUoMrYJ1nzXZ1KXLutiARXQ=;
        b=jTPlak7bIq1orJC746mCMP4+ExHbR3BycHQ4N1ocI7AN+qt4kHBdcQf+dhNlpF4482
         jUKkr0w09YusKEuigxcRjGxPFvaV2UR96nI4+UXm/fhmwPWB+D1tBXSUCiTmkNGt7B5F
         0DnAWf+1eK9lfQ2MmO83pTMkxjDQ9kQNl+xcFrrNE6g2K7E6+6LgHB7ijx4hBtSKpEqN
         VfFpsyueTffXUtaoLWwlTnGoTbBK1j8Idc03BYNPi7+8KNgc8PgUHXHbnqAq4YksfuhU
         f2abn40AU6d2eAVavCNKnljIrBMOKYivGVReO1herg7z0OGqSXg/d+WfAj1lkDol650X
         HUyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773290705; x=1773895505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgMcmH9Gwpqc1HHx5dKj3Q/o1wWVuLoyfj8Tus3Dc5M=;
        b=cI9Hncsn6liqIXWsGBWgXjVLoUR66YNjKUDZEJn3Ux+Zug0KQzmM4OrW+6zrvPT+yz
         i9vPbWksjo+vlLlwTTAceb6lYE7nsIVE9HDfSQENI3Wt+REUz+k1w0UXWyIrQfR1a4UR
         zGErO75uNxvdueW2rvS+7GYP+6PInly0U/rOoJvYOtCUpvkh/PT1nZL7P2Kkh6Zd3WQn
         UNpvZST4v+6qU15eN1kO/HoEeVjeRpiA3G6TNx6VUIgaXBVQSJAWyzWXOREET7ftM8ZL
         K4cD3mVAnjGjiEr0zgH9JJOVipaJeMLQ0f5GgDP1gCsVP/t+wJgiqQCmu/OYabKE2F3O
         IlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773290705; x=1773895505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HgMcmH9Gwpqc1HHx5dKj3Q/o1wWVuLoyfj8Tus3Dc5M=;
        b=srwFwFnajy/LoTBe9+ql26AOFnKVG5lXh17WCt3s/6meSWsfD1wj5GhZAU6MhrWKDH
         aFwJiE4n5WjIUZle6b0EaQbLlf/0QNcFheiOaxhUTexl8lh/IQWWd5C1AcKgx8jkB8RC
         zwBvHDoO0Is6cwY2wWEiFNq0ugLBddkKkrhJe5g777jj1SvBquDYe/kmRc329xnknwj/
         hkMoys24Ylq4Du0bRVkH20b3e54MatMx0AA3jSxhOnRvamDtJLBy5ScRiJ3HlAGLY4Hj
         EvkRgE2RYX+C81GQTrctU4hT/vgZKKQ9tlCt3NBkAc8ic0Pit5E8kW4GO0yR+704IzdS
         zeFA==
X-Forwarded-Encrypted: i=1; AJvYcCWwqPl93eqGYrxctGjq5mnssG8OQZQZvjm0WgY9fTdFWXXcKDvUTCY9gCTi0eSPVVe/hlVt+Dg1ci9FLHR5in58@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf5C8wFGMFcSllesQ2fNrXTMpHBxOvsoQw8jwGK7lE9ToXm/Fs
	qwFvSImF9lQtdsSWgjfz3sYyvykVa3Ya4tPEFLcDq752iSpLLNnikdE55S432u60dkDBuijT3sR
	+zLZ41UYi7PIHurbpA7Q+OQOKMpzi87PDjyVwRsRm
X-Gm-Gg: ATEYQzyXy5FgOFzZrjEBTzhgpoU2I10246VeYe5RAJOMqUc70IVB5mRtZFyQNu8j4gI
	gsQW+KklMO2l9ymiNYaRPtioXxNH/3o57Xq6jt1fXiUSWFDz/pE4IjHz4b50vafuVB+2NdC/7S2
	dvWozySjU5oLJO7+G/I2dhCg3HBRQPQ8n7czbSJ4NHHRauAPY6WPVj7k8INxsqRv2Y2WqqQaz8Z
	U/Le/OakUguO0oPY94U9ayOVQCKpsjHFdL+hDgzNDL7zUHr47Xt11H8v91elYRj7y3rIMwocOyt
	/lbkhcWl
X-Received: by 2002:a17:902:ceca:b0:2ae:44db:570c with SMTP id
 d9443c01a7336-2aebad8baa2mr1911705ad.12.1773290704275; Wed, 11 Mar 2026
 21:45:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311075201.2951073-1-dapeng1.mi@linux.intel.com> <20260311075201.2951073-2-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260311075201.2951073-2-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 11 Mar 2026 21:44:53 -0700
X-Gm-Features: AaiRm52BLEupPtEuYASnrUv315QKpDz0O4Jnk9_MedgTtoLXygzumPg-Cf64XxU
Message-ID: <CAP-5=fWr2L6miiFZ6Km3HYEdmqp3T0NBL=WY3buKdKztW+HvmA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf/x86: Update cap_user_rdpmc base on rdpmc user
 disable state
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>, 
	Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 12:56=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.intel.=
com> wrote:
>
> After introducing the RDPMC user disable feature, user-space RDPMC may
> return 0 instead of the actual event count. This creates an inconsistency
> with cap_user_rdpmc, where cap_user_rdpmc is set, but user-space RDPMC
> only returns 0.
>
> To accurately represent the user-space RDPMC capability, update
> cap_user_rdpmc based on the RDPMC user disable state. If RDPMC user
> disable is enabled, cap_user_rdpmc is set to false, allowing user-space
> programs to fall back to the read() syscall to obtain the real event
> count.
>
> Fixes: 59af95e028d4 ("perf/x86/intel: Add support for rdpmc user disable =
feature")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 03ce1bc7ef2e..0266a11d7ec9 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2807,6 +2807,9 @@ void arch_perf_update_userpage(struct perf_event *e=
vent,
>         userpg->cap_user_time_zero =3D 0;
>         userpg->cap_user_rdpmc =3D
>                 !!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
> +       if (x86_pmu_has_rdpmc_user_disable(event->pmu) &&

With the AI's help the following bug was spotted:

Places like cpu_clock_event_add call perf_event_update_userpage with a
software event:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/ker=
nel/events/core.c#n12314
This then calls arch_perf_update_userpage:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/ker=
nel/events/core.c#n6870
In x86_pmu_has_rdpmc_user_disable:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/x86/events/perf_event.h#n1336
```
static inline bool x86_pmu_has_rdpmc_user_disable(struct pmu *pmu)
{
return !!(hybrid(pmu, config_mask) &
ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE);
}
```
The hybrid call does a call to hybrid_pmu:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/x86/events/perf_event.h#n793
and that does a container_of:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/x86/events/perf_event.h#n782
```
static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
{
return container_of(pmu, struct x86_hybrid_pmu, pmu);
}
```
In the case that the event's pmu is a software PMU the container_of
should be invalid and this will lead to an out-of-bounds read of the
config_mask on hybrid systems.

Unfortunately checking the event is x86 doesn't cover the hybrid case:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arc=
h/x86/events/core.c#n780
and it seems this bug may exist elsewhere. It'd be nice if in the
hybrid_pmu function there were a `BUG_ON(!is_x86_pmu(pmu))`, but
unfortunately that'd only get exposed on hybrid systems.

Thanks,
Ian

> +           event->hw.config & ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE)
> +               userpg->cap_user_rdpmc =3D 0;
>         userpg->pmc_width =3D x86_pmu.cntval_bits;
>
>         if (!using_native_sched_clock() || !sched_clock_stable())
> --
> 2.34.1
>
