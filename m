Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAE73446CE
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111217; cv=pass; b=WR1BDopOJ8aTR4tUSGcr/vLmpz4uxTGLzcRSlW0IBTh4/N2gziEQfkxC1dKlvqIMO7dNetyJFi8UIcqmcJv9RPbveI+hdfDBMkVkl4UtTh311SVau2iMKJvsRagcJ6SyxP1+PqZw3DQauj4OqI7R7enCRdr+o3v1eRcD5EbDR1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111217; c=relaxed/simple;
	bh=rg0aiYDhHHZucD9w1OGtfujvoInDxOzvRtHWBuvfeCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2DCLChAtATu+JMb83fBTKjUA5k72xFoSn/bP8ZqMkTQJAuAlfojvH+yknBH7jNkWESlAvnBivLoJ+BXpwCkhWa++6Vs4NBHTpkA6mbCwJ4ddemPL8eQjE0nO3qKaoMxrdx3ohQpBcRpWkheAig/2TSnMC85kG/9+s3haWe3TMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LMrCWuKf; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LMrCWuKf"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf2d865383so4595ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 10:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781111216; cv=none;
        d=google.com; s=arc-20240605;
        b=ZbCRUb5rVT/+h75XTamx4QNBg0D5wRUJF2ggb84vNMvdxTTRL0aaxvHIviHwssZ3re
         jH2GErjfD8VRhf8GzPejzmzfxEel3pM0CQeRm47NtA1nNSNBbL151S2ECGurufuUWUvU
         gveqe0YlURN263c2sHtbJF/0HQ8sP1AKJP/XG9d1PLDJyJ9yzfZ5nnw3UomB5KDUTArC
         AYyvrnDic8b2431bZSWtOJ0uaCpnWb6We6yz1+rVhkbVqhdx3v9Sx6laaqfyLSS4k67U
         Haewuxwdt/RJ4Ybpp7EFe+i9zgdvT20i0Y6XejiXD5LUTqMIYrlfNGjcRhpWJqj5XuOq
         Tx1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0Mropv85BQrKNEGe/YL6H/Nji0UWEphvooDqge768FQ=;
        fh=6UK06scBT2Fg9DCKSURzFy2tlozUtTVA09BMVQxqrCE=;
        b=Z/r1ZjS7yRgCD1LJm/crn7gs6737qHWuvWL8S7oiZfmB4vdax7gMg2aM3u459ttKz9
         1WOVfcAkgiEJMftyZf/ru7kLHYfKx+H1fjfQCxOa8nscmNgNbuauZJKS1bmRagjeep/3
         wup03K/QVx6Z4xv51Y/hOOoociNRWEP7iLbart2OFtSVd2kNQzuNtTNB3IWcqbNM9EZy
         3n7Rm1Z8UonM7ubtgmuwfooi/Ttly7uutHwDsHUHKP3ez/xSFQB+WbPjOHhg5PL/WR7n
         i2V3jj5rI11qvEodGlrSW2i07GjQcO8nfFCHdD+XrUSLL7Q20nAlsq5JVRVO5ROVRI0d
         Amrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781111216; x=1781716016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Mropv85BQrKNEGe/YL6H/Nji0UWEphvooDqge768FQ=;
        b=LMrCWuKfOpXkFo0QIvx1lZhvyHt46PN4aLcZx0icoXTK5w6injMvp+FRr7Xn7xifN7
         8cL6Jm+U/gclK4bYmiFeake/iwmnKlqRMew8ceK32br4VDXCOa5Y3jnAgtjEYkjPSeRM
         yEruJwNQDssi0Ta32K47D7NYiTAEY+5/E1fprBNaF3ISGw5GmHw9ecJDLVNddSWb/zTA
         pWBc2Tb0ZgYTHwIpu9yUTZTJu+KNMjA8bbSd90iOXvAIURZdWThCr6DGiYAkaYMK5Kb5
         XEDDNTNiJqtzJJlUHzF81Mj2q50mrE/q/RYSLlvCQt60Z+98xc6ESPjHwZ6jzG9FtnxG
         YBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781111216; x=1781716016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Mropv85BQrKNEGe/YL6H/Nji0UWEphvooDqge768FQ=;
        b=f116ofcqtk64UMxdpNW75kw7dScUG97Vy0kCf3ZTm/xemVYJ3gUvwXA4eg8oANacI9
         bAfaQMtD0gE/QVPGcYYdaiXTY3BWmD9NeqlhJSmbiNu+d5tLf5/K0VkWbMp/OKjDef7x
         aJeHyqT14AFIPwToIdMlmDm5LYicbW8wQppPpZsFV33sJcDRrvJ7bmHUv+Z3vPNHGZVN
         dzAV7q+j3dj2rpRqpwB/C+x1eXGkIycoDvsBnsjD4j8q1ES1zIn/ty/qOLY2c9EM0BA0
         Hj57ff1YHRlrJ+KwfigEOKLQAfBemH2YBnyl2FcJ/3m893Un2pcn3VYXrKk3aQ7OCh8i
         2N7g==
X-Forwarded-Encrypted: i=1; AFNElJ+NYY2xSKwVP4/BblyheLoJ4XOGOUyuHA+apkn5QAt96CdiU9sBI/w/AeHaNCnz+vbaxkfsVXaxY4CZwJlA5lMV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1hyzAm/FZmnLRQfTgIM5MoR9SbsVNdKkO++c6eaBbUqJPEZAS
	jfyqKkDtVaKDrELplmhPreuJuN288rVAOKbwnpC72rn4cWe/XmjYMWSl42q6jVj2aqvC5ut0oTy
	b8kZAbU4breep3dlvDVzXTBPCNcfO2J8aUFtd/s5N
X-Gm-Gg: Acq92OG0dor7vPRsG6pFSDSyz/hTIOUCH4mZbiglD+gnrufDdMR2oLM+FKzagGx6kBv
	RSkLrpxNGtZdorKJ6SQWuf7rmyiV6kqAuBv+38zqdSIqMZWa8FAbObZwix9420gZyIfXpOamuOw
	VXMmjvKQvbCO7KpMeIyqUw8mSKMaaX4EYz6JBz/XxbdqpiC3M3F2f4AQD6tW8eLV0vsWRe2A9yO
	3CLHwdh9pEiIPbIat0zGon8mJOp01dTl00jnOeLiZw0ArCr08Z9hdyiMtCsItRNR19uTHxeQ31a
	cy2+tIvR6gpEq9hWMjbLIE7sh+ZgYCPT4Vno514g3SWW8Jrw
X-Received: by 2002:a17:903:2ac4:b0:2c1:ee6e:be22 with SMTP id
 d9443c01a7336-2c2d9405887mr266515ad.32.1781111215231; Wed, 10 Jun 2026
 10:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610165207.2077258-1-acme@kernel.org> <20260610165207.2077258-4-acme@kernel.org>
In-Reply-To: <20260610165207.2077258-4-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Jun 2026 10:06:43 -0700
X-Gm-Features: AVVi8Cd6_5vKasSYaoGpr5bXZVE9ogmaQAy-bLhJtOKqwmJPH53bTr106O73puA
Message-ID: <CAP-5=fUbJTXjqyM2kmW2JSxgqVJGtcdBPqq7S0f4PLzssXjyuQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] perf tools: Use perf_env__get_cpu_topology() in machine__resolve()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, Kan Liang <kan.liang@intel.com>, 
	"Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 9:52=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> machine__resolve() accesses env->cpu[al->cpu].socket_id after checking
> al->cpu >=3D 0 and env->cpu !=3D NULL, but without validating al->cpu
> against env->nr_cpus_avail.  Since al->cpu comes from the untrusted
> perf.data sample, a crafted file with a large CPU index causes an
> out-of-bounds heap read.
>
> Use perf_env__get_cpu_topology() which validates both NULL and bounds.
> Also bounds-check al->cpu before the cast to struct perf_cpu (int16_t):
> without this, values like 65536 silently truncate to 0, bypassing the
> accessor's internal check and returning CPU 0's topology.

Thanks for clarifying this. Perhaps we should have a general
int-to-CPU helper, but that's out of scope here.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Fixes: 0c4c4debb0adda4c ("perf tools: Add processor socket info to hist_e=
ntry and addr_location")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Kan Liang <kan.liang@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/event.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 66f4843bb235df53..ea75816d126a14be 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -14,6 +14,7 @@
>  #include <linux/perf_event.h>
>  #include "cpumap.h"
>  #include "dso.h"
> +#include "env.h"
>  #include "event.h"
>  #include "debug.h"
>  #include "hist.h"
> @@ -836,8 +837,18 @@ int machine__resolve(struct machine *machine, struct=
 addr_location *al,
>         if (al->cpu >=3D 0) {
>                 struct perf_env *env =3D machine->env;
>
> -               if (env && env->cpu)
> -                       al->socket =3D env->cpu[al->cpu].socket_id;
> +               /*
> +                * Bounds-check al->cpu (s32) before casting to struct pe=
rf_cpu
> +                * (int16_t): without this, e.g. 65536 truncates to 0 and=
 silently
> +                * returns CPU 0's topology.  Can go once perf_cpu.cpu is=
 widened.
> +                */
> +               if (env && al->cpu < env->nr_cpus_avail) {
> +                       struct cpu_topology_map *topo;
> +
> +                       topo =3D perf_env__get_cpu_topology(env, (struct =
perf_cpu){ al->cpu });
> +                       if (topo)
> +                               al->socket =3D topo->socket_id;
> +               }
>         }
>
>         /* Account for possible out-of-order switch events. */
> --
> 2.54.0
>
