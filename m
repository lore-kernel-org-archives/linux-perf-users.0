Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793295525;
	b=JHIBaUEY9Nwf3g6WYIa4O9yFpnuYDqwffGP8RUjUD3g7SHEgB27q9vjHNKuodV5NU1uY
	 G2M4t5uTzerlvxmu9Ofcmtr5F1be8/kYaefuhdwvoWq4Z3CMALLsTIy3f+EdXw3RMThxR
	 Nwr451CH/HvVogQ4JyWr38hetogsuDD5GepOv1lcHQ2UNdU6v7TNGScAvEvwH8UKnYzJh
	 pp75sxB1awl3RyZ7qGX984GVUwEgakbLTPSKNJbKNurOj52dr7XO9MdsGTZzUYC32vlKo
	 XofXjFbqGHa06zdyvZmaYXzUp/LtYkJgHrsLeDcuZwZ0i0a+FdpUVsr+99a1aRnumKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793295525;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Jnb2ggFy/68cuPuLhBQIr9m8EgIXZTngDYovAtQO7jc=;
	b=GCsB3bU589UNJrz4QHzEjnP6qPwQpmetF9C8CKdnpcVFe757WxeguWFcGrUStnJM6TEM
	 sEG6wDoZKF8eXOnIO4DjifBdDu6rISG15t5kBrGUK34P/osocF2CGI4rAhoY4E4d9YZC8
	 4XD4VSOvGMHYXklbtZ/lLRvgL13ZJvFGOR92nSzZT5FCYGs7Cl84n7ciMwok3/zBadK4v
	 PYnoykfZoDHg+2TuRGqKlFxRke+jHl6A7JEGeTdZnwwDmq/hXuskDoq+Rs7UvTrsu90DA
	 fp11beJmqHFl6UZnpcUnKKLoGGReQNqjK3tYcO0fPM5fZsJNrixAhxoLHFc056hIH2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="WdOK/Nmn";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A7B606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 17:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4A7B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WdOK/Nmn
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b1f31c63ebso1690153a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 10:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793295523; cv=none;
        d=google.com; s=arc-20260327;
        b=akjYSSEUScifzcsnYfd2EYB2fkNQrpdYN5BVg6n65omcKpwV294xqiEgn5lNJFuJqs
         65Lh3Z6PU3kkJxR6UG2x+3P8+qglm+xs4UKJxcGxbQZml4ajBSVinE4E7B3PwVcGk8cW
         LXdN3rWLMOHfneJ/mp8Dxb3iovDz7PFQwrczbOezZD+VzrJou5rvzwMv+ig05b3KtYxx
         NAx5XFnTSlOgLatcia5RP3h0txbWdan5MCP8eu8L7sACAejALF3/ZNKth7T2cP1egx8s
         V96GHqTODn0disF7KO9PViv2uiAQQod7hxKZEoQYj9MXDGFNPlTQR/3smC84Ou86Jb+c
         o/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jnb2ggFy/68cuPuLhBQIr9m8EgIXZTngDYovAtQO7jc=;
        fh=W+2vrK3LnykK0w6kCqr8A3CGFZBO2IlJ3vpMa2L0D7s=;
        b=nj4cjowJFPz6W/RdblruDnT14SRkAPQ2rxlzIzX5I/CjP+KNup8T+4KLvkRt8CScIK
         AZOz+EaroXWEW4zP8bNyScZxsYfeBS9F0koC/HA1vxj1Itx+KOHNzzH+3NFdhRPn/fIH
         qF8s2doYKeVUcn/ud1Cd1np5Wa5NIKnGqis40mPNq/T2ggcCJtwoB9PpZ9zUFI8vEOzR
         8em5URBEYGU73cdsAm0HgqaCyPOJtn6ygVXN+E+fiSzsIO88eKGS7E8gsLblSC9H2oV4
         f3MP0tTeONzA0y42cjphygrjA3RvXlQGIG7XCp+FmBdGuEw1oG4AA1X0cwpxU9dhrkxy
         JI3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793295523; x=1793900323; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jnb2ggFy/68cuPuLhBQIr9m8EgIXZTngDYovAtQO7jc=;
        b=WdOK/NmnJj+0TX8YV8z1q/DKcXpxJQbfndklH5sBCCZuKZZkbRxchJkx3BGXfHQwEb
         DfNN7ahPHVpaGDCk+IdV+0yyCfm+HfbrkHuzDB0Fw3+jfFh0qKBRiEWWf75WrAAtkqeP
         f5KFxYFeqd1WGB/MQ46ddbDg6FGFHpWB91irCwQfFiim+dOMQTG4BKBI+xYsKwBDKOW1
         3NNofkg4yKoEiCQ33IC+d8JpnAi5vs1v7Foca1Liog7Lc7f2B/vRKWsJoh3Ttz5U7Qe4
         EHkh768OqJwGj3M0KwrRp/7JalebOMV6sdVb8MkYmw/2YYj3dCAh0EbaOW0rsCcXenS4
         TOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793295523; x=1793900323;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jnb2ggFy/68cuPuLhBQIr9m8EgIXZTngDYovAtQO7jc=;
        b=jXxZlhMBBQZBud8AKVMvE2dGlK5VnDD0y8f7mhTEQWNPJNur2Ve9n4PXXAwDl3jhxp
         /yQJ4QaiyF2y2gYgnYnFtX2v9B75+fJFQPDyPhKgg7mpun86bOOh2x47ukVOW4FeCcaf
         GeogJ0lgdpa1FAzPI/vYIhbGVU1hdB9lrLZv+183jNsBf2sWCTHYzGaXFMpJZ89Q64YV
         04p7aQt2hzCC+SShzEnu+GB8wBWk2p7rKBu3R3//5pswMLz675jpp5N0MkEgHls7sIEM
         2me8dTmyUvx7cGIJX3UQHTQYqyQL+FMSRFUfSdJH2Fm/ccXULBsGTqEkFxof0QyBFL/i
         0SJQ==
X-Forwarded-Encrypted: i=1; AKwUvByzvFt84hGhNH890+4R83P2XpCYl3HSTLtGLfQzzZuBpNbL4sNFI5Fc5JNJeZoPScPTj6lCA4hN9RhwTLIZ6Liw@vger.kernel.org
X-Gm-Message-State: AFq9FYK9jVBn5nfhsAdLHhdd/biO1HxyKA+z6Zro2WdrDctXoesEvpar
	MFr5vTPbGBN1Jl7Dcx+UauLlVMwL/ChwUGMex86LcQEMSK+gz6Q3tzsH9KCZFvyBmyy3AY/QSMM
	uYo5ssBV+1+wtaE19qCy8VAJX3Ut5fg8=
X-Gm-Gg: AYBFou3kykUEpknFjT/5I3OpwqDqujPTozC3GdVe3puQBB7J42ITBuauHDBsrh79HSg
	+ET96IFGnKwBhqOr3Y4mD7PqRcOVke2sUFA26AfS4X5x49QFghlITPe+XZI22d3yRHGz0zvydA3
	3DP48eE82ktCdRujN7PjofRNnquASQBMgHyRcChe2PrweM4ml0p3N2c1JRT+lI2R1dn2gO6PO9n
	N7VU0Lxm0aWCm08KQzlxAJHKhmjasXihA9+9v3VehUBovakTP4cdl95ZcHH7huC/SO7/ZmeTZdG
	lSu+QtTBGhO1ZvHUJP1sFE8xIrxdFP+YKexcXP3bmMVokZw+p5QY/pDWdKCcbcAeJy6+0Qm+D7T
	GcGSEyI0MeSGW4XAX7WGXt3y2eJLnfu3FvL4qWNDk0hB+zoEJgjSL86S1O90KM2wntcur
X-Received: by 2002:a17:907:3e19:b0:c48:a838:c17e with SMTP id
 a640c23a62f3a-c49d1307e11mr311139066b.14.1793295522951; Thu, 29 Oct 2026
 10:38:42 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028-alpha-profileme-v1-0-d44b52bf2500@gmail.com> <20261028-alpha-profileme-v1-1-d44b52bf2500@gmail.com>
In-Reply-To: <20261028-alpha-profileme-v1-1-d44b52bf2500@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Thu, 29 Oct 2026 18:38:31 +0100
X-Gm-Features: AclHuK-SY1_Xa-c9wgWP3q7LRAU1TLOJcpcznXRsfIIxmsCY3IoLxSzQH8m4NoQ
Message-ID: <CA+=Fv5TsDjMcd8+ZPPAXWzw-ox5yhvYJqiCBUfj-6Jm0Lxf9aA@mail.gmail.com>
Subject: Re: [PATCH 1/5] alpha/perf: pass PERFMON_CMD_LOGGING_ALL to the
 logging options call
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Wed, Oct 28, 2026 at 7:09=E2=80=AFPM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> alpha_pmu_enable() passes EV67_PCTR_MODE_AGGREGATE to
> PERFMON_CMD_LOGGING_OPTIONS. That constant is the counting mode bit for
> PCTR_CTL, which belongs in the PERFMON_CMD_DESIRED_EVENTS argument. The
> logging options call takes a flag in bit 0 where 0 means "count all
> processes". It works only because EV67_PCTR_MODE_AGGREGATE happens to be
> 0.
>
> Add a name for that argument and pass it instead. No functional change.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/include/asm/wrperfmon.h | 2 ++
>  arch/alpha/kernel/perf_event.c     | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/alpha/include/asm/wrperfmon.h b/arch/alpha/include/asm/=
wrperfmon.h
> index c97b82a1f7db..1fa9bc813263 100644
> --- a/arch/alpha/include/asm/wrperfmon.h
> +++ b/arch/alpha/include/asm/wrperfmon.h
> @@ -23,6 +23,8 @@
>  #define PERFMON_CMD_I_STAT 8
>  #define PERFMON_CMD_PMPC 9
>
> +/* PERFMON_CMD_LOGGING_OPTIONS arguments */
> +#define PERFMON_CMD_LOGGING_ALL 0

The Alpha Architecture Reference Manual, Table E-18 (page E-24),
describes bit 0 as:

  "set =3D log all processes"
  "clear =3D log only selected processes"

That appears opposite to the changelog's description of zero as
"count all processes". Is the manual incorrect for the PALcode
implementation we use?

This preserves the existing value, so there is no functional change,
but a short explanation would help reconcile the name and changelog
with the manual.


>
>  /* EV5/EV56/PCA56 Counters */
>  #define EV5_PCTR_0 (1UL<<0)
> diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_even=
t.c
> index a3eaab094ece..2d9383425357 100644
> --- a/arch/alpha/kernel/perf_event.c
> +++ b/arch/alpha/kernel/perf_event.c
> @@ -728,7 +728,7 @@ static void alpha_pmu_enable(struct pmu *pmu)
>                 maybe_change_configuration(cpuc);
>
>                 /* Start counting the desired events. */
> -               wrperfmon(PERFMON_CMD_LOGGING_OPTIONS, EV67_PCTR_MODE_AGG=
REGATE);
> +               wrperfmon(PERFMON_CMD_LOGGING_OPTIONS, PERFMON_CMD_LOGGIN=
G_ALL);
>                 wrperfmon(PERFMON_CMD_DESIRED_EVENTS, cpuc->config);
>                 wrperfmon(PERFMON_CMD_ENABLE, cpuc->idx_mask);
>         }
>
> --
> 2.55.0
>


WIll test this all later on my ES40

Magnus
