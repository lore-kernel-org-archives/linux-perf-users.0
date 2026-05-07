Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9E62DAFBD
	for <linux-perf-users@vger.kernel.org>; Thu,  7 May 2026 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167852; cv=pass; b=BCzCHZaT6DcQHX35zH5fAN1JNiABb6utnhyc1MNsZd4ASkr4l5S6q/q9NhAgTUfsi5jO3oT0j16jZfRC3OFdk0Pw5nTgea9Q/g/0YB9ooPp+MFDx1MdFnSyW4Lmv7Em1tTCqeJdUwiAkz1r5m3oL/q4J7gcDDjE+lMf6f9qpIbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167852; c=relaxed/simple;
	bh=kNrxkxYRW7kagplXpuPKE6qKbTiz92vOI0XvAuUSKT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KiiS+yS11pa4jgoQ0nmDFCck0Ry1mJ4WWXLIVAWwAlvUHbIp5re1ZHfhJFdNJGep8/gb/MpbFpvWhlIltbSXCultT8EZBmNGlSecF6WGd3dWxwO9bszs9MnnD7vM1J+pM7H84KvFsxQ0yMDoSR0TnjkDo41C+/YwLCXz8fbKC04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jZyFql3V; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jZyFql3V"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b46da8c48eso95545ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 07 May 2026 08:30:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778167850; cv=none;
        d=google.com; s=arc-20240605;
        b=gd0sugdHRGgzb7QvyiWypBKrePurQ2VxguoeUsdpdb/RGpRmNqHVoWH3cXdbyIV2xj
         djnRQ+VXhfrRYehkm5u7dhjKf6+nx5DE/tnjdIeFQUkTbwPvQQewvVnWZSpUNYu7V/kr
         cjxabmo29w63+uxzPgLE+b9QjOHfPt/caQvVm2Oi1OUt1Uiuqg8JIyzs7OnXVGvNlBLz
         oqes+qoL974kPm+Cw0g57KHzCIa74BYa0GKirkQEaWD9GnoCo5AQ39o58CQpZF8ZbuRa
         0/rv2GQENr8g2rsxtf3N0rA7PkGFFP3ZH2vkhtK4QfG/bGF25gBiJPCMLuuPNCgXw5on
         YnnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vJRPPZKaWZPC+g2g3YyNOX1Fvmg1nX5oE76KRCNN+u8=;
        fh=WD6DziX+CFj8e/cJsEBYBLpg/lTH7SjD7zdbyqYkeyk=;
        b=Ihgsh+sDJnfXKthLV2Puq9iGFPBXPOD6L2+8DiiO4c8g4cmNvb0gDoGSMGvUKvVF4p
         0l99i7M8pj43cAaLbv7ar6oxzHmVu1lDGWchkLi+u7l+0PFs6VKORPS5gaT0ZtWMNGEc
         Ymewf8wTbDMA+7jUdI2pVhOvXi7g6ZZCKKNAARkMpDvwFzY5DL96VnVgX1zlgOgG2N5P
         OZ+YXuHUJni+/nBtXzyybbakzQHDUQ55T5TKAQ2vWNTGXmtoQ8XCb/8SVyCkUFUlitiO
         ojv3/Fa1Q9DCkwzu6nJGuvjXCUqBqt8xvqwGQoOY4ExrZOSMnmRTMid0GT3lLxt7K5ds
         7lNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778167850; x=1778772650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJRPPZKaWZPC+g2g3YyNOX1Fvmg1nX5oE76KRCNN+u8=;
        b=jZyFql3VkcKND0tQgnrqhv2j6ZwZzCl6jczWADJLfzkGe8E8VtXx8Fn9DsN9dMODdC
         G/pV6cNzGYw3X5ovNbv0bKtlcUYDhtVZxqdOi25+G6EBAQuJbR35FCAGbJN4oP2UHZ87
         NpNW/eGWoqio32nOqLl44orRz7iLQASEyHBic4DilYjH3ZA7fFWieM2eZ/4SIjQPeu3A
         BBqW/QMZnIzUF9stYGly1CzeeYHzRYE85e60qF9YpzVQIW1c+rqiYi3XzONXXMjlkb+p
         KSfvEyt0BEjQv08mEYMqZ7dKfMaVpT45ZeLUNn7tTbr8BSCoxI7bS6ikqo/Og+cpdjF5
         wuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778167850; x=1778772650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vJRPPZKaWZPC+g2g3YyNOX1Fvmg1nX5oE76KRCNN+u8=;
        b=ST1L2Fesox1V1vkhM2MFS6LC3XW72dF8bFRyM8QnJ/9gFfZXKPYfm7haijFtScBR27
         PyckTs/cWlKLqy6T9AFFOMM4dOXgbDgueJSW+BHE5k+rl1zQZ0SCDBr4i2YVzeoJxUbI
         ZGiaagm4NHXoQj7wWFEa9GlbFNQLLpfYwtrjbfPTidoXyCpUhurzoGKf+LAe9eq4bMrd
         k8y1WPsyEHC6wOpmgrxwdskrtcGpTX5jNlWnjiGU8b/PE2bNqzLdHNg3elRbPy7UA0eS
         +uZNBTAuBZ5hmKiCiZNKlDq95yDGy8l4achQBvN4feC0o1nuzbYzMDe7u6RXH/g+BYmR
         QpiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9WLr9vVz4kfnyqT/pz15iL36P7Fr5xprBjK0IT6n6beHYvsG2mjaYD/vET7XFQdQWMDFEXrQA+WFpprAGG3P3z@vger.kernel.org
X-Gm-Message-State: AOJu0YzJQ7+aIoNbYhmxM9X157yjzbqufVsJqWz5N3z8spYy6ooWLOnt
	S1jeDYVlWki2qdYVvCDwrM9iGB9TRhZ/Aj4Yka98mIvZ95jnYmldL9SAL+TB836VZho6JcxcS52
	PIvcD0sbpeqTu25HZuBa3tch9zI3Bq0bU+Krp0AtQ
X-Gm-Gg: Acq92OGbTyyRiNGar/ReZGUAqaqWNyZiCm6yLt9i/oMaE7Vw6bR42ZEHOPtOftcId06
	svVFWqE+HSK/TF5plJzMjv/2Sres0KdFkGjBJTQzlhn5OwOvDEivJ21OrOCCaLfGCZtF/kyL56P
	LWKpTxP16jb0CabAeOycxBYcUKibU8q4QlapQCLCVVrDRvrC66mnUS6SNIkDNovjhj/VWeQyvhd
	H1lGCYlbi/YIMMGt3doJwb7kFYS5gbJ37/FnJ1jkMQo795YxbAkFJ+y2frfmRpVvSRpXCasoRbt
	IeqE7KNWtudo7qFjXF42gA7NRDvwFssxF2RrznHx0LyMwYnU3sheHHj6ey8=
X-Received: by 2002:a17:903:2656:b0:2b8:e82d:ff7c with SMTP id
 d9443c01a7336-2bae59d0059mr292905ad.9.1778167849553; Thu, 07 May 2026
 08:30:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507063737.3542950-1-wangyushan12@huawei.com> <20260507063737.3542950-3-wangyushan12@huawei.com>
In-Reply-To: <20260507063737.3542950-3-wangyushan12@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 7 May 2026 08:30:38 -0700
X-Gm-Features: AVHnY4I4QvxZzqwfpnvEbeIlSMNnhQaDf0SBrzeqp55KmSJ1VSkv32i2lPyqqXA
Message-ID: <CAP-5=fWkRD17T2iMTAPF8kjkkpW+BaeyxA3EzxXatRc1vN4QCQ@mail.gmail.com>
Subject: Re: [RFT PATCH v2 2/7] perf stat: Save unnecessary print_metric() call
To: Yushan Wang <wangyushan12@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@arm.com, 
	john.g.garry@oracle.com, will@kernel.org, mike.leach@arm.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, jic23@kernel.org, leo.yan@linux.dev, 
	robin.murphy@arm.com, linuxarm@huawei.com, hejunhao3@huawei.com, 
	prime.zeng@hisilicon.com, fanghao11@huawei.com, wangzhou1@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 11:37=E2=80=AFPM Yushan Wang <wangyushan12@huawei.co=
m> wrote:
>
> The patch listed under Fixes removed the other branch of iostat_run, and
> changed num to 0 since it is the default behavior of it. But during
> iostat_run, default value 1 of num is required to avoid print_metric()
> call later.
>
> Set num as 1 to avoid redundant print_metric() call that causes
> unaligned blank printed.
>
> Before this patch:
>
> root@localhost$ ./perf stat --iostat=3D0000:20:0f.0 --timeout 100
>
>  Performance counter stats for 'system wide':
>
>     port              Inbound MWR(MB)      Inbound MRD(MB)      Inbound C=
PL(MB)     Outbound MWR(MB)     Outbound MRD(MB)     Outbound CPL(MB)
> 0000:20:0f.0                 0.00                                      0.=
00                                      0.00                               =
       0.00                                      0.00
>                             0.01
>
>        0.100138030 seconds time elapsed
>
> After this patch:
>
> root@localhost$ ./perf stat --iostat=3D0000:20:0f.0 --timeout 100
>
>  Performance counter stats for 'system wide':
>
>     port              Inbound MWR(MB)      Inbound MRD(MB)      Inbound C=
PL(MB)     Outbound MWR(MB)     Outbound MRD(MB)     Outbound CPL(MB)
> 0000:20:0f.0                 0.00                 0.00                 0.=
00                 0.00                 0.00                 0.01
>
>        0.100127590 seconds time elapsed
>
> Fixes: b71f46a6a708 ("perf stat: Remove hard coded shadow metrics")
> Signed-off-by: Yushan Wang <wangyushan12@huawei.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/stat-shadow.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.=
c
> index bc2d44df7baf..0056444523d6 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -326,8 +326,10 @@ void perf_stat__print_shadow_stats(struct perf_stat_=
config *config,
>         void *ctxp =3D out->ctx;
>         int num =3D 0;
>
> -       if (config->iostat_run)
> +       if (config->iostat_run) {
>                 iostat_print_metric(config, evsel, out);
> +               num =3D 1;
> +       }
>
>         perf_stat__print_shadow_stats_metricgroup(config, evsel, aggr_idx=
,
>                                                   &num, NULL, out);
> --
> 2.33.0
>
