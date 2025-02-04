Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA6F21B8F7
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Feb 2025 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738707127; cv=none; b=KhHhhjX68JoTvcU4OfkJtacwzuB1Tp4SUem10Dg54vrhSvcngjBwwExwzyG0kSYRuatXRotV/2CTg/1kjnCcNsRVUgPiCi4FeVuyiIpU2iNTNM/PaPZg2KL1TFP93PMtsh9uziX0+BBHBe3H/hNBKQF7xgip/5UAPNLUDlVBu/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738707127; c=relaxed/simple;
	bh=SbLZ68tAhC5lFgZtcuTaO/ZN0INdq9R0NQBPg+Z5DFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NpNlxtfrVyLBpNMf4BDnPFqI0yS45MWy89MEQDD7QrpbnQl3xjLmS50UAnrnhhEsYF/Izna1c30T2vgXRSYUpBOHJFiE7sfKNnZpt7mVnUyUnLgaXZsH3etug1/E+wB6mHn9n09TXxJa95PINFotUI5fQS5d0l1+INafg5HqzO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nVynHzuW; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nVynHzuW"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a814c54742so208945ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Feb 2025 14:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738707125; x=1739311925; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/mabsTbGHPnjmk/SSrj6+QXhLg6a9ZtIdxHvTtU05I=;
        b=nVynHzuWoGCoJyW7xwTNOoZIiv0uXXCx2pBX8chpfmLFw7qwZH/0Q/dxuwTUwCNneR
         ncCk45Itrs3KV8KuG+52pxABpO1SYPxP9o93NfksEOqSj/6iaoPeqN+0zCWJkOGARy1G
         839+pYc/edN5GaVHHoUYJdHqdPC/uMz/kIflhCSbjmO2HIf+0OSXhDjE8Y6g7l/cJhom
         3gNxV78TcH5B9wfAPhY7I9KzQ14Hrcqg28sVhN+Z7yeyusUCOAwrXNBjx6lv3G5miqWq
         7ywaFYLgCnVS/NrNJwm9CdHB0i9pkAF1s1rf4bUUu80LIGKqnLtEp/QlmZF7Qr1tAKul
         NrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738707125; x=1739311925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/mabsTbGHPnjmk/SSrj6+QXhLg6a9ZtIdxHvTtU05I=;
        b=saRtuMIrYYQvfhEzDuma4LAv1TIZP8qSBmNZFxrt8GPQniJc2UVEp4lRdrCaLuZBW4
         ZMrc2Qk48SJfNsIGxUC68wPXaB8S48ecD4+qvXZzv+tiWvqzRzm31ucD4HR4nPa8PNS0
         nHBhG7yApR17sB1UtV2D1BGMrX25SJjN8zfM12zdZKyqfQ5mZFdKxb0vPydXj4Gt/aVA
         Ut0EA0VxFStK/GCfzrRnuiqV5fjuCoUBZAmd1JKM+ECLEKl42BFqB2bAdcf98BnoHhgR
         4DN650vZAgVwkPozEm10HXvhINKZlLgUAJI/f+9KDy/I/WJmGaC4MZSmt4MYdT+5SsUV
         muMw==
X-Forwarded-Encrypted: i=1; AJvYcCW/qgLhPVzj0ChO1oUGyNc2/1hY69sEEvjtepmcvHV1kZxzb9xyf7BUFqFLo2ecgewiP529SypWOkjzr1rCYpsS@vger.kernel.org
X-Gm-Message-State: AOJu0YyzQZXoUO9Qgw6tsTNR38MMbTXYFax/iPL44rRMJjcGE19C83Mf
	DrdjftVdIaT0DOCc+DpaC1bI7EIJ2jNqzLApc9y6PAP8f29AxZ/DVq7RV3VRREWm2FtEtXz8Loe
	hJBskArQ11QBMLYeHS+0ftdKhGGrkZnL7GrDxt/rPVOSRAo7hUDVv
X-Gm-Gg: ASbGncvlFsyQXExLkWmRZKtVyMXHbXNEB+Wg35cSnyTxX5sEPPfUkGsZmXHkNY7JCJR
	rdevitJxIHbV5b4spAPwYUfZ925QAINjbc2JloZbsRZy5r8usOgmsvuxxOmJTfApN+RBb7umkFo
	esSadH4rvAXqJ6oUxMFWHVMpxG
X-Google-Smtp-Source: AGHT+IHCqfuQxlxRFIOqBg0Vyk+jZXnF9w9c2iMxC/uqr3v/B1PmhbPUHlVtsCSV6GtaamNuvvJEshElFckumyCN2Nk=
X-Received: by 2002:a05:6e02:308c:b0:3ce:464a:fd2d with SMTP id
 e9e14a558f8ab-3d03fc66229mr6644715ab.28.1738707124763; Tue, 04 Feb 2025
 14:12:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204220545.456435-1-linux@treblig.org>
In-Reply-To: <20250204220545.456435-1-linux@treblig.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Feb 2025 14:11:53 -0800
X-Gm-Features: AWEUYZkvzQ0ayiW3iNRNnoBXWUOm6Kf4sscZUaDumMp__7gNxeLqPD6PSxm_58M
Message-ID: <CAP-5=fWMp-ePPHUsBD_pe5NPoyCpHVZ2gzSn1HRyu_gO3Ghmkg@mail.gmail.com>
Subject: Re: [PATCH] perf: Deadcode removal
To: linux@treblig.org
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 2:05=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> The last use of machine__fprintf_vmlinux_path() was removed in 2011 by
> commit ab81f3fd350c ("perf top: Reuse the 'report' hist_entry/hists
> classes")
>
> mmap_cpu_mask__duplicate() was added in 2021 by
> commit 6bd006c6eb7f ("perf mmap: Introduce mmap_cpu_mask__duplicate()")
> but hasn't been used since.
>
> Remove them.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Tested-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/machine.c | 20 --------------------
>  tools/perf/util/machine.h |  2 --
>  tools/perf/util/mmap.c    | 11 -----------
>  tools/perf/util/mmap.h    |  3 ---
>  4 files changed, 36 deletions(-)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 2d51badfbf2e..321cc110698c 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -886,26 +886,6 @@ size_t machines__fprintf_dsos_buildid(struct machine=
s *machines, FILE *fp,
>         return ret;
>  }
>
> -size_t machine__fprintf_vmlinux_path(struct machine *machine, FILE *fp)
> -{
> -       int i;
> -       size_t printed =3D 0;
> -       struct dso *kdso =3D machine__kernel_dso(machine);
> -
> -       if (dso__has_build_id(kdso)) {
> -               char filename[PATH_MAX];
> -
> -               if (dso__build_id_filename(kdso, filename, sizeof(filenam=
e), false))
> -                       printed +=3D fprintf(fp, "[0] %s\n", filename);
> -       }
> -
> -       for (i =3D 0; i < vmlinux_path__nr_entries; ++i) {
> -               printed +=3D fprintf(fp, "[%d] %s\n", i + dso__has_build_=
id(kdso),
> -                                  vmlinux_path[i]);
> -       }
> -       return printed;
> -}
> -
>  struct machine_fprintf_cb_args {
>         FILE *fp;
>         size_t printed;
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index 2e5a4cb342d8..ae3e5542d57d 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -266,8 +266,6 @@ int machines__create_kernel_maps(struct machines *mac=
hines, pid_t pid);
>  int machines__create_guest_kernel_maps(struct machines *machines);
>  void machines__destroy_kernel_maps(struct machines *machines);
>
> -size_t machine__fprintf_vmlinux_path(struct machine *machine, FILE *fp);
> -
>  typedef int (*machine__dso_t)(struct dso *dso, struct machine *machine, =
void *priv);
>
>  int machine__for_each_dso(struct machine *machine, machine__dso_t fn,
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index 43b02293f1d2..a7ef4d8d57d8 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -356,14 +356,3 @@ int perf_mmap__push(struct mmap *md, void *to,
>  out:
>         return rc;
>  }
> -
> -int mmap_cpu_mask__duplicate(struct mmap_cpu_mask *original, struct mmap=
_cpu_mask *clone)
> -{
> -       clone->nbits =3D original->nbits;
> -       clone->bits  =3D bitmap_zalloc(original->nbits);
> -       if (!clone->bits)
> -               return -ENOMEM;
> -
> -       memcpy(clone->bits, original->bits, MMAP_CPU_MASK_BYTES(original)=
);
> -       return 0;
> -}
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index 0df6e1621c7e..4d72c5fa5084 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -61,7 +61,4 @@ size_t mmap__mmap_len(struct mmap *map);
>
>  void mmap_cpu_mask__scnprintf(struct mmap_cpu_mask *mask, const char *ta=
g);
>
> -int mmap_cpu_mask__duplicate(struct mmap_cpu_mask *original,
> -                               struct mmap_cpu_mask *clone);
> -
>  #endif /*__PERF_MMAP_H */
> --
> 2.48.1
>
