Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FCC36C0CB
	for <linux-perf-users@vger.kernel.org>; Wed,  6 May 2026 07:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051073; cv=pass; b=f0AekRwGHwKVWCJqfQ9oLtWtDeX/1dsh0mojbLODfQLoVog2qY8jFDnonje9H0drFGlY1CaGH5q/FAaldymiqCzR+hszU9B8o5k7PnbEJa1cJonU/GorxqmeukHiCxiQ1pnV5LVBlp84SIsh3dJOeca2YUa9OJ+onquCp+JUyyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051073; c=relaxed/simple;
	bh=ssFSspPkI/ZVkAske6pW54q8l5QUCB7qB+KlWa5BVuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqU/LYmEshbLCF6LuHNAeWq2XXZsdd6ZbNjwncwsTDLPmlpQImQZDIsvp2OyOLczMOB0oEgxoQNO1S1x4yBt+bjoPvcDgcmr7zjt5Q6+fq13P2KO6DC8Jdwerbfnul8bQAggueANVC9Ty2M3goCj2HeVzQO0wc75eWl982/jeCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVEW81Ua; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVEW81Ua"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-40f1a1f77a6so4797192fac.2
        for <linux-perf-users@vger.kernel.org>; Wed, 06 May 2026 00:04:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778051071; cv=none;
        d=google.com; s=arc-20240605;
        b=BneM9TrvcZZKEDIO8Iesu5xDnN4zg8vJWGUxfY8O0yRtgLmxZKes2lQlsJ5SA8TZWO
         u3AxhS2UJPE8KB7khyTVmXYkGqScknQNLZcOP8IjjANwJmW9rxdVXApJhpXGJFVGXgyd
         vIsdeRVtrPkBitiOf60yUwHZXfIodpwPde0b5CkfyN/dFTjOr3OjGRJss9ldbJUpYmqI
         tqjUVyVNOM2cwnUrPvQHndYssC7yY6qX7yl0Y5JIIKFzS51W8l3PGxTuB7QjO9+295OM
         5zblSmfL5eOEGrFeznrahGEHstt94fR7bsIY19M91JcGQzprndY3Pc/u4El9VExqRIcT
         sFSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YFgyP3bTzum2n+ShJZRbTnBUvnnZ+xO2mUQjUayQ0co=;
        fh=hzProQfyJfe3OJ4b2/Pe34vrQwrXOA9QjKYVolRg4zg=;
        b=b4QxtsZvxi3SaU79AeqgEf7v/XXP5q1+qI6cyObRq/UiUbH+Xe8p8bXf8CONdDJgUn
         /UX356Uk0fgsZ+TghCkHs5T5Pfr+6gh9H9U/GoilM41u8qq8Fbfp7Xm3icWwAGqTqx9x
         JkUZCgKLOIaFkq/YfOncEU7fBsit8IFc9nluqjboeWorbDNI5s2+p1f0zpHOIAkAGcqU
         IB4g/3lEPG7Z5Kkc1aw4pfWEyU9mJxSY8JjGrK2M5By/3FgISj+AyWzuOfTXZKMJStye
         CUNn8nadwpffQVPb92GOdww2GxmX0VlZEyTWUya8TG7Tjeo5e61pDNGFjnGHOJFAZJkB
         Nr5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778051071; x=1778655871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YFgyP3bTzum2n+ShJZRbTnBUvnnZ+xO2mUQjUayQ0co=;
        b=aVEW81UaAR9DQibUUrbfNTCuF9xAD0LNd226+lepCSczZ+ZYU+S6nD8GxLv0LNqh2G
         G07R/+xPKILUwCrOV7a3eDt+EaNW4j4MVAxUiVGDcMZlekq3QEdnT2U2EDjifIeSi1x+
         jLk2FH2OGQP1/hPxh8RlEXcbuk8fd9C0cvyOxSErehODpUpip1ur7Go2yzF5+Md5nyWO
         LfqXKT/kA69roYbkUGhUnSV4oFVREUUekg1rxf6Fx8t7Hg/FXnOmHia7coWE2vdRgJVg
         67ytz7whFBdXItAgpYWwwfh82IpAwMtuXTf4d7MWIhzXi94hz8to7DX6wpmGaTpRCF7Q
         Bdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778051071; x=1778655871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFgyP3bTzum2n+ShJZRbTnBUvnnZ+xO2mUQjUayQ0co=;
        b=sIjH9csMClwl4U0m3h6eSvydbiaM0E0Y6SpCNf4B4UKAUux8N2zSRRpeT4EthA2/hU
         BCts9jszTHtvqd8U3gxJV/0b4yVwklk3ZfPFX/tzzvj2WY5Y8QzxLJzvZHuwgCNqK4FD
         iHN4eWA0WdN3+vTVNaEoEGsRtggdXQJp8goN8n+zJgYLiCMrMmnGhFk5MiI4b+XcTvq4
         laqy+3igR646uslVg0p8BwVa3MISkuiav+OB+HnEg/tlHUXybRAUGmrZ0lOmwnuS31TH
         E14p4v2jAiaNxB/rH7JyrtwQoDJ/Nmjn+nIYIPre7i3Ijr2qZHEahxiUtZ7XD5VEFFoE
         gWBA==
X-Forwarded-Encrypted: i=1; AFNElJ8wTCkHkvlnR4FWqYHkocmKmwxsdnnTUMNXSWok3tg1mDe8g0gG5QQJEeAaPoKrCS+y77YiGhOD2qPECtQMfdnw@vger.kernel.org
X-Gm-Message-State: AOJu0YwUcoCw2OGctVBRRyBfiDqpuzJQnqxadrMOH/vKVw97xTvJpczZ
	1H98E8RbH1bdFZwxogfKcNL5pso0fyt/Wyo2i/fpbaU+6GipQzVwXqkEs4DrTL1249OxFF523xY
	/3lTEncXaI2yqa+NxGCfH7NHr+eoTqSk=
X-Gm-Gg: AeBDievRP1xcb0XQcp3e6AC/7JD6zR9XTdUDLJjCIqz35w9JRV3/AXU+rPhn3Oza2PQ
	DqTT9zMhbr6WO5H7nmNrK3+dtQD/MVG9kgdznS+kgusBDnqAe0k2RPdLMQFuBNKEZWo079SvKrX
	O9lUBvitkQfrf4isihjWAvmBP7VZdHbuWj804tgRR69fk9nzN/2N4VJDgMzkWtNUTQZVioV2xQ0
	w19bZCdz6iAN2i9JLZcKaAN41qI4fTjLTsmq5T3GXvPDZdqdE2HZOdSUc+/daQbsRPwZH2mTAl3
	w1e5wPrqn3wCT5h4+Sl9f7dvo+k=
X-Received: by 2002:a05:6870:56a9:b0:3d9:2fe2:f5c8 with SMTP id
 586e51a60fabf-434f66c4375mr1629496fac.32.1778051070929; Wed, 06 May 2026
 00:04:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504135138.17050-1-suchitkarunakaran@gmail.com>
 <20260504172338.6FA50C2BCB8@smtp.kernel.org> <afpwnf5VfjxBgIhS@google.com>
In-Reply-To: <afpwnf5VfjxBgIhS@google.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Wed, 6 May 2026 12:34:20 +0530
X-Gm-Features: AVHnY4INiEqN-KWsg1sOGfy8sVSRnDlqIQwTNbQlo9Jl86AgtqsiN2NjxhytRD8
Message-ID: <CAO9wTFjS85h8DvgsfifGkaTJUMe=Etqto26pqf+wsgQbgvS+rA@mail.gmail.com>
Subject: Re: [PATCH RESEND] perf/lock: Fix non-atomic max/time and min_time
 updates in contention_data
To: Namhyung Kim <namhyung@kernel.org>
Cc: sashiko@lists.linux.dev, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Namhyung,

On Wed, 6 May 2026 at 04:05, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Mon, May 04, 2026 at 05:23:37PM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Low] The use of `__sync_val_compare_and_swap` introduces a compiler dependency on BPF ISA v3, breaking the `perf` tool build on older toolchains.
> > --
> >
> > commit 30820839a2cfcfa987fbc2e0f79fa0e2f2cf0dc3
> > Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> >
> > perf/lock: Fix non-atomic max/time and min_time updates in contention_data
> >
> > This commit replaces bare conditional assignments with a bpf_loop()-based CAS
> > retry loop to fix non-atomic updates of max_time and min_time.
> >
> > > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > > index 96e7d853b9edf..5c8431be674ac 100644
> > > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > [ ... ]
> > > @@ -486,16 +493,49 @@ static inline s32 get_owner_stack_id(u64 *stacktrace)
> > >     return -1;
> > >  }
> > >
> > > +static long cas_min_max_cb(u64 idx, void *arg)
> > > +{
> > > +   struct cas_ctx *ctx = arg;
> > > +
> > > +   if (!ctx->max_done) {
> > > +           u64 old_max = ctx->data->max_time;
> > > +           if (old_max >= ctx->duration) {
> > > +                   ctx->max_done = 1;
> > > +           } else {
> > > +                   u64 r = __sync_val_compare_and_swap(
> > > +                           &ctx->data->max_time, old_max, ctx->duration);
> >
> > Does this cause build failures on older toolchains?
> >
> > The built-in __sync_val_compare_and_swap lowers to the BPF_CMPXCHG
> > instruction, which requires BPF CPU v3 (-mcpu=v3).
>
> Hmm.. this looks like a real concern.  We could add -mcpu=v3 to the
> compiler option, but then there would be compatibility issues with old
> kernels.  It seems it's added in v5.1 kernel and the oldest longterm
> support kernel version is 5.10.  So I think it's fine to add it.
>
> Could you please update the build flag as well?  It can be a separate
> commit.
>
> Thanks,
> Namhyung
>
> >

Sure, I'll send a patch for that as well.
