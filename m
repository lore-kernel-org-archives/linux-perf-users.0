Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795458465;
	b=tmL5vTLN9mdbPS/03P/UuGYhF04UGkaSra0Tsl34n5flRiaxjzjc5HJhRaP8U75p35PS
	 qJq1yMz9dMHKYMc2mQwS/P0jdF8a1fLoDYZaS45hodgL7D+J1jU8v/fscd507lnttztWp
	 DCvcvf1YMKRUoY3yLmX0+zDhcU5ryZEpply6+mO5hWBSpM1AkmbRGhblkXD5SdJgIOwFt
	 up2KuHoEHhlOr1HNziFdc17/p7VxlJhgu+g56NrIbpIECTYRGbgh37K6B/dsOVv187dEy
	 D2uirHDer21KxTR9qp5YrsBO5CV8Tc1IlAUsQcEwqOL0k9WsF3J3dBTQu97cX0OF11A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mv59fVvaG8+1uwanG9a9AV3qrfmi8QzYRDjJgUgr+zg=;
	b=p/BMRfco3SYVaF+L1CsJDWRJv24+R2BFgrmgfa93TCZ3VdUvlL0thOFBkyUtgC62N2+K
	 3ht2DCOPCtW/fdgjHpoMk3QIqD+FO9EqvGQk9/W0yqjOkPS2qHg+X7aVNKQ1vwnFCSQ21
	 OoFYrfKX6Eo+dk9lQLwTMozWtwW6TUDKaU4EIFDsSYRnXZCFKiyeYnKUnwjQPdhQgMF1y
	 En9+IiJ1PZQlfaZHz49k9b621RKeYO99WyymLqyXi9wYfL6QsC1dw3i/4tCYZ9EdzdRJV
	 +AI6979clA9nNr84XbNDzjLSn6hujr61JsTkWDqKpplcWJkLYXvg9cw3eVM011Kc7RA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HW+YiFhw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D066606A31E
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 18:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D066606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HW+YiFhw
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-54492d8a988so574511cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 10:27:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795458464; cv=none;
        d=google.com; s=arc-20260327;
        b=Bvu457qNrHfnthMSDoinI4x+WblEMYag0iVkRbulkLz2ZmCRlJ9C5mvoCLuyXigzUj
         FOYtLbCjj23gcrJML7QCaiZgL0ooR/QHf8Ss0PeP7rWeW/SADz16myPRzvrSgVYdyFeh
         TNR9nO0E9LMozyDRGt5MAtsgWEacHcZdqsCyNvRK81BtX53MRlCRrHHEqFKFDWbiNieO
         yMPoKtAmoR8a8OXs9SB4AYMmLqlNojLrrJBz78NLgZfoK8aIBcuSe9OTRunMaRULkOAD
         Qy98hnWb7wv8U8aZkpVzFZOHyt++oiriXZJhDNbSB5nAngYdgsi+DiRGsaibLDwsOr4S
         Xisw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mv59fVvaG8+1uwanG9a9AV3qrfmi8QzYRDjJgUgr+zg=;
        fh=sm6Ey8W6CcqODGblgQm0zgB/Zr5TyepSbKP3RsYbCNA=;
        b=Io8pvb5ZxrkNYhMUw/axcYqVERuxzsvsOaidy+6bciYEBzeBgKxgCSldetBg/G2C4f
         Cj+tUB7xq8j5cd2iK5CTSdaluBslUPyhIAlfMdJzyGrRsp46rRw1uAaSx3QPu/xm2Awx
         uzfDZTmrH+bYoNJjguHQyKNTPnrQDKAlWo6XFl+uIt8heThZfj0+3j7a3JMwhkuo4ALz
         MKlPcirsopIDViFP153PYcTkniU8efJnbdQLfQD7qbOcMfwkue+fIuc/+/pJvZ5Dusx/
         txSeTdUQIPnno0COvL8fAPn2fUm7G7JK6rAZqOf0c7H270aeC5pNahi9LaltxQWEK2gD
         pVHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795458464; x=1796063264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mv59fVvaG8+1uwanG9a9AV3qrfmi8QzYRDjJgUgr+zg=;
        b=HW+YiFhwv7IxT2ad7gPZ/RR6jjeN6wZI2Aa0/UsnF7Jqo5otvkv5YXOWxzab0C0oPA
         WfiyRxlfVVq8PbrRBI5tBlH4jHBm+V88xLgAT3Fyp4E3u0Pm1zVXWuqfZp+s3W5J0DwO
         lyI5kcxGqdx0l2Cz9THrLsUgo0MGAeD70MstlEpKcR9tD/6iG3Smw1Z3nJVuzLJVIY3r
         rsjfp5reIgeJ/pWWnhQvj+h7Y5FvlebTs66BkuAwek1prpTIdwuGf3mpMBYjPhJbwJXr
         JBJuBTm73q1cGi7PUzA95q8nEAK5q4zZgOnxvjaoM0DbYjRKwOPMLjEjUwAMwXW9UQbf
         9rXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795458464; x=1796063264;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mv59fVvaG8+1uwanG9a9AV3qrfmi8QzYRDjJgUgr+zg=;
        b=FcFXPsMs7xMfDoiTiPYHyG10toWXWD0dScSE4sZBHRV2A7wop3jloKrkxXp6msBSu4
         2bqgxB1y3fq97GCRKoX5XqYduMAuO7WuNTjmBahKZZj9bT1Fm258Hm+2bj5sSQ3ZT7BC
         c3zmIDn0SShFUkjIxoJauGA6dcAu4NHerOzsRuAh3VXkOvC8PIHwlxlrQ5JOsRvKmRpS
         pXEO4ZwBtVri9HQ2mmjp5ZYnfC0hmA4jZ2H77I8oBoon5nSnRok0YSEfGiFuCKqRFrvj
         r5/Y0ueJN1V1VbWy4zxFLAbYZYEUwSVp6sufaHL0v2iTf5iy1J3m/k964u2ITFohqkkv
         tIoA==
X-Forwarded-Encrypted: i=1; AL+hErGkCixb0ZyCKZJc40tuZFVJ/vrl9Q8LnGUvvfQwfnZ16AmWVHbvhhIN5bjnVLXV/e1ceVqXakvtWd6mvkYUClQf@vger.kernel.org
X-Gm-Message-State: APuU4Z+YbSruFUK/WBRs+c+5/FbBqlu3pHAGucfzrr6TMjYhS/igmKYM
	TDWELzgFchR41YA2aqI8C0VnhTz7meBD2giccr+4SL7ohEpd8KwyM8K9b8wEWJoSchqrhnzRSOP
	mjklUb8jGOERT2eoQu4f2LluS794FfaJXb+Jb/8ve
X-Gm-Gg: AZFdTZdFn7/Hq/eid5mvodqaHrX2YB1xHSGCGz18Mlz3ZUVAXQJX0Eji0Yt2MhWYDtP
	4/WTFbceSFL/z2pfYVzaWYsCV7lWCRgs7pPCyKYULZ44fpkBhjpZrnuuhEPznGaFUy3uQHOTIWQ
	dTjzJ2ndJ3Foq5e0dq6svI+le9hv36gYM7AY+kRNECaaAXyUk3mv8FBkvyBoBmfKPGbKiU2MD6y
	i3OMvONJURHvKPwe/ywNAjC4j4YhKyADKFcjPg8CrHOT4zJiZrDVBUGJZJw50iwreJBdFwatcpO
	+PiUIPjOdO/ySjF5LxXxTLnTuN0VThZRKpGtorj6pQY3Habcc8fKjA6g9kztjA6fc3EvETfbb9x
	Pglc5sq6TdNnLyTncNqBU26AGQrIISRkAw62jyA==
X-Received: by 2002:a05:622a:994:b0:531:282:6560 with SMTP id
 d75a77b69052e-55d8906adc4mr41086201cf.15.1795458463690; Mon, 23 Nov 2026
 10:27:43 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113074125.4146687-1-aaupov@fb.com> <20261123175540.GE9176@e132581.arm.com>
In-Reply-To: <20261123175540.GE9176@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Nov 2026 10:27:32 -0800
X-Gm-Features: Aa3M54rkqvnpPz0DiXLf5e18ONtq5tQbgbU2y6PXCXZ-S06Dd1ce403DsJ35cTM
Message-ID: <CAP-5=fXh9zDsh6J=oyDKmxLVsOw-CA4vDYu4589eLdxLsOav4A@mail.gmail.com>
Subject: Re: [RFC] perf: SW strobing for AUX trace windows
To: Leo Yan <leo.yan@arm.com>
Cc: Amir Ayupov <aaupov@fb.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 9:55=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On Thu, Nov 12, 2026 at 11:41:18PM -0800, Amir Ayupov wrote:
>
> [...]
>
> > pmu_pulse (coresight-only)
> > ----------------------------------------------
> >
> > The first attempt was to try to avoid perf/core entirely, and extend
> > a coresight config with pulsing ETE external output on every cycle
> > while tracing is enabled [1]. This way, pause event on TRCEXTOUTn
> > ends the window after exacly N traced cycles. The use of ETE external
> > output is pure coincidence, just a way to count cycles only while
> > tracing is enabled.
> >
> > However, the review has raised that the config is not self-contained
> > and requires a lot of checks to only enable it on capable HW:
> > - needs a helper in the arm64 PMUv3 header and a move of PMU
> >   definitions - needs arm64 maintainer's approval;
> > - only works on ETE whose PMU counts TRCEXTOUTn,
> > - the window is always measured in traced cycles;
> > - is restricted to ETM, doesn't help Intel PT,
> > - the further it is from a pure config change, the less understanding
> >   I have to support the patch series further.
> >
> > I decided to abandon that approach and ask for a better/more general
> > solution, hence this RFC.
>
> I saw you have sent CoreSight and PMU pulse v6, I will review it.
> It is a good improvement for me.
>
> > Option 3: cross-event "arming" (attr.aux_pause_armed)
> > ---------------------------------------------------------------------
> >
> > This extends aux-action with a new bit (aux_pause_armed):
> > - aux pause event period is set in an overflow of aux resume in group,
> > - restarts from the full period,
> > - on overflow, pauses aux tracing:
> >
> > This is the most flexible and general solution:
> > ```
> >   # resume every 10M cycles, trace 5000 cycles
> >   -e '{cs_etm/aux-action=3Dstart-paused/,
> >        cycles/aux-action=3Dresume,period=3D10000000/,
> >        cycles/aux-action=3Dpause-armed,period=3D5000,call-graph=3Dfp/}'
> >
> >   # resume on page faults, trace 100k instructions
> >   -e '{intel_pt/aux-action=3Dstart-paused/,
> >        page-faults/aux-action=3Dresume/,
> >        instructions/aux-action=3Dpause-armed,period=3D100000/}'
> > ```
>
> I am just wandering if we can extend a bit "aux-action" syntax to
> support delta value, something like:
>
>   -e '{cs_etm/aux-action=3Dstart-paused/,
>        cycles/aux-action=3Dresume,period=3D10000000/,
>        cycles/aux-action=3Dpause,period=3D+5000,call-graph=3Dfp/}'
>
> The + symbol indicates that the pause event occurs 5,000 cycles after
> the resume event.
>
> > Cons:
> > 1. the core has to keep a disarmed event stopped across group
> > scheduling, throttling, ioc_period, power mgmt.
> > 2. rearming happens in the overflow handler (in NMI/IRQ).
> > 3. Software pause events are not supported.
>
> Why here software pause event cannot be supported?
>
> > Question
> > ---------
> >
> > Does it sound reasonable for perf to support this, or it's better
> > to pursue pt/coresight-specific solutions? In the end, my use case
> > is about tracing.
>
> I think you are asking perf core maintainers to explore a proper way to
> move forward. If no feedback, it is good to send RFC series to
> demonstrate idea if you have a preference.
>
> > If yes, which option is preferable?
> > - Option 1 with restoring first period behavior that was already there,
> > - option 2 as cleaner fix,
> > - option 3 as completely general but with more core state to track,
> > - something else?
>
> Seems to me, if we extend a bit with "+" syntax, this can be general
> enough to benefit all AUX trace. And we don't need to introduce extra
> new interface.

Sorry, I hadn't seen the original email but this reply popped it up
the list. Could we extend the (BPF) filter format to support this use
case? Or maybe there is an overlap with the auto counter reload
extensions on Intel.

Thanks,
Ian

> Thanks,
> Leo
