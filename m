Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A23786342
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Sep 2025 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758319413; cv=none; b=MS7oqqQ3VsEGSCJoNhh1Wgbd0X8M84H9WZ/vOH2AyG3+DfWzWZ4h8fW9RZM4aZ/Ui5Q2t0d7T+1Mbykxu3T+migyU8IT6RLI1ovbUBcNYO/eqrKjS+glWhbHYesPYQEiIpA9xp9IfnxaLevgPzs7sWPvPstUA1yNWH8TQPpZ2sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758319413; c=relaxed/simple;
	bh=pCHucsLT5P3ZsgU0T7z20r2f4B/eHCIhX5LArsOJmuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+lKhBSRTm5cTVusCAxv7154zR39ugFZ3uEn32ikTJ0sxI4XtlCKFr5PXldXktEv72iwZ8sdefqUb0PEmbqqHTqBay5GU5nLAGMI2fR0tqgK2MVE992nb2GnurvG+S/ai63qYfeH9Yfkr8LT5hJpOkLUsMx5GQefPPi/saOOtMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LDaisk38; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDaisk38"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2699ed6d473so58715ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Sep 2025 15:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758319412; x=1758924212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKiy/m0+cOmNMee9GUcfQ4T1DjGRK2p5T2fy+Za3D5c=;
        b=LDaisk38ETIrdLNa8Jgmlg/vcX2YOLpD3895ewKWJ6J9Rv1ITGWGADMrJYgsu2oCjJ
         aLvByWG9X02L7XjQ8nyB/4GGajBuBbwi/8f8OqgyZZsCBubW8gErEHdJyeLTlItnwN0U
         OUwQlxNZfRX1oz2/BvGhfN1O/OyRmDTUn7fsymuUVwbkiujihZg/LTz8Gv2Rz4SruoGt
         sn8TzgkOrTeT92HVAkbW24uO+yF+bgiwkveNSaGuHQncKjyVSp7b1MPklQGnt0BclNBX
         u/BJehL2weRvudkb3jmp/RBU6b8rDsjux12lbizYw8hfp5BwVXLEL8UzIoUunp+w/f/S
         KUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758319412; x=1758924212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKiy/m0+cOmNMee9GUcfQ4T1DjGRK2p5T2fy+Za3D5c=;
        b=ZltCTDkaHSuGlTR+MyEg/cGh/hCAyGPnFNmfumJs3qK2a6BMjIDbj8rx823PSzZkUF
         UZw7XYz8Ei63MEr8VeWVxaQuo4jcJVs4WFUzu69KqIbg+U2Lm7HROj/Ca7aFZGoT65p7
         DLy1Q6ERFCZDJSBonUJe2yq9e51c38gows0RAVhDyHm7zJ5DRYD4767TAhZxzr6ePmcz
         ULLku4C1zz7yd2WaXBx9hHbOgsFBYazJ1whRkKvp+6MFMvhYUH8aLp1IRECfdFsm2FUf
         PFliliKoMfY7tAT9Zjehvqg2Y9+qCZhYwMeyS9blBfJVn0IcPqtdrTQRC0xwYD5KiPHJ
         WXIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP+3auZArghMeZw1AKNBurmEsSchGrNQiLa3vnpI3c7okIEcH1efvO85VPhOJk5DtdQ/myAieDH72y+1onUjGo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9q0xgcPCEZOpdSyQfmM3OU2UUB4RF6oDWQihhgnXzKIf+osq7
	I1gPjJ9tnvxmrjkyfCrGDzIwz0RJjVH9UQ6ZKLCyCQJVWmm1EUrGPHlIszZsOSnOuEL5yQ4E7PG
	qm32lTVm6f7Ag+bC4+9foZwyFMqcSdh2spwM8iTNl
X-Gm-Gg: ASbGnctUWM4pAO5QD19xXUEFpEJLim9u8XyHQghXr2PmGpVbjjRyaFbCOREE6hT2hHb
	pJTFy6youQjJEocc3Rg6gimBJOEDlft4YWsqe16QfsTxNGDxyvgn3Q5BPA485FTEJbv7Q89OK5f
	iQkmNW9Apc8LvPvqBHNMmrnZwRQxInIKM1dE1TxXMTiaAwNB1dMoxwBcbb90GUoVgbqf4ImG4Yy
	FZrwat5
X-Google-Smtp-Source: AGHT+IFxce0HLNf3NmhbLRlCJ9F+PK9cigxmx8jIuBWo3JRMbzF/75YM/UR0mgu+t4nd9d/RKhL7wrOwbbxrqB0N/OE=
X-Received: by 2002:a17:902:d2c9:b0:266:b8a2:f605 with SMTP id
 d9443c01a7336-26808a2fc00mr15448915ad.3.1758319411403; Fri, 19 Sep 2025
 15:03:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919210654.317656-1-acme@kernel.org> <20250919210654.317656-3-acme@kernel.org>
In-Reply-To: <20250919210654.317656-3-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 19 Sep 2025 15:03:19 -0700
X-Gm-Features: AS18NWBBr_OMapccE_pePLiwwGgPyzXXthzaFZOsmjG_0k6N9qe5Q5gO2X5Ymrk
Message-ID: <CAP-5=fXQSA2PWCWQh7d7ou77pLvk9QcicnJc303+C_vHr2Tb2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf bpf: Check libbpf version to use btf_dump_type_data_opts.emit_strings
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 2:07=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> When building perf with LIBBPF_DINAMIC=3D1 on a fedora system with

nit: s/DINAMIC/DYNAMIC/

> libbpf-devel 1.5 I it was breaking with:
>
> util/bpf-event.c: In function =E2=80=98format_btf_variable=E2=80=99:
> util/bpf-event.c:291:18: error: =E2=80=98const struct btf_dump_type_data_=
opts=E2=80=99 has no member named =E2=80=98emit_strings=E2=80=99
>   291 |                 .emit_strings =3D 1,
>       |                  ^~~~~~~~~~~~
> util/bpf-event.c:291:33: error: initialized field overwritten [-Werror=3D=
override-init]
>   291 |                 .emit_strings =3D 1,
>       |                                 ^
> util/bpf-event.c:291:33: note: (near initialization for =E2=80=98opts.ski=
p_names=E2=80=99)
>
> Check the version before using that feature.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/bpf-event.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index 2298cd396c4235e2..59f84aef91b4a2ec 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -288,7 +288,9 @@ static void format_btf_variable(struct btf *btf, char=
 *buf, size_t buf_size,
>                 .sz =3D sizeof(struct btf_dump_type_data_opts),
>                 .skip_names =3D 1,
>                 .compact =3D 1,
> +#if LIBBPF_CURRENT_VERSION_GEQ(1, 7)
>                 .emit_strings =3D 1,
> +#endif
>         };
>         struct btf_dump *d;
>         size_t btf_size;
> --
> 2.51.0
>
