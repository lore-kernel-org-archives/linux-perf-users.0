Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24E026E165
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235014; cv=pass; b=dK8kNxMNNbnoFnCl2n5t2YNATZOVal93e62Iz3kdcw9auu+BjVh1wF8lwu8eTvOdtTHsrTAJKfRTxs+WPIrhbJRNRGP0N7PKlqGB5bsx18tE8Wgs+kzRWMKVbWGr+WILO+IOZC5lep+N00qOasenqF0vwHfBrLoGmEyefg0OlVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235014; c=relaxed/simple;
	bh=Jc3NFIyBGO0I0IA43oP18JYuheVpqNYBKCnYTwx2ijc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utCXLcZkYmhkLpA1r7SjjgWfLJKVty9l9tIZL4oXHcosFNt4J2CVcHsApQYMx4XfaSXIlfjyv575OC4Zt1peBP75dXl6NdGuSRRDGKaTjN9PRymnLjopOzQaKRfdz9+gcbl0MenqDSKnEs9mmiat0t9ZhnqKc4D2ejVr06hagEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rWOdSYcQ; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rWOdSYcQ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c69fa0b1f8so2945ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 10:16:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782235012; cv=none;
        d=google.com; s=arc-20260327;
        b=BL9ZdwOnwYKvEdeEcX3VyuhGxYBk3/yA+aA52qvr0GpifudEbK2FlPny54Ls9xnx0x
         CB1cfgJ5rAdZjm0UbbFGBtsbWgW25iF2w+mmtUwV5Zjnf39GipRdnoiMHb8w5F1cvAWY
         JILWcTl/1Eo9GDg7QJXUGwgzwTtAhEVtiJzHwqfevGqfRzVHM7egqf/x4D6bBfXhhyEf
         kW9QVcdIYa0tt6GekBR2cOORDFzmsKpQplK9ujnVR1UZ6PG185qbbmHH2liTKalzAnYm
         mRLk9nRYL5Pa3QLnWa2aYBmQD0p+79fc9IwOdDF+cVyV5V/1VgUPnrxy0G90R/rjSiuc
         DJtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8V8XmSTsxuXnjrPVNLI5LwVP6bo1s9Bz+C8FMG18Z54=;
        fh=MTb/KjYajXCezPOJZSpC6VOZWW9+LiEuvKdxfa9wWmg=;
        b=Zw4P/1TW6x1mywintCjr+Lt9SQbbVcQBLI9YPD4KmWCvO2c968B2XOe8R+YX6L4WdT
         9pwLQNTRWSMXR2ele+6AtTMxEGCRnUbIU6+6145hm125tV8wjtelRziyTinDn69r1IdN
         whAo3O63QfiaxZn6W6MbdBmKn0FFEQFjLQQY2Kf8or3SKm3i+tbc8/y4SvF4pqPEWJdS
         8XdxVcQqe/PMWKzaDGgqALKE13DQR7bLoN7juSUFADtaH/SWrc96GhWgOmei7UmZZSY9
         NmjjxoVSjEjS+C3BMs1Y+gKe3owKwu/ncirMXUZeXqork6t6xRzf37MdFmIMScdaeg77
         x8mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782235012; x=1782839812; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8V8XmSTsxuXnjrPVNLI5LwVP6bo1s9Bz+C8FMG18Z54=;
        b=rWOdSYcQRqxJ4SkiWSEygmXvf4MOatk6ekzsQvGYaxn96+tluU7WItGWWD+5Cc8DzI
         LV8ri2uCRJ9DAqllQCToVhrR+IbLJiTvg5mQ41tOYH5m+1/2d2KEr/qpCj5yKcsbbdIb
         wkOGbMnTLi2QhtjFMG4NkhvmCpZOQywzK7gdNhwOXvElnX3CbVeYSx8woU67JCTFoImE
         VNuN/+yhPnN/9YeRIfI9Knaly8AKBz0bsSy4fim6RPZ/wRe9YN09wNfllGl33nSnAsRX
         ZhcyA8Po4a0lxpJlZYueX5Y4+4+q+EOqwGEswcHqG9WmCF2A6/1s2RonMQNnXQ+3S4r2
         UDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782235012; x=1782839812;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8V8XmSTsxuXnjrPVNLI5LwVP6bo1s9Bz+C8FMG18Z54=;
        b=BCMwBBxh42Eu6N27i/v44syD27P445A2iAP18l8AOdPcVae+nCgsv1lEWb8pHBLvXE
         yZtt2HuDG0RpRO6E1fgrHITI2EKNjzrCTXX/rKiPRv//DMNOJPGFTTJXd4HAOlHght7e
         E7mjUK1uFC+dPRJE5+flNsyWJ5SagI5hX4M6V7WD/bcUR+JCAecnlaX0KeczZPtCS6Tm
         xyaZ9BABp/oviAFAWEspljOW9FQpr1LIKfnhEJTbftZA0YCBgruThJC18bdV3I7aA7wt
         hsuu09KeNpuZmx9aM47QEYyMsz9BzqlwKchl9jupfpkrGedjgOaV5C67M2Pt/HvtYfdo
         dQng==
X-Gm-Message-State: AOJu0YyZGdhbKVJpjDW9X41m77c2hR1pe/LHYGR0EmUCmWUElOP8S1F3
	z5JUAW8xGLlFrXFrOqgG1nv0DL7DHckY3PuSgqPk5jG13E7B37ppDWf97LtSDnFjVWUWnAKbMnS
	BWjuYZOiHH4VnEUUKqB8mN6Ftdqo+iivH31So3Uu7
X-Gm-Gg: AfdE7ck0c7UWjCiyfT1Gs9Y/wzroMv5gg5Chh+Gjxkzl+23E7f1TOnFKOiDwm0Jtpip
	C6mQWtPRg3VtaGbdMY8sQKK3eYgRjG4lc9Ca12dHeKBT1Kyl8cAZwgHIs+8UwdiEpmDU6bbbGRY
	kIWYJaVrpyP5CXMXJDM1r7mMGHD0UB/atCVOnX/BnF+ZghxN0FH6S2rsGqrGaNd0ic/LriGgbLv
	7iKQW5Lf5G78F7yAXe+Wdxlk3FkDH27IRY3HtgYVCI7fcsTPJmbe9/FqGcvAB9z3nCj0iCQNQ==
X-Received: by 2002:a17:902:f60e:b0:2b0:b0c9:96e2 with SMTP id
 d9443c01a7336-2c7e080f9edmr7995ad.21.1782235011263; Tue, 23 Jun 2026 10:16:51
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0f2cff983d79521e153d211ce412fedbc4ed942c.1782211518.git.sandipan.das@amd.com>
In-Reply-To: <0f2cff983d79521e153d211ce412fedbc4ed942c.1782211518.git.sandipan.das@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Jun 2026 10:16:40 -0700
X-Gm-Features: AVVi8CeH-QPUKKatnRpEeQ62Nrbd950T6a5bkATHYk_ePokt8Ba-7R7KOLnTdaU
Message-ID: <CAP-5=fVg-mjLj2v6Q2kXMBU26rn=CgZNyFE7O=-+ZuE90RC_8Q@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/amd/uncore: Add group validation
To: Sandipan Das <sandipan.das@amd.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Ananth Narayan <ananth.narayan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 3:49=E2=80=AFAM Sandipan Das <sandipan.das@amd.com>=
 wrote:
>
> The amd_uncore driver currently does not validate event groups and
> allows creation of groups with more events than the number of available
> hardware counters. Because of this, pmu->event_init() succeeds but
> counter assignment fails later in pmu->add() which returns -EBUSY once
> all counters are exhausted.
>
> Address this by introducing group validation in the pmu->event_init()
> path. Since the uncore PMUs have no per-event constraints and all
> counters of a PMU are interchangeable, validation is reduced to just
> counting the group members that target a PMU and ensuring that they fit
> within the available set of counters.
>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

This is great Sandipan! Thanks for addressing this! I'd been wondering
if in the perf tool if we could test hardware PMUs for not supporting
failing at open properly. This is a problem for weak groups, as used
by metrics, because they try to group all events and then break the
group when the open fails. I'd observed that AMD uncore events
supposedly opened but then failed during reading. I suspect other PMUs
also suffer this.

Peter mentioned a behavior in the past: opening events in a group in a
disabled state, with more events than counters, and then the software
enables and disables events in the group to control counter
allocation. The perf tool doesn't currently utilize this behavior but
I think it explains some of the Sashiko feedback.

Would it be possible to get a Fixes tag for stable backports?

Thanks,
Ian

> ---
>  arch/x86/events/amd/uncore.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
> index dbc00b6dd69e..9715cfb8cce3 100644
> --- a/arch/x86/events/amd/uncore.c
> +++ b/arch/x86/events/amd/uncore.c
> @@ -265,6 +265,29 @@ static void amd_uncore_del(struct perf_event *event,=
 int flags)
>         hwc->idx =3D -1;
>  }
>
> +static bool amd_uncore_group_valid(struct perf_event *event)
> +{
> +       struct amd_uncore_pmu *pmu =3D event_to_amd_uncore_pmu(event);
> +       struct perf_event *leader =3D event->group_leader;
> +       struct perf_event *sibling;
> +       int counters =3D 0;
> +
> +       /* Ignore software events as they do not occupy hardware counters=
 */
> +       if (leader->pmu =3D=3D event->pmu && !is_software_event(leader))
> +               counters++;
> +
> +       for_each_sibling_event(sibling, leader) {
> +               if (sibling->pmu =3D=3D event->pmu && !is_software_event(=
sibling))
> +                       counters++;
> +       }
> +
> +       /*
> +        * When pmu->event_init() is called, the event is yet to be linke=
d to
> +        * its leader's sibling list, so it is counted separately
> +        */
> +       return (counters + 1) <=3D pmu->num_counters;
> +}
> +
>  static int amd_uncore_event_init(struct perf_event *event)
>  {
>         struct amd_uncore_pmu *pmu;
> @@ -282,6 +305,15 @@ static int amd_uncore_event_init(struct perf_event *=
event)
>         if (!ctx)
>                 return -ENODEV;
>
> +       /*
> +        * Ensure that all events in a group can be scheduled together so=
 that
> +        * a failure can be reported at perf_event_open() time rather tha=
n
> +        * silently at pmu->add() time when no free counter is found
> +        */
> +       if (event->group_leader !=3D event &&
> +           !amd_uncore_group_valid(event))
> +               return -EINVAL;
> +
>         /*
>          * NB and Last level cache counters (MSRs) are shared across all =
cores
>          * that share the same NB / Last level cache.  On family 16h and =
below,
> --
> 2.53.0
>
