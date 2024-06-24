Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1A013DDC6
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Jun 2024 16:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245818; cv=none; b=tzKUu5pMqIJ5wxqQW5hYHHQQIU+uRDODJ0biKkTTcg0PACb+zgWvSrT9VKC5oBdeg5suaNEqlFlHKVMoUssVZoqKS+CVIKMyjCITiBXEUwKj7CrneZ5+O4KFrX7eO3i5L2qvWxqRjESrun86jtWfjWyrqbtHk+DiAT9NEfO88xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245818; c=relaxed/simple;
	bh=VC15zHdju7sXcUQrdV4uuCooM3b/QyNaod6e42Iz/lE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i++lVn3g2q3MgpSJafL1xmQd2J7wwMyfbIgAxH1AiQQcTfyQi7drSqGqvTdrGPg9JAxzJv0pe7AazORMZHajZ343Fk1A40FrLKT+fyBWNNYmSoAz/BwF/z7c/v04NCdqLSPI2rT8ansN6HmFYeEwVxisWqzTEXycxYo5DeBJtXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y1uzcEEI; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y1uzcEEI"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-443580f290dso1067951cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jun 2024 09:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719245815; x=1719850615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoCuTTuRP9nik68N2jcDiJ0+UlXT5uhKxb/k4JLFLE4=;
        b=Y1uzcEEI8IpE/6wnXy4rk7DAaesQ8JfIDKdwO4kTcQ3lpR6FeCAH81vqQq6OIj0zGS
         x4/+2dTkOSRudYIbSscF9mZ1FKh21tUrGaIbOueoGiJHfZqtFARgqZPFR8Zhu/YZrxLZ
         YM9V4LxSjNXgzZ+PrV7cph8wNn1L83XzFdSqganPtDmB2IErnqTCa2iLy0cN9CC7QosW
         RnzCGeY5DT072t21kegqql/ncigBxFGwuISKrke+LhrJJWN6R/EQHzunI2q8DPKoutqt
         KXv3bUUO1ckLL1RSS6n1Ee7+YTE8tv8mydPgpjGTU3Hjn0lEt/si+sHMavEH3ITbmT2C
         t1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719245815; x=1719850615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoCuTTuRP9nik68N2jcDiJ0+UlXT5uhKxb/k4JLFLE4=;
        b=A0F8S6SPXUWvjGABlzyqbP0K+91v9vN0MBY/A80QG5bUf1ADK4j9IWyU6/0a8N41Qy
         sjVPY90gbphnZ01T25GzAh8P2zEjaTIiKvMlBc6P01G7hrGWb/U8/lgjxv+NdLbx/Zul
         9CBwUAXLjJFsBkq2LdPMPx4kx9FkUauT8zqs0tv6ADZa+Snfas7TDmJE9An4OkrmitTW
         nFCGsr1yUoSvZtsj9wUlsI0BIXqoEhUqMXiP5GonOydLzBipH6VD+oQaGEhCO1N1BYYb
         Q1gh0RJRFXiJMSQExnDFea7Rue4Sj/sVfOOWiqv5IH33iIT8LEBndD4KSo7vA24dRL03
         Dq9w==
X-Forwarded-Encrypted: i=1; AJvYcCViDuRs0JvK5U0JZaWon5bkb3UxyD9sRXT6RgQKIZ9GZ+JyP1xvzEqjBOfBM09zCGux/Ql2elFc/iIz09u9QguM/u3PTarPQoL0+JmL4TdDrw==
X-Gm-Message-State: AOJu0YxtmlJWSoNDDbM6eifa8bAHYjFkaf/UWJO+nXVF/By7+1Hd/lVz
	/T71gSqYSk+2rqBkmRx3NPiph90KIJqYFpo3NH6v9def4wROSVTvb2Z5TU4X7ejeO2TtVlWnTlp
	wYWXURpNy4N/WwsYy3IRs9bpfUe3e5hXvBUmV
X-Google-Smtp-Source: AGHT+IFsUsVaP9g9yLLpm3p1FMcIJY7mfKyNWsnIZ1899ae8yEIlyhLVmzgItOvSQQeU2kn7xvkZJb87BjIxIWBySJ4=
X-Received: by 2002:a05:622a:14c7:b0:444:c3f3:231f with SMTP id
 d75a77b69052e-444ce2eac12mr5751141cf.16.1719245814685; Mon, 24 Jun 2024
 09:16:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623133437.222736-1-leo.yan@arm.com> <20240623133437.222736-2-leo.yan@arm.com>
In-Reply-To: <20240623133437.222736-2-leo.yan@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 24 Jun 2024 09:16:43 -0700
Message-ID: <CAP-5=fWgGR-L6V5RNNpTHdHyT0wTOqKd3CQ8xQSQDAJ1D2edYA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf arm-spe: Support multiple Arm SPE PMUs
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 6:34=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> A platform can have more than one Arm SPE PMU. For example, a system
> with multiple clusters may have each cluster enabled with its own Arm
> SPE instance. In such case, the PMU devices will be named 'arm_spe_0',
> 'arm_spe_1', and so on.
>
> Currently, the tool only supports 'arm_spe_0'. This commit extends
> support to multiple Arm SPE PMUs by detecting the substring 'arm_spe'.
>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/arch/arm/util/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pm=
u.c
> index 8b7cb68ba1a8..29cfa1e427ed 100644
> --- a/tools/perf/arch/arm/util/pmu.c
> +++ b/tools/perf/arch/arm/util/pmu.c
> @@ -27,7 +27,7 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_u=
nused)
>                 pmu->selectable =3D true;
>                 pmu->is_uncore =3D false;
>                 pmu->perf_event_attr_init_default =3D arm_spe_pmu_default=
_config;
> -               if (!strcmp(pmu->name, "arm_spe_0"))
> +               if (strstr(pmu->name, "arm_spe"))

Why not use strstarts?

Thanks,
Ian


>                         pmu->mem_events =3D perf_mem_events_arm;
>         } else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
>                 pmu->selectable =3D true;
> --
> 2.34.1
>
