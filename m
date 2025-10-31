Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C731A2FC891
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761929791; cv=none; b=eRt1MeLLXYxr+QHE4ebaJv5yCmnspflo+5AI5Md4UhAdhgye00JvL2egvy4QkGYqbVA4YYXCEIASdaiNBhf2Dd4Tt3pbTUf58bGR2mczMoAQV0dUqvimddE1izPfcNjE3B72BKFuczgKgZ1DmjpjAMTffLusVP5hJoZa8gQcEJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761929791; c=relaxed/simple;
	bh=lkiO8XrUOZOmOcIFgJAFhtGKZWzU3bVRktX8oPYM5CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhOSxu1mRYWZXgMlbssUjPfhYfOKquHMLvDYgSWKSpyk3xP2OdqpcWbp10JjABkLr7njZntoVMzbmbPyHUU3a0KpwdxkCC2x/ZbGCkQ1Td38yXMrSrLgpoX2D7YyNwU94jMayQq/w8BLjEN3aZWwCTnqOGivjtRoyhNNQTn1Auc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lxD7e8Cq; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lxD7e8Cq"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27eeafd4882so6205ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 09:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761929789; x=1762534589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orEjtXAHj63cwii1Ewu/bOztRrLitJVVFzVJhGPGPvY=;
        b=lxD7e8CqaMJnRgSOY9ZtP5qSUPRiHwNshRTXXbo9XQlQn1jYw1eZfnP/tRmGh/GszD
         ypZMw+aG8oaxfnqxBUJS7F+PZQm9Xxy3AdqBHDAgxu6Zto9D9o5T+I2zJml3L31XIezh
         H55RRs5WAsMUEWlNmNPmo0SfrkpIWsKMOeYgE/fMcsrtedkQjzx32+3zqrp5PuR1h1vP
         +D4xRPr4/RJBgQ6/FzCwlbEizcZqvXT0OMrqdQv+OCFn3HU1ofFL2xMYLdsxDFeLERpw
         KOjMx7HUtLkosN2i6y702EWCdLDIeQBK/lTcYpgFnN5W6aewOqpL3B4sLSTlwFKqwdfa
         7PrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761929789; x=1762534589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orEjtXAHj63cwii1Ewu/bOztRrLitJVVFzVJhGPGPvY=;
        b=cwzxPaWP/xkDeeng6YsG+gIQGxp+Khf9HVSVXnb6DbUfx3Fq6Z/RYCa3CzTPT0c+RA
         tXDND9tchnyWXg0Q7UXrLxCJedWtMiuqaFW3RUg8G6MKWZxrlsITCRzmqFdk/giLB620
         cSVlZA0pkgO+1XRDtI/5GTeCDSwqNDMUPrulVlwnAc65Msqi9ecZReG8gIx7iEIHuAd6
         lRXHzJgZ+Yop7u9l/KU9zu4oK0U62GVnz8V5BTfi/kASvrczebXstChJ+YU1qpeaTPfm
         XtQsDtJgszJ4XVsgWQlQfXsJzc/egDyUdMQkyDQJqVvIkxqGNqOubPzfAiugQLQiz7Wd
         HCwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoUQvlXR61H0DW/TsBad7kjtCc0PHDyycc0b6XhV6xrm4zw8pNu4UN76PZbN4YrqmA31l1z43DrZvXWRIOxRcx@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfo5lAnA1FV3T3pv23k3BEgRi7poJfWcjILPRQbmrukerxig7w
	T9fUPTWlErGWr5orgcsdDt8PY9jEroI0PRzOMPNCgQ88DHFkxjvc2S4e0ZnUWI73fCC6NZPKlxx
	NJ+TogtCYRP2tgK6YB0wP+UwRv3Mr9JxfxHTxJcFG
X-Gm-Gg: ASbGncs2q01vGV4mU6C67DXOiSF2H1O0N9R+P0vk6SchrKtpC1arb8uuY02MjqCsubK
	I8/JhBpOhsmmTdeoUKfxTCoAORIuMnrC3+w8E62Au8rOHQBjDRvd19tGAP53IfJThk+LRntdvyG
	2i+kAeotu8h5aSjCxwsyiUZvUdLDDw6hGJX0SXFgjE+OvkVHpEdWcOpv0BMmr3c1wgUuD1k9uyR
	uv871/xD8qqbXrgQxmrGfmlcZ26a+s5EDRpmBrFWKyZ19aGDU92SfzDdT/+TsEJg0sKwMydudcy
	JZahW8lNCK5nHJw=
X-Google-Smtp-Source: AGHT+IEsPnPxFIN1hYlO+t/wmUYP6y9esVa2ldoa9AgpQzw0BQvhvOGZ3gJe4GC0IHDy7KEHxRaubt0hT/sM3EKgjeE=
X-Received: by 2002:a17:902:f60d:b0:295:28a4:f0f5 with SMTP id
 d9443c01a7336-29528a4f6bdmr2781575ad.5.1761929788793; Fri, 31 Oct 2025
 09:56:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030040140.1115617-1-namhyung@kernel.org>
In-Reply-To: <20251030040140.1115617-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 31 Oct 2025 09:56:17 -0700
X-Gm-Features: AWmQ_bmyg0Pz25RVawZdFY6E21GseqbValX9xKWlZmhN4wDaYncuilO84HOs4xo
Message-ID: <CAP-5=fV3H234wnVkmf04kyJYb=M9gUtZbHigrc7pQKYUXoFSzg@mail.gmail.com>
Subject: Re: [PATCH] perf lock contention: Load kernel map before lookup
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 9:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On some machines, it caused troubles when it tried to find kernel
> symbols.  I think it's because kernel modules and kallsyms are messed
> up during load and split.
>
> Basically we want to make sure the kernel map is loaded and the code has
> it in the lock_contention_read().  But recently we added more lookups in
> the lock_contention_prepare() which is called before _read().
>
> Also the kernel map (kallsyms) may not be the first one in the group
> like on ARM.  Let's use machine__kernel_map() rather than just loading
> the first map.
>
> Fixes: 688d2e8de231c54e ("perf lock contention: Add -l/--lock-addr option=
")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/bpf_lock_contention.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_=
lock_contention.c
> index 60b81d586323f379..7b5671f13c53525d 100644
> --- a/tools/perf/util/bpf_lock_contention.c
> +++ b/tools/perf/util/bpf_lock_contention.c
> @@ -184,6 +184,9 @@ int lock_contention_prepare(struct lock_contention *c=
on)
>         struct evlist *evlist =3D con->evlist;
>         struct target *target =3D con->target;
>
> +       /* make sure it loads the kernel map before lookup */
> +       map__load(machine__kernel_map(con->machine));
> +
>         skel =3D lock_contention_bpf__open();
>         if (!skel) {
>                 pr_err("Failed to open lock-contention BPF skeleton\n");
> @@ -749,9 +752,6 @@ int lock_contention_read(struct lock_contention *con)
>                 bpf_prog_test_run_opts(prog_fd, &opts);
>         }
>
> -       /* make sure it loads the kernel map */
> -       maps__load_first(machine->kmaps);
> -
>         prev_key =3D NULL;
>         while (!bpf_map_get_next_key(fd, prev_key, &key)) {
>                 s64 ls_key;
> --
> 2.51.1.851.g4ebd6896fd-goog
>
