Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA09C383C78
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 04:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773288488; cv=pass; b=lCRkMbZXnZEmYSRnN3TjbpFpUQdDRDNK/+g6yVm2IGfeDpvt4qsvT0TTQuxF0p9EO4X4njuV6aNt/04TzIsbeTpX1qYy5H7P7Z2RTcGET+xsZafe5YIOpM7AD/hHfos2fe5C9/sBoqevQuw3ZRfG/wufaLsL0z+40IS/bmO/KdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773288488; c=relaxed/simple;
	bh=Uv/TqGF9E9k1C69ufOyeiIBHdcw1rEQjoXeaPzfJS6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VilrbLc/cgXrYfBNRLcVwhtr7jFYMK7WPXfD0DPKj0mpK148OLLg7ojDSPPEQLg/hgiv7bPrqXF2rqATN2MbVkZ6QFIjDiku42l4bdrOgWSwObq4L2LY23FPzSK35FZCHfYf6VEXTWXen6OO4GhXLjJjrMkpQpvgF8BhX0VAQsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=23F0YGrH; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="23F0YGrH"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2aea4ebb048so37895ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 21:08:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773288486; cv=none;
        d=google.com; s=arc-20240605;
        b=epKRGHRwzwscx7cItJPRN5PBNVOeB1vHwzQ4Fs7ONvRFJpOLKZ1iD3q54thUjuPHs9
         IKA4kExKsjbKD7hlRjh1w+JkMurWmuzqDLZwCZaStNQ8x9nKR0YOmolOkpPie7SC/C5K
         Q8RQk3tP02X1LZyICMoFsertJE01tR3tfxYRGXuibFp5mQmTgXYqXfhYZutJydhyQsnc
         XlErqRjKVwDiUlGm3I0z0PaM5iIWuavgz+X0/Zy/Zj5Y/vIo90PVlJ8ME97b33Fh3+lY
         mAXYp5QdMbSUOZfzYhKJpEhgiRJye3Tqpt/tuTnCbNFrVZ/QY9RqPPTrip8saLhKGbg6
         Vllg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=61t+EbnVfzj3sEPVM56b+zkdCqhOhDzZRsrhQZlmWi0=;
        fh=Qm/y2aFZwsFuFesryFuKdCRVl2/LpJYLmGSS1avASZA=;
        b=XxeZRrzBukEmAF16jjzbTv1SK/KR5EwrhkliX8WJUJLv4AYDIBuW51vO7f2Nw3RCNv
         hhYwkbozgkCt6qEfNx6sjNKt6ZS12CQWAJ2iiNMzmAyvvQiOL9PLGEWkn4LUZYd3Cc9Q
         ykXp7BsiNcG1OA7LBDo5/lfifa2sUOGIMIvhS3tAaC1DUt0dwuE7jMRtsnNJhtQPVoAL
         eGi1V1s318siGaOhfG/09i8npjWqqi0Xkrx9/8Ai1yAYIjeidIVLRwlA2rfvneaFNkEH
         Rw7e1kzzigJSio8xNnCHmjdNLhSq2SjS+FlgH6NW5JcfQWTlvJeujDFPNB2m1rKTSO2g
         DT6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773288486; x=1773893286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61t+EbnVfzj3sEPVM56b+zkdCqhOhDzZRsrhQZlmWi0=;
        b=23F0YGrHMLrworq8GHLf3MACRhpFhyYbowSGgkv9+3xHHlB/D+GKE59RKprziupXrt
         PUL/LmL8B2mb3zdbC2fWQHuTg8ZY40uLJ9zd0Uad1Rs/JbaBTwMRoFs6EbNUtR4anhts
         /aMJTj5hSo8gyyG7cRnGtrY3IYHIEnbBmYsf7791y2xb2fbM2ar4Na9Pr4t2C2aj6RyC
         /VoF39DF0FxrokVMLzJbcHc5i0KweydXbBSGicF2Duuxzn0WUPHAjp4xMcbXTUrlJHvN
         kq/nnkV1iI4QWdedB006zZMeAB0cQySUaM9HA2C03HPrUjt8GuWCwDif3Fxk6/7Fsdd+
         ojXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773288486; x=1773893286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=61t+EbnVfzj3sEPVM56b+zkdCqhOhDzZRsrhQZlmWi0=;
        b=dDxWq99Zlo/es9S45E9kJrP6xfW/hJL7iAtO8htz/1vYmbQ5xz/mTBkTi9uFgbg0nl
         ppif6B3Jce2UN1P9CSKbw0wDunE7uGSTJmXKX3JTnf6nXEQLcBgt/XViMKk8TRX2Vwek
         EzIvR6vqK/46Rk8hsX5iaycdBCxUkZdbx4eo1P4S6NvndvmqT9XcZTJods6pnf8I7rfw
         gRC2D3b3Py5rtcLX6VpNK1f9d04B5wzKT0fHY2qnANgmcvL0DuxCC0pB5PYc+B42cbbu
         ZUnv9Z5oFaJQgX3Lkgx2kR9wFCCWrua6bv4ZX7qeVGtJax3wEbRFYkYBlZ3vO3ub0TdG
         jYUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0m7ifg1ZlekBF0Ixw+hjbcpuoI3Jen7lx0mLe+tDYF6pAA8QFIhNeISEg7ZbqhwMLIglvIUB8DdBVwlYsyOg7@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu1v5RD5136uJWuaprG11TexXDu98QrJ2g0DoTraMCjTGuUGtU
	pju8mEktLYtZ87EQd0az/1mvyXUOx3f4R0YbcLK/KQ1dqORmOqYl/F5XCwAIGmlVdCKdnD1KyCM
	vuEa+7SxInTI6UZzHHQIbbtXaUhUaHWcpGYcs1oYI
X-Gm-Gg: ATEYQzwm35oxpxdcJ0DiELHbBOlp8AcbjMr0Xgmt8/PxAQOrVtfv6bdsZDv4BTsaWvU
	ZB6TjGdSdF5cPwInTbfAxWCuS6VYgMUAzI7pOzdfiz1VFWEnsy7OvDsdvbwatacEl5Tnc5R8rdm
	iXkjJ+Ufp1QPRid484U7n+di2ReasGpIGWStttD+VgbdLRjFv7ioarqELvqCVOL0t/1efH1tq+e
	l6ck3X7AiPhBpwM/nTt7OeITB9pkLsgbmyGULHiLgS0XqzLAnF6XuDtUHpLyXwL2LJ8Uk+YJVXs
	g0bs/gi8
X-Received: by 2002:a17:902:dacd:b0:2a8:fe50:2933 with SMTP id
 d9443c01a7336-2aebaa4a522mr1928605ad.0.1773288485480; Wed, 11 Mar 2026
 21:08:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311075201.2951073-1-dapeng1.mi@linux.intel.com>
In-Reply-To: <20260311075201.2951073-1-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 11 Mar 2026 21:07:54 -0700
X-Gm-Features: AaiRm53hCECw5KbAkmCB_WIjhRm265OZF-1qIWqS3vH664SxaS72HF2hKdHLBUo
Message-ID: <CAP-5=fUw1Lybp7YbdP7b=ci8wuqRgkwJTCEEg6MTG4d93Pvwrg@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf/x86/intel: Fix OMR snoop information parsing issues
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>, 
	Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 12:56=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.intel.=
com> wrote:
>
> When omr_source is 0x2, the omr_snoop (bit[6]) and omr_promoted (bit[7])
> fields are combined to represent the snoop information. However, the
> omr_promoted field was not left-shifted by 1 bit, resulting in incorrect
> snoop information.
>
> Besides, the snoop information parsing is not accurate for some OMR
> sources, like the snoop information should be SNOOP_NONE for these memory
> access (omr_source >=3D 7) instead of SNOOP_HIT.
>
> Fix these issues.
>
> Reported-by: Ian Rogers <irogers@google.com>
> Closes: https://lore.kernel.org/all/CAP-5=3DfW4zLWFw1v38zCzB9-cseNSTTCtup=
=3Dp2SDxZq7dPayVww@mail.gmail.com/
> Fixes: d2bdcde9626c ("perf/x86/intel: Add support for PEBS memory auxilia=
ry info field in DMR")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
>  arch/x86/events/intel/ds.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 5027afc97b65..7f0d515c07c5 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -345,12 +345,12 @@ static u64 parse_omr_data_source(u8 dse)
>         if (omr.omr_remote)
>                 val |=3D REM;
>
> -       val |=3D omr.omr_hitm ? P(SNOOP, HITM) : P(SNOOP, HIT);
> -
>         if (omr.omr_source =3D=3D 0x2) {
> -               u8 snoop =3D omr.omr_snoop | omr.omr_promoted;
> +               u8 snoop =3D omr.omr_snoop | (omr.omr_promoted << 1);
>
> -               if (snoop =3D=3D 0x0)
> +               if (omr.omr_hitm)
> +                       val |=3D P(SNOOP, HITM);
> +               else if (snoop =3D=3D 0x0)
>                         val |=3D P(SNOOP, NA);
>                 else if (snoop =3D=3D 0x1)
>                         val |=3D P(SNOOP, MISS);
> @@ -359,7 +359,10 @@ static u64 parse_omr_data_source(u8 dse)
>                 else if (snoop =3D=3D 0x3)
>                         val |=3D P(SNOOP, NONE);
>         } else if (omr.omr_source > 0x2 && omr.omr_source < 0x7) {
> +               val |=3D omr.omr_hitm ? P(SNOOP, HITM) : P(SNOOP, HIT);
>                 val |=3D omr.omr_snoop ? P(SNOOPX, FWD) : 0;
> +       } else {
> +               val |=3D P(SNOOP, NONE);

nit: the else here is fired for omr.omr_source of 0 (invalid) and 1
(reserved) but the commit message says it handles omr_source >=3D 7. In
the case of 0 there's an overlap between  P(SNOOP, NA) (from
omr_data_source[0])and the P(SNOOP,NONE) here.
nit: why not make omr_data_source const?

>         }
>
>         return val;
>
> base-commit: 73cee0aad1ee2479fde2c9b753a1b66acb7d1b9a
> --
> 2.34.1
>
