Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B304C62
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721782912; cv=none; b=YwG9iIrimjmFpIPPkfOKrqEjvLndOHBqPkgmHdV19TVgAtgG7odTozM+mRCnqhtEj0djtu+o+1unVZQZa82wM3nmCfxw09wTv1YnE1YJNirSx3Sb43c41mSlgjinv9Egb2+dbLYY6Z8t4JUjLzdQt7Ozvtc1nBywaqrs5sMOwVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721782912; c=relaxed/simple;
	bh=Zu25c00JsWlhrOfufasBRRsETcF9KBwlx9kR4Qh+au8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCBawU9FdW7KRFfuosSKQ7Rtq/gHZMUB98A3vmcjLQAzUHIPDkQO3dy99dkuKlDK4mtrfS89Yx3WT5B0x+yYbv7yobd+XAnp5G7SL429HAEtWJGZwDVxa0Dcj72r3F9dHgMJw7wNqh/MtdOHk+vU2Nb6DPb7xk1zwNpmLFsgUyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DZavSEjT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DZavSEjT"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fa9ecfb321so9927945ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 18:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1721782909; x=1722387709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sz9IPzon27B+vtOKB1z6ZWSG6J+jwhqfPYpySzTzLO4=;
        b=DZavSEjThwa+kRv/EF+qeWvqInu7SPI5ZoRn5aGB5ev28dzgVSkXMl+w82FBgDNpxf
         6UXm4qpbX9155RYyPEdlImMseve3CX1nykP/AK6grmV3qn69hRG6csN2BoKsKqj4SaU1
         ENHlkp6zjtuQhtUWJ2oXcviR/JJwa5p1hodzBazUFqkLZKYYCX8xv1Cjx5gJhhiiPAlU
         5TRZChCvNHuxno4Qmu562meq3x2shJojY/SXQHHlxVkOD2rpZi1v0SThcpjH1Yac08HJ
         39DnqRhszAb949irILicS39wGeEnmIGWtDyVPKzA+mlZPhBJbBAfEYxO3SclDfjk/sX/
         EhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721782909; x=1722387709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sz9IPzon27B+vtOKB1z6ZWSG6J+jwhqfPYpySzTzLO4=;
        b=Jxd5fae9Q6nLzDa2LQ8TIDKdLuzvCOf0L1DjXT7LXXqYSxdJHCmBKSex5V5mpVLgoS
         H2Uvehh7Vo2xNMqhuqXbXn04Hkh7eOMPwJqncdUZbdevqdQr3XGza8uTj6TN+gkrifKd
         M+Obgs7gUqzdcR0sTbG709/S+5ZqCd0NFsBvJehKclLfKiqMnMp2s5IBnYu4LTTFQ/38
         sw9uoRCdRZ1uJGtesXNCHnIGP3qXgmAq08IJF/tJe8v1l2qBu572QfrOMcYOrdhlw+MY
         NefEEGciey7OPe1JB/ZKUOw0AvmUsut9hFL5nDsoxc1dPq+tLjBh2lKGVQuGylpGYZ3G
         C5tA==
X-Gm-Message-State: AOJu0Yw37oVLYzxNOHhR/kpAEMb1NIH6OYrvXDp63d3GN6oMjWhEXc+P
	3zYWKSZJ8i3m2DI7FpvKZ5KcS7ffKKP796LFCHfFqB4ZFm3c0/hwFk62KgclZXC/LrjA5H7W9nW
	bU/hzEDRNrbXr9cASitexSVg2/Q2yJFr0aO75lvVFY2MJiLd3D+M=
X-Google-Smtp-Source: AGHT+IHMEm+FUBb+XmMeTLjEC9Gy4Tq8ayvSdZ2+NfD40y4A9YYx8rD8L/zxzkFcwWjC4lTJ6vFeYucdMH/L2gcxRZ0=
X-Received: by 2002:a17:90a:c17:b0:2cd:2c4d:9345 with SMTP id
 98e67ed59e1d1-2cdb5120b02mr798742a91.6.1721782909233; Tue, 23 Jul 2024
 18:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722211548.61455-1-cachen@purestorage.com>
In-Reply-To: <20240722211548.61455-1-cachen@purestorage.com>
From: Casey Chen <cachen@purestorage.com>
Date: Tue, 23 Jul 2024 18:01:38 -0700
Message-ID: <CALCePG0GtG4DQwzJ-QCJRScfxVg3Up6Xeemxh48qSf2VjxjebA@mail.gmail.com>
Subject: Re: [PATCHv5] perf tool: fix dereferencing NULL al->maps
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	namhyung@kernel.org, irogers@google.com
Cc: yzhong@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ian / Namhyung,

Could you take a look at the latest diff PATCHv5 ?

Thanks,
Casey

On Mon, Jul 22, 2024 at 2:15=E2=80=AFPM Casey Chen <cachen@purestorage.com>=
 wrote:
>
> With 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions"),
> when cpumode is 3 (macro PERF_RECORD_MISC_HYPERVISOR),
> thread__find_map() could return with al->maps being NULL.
>
> The path below could add a callchain_cursor_node with NULL ms.maps.
>
> add_callchain_ip()
>   thread__find_symbol(.., &al)
>     thread__find_map(.., &al)   // al->maps becomes NULL
>   ms.maps =3D maps__get(al.maps)
>   callchain_cursor_append(..., &ms, ...)
>     node->ms.maps =3D maps__get(ms->maps)
>
> Then the path below would dereference NULL maps and get segfault.
>
> fill_callchain_info()
>   maps__machine(node->ms.maps);
>
> Fix it by checking if maps is NULL in fill_callchain_info().
>
> Signed-off-by: Casey Chen <cachen@purestorage.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/callchain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 1730b852a947..6d075648d2cc 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1141,7 +1141,7 @@ int hist_entry__append_callchain(struct hist_entry =
*he, struct perf_sample *samp
>  int fill_callchain_info(struct addr_location *al, struct callchain_curso=
r_node *node,
>                         bool hide_unresolved)
>  {
> -       struct machine *machine =3D maps__machine(node->ms.maps);
> +       struct machine *machine =3D node->ms.maps ? maps__machine(node->m=
s.maps) : NULL;
>
>         maps__put(al->maps);
>         al->maps =3D maps__get(node->ms.maps);
> --
> 2.45.2
>
