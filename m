Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B30D145A05;
	Sun,  6 Apr 2025 07:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743924056; cv=none; b=FxmnUcKYV9QwIfnRp4qwbLkN64EQDJSCjycINgxTJ81oS2+PlR7dJbclVZA7UMuZSc4Kt+WMPHq7EavTjuW/nn329xVmhkyXHe2bXKdx5AYCtmyocrzDV0bNM0IlvqFI5wb/aitibmRp6JdhC6W69ieBASZLL0nci6yOwVafOhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743924056; c=relaxed/simple;
	bh=gOz7WzrVKVFjQogYNZGybSPujxfm5zi1yI/Mn2wZfLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBwpTcH+zgGWwTWIZHaynSkmy2v9sAgIJc33Z0D736Bune3ql4NHFsgFQsweEga3gw+3iNudnmmim7qS26AvWxeQwyRMEDGZy0NyyK+JfWm9T9PffgXFN48xNyiI2Fc2ujtqonbeQac2r77HtKI+h6GZEZGH9Vd8fyATE50R8cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFxXAmxF; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFxXAmxF"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47664364628so35615311cf.1;
        Sun, 06 Apr 2025 00:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743924053; x=1744528853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CsjPYecOwi8hQj5aoNaycY/6PTPOmGRunWyU+08oUb8=;
        b=LFxXAmxFuABJfrdNVZD1FAsTRBSafwfCQyhSeDVUOm70/qDmvUZx3aCl0wqFbTYjDR
         kjqMZ5SuS+j0e9yBbEb6W2XxGYQ8LH7GAAa1p/UvGVPBN3Ep2+OQD3WAHAbl72uNciQj
         X47qaDQZB8BwS9Teaw12ZkUZMIXnxojSsZ008cwDCR618kyopXAaZmiFc3YVo1I2gKxl
         FGQV/b9zK/Ut7TRGiAcPyryraUyjr3ZAoPfXfBs+UceCcyOAvADr/3XsTmgxQmkQ1s6m
         QzbE/GwAb8zaznk4WHKbGtYMnUFHrE6LUnM59O0WMCiO1dd37AiYj33v1SCiVddx2NOw
         xzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743924053; x=1744528853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsjPYecOwi8hQj5aoNaycY/6PTPOmGRunWyU+08oUb8=;
        b=s/OAsreH+AS/N0UKQfpSA3ZXeI4PoijLxlFuEH0mfeRrwwesD9M/JRRHKf56wtmsRW
         ruywNCAXSu6F4med3Cinqigfs2bzMbPJZC0gY197BTsYu5kZGPzNT9/3F5sJH+/uqQ6/
         zFKaW7FvQd6n4EBgydpuTT4xVPtWtm4LYskFqREiearKfhxzIKDuB3b+eOZaAC7eyx42
         WS6sjcy2AEVKkye9UZgWZi22+DN225Ce19JzuKUOSAe1oQJeJctFdYP5zj6UoF3mvF8w
         5Y8ssYAmj+NwY3nw6UaWuXbAG6hij1gcubiVFI+POFXvJD+fC8peAXVFIrnMqnLab6wv
         YQRw==
X-Forwarded-Encrypted: i=1; AJvYcCXhExURLMDC6g3u5L/1GBvLrBK5TmA2IeDwqWtSizpFCejF3deiyE440C0mTNLe2RQXyIRNUOVowRitasNtNh2B@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ3fmHgDgOC9uc5EgbQIIBxjhefYdmbrlQOUeuTKMQSTMY67F8
	rt2dpOEmudP6CYWbt/MJGdn9iU3hpQHtoCXLTPXsVTgsxRWEx4bcxsNB1gMoo7GZ8BEYrpbFQpA
	chdKZstKxx55R9Lu4e70ubwaDa5M=
X-Gm-Gg: ASbGncurxrB4P/D5VjAPxUatoLVjaO3tL22NrCL1kKBmuO1E4AIuiuw/KLEJnaLR04L
	nk1vuwmSfq7dzFp2/e+TR7axe/T9j4a8fzOD8ro+iuA4gcLWD+Vc5SPHjrEPFbMFrOHvooLmv15
	niv7MxRcATeT3njACdgDeIUv+deUyhrHxK5Ul7vMvlMgodDMaRKy1Ej98VsA==
X-Google-Smtp-Source: AGHT+IEH037Fk40ggPFgWWQx+6QNlWtiRSd+WTm/tEXwShD9X4Cl0uf7VM7Wg13I2mwt/EV/fsG8++jMYskagKq7dZA=
X-Received: by 2002:ac8:570a:0:b0:477:113e:1fb3 with SMTP id
 d75a77b69052e-47916130d85mr160207961cf.3.1743924053394; Sun, 06 Apr 2025
 00:20:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250405203036.582721-1-gshahrouzi@gmail.com>
In-Reply-To: <20250405203036.582721-1-gshahrouzi@gmail.com>
From: Gabriel <gshahrouzi@gmail.com>
Date: Sun, 6 Apr 2025 03:20:00 -0400
X-Gm-Features: ATxdqUH0xUlfHS73rix1kl26hMdjVR8MUvx_Q8JTUzR4eSinZEmrrW8YuckWqU0
Message-ID: <CAKUZ0zKwPoh6MrtpN+gM_rsKV7_+yy-MgWNU=fs98BhwWKa-qQ@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Prevent WARN_ON(!ctx) in __free_event for
 partial init
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel-mentees@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, 
	syzbot+ff3aa851d46ab82953a3@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 5, 2025 at 4:30=E2=80=AFPM Gabriel Shahrouzi <gshahrouzi@gmail.=
com> wrote:
>
> Move the get_ctx(child_ctx) call and the child_event->ctx assignment to
> occur immediately after the child event is allocated. Ensure that
> child_event->ctx is non-NULL before any subsequent error path within
> inherit_event calls free_event(), satisfying the assumptions of the
> cleanup code.
>
> Reported-by: syzbot+ff3aa851d46ab82953a3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dff3aa851d46ab82953a3
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---
>  kernel/events/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 0bb21659e252..153ba622cfa0 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -14016,6 +14016,9 @@ inherit_event(struct perf_event *parent_event,
>         if (IS_ERR(child_event))
>                 return child_event;
>
> +       get_ctx(child_ctx);
> +       child_event->ctx =3D child_ctx;
> +
>         pmu_ctx =3D find_get_pmu_context(child_event->pmu, child_ctx, chi=
ld_event);
>         if (IS_ERR(pmu_ctx)) {
>                 free_event(child_event);
> @@ -14037,8 +14040,6 @@ inherit_event(struct perf_event *parent_event,
>                 return NULL;
>         }
>
> -       get_ctx(child_ctx);
> -
>         /*
>          * Make the child state follow the state of the parent event,
>          * not its attr.disabled bit.  We hold the parent's mutex,
> @@ -14059,7 +14060,6 @@ inherit_event(struct perf_event *parent_event,
>                 local64_set(&hwc->period_left, sample_period);
>         }
>
> -       child_event->ctx =3D child_ctx;
>         child_event->overflow_handler =3D parent_event->overflow_handler;
>         child_event->overflow_handler_context
>                 =3D parent_event->overflow_handler_context;
> --
> 2.43.0
>
I want to clarify three things [1] why the Fixes: tag was not used;
[2] what the author=E2=80=99s original intent was and how to maintain it; [=
3]
how to improve my patch.

[1] This bug is a side-effect of multiple interacting commits over
time (up to 15 years old), not a single regression. Bisection yielded
a false positive
(https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?i=
d=3D00b35530811f2aa3d7ceec2dbada80861c7632a8),
and testing on an earlier branch (6.14-c8) hit unrelated issues,
confirming no single commit is responsible. A Fixes: tag is therefore
unsuitable.

[2] The code initially incremented refcount then assigned context
immediately after the child_event was created. Later, an early
validity check for child_event was added before the
refcount/assignment. Even later, a WARN_ON_ONCE cleanup check was
added, assuming event->ctx is valid if the pmu_ctx is valid.
The problem is that the WARN_ON_ONCE could trigger after the initial
check passed but before child_event->ctx was assigned, violating its
precondition. The solution is to assign child_event->ctx right after
its initial validation. This ensures the context exists for any
subsequent checks or cleanup routines, resolving the WARN_ON_ONCE.

[3]. Defer the refcount update and child_event->ctx assignment
directly after child_event->pmu_ctx is set but before checking if the
parent event is orphaned. The cleanup routine depends on
event->pmu_ctx being non-NULL before it verifies event->ctx is
non-NULL. This also maintains the author's original intent of passing
in child_ctx to find_get_pmu_context before its refcount/assignment.
