Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA3B1E898;
	Tue,  9 Jul 2024 05:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720501280; cv=none; b=V2ydmJ+bajUWCsPGrWl8rbgzc00xKMLqtB15Wwuw4Oz4qnB2NYu1BDbD3jpWqLzW3+UUppuZbUIZqM2jMeZO8SDwArqifwA8WT1ufpCrEV1/jhZbV+MpsKeRmlqqUxVNmjZsjPwXYJ0BAdK7sz0FHxFez8gG2aKUDCzChfj8TEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720501280; c=relaxed/simple;
	bh=WDZhLj3jv/6khdqWAJNR4muP/imGnI4izAweDRmkn3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHGdtE6KyVL9NLloE+vMnupjFSklbFI64EV5ibQ2CRgFy5mkTjVO9eFyOdByzl+JqOp6dLirWtOLWksCBPVwzn0Rm5EbS41sxCv4Kgly6dyQUO7wqT4zJEFg+ndnQ1cgdSeX9ogpQd//uiDgfP4OXJ/+IoQK1OUT3XB6nzEhhxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d6301e7279so3180136b6e.3;
        Mon, 08 Jul 2024 22:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720501278; x=1721106078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrve9qh5xt8FRNU0+iIxuzdwL5UCVlCRUtBcv5wI6+8=;
        b=kGizM2raTdiCshUSrjFzFghrx+Y9or58C8q9NmtdnidsmMVq/EbTtVOPAAOZCjMmy8
         x1WYQdJ4J+k7O2z04IWkSR7FqYq9R28g5JKh1dcCOvKPFKzsBql8HNoq+aXnatfCHkXb
         Q+JqiuM8Z3UaSm7g3/W0hBsi5dRYUuSAmK3kN2DnE/jK76EhgY+zBkg0n0p+rkBwC/nF
         PZFNaohKVT85kVeNSFumKfqRX3W46d6xwLyqUu/3ZQNRboOQ1rpujqtMpWEzRj8pikpt
         CVO+6s9+Eh4RLyg5KzAvfOpG2lkw+xEH8mkKyrvZdZuKQ6TS7FJjKdNHkZjzKnGvKhKY
         ZL3A==
X-Forwarded-Encrypted: i=1; AJvYcCXgY5UChq8qzfoe/nJ7Obzj/FPBD9FqIqSDw3v8qQvl3SdT5QxTHFTSECPXI6sDmdu2wwRYK4kQIe1skeFXFgj/r9Z4qxJUlAh+APX/
X-Gm-Message-State: AOJu0YzyXhXsHPRSA/ZPMvIkLixdBDdlyqdN3ls4+gzGWk2W8oEfb/IJ
	ZTKu5qguoSCEisWmNYlmcmZ3yypW4PSDIFnfj527g4YbkgVV6RLXq1T2HsAXEYAgbmQRbAqJBMM
	6GFKLOzsm2+Cm2BcpRgxVyoqfjz1IxwnS
X-Google-Smtp-Source: AGHT+IFL2nyNl2ncoQH+9iHjFB5KYmEEw75ddRYQrICIPxXV+bwirCFOcHFW11xgfencHZqvEa+aAklkgCBWSCKnGto=
X-Received: by 2002:a05:6870:348d:b0:258:4dcb:7d4a with SMTP id
 586e51a60fabf-25eae7eea87mr1101312fac.16.1720501278432; Mon, 08 Jul 2024
 22:01:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708232302.15267-1-cachen@purestorage.com> <20240708232302.15267-2-cachen@purestorage.com>
In-Reply-To: <20240708232302.15267-2-cachen@purestorage.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 8 Jul 2024 22:01:07 -0700
Message-ID: <CAM9d7cisBvfLTzNp8=0SG6g3CA9zJFNayjopSEDX0fxRyG05UA@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf tool: fix handling NULL al->maps returned from thread__find_map
To: Casey Chen <cachen@purestorage.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yzhong@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jul 8, 2024 at 4:23=E2=80=AFPM Casey Chen <cachen@purestorage.com> =
wrote:
>
> With 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions"),
> thread__find_map() would return with al->maps or al->map being NULL
> when cpumode is 3 (macro PERF_RECORD_MISC_HYPERVISOR),
> later deferencing on it would crash.
>
> Fix callers of thread__find_map() or thread__find_symbol() to handle
> this.

It looks like you drop the callchain if it doesn't find a map/symbol.
Can we keep the entries with raw hex numbers instead?

Thanks,
Namhyung

> ---
>  tools/perf/arch/powerpc/util/skip-callchain-idx.c | 10 ++++++----
>  tools/perf/util/machine.c                         |  5 +++++
>  tools/perf/util/unwind-libdw.c                    |  6 ++++--
>  3 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/pe=
rf/arch/powerpc/util/skip-callchain-idx.c
> index 5f3edb3004d8..25b0804df4c4 100644
> --- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
> +++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
> @@ -255,13 +255,14 @@ int arch_skip_callchain_idx(struct thread *thread, =
struct ip_callchain *chain)
>
>         thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
>
> -       if (al.map)
> -               dso =3D map__dso(al.map);
> +       if (!al.map)
> +               goto out;
> +
> +       dso =3D map__dso(al.map);
>
>         if (!dso) {
>                 pr_debug("%" PRIx64 " dso is NULL\n", ip);
> -               addr_location__exit(&al);
> -               return skip_slot;
> +               goto out;
>         }
>
>         rc =3D check_return_addr(dso, map__start(al.map), ip);
> @@ -282,6 +283,7 @@ int arch_skip_callchain_idx(struct thread *thread, st=
ruct ip_callchain *chain)
>                 skip_slot =3D 3;
>         }
>
> +out:
>         addr_location__exit(&al);
>         return skip_slot;
>  }
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 8477edefc299..fa4037d7f3d4 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2098,7 +2098,12 @@ static int add_callchain_ip(struct thread *thread,
>                         }
>                         goto out;
>                 }
> +
>                 thread__find_symbol(thread, *cpumode, ip, &al);
> +               if (!al.maps || !al.map) {
> +                       err =3D 1;
> +                       goto out;
> +               }
>         }
>
>         if (al.sym !=3D NULL) {
> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libd=
w.c
> index b38d322734b4..fb038ef55be2 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -53,8 +53,10 @@ static int __report_module(struct addr_location *al, u=
64 ip,
>          */
>         thread__find_symbol(ui->thread, PERF_RECORD_MISC_USER, ip, al);
>
> -       if (al->map)
> -               dso =3D map__dso(al->map);
> +       if (!al->map)
> +               return -1;
> +
> +       dso =3D map__dso(al->map);
>
>         if (!dso)
>                 return 0;
> --
> 2.45.2
>
>
