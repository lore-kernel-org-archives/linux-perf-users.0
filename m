Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8034111BF
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Jun 2025 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749067751; cv=none; b=ZDSNeR5BCQWanaOrZr+g1vpca2Xfxv/EbB5mBVEL/ZFAQ3NLqdkkr6SvQyWbtbWNd5m/FMa4iULAPHD2d0o/sR5HrGwzSm2DE2DofYre2MH97Tsyhj/vPCVpcDKJ7RZeRGc27i3uyp3Nm74IJX2b0n/ZIEF7XG1Eje5Uu4sQCc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749067751; c=relaxed/simple;
	bh=JeOoVB0bIPowliZ3Nqz1q2FpC5OCUaH8ypU+/TyDaMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdRbW15eFJSlJj940GTYlBJ2KFbIr1aRvs6k+EeydcGuQ1vK7ibu+sbRNHuAvAPZ19IdHXEsV+rBjDn3JyIAiWFscWWpf4hqUf7/rfaTQjcb3LoRMEzeZxEplGN9Qr6ve1g8DJ6dnBN0882gH3aZZaEMlsc+aVMZV7Sg+h2RcFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w2VY1pQ3; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w2VY1pQ3"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3dc8897f64cso358175ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Jun 2025 13:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749067749; x=1749672549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQd/6lxEQmh10n4MdeZg3ZypUWfH+P8Jft7FB6Fs6q8=;
        b=w2VY1pQ33HyWOZ2Ndwj3r8DDQza3CWk8SiPyoKFVUHmIfdoy0y8BxHKp259QCdXJfO
         QC028AiXOmjhn1q8SLHLWz4Z3L2seM/oL0TEMWmZ+w8vTVudiIxUk3YrUW+EOzMxmDAG
         MjmGvkCW+RudczKr90WB72DyNHHW8mbvLfDC11qSjam8kUL8/lTk+eudwcft4xWhNJNn
         o79IOFwK1SFmFL5u205sN3+FK2lsJPeB2XmB+FSzfb1io3Ch9UeQEuA8ygmI1J84UAB9
         RqeFVBELog2XohfRqwgy4f/CNLyiFhXKRZPOWVNudEg+LqfRNVz/x1keCnRcCO/pZIyH
         7Wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749067749; x=1749672549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQd/6lxEQmh10n4MdeZg3ZypUWfH+P8Jft7FB6Fs6q8=;
        b=A9MSnqyZcEV3AFBCXMjJStOanwge8H4av5CzjQWIQkDzglXLKbwyh1MaKlCiE8rTrd
         meVtCL1m8/OoEjFLgsD8+1qI1IAlSdhuFM58JMDiL3dHK2bTBb/NOEiw2E4xTxIyjYgF
         IW6o2YkfV21IRtq4EETiSWNzhnt7TbNQsxFL5enK/2zfaM1VC9ZSdFhoCsSwUP6TJeXO
         ufV5UrfVa8sUFeCOuCPpyq1Z0yOujuSf6tIRZ9ESschRDmCqHzgjUwJIb+EG/Yb7zIAV
         fPEH3qugdo7jnEKtQQ5vsA71f8w5I9io/0yIffYqsRpNHe2rvdrnIiSxJq00JWQvxVTh
         qoYA==
X-Forwarded-Encrypted: i=1; AJvYcCWdIPCmCugPiCCTDeTL8AklB9MTP0vDVfeGwu2S9mCG17fcMInFivR96FfFnfQ+0LLTpP9p5gE5N9go0Fo9uiBP@vger.kernel.org
X-Gm-Message-State: AOJu0YwPI75KN3moEZt6z+VWJqaIQ4DO9SjW1j3UQOAcHS1WCaFF6cUW
	TbLcwl6d03v94D6UvfzH4GQUHd9GcPZGt5PZ7aS01AUwd3Zr9biq861OUEPwLWkxcMJ9/moR7Y+
	hxWZ/Rt3pX4p89NdXHqQW7Xd9LQozR7Nkj3r6oik+aMhCsIRyC4dBV4Nw
X-Gm-Gg: ASbGncutUw0Re+VyyYkjWcNqMDNNFtcelKKvDNH43ADxiOaPBBhpM3hSRlRRhU1xai3
	27KDwZANUVnLyQ3LGcApcJnTBHc2SgF3Ugs6k4XpI+MDiTmkorLikPy8PdtkOz2ykmmqeGNkfJ9
	Xds5WBO/El7LVVcJCfAACiTamUUQLPYl0Ph7hTkC3a0oD/+G5dmv1Sey53VzmqO0VccTJgk6o=
X-Google-Smtp-Source: AGHT+IFxxFvhMmlbkQhVjaeWObABV3WoeoOVT5fSHhijIuYsrBno4ADnY5diwgzhSEBnYHCkQ7K8VovdxIPM4tB5l28=
X-Received: by 2002:a05:6e02:4d1:b0:3dd:b826:deca with SMTP id
 e9e14a558f8ab-3ddc69d0cadmr520205ab.26.1749067748380; Wed, 04 Jun 2025
 13:09:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604171554.3909897-1-kan.liang@linux.intel.com>
In-Reply-To: <20250604171554.3909897-1-kan.liang@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 4 Jun 2025 13:08:57 -0700
X-Gm-Features: AX0GCFu_ae4C-apM5oZSw0bUB-TV69VsOZiStuOFLxft_vnnKpidVhfv4nqHewo
Message-ID: <CAP-5=fX9+XouUy=KeFbHw_GEMKjHteg_0OPvvohhe6hxgVP6UQ@mail.gmail.com>
Subject: Re: [PATCH V3] perf: Fix the throttle error of some clock events
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org, 
	mark.rutland@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, eranian@google.com, ctshao@google.com, 
	tmricht@linux.ibm.com, Leo Yan <leo.yan@arm.com>, 
	Aishwarya TCV <aishwarya.tcv@arm.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 10:16=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Both ARM and IBM CI reports RCU stall, which can be reproduced by the
> below perf command.
>   perf record -a -e cpu-clock -- sleep 2
>
> The issue is introduced by the generic throttle patch set, which
> unconditionally invoke the event_stop() when throttle is triggered.
>
> The cpu-clock and task-clock are two special SW events, which rely on
> the hrtimer. The throttle is invoked in the hrtimer handler. The
> event_stop()->hrtimer_cancel() waits for the handler to finish, which is
> a deadlock. Instead of invoking the stop(), the HRTIMER_NORESTART should
> be used to stop the timer.
>
> There may be two ways to fix it.
> - Introduce a PMU flag to track the case. Avoid the event_stop in
>   perf_event_throttle() if the flag is detected.
>   It has been implemented in the
>   https://lore.kernel.org/lkml/20250528175832.2999139-1-kan.liang@linux.i=
ntel.com/
>   The new flag was thought to be an overkill for the issue.
> - Add a check in the event_stop. Return immediately if the throttle is
>   invoked in the hrtimer handler. Rely on the existing HRTIMER_NORESTART
>   method to stop the timer.
>
> The latter is implemented here.
>
> Move event->hw.interrupts =3D MAX_INTERRUPTS before the stop(). It makes
> the order the same as perf_event_unthrottle(). Except the patch, no one
> checks the hw.interrupts in the stop(). There is no impact from the
> order change.
>
> Reported-by: Leo Yan <leo.yan@arm.com>
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Closes: https://lore.kernel.org/lkml/20250527161656.GJ2566836@e132581.arm=
.com/
> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Closes: https://lore.kernel.org/lkml/djxlh5fx326gcenwrr52ry3pk4wxmugu4jcc=
djysza7tlc5fef@ktp4rffawgcw/
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/lkml/8e8f51d8-af64-4d9e-934b-c0ee9f131293=
@linux.ibm.com/
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>
> Changes since V2:
> - Apply a different way to fix the issue.
>   Remove all Tested-by since a different way is applied
> - Update the change log
> - Add more Reported-by
>
>  kernel/events/core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f34c99f8ce8f..46441c23475d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2656,8 +2656,8 @@ static void perf_event_unthrottle(struct perf_event=
 *event, bool start)
>
>  static void perf_event_throttle(struct perf_event *event)
>  {
> -       event->pmu->stop(event, 0);
>         event->hw.interrupts =3D MAX_INTERRUPTS;
> +       event->pmu->stop(event, 0);
>         if (event =3D=3D event->group_leader)
>                 perf_log_throttle(event, 0);
>  }
> @@ -11749,7 +11749,12 @@ static void perf_swevent_cancel_hrtimer(struct p=
erf_event *event)
>  {
>         struct hw_perf_event *hwc =3D &event->hw;
>
> -       if (is_sampling_event(event)) {
> +       /*
> +        * The throttle can be triggered in the hrtimer handler.
> +        * The HRTIMER_NORESTART should be used to stop the timer,
> +        * rather than hrtimer_cancel(). See perf_swevent_hrtimer()
> +        */
> +       if (is_sampling_event(event) && (hwc->interrupts !=3D MAX_INTERRU=
PTS)) {
>                 ktime_t remaining =3D hrtimer_get_remaining(&hwc->hrtimer=
);
>                 local64_set(&hwc->period_left, ktime_to_ns(remaining));
>
> --
> 2.38.1
>
