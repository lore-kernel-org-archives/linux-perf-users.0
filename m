Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29CD7462
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Mar 2024 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710985841; cv=none; b=hanFViTDtmWcf8RK4arEKdAEYJhQw+qiFZxwPnzB4dGVjgXWgyPaCnZgJmcg+RnQUh0cqUDFb/CZeVxCffXlCpuLp67UBPn/JZ30g/YZ3RZFw5lDWwevrIkKePEoWaZrj2CdUXmoHtXl2/g1MQeroUfvY/F5HO8wpo4zaNLO+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710985841; c=relaxed/simple;
	bh=R7zrijesuvQqmNNwfNJ1OzbmHqLbGTLOtVIZOBj5Gfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLfno88Zb06ARzffvwGDuIoy3N0ZTH0UWMmxL/B5sjFOZi/RQniCHz+vDacv1oYaD4fuRXaJEyFjBoWsyHjVWLnGoX/E53oSut9Q66jEo08/Ab7xSFrYSoUJ8TCf5ksLQu0pguo6tQSv6Or0r5v7jvClXJ8/ZHgBZCGpUPsZK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ScjHQM8l; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ScjHQM8l"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dee917abd5so51905ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Mar 2024 18:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710985839; x=1711590639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mc+skKU4QeCkSwTpMdOslAlbmrHBOUhgUxYcHE46Yps=;
        b=ScjHQM8lyKUaWh055DRHoKyD90T0MkdPGeAwNkpwRIb8lNze3SXdfOK7lyWipZ5Ahx
         WDQ6bE9EXjaPzCcAz+iDAUUSggBA7LwzGo04QvMEXVRXnqS4ufJ1+GFANgRqPBiEDVhy
         Vf107gT3BoQ7Sg9HuoVbE84RmnT+Sa+RKxbpMKgQihU94R/Sz3MmVll5bXpcM3Vi9lUQ
         tCs2VMUf7LfKYbej4KW6xFET3bwqyIVaTEjJr21Oeb+UuMNrpylthS5BJAYvwRE+yWMA
         Rh4gKUmuZx9m5eh6C0UjSJ+coQ6EvJMy8ZxT2DvzGZNFlucHSvTwhSx86q+SHRFhtBRY
         /hUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710985839; x=1711590639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mc+skKU4QeCkSwTpMdOslAlbmrHBOUhgUxYcHE46Yps=;
        b=MovkNne5sxsy3sd0usWoQoN3zKIdX3gZjEgNj+S9F191LKix+17GvN1HIEDqoK3Sxr
         itkUnhIKQnJ0XjgG90R95X++pjHTJQvwDVDXklRkUid0TcqhltSncULlc3AEiuLS0JOg
         7GIC/aafU9t0/Wv87mMdZ4URzecbsxshNlbEeFlW9hKCFimjeDwGhuP6b2Ag32Hku9hb
         K8Bt3bFPOFRoQwtxi8RdOkFsUDRo/43zckCcCwfhveCnzOSAMJEtzWmnUIL+dX3GHc5n
         S/JF4eNWv16mhlaaf5uoMKT00jGZyvfdbk5mRJOKoXoIDPMN6dazZyhCOBz5u0BKy084
         lYSg==
X-Forwarded-Encrypted: i=1; AJvYcCXgD/L4/q5zhdRbDwmdQWH51CgwFJhWkIfSPjudLfjwa4cKpt93JJbM4dmg6vmVP7Pcs/tYHB/po9hEiyj4+pZcU0/pUDdTfZVVT/qCw2E6Dg==
X-Gm-Message-State: AOJu0Yzk0JX5SYg8Pe9ziT6fHUaphl7cv+nWP1OARCUvEPpC7jVb288U
	sc+bI9rdhKPotwAaxIYvt9OlrnmGzDNnGtRnnlKIFqBsLbTcAa0gPXe0U03z5zhvUFCk3T1jCmM
	e379Ew2qJcoW1taYzH4VPFw664yUEf45hEEv1
X-Google-Smtp-Source: AGHT+IEsoCQPqVzJEWJkUcjD/b+B37rNwRY73AmQVN2jEMdyV1hGWH6jIVGKzGtm6hPF7a4AdUxbzQStyWbvN1VfYPs=
X-Received: by 2002:a17:903:2282:b0:1dd:6e0b:75fb with SMTP id
 b2-20020a170903228200b001dd6e0b75fbmr74752plh.9.1710985838761; Wed, 20 Mar
 2024 18:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320193115.811899-1-acme@kernel.org> <20240320193115.811899-5-acme@kernel.org>
In-Reply-To: <20240320193115.811899-5-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 Mar 2024 18:50:27 -0700
Message-ID: <CAP-5=fVmB=E-MMyhA2WBQV8OLcPH20tw+11XjCeecMU6hce5jQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] perf trace: Beautify the 'flags' arg of unlinkat
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 12:31=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Reusing the fs_at_flags array done for the 'stat' syscall.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-trace.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 58546e8af9fcf481..ef0dfffd99fdf3cc 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1171,7 +1171,9 @@ static const struct syscall_fmt syscall_fmts[] =3D =
{
>           .arg =3D { [0] =3D { .scnprintf =3D SCA_FILENAME, /* name */ },=
 }, },
>         { .name     =3D "uname", .alias =3D "newuname", },
>         { .name     =3D "unlinkat",
> -         .arg =3D { [0] =3D { .scnprintf =3D SCA_FDAT, /* dfd */ }, }, }=
,
> +         .arg =3D { [0] =3D { .scnprintf =3D SCA_FDAT,         /* dfd */=
 },
> +                  [1] =3D { .scnprintf =3D SCA_FILENAME,     /* pathname=
 */ },
> +                  [2] =3D { .scnprintf =3D SCA_FS_AT_FLAGS,  /* flags */=
 }, }, },
>         { .name     =3D "utimensat",
>           .arg =3D { [0] =3D { .scnprintf =3D SCA_FDAT, /* dirfd */ }, },=
 },
>         { .name     =3D "wait4",      .errpid =3D true,
> --
> 2.44.0
>
