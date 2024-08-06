Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E81A45948
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Aug 2024 03:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722916464; cv=none; b=gDE/UsBreDaf5p8X6/6bhmvshNq47dsobB7jpnduMX0g7TlTh76zHSwFnqixezdGx+uzVk0k9nkrfh0kMqPa7UW9lKDKQTCmdhsla3GCebZXhYc1QdNidYWd5+YoQkrNpW0PftOHsNhN3Nmn+ecIUpnvNNe4F5s9U/nj1+bXJVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722916464; c=relaxed/simple;
	bh=OHn7wU9Ux6L+zXgz4hDtyYLrDplln0Krvsa/Tanrbn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HGOSdqMbufifPujfGZlyjCqbHq+tKdQjLxjrOHskzyQnjErnrPOuinzcnNjpj9BjsH51w6rBXSy99axPIlwRimALRR4Cez94DM1brdd769d9UgJ73BJSYe5JW9jr2fFlGp22wEDV4tTSXwyriGKVY/N4LuR8+HIq5PdzmwgefnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=XUaANtXp; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XUaANtXp"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f149845fbaso2355851fa.3
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Aug 2024 20:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1722916460; x=1723521260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvzMXnNtbinIR6sxB9Vjeo1DnbXtPT7sraVJvvh8AKs=;
        b=XUaANtXpbu09ETPcGiZ9iL1DPJtSvU4KREKAotBT+gO+YGZuN6zVBGRXkVchgkkgLp
         LEFGnGDQick+jni6E36ZWnY4bC0WO0eDt3hwxh1u/2zbt0BqJoxwdDAhitfx4G4z8vY5
         UEkWYk0SN6i2lCyN68w8w/V5NjHbLLRSbXjhU6osDq7syau4SA0jvYzG5fuRk8tlsMz5
         1pnl/ZlpEGDMHgbRRyE58Gq5nVYyJnfynkC9RT1FaSVklGPH9nWez/+ilK27wBpK4CzI
         3/6uvbkkXGJ7rAteeci16GYcIPvzg9EwEcOB3Z+PaoYk3QtLxqWUZOKhldF8INdBYfv2
         mtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722916460; x=1723521260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvzMXnNtbinIR6sxB9Vjeo1DnbXtPT7sraVJvvh8AKs=;
        b=b8TpUlZej9wGxfmbyq45ce/4CjbtGKUFnyWekqMCXGICtBp68D/hNjCr0+IVLoB5x7
         FvrYWFNLxi6QsbcFJFt4Gqx4dizi4YLOYi0TAs7ZUwjkNvh4VyZ7BDBkHxDaygE5G+Pn
         WOzCj3263vkC23utrp0nVdxb9rY7JfaOGQSwMS3ByuC3SoNsN5Xfa0YqcvVThDCsLLSV
         M11IRq6pwM/8SFC2KsYt/Qr3zqyu+beNWb5vLBZQsKJ8/d77inTB0ScLHSAKf3TfHwsl
         oOYHBmHePxM07uaG6UMFJIbr9UXHxirPUgYsjsSkYux9xLlze2OzKI40+cIOg7sfCuz1
         XqcA==
X-Forwarded-Encrypted: i=1; AJvYcCUN3tUmEWsxRkCpNlQZFtD2ZqjFrR6LPHdZZdWI0h1ZbJfz3mCxcmlLASB+HFMA9ddiXnILXQhuj1yQACkTfGQgVFphJuKdyy7i4qi7MZwdOg==
X-Gm-Message-State: AOJu0YwSkexHIc9eRZD9CnV8vS5MJiw71uApkLFYwnUH13JplqPGMT26
	GQU/yHGV6ZJuyTk/M66VoFz/pkkQ0qG8U1YERCFbJ0Fp3ghB3f2F6pQRTw0yiwcfB7qCK+G8cN8
	S2VlR7Kkt/k9tqaSTKX58D6W4j/FrBvo9E4HVkA==
X-Google-Smtp-Source: AGHT+IED+QfpVh2ns4r5CsCF2Hf7HG0ncsxihC0vDxBSVd4rH9+6r9D1hKisabpmLxEL8TLvLP+nRbgTy3vQUF0nLB0=
X-Received: by 2002:a2e:999a:0:b0:2ef:2f19:a8b3 with SMTP id
 38308e7fff4ca-2f15ab049f2mr93096061fa.41.1722916460054; Mon, 05 Aug 2024
 20:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805194424.597244-1-irogers@google.com> <20240805194424.597244-4-irogers@google.com>
In-Reply-To: <20240805194424.597244-4-irogers@google.com>
From: Eric Lin <eric.lin@sifive.com>
Date: Tue, 6 Aug 2024 11:54:08 +0800
Message-ID: <CAPqJEFpiy307B4OBHK4WJGjgbVm_woUrdZ+Vy_LSdQ=ECqZX-Q@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] perf pmu-events: Remove duplicated riscv firmware event
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>, Charles Ci-Jyun Wu <dminus@andestech.com>, 
	Locus Wei-Han Chen <locus84@andestech.com>, Atish Patra <atishp@rivosinc.com>, 
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, Inochi Amaoto <inochiama@outlook.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Guilherme Amadio <amadio@gentoo.org>, 
	Changbin Du <changbin.du@huawei.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, vincent.chen@sifive.com, 
	greentime.hu@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

I've sent a patch to fix it and the patch already merged. Thanks.
https://lore.kernel.org/all/20240719115018.27356-1-eric.lin@sifive.com/

Best regards,
Eric Lin


On Tue, Aug 6, 2024 at 3:44=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> FW_SFENCE_VMA_RECEIVED is repeated twice in the file which will break
> invariants in perf list as discussed in this thread:
> https://lore.kernel.org/linux-perf-users/20240719081651.24853-1-eric.lin@=
sifive.com/
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json      | 3 ---
>  tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json      | 3 ---
>  .../perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json | 3 ---
>  .../perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json | 3 ---
>  4 files changed, 12 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json b/=
tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
> index 9b4a032186a7..5a996fa4b837 100644
> --- a/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
> +++ b/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
> @@ -35,9 +35,6 @@
>    {
>      "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
>    },
> -  {
> -    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
> -  },
>    {
>      "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
>    },
> diff --git a/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json b/=
tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
> index 9b4a032186a7..5a996fa4b837 100644
> --- a/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
> +++ b/tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
> @@ -35,9 +35,6 @@
>    {
>      "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
>    },
> -  {
> -    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
> -  },
>    {
>      "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
>    },
> diff --git a/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.=
json b/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json
> index 9b4a032186a7..5a996fa4b837 100644
> --- a/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json
> +++ b/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80/firmware.json
> @@ -35,9 +35,6 @@
>    {
>      "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
>    },
> -  {
> -    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
> -  },
>    {
>      "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
>    },
> diff --git a/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.=
json b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
> index 9b4a032186a7..5a996fa4b837 100644
> --- a/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
> +++ b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
> @@ -35,9 +35,6 @@
>    {
>      "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
>    },
> -  {
> -    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
> -  },
>    {
>      "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
>    },
> --
> 2.46.0.rc2.264.g509ed76dc8-goog
>
