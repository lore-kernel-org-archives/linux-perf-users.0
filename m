Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FB43624C5
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 21:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789509445; cv=pass; b=KtCKJ8z13OUjZID2zr8/8M+SbJgIgf5JWqDF7GB85/CA6vezdNssi3JmfWTA6AgAeyVSJ1z9sZhjPQDyNn637gIVFRYEFdFw56Pxor/RpHwfQr6+sw24j6XLHxEGmvcGkEoSnNkql49KBL+gHkA8AoAbryuVs+AarnPdh2Fyrvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789509445; c=relaxed/simple;
	bh=B09UMPWh/F9lgVNS1GuZqMBkiWEj9ROYTWux+VQ0uNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dm5dhjQ60Fpp+zm8+ScaecUtxZFl5catsdKlJWsFEG+v1ioIp6VXy/RSdKs1aY4WGgu4gW0eqKjMpUaVM7RAKkiAtruj/rEls2n1OKO0EMMXoDyzHQcZ9gCZ8UFtjX3Y1FAAe+9uIpF8jY767ERAleHpn+aoxztai/mQ3lxNWqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e79rg3uo; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e79rg3uo"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530d5fc2cd8so32921cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 14:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789509442; cv=none;
        d=google.com; s=arc-20260327;
        b=YyHQBtqym1GWHYfFKeu026YOAqvqMjAyFJt0onwG3/2lHaQUt9zZEvnO0fhKWR4PTg
         u/eErhqr179GqwPavP9cMtEHntZoqp8NN0FDGHiqUa9b3i6QtXI7ctxg3J4U+PI87uSp
         tbTBsK7V/L4iGPij/kaTvY4Hy9yP2GQsIZQhinOURM46XDuhulcGRSX4ZxQZcJqwrEq0
         DFB5ihciEvnYXz6pQbmxJFawhHQv7rIERE92bZVWPyYxJUr8Z9p+Fmy8dfStsynXoMdD
         kXZC5Y6veggExDKIufBTslrXd860LmLtsSP1sOMxlV1LwRYb/loqRCy7w6FAkVOJSmas
         Jv1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z9uGtBRGXnZY424iSjz1/0UOFBlLVhJloiHB5FKGB/s=;
        fh=sPO6DnEZ3KGQ16S1RNFC/5zw0cE2Fie8YwARwUw+A6o=;
        b=bKPZrh4ifr8Af2PXDNEmZZnUMX2waPAt1+yA3puoMJ9qysqsRBtSknwhPS9gDwK4+N
         /7P9/UCJ9tkrHacqJz+5TQFmsi4T6iT/47O9F75gbQCRONjwuVeOjsBuYrDLCdJ8Shwh
         JRFQmCx+UU/nxNe6C0lP+QKGV8gss2oVLWOjFlAfQqx2GO3UpkQgDhqW4vCPqQihwEz+
         kkgucxZnsdBnreZOSJ20F4dFDImX8SgW/6Q/bZJWPhC90E7wEc3YnDmD/RNZ+e0t0xBd
         xBWfa2biUa5uKRTo599m+Sw1UFpDbmpxUAOdVVpIeNG+AeRFG8qyQQtnLahlUz+syqKM
         Xifw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789509442; x=1790114242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z9uGtBRGXnZY424iSjz1/0UOFBlLVhJloiHB5FKGB/s=;
        b=e79rg3uo4l25Rv9GovhL9mGagMY9nosc9EiDY+LPp5yPAsYS/YS7I9lUTjTTvbm5r3
         lPcY571ERevpCL9uJT1lbS1Ijus99jH8QpVNNcErBP9579XGnB85sK3d33LQhabI5Kcf
         WiNewxJMacITHubq5BDpceot9CMFA2oCDuUJcAzHlM8D5WIfgDW1OwX8wZJYtn/HEEcU
         fkcyq1uToXspaTDfs58NQDXLwZu0f2h0ZGO7cRZpNIuVgO7x5tQ/lGRwh5mO/TOXbaf9
         fozXHwpWlc7mbIWPxoSM7k0NP+sZi6MaoH6BY5I7WEdvr2H59ZBBIR3BnLxk3TR22yRn
         MOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789509442; x=1790114242;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z9uGtBRGXnZY424iSjz1/0UOFBlLVhJloiHB5FKGB/s=;
        b=1gJd9hNfGtispccu8nfrruiXgxSZmHL5Il2vRg73YQJk0axXYUSXTWMVuVpXhphlXi
         IQfLsQpKCSiA6R+O2x+WLfOacblajgbQ4z3R1cmVEk5LJVhPTKIq0kQrTNPVNDc7gJIp
         8CCMA7Rt6v/DSWT3wG4oiRQTUAU8bvHzI88ybDzBgdTwYpf1Vusq2fKfDffsxd3iDohu
         DvGyv6T50opDSkqWog0cp9sAiBYHZUGbeLSRVBTvGg1xn9QNDJlKNHfKW8/4sKE7X4hc
         hx9bHKecOrX22MhITKUoVRuW03TWezDZiLBMAgEkHV/LjcgKCmu7TjLoNEvLkic7DZXX
         IONQ==
X-Forwarded-Encrypted: i=1; AKwUvBy/oRFaHocHsnWGdCtamnBOY5/Mtj6rK3QVcM33YVN8S/oRV0hrx7JFmZLpTjZu+b0IZn0y1gdT7cFgwVXAaUw5@vger.kernel.org
X-Gm-Message-State: AFuF++nKojAPdCoPzOFN7W5xUqc7FCd6DwSoSyEBsXXT4KqX7HQff/Wg
	MeXkh8lsaa1pYk6ctF0cwbTzAVVS17XPb/krx5hGF2kCLhEOJtC9SdOBSTjRQZB+ngGQoA19k3n
	/Y1cvmucXi6CxJi42nAycHA8XhfUkT6NDpNrTSvsH
X-Gm-Gg: AYBFou2vxb2loF2Rf9pUZ0A6JcooZQv8TbRAJxuBpoK+JVpOUgha7rkvLRU9lItysMK
	/sGQlsxv8QOpYwURS6QL/x4sI29+70P0+mPPGSW2m5pp9hnFWByMScyVFlW7jGhMQBdwO5R0xYp
	qterPZZ97wwJFu79n3z9gorhWyVJPfMAuLmtPuhRHB7mgxGrCMmfMIgC6bjiW5a7mDdjFUJI1r5
	9JLZCx2putOioWgS08n8W7IjlVFiea1xBtGbVKAWhSYZJnUkYB6SvFHRRRoVceo2SFu+HNHdxTu
	DV5DdtRTz1jfeg+VssTu8FzzBBsG4Rm1Qy3TmzXfMCiUd0ZTIsACaPmK7D4qN0Fk27/n41h0e94
	AL4m3Frzk4g==
X-Received: by 2002:a05:622a:1486:b0:52f:8389:29e0 with SMTP id
 d75a77b69052e-5324676bdaemr5224271cf.0.1789509442044; Tue, 15 Sep 2026
 14:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_5A81C3E27E416B65341A899C62ADD6FF0D0A@qq.com> <8dd3659d-8395-49da-94c0-3f18880ead1f@linux.intel.com>
In-Reply-To: <8dd3659d-8395-49da-94c0-3f18880ead1f@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 14:57:10 -0700
X-Gm-Features: AcwNN1WxEywFYfwOJBptmCG3QDtYhtfOZ01mz34Ua51FH_hYVe15d-webU3R3vs
Message-ID: <CAP-5=fVhiB-shPhspmUzrid+JcUEXcE3pkqN6tSg=ECFZBx5Ow@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix lockdep warning in perf_event_throttle_group
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, mingo@redhat.com, peterz@infradead.org
Cc: Jianhui Zhou <jianhuizz@qq.com>, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, jonaszhou@zhaoxin.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+a945e9d15c8a49a7a7f0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 12:15=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.intel=
.com> wrote:
>
>
> On 11/12/2025 8:34 PM, Jianhui Zhou wrote:
> > When perf samples a tracepoint like trace_lock_acquire with high
> > frequency, it can trigger a WARN_ON in perf_event_throttle_group()
> > due to lockdep assertion failure in for_each_sibling_event().
> >
> > The issue is that for_each_sibling_event() requires either:
> > 1. Holding ctx->mutex, OR
> > 2. Having IRQs disabled (since ctx->lock is IRQ-safe)
> >
> > The call trace shows the problematic path:
> > futex_wake
> >   lock_acquire
> >     trace_lock_acquire
> >       perf_trace_lock_acquire
> >         perf_tp_event
> >           perf_swevent_event
> >             __perf_event_overflow
> >               __perf_event_account_interrupt
> >                 perf_event_throttle_group
> >                   for_each_sibling_event [WARN]
> >
> > In this tracepoint path, IRQs may be enabled and neither ctx->lock
> > nor ctx->mutex is held.
> >
> > The fix adds guard(irqsave)() protection around the sibling list
> > iteration in perf_event_throttle_group().
> >
> > Reported-by: syzbot+a945e9d15c8a49a7a7f0@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/69122cb3.a70a0220.22f260.00ff.GAE@g=
oogle.com/T/
> > Signed-off-by: Jianhui Zhou <jianhuizz@qq.com>
> > ---
> >  kernel/events/core.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 1fd347da9026..253c514e9452 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -2700,6 +2700,11 @@ static void perf_event_throttle_group(struct per=
f_event *event)
> >       struct perf_event *sibling, *leader =3D event->group_leader;
> >
> >       perf_event_throttle(leader);
> > +    /*
> > +     * Disable IRQs to protect sibling iteration; for_each_sibling_eve=
nt()
> > +     * needs ctx->mutex or IRQs off.
> > +     */
> > +     guard(irqsave)();
>
> This seems the simplest way to fix the issue although it may bring a slig=
ht
> overhead if hard irq is already disabled. Thanks.
>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

It seems this was never submitted, should it be?

Thanks,
Ian

> >       for_each_sibling_event(sibling, leader)
> >               perf_event_throttle(sibling);
> >  }
