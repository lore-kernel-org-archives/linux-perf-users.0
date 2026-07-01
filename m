Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7A4257824
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 18:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931758; cv=pass; b=bpaFIYhTiq2uZo4C4dXYIqjKVNGXXOGLs+wNAlgCCyJ+1QZ6yIjKLF3bJEWFpCq49IkKtF5psq2ZSx53jPfNH5injZAxQKTOa/H3VeRYAG20vXzoHFxSlbzjzatZD8CBajeR8/7lvTFYtcLBRkczLDm3cMaXNuAmYPLJqHmCklY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931758; c=relaxed/simple;
	bh=ze0WwvejWRLWCWbU+CGUHRpyIhaGjlfq5Z2yPqxWWmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHL0SySTRByoZGn6WEJ+JTMhio6aaH+DmsgVkIqit98PiJaSpvdEObumu91EEc6YQfjzDdG5ljatzoUwsCiI6qGH+Z8gp4HzZVe+RYrFA0vhRIRnLsDddgVZQ+0LKKmE48ybwCfm4CeBxVTrd6s2zzibGxYeJtuuPlyfdlvTcn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o1bAVYvV; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o1bAVYvV"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ca597093c0so82355ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Jul 2026 11:49:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782931756; cv=none;
        d=google.com; s=arc-20260327;
        b=SA2GdmMgWZBNzIJ2h2P5ckzp1eORpGhUZ+ZqSCLaXedd2qpKIz/sD9h1t3x842paDX
         q6WpmLWVnDPcFBMHOFJs19VHsKip8GE1uDwP0oVKxjluqlzdy3i0OigZ9YG2ZWK6NCmG
         S74jaNQyfE7iFKLZAPc2BR1c88+JadWf0JleqqTZEAzzTT9HIpsTmM0GpV0AfJnAhReE
         DX6R8pnZ7a0oC2qg+Gnf9ojmmb2W0O/j3nxKtpXfvqp7DioDufFhCSWh81yOHF/CT4/Q
         NzLNq4IcM205NAuqujuYz1Otfqaq7h2vAFnIi2nky0jvCtD8FLlNDo3/AlU44S9dwlaR
         qZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jcn3Se6LrEj5bJH3mC6qWq0X51hmaIjISmTfpQOQZlE=;
        fh=cfTc79t1m8/rDUeltNwYWZ1IViqcExl3A4cSpO+hcKU=;
        b=aXtwdF9dGmzTw4p3YUBmrpYXD+VtJFr7e58tBB3/57jyk/kaD7XNN1S/KgxYhntx9C
         luObJ3KeaGxXqjC0/NLHoYZs0TE2EcVdGfHnY+1Be1FEDg4jDCeHxhIsox/phR2un1NS
         RoFK+lWFaVE2GRIqluxFcuSYbtdFHQHHwI9rJ5OcRl6hEZjEWUVxItbUiXeOjVbeOtDn
         Y5/LQZ0qcEKOfZ4X+FPCr/Hd5cA7RarC13f7yAGQPaAQvsqWALkonIDO+GD2qJKODiR2
         AhA6HuMvkVW5MRzsMISsM4f2xYRHG8D5ZjHXjqOiyuhL8ouW7uRWsoL9v0IBIoBQgrC4
         2Izw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782931756; x=1783536556; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jcn3Se6LrEj5bJH3mC6qWq0X51hmaIjISmTfpQOQZlE=;
        b=o1bAVYvVmkutFmDQv3Z/WH48pjzvmMiY6QHkjBxMcDxTKlDuEMvxYQxpX3tNPl6eSI
         gZNM2Tgf0Mip3JqERuk1B+9UHVl8lvgTIJGiS6Z736fp7lPcK7/j5wL4Os4QXqyfRyx5
         9BvJC5erdlOhp61ERhnXFbHuGGJxz+S2MOX+dAajaKqB3mucMYHjw/t+Y7pFh/zknrL/
         g1e1k/IWw21C4ioM4C5SZprgx6MmcQ9daDcW3NmVgp95S1i3iT+xVK9pKB2X+86xA1Ib
         g35dw8Ia1Rm7bv+oyqtrDojC9eXJ0wB/QxmQXfqplRnrcnCAtNDEPuzJ8TcED7kkbzo+
         6iiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782931756; x=1783536556;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jcn3Se6LrEj5bJH3mC6qWq0X51hmaIjISmTfpQOQZlE=;
        b=JIHPal3cpwUHd+0qFCR7y8ikd5+m+hw0lVP0Hsrlrn8vvPr7L5pmjySaYEovFWJTw4
         n/FyxtEwhba0o/I14Uwy3YNkZHK0mzXdMap0DH06jca21JR8ZvSJ72BzxurYfH4JSEBN
         r7g4lF4jpl1KAS6yIhmA6BpSLjfPJOUuFamBl/0UnZ1GUgget9EweTPKb2egR7USRRK4
         1+AtIqkdnRCAaOnTSaJbDDJAzHcggoSpeYCndG4PGZq4Em/9Km3sEpL5NmHafsSQAi/X
         Q4XJ+XZ6yf2znjyIrDABWBRHPizGVmzwUgAyOeIYKy54vMF3yoCBxedALs1uEEWrzDFB
         pV4g==
X-Forwarded-Encrypted: i=1; AHgh+RpWXY7ypmyeqAvInH4hYnPDQxqhvYQMiw6awreKfqf/LuRuhDPkocJ7vTLknXODLPS8Viqrkazo27+4wnvQlh/7@vger.kernel.org
X-Gm-Message-State: AOJu0YyyPc8BVyWOJQoBDPq06y7skJBaO/4xLXAdGCk5zP+xCKsgNZQM
	QcFCCEKKeqfo+YM6/a7YBZcT0iLvpg81WZqA8gOchtt070Zaf/3bIaFC+VIdIcWmvX/xGZgzXRy
	qv+Skf6wlPAkewyWcc5ok1bse9sB+F6HxoudkumM1
X-Gm-Gg: AfdE7cljxtBM1Fg1VXc2dlFPeZVqWNejYY2CmYbOgdZ/RiIxIgDa3kKwW/DlQkankPk
	j5KyUdVdmg82KLW/cspvxolQ6CZbAb5AkIZ2iDpAH5bPqEtY5xHAe5b7NYrmwHOIghy8CJePsOP
	aL063b1zBQlyqp9k1332aeBkD8cGYqnVD0fOt05I2lwCfwTEWtF3/DHomog5FbcvoVhwTSwHesP
	GgPRgZwuau6ZLPL7ZL1tcZDjYYwKzSojtts2HNKXWiyEngZzhf/0RVTZCiwqmLa2O+0L4JceA==
X-Received: by 2002:a17:902:e812:b0:2c7:c363:dade with SMTP id
 d9443c01a7336-2ca77f84f98mr2690405ad.27.1782931755046; Wed, 01 Jul 2026
 11:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701182824.347941-1-namhyung@kernel.org>
In-Reply-To: <20260701182824.347941-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Jul 2026 11:49:03 -0700
X-Gm-Features: AVVi8Cd5Oiq5e8xSv3vEKPVCdRfDmoUawuhnqXP4UpoJlTITfCOS7wajHAZMSF8
Message-ID: <CAP-5=fUzfFkErqnDp4iJEgCQdAO1pFRKMKWn3mhEGK5z2qZvWA@mail.gmail.com>
Subject: Re: [PATCH] perf build: Fix compiler errors with old capstone
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 11:28=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It seems RISCV was added in capstone version 5.  Unfortunately they are
> enum constants so cannot check with #ifdef but anyway we can define the
> symbols.  Let's do it using the version number to avoid build errors.
> It'll fail at runtime though.
>
>   util/capstone.c: In function 'e_machine_to_capstone':
>   util/capstone.c:186:25: error: 'CS_ARCH_RISCV' undeclared (first use in=
 this function);
>                                   did you mean 'CS_ARCH_SYSZ'?
>     186 |                 *arch =3D CS_ARCH_RISCV;
>         |                         ^~~~~~~~~~~~~
>         |                         CS_ARCH_SYSZ
>   util/capstone.c:186:25: note: each undeclared identifier is reported on=
ly once for each function it appears in
>
>   util/capstone.c:187:34: error: 'CS_MODE_RISCV64' undeclared (first use =
in this function);
>                                   did you mean 'CS_MODE_MIPS64'?
>     187 |                 *mode |=3D (is64 ? CS_MODE_RISCV64 : CS_MODE_RI=
SCV32) | CS_MODE_RISCVC;
>         |                                  ^~~~~~~~~~~~~~~
>         |                                  CS_MODE_MIPS64
>
> Also note that capstone renamed CS_MODE_RISCVC to CS_MODE_RISCV_C which
> would cause a different build failure on latest versions.  It's reported
> in https://github.com/capstone-engine/capstone/issues/2977 so I think
> they will add compatibility layer to prevent the error.
>
> Fixes: 12c4737f55f2 ("perf capstone: Determine architecture from e_machin=
e")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Perhaps update the feature test from:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/build/feature/test-libcapstone.c?h=3Dperf-tools-next
```
cs_open(CS_ARCH_X86, CS_MODE_64, &handle);
```
to be CS_ARCH_RISCV? That way we won't detect old libcapstones and
avoid cluttering up the code.

Thanks,
Ian

> ---
>  tools/perf/util/capstone.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> index 5ad537fea4360e31..dd7cd97d0a38056e 100644
> --- a/tools/perf/util/capstone.c
> +++ b/tools/perf/util/capstone.c
> @@ -24,6 +24,13 @@
>  #include "symbol.h"
>  #include "thread.h"
>
> +#if CS_VERSION_MAJOR < 5
> +#define CS_ARCH_RISCV    CS_ARCH_MAX
> +#define CS_MODE_RISCV32  1
> +#define CS_MODE_RISCV64  2
> +#define CS_MODE_RISCVC   4
> +#endif
> +
>  #ifdef LIBCAPSTONE_DLOPEN
>  static void *perf_cs_dll_handle(void)
>  {
> --
> 2.55.0.rc0.799.gd6f94ed593-goog
>
