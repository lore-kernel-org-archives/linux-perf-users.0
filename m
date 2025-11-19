Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81AA2FFDE1
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763570960; cv=none; b=tuz4mBKZJ+iwNZhNYvVpOExkYu4qZDxCwA7cuZipHtjpw6pRvprnOVa0fbS+JsPTvtzkcdYvLNQcx4d7S0Q67Dl8n8ofRZjjGCnyu6oa6HOP18LEdFeTiHUOqsxdHSlUlMgLFFtU3Ik+rczcXo/JLtgeQcjD+M4+p0zkF5wtC2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763570960; c=relaxed/simple;
	bh=Ntu79LxvHkkLpbqi13VepeqzmJSPf4zQKMOz7mKoU6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rkc5geYIpkGdmEH4Kp2PYeGHoI6K0OXaGkA9r8ezk1VP9HHoTbsazxYFt0r3LNymYLCbp90+bg1KmGy7eHeB4reAHx2q1NjoBwvUF/OlGXgMQhjkIM/adkol2s9iusxtstdorhZiavQk4X0OVE1qsy1YcIWXLmWheITIBmSX02U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N/Z7EAfl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/Z7EAfl"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29852dafa7dso219725ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Nov 2025 08:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763570958; x=1764175758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMXsqgKysW6m2FrQa3pYXbUBYKL4TuiIPv4CnNvKLAM=;
        b=N/Z7EAflTrqkSa+dBTG00mPJcJj10qpHqDUcXhnWgiUdD7VA9XqflFc7mZhDTYENhY
         3/fXZrtoxHNjGROS8ZtfNr/Ba1ruzOh2CTr+TLDKy5fsztwK9PTEht9xy82c49hQ/DNt
         0q10JSXzEQpzs3DG61sERP1Z3ikTunZ1v7h0R/PfgUFEXuTGidRdGB+OPeix7nCcz5YX
         HmSReT19XnvcxLHETPaRo4xVHc7LBgAqTmxJsq+5cyHN9AbcybeVUB0MJA2ut4Ajlj2p
         pDu5KTBAeAL2cqWvJ/o4YUD2Uv4TiLGe4cQDhe91tNq/KEVH69zh68lT6zZkmTMoksRC
         yjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763570958; x=1764175758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sMXsqgKysW6m2FrQa3pYXbUBYKL4TuiIPv4CnNvKLAM=;
        b=w6bmMP7kCKkONH5ysncErn3hgFtTw7QMucTvzBswaEWXHakb0CgT4D1Hu8hBes0Mi4
         Y0ql8E3RHd7mscAMI8HMoJeuHZ2ABrMoNrQob5Ys8hwH02bFsZPCspsmX5MNh8/9WW06
         N53sR0mw7CWLok/cT1yTRw6+soAkqgMith1ljWzx9iTuSVgzPgGmpZVLSuQrPG/X/bmA
         6zUliuDo4GHO2PP8ZzEI5HqIKwJixw/SDg3xnzI+AX7Ds8dCCCprkGe2+KqYM74UUWVf
         dTplkdUv1ogILFVLGFef3WuMmuV/6qxr6uEEsXEsjz7tQqgaBlwbZ/5ExEpIyeP7t4iN
         EPNg==
X-Forwarded-Encrypted: i=1; AJvYcCV87LDtJQVXJWI9rzA2b6D13IxxOIq8wsF0GFREJ+lvDsZ0Dpr2AHKeAaTWWHUdVT2h9Ogp7S3hAbCAlAyqYfsH@vger.kernel.org
X-Gm-Message-State: AOJu0YxFFstDVMinePsXqYwoUtwj82DK5lsWQzylmZW8YOvtUY+dEMfW
	5mpoXwV8ALSO2DR2J5ltdlJrs2a0lPSxUtJLQS/gSbnpBS3g0XbUdDWVmMCtMgXqdhdFvEcVewa
	CpOqzH8IHHTrkT/QI3v3b6cDCfR6GqTjFTn124+0b
X-Gm-Gg: ASbGncvEyquiAPQBU5sQ58MkI9Vmo1cUNc3sb+Tt6oHmr7GlKjjqmTBHuzrT3AnQIoA
	4P3jVr6VZSZZYQOvtqWvNMbER5i+64wO+wXlmEjolVqZQ+BwzaBPhzaNzc1Mk7QCALSA1qzydas
	0/UdfI811izSixyQ/DV5+afoW2O7PBGoKgNo60AX3nrVgH5vBOAXXsNa+T6gHD/JeB5pEsK3dHC
	469k1HUisJvfD3n29HhM0J6qEhG9qgDXFDtU9eaq+zLoGLa53UqXJTLnDmKaDjpw+YPusGvPH64
	2Nx8FP67RmHXt5mOTeGmooAflA==
X-Google-Smtp-Source: AGHT+IFwgAnkLR0jx5LdmWn3kQVmzzBqFc3ZBGwWcfrEixV6e2Vn8lfZW5HJjzboKiJOREeEKIkahsDPoO/Vh1R3le4=
X-Received: by 2002:a05:7022:e01:b0:119:e55a:808c with SMTP id
 a92af1059eb24-11c8ddae890mr119358c88.9.1763570957615; Wed, 19 Nov 2025
 08:49:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115234106.348571-1-namhyung@kernel.org> <20251115234106.348571-2-namhyung@kernel.org>
In-Reply-To: <20251115234106.348571-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Nov 2025 08:49:05 -0800
X-Gm-Features: AWmQ_bmWEG9oywEpm1PC44iobFk4gdVnk4-eYJda-DCWGCTGZHFeOLwBPXQD-Lg
Message-ID: <CAP-5=fU135iJV72o6tLEBj2GW-uMsQdnnbE=hTAz3rDbmSnBEg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] tools headers UAPI: Sync linux/perf_event.h for
 deferred callchains
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, Jens Remus <jremus@linux.ibm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 3:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It needs to sync with the kernel to support user space changes for the
> deferred callchains.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/include/uapi/linux/perf_event.h | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/l=
inux/perf_event.h
> index 78a362b8002776e5..d292f96bc06f86bc 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -463,7 +463,9 @@ struct perf_event_attr {
>                                 inherit_thread :  1, /* children only inh=
erit if cloned with CLONE_THREAD */
>                                 remove_on_exec :  1, /* event is removed =
from task on exec */
>                                 sigtrap        :  1, /* send synchronous =
SIGTRAP on event */
> -                               __reserved_1   : 26;
> +                               defer_callchain:  1, /* request PERF_RECO=
RD_CALLCHAIN_DEFERRED records */
> +                               defer_output   :  1, /* output PERF_RECOR=
D_CALLCHAIN_DEFERRED records */
> +                               __reserved_1   : 24;
>
>         union {
>                 __u32           wakeup_events;    /* wake up every n even=
ts */
> @@ -1239,6 +1241,22 @@ enum perf_event_type {
>          */
>         PERF_RECORD_AUX_OUTPUT_HW_ID            =3D 21,
>
> +       /*
> +        * This user callchain capture was deferred until shortly before
> +        * returning to user space.  Previous samples would have kernel
> +        * callchains only and they need to be stitched with this to make=
 full
> +        * callchains.
> +        *
> +        * struct {
> +        *      struct perf_event_header        header;
> +        *      u64                             cookie;
> +        *      u64                             nr;
> +        *      u64                             ips[nr];
> +        *      struct sample_id                sample_id;
> +        * };
> +        */
> +       PERF_RECORD_CALLCHAIN_DEFERRED          =3D 22,
> +
>         PERF_RECORD_MAX,                        /* non-ABI */
>  };
>
> @@ -1269,6 +1287,7 @@ enum perf_callchain_context {
>         PERF_CONTEXT_HV                         =3D (__u64)-32,
>         PERF_CONTEXT_KERNEL                     =3D (__u64)-128,
>         PERF_CONTEXT_USER                       =3D (__u64)-512,
> +       PERF_CONTEXT_USER_DEFERRED              =3D (__u64)-640,
>
>         PERF_CONTEXT_GUEST                      =3D (__u64)-2048,
>         PERF_CONTEXT_GUEST_KERNEL               =3D (__u64)-2176,
> --
> 2.52.0.rc1.455.g30608eb744-goog
>
