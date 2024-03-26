Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C356913C91F
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Mar 2024 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469641; cv=none; b=RVo04N/QYpibogVEdPwZSJagHg1ysI/uPaQUPy0IUH6rX8ztVn/agz4s7Vw9fcESb+BqfWJNl0r9tMzCMe7UzS0owAYOs6cHu8mItqyXGi9sNTsTchiEclV8/P0PY2SUZ/iCASB71PRCKEXG6nMhtYiZZRuW798W2t+3j4CLQH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469641; c=relaxed/simple;
	bh=cZoq0o7ad5PeIU5Dggn5JwU+BryvvaISPpzzmhX/QyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=osLVgRAZ79NGVmL4Lciw9SgWylwOXCQcZMtSL8QxKQXDljUX/8lpGNaze7jqhXRyKi2EwXreBAfYHQJUef4xYdt3GVAYoCgJeP0DOrlMbuWaH40kcIeJQ5MUT35+FdDcMzilR2HsVImyszC0UlvLarrGmtUV+RXGVAI3kvut75k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=apOwC4P3; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="apOwC4P3"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-430d3fcc511so324621cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Mar 2024 09:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711469639; x=1712074439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbMtObAheSsAzdeSiEvX6OHpKYNeToJOIcYIcWYK+c0=;
        b=apOwC4P3vOo8z9UmsVCnfxjW3v/4z6uVxQpHwAtE5PDjqfWVrb4zsu4K/Cl15lZfzf
         twdHn4beF9GxwsN2sFf448gZ5MvdLDJc7C8nsL5TKGf7gODcwngSdqLCLz1IbUfyZuKV
         E+abXPTyoxL6DGjWMHdYB3kjHtILDvmLvwlpOVBG0DYyHYGK2cKvWFrNedb0aroRqYbP
         XSwBrhG9MDSjFJK6ourcXJFKtg4e95X+T0nNzhzpVAUh08c3kRm7hE7mrg+jBoo5MHJS
         5BaJQLFWCLNejg6pjQT4kn/sCXQFzk666Bifv4rEIQ2W0kc7jwRFq8YREUxkxBFwz8GT
         R+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711469639; x=1712074439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbMtObAheSsAzdeSiEvX6OHpKYNeToJOIcYIcWYK+c0=;
        b=X04lfzc4PL7Wl2wgsRd8wCbku2Ry+aZmGF+7sevRp0VeD5tAxpk6181j5kadxtv6LY
         bdaBh48shBNGQHdATcDERIiMQRbWPDmE5286UnOQprKZ5VJVdSH4gGg44E8WmvK/ZTGH
         4ba++TdZdPQchQul/IL5W6B7rKlvK3qXkCeOAXF6K40vQwJ6y4QnI/GwuM4lnq0B+9lR
         8pZT9BLEFSRVLQEschvngsQlD3QOAM7Yv8CUA5vzMS0v1gYZG0RZO6Y5tsjVPxHj29Qj
         LHbQabqbgOgnTrOFx332XcTAusbEfALIstgBTaHicDckO4OGzdO9+z6/d9ab952Uc60U
         F5OA==
X-Forwarded-Encrypted: i=1; AJvYcCWR/zoLKVweJiVFf0dFejV8yK+VLnBHho/NILh6Ty8V0K2MaUJHRPkMgp6FUlD/8mhuW+caMM36VRe4FGeA7dMYAZWeLCjijcqP1Op5t6hOtw==
X-Gm-Message-State: AOJu0YzFNyd+ApMIR4ENBi81lKVgtGHA/nKxRIv9Yh7tncGsH8IjUJ+z
	ozG7Q4e35rPc7azVJvIAQeimNGe1tPZQ0DssyiIg6qOSzdPKpEnpLRTRb/51AuJd84QIj9VGZnV
	oPMKjRcNu0sSr9DNec75qkDgcywTruUL8SBoj
X-Google-Smtp-Source: AGHT+IEqVSh9DxVcvxp7ujQTBkubsreCdaJFgDje9+tSP+o3LivsvPLSae+Aa0KdBbQeSQ5zMDQOVyZhHu7658VlZ0U=
X-Received: by 2002:a05:622a:510b:b0:431:3477:1b1b with SMTP id
 ev11-20020a05622a510b00b0043134771b1bmr279349qtb.24.1711469638547; Tue, 26
 Mar 2024 09:13:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320162619.1272015-1-irogers@google.com> <20240326083223.10883-1-adrian.hunter@intel.com>
In-Reply-To: <20240326083223.10883-1-adrian.hunter@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 26 Mar 2024 09:13:40 -0700
Message-ID: <CAP-5=fVbR8xvFvG_cnzq6==QbZ1wX9mPT-RWHEMgaTp6ic0jNA@mail.gmail.com>
Subject: Re: [PATCH] perf intel-pt: Fix unassigned instruction op
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 1:32=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> MemorySanitizer discovered instances where the instruction op value was
> not assigned.:
>
>   WARNING: MemorySanitizer: use-of-uninitialized-value
>     #0 0x5581c00a76b3 in intel_pt_sample_flags tools/perf/util/intel-pt.c=
:1527:17
>   Uninitialized value was stored to memory at
>     #0 0x5581c005ddf8 in intel_pt_walk_insn tools/perf/util/intel-pt-deco=
der/intel-pt-decoder.c:1256:25
>
> The op value is used to set branch flags for branch instructions
> encountered when walking the code, so fix by setting op to
> INTEL_PT_OP_OTHER in other cases.
>
> Reported-by: Ian Rogers <irogers@google.com>
> Closes: https://lore.kernel.org/linux-perf-users/20240320162619.1272015-1=
-irogers@google.com/
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Great, thanks! Should it have a Fixes tag like:

Fixes: 4c761d805bb2 ("perf intel-pt: Fix intel_pt_fup_event()
assumptions about setting state type")

Tested-by: Ian Rogers <irogers@google.com>

Ian

> ---
>  tools/perf/util/intel-pt-decoder/intel-pt-decoder.c | 2 ++
>  tools/perf/util/intel-pt.c                          | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/=
perf/util/intel-pt-decoder/intel-pt-decoder.c
> index b450178e3420..e733f6b1f7ac 100644
> --- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> @@ -1319,6 +1319,8 @@ static bool intel_pt_fup_event(struct intel_pt_deco=
der *decoder, bool no_tip)
>         bool ret =3D false;
>
>         decoder->state.type &=3D ~INTEL_PT_BRANCH;
> +       decoder->state.insn_op =3D INTEL_PT_OP_OTHER;
> +       decoder->state.insn_len =3D 0;
>
>         if (decoder->set_fup_cfe_ip || decoder->set_fup_cfe) {
>                 bool ip =3D decoder->set_fup_cfe_ip;
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index f38893e0b036..4db9a098f592 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -764,6 +764,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_in=
sn *intel_pt_insn,
>
>         addr_location__init(&al);
>         intel_pt_insn->length =3D 0;
> +       intel_pt_insn->op =3D INTEL_PT_OP_OTHER;
>
>         if (to_ip && *ip =3D=3D to_ip)
>                 goto out_no_cache;
> @@ -898,6 +899,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_in=
sn *intel_pt_insn,
>
>                         if (to_ip && *ip =3D=3D to_ip) {
>                                 intel_pt_insn->length =3D 0;
> +                               intel_pt_insn->op =3D INTEL_PT_OP_OTHER;
>                                 goto out_no_cache;
>                         }
>
> --
> 2.34.1
>
