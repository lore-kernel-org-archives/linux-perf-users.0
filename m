Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC0442AA4
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751297735; cv=none; b=N6gwOpDTOzPNTZjXXJxz+4hFpZV+KzsWhjxN8NyXnK5Hf/WU5k2eRY9GrabgzY7a+vqlETcNbRWum1Hnt7/bLC6dTz6Ohdd2TiSn5yFuhGkMHM82EU4j/EjCfz3T3S0jgInSOJHFGhO0THrsSvdnvM1lNTsi3ryNolVeyX+ITeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751297735; c=relaxed/simple;
	bh=WzUsL62s99aMQbncJlzVXJNCLYFnik+CIGI7EJNTcOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyOVc+atXVjMMDDqOi7uX5WmAD9D4WEUtO9LUqi8AklTmU/qZfZT9j3WFiXzBck9wXZCf30cnheBSoViGka8f2O1O50K8YhI1CyvwiYOPXi3N4Qyl8QI8pEINYuZzd+6AnqALUmTSh53iQhTRtiwJ6OVoaWqnFAvhIghQLAcz44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ByZZzgEO; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ByZZzgEO"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so488665ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 08:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751297733; x=1751902533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbO9psxgk55oppNmRGWDGVoNc1FLKxrpCgi5quujmE0=;
        b=ByZZzgEOrsnKfKVfx0kLc6+wQRCMi30ELjB5ZTTNVkJ+gY7CSb9cYvkof+UsdCR96w
         ULMiQSG1+HV/Zv72bzEmiXP9e/lFQ/q9fpqD2OdZaZgafwKkn6fLLELouDwGCf8OjAGN
         FbxxmF/WpKY22R0gceT9HfVP8WUTM9DndZ5OAtzDExAAtY0b4We7Jl+DDSVyYsdiatyz
         z51RYlMMsCznCrJ+EdsCcnqcbNJBTN6WX0Mr+2+Os0bloILRu9wy4GxlZw6I/UOW5K4D
         x7nEtlFloWPa3fl2SfpVrChHgT2FdyDXEe7rjKeBi2Vxp2jtt5MB1kWBjCGMmh9bFuxZ
         /M+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751297733; x=1751902533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbO9psxgk55oppNmRGWDGVoNc1FLKxrpCgi5quujmE0=;
        b=VrImQwWM52eaBimV5wqHQ3E6CRGR+T+RkadOiSBgxCFvvFSgyQ7MPCAeRxXZCuoLOc
         V43BJSMAkpteD4nHqWA1kt+jr3vgiUDNBxpxEG/jm97WI1r7zLzPugAydUushIuVF2qQ
         2L1aDNqrDe8FvzsMjNL1T4CeTbmQ+4NHAOdCcL7xZJIciH/t+/e8VsRSe3H91+Ly+yby
         jUMcYgnYI2uVhE88RN6TwWzyAko0AMhX8sTmm0uPg5PL9MbcUM2zdPF3PT5gWbvm/iYD
         bd9SaIzxL888XpthBPM6R4NV3aNCJI6daLG8fl09T6Jy/Mt3gNvLrz2YkcxuRES9Qfqf
         weNw==
X-Forwarded-Encrypted: i=1; AJvYcCWFOmzLtf619BoRvxY46MQ7jYjioOGaLwIcIYAbtMPzCzco0tI370EecnYXnSfr6utnjB7GB+IqB94kog8GcOZC@vger.kernel.org
X-Gm-Message-State: AOJu0YzJMbJa4+RwHv3xu1Nfpl+ZI3MX6vn7sXkXxyjOBUz1YIpBnbK1
	USQ6gqeeAYMtCJaB/EXCw1pSohJ0iUduSlhW1W7NuQaPsGeOu4iG+QAikoMA0Rqb6BdlCwjnUyd
	OxNUHqGeISnBCY9CNpHY8zX9N6e4VCzlyUy05aW87
X-Gm-Gg: ASbGncuLGvYOeVOvrsOmJhaKDJMGVoKaH1RA/cJYBOcD0vwUZjGGw94cE/9VR3wFeKd
	z99U7632+iCtivwsphPxO4pkoks8HfYIYflZzdJsfL51AqzbmtImHCEMJaRWEMEBcVek+40tIah
	nbxlwfPeCKifrNLJwD/LRF1unE6dG4/sz0jhi016IP0yHrvvxYtVLpFWUZ+QUF6MHwx3AXhFGJL
	JxoqwqivQ==
X-Google-Smtp-Source: AGHT+IHOX7kF7dn11PIYsXqc5Lvgd9CFgVl0JgQOIRErwaVxAn3VrCW+V5ML7ah9kVF847kUzTGbYaJQz6lAmBOdyCw=
X-Received: by 2002:a05:6e02:1a6c:b0:3dd:d664:7e0d with SMTP id
 e9e14a558f8ab-3df56d1d4famr6330985ab.25.1751297732904; Mon, 30 Jun 2025
 08:35:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-james-perf-feat_spe_eft-v3-0-71b0c9f98093@linaro.org> <20250605-james-perf-feat_spe_eft-v3-6-71b0c9f98093@linaro.org>
In-Reply-To: <20250605-james-perf-feat_spe_eft-v3-6-71b0c9f98093@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 30 Jun 2025 08:35:20 -0700
X-Gm-Features: Ac12FXyUBSBjSl_fXOEDXQ0KnLnvxPP2kraYhFsM6cPyGu_cMbUCD4cbUl7FD2s
Message-ID: <CAP-5=fVZjqapNHhZ_Gro39JmJ-57nEun-SQhM_rd=MkQbx3GLA@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] perf: Add perf_event_attr::config4
To: James Clark <james.clark@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, leo.yan@arm.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 3:50=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
> Arm FEAT_SPE_FDS adds the ability to filter on the data source of a
> packet using another 64-bits of event filtering control. As the existing
> perf_event_attr::configN fields are all used up for SPE PMU, an
> additional field is needed. Add a new 'config4' field.
>
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  include/uapi/linux/perf_event.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_ev=
ent.h
> index 78a362b80027..0d0ed85ad8cb 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -382,6 +382,7 @@ enum perf_event_read_format {
>  #define PERF_ATTR_SIZE_VER6                    120     /* Add: aux_sampl=
e_size */
>  #define PERF_ATTR_SIZE_VER7                    128     /* Add: sig_data =
*/
>  #define PERF_ATTR_SIZE_VER8                    136     /* Add: config3 *=
/
> +#define PERF_ATTR_SIZE_VER9                    144     /* add: config4 *=
/
>
>  /*
>   * 'struct perf_event_attr' contains various attributes that define
> @@ -543,6 +544,7 @@ struct perf_event_attr {
>         __u64   sig_data;
>
>         __u64   config3; /* extension of config2 */
> +       __u64   config4; /* extension of config3 */
>  };
>
>  /*
>
> --
> 2.34.1
>
