Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794264626;
	b=cfZBVeQXLtM791cXoMwniW5G1p4JX+FukHmH+7hTd3DJvCpr2FIPEcReYEN8uankTV4l
	 MBCKU30X1seSgXKP2Qkykio+qRghTzhoCFE0NBdFYQfgC2nUNkQpmCeY7ZZO9M1A6R0IG
	 rfAOym1J7BadYyXDpIubFV+b4UeTG+I/cgSk3p/lnkkYbFYgSSCNddXYBesDnxPzd3mPw
	 J3265jo11yjFYztM9JOebEx/H1mh+2WPb5gfiK+RKalMjUGFpp9DWqQt9+c2ESEk5M//t
	 GAcfz+BHJGHhh9h44o1tIF8FAQKvEIu37gO0kl3tMsMPwxpCU9OV63G0Htfu/rmxUZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264626;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6JVA+B8V5GYpRZnqFW1zVpWT3o7noCaTpT1OABug+5s=;
	b=syZ2J3C5gBbDSiWitE94AZ0Go7ifKb8NxddMwBrYcudBl0fAZXYVti+850w+xrQ8UUqL
	 Wi5M4joz3quBKWhZomDiCJ+esXVXDWeCtQWdwgOVTPjrcVi88MM7CKeKbFoH+7lCIY+ot
	 riU6jzfvqoCTO14vr2WMRhFZWqJ5e41oMmVOXfroPJ4EGoNqJR/MlnyBSRTY1bWPWlXs0
	 TpAOwSMiYPZIoJl7SoIT94ePP8ys2THMYkWsxExlLN8tFxjfGuHrNc/xFHwTGnWsjXpyQ
	 9y5vIE2Ae6ojBCnVnG/5GRI8JOzKACvPa2mgSadNPlG1Fz6zeWMsdx+QG+m8VU7kJug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kuBOCAoO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C8F606A321
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 22:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3C8F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kuBOCAoO
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso3098862a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 14:50:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794264624; cv=none;
        d=google.com; s=arc-20260327;
        b=eFiGyxrScQdwshPrmkMwxDClWZUmm9DjK2nBhaqC6lo5aRKW01OrEiE/kJnwgiIdWj
         gEN4IUzMEPhCDuKZleVSCwgPmO4Z8FzpT1mtpZORXm03AvDPiuIOB02LiD34UjlBtYyH
         i9mzD+4oXcXrZNni9uxmAxmoLDuvMAWlbFVx4du1Xx8OceHQdAeo/jbNHkig7v6P78qw
         DXGfY4CTlzPFjR5BvvFYkJBUGFx5X3QOZ8pgpUkMFn+Chw9ChcixFHHjgQKDz4BF+ZiB
         s2e5fnmP+SZblb27nIktaqPOOhCLh5NrCKCAkuIrly0t72hFWqZso7/1ZImD1LnQDwgr
         OiHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6JVA+B8V5GYpRZnqFW1zVpWT3o7noCaTpT1OABug+5s=;
        fh=A/o6gpZg7LObTF2uotwqMMUVgX7RtMrWf0NS/1+i/IM=;
        b=Wb61V8oxdEF202REI7NgWtPmFZnylUwSbo/HHC20+VgLvPf43v974N9riGoshrHo8t
         1SSwn7BHJ2aFBOIwHVkP+2OZLX0z/hy1Y7D1jOX9e9TFBfSqRcgauChusrM+2NjeCb7C
         hk90RjcJiJDcI5/hXz88EWNwpwqhxD7miaxoZsC6rFlc+wFIiwlQcUuG4X81EZUAw4xZ
         R4m7zSg+4hGV32xPHbdAoeSntwgnkCv+kkzgwpQ411e9SeWdkQehHe8azhnDVK3ZrfFl
         ZlC+dge0pLz7YDTuk9v4r8lwq44cRTMp/dtkjv3ZMH+RTCMTTLgCjJbEIQckVkmtotEQ
         bMQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794264624; x=1794869424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6JVA+B8V5GYpRZnqFW1zVpWT3o7noCaTpT1OABug+5s=;
        b=kuBOCAoOxBFc8wmNMTK6Rvj0bWKDAr6KPpBzFPPSGuFFp1mYUPa2WOvHHR6vcOMt4/
         mtbKq89PtpogcafK8HN4apLGDrHw14NOXbF6tqSlZOO/RY4Fo8eQibsE6qejuUpwCZSo
         HRy7HwB1PHp0zIiJKF/D82gmj0joofbd7TcLVU/HgIHw4SQASJwMmT+VFIFpMi3TqSL4
         r14EBOApL3zDWMk4M9+FCFJ2r3bH6u6D5XlqRCCRyyxtBmodUMR92L01XcFtgxAFIjeS
         ILXBCjP+kV3QAu8kYVKQ9bjxerpKSLEg4ox4WxzZAjFsYLdjRhWMO8vAPTdDrloJBgvR
         Rreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794264624; x=1794869424;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6JVA+B8V5GYpRZnqFW1zVpWT3o7noCaTpT1OABug+5s=;
        b=IlgImCN8I2cCeQwcPr6u+kslviJXrADqxQDsHTqZBRKaUaGM/TVxGp/uSIRVvDBixP
         +WZsVLFB9PweOvjuuAa7rcFjIPTMCpGRDqKS6QdkmH/ww1V5QV67tpYDXwIsHId4gJi/
         B6/qOvm2Un1gHhRP8hWAdSmXnu5BtpCrG0P9y5L4o8qCPfJppuKZrQFRTksYpHzBvsUu
         ZSgmDTVrs90lVNGV+CXkeKLjIxGve2C7OPmlsugrxqssEXSDNskZM4DFGtxwV1X6FL0f
         XkslBH1rJxNIpvdn+JgqWRfz8uvN0oaT3XunbejELCKBiZbHc6uUsnOuDF3i7poqvxN2
         c1GQ==
X-Forwarded-Encrypted: i=1; AL+hErHMqV+9VXoq0JXIsENe9bmbYZjfjNd4DZoKOIPYm0TXkz1sqTWQwTwR29fMs4V/Y5D8V7NTlpYXAhtWz4lLXgIa@vger.kernel.org
X-Gm-Message-State: APuU4Z8yTgysB/sFDq/5r/ftYMHumKevAkYv6sE6Qpzt//Fe3VeyUl5c
	QilWo/UfE19iQTyuCMGb9rFUiQVDxEoppLcwyYARcNVq96m9AcI0OjRPoNMFlyvUV/mlOC4aMWq
	JSr1vzBMhfEHkV2bEDaz7pG1bLxlse18=
X-Gm-Gg: AYBFou1MZfiNhS+xsCbJQFzhaNvijqbqwhy3kx3eZLYe0nBZKX0PLJRfdHt6Edh6X5c
	V+DLTftvu8wacGlxS42HDm1iFjr2aBzJX2jyQv1BkPV1ruvAXfsbcRX4nMGpGGgYI5FvzfEg/jK
	syD3WSUEcDW+wxNhzSmNT7wQO3mHFTYHFnZgmRjGswp9KBN0cfZ+HbY8Z39tEau6xBAfI3luAua
	5dCscn9Zo83PYJH3vgjUlwoVDbGfuaGUlsgnuVVt6z7+b5HnvPITb/6Cxm5ya7JeWlRa/mUrQMS
	xokdIpqHO0JfE/UzdCVTNw54U4DmjgIjTI0+kbnsa4HV/4bHkDx+rDeeoksE4QuS20zjxqdqNYs
	u9pS1BH4QA7QrQpvTgSAQ2ui+GIbwClMI8qiR6j6ueRPTzfvprZSW6iCILJr+t3oRwDNf2yLXF5
	jGvsm0jzbFE7IbMo4PNRYnlgA=
X-Received: by 2002:a05:6402:4402:b0:6b5:8625:d327 with SMTP id
 4fb4d7f45d1cf-6b7564bb8b0mr778506a12.8.1794264624107; Mon, 09 Nov 2026
 14:50:24 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-alpha-profileme-v7-0-c474e892abb0@gmail.com> <20261105-alpha-profileme-v7-1-c474e892abb0@gmail.com>
In-Reply-To: <20261105-alpha-profileme-v7-1-c474e892abb0@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 9 Nov 2026 23:50:12 +0100
X-Gm-Features: AclHuK8v5aBtIg32jclnjWJP3N3adwWeqdsURZmH27b0rZGwuLLEb1hb4knbBBY
Message-ID: <CA+=Fv5S8m3m6+UNJ-B-rT6AiQqkTnw0zLajJcGEcnFrAg7Z3wQ@mail.gmail.com>
Subject: Re: [PATCH v7 01/14] alpha/perf: do not update an event that has no
 counter in alpha_pmu_del()
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Michael Cree <mcree@orcon.net.nz>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Fri, Nov 6, 2026 at 5:30=E2=80=AFAM Matt Turner <mattst88@gmail.com> wro=
te:
>
> alpha_pmu_add() puts a new event on the list with current_idx set to
> PMC_NO_INDEX, and alpha_pmu_enable() assigns the counter later, through
> maybe_change_configuration(). Alpha has no group transaction callbacks,
> so the core schedules a group with the PMU disabled for the whole
> group. When a sibling does not fit, for example because the counters
> are multiplexed between groups, group_sched_in() rolls back the events
> it already added by calling alpha_pmu_del() on them, before the PMU is
> enabled again.
>
> alpha_pmu_del() then passes idx =3D=3D -1 to alpha_perf_event_update(),
> which indexes pmc_count_shift[], pmc_count_mask[] and pmc_max_period[]
> at -1, and it clears bit -1 of idx_mask, an undefined shift. On the
> EV67 PMU the entries before each array happen to make the computed
> delta zero, so the event's count survives, but only by luck of the
> struct layout.
>
> The event was never on a counter, so there is no count to absorb and no
> counter to turn off. Only remove it from the list.
>
> Fixes: 979f867191f8 ("alpha: implement HW performance events on the EV67 =
and later CPUs")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/kernel/perf_event.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_even=
t.c
> index a3eaab094ece..f77abeeb25b8 100644
> --- a/arch/alpha/kernel/perf_event.c
> +++ b/arch/alpha/kernel/perf_event.c
> @@ -506,11 +506,17 @@ static void alpha_pmu_del(struct perf_event *event,=
 int flags)
>                                         cpuc->current_idx[j];
>                         }
>The guard looks correct: an event rolled back before counter
assignment must be removed without updating or disabling a counter.

Tested on my three-CPU EV67 AlphaServer ES40. A two-event group
multiplexed against a standalone event counted monotonically, with
scaled instruction counts agreeing within 1% on all three CPUs.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
The guard looks correct: an event rolled back before counter
assignment must be removed without updating or disabling a counter.

Tested on my three-CPU EV67 AlphaServer ES40. A two-event group
multiplexed against a standalone event counted monotonically, with
scaled instruction counts agreeing within 1% on all three CPUs.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
> -                       /* Absorb the final count and turn off the event.=
 */
> -                       alpha_perf_event_update(event, hwc, idx, 0);
> -                       perf_event_update_userpage(event);
> +                       /*
> +                        * Absorb the final count and turn off the event,
> +                        * unless a failed group schedule rolled it back
> +                        * before it was given a counter.
> +                        */
> +                       if (idx !=3D PMC_NO_INDEX) {
> +                               alpha_perf_event_update(event, hwc, idx, =
0);
> +                               perf_event_update_userpage(event);
>
> -                       cpuc->idx_mask &=3D ~(1UL<<idx);
> +                               cpuc->idx_mask &=3D ~(1UL<<idx);
> +                       }
>                         cpuc->n_events--;
>                         break;
>                 }
>
> --
> 2.55.0
>

I think my reply to this patch was accidental off-list, sending it again:

The guard looks correct: an event rolled back before counter
assignment must be removed without updating or disabling a counter.

Tested on my three-CPU EV67 AlphaServer ES40. A two-event group
multiplexed against a standalone event counted monotonically, with
scaled instruction counts agreeing within 1% on all three CPUs.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
