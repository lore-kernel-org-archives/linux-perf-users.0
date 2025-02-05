Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C5F21423A
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Feb 2025 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738788473; cv=none; b=ALksZVUAs8u77nKDtmlo08rvyoggzAaxb4M313VaLmrw109u5TrUrwdKBoqSLEbjDqYRP4GHnxlDAXuNGpUdwZV3xzZC1anFfnxBxCtSmcAWUFD5zcnYKJokTV9COUeRjHxYYLqVZZAHTD4eiCFiMjaJPXPCuvAj6orALMV1BYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738788473; c=relaxed/simple;
	bh=rU0ctC7rOtBbtvVcAjSEvVnzlmDJ2Rez5/8BZgHt+xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SuhLNnOfGwCF2N5UfxIdTXfCYszMowsxLm7sTiPnoQ1r/AvZT9ylgdcox2ffnu5rh3BQx9GmuMCVBOW1a2hKI+M+EREYi+uUy2u3QEZtZoV4CGklPo3L7Fs0DtKlkdyShrwZegR1PKQC9maCeqFRiHlHyjN7szPBKVyRzSJOAbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BKi6i9Ad; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BKi6i9Ad"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d04b70fe79so25195ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 12:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738788470; x=1739393270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qO3VLGfpIyW7n/mpkrRU9S3W3XvjrnoMDTo4eY/G6UA=;
        b=BKi6i9Ad/3CLLMV1AOC6F03JbxYWiiQnpt9jInEYQprYUY37RTrkdGk+LYcSIjcCbk
         U8Rdgtp3ykGT0tnFi5gWFPF301CpVQdlt48UQ/w26PjzD8MMBYy5Eb+2SCCKEHOVAcJC
         tCJYLMmYcyUGgY4/H6WOEz0lqgR8xiEqrP/YqVYo3EM4A+Xnh3rGaCmMhcXYTwBvTzE3
         MiIAk6MlqVsxEmTaPd9iMcAaHAsx0gFww8tO3faJlTKY8AC/Wk8rO2vYn6E7J4JPu+xp
         zYzSWhIUmitv70ny6kmXh6Sotlxijgf0tk92+xPZe6i3yJ8O4Dln2Qq53lR1UZQeL3Bv
         ws9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738788470; x=1739393270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qO3VLGfpIyW7n/mpkrRU9S3W3XvjrnoMDTo4eY/G6UA=;
        b=pjWZlfQt8DKslEb1Z1tAWZUpkthO4FomntV+NdsASs9Gltxt1qRnIfUBCefTEA+/Z2
         ZiFU/L8BP+axJTR9jKNLMMvj1tvLtIwhhJ+KNIvtvUAH8cIwocNeIFMTaoaswMryWMTR
         T0jXXMABuFtBT2mXegASxacrXGQgHQz+J4Cw3f/4RP2TE7HOawu49YbpMhxQVwUVZYMS
         VcoUmh5Yu2HiH0ewVZx9pikTi6YUSKE6PdvlBgJ+2SEsztULLNs3jBFkLnWLZS6T2WiG
         rcu0w6/cN1srPDl/VV9cn4VH0a2sqJ2ko/eBRt3tB1m/GALdz1+9NVUETX28PPM2Xci6
         5u8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXr2NY8DOf+CnLn1XpS5NAeH5GzKo0O/p6MJptwIUsmHgooYJSpws6ymR7yXHoMg0ZF1Jbm7/t5Qden+HzcCnNa@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ib9cykKa4WRbJU+pGVn32JQCLXlzSPcTig5h8POrh1yv5l3J
	6Vn3iNxpEUVOIGyv0mtmYWo2wDdyg7ejxgjB8Z2cRTNL74iet4BJg4S03vgKXS3SqV62FL1bope
	1nV1UnyuP9zB+yYR0gjfdBZbfN7XzP7hZsN74
X-Gm-Gg: ASbGncsILrVBBSdj6Jgy44/9KuHzUwYfHUWSxEyk9oWx+nbzhEEVzL5Gxwf0t8Cpx7a
	sGKjXrvrfZwSTasX5ZCMwfztbTHoCT4BCedgQRKZbvLW5kAiRYvn3rGbMy6OrBs8Ds8TMzutB11
	lCNhVq7b0WewsoLwAN8rHVuboQ
X-Google-Smtp-Source: AGHT+IHJnefBKwcS3pswiENouUkaAd3Hiy1kZfPbDXW7Wl7NrpVnF9fY6D5TADaLx1tGX8uwqg0KXDS/aO+qCYmly/k=
X-Received: by 2002:a92:d1cf:0:b0:3d0:507f:38dd with SMTP id
 e9e14a558f8ab-3d05b4befcfmr423545ab.5.1738788469762; Wed, 05 Feb 2025
 12:47:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205173140.238294-1-irogers@google.com> <4f42946ffdf474fbf8aeaa142c25a25ebe739b78.camel@intel.com>
In-Reply-To: <4f42946ffdf474fbf8aeaa142c25a25ebe739b78.camel@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Feb 2025 12:47:38 -0800
X-Gm-Features: AWEUYZkjLLl2RiWIh_PBTKbSre4apLrTUqpKx5SDeXneyEXwT4EWNR30bpCGuKs
Message-ID: <CAP-5=fUjx3PTHfjgkam9Q0xE+TrYx+FSzF8wUscbD9X36gJ1Tg@mail.gmail.com>
Subject: Re: [PATCH v5 00/24] Intel vendor events and TMA 5.01 metrics
To: "Falcon, Thomas" <thomas.falcon@intel.com>
Cc: "Baker, Edward" <edward.baker@intel.com>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"Biggers, Caleb" <caleb.biggers@intel.com>, "mpetlan@redhat.com" <mpetlan@redhat.com>, 
	"Taylor, Perry" <perry.taylor@intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, 
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "Alt, Samantha" <samantha.alt@intel.com>, 
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "Wang, Weilin" <weilin.wang@intel.com>, 
	"acme@kernel.org" <acme@kernel.org>, "afaerber@suse.de" <afaerber@suse.de>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 11:44=E2=80=AFAM Falcon, Thomas <thomas.falcon@intel=
.com> wrote:
>
> On Wed, 2025-02-05 at 09:31 -0800, Ian Rogers wrote:
> > Update the Intel vendor events to the latest.
> > Update the metrics to TMA 5.01.
> > Add Arrowlake and Clearwaterforest support.
> > Add metrics for LNL and GNR.
> > Address IIO uncore issue spotted on EMR, GRR, GNR, SPR and SRF.
> >
> > The perf json was generated using the script:
> > https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> > with the generated json being in:
> > https://github.com/intel/perfmon/tree/main/scripts/perf
> >
> > Thanks to Perry Taylor <perry.taylor@intel.com>, Caleb Biggers
> > <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>,
> > Weilin Wang <weilin.wang@intel.com>, Kan Liang
> > <kan.liang@linux.intel.com> and Thomas Falcon
> > <thomas.falcon@intel.com> for helping get this patch series together.
> >
> > v5: Remove Valkyrie metrics mistakenly added on atom. Ensure "perf
> > all
> >     metrics test" doesn't skip for missing events.
> > v4: Fix TSC events on hybrid mistakenly specifying the core PMU
> >     inhibiting the use of the msr PMU.
> > v3: Fixes for hybrid metrics that were missing PMU. Update to the
> >     latest events.
> > v2: Fix hybrid and Co-authored-by tag issues reported by
> >     Arnaldo. Updates to Lunarlake and Meteorlake events. Addition of
> >     Clearwaterforest.
> >
>
> Thanks, I'm seeing some errors during the perf all metrics test:
>
> Metric 'tma_info_system_cpus_utilized' not printed in:
> event syntax error: '{cpu_core/TSC,metric-
> id=3Dcpu_core!3TSC!3/,cpu_core/CPU_CL..'
>                       \___ Bad event or PMU
>
> Unable to find PMU or event on a PMU of 'cpu_core'
>
> event syntax error: '{cpu_core/TSC,metric-
> id=3Dcpu_core!3TSC!3/,cpu_core/CPU_CL..'
>                                \___ unknown term 'TSC' for pmu
> 'cpu_core'
>
> valid terms:
> event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,config,config1
> ,config2,config3,name,period,percore,metric-id
>
> event syntax error: '{cpu_core/TSC,metric-
> id=3Dcpu_core!3TSC!3/,cpu_core/CPU_CL..'
>                                \___ unknown term 'TSC' for pmu
> 'cpu_core'
>
> valid terms:
> event,pc,edge,offcore_rsp,ldlat,inv,umask,frontend,cmask,config,config1
> ,config2,config3,name,period,percore,metric-id
>
> There are all some errors like this,
>
> Testing tma_cisc
> Metric contains missing events
> Cannot resolve IDs for tma_cisc: cpu_atom@TOPDOWN_FE_BOUND.CISC@ / (5 *
> cpu_atom@CPU_CLK_UNHALTED.CORE@)
>

Thanks, I forgot to reapply the TSC fix. You can do it with
$ find tools/perf/pmu-events/arch/x86 -type f -exec sed -i
's/cpu_core@TSC@/TSC/g' {} \;
I can't eyeball this later missing events problem. What model type
does it happen on?

Thanks,
Ian
