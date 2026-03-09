Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECF83264C6
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 23:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773100615; cv=pass; b=KZwRFR8xmyHB5RKg2DVsEReXmHUA5bx0z3S4Ri8c3jHy2snn5gdy79KDN7M6hqErcOO6KPfm8LGu7TriEfwV46m+eQM4E5g2BmTnx5fWfQiWpT0iCYKQWxFxh31jJ/vqoGxQ6Xqs/SXmy7emFfbPvFEXAF0wRb5jZ4KOfQFOYv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773100615; c=relaxed/simple;
	bh=rCkqlmOoX493PcNokTYXqB/RoubSartBr89jYzTEuJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fthopyhktbr5MJ+9YMig1LeGZUutJ4XkOUh6pESRnOymIY1Umgsv+umvqkrxFxvZD+aFw0zF6V3nJbCWcUrJJqnN2vRberj/6j+MxKqr4N3Xd3io7cyK71cW4Zhv+WoNLX5D1gxgSZPEhMiGoFqzTJ30xAQxR5c6yNleqAdYEDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BjsQO3Y5; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BjsQO3Y5"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae3f822163so38065ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 16:56:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773100614; cv=none;
        d=google.com; s=arc-20240605;
        b=Y9f/mhFxOwV+qTbKbsxvXmJB0cJNJ9N1RpZHHRRPM7oExlYM0NhNJyZr2+0+u/nIg8
         aTUkaEfSjS3763RYpKW1qF2qMcCnpithihCWcIc0ZgDXrzTu5fZpAzE4eCueweOnXM5J
         zAI7/cciK4XgXVqqdQqYK0G7dk0sSXmCK7OTdlKj95+2MTjLpkw0kToMSZ2C27ojYUFL
         rda53iB6700I0PjfmvkYXIuGd5fYsxSalwCLCnI45lJG6vUWOojFmmGv7O9d//b+EyR0
         FXA+JISIz83/LvY/2YLQKCftbjg+PspFpuUe2oJcaUdNRV6Pm+ZYreDNAwGW0vfcaW8N
         na8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v6T7JtNle+obQbNoh/527NQd5aVpDuOky67lKQ0q6CI=;
        fh=G09kBGkRqBkd+MMn1ScgH8KnCk5gtzklJ/r0ZMLln0w=;
        b=d4aYWOXG4oPzLY1pmgny4g9rSCvRarFNIUd5YS/2GBxt5N9ZMfmVQwwpzRfByUbJEM
         Hf0Int94iUDRfSsdwzYxFs1/tnlnsfZ34NsbKLaFY65Nl7/Gge4HAtrKyfBPnQdYyJNT
         mLOUxQJflygN//E9I2XPwqCQ/CQOH0MIxfgZYJ/kcmAF2CGQJEF0zRPgHf5RdrEWNqPH
         SYZu/IRfuMGDY6vguN6/0ZOpZHyyW0TR5oLCv6YNr1SYIl7+Y464TvZD+xRhQR8Ibt6S
         f7U3rnn3cPfBmPArKzF5BTpVwHQ6wKCfOZBrWgJbX0vzvx8y2kthY7xPoKYToO5uU4wY
         FuTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773100614; x=1773705414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6T7JtNle+obQbNoh/527NQd5aVpDuOky67lKQ0q6CI=;
        b=BjsQO3Y58YlhiO0a9LUpMcu+uihVAQM9pSDl3rmq68rqyfEzNDThhl6nxk/V+X7Xde
         PpWyMgo82hx2htmOI8f9YX8Suu4kb0j4lYQ+KiHftyrGGaBfLZTfs0YEwF2x6XPgpkqQ
         JAo/h4mVgSGP/a/NHQpKREv7kLYTVRP44uBiBFiHviXZEjt77AxfJ8pt5CXaJ3xJOziY
         v2D6Dd7HC4xNvgD9Lx+4Ogjj73UsUvcssAZp5cKtRokI3czjsJsFK9nYdbA/H+tYzTbC
         ZlPLkDHyjCLUk5A/K0ukr+Mnuy4gnGt6mAOuM3z+NsRRbi2mvu4BJw2h8C8ZTWjzuCDO
         9cXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773100614; x=1773705414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v6T7JtNle+obQbNoh/527NQd5aVpDuOky67lKQ0q6CI=;
        b=YjxZEZsffMq7OsaWAC1KcR+ibyrpC8OMK62PsyhOzOfkAHqnjoCR/QRZqshQ/1SR6I
         CS+JRJeewJWhmFIUs9FdFOzUdqS/YL3lY8Z5s283MswsZBvexX+/Ib5JqUI6hIQBlGdk
         0vTeDzZ60bX7ms0siBEiyCBkiocMd7uVJyrHEYLgXMx2gHswS8Aaj6pSZwFymL0yQNgV
         9pbP1sxzhgsWSRU0uoDn01LNdR7orsXayookFPTkAwfw8sKx3nad9bkNCOR8oGowT8MK
         +gDykk2OxSKE7/hyz85y5Rbf3uVU6GGhFOFEAA+W7oXR/rlXfMxumRqtvb1uhfxTRwxo
         lo2w==
X-Forwarded-Encrypted: i=1; AJvYcCV+jpkU6PbFBE++UrBNznp8bm9BHyKw7AMkL0Vw6SOsnP650t3nMuRGEyVApwl0JbBUbnRpmLVLGESPfHtFzA3n@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0wIMfoUl+A8EMdEMAa/jXnGIs2HGsveBgBANnm2J3cb6k1YrM
	TdbzR5CSZk0A8yBdfZToTcdCT+kO99Eh1cvUDCoqYAHPhjfs9Wc38Zrnj08ob7R/5wU7lJmU4jp
	jBtmfjih4hMLOGTjU5u9sPZ2qNsqLyVcPwWKIvGy+
X-Gm-Gg: ATEYQzwzbYFhTjoHjNA6Bz0QIDUXgm226qPGu5JOGP99R9483PzhSfOuQ0DI4yTSPMr
	Xu+1OF3sY2yTfF7PTuI+Ok3lLXTcoRScygInexAQqZtLJpW+Ter+pSudmk4MDEexbyuoH7NiEn5
	ISFxz5WD7xOvQ8RG8ZB6U4rz9HKBQO5QbsYmT2mwTl9ISi0lVt0Knpf1qYA+54Nik54Sy/NFMYy
	jMFHyzL7X2nw2o3fpIHlsKsCqOXdDPJYNscym6FxRx+teR32qC8IFmAJnjCJlbKergiT8DIBJk+
	uMcdw+3l76kcvVHsNt1xp0bb6IjzU+5T7+Y=
X-Received: by 2002:a17:902:cec2:b0:2ad:6f9b:7818 with SMTP id
 d9443c01a7336-2aea459afe5mr794195ad.23.1773100613386; Mon, 09 Mar 2026
 16:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114011750.350569-1-dapeng1.mi@linux.intel.com> <20260114011750.350569-7-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260114011750.350569-7-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Mar 2026 16:56:42 -0700
X-Gm-Features: AaiRm53yCeqJhXsRyPH_nKTZd_QVKpTpHhgWJNLz2w3TzzU-V1yF-V4C_UROwDY
Message-ID: <CAP-5=fVSbYX9qV7NOrfkH7GyFRBXjkfgc34sv8FkioPgY9xQ4Q@mail.gmail.com>
Subject: Re: [Patch v3 6/7] perf/x86: Use macros to replace magic numbers in attr_rdpmc
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

On Tue, Jan 13, 2026 at 5:22=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel.c=
om> wrote:
>
> Replace magic numbers in attr_rdpmc with macros to improve readability
> and make their meanings clearer for users.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/core.c       | 7 ++++---
>  arch/x86/events/intel/p6.c   | 2 +-
>  arch/x86/events/perf_event.h | 7 +++++++
>  3 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 0ecac9495d74..c2717cb5034f 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2163,7 +2163,8 @@ static int __init init_hw_perf_events(void)
>
>         pr_cont("%s PMU driver.\n", x86_pmu.name);
>
> -       x86_pmu.attr_rdpmc =3D 1; /* enable userspace RDPMC usage by defa=
ult */
> +       /* enable userspace RDPMC usage by default */
> +       x86_pmu.attr_rdpmc =3D X86_USER_RDPMC_CONDITIONAL_ENABLE;
>
>         for (quirk =3D x86_pmu.quirks; quirk; quirk =3D quirk->next)
>                 quirk->func();
> @@ -2643,12 +2644,12 @@ static ssize_t set_attr_rdpmc(struct device *cdev=
,
>                  */
>                 if (val =3D=3D 0)

nit: Could 0 here be X86_USER_RDPMC_NEVER_ENABLE to eliminate even
more magic numbers?

>                         static_branch_inc(&rdpmc_never_available_key);
> -               else if (x86_pmu.attr_rdpmc =3D=3D 0)
> +               else if (x86_pmu.attr_rdpmc =3D=3D X86_USER_RDPMC_NEVER_E=
NABLE)
>                         static_branch_dec(&rdpmc_never_available_key);
>
>                 if (val =3D=3D 2)

Similarly could 2 be X86_USER_RDPMC_ALWAYS_ENABLE ?

Thanks,
Ian

>                         static_branch_inc(&rdpmc_always_available_key);
> -               else if (x86_pmu.attr_rdpmc =3D=3D 2)
> +               else if (x86_pmu.attr_rdpmc =3D=3D X86_USER_RDPMC_ALWAYS_=
ENABLE)
>                         static_branch_dec(&rdpmc_always_available_key);
>
>                 on_each_cpu(cr4_update_pce, NULL, 1);
> diff --git a/arch/x86/events/intel/p6.c b/arch/x86/events/intel/p6.c
> index 6e41de355bd8..fb991e0ac614 100644
> --- a/arch/x86/events/intel/p6.c
> +++ b/arch/x86/events/intel/p6.c
> @@ -243,7 +243,7 @@ static __init void p6_pmu_rdpmc_quirk(void)
>                  */
>                 pr_warn("Userspace RDPMC support disabled due to a CPU er=
ratum\n");
>                 x86_pmu.attr_rdpmc_broken =3D 1;
> -               x86_pmu.attr_rdpmc =3D 0;
> +               x86_pmu.attr_rdpmc =3D X86_USER_RDPMC_NEVER_ENABLE;
>         }
>  }
>
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index f7caabc5d487..24a81d2916e9 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -187,6 +187,13 @@ struct amd_nb {
>          (1ULL << PERF_REG_X86_R14)   | \
>          (1ULL << PERF_REG_X86_R15))
>
> +/* user space rdpmc control values */
> +enum {
> +       X86_USER_RDPMC_NEVER_ENABLE             =3D 0,
> +       X86_USER_RDPMC_CONDITIONAL_ENABLE       =3D 1,
> +       X86_USER_RDPMC_ALWAYS_ENABLE            =3D 2,
> +};
> +
>  /*
>   * Per register state.
>   */
> --
> 2.34.1
>
