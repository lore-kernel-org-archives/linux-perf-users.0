Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054D7387342
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775076530; cv=pass; b=XVp5HlUFU19Txh1E80l2LjEyv74L23nQxIAdXjW+RuH7V8nQhlcXuK3vS/UpeLsryc7Uio1dNffpvFsk8IizEzkboF+IB58jCDekWSCcwWjXVdyjloROpF8nnh8V2JFrsAQOWHRMf7aHsTfBygarHtqA1+IiPEo9Chw1sBNJmOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775076530; c=relaxed/simple;
	bh=qPgEa0KuFO1SjD61L8KwdXpsC+6omrEbJP14/tV+O/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qX+oUugsSbFZLmMdHGHy7dN4HEYk8SU5NKZo5nM9myL/Kw8mPvR9tsDaQb2fVyozZRIxIBrvfHP6vy5sQTqiD0dlaJUBarpl8jx+FbWaw9bS1O6EyunjGKQZlNsQ87veaOR/oIFiWxHBNTuGv/WueJNStPgABFz1JREJlFkbiFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WcoOqARv; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WcoOqARv"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b2591757fbso34495ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 13:48:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775076528; cv=none;
        d=google.com; s=arc-20240605;
        b=k4K2SttLgWUQqm4NJw3/7fJ0s8NxzBoSheEpISaeaJQKaLsVX688NQJ2B7rACM3yGh
         VfhxTejqbX3uPUGR1uc+3Oad5QBHILX7CR3SKojPUrTWi7O02Q37Ss8k9HtotaUSLXQT
         6MhvepZEst0H67Tbui+gOXb7N86DSxvTdR9626cL/fHBpykQwBJ05WBxkH0MhyaZPHSV
         gWPCvlHDVer0Cjepmh2S3FnbcR+VjvbpBwc2/0m2BbO9sDLCB5ZFrgGa/M6+Z8Jbi0Qv
         ejq9YMjl+6EtdWNOvtYnITSRDOCqxu/qk8Ykh93mElB93z5FdmuaEXnknLt/DndhdqKv
         ZucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dqcPdfuIEhIvswUZb+Hzi3Id+ifHsfnZIumCRwmKQTg=;
        fh=R5XUtMTLFl63KI86+l1MyyYA820nkH8/e7gdFoR2DBA=;
        b=hJJJtXR8RsQgFYuXY1/xu6aIE4OnfHTwQIKdx9NMef20COxZImJ5p1usVTuW76N6ZA
         gBmnmC6GV7rkSKmkGKfzNjR2kPYQAKaXhgx/ckeyPH9UrO2fHolIpAN95vvbz8MqP6HK
         9qVpRB8miRd9EZOL33MiW6oFUf/tvFNNvRdhDamE1Y8y3IiZp8ke8/1STklxzJVFUVKo
         K6GXpT+a8qkgvwxOYq6nLhuIOXhjDoZEi+Xd+ab5yKVuO9MRefnf4FFrxGOCugnQYTG4
         djV/0LWtdznJmMn/VZ6lhwpFe8BTCr+K/VsmqzbCA9AIgPmt0tEPfX7BAMc1+NdnJBmX
         tV4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775076528; x=1775681328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqcPdfuIEhIvswUZb+Hzi3Id+ifHsfnZIumCRwmKQTg=;
        b=WcoOqARvg3oz8UzQg4IygVQw8a1K4ETRLderxSfXfNlobDfpquUd6ST9pwLjy2ltpe
         TxK0OOurcSTfFp8HI/yPsc4dhg8Jx8MBWCntGuOLwMs4t0k4Kx6S63oqYG/yJEigbSYF
         BvW/6PCPbYYPBKzxHwtJDa2RRa5WzwbvBTWp5ijw+XNg3Lv00sRswP9G8uUPBW4sW2II
         5RiUwNRAMgpLn498KgB643dj+H8fdQ+LQDaZcoJTY4jwgGavQtD/gNoURjfr/drGdAsE
         ge0EtqU355iX7wAFRIW94C7A6gttIDMQ6dVTQOuLNagz+P1j5ZcTAhEx/8NBvi67LvBw
         nWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775076528; x=1775681328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dqcPdfuIEhIvswUZb+Hzi3Id+ifHsfnZIumCRwmKQTg=;
        b=MNR4lJfQ8FtsMTgNWlWpODkg5wvSxHw0tMq+9xmhH+K7n7XchYc49bAiMLXD3FJghH
         js/yQy2sxrLMDwSajQ5l9dfodRJxnQsfO3HceJcIRykDFRk0pfhGuEiicj7HhRkaVrdN
         VtZR/5eSWi0mjqW1ncrkpJ3IKn80SBJhZ2vrZCcv7kL2xR2xjxjmzVQ6lb7s54X8Pl+h
         vObrgusgS8Gm7zJM0kWvEWYoHNEHnhrCeHBZV3VDZr58p9tRfUBpQPcEo+9eAjrwZccn
         KGUsQmNjJr80xe8xRtcBAUa882eKm3Dbz6Oih4Nv7NxjU1rNmGp1m73yrGXiDYHkicg+
         hc/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwNp49tk59bSmX5RqD2bH6gkxdRQ18JvFPIFtRPPfsQWVEowHnwMr1dEtmfPd2YMUsetHLZKTcyQadufQAMd7u@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/VV0DOC1P5DKv/7Kyi8jMXBTk4QWMbR9i55kEKHcJRwgcsMnt
	HCOWtfydHB5KBBl5G20YqBRUxhno2qF9G7TNBXx89MSRQ7qbZx1z3RqYD6wQk2wapJKQ8xFL1Wt
	tZBJ3LA36wh2xYC+X7J+mxxbryGjHF7Ljz46GgJ/p
X-Gm-Gg: ATEYQzzK+Ofj2Ti+aBT1YuPGjUKrZDK0V7znlOKfYnRVa54y3Bop2ulfStxN6DPGEsY
	zJ+oTkS2sMXVqfOG7tB4Iibk/YNQqrudEVPvqMaPQWPvVXuNeOkH6+opFaQJl/MDY3vzRVpadJS
	idacPx8fvCp0bQ8vxDXHiRQ7eE8FZDPRRTuFtAQKHr37JLq9y6OBdRmmeCauP8yrZOMEIERXdc6
	sjgDYDSc+8usWl4DUvH9/fdfynR1z08pZJGb2vyiSbytT7dZ1ECBILcXPm7dYB7NjJ4+D6GH7AJ
	drdQKKe94qyBtDaePVie832CYzYXZrZaP252VPRei0+lkFo=
X-Received: by 2002:a17:902:fd43:b0:2b0:aee4:afe7 with SMTP id
 d9443c01a7336-2b276a87bf9mr250895ad.10.1775076527946; Wed, 01 Apr 2026
 13:48:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206083721.2277438-1-suunj1331@gmail.com>
In-Reply-To: <20260206083721.2277438-1-suunj1331@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 13:48:36 -0700
X-Gm-Features: AQROBzDWawhHrje0Oqq1k44R2R_v74L6Q1HqZ6-NWyqr5N2cdncwrbcdyVCALoA
Message-ID: <CAP-5=fX3Aig-hMq7fC=U2nsqswXLsqE9QwfSw17dmS7n+QgKnw@mail.gmail.com>
Subject: Re: [PATCH] perf header: Validate build_id filename length to prevent
 buffer overflow
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 12:37=E2=80=AFAM SeungJu Cheon <suunj1331@gmail.com>=
 wrote:
>
> The build_id parsing functions calculate a filename length from the
> event header size and read directly into a stack buffer of PATH_MAX
> bytes without bounds checking. A malformed perf.data file with a
> crafted header.size can cause the length to be negative or exceed
> PATH_MAX, resulting in a stack buffer overflow.
>
> Add bounds checking for the filename length in both
> perf_header__read_build_ids() and the ABI quirk variant.

Lgtm, could we print errors when these conditions occur?

Thanks,
Ian

> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
> ---
>  tools/perf/util/header.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index f5cad377c99e..208ccaa62399 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2335,6 +2335,9 @@ static int perf_header__read_build_ids_abi_quirk(st=
ruct perf_header *header,
>                         perf_event_header__bswap(&old_bev.header);
>
>                 len =3D old_bev.header.size - sizeof(old_bev);
> +               if (len < 0 || len >=3D PATH_MAX)
> +                       return -1;
> +
>                 if (readn(input, filename, len) !=3D len)
>                         return -1;
>
> @@ -2377,6 +2380,9 @@ static int perf_header__read_build_ids(struct perf_=
header *header,
>                         perf_event_header__bswap(&bev.header);
>
>                 len =3D bev.header.size - sizeof(bev);
> +               if (len < 0 || len >=3D PATH_MAX)
> +                       goto out;
> +
>                 if (readn(input, filename, len) !=3D len)
>                         goto out;
>                 /*
> --
> 2.52.0
>
