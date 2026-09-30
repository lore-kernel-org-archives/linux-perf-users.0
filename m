Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB275208BA
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790354; cv=pass; b=jAxaNFsIDIbbR95kVkrb7TWBvShbAFLCTv9Fcsws1iq/Uwb3nkxK+L87dYBlrq/1qMYPvoPSrIlAUptftNInRuLCnwEG+7Htn2zxx9ObhgDy6xMRc4EIngxVkGjvmZpsn/Foy7LbTo9RpzvHLk4pLI03tyM6f8EkEN+A9G/ritg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790354; c=relaxed/simple;
	bh=pVumn0Fo0Z/w/+LO3c6ave9SWS9g+8WQZ+u7BTWnxvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vm/kXVqvbavWG7Nbs3ESiHMZtR3/OW9d1ahyWxTTL/AcMGwbUIvb547ThhaxQ1qturDHk89IMWJkhm+LxVAQSNR/YbNdtz5KT9MYyuT+RnfFeBxVf2XWl6K0MsR7CP6jDbmgK3tDEgRM+TumMVR9FNGfkfB4Csv3tzsPuAJoFsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EJFjUS/o; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EJFjUS/o"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e2e4ef20beso6795ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 10:45:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790790352; cv=none;
        d=google.com; s=arc-20260327;
        b=BO4P5qZpKQrkjZ+kLDdmX/F8jZEuutkxc9pJaZ4Zlp8qH9yCCkEMAN+PpxoVJzvWOc
         pgfI11bzGQLg2X+nYQxObmgkSYDggdu0LdVoRALlcckylzOaxRmle8PK2+Olf7TO2BoR
         Ls60Np7Ew3bD15B+gzJ0pWg9K0yrKb7YsY4N/UAyGhg7fGBQ8hNqK5tXQUu7KICHQ4xL
         M2kCGUAukR6+xlgdaTr2mphRCSDznSMj4PAHYBB0jqfSkVQ+AW1zGeXfCSd+gLECoFO6
         SETI/48eycPJtzMupzz9RsuUreXPQFgib91LN7LM0IHqR74GcBjYEmzEDieqgAp6+vQS
         WNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=745lyEoVbjciTEzOpvKdu3hogLTn3ptSICKnH9CyO6A=;
        fh=ZBuH1pIVCg1wzSzuMl6kyGM6YzdeqysITGwIQZLn6CY=;
        b=QuuqJ5t8Gsm2/wJuG0Uk6G9o6Ndwb+2ejKGa6zvlXColc4+GnM52CYGMx2DYcJZaGA
         FXoetl86Yb2GseCSUAefLq7jOT4Hibl/Eys+gZM9exFhg51HuyfsMHBUkxNbjewJwt8B
         u9G4tUp+yRp1ceL2qXgplUWRd2uS3wtRgzQyQE5Qp91kDMYNhDksog5qd7qRXwkjpNzb
         Sh2k1ku1VA8qxEKVYftBZ7jijC2XLS3TPGOy+Z3Pe/R1bzlVWnEos+y0qWp34Rt1rwDk
         U7j7/7Sdkq6SL0dVOBpt7JNDX5Zn39Snf9Mqp6hJg8c9wsvIbjnLUO7TdpG73Iayv0eQ
         ZCCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790790352; x=1791395152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=745lyEoVbjciTEzOpvKdu3hogLTn3ptSICKnH9CyO6A=;
        b=EJFjUS/oL3BZt+Y6WK3ESm7MOyNzzaaetWmYRD/xd9fm9OkgLCTfXPRBqiYGpwKrKV
         /xecn1iURtNlI6NFHRHrNNShBlYsJ/Hm3za3jMufMGgKvcIKvHlT3RAiREMrNvbtytcB
         MyDgpbTZ51ZMocv6cAkGrHNluNeW0fgfAgGrVHBmBCQQWRg1BAPAtrLbZM4Gk8xA6y9I
         VYhQjbNln1VFQZbCg8p/fR32xyMFeKO5VlXd9CHBmsnnBFKOo56wPfrTzuicMnbKx8TX
         j4uZNXwlbmo6gOUFVNbIrn9j7VSMd8uceh6/agEbIXG9dnD/+/T+OsngwcD9DK2dJi+w
         SZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790790352; x=1791395152;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=745lyEoVbjciTEzOpvKdu3hogLTn3ptSICKnH9CyO6A=;
        b=rFv3Il0l6dA2nwcJ/BPA7TPhIy7OqWLsnyK1gyqBbrejITiwtKvWKsCJiZwbZeu1Cd
         dSb6NtcwsCF8AOM87yZn1uOJYTXF+TKGHwu4+Xw8ouZkJ/0yhL76KC1gc78z3OlQomMe
         ISz4h0n5ohyFjDR5+mIO/Hjbt3ex2vjh7t+U+sVcvZvMP67odkCkkcb02yyZjtWEmc0X
         6mVWn4xjfbTxawgs8ldf0vA1pJ7yJwJLDr931AoY8vK4ug0vZUk2TH3hK04FfqJoj0AP
         lZTy2QnCDTJWENVk9vrVZ5Pz1EXa0/R2KgmbtSzKiMSfe7zTKuiluT0vjcLeU+47RAHU
         +l7Q==
X-Forwarded-Encrypted: i=1; AKwUvByI7sy0xO52eoGUsUhQr6/hMlfOocykQ07PVBQ2ayMvWtykxFSBQfjlPpdFuu5k1ZyowVdbzFhJqbfVrBsCjXVp@vger.kernel.org
X-Gm-Message-State: AFq9FYJGSUX4FMnK5YIsXt0flDwNEF2yVxE0mIrObMYJTOia9XA8I3NM
	8cAvGHPjN+6gXlxy/CaJjNdXYB9NDqgwQnhMTA8EjGd+wnj0y+lZxXlDj8wLVCxlgXrZVGpiHfm
	0kE8a86co5C9FH0Z0GiMYvJd408YuwqkteyCnTN71
X-Gm-Gg: AYBFou0zRqw7/WF2H3I+krfNG7NG9v03HjaVVmkmL/H6Odzuw51EvDN6Uj5plh/oyZn
	9I67beKLHgM42McpocR9xfAtlTCfqxqH8QKQfVDlND40fzv4SlGYxYZxo7HgyvlSHcAO+7O2aWu
	RT24ec90OJlBhWUatjUg+29J5bnChj2vTyUGww7aODdeEf8ooUpxbl0+Yv4+bQKqq91/3nNhKBk
	rcNjIc6mT3Z/R1+dmJj08Dc2aOEv90iK//0ITprGHn+vVrqbIAxYcTYXom7ak7BYdeF1YqXACw2
	xh5Amsk+OpQOvgxFF2K7BGKOBRsIwNPIa/e2xGn5E2EHBXZIfHyZilRdDXd3+lUpP0Ognj+ErVf
	XK9sy4abTxQ==
X-Received: by 2002:a17:903:440c:b0:2ca:bf8e:360b with SMTP id
 d9443c01a7336-2e301ae0dcbmr343165ad.9.1790790351709; Wed, 30 Sep 2026
 10:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-perf_fix_pylint_errors-v2-0-945cd526576b@arm.com> <20260930-perf_fix_pylint_errors-v2-2-945cd526576b@arm.com>
In-Reply-To: <20260930-perf_fix_pylint_errors-v2-2-945cd526576b@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 30 Sep 2026 10:45:38 -0700
X-Gm-Features: AclHuK96gSFJbCoU7KxewvSZZwDRlAoq9ZSjsa8u-XvTg7Cf3dwYi2d78g4fo5A
Message-ID: <CAP-5=fXwsY4DAL3qfNzdAF6SipeGP-YURhVDZzjCgdkXety_KA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] perf build: Add the output Python directory to
 pylint's PYTHONPATH
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Aishwarya TCV <aishwarya.tcv@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 6:11=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Prepend the output Python directory to pylint's PYTHONPATH so builds
> using O=3D can also find the generated extension.
>
> Fixes: 5fe83fb352c8 ("perf build: Make pylint build test opt-out (NO_PYLI=
NT=3D1)")
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Assisted-by: Codex:gpt-6
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/Makefile.perf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 0eb4e7c29c400021907d3da716bc4871f0df8d88..7ceefc1da774625d9f48d3bb0=
498ceb819b84d26 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -310,7 +310,7 @@ ifneq ($(force_fixdep),1)
>        $(warning Warning: pylint version is older than 2.16.0, skipping p=
ylint checks.)
>        override PYLINT :=3D
>      else
> -      override PYLINT :=3D PYTHONPATH=3D$(srctree)/tools/perf/python:$(s=
rctree)/tools/perf/pmu-events \
> +      override PYLINT :=3D PYTHONPATH=3D$(abspath $(OUTPUT)python):$(src=
tree)/tools/perf/python:$(srctree)/tools/perf/pmu-events \
>          $(PYLINT) --disable=3Dall --enable=3DE,W --disable=3DW0123,W0311=
,W0511,W0603,W0622,W0718 \
>          --ignored-modules=3Dtextual,setproctitle
>      endif
>
> --
> 2.34.1
>
