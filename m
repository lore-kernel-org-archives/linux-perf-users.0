Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3785A411667
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543717; cv=pass; b=idOGuARaFKGL8af8M+t/iLo/PTzemIw3JtGy754zkYYeaOH1C0HsKJxJLf8k1HzD4gTJexEv/4L9wdWs6hSQMfyl7uQMnUKP3P+NHeGrdxOeykTTRiNpKbnr00OAiS6mEYn8w0hpDDIyyRyN9B9rCzJp/FOdn+Uz5sv22Z0VXC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543717; c=relaxed/simple;
	bh=LUM4hPSeO63idINy2/kJHThckwP26oImjP4X14PQ9eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXSaVEscHQWOvYuKjA7g1qgMVxXREVlXLDHsxIOItI14IzxVwujv5SzyJtpM2Fct7rKa1Bc2dAKOxMCra/GJqYRWGkYNW3IkbQaDBaRXK/JE0Zu+ccelWVTPEB5c4o2ivabfQ4x/fzIURWSzoshnChHDmrSn6ZeoVl9G96DAdeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fAc227os; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fAc227os"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf22c18ad3so3345ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 10:15:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781543715; cv=none;
        d=google.com; s=arc-20240605;
        b=lqwrF/bp0+547IhIYG0a4maahnaZVdPoQ9TBXvIiJplWOktGeRlsIdbtsDWBHDZ/28
         AeCDfVNE5St64bI1kU0iVa5XtbDaH+XhKwsCWAnrCLYpJkTkqdrb9/lkWyaGlG4zLJ97
         5UuEuOCY1nNyNq1wCeuA+XzXPpIYRq8phA/SFIVpQxn9e+ezzxeGOeIol+uLQt+7WrGi
         HE22ZlSjE6S0JXQ9Jzv2HAePxotVnXhSEUTvou1l7o/tVF1wqa8F/zMn5ZdQ9l7y4tNW
         qI2k3bfxXpHN3WOI52wVD7Z1Floxlw/REa2qdG2wvbiYsyaPO+TCnJrL7Ntm4eFnb90Q
         5HnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jt1b6yZuySthSIJzDO+sQfG+sRSus5hUkJLauMSzfxs=;
        fh=eaNeZ9app6aOwSuYIita+PwEGyDaKPkCyvgUc+3vaEM=;
        b=lXZDy3eaE5yZNP2jwpUFlGeeoV+KsdH02ex413dHDtnAH9HuaCSp8sun7XjlBuVOI9
         7lAftteuJzn5ve1CvjgD9vX3NuXzG8PDv9viJ4jbrru2YEULlWCx7Ah3KFtxP5NpNAMa
         FCNq+VP/sb9DtAVWMLCdgRr4p/jjYwHZZGWpF3n6/wlmH7VFiofyCvfb+08oJBx5VGn+
         lxWd/TMRgr/cY2NN1i9aa4nT1Hp93iOJBVdYq+4h4Ks/jtIGIrxggt+1uGhe5zWbsBPy
         VQ1668EIVTVJGmrLcnbC4xX+xDV55pFQ+yJ00/S2lKdZU7V7Efhd4ZoM8RJx/FK0drKQ
         Wj/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781543715; x=1782148515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jt1b6yZuySthSIJzDO+sQfG+sRSus5hUkJLauMSzfxs=;
        b=fAc227ostSXLSZMkzgfdk8JtnijozRfvfZAowlNas4ByW9Urpt5AL+HafflKUJqMuq
         jNjYeDE7JgOYqdaPgvyStNYrvcToo+53Wh9wKvg3JOovOQOX+gMVaaqXpenRnSBmLqoE
         GoVm5Ovn+DbU2i6p9bJrAbhljDEQtJ75VQCQSssYK35KugYw/0LoauJya8or0lPEzNsT
         XWxcAabOmg8Nm8zpLP3KUloV0cbawpud2FAu1yZCTxgySXvvxyPEZqr6IS0hatLv8UWA
         vmQ8BOFyEOmhpKagU75E3dZ7qrd+YZyKxQkF25iKOG6Zv30C6zID9f7HYHudTnOlLlZ7
         WZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781543715; x=1782148515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jt1b6yZuySthSIJzDO+sQfG+sRSus5hUkJLauMSzfxs=;
        b=rLe999Wkn1YxOQEi1wDkzl0k3J/SXK/K7aF8YNSgskRj/yps0GyNbpiAYxuo+joo/a
         CRD9p8Bug/unkLVeBPOuFscnnSFvt25qM1LzaRl0VV30/VBevbFVVSj9wFZTZMXBeimB
         0n6Txvn4ueRoayoFe9jelKAaXEB7Kl1/FbhBefsKRMynCxjvqGpDGVyVbc7zQCXHxWiX
         qYgj+cARLDx8U/kJAOfUuZRZjQ7aPexWmhrlDyOhttVQi4r/Dehdt6lEnsofK4ATxSsS
         v70gEthWKtHDIeL7oZuLpiPWSiPJDJcE7pBZUf/o3Qv+FWvnCxMgpwrDEbQQZklaKTxS
         Upzg==
X-Forwarded-Encrypted: i=1; AFNElJ+EXa/1iH4Ohc7YaUtWn1Hg7+YqECBF4mkNz7hKlS8q+sfdPrkugPmyHBWLZPmBTUCQgkGl+dZx75DuxvqIImpO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz989hBBvDQXLApD+i+RYQUy6y0/V6D2uLKpZ/dN1PK354UxddI
	uZzdaZunFzQrZxnaHWQR38RfF/M+3+lW/zHMKOjRhQSW9odo2e2/uqDtbSbcOftn+69WSyo0qrY
	l7dFvkx24qm/rojcd6XPErpabsHneDXtmEcWtRSfu
X-Gm-Gg: Acq92OGraPtLjuWt0PkE5MU4wAhpstf8fX3mjoVNN0uVnyMvuyp5WVL54Q1xSni63f/
	m3eAqmRY+NzgbG+8BQrggrqOI7Yd0LOWsVeg7UpDWIEIOEkPvZp/ZPIwlKgdO2OwLMcRkmbjT6T
	MkY1+H+tC6ImLAVUP3tHI/ZOEwY0D8lap3o23WUvLGK8ztZ06D0TBswfLE157R4ECdJNdksuxT1
	jZ48Mqao4GrWT9QGGzZ+s2fI9hByIVTAPiOCc/wuGhh8w2yKgPd9mMhzTd/oBBm3z47o+pj3tID
	gVS4bGUTSyuTNeejWWINUD5xGrUkbRSY5Q1l
X-Received: by 2002:a17:903:37c7:b0:2c4:3ba1:9b26 with SMTP id
 d9443c01a7336-2c69a151fd1mr119405ad.0.1781543714976; Mon, 15 Jun 2026
 10:15:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612222413.40791-1-acme@kernel.org> <20260612222413.40791-9-acme@kernel.org>
In-Reply-To: <20260612222413.40791-9-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jun 2026 10:15:02 -0700
X-Gm-Features: AVVi8CcUHTX95HVU66en1HQIxfRePf_BIhpPs4Vui2XYi4SBc8h1NNTO98TBY20
Message-ID: <CAP-5=fULowK8tmKe1KnkR4YMFE51CRuq69444=tFnbq+BMKYKw@mail.gmail.com>
Subject: Re: [PATCH 08/13] perf sched: Replace (void*)1 sentinel with proper
 runtime allocation
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, "Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 3:24=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> map__findnew_thread() marks color-pid threads by storing (void*)1 as
> the thread private data via thread__set_priv().  This sentinel value
> causes two problems:
>
> 1. thread__get_runtime() returns (void*)1 as a struct thread_runtime
>    pointer.  Any field access (e.g. tr->shortname) dereferences address
>    1, which is an unmapped page =E2=80=94 immediate segfault.
>
> 2. cmd_sched() registers free() as the thread priv destructor, so thread
>    cleanup calls free((void*)1) =E2=80=94 undefined behavior that corrupt=
s the
>    heap on many allocators.
>
> Fix by adding a 'color' flag to struct thread_runtime and allocating a
> real runtime struct for color-pid threads.  thread__has_color() now
> checks the flag instead of relying on priv being non-NULL.
>
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Fixes: 58a606149c60d5da ("perf sched: Avoid union type punning undefined =
behavior")
> Cc: Ian Rogers <irogers@google.com>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-sched.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 5f16caebd9645da0..7fd63a9db4574fbf 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -274,6 +274,7 @@ struct thread_runtime {
>         u64 migrations;
>
>         int prio;
> +       bool color;
>  };
>
>  /* per event run time data */
> @@ -1589,22 +1590,32 @@ static int process_sched_wakeup_ignore(const stru=
ct perf_tool *tool __maybe_unus
>
>  static bool thread__has_color(struct thread *thread)
>  {
> -       return thread__priv(thread) !=3D NULL;
> +       struct thread_runtime *tr =3D thread__priv(thread);
> +
> +       return tr !=3D NULL && tr->color;
>  }
>
>  static struct thread*
>  map__findnew_thread(struct perf_sched *sched, struct machine *machine, p=
id_t pid, pid_t tid)
>  {
>         struct thread *thread =3D machine__findnew_thread(machine, pid, t=
id);
> -       bool color =3D false;
>
> -       if (!sched->map.color_pids || !thread || thread__priv(thread))
> +       if (!sched->map.color_pids || !thread)
>                 return thread;
>
> -       if (thread_map__has(sched->map.color_pids, tid))
> -               color =3D true;
> +       /*
> +        * Always check the color-pids map, even if thread__priv() is
> +        * already set.  COMM events processed before the first sched_swi=
tch
> +        * allocate a thread_runtime via thread__get_runtime(), so priv i=
s
> +        * non-NULL before we ever get here.  Skipping the check on non-N=
ULL
> +        * priv would prevent those threads from being colored.
> +        */
> +       if (thread_map__has(sched->map.color_pids, tid)) {
> +               struct thread_runtime *tr =3D thread__get_runtime(thread)=
;
>
> -       thread__set_priv(thread, color ? ((void*)1) : NULL);
> +               if (tr)
> +                       tr->color =3D true;
> +       }
>         return thread;
>  }
>
> --
> 2.54.0
>
