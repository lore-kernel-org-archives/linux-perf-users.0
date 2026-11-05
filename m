Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905894;
	b=d5l2ZHhNcU+W/GUogaryhWhWblx/9Qm4XARP46EyB275lgWM1GR9I/ku9KDtyMh/F7F6
	 imRkmtA539d22E5cUJPQkAa40VJ/cSE9yEGU08X37B173aPX18UJpXG7Ek6KkfNLiNPb2
	 cQKYAI9mjMUKaDBu+Yt4oIJ1cyXy6ArHBXrKDUYOixiqMuFjEGkYW1jPGnFfAUF4Xq/ld
	 7nKssFc+r2wVMKLeLq7SS/d0TQKQ5m9OZFuc20YsMlG8he5w/lcC4XmH5IybPWBDfSfi3
	 yOw+UVBuZTtdKDxxYhuEBMs7RvgLUOhp/ItrJZuVBl9tNV/Pco+Q5uHJc3CcdTumV8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5xfLNd70a9iJW7TLASfq9ztkIr5MXc8aGM+GIXNOZK0=;
	b=YHhGtLoTW6NGyqOTOGbQy9+wP2Tp5ewiDrATEjKL77tihYbuqoTeERnJy792oq+XZx+M
	 JO26VTWl23Lprc1ctWXH6HfNJqhGDaTyhjbDnq/E92+6tt/KcMBFNAl5he6z3BcMAzXwW
	 eQR3QB1PK4H5CmmZfvZ+OUuTAKOdVqDTrKCl68gktoUUd6vlvYI8qGE4egTY8YRwreIRM
	 DKniiCiUJ6fpDlOV9+9ugm1JuQhioqsumFtdMifRwzOoj/1lrNV2h3U3/qYPKFjaHxdwW
	 KdPBx9SCu2Raf+QlrkWEzCpKwE2WOibLvBgMryNNDh7/rNV3jYN7zZ8+dSNgUDbfPxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gguh5mw1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E3B606A328
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 19:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08E3B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gguh5mw1
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so3689796a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 11:11:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793905892; cv=none;
        d=google.com; s=arc-20260327;
        b=mr0yf5eydo7kh1pIIkIz4UZrDgSKkdjNwwWQsRb2YzeaADuwaYHf52v2ztdu5Z4r0W
         uihYQdwiYQWcAMWd8/4LuSDo8eU4QpUxQal5rTNeLP/lF7c4+1bk1bqyyijow5/t4HXS
         wye9x9+7JXg1Mg8gsegEt0q9gj5xKxtVXrv9EKbmwujR1D0bl6ZqspCslMkPotb0fdcV
         1jqEvSj/+pVnbQnEIOs/0DAz8ujuOO30CWKypmqeP6YIUoskGbH5IDCnyChBrYdiZqIH
         aLbTyoCSsu7MH4z3KpOn9FsX5pdCN/sTh2JPTRY86yYlv5/Cls+V4d/DB+JL3y5kXvYW
         ITeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5xfLNd70a9iJW7TLASfq9ztkIr5MXc8aGM+GIXNOZK0=;
        fh=W9srbYR/+000SAUZ0fZlhJ/Zm1O1ImPXKbPHntT5O7M=;
        b=lh/0VQNKTRam1PRzOc2AnyqLji/88vaw6yJuFJMceQsloF8AjDDsbpcQEIu8UFtLRZ
         Up81ZWof/sjnlsD+7LHymyJPIz2DU52+2WgGTeQD3NuPyQZ9lu79hyqGbd/G24bPYjb/
         HK35Xs5FE86Igr8kHm+olL+VUbuIJn1dYmFRgj4/TP4GydShrFsTtL0LlDuPVJ3n3ae5
         07xGOHkqKdFHpnSJkMzXJ0wHcZtaWrAFxE9CssZ/ADOSeon3QwiOshx55IxBYvjcO2gI
         OxeNw6Im3W5kSNeUbRFfMZ5dgzXMjyQ+X1V5exrjYtrMkJuhNkg0L6yYROm5fnUTCezp
         zwag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793905892; x=1794510692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5xfLNd70a9iJW7TLASfq9ztkIr5MXc8aGM+GIXNOZK0=;
        b=Gguh5mw1KI6YBUsJFzC/Hk6S/1l0z07HBEw6ry59/x0/EYnGs0ARcmd8QeRIpPl7+l
         8+GtqlOVfnZgPU6qCcvm8TS/TrSF6HRjkRlfyeZ7DP9t/gFx/5AsNGKrUqcLLELImjMk
         jQF7OfOFBkOosjPUTcKF5dK/nqlYU/vlWYcWCQanUHsQJc2iFmjI/X5lXxs4Plx44UpS
         DD11gjLzF2dIHd/VA95jSZPWRigF7VX8NUE/7tS9Cx4gCnUUfxKUnWPHFmRRxeBK1lf5
         7wrdOP/98n3ig7v0ix0WPpWzGT94G1alpMDOGNjw66uBhuX7kHTfM1iPmbYkIUhDTKhj
         11sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793905892; x=1794510692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5xfLNd70a9iJW7TLASfq9ztkIr5MXc8aGM+GIXNOZK0=;
        b=s4QCORVAZjHFsKaKuqAXxvcEqXU6GIUG/JpCvnooRO70EMcskPZb/RfbzraAgT0J5y
         jOp1/9gVrxm6rgxYycBasL8X6f09sQc4inP7ybUMpSXf7hKBtCkKR7v2ZC4NA5elpyTn
         g1RgPOQ1ECWcsAvxbdQMncUOpMU/sEwSUgNCizIqo+5P/w18v5fmS5fjpRQDs7ALergy
         69eQHV5mAhEu5xURfuWL4M7+mho97Q2Qo7eLNvy6DwPZScpQd4UdX9+0+fpFBC7OcS8n
         +n78LAscZW7g+XbsWtn1xZ63in05p46mDyh5uo2hjo5zlRr7Zl027sv1KAYHUfwnoaWC
         OQyQ==
X-Forwarded-Encrypted: i=1; AKwUvBwoZLsMuhzLOWVt9ziDrfLNAZKHB1f758CsIjlxByryyPyY91tt0DAuz2E8mqgBydAREN540Hv4Z238GyonHZPA@vger.kernel.org
X-Gm-Message-State: APuU4Z9qipihPKtUrAp0gptcdtqX9QFsBP3fuJj5rXl/9rulikx78hwo
	hQLG9wA70fWSOK28lI+fvUxQ1ZHzSd/C4X4HSIYUcaD+/l1Z/52jcEkXVIq2NY8G4lWa+pk0wvn
	Q46QrKaSfhymvJW3RplkUg3h62hohBdc=
X-Gm-Gg: AYBFou2Y3CyeBYgIp3tKpntpefgNc9amEMaUY90PIQENbOntcwwRlI6bKbARlJkir0d
	0lFk0OqtR+nzo9jwTqMMdoE/aGMnolL5B9wGMf1fNSl5szVe+zF1ZBo5NGfhML0ady4ABHqI7B1
	8xu6OGjK+6m5BX9JS40qpwW+L0CXNje/nCb5ucLy+OVlwbZoNH7/58K4TpAUPVrdRLy/F3n0pMd
	zc7Bzw8f4b4/7qeN8SfcPQrpbBJnb4bq5rscnX87TaPK0wU0a7AlArFDy1l/Zt2U0iulPMu6z0A
	J8oFKvKe8SYNBUQrvXt2hyur+6iU7pKywYMS+MNsd+TaV00wypEsocIILHwzTnTIliUUo0OWZzR
	hQhyxApMMG70z1+jjl3bak5dDVLvtlttUzh+xKChwZ/FyOnMcn1pSaox5+0VetJKJQnomgiAZPN
	WE5eKOZOY94wzbiVfHcfuKyQ==
X-Received: by 2002:a05:6402:2742:b0:6b5:76be:62e0 with SMTP id
 4fb4d7f45d1cf-6b5977ef792mr143941a12.35.1793905892223; Thu, 05 Nov 2026
 11:11:32 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-alpha-profileme-v6-0-63362e9290a3@gmail.com> <20261104-alpha-profileme-v6-12-63362e9290a3@gmail.com>
In-Reply-To: <20261104-alpha-profileme-v6-12-63362e9290a3@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Thu, 5 Nov 2026 20:11:20 +0100
X-Gm-Features: AclHuK_C_Cie3ArOrjKqlHZt7jfTNl-4Nhbo7AW6B15vErDFBBi4J5x1cuUYTes
Message-ID: <CA+=Fv5SxHnUTDzV0R_E8KdiASOUijsSSgWFwmy=WmAdvUi3iOQ@mail.gmail.com>
Subject: Re: [PATCH v6 12/13] alpha/perf: sample only retired instructions for
 precise events
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

On Wed, Nov 4, 2026 at 7:49=E2=80=AFPM Matt Turner <mattst88@gmail.com> wro=
te:
>
> ProfileMe samples include instructions killed on a wrong path, which
> show up as hot spots in perf report although they did no work. On an
> EV7 loop with a randomly mispredicted branch, 19% of the samples were
> killed before being mapped and another 48% later.
>
> PEBS and AMD IBS op samples are of retired instructions only, so make
> precise_ip imply the retired filter, unless filters are given. The
> profileme bit still selects every sample. With cycles:p, both kinds of
> killed sample went to 0%.
>
> DTB miss samples, whose instruction is aborted, are then dropped too:
> cycles:p reports DTB hits only, and the misses need cpu/cycles,trapped/p.
>
> The kept samples carry the full period, as do those AMD IBS keeps when
> its swfilt discards others. So in frequency mode the sample rate, and
> the event count perf report estimates from the periods, fall by the
> share of killed instructions: to about a third on that loop.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/kernel/perf_event.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_even=
t.c
> index 32a8b5c98381..7e34eac0ea47 100644
> --- a/arch/alpha/kernel/perf_event.c
> +++ b/arch/alpha/kernel/perf_event.c
> @@ -837,6 +837,11 @@ static int __hw_perf_event_init(struct perf_event *e=
vent)
>         if (attr->config1 && !profileme)
>                 return -EINVAL;
>         hwc->config =3D attr->config1;
> +       /* As with PEBS, precise samples are of retired instructions. */
> +       if (attr->precise_ip && !attr->config1 &&
> +           !(attr->type =3D=3D PERF_TYPE_RAW &&
> +             (attr->config & ALPHA_PERF_CONFIG_PROFILEME)))
> +               hwc->config =3D ALPHA_PERF_CONFIG1_RETIRED;
>
>         if (attr->type =3D=3D PERF_TYPE_RAW &&
>             (attr->config & ALPHA_PERF_CONFIG_RANDOMIZE)) {
>
> --
> 2.55.0
>

All 77717 instructions:p samples I checked on my ES40 matched the
retired predicate. Using cpu/event=3D2,profileme=3D1/ gave me the
unfiltered view, including the DTB miss samples.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
