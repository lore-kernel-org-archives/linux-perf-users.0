Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3416F28DF33
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751302413; cv=none; b=n9lRQXMsU5nUt9TCquvqy/rso3HOAdVX2qAdhmhm+nEvZtCKyDw6pDcTmXk4nnCa4qNYPVKCDE5QUKfKHtUT1xGe/qUI3X1T+TWUrZjib6c7XiQaWMNlZGRVdDpNgmBpV1+fu7GGbK4cuB9fcVZ99lOOnXBB+eyXIThEjYpfM+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751302413; c=relaxed/simple;
	bh=m6pmDLKNitXJTJlESycGVZSxzg/NqK0rrzta8btP/PE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvK9D7WIEPPl47LudTJMUULu8uaTMoi8gURkp2CE8BnGBeCPpVLKV2inuhmZewp0+g+lkko5aPEb2j261NfsgldoPa8gIe6qgSXR+SBM3g/cN13i64he7M526eCbPVt1hEjrh2l+yfW/CcX/yDx0KWBricgkD9cgGkJ1C32QwVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gFMsuxQ4; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gFMsuxQ4"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so10725ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 09:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751302411; x=1751907211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koSKvu+nJp3uxbt5cwdf0o3CkZhZBMZ1Z75ULUCsakk=;
        b=gFMsuxQ4QY8fla2gUPsxWZ1Vv1bvYIPj/IfxFM5xSYS2QJ7sDZwI+iJviZ6Dpk08uL
         dlJdF0D/rH7tfvQXU6jNp/Yfr9NiV9hiSSJgRLRuuZcfvYdD4AkyBUrTQJShDIDBGBeh
         /I3OHjCRC0oINTiDwB/5gsdcKhLOGUhBHmcW6TCT5n5yVQPPjT9ZsKo6wdRsMxxpra/i
         OetvTcU7upL9zXGkcUrUprSUc7jFmHng+ZugMhUX788tnVqRYBL+fNtX00jea4N/SP40
         SUzDkxvmTex2nMud8/Mmlzep2kddBPNlnY4i9ev6u5vckQcQHTS/5C82We9dzsB+opAw
         svRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751302411; x=1751907211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=koSKvu+nJp3uxbt5cwdf0o3CkZhZBMZ1Z75ULUCsakk=;
        b=aw2hnG4xIHyvMh72qhw51V0lbZ6zaxXWcxBX7UzVAHEGhQSekUr6jjZS9aeVD0sQJ4
         TJP9rZ2P0PzpyMYRhUPe59wYt5tQnL6aqcG2+0F7RxWZ/Rpnubu2mx9EsGWqbRJIQdoJ
         IAwBtehje8rwZlfbgOSFqOe4Dk44ohBTu6elz2RU+RWd9PmwBJJDHCypMnlpeMle+0lV
         B8/Jeq3JnUz/Foq8bHJje6a4gmkEo+g3OTTxwPYb7/45oHTo9zDxfIG95CiCfhbqHB4e
         AY7wd88+enU9IYJMdOMQDynQLod93QqRjfF18piDukyqja6YS8EGkRrVE6rzZ57++8N/
         mKHw==
X-Forwarded-Encrypted: i=1; AJvYcCV3Mhnfqyv2i7R17ClRauyI3SB48wuWbhQDs5xNTbYxoDpdwSXl8cgGKBkPK1lKlFgiI+fLtEjdwmhs5g+Q58sI@vger.kernel.org
X-Gm-Message-State: AOJu0YxkUwv+jRZqIzN1XEoeYLDoGSB4UyFbFU6Mnial5qlaEtjQ4Rd6
	mAjld3kbKYZBwb8aj7L6R380ajkIntIim3biQx0HlTy3GD1hvcUWPhD8fnQq7RWi9H4oYt4+7rl
	0DA/gnpjWdX8kTNvT+7+qMY/Xfjvmk01Ng/0YSixE
X-Gm-Gg: ASbGncvHCUk4g+1JDkwR1regBSax4TqErCwcTrnPqpzUGydBKwrrUFTWMDUQarhY3uq
	/1nBrFG72TbivulFpab7xUhnf9K+wdu/g+87hk54SnEIsIHpUjZlQwOhs7a0vKylVK3Qlly0K53
	sM8f0nHjH0vvYzkaJvpT1w7of9xHkeTw0a4fv25AQyGOIbTi35OMfveKo43o28NDZFMpu54A8=
X-Google-Smtp-Source: AGHT+IHf4Dw8AT09cTLDPz/Q487i7S0vAQhToyal3XnhCSdoAf6NiHqu4ggTYRi5WambGva/HYOXYgw+LKcaM0/XK40=
X-Received: by 2002:a05:6e02:1807:b0:3da:7c33:509c with SMTP id
 e9e14a558f8ab-3df56ce725bmr7175165ab.11.1751302410870; Mon, 30 Jun 2025
 09:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630-arm_spe_support_hitm_overhead_v1_public-v2-0-2e1afab313b9@arm.com>
 <20250630-arm_spe_support_hitm_overhead_v1_public-v2-11-2e1afab313b9@arm.com>
In-Reply-To: <20250630-arm_spe_support_hitm_overhead_v1_public-v2-11-2e1afab313b9@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 30 Jun 2025 09:53:18 -0700
X-Gm-Features: Ac12FXwouBTXnLdSPlYJcdiMXR08fBuompdMOwzk6okmpTBgNCFaF2SVe7qtqQg
Message-ID: <CAP-5=fUPfKB5Va_+sO25yf5Y-SjQTR6WsauqcmxirVzgjRNVAg@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] perf arm_spe: Refactor arm_spe__get_metadata_by_cpu()
To: Leo Yan <leo.yan@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	James Clark <james.clark@linaro.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, German Gomez <german.gomez@arm.com>, 
	Ali Saidi <alisaidi@amazon.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 8:24=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Handle "CPU=3D-1" (per-thread mode) in the arm_spe__get_metadata_by_cpu()
> function. As a result, the function is more general and will be invoked
> by a sequential change.
>
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/arm-spe.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 3715afbe1e4713b5eebb00afbcb3eaa56ff1c49c..5b6699f192e5e58bab6b0d8e2=
e8df80fdf404a36 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -324,6 +324,19 @@ static u64 *arm_spe__get_metadata_by_cpu(struct arm_=
spe *spe, u64 cpu)
>         if (!spe->metadata)
>                 return NULL;
>
> +       /* CPU ID is -1 for per-thread mode */
> +       if (cpu < 0) {
> +               /*
> +                * On the heterogeneous system, due to CPU ID is -1,
> +                * cannot confirm the meta data.
> +                */
> +               if (!spe->is_homogeneous)
> +                       return NULL;
> +
> +               /* In homogeneous system, simply use CPU0's metadata */

Could this be derived from the spe's pmu_type? Something like
perf_pmus__find_by_type(spe->pmu_type)->cpus ?

Thanks,
Ian

> +               return spe->metadata[0];
> +       }
> +
>         for (i =3D 0; i < spe->metadata_nr_cpu; i++)
>                 if (spe->metadata[i][ARM_SPE_CPU] =3D=3D cpu)
>                         return spe->metadata[i];
> @@ -926,22 +939,7 @@ static bool arm_spe__synth_ds(struct arm_spe_queue *=
speq,
>                 cpuid =3D perf_env__cpuid(spe->session->evlist->env);
>                 midr =3D strtol(cpuid, NULL, 16);
>         } else {
> -               /* CPU ID is -1 for per-thread mode */
> -               if (speq->cpu < 0) {
> -                       /*
> -                        * On the heterogeneous system, due to CPU ID is =
-1,
> -                        * cannot confirm the data source packet is suppo=
rted.
> -                        */
> -                       if (!spe->is_homogeneous)
> -                               return false;
> -
> -                       /* In homogeneous system, simply use CPU0's metad=
ata */
> -                       if (spe->metadata)
> -                               metadata =3D spe->metadata[0];
> -               } else {
> -                       metadata =3D arm_spe__get_metadata_by_cpu(spe, sp=
eq->cpu);
> -               }
> -
> +               metadata =3D arm_spe__get_metadata_by_cpu(spe, speq->cpu)=
;
>                 if (!metadata)
>                         return false;
>
>
> --
> 2.34.1
>
