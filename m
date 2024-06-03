Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473C112C81D
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Jun 2024 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717432381; cv=none; b=Ged9Np3TCIA03KS0nMrpNNFI2IVa7XK31YeVKX09x3yvxcElgO5rWTAb4mlDVxpbv1BLeKLlJr2fkqp/m2b5kF9CXBvnzEVaTRTQUMZ6jd+whdADskQsFeKm5FgEoEJr0a1IVGknNwmOiBoEF9s6vzNoOWQwxZXbI0eRdF6RWIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717432381; c=relaxed/simple;
	bh=SwyAAsQo5LPigjyVrJh9TE3RAcBQUO6hlyM5El9jJtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tc/NZlUetoe6G4kIyZ2f9nxtHAE/ZQjJSdigqhGDgBiJtwTV9JSIospEUT4MTy3sTVqSZrkKnZdI/G61X39FTtrNgNV78l4dS+hAj1kt5rU+aOgMLY1VJwj207TWi1GO8feSoX+qIbTg/QOb35iXqTXmsfGv7B0dV9KG7oErhQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vhbLN/BV; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhbLN/BV"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4400cc0dad1so1041cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Jun 2024 09:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717432379; x=1718037179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjXuAqR4EYQTQU2Kd98gpGTnvGi9iTYHYeoY30Mkzb8=;
        b=vhbLN/BVxX5n5fC6Bn33MNJJ87nFvTvdt9ieBJvPxfnPcw4llbjKS5xdwNVPILTTR8
         kpK2gu8OBgeKsQtHzgAXXipx6Q0ZSuibbz62c0k8LH4OUA7hwXU44W68kC+B8QIo59J2
         If7Aj6x9d7sasIrFVTbuGhK6R73QY5x3U5C7ChjbPjaifdkPt+JOn5+rJdZetZRnp3co
         xSb9iBJovr8E6AenzZuhBMz65Pr3kP3D9O6iJcpDv//UMl1dVHuHWD5MPbPG7zGU5QcR
         lXjemL7EoHY4cPalSJFYf8E6/9bfHLHFmHnQh/r4KnKpk9FHAWH/iTlk3p9bJQCulT5k
         HbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717432379; x=1718037179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjXuAqR4EYQTQU2Kd98gpGTnvGi9iTYHYeoY30Mkzb8=;
        b=XMJ9AVX488Z1OBBO9rKTjY14jqAug2FIbxU1kyB7TbrfCUCZq2imckHePEi2bPT96+
         DjWJ0VspTjZpehvOMi8DXanlkIP0+Ds8Wzx3Wc7Sx1t+MyFv0YnxhzS/L1XgjxEED56g
         +H8QZVWJyjryeylC5x7RuoirCF2ElU4w2Y1P1CL8fK0IljBpO68yr+2jG9O7jL3NO4v5
         6UFAdxTUgeewl3TyEVAuBFL7811q0AenL88Yg82sWAN2/wg34bUuOV9YU11Puk92uDd9
         wwjn3W9XPNVYdVZVy3y/Vg6V5nmeARRAaCwsMJ+LRMOz0nhFtGjx1XpMuqMKnzk2Wg1v
         OIRw==
X-Forwarded-Encrypted: i=1; AJvYcCWndFuypLlBfaB3RrE7RZWcbWewhJd2GSSTNlfirP+vSEw2/QtLQoF2SDCsGoZcNhOXVoNODOn8d3nDqUnJas1g0PuhfOv/fpOMZEoJQKHnpA==
X-Gm-Message-State: AOJu0Yw/yTqppNdf5b9C/N2Q+5J/rLfe9UxdoD/hHqRuamo96RNFQGSH
	hgBLcpCS1RuQYx1lmutU7mEu7F2F8Zw5n6wHmTK5uUfyfDVHOUDxK/XIn22bmgeXKl7bTx8I7AE
	yxljQW854888TQU0YpoMZJWPFbJ0tBhPhbUxh
X-Google-Smtp-Source: AGHT+IHJuWInCRTDMlvTj/RdEeJeBxSy/8tT4IotZuca6cMAB+u12gC4Z3gU+2rP8k1Jw6COZaoHA2CUJ2x6Vz27V7s=
X-Received: by 2002:a05:622a:a709:b0:440:3e3:5730 with SMTP id
 d75a77b69052e-44003e35ac3mr2074601cf.14.1717432378882; Mon, 03 Jun 2024
 09:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602000505.213032-1-linux@treblig.org>
In-Reply-To: <20240602000505.213032-1-linux@treblig.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Jun 2024 09:32:47 -0700
Message-ID: <CAP-5=fUbtFd2V=cjSHd-KgFmrGQnncS5p7FXTNpL5kA+19qRNA@mail.gmail.com>
Subject: Re: [PATCH] perf genelf: remove unused struct 'options'
To: linux@treblig.org
Cc: peterz@infradead.org, mingo@redhat.com, jolsa@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 5:05=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> 'options' has been unused since
> commit fa7f7e735495 ("perf jit: Move test functionality in to a test").
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Hi/thanks David,

Reviewed-by: Ian Rogers <irogers@google.com>

Ian

> ---
>  tools/perf/util/genelf.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/tools/perf/util/genelf.c b/tools/perf/util/genelf.c
> index ac17a3cb59dc..c8f6bee1fa61 100644
> --- a/tools/perf/util/genelf.c
> +++ b/tools/perf/util/genelf.c
> @@ -54,11 +54,6 @@ typedef struct {
>    char         name[0]; /* Start of the name+desc data */
>  } Elf_Note;
>
> -struct options {
> -       char *output;
> -       int fd;
> -};
> -
>  static char shd_string_table[] =3D {
>         0,
>         '.', 't', 'e', 'x', 't', 0,                     /*  1 */
> --
> 2.45.1
>
