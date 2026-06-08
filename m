Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF03AFB0E
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955798; cv=pass; b=A8usrHGhrdXTbhYcubfX0kTXbA6xUL/Nxp8Xd7yR7f1HPLd5PRSVn95cx7UO1+vsrJnlPF0foiUaxUZNZSzU0zCYNAL49enIgWtLmkTBasnfCZYpKWujNhwmtQXx8WTl7kAEcY3UV/6PKjf+FtFuC9AU2rB9tAYn7DPw9MHLpm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955798; c=relaxed/simple;
	bh=4/TdIGiAUTVXwG9mxH9B50ueYagB1AAah/kq5n5r5gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQ+YoBwn4iV0d9X3oUN0jHwAZeladDMugYbGNNiH20kzwBE81zJmWp3HfuDIRQErZP6lzQID7x4AphRwyolpu/9eajFN5+uRByAYt+dbSa9wRB22ywkbLT21v19qLmZ5z6HAaPvMtnNZQ5y/OKSz7YDo6pDCybR5DLKM2FSfnOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RzMGzOWv; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RzMGzOWv"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bf2d865383so370755ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 14:56:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780955796; cv=none;
        d=google.com; s=arc-20240605;
        b=YriPylfcq4qcO2jVAhkNarQQMTi1OSwR+KG9tbQUnQpv7fpb/ZyYcFpRZ1b8MiLjaT
         SbHDcLFaEP38A4KqvyORXt6iz1J5oC2CASzBaDjZiRS4dIyqNSq8l2+TCFi1rZ605kia
         UQCPuIKjynOF3SEjQdxxwcF6DKAfPj2sV/BlSlrRAabOdp/1hbm6jbO6Kj9o3xKUKW4G
         weavKHO4f6VO2fCStb1la/2VJMYxHrQMn91l6sb3Q646avFSCSSDU2dA68z1CYmbzsHA
         B86qeiG+tCsKs+SvLGACTklrfRimnUvPu8En9LpaKKtVSK8tyr+uPU0Sqz6+ONuo3KbJ
         PUbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p5pcHEptBrs1dI8SNZVZgCdEvBQ368v75cLdJIJ+m/E=;
        fh=zvPhJdzicYiGkUlrPGBW1bcVrMhpn2uOIgcwJ/gLIz4=;
        b=jNNj/iNq4uKjFfTzdN9OaxboQqUvpPKX/jIh5RYroyuMc6jlMYi+2QX0Z5wsehz0w7
         0xHcVMhqj6rm2gRVa8KZBmzVbjaVNPgx6VLx3e6qT2cvxzmXlWS9HwwFzJRtJCwcIKsS
         rPBm5TjbLUDK9kc9Hjd4lpOOJHobpsDR7arkzGcicjOSo4MGfISEsnIdOvZ9zkyLX7lP
         ptLCRdBveEQrhFxp/o/LZ23HAgzPw+C6PjwJuw14vvguWU3QnIKdXzn9FpjfDBiXWvoC
         WHwsPmQvd3ir1L0mCzPlY8lrhKmpNqnz+PSlY7Z4c9METwDxv1eReFskR1GGM+1PTXtH
         EK0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780955796; x=1781560596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5pcHEptBrs1dI8SNZVZgCdEvBQ368v75cLdJIJ+m/E=;
        b=RzMGzOWvHmAV2F7jXUgeSX5actoLNHZ5weDMN3YLaMQPvkW9VsP2HxDWgyJRiQYLZX
         zFy/LBY/rNVYw5iU4mg6DgAzj7dVniAcINNyN1FJxtDKJ+yE8/Wue2UV8YbqRGrZBrbH
         u2omsAEZTWOwT3T2HbicnJhQwCKHgru8zKUqc92X2N9aQ/1zd3pr6jL3iX6T5EjTc9/e
         bs7muzm7BKPXpQ/2UnQmG3O078Iaa6YJviJcjUDETACgrDkyHo7E+HRCet5HJPFnEX5O
         e8YFtTwXd0HoGGj849ILl3Xu1a+MtBUxOY5VARTd2v5MWgqVN0lLfjqHrqWA8EqjsrHY
         WR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780955796; x=1781560596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p5pcHEptBrs1dI8SNZVZgCdEvBQ368v75cLdJIJ+m/E=;
        b=bOLjEF6c0tVvXNxDw/2dugLdqtqUVZeza/MdbWw8OdlFohflFl9uSa7sEJQ+xo5TXS
         zo2UDDnsoADHtxMnRZyvaI7XxEmBIa/N6K1eEfQMxDJTr36OqcMUN1meRi6mz+RAjaLP
         ZjXt2QA31/pvAFDVhw9VQYUJilrMO9eO4AHIC/MsrIcR6o3oYdOkAA7sJu/MVR6lTN/+
         ji7mcuRoJXf0PwPxRzenJJrC9So3HCbuUxKLipzGwLyXDpcHG2nECctVv+x9zoSfPKah
         AIUbnC7zzyH6k+Jd05pFMADgw0JcwLT3YW0Kqu5pFGe+9x+g/54SKtaZsBLRzUMtbt7h
         By5Q==
X-Forwarded-Encrypted: i=1; AFNElJ80ZP59eJ/ZHJOP77Xhgge5r0vqmV3FesS8BwCm0t98VzgiYnSucsv33ggs/PZJQt8X9Hm2v1O1crVyp8030mxw@vger.kernel.org
X-Gm-Message-State: AOJu0YxuoJShom64OFjwmZBnrN2E2Fd6/uxwBP9zl9D84ZehGT8VBT9A
	A9NY/NGN2OpvflvbUBPywmqSlr/0bMHVUZBeLAt5NO3zrObYUCH/fzRGfh15Rpv3L/PJVnZClNL
	1X2Gl5HnHEkfSfF+iSNTBD/MbTIeAHfni4Lo1Ij1q
X-Gm-Gg: Acq92OHVf3QxZtTabhnsriCxVhujDD5nYoyLmOYE02ZCvZ0AVUcasQLCLzo8eXpa7sa
	he2RCmaVkBC/NDmBIqceOjiQN0owDm8faXcvBlt+Nd3H4oo3H774FO3ySGKGX9+AajjUfygb9N6
	wmV57lm0SXS3x2r7cWmCv4Hzcst1gphlmS88GC5c89606QDQDBZyR94Iyo2YkTkdglIaaSroOXT
	AZeMEJtWurHVijnR8SqMCXUAgH6opDEuiGkSe4SqnJqMPqC57HMpcWiZ1kLtbk8QjBaapZx+Bn+
	T7XrBvDxXENQnoQ1WLc3t948HiTBgGytCNJPvU+52nQWNlSx
X-Received: by 2002:a17:903:11c6:b0:2c1:4228:3321 with SMTP id
 d9443c01a7336-2c1ebb62205mr6772325ad.12.1780955795614; Mon, 08 Jun 2026
 14:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608201753.1979464-1-acme@kernel.org> <20260608201753.1979464-4-acme@kernel.org>
In-Reply-To: <20260608201753.1979464-4-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Jun 2026 14:56:24 -0700
X-Gm-Features: AVVi8CezuoXtsYQuClbptMaDVHoMVumf3hP_7T6trIPKaL2QYDMWuSijJMkz8PY
Message-ID: <CAP-5=fUnohrU5_CzJ8Ua8D8tTyR=HDwCBUeteu39pV6cZvH4+g@mail.gmail.com>
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

On Mon, Jun 8, 2026 at 1:18=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
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
>
> Fixes: 0c4c4debb0adda4c ("perf tools: Add processor socket info to hist_e=
ntry and addr_location")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Kan Liang <kan.liang@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/event.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 66f4843bb235df53..001db00be1073ad4 100644
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
> @@ -836,8 +837,14 @@ int machine__resolve(struct machine *machine, struct=
 addr_location *al,
>         if (al->cpu >=3D 0) {
>                 struct perf_env *env =3D machine->env;
>
> -               if (env && env->cpu)
> -                       al->socket =3D env->cpu[al->cpu].socket_id;
> +               /* bounds-check before truncating to struct perf_cpu (int=
16_t) */
> +               if (env && al->cpu < env->nr_cpus_avail) {

Isn't this already covered by the test in perf_env__get_cpu_topology?

https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/env.h?h=3Dperf-tools-next#n199
```
if (env->cpu && cpu.cpu >=3D 0 && cpu.cpu < env->nr_cpus_avail)
  return &env->cpu[cpu.cpu];
return NULL;
```

Thanks,
Ian




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
