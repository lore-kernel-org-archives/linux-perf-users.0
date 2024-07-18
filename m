Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F7E13D89D
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721309087; cv=none; b=i7AoOR8jYqULVEPIeBBH/+j+Ikj+NSz1QuZD6pNtErAMX1beC0/b/IM1UDVdp8b+p0C8qLx7bs7/HA2823gl98ViLbXK1Cg52Fcvph6xJWxrqbGewY8EJk3c64B4lYB7/KzSKBYXgsoVBHUvJ030Ihfo9/bm4pOgTf8ZkBjKUGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721309087; c=relaxed/simple;
	bh=swCmPD17diG2jnavDnksc2NuxVuLrrARkP/gdP3rn44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wm4mEQHZb3fFOq2nWGy/cAbONLb9NLCy+iTFwqUlhy6WHf5BNx2ZRT0OxZZybH3KKvOivQgspNUBTNU00wblB22VUqywfPJx8bR9UJDsDWiUswaSttLuqG3Vyq+yINtTRvpQAI7WMIXdc+HC3Am+I7+OG4+ADgJNmhdL1B+Pwm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WPSi0ob9; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WPSi0ob9"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70b0e7f6f8bso668497b3a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 06:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721309085; x=1721913885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fq6buaq0J77LyE/GBWk8ILfSOIynHPKL2rGxd48KAGw=;
        b=WPSi0ob9on8NvBjFXo1MBKbtxVOM43W3IYo5j5Tabu7GMWi7gJ+IlhTPLOCb/S8Xox
         2muhXT/zI+wu8BvjiWmSyhrTCaJWeahwp4oQzr4hQGoZ53a0ME9kJNzaNcHXznUSF39k
         HHQez9HbaiOsKlpzXx0ycdO/0fcIds55tdUlFPEj/3hFlAlRFNqOVpSRyO3yYV9NO1kk
         ktqPBFwvSPEl6qHvsVrTZObk2stf9NBZy9kKFE1UseVa793nZhLwLKdtuqn1pv4JFgfb
         TdbNoUF2L3/sjF8H/VAHg0qq+KpBzhp6AkjdplJWFbjthqNp9x+jrT5oDqSzWfPqe1O+
         D4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721309085; x=1721913885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fq6buaq0J77LyE/GBWk8ILfSOIynHPKL2rGxd48KAGw=;
        b=ZCI9ZKoYwCVrgRPjVJxTOpyZ4n//JRPK0iI9E82RnIRn6DX8jLk34NfNND4V1rNOQk
         PxF/Miwlr6ZwJ10V7kaQ9x89sVRyWoFNT0kUmhSTP51lMg2b9WBv4hdn/ebZFP676h4n
         YudM5TnGMeSm2NhvY8bDBTaYVDtg5/o0i+v9GdadNU1jZ8BdcSM3Kn8Bxt+fN0UIOfia
         Xnq0BUVHYvYsrk86EHB18i0+sjUMbEBOlFIUir/wsKsX8WKQtxyNwZZ5uXHbg+yXYY2F
         yGfYI1paP6KqOJunPfVdBz6cxfaP5GVCDS5EfwIifwqmqgPPCAKBf7VEKFkIB7S8Kgpp
         UEuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNGD4iKkx4odYgg6pvbGGKGUlW2dkYFN7opz8yHqc+ZMTdEpF82pBD6WbcMonzNV8d2odDATu6NUtAsCVlpm6QVw5+LKvQcJDdH4jNgielaA==
X-Gm-Message-State: AOJu0Yy5jpViQK2hMQgg8ghfnmUjVzbB3TsWkL5+doiPQAXjc7GktFYO
	kg5H/YdRDGbdEbRdmbcplKqJSHLepiayaHjRIz1jItqJy2du5sv7JE124E397u5upjyLoQ68kdO
	GiBDu1x49F00xvLd/uV58oiArxcpoKCoLskFQ3g==
X-Google-Smtp-Source: AGHT+IH9mIMsGzBmrv3QWb32eFUfrlMcHd5f8eA96tyiDq6Dw/aKdX2ecIK8CZzn1z6FPeTtkwF7rM24BmD+rSYOAdo=
X-Received: by 2002:a05:6a00:4b15:b0:706:8066:5cdf with SMTP id
 d2e1a72fcca58-70ce5066a47mr5635179b3a.21.1721309085199; Thu, 18 Jul 2024
 06:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712102029.3697965-1-james.clark@linaro.org> <20240712102029.3697965-6-james.clark@linaro.org>
In-Reply-To: <20240712102029.3697965-6-james.clark@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 18 Jul 2024 14:24:34 +0100
Message-ID: <CAJ9a7Vh9GwbFZQDH=FedjnvdVPrOQnftCpu2CBh4EFT=kbg_2Q@mail.gmail.com>
Subject: Re: [PATCH v5 05/17] perf: cs-etm: Only save valid trace IDs into files
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, suzuki.poulose@arm.com, 
	gankulkarni@os.amperecomputing.com, leo.yan@linux.dev, 
	anshuman.khandual@arm.com, James Clark <james.clark@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jul 2024 at 11:22, James Clark <james.clark@linaro.org> wrote:
>
> From: James Clark <james.clark@arm.com>
>
> This isn't a bug because Perf always masks with
> CORESIGHT_TRACE_ID_VAL_MASK before using these values, but to avoid it
> looking like it could be, make an effort to not save bad values.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/arch/arm/util/cs-etm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index b0118546cd4d..14b8afabce3a 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -643,7 +643,8 @@ static bool cs_etm_is_ete(struct perf_pmu *cs_etm_pmu, struct perf_cpu cpu)
>
>  static __u64 cs_etm_get_legacy_trace_id(struct perf_cpu cpu)
>  {
> -       return CORESIGHT_LEGACY_CPU_TRACE_ID(cpu.cpu);
> +       /* Wrap at 48 so that invalid trace IDs aren't saved into files. */
> +       return CORESIGHT_LEGACY_CPU_TRACE_ID(cpu.cpu % 48);
>  }
>
>  static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr, struct perf_cpu cpu)
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
