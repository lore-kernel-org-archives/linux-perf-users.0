Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2F08F6B;
	Thu, 15 May 2025 06:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747290908; cv=none; b=hZ7iwb7EwCfE2j28OAdBcV8SDMt3D5XOuq983ne1JVUhxLfViRa6OUNRBxHRxk5PkK01slUGbAJDqJsWJ2pMqH4nlP2hme32wk8H1mAAJ7O1NYIPCSJAkDuusUtlKAVF2WzLSiRILV5HoEPSjRVGiyaGrJVlmjEmsaRmy/UfHXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747290908; c=relaxed/simple;
	bh=MSr4YD5vSH4lNI7mt0HBLXYbePuFkhW1qFm0gecuRME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQbPiC15eoOu/zjsqh7YtJqR+8ds6xmEeWEH92olUurXkUzEsj3Cg2IX3+Fcy1dP9PMNK6XK0hTeN0+UDOtaM3McQhy94gFD4ie9AcAwL/0fZ4CNblKfHrTf8S4bxlpr18NOjtlmIIjMOBk+i00sKu7Zwy4OMNDm9OLJREoP57M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiX7F27m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiX7F27m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F683C4AF09;
	Thu, 15 May 2025 06:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747290907;
	bh=MSr4YD5vSH4lNI7mt0HBLXYbePuFkhW1qFm0gecuRME=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QiX7F27mVMR9T79j8DQ7z8gQkgcSQEv0mf/vft1q9VdKuieQaHGE0DzgKhumDV8rB
	 QQrsOUqSaxLbVGQCdPdGymB5MqmDFu0oKJxO4WlqyfLoS/3rqptcS8yPZT9FXVsvzZ
	 jTv03wGzqNbZLJEKGyd5tC2MgX1Q2qxVNT4yC3cld+fQQIprTu0rHmYGY5c6W2LAT/
	 W5Bl6inEAEsJI4guQOQcFN10dHZVFY7bEkByvOVZVwXVPX4QUpc7LyxXkuuCbkUpYb
	 gUHoJ0tJ8Af1XiqvPOsqNZKtHSotvxy9sBxBV7BfmxSyFavJHeqHBINmfbYn136VQk
	 Aj7CF1fL3DFHw==
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a0b7fbdde7so450282f8f.2;
        Wed, 14 May 2025 23:35:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+9dRE6yx6RVn3S8d3oVMZQbzCAbqObXCQ+7UA0GG+MrRQaAiLIDxabkOT1A3sJS+r8ll1kGCv2oyR@vger.kernel.org, AJvYcCV8Z7MMwXYnFl44OTjfOazVPmctGuNb/udkAYjUeKJwmubnL7LdgfNnReYEi/O1ecf7UyH0S+6iptx6t6CJ@vger.kernel.org, AJvYcCX5IxzLec5Gp0vlMTQJf5SNs3cM4aocglJzY2c3CPOIjv8F2Xr5/8Eo3ayq8iV3I01Fh6mcPX83xVmHmNzZjVrKyA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5bfN6DK/JoXN570b/drXVVaGt3nrfuPdwOpYZoBJO/0aIKW8h
	zf0Ynj4z22KXycaFYjZ/cjt6DP8HiE2dnVJxZ4VT6AbUPxITjD+YjQ+K1zyujjPaY7LCmsYn2Iu
	BeA01NI1zwhsf9a1+QNvmzRTmk5Q=
X-Google-Smtp-Source: AGHT+IFGLHb7ySos/FnFUiLC+79eVlvbF+XUlDMy0ikXTR7voaegX8lHIiEjUdPYRkwNprzSQchX3TU4Sk49muf6LHU=
X-Received: by 2002:a5d:5f46:0:b0:3a3:582f:efaf with SMTP id
 ffacd0b85a97d-3a3582ff088mr403353f8f.26.1747290905872; Wed, 14 May 2025
 23:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514151401.2547932-1-kan.liang@linux.intel.com> <20250514151401.2547932-12-kan.liang@linux.intel.com>
In-Reply-To: <20250514151401.2547932-12-kan.liang@linux.intel.com>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 15 May 2025 08:34:53 +0200
X-Gmail-Original-Message-ID: <CAJF2gTSKyhzVMeWA9DN7wjaOfKW+K8XiO56c10kim6eesJYDDg@mail.gmail.com>
X-Gm-Features: AX0GCFtDQK1cgru_NYx59vfBOI0EV2TaEiyZ3thPCPW0dP3lU5WeJSfw_X1WhWs
Message-ID: <CAJF2gTSKyhzVMeWA9DN7wjaOfKW+K8XiO56c10kim6eesJYDDg@mail.gmail.com>
Subject: Re: [PATCH V2 11/15] csky/perf: Remove driver-specific throttle support
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org, 
	irogers@google.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, eranian@google.com, ctshao@google.com, 
	tmricht@linux.ibm.com, Mao Han <han_mao@c-sky.com>, Guo Ren <ren_guo@c-sky.com>, 
	linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 6:49=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The throttle support has been added in the generic code. Remove
> the driver-specific throttle support.
Acked-by: Guo Ren <guoren@kernel.org>

>
> Besides the throttle, perf_event_overflow may return true because of
> event_limit. It already does an inatomic event disable. The pmu->stop
> is not required either.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Cc: Mao Han <han_mao@c-sky.com>
> Cc: Guo Ren <ren_guo@c-sky.com>
> Cc: linux-csky@vger.kernel.org
> ---
>  arch/csky/kernel/perf_event.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.=
c
> index e5f18420ce64..e0a36acd265b 100644
> --- a/arch/csky/kernel/perf_event.c
> +++ b/arch/csky/kernel/perf_event.c
> @@ -1139,8 +1139,7 @@ static irqreturn_t csky_pmu_handle_irq(int irq_num,=
 void *dev)
>                 perf_sample_data_init(&data, 0, hwc->last_period);
>                 csky_pmu_event_set_period(event);
>
> -               if (perf_event_overflow(event, &data, regs))
> -                       csky_pmu_stop_event(event);
> +               perf_event_overflow(event, &data, regs);
>         }
>
>         csky_pmu_enable(&csky_pmu.pmu);
> --
> 2.38.1
>
>


--=20
Best Regards
 Guo Ren
