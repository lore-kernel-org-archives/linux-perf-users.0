Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793692012;
	b=J/UDhFJMWXB2N/loinuFeNsmxQsETmO/ygtgi5iPzz32HxTsMugW5v+1CRb/dpuAXK8Q
	 6oYNsPSrx/ucsPcHzZVF3a4LlUliDiPAhRUs3ocXThE8lan/4E82UMxgGQtCOpslQQrkO
	 QMMP77g2dqcmVEa1bAlZ70kI0cUCIksioTgbkC8DkImjC0i2quihJbSc7GmYnSBYtVEyu
	 aTsTGfTatFRBF1pxsxiVHkTgvBshbFTyRwUTLhEy1hqN5JI4ceTeY0+f+mLOE53Bfzc7g
	 i0pmfYPO1dlEJ78Nrciti9+2qTC8FR9YfdSNRwATha5VBSx4e9EGthHd44kreFBCuHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8QBB6SDvL82bQ+9NTShsWyttaad3ZVjOHNfU0QwklhE=;
	b=lAFmv4yx+wBtzS1tRafbGGGbI0Yc3brz28uzKv32L2tlkGDVg5NtzDPvm9SGpiIvwgoL
	 HflfHZIXiGmYlRIIlBN/5Ba6wt1ShJ9cbzBwYQqGPna+OpQreALT4vaw4s+i/rTsTv1Mp
	 6YT4ujeb6WoKk7tXvpYt6srpdSuZZjbQfWQvBRsXcqeVkgF2eJ5SniEJwMURvTwnY6Qed
	 Db/98oVxJNC9eETeBNyMTG9d05X1Z/+T4haSpsml+46k9BGG9iqH3dMqd8swCXcs3wDUE
	 7tTTiEOI69et/uNiyHIRMYjn/PGL2DI8MOgkqhBTFZ1nOEHgeqWhYcvsoISvolsVQ7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JoObrpEZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47678606A329
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 07:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47678606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JoObrpEZ
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67999045530so3248180d50.1
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 23:46:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793692011; cv=none;
        d=google.com; s=arc-20260327;
        b=k6eatgN99Hbo832x5X2D39eXIi/oZjIRRj5t4/N0EnaNfh4BcTOO6ZsZV3usxQ4qnb
         VfWAg3Vqo6WPnGMscM8OE2YLF/xsyw4o+13zRJp1VjqF+AsvnZ+SZ/uGSvhha0DxVllB
         xSJDiGrJvfyo7tHz5t5HmL994FneYdNMkBXRnzZHW/yifbuIMOPBXT2W/25zS3TL7kdI
         Ef7OhChYipwSYxpBsx4fhFhYecIsXehC9lnRKPC4fkikaEK3qRdv48sZf33GoPvtcIjF
         ImhSG3v7oVf3u8mqZXJyo8/SSHynDLz6G0BTIh0taIjSuQpN2iQZbIO/4o56ZfXNAjs+
         grIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8QBB6SDvL82bQ+9NTShsWyttaad3ZVjOHNfU0QwklhE=;
        fh=q9JTcMDyMi3ldSJu7NZRi3uZNf/8AtPO4tKje5gHEIk=;
        b=SnMlPiE7W8lzWOvCNKxeSDi/oI57XsbMCbxIxi3jqhZ5yXteAiiQzkfOVUZSclxuJj
         HB5gGjwL86NlzEfTzHsZaI22eSykBTy/pCdICUPhHABOktPM8L8JrVnHXpCq0Nf+TkIf
         bww1GXL+oL6yGXOb92ffRl5ZWFGWwcR2kYpgKC5yDpa8kifOGIRUDnFIxOQETQMqKjK9
         XAT5vW/X5Vqow5/fFv1w09N/9JHEbZuNxjQuxCSNl8ZKEapJ/HVva1hxXudmqUst/WE2
         bujsbv7LRYXaoP6hE+GaXyIF+MpifNhSBQf0Fw5RugdrSQS8VPw9NIvQVykUa3a2gQ53
         /e1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793692011; x=1794296811; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8QBB6SDvL82bQ+9NTShsWyttaad3ZVjOHNfU0QwklhE=;
        b=JoObrpEZLzoADc7vD7Bvwr5FOjMe2z2qyfiWuB5TZ6HoTdsGXNds3QjmcunW/2LkYQ
         c9QnBcpfgW1ZFWmGdDTS0FWrwYInfCzBz2GQ/yp9732zJ8bnK7ys6/xmyB2dmoQALcj6
         PHJV369w0CnTtYPw2hr2lPgCkkAsCH6lzDw04OnYoGNW83SRgkc6qOcsYRXlGyAoAdbY
         Fz5IObINtZLQx3qA7bfhpadKcdNK8gk/SbtT3tfXHN6czae/KIHA8uR6VxXt4nRl3nA6
         FC7GntIuHqRVB9vEv8vnRjLYM9M3Zh+aRigSTYEiCG3nWTcy6NfwcWYYYiqhCr5uQry8
         ZbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793692011; x=1794296811;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8QBB6SDvL82bQ+9NTShsWyttaad3ZVjOHNfU0QwklhE=;
        b=YFlb5H2itGtL6d7nD++R7rnylIWX4ZUqDNPf4IjKtqgathNVk4DrD4/ytJYjJvaZWZ
         /3CgTtE3lZhYFr5GOrEwl2f8qNx8ly9WsqKuu5gdQwb7s6vD0+Nr/XJL7FVAtDPkW4xx
         +ZROGHFqogP3FLW/k59CfFdCXn+u4mT/b3itePm4/FHeNQqhdGvwreFuyfovO0lON8Ol
         iAcxVaf5Ts0VPID4GLS2CP8tGTjwCb+4Hty3ankPkFet6g81OblbJq4pCv5AJlBCqnVt
         975K9V5Bvd0+Bjj3k8f97QAnJoz2IWHPEuFntnHkaGwbe2UcXqxQWMAGK6EzC2sIFMrO
         CANA==
X-Forwarded-Encrypted: i=1; AKwUvBwNgRr9XgnD6r75TKkjDeWNiLWn5eahl9fitZRqRMUkrk/+DKaMf1JD4qQoZpBJOYlrQsaAlsKU6afK06Px2jt2@vger.kernel.org
X-Gm-Message-State: APuU4Z+GxDHKXROcHj1pHFaK02bgMs0Wa56vmVNSZGeGtItqnBoW0TVP
	AKAdc/QIkYxCGmtLZr9i6uTqGOwS19Vs872zADxGWFsCdenA6XG8CzfFnCRFgqPVqx9WK7IyrkL
	VyYZudWB/a4F7f6+sKzbxZmJJXaAX9Ik=
X-Gm-Gg: AYBFou0fkUXNaFPg5srMHHENLnWWCQcJ2v+9NfPs4RKWsApBRVDy/CCJq+im/DZhfeQ
	3ntmWFF/BfNX7KzsVivyDipZ1zGEIhmwIvgrzHjyeO0gwgInLbKZCEyXTvQDrxYg2badjdyaHNO
	7LUL19loBgi/YNZ1uFNEMHtFICDNR9pCy48vIYBzNxJd2Q6YE2Vj6DdY2u/ZiiMvJittVVKl2PB
	LmAASw6aA4705+zz6K5fEpz+4OuZ/GQ0qeheq0Agu5/nKpuisyTCJ/qSzYSN7vV3J5GfLxyyAPt
	xczOjn9l1m2uAIc+T2cyF586fldxsDXnDsrmjlVpFSnZXGFMRq2lXgFo79Zqeacwd4Qc4WSJv3z
	7gcQ7BtC5cscuVuLsez5B/m1/Xybe7NsTJiNa6Fu84gAc1KpodUY0DtvkyNT/QnVllXNGtzomra
	gdgsBg/iCPepAXfus=
X-Received: by 2002:a53:ac84:0:b0:67a:86a1:699f with SMTP id
 956f58d0204a3-67ba4c87fa1mr7869443d50.6.1793692011225; Mon, 02 Nov 2026
 23:46:51 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com> <20261102-alpha-profileme-v4-3-61e00f5e1da8@gmail.com>
In-Reply-To: <20261102-alpha-profileme-v4-3-61e00f5e1da8@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 3 Nov 2026 08:46:38 +0100
X-Gm-Features: AclHuK8W3aUGX7Fqw-nFhXB97QbZ2QNQORFdHiiKISHMfzT0-PRxCJAhJHGQpLY
Message-ID: <CA+=Fv5TQHTUBoP71y4HZ94Vg1k-mj9OZA_cBWs0bW1e+tnoTnA@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] alpha/perf: clear PERF_HES_UPTODATE when an event
 starts counting
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

On Tue, Nov 3, 2026 at 4:02=E2=80=AFAM Matt Turner <mattst88@gmail.com> wro=
te:
>
> alpha_pmu_add() sets PERF_HES_UPTODATE and maybe_change_configuration()
> then programs and enables the counter, but nothing clears the flag until
> the first alpha_pmu_start(). In that window alpha_pmu_stop() with
> PERF_EF_UPDATE skips the count update, because the flag claims the count
> is current. Since the next reload rewrites the counter, everything
> counted since the event was added is lost.
>
> perf_adjust_freq_unthr_events() does this on the first tick
> after an event in frequency mode is scheduled in, which is the default
> for perf record, and it then sees no count to adjust the period with.
>
> Clear the flag where the event starts counting. alpha_pmu_add() cannot
> do it, since the event is not programmed until the PMU is enabled, and
> stopping it before then must not read the counter.
>
> Fixes: a4eaf7f14675 ("perf: Rework the PMU methods")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/kernel/perf_event.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_even=
t.c
> index 70840c05d39b..ecec78c355cd 100644
> --- a/arch/alpha/kernel/perf_event.c
> +++ b/arch/alpha/kernel/perf_event.c
> @@ -456,8 +456,11 @@ static void maybe_change_configuration(struct cpu_hw=
_events *cpuc)
>                         cpuc->current_idx[j] =3D idx;
>                 }
>
> -               if (!(hwc->state & PERF_HES_STOPPED))
> +               if (!(hwc->state & PERF_HES_STOPPED)) {
> +                       /* The counter is live, so hwc->prev_count will g=
o stale. */
> +                       hwc->state &=3D ~PERF_HES_UPTODATE;
>                         cpuc->idx_mask |=3D (1<<cpuc->current_idx[j]);
> +               }
>         }
>         cpuc->config =3D cpuc->event[0]->hw.config_base;
>  }
>
> --
> 2.55.0
>

Tested on my AlphaServer ES40. On all three CPUs, the cycle count
included the work done before the first stop and reload. Frequency-mode
sampling also passed.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
