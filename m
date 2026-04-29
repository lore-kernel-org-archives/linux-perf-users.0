Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240E82FE58C
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 16:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777481746; cv=pass; b=QDL30jOfur3nqMNWMW418mEmVH5mBMITRk5asQYsGSu2UYIPsN/miK+YGgo+p6vhJZsy/rEn9uOvFu5flMrgwN3zG3jvepsGdoVJI0w9G8/aWt8LcgNkFsPaH9uIueVHIMZcbeSIaB0qQWmhILaq9ZcCyUHwt3Yumb/O2PyB+CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777481746; c=relaxed/simple;
	bh=7xJDzbQV0k6vBKrEv+Js0aVz8OlnZRc2ucjbFdpRo4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oP7TgIPl/KffqleEKSIJNmxlNqEm3keSQAUVwors0bGnMOaF6svyaa4qTRyq7h0+HwUH/5ZVEzmF7hICt7PiL79iEZKdTIHuZBbL24ajohbfh1ZNqW/DupACa5bjhHj5B46pU6dywgn5Bfaa0MIUNvMMlvzxJnZKy2T70MgDh2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IFx6cC1i; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFx6cC1i"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b243198058so2965ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 09:55:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777481744; cv=none;
        d=google.com; s=arc-20240605;
        b=ARdY6SJg1MZ+ooviMKTOIgNRJOcNgExxIjvLVtEu1KzvQ8/PIr0YES+N5PYH3RP+1U
         wXrEP0X0BW9jRff3Ae9ZSLfHZbANBwg0vYkYxDOJ7ZYxVBpBY2V411KFdZNUGcOYgLDP
         tPeZjC8QL5J+m05KT9EugcmOFQ9G/PSJUPYP9I20ZvmxKDn4xWOr2O4j0mOvaTJam4LP
         owGrjdknGJsqM+p7F5Zm18x43ijuCoL014sf2pvFFZr4dSsqAy3ZFWkvc53KRiBU3olC
         O3pLKyjl7eR8wQ4Y2JbVp9ssPl6jyyKWPv2kWTefpTusoIcZCMz52SBxNlgHLSLgGx4E
         46KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Owje/qR+JsI5J1TZ3arMohBrXcgcMhdqJUaLjcaDG0w=;
        fh=cTInnflu4NveIvV3hXuo8pN8ADRCRO/OEP3BvMnrnRE=;
        b=SR/s+3+ApOmXZdL9GPT19aCW/74GT+0xxFwDra6rvpRX2P5PcUghM2hWd97MMxVryW
         41q3SGr+A4S7h/cFeOM1FLDEN/mfgeo5AxRXReQUeJAhd66aXEMhPA2uZJ8tJ2NrWpl5
         OaLrc71in6U9tjZY1dwLFtEVUVelCLKT4SPXsI2Vf+Q5ZghRWK7mzKdz7fRyVFyE86oc
         na8xXbJNZ1mNakAegxNTQOYAIe6HKuvd/aklA3hVe1uyJC7aEFksempYf590y6VgSqok
         /MuXz4ZyLkZ05N9+OdGM4pZfmEx5sIxp/S89z3v0CGBUuoJx3slESJo2GnmLNaB5y1Wh
         QqFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777481744; x=1778086544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Owje/qR+JsI5J1TZ3arMohBrXcgcMhdqJUaLjcaDG0w=;
        b=IFx6cC1i1oxhYAWFkIZUoOutc+T31rAf8ayXUT58hHGb3fsy8TqAlnZjxylSyBU8VW
         wiJzxSfQnnHoATk1gpfGaWNNb/Tw7OR7GQGazYyC64LTs7HtGt0c4SlndPQZfHY9OAGZ
         QKxagEVsXDxYN+Jbi6oLZF8FruKSRTV4MKUiXzG3R+bqebc2pNm9xXPQrDeOhavNM/42
         fOeJQuxetdWfG4uU3KyquctFV2EpExb74ni0WehyYeD4Et4JLfWb3UA07yP8Luyyb5kZ
         uL3sfLADDiRmms6nL8k0ukTpgeO10XwYxA8dpI3Iawvfx9QRtWVqLuEmSx9lz6mmX2ol
         0J+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777481744; x=1778086544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Owje/qR+JsI5J1TZ3arMohBrXcgcMhdqJUaLjcaDG0w=;
        b=efyL/PmAkm9RI0yKvNx4Utiy3qz6x2650RZ3cksvC0flHonkbg4zeSQr0UjK45WSHL
         rMCQ1Y9SS9uBqiEr/h8XSG8HH6DzM9NSv8VEqV4HOra0PLeeCUEeRBrzXwdiwIrfIPND
         rzv35HUiKzIgxQfvM4GOBy44D3jniFq9NThaCTfEMtoGbCPEakPzUq6oTcIMK3noa7ka
         aP2HfP5ygpCpO3ssgea/UVZZFjX/lSstPdikW4DLLd2UtlBlofca4AiEvG8DhQLf0y7k
         GfCNjVHpy/+p/XRREpf2OjjG/VR429dTPt+jnxXLpLJiIky6ZlY21SRwIuF8LyRZGO+l
         A96g==
X-Forwarded-Encrypted: i=1; AFNElJ+WlzTNrUcTej/JBnKOcLcrQk0IVxp8V3+2pBZuqW/sFZNI+MysptFgCBhhW/LO07dJq5Ce2rkUBXX7IYq4M9Tr@vger.kernel.org
X-Gm-Message-State: AOJu0YzmL7umfZG2NOkdfqy78t52WPUEEkIfTmGjSO8MMHDiOL/KMmjc
	9fQu10KXFBey7AXvEh97aJvZAFuyyiSUih3kuk6/BH5t4vMvf6pQliAtkE411tRGm3vhYEHxOej
	ZgNzPjng2BXsjbEBa785wwbJKKCzmw0o4iwXLv09j
X-Gm-Gg: AeBDietdPkEFUYT1cOyQm+7datmbsU0AvQ9jJCBw2vro9+FNifPUJuGy1041p/CvR0n
	GTJwf9c7RNe4XMIg6ZF2gcMkTEbtUX2ghSlfJ3jYPp1ioSGGdPcnGvx7nHDcZRqbjoW1jINVTTy
	1JCd0umTt8ocN9aNykzZaNTCdUvC7EMGqEq/XFfoAtxgZXitpFRJcJd2qFHHnaY+GMcAELqyyhD
	hTT04W/OWT0Nuv3c+9HgQPc66nG/KwMFFNYR860rjwabnX4GUfEJ3gQ1xWq0xlI+oAGxpTbQSP5
	9DXCf1VhfaGFB1ROCi7zJQxUaHvlFBX8XDiWgFdt7H4oQZrA5qwZRd54sDQ=
X-Received: by 2002:a17:902:e74c:b0:2b0:5c88:51e1 with SMTP id
 d9443c01a7336-2b987eb5d67mr4340345ad.14.1777481743788; Wed, 29 Apr 2026
 09:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428143920.2466185-1-martin@kaiser.cx> <20260428143920.2466185-3-martin@kaiser.cx>
In-Reply-To: <20260428143920.2466185-3-martin@kaiser.cx>
From: Ian Rogers <irogers@google.com>
Date: Wed, 29 Apr 2026 09:55:29 -0700
X-Gm-Features: AVHnY4LPzynVKE_qz5ERdySCKLB6e83S_0eopv_FGSbGV-NAK-btgLx2SsRg69I
Message-ID: <CAP-5=fU7vttJC6nP8swT19bynjnhV4DR4cetHK6=gBGsp67NMg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] perf test: fix sys_enter_openat event test for musl
To: Martin Kaiser <martin@kaiser.cx>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 7:39=E2=80=AFAM Martin Kaiser <martin@kaiser.cx> wr=
ote:
>
> The "syscalls:sys_enter_openat event fields" test calls
>
> openat(AT_FDCWD, "/etc/passwd", O_RDONLY | O_DIRECTORY)
>
> and verifies that the flags of the captured event are matching.
> This fails for musl, where the openat syscall wrapper always adds
> O_LARGEFILE.
>
> Update the check to allow for additional flags, the access mode flags
> must be unchanged.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> v2:
> - check that access mode is unchanged
>
>  tools/perf/tests/openat-syscall-tp-fields.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tes=
ts/openat-syscall-tp-fields.c
> index 2a139d2781a8..5523cf4e9321 100644
> --- a/tools/perf/tests/openat-syscall-tp-fields.c
> +++ b/tools/perf/tests/openat-syscall-tp-fields.c
> @@ -120,7 +120,10 @@ static int test__syscall_openat_tp_fields(struct tes=
t_suite *test __maybe_unused
>
>                                 tp_flags =3D evsel__intval(evsel, &sample=
, "flags");
>                                 perf_sample__exit(&sample);
> -                               if (flags !=3D tp_flags) {
> +                               /* C library wrapper may set additional f=
lags,
> +                                  access mode must be unchanged */

I think normal style would be:
```
/*
 * C library ...
 */
```

> +                               if ((tp_flags & O_ACCMODE) !=3D (flags & =
O_ACCMODE) ||
> +                                   (tp_flags & flags) !=3D flags) {

How can this second condition be true given the first condition?

Thanks,
Ian

>                                         pr_debug("%s: Expected flags=3D%#=
x, got %#x\n",
>                                                  __func__, flags, tp_flag=
s);
>                                         goto out_delete_evlist;
> --
> 2.43.7
>
