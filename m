Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9593009E1
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 22:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769465237; cv=pass; b=LdJaMOwZ759mH0I6cLz2YfnhTj9PgnFtqz+1oJDv5aSA+Tp+zW3qfa4I31srfXqHvm1VDA5WJriTEE35nURPtdU+EmsQv3X0bx5FTEVpLMMpyhueOwbsIBx96l+st1U7Y3ymx5iFJnTUGf5z0gB+o5u/0r4xlD9Gr/Xi/hwKc8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769465237; c=relaxed/simple;
	bh=KAwb02G4E7FzeHNIBz6aWU4QzktcDdU2xhBuwmlCaZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXDWPEZEdq/3cocMcWjxV+hL64Hckrvea9vybeZS/aKt56b1mqZQROHYNUMwqCLOXN1HpwRb2XsLmjZru+X+yRoWAep9S53SBEWXYTLj2kTnxA/SBpFzquaK4UcWaok+o87sn7VGH5dVppBtcpsXMtt8RbrwBOjkFNHDzrdB27s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=etCWox/2; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="etCWox/2"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a76b39587aso10605ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 14:07:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769465235; cv=none;
        d=google.com; s=arc-20240605;
        b=hg2pHWetcUQI/nxw/MvJmH/jo+NWkgNlNBr0hoOndwDUb348nzDuLXOzYotHvay/uf
         I+mMYJGe+J7LFe7m1ZebkkwtKCEYOBY51S3bdOR1Lz3tV/XPWx3ze+yXrUk050ZyxtUZ
         RWjELvQh+YidclghjL05VG6aJsLU1LdP1ardRjKzQtp/C3Vl8oVdosSKOImcG1ZWw6BS
         78NzHGGto1idrDSZwIQWe8Ep5F1cvG+6i7D5BNPVacSRqYRSfm9AAVwSrHmsQ4yjzqOu
         L2kQ0H2w8EDUdDjtRWM8zVcFZiFjLpYo0mSSBN6GmXvNypEfdmwyl7UEw+fwTO+YL/ml
         o4VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R7bls5ssmT6tHeU7M859yZkUA/qvyFK58QdUrH38uDA=;
        fh=SZsqrmeIwkFoFg9KZYtxOlpELQNg5B1Boud7MRS6DMA=;
        b=H0MEyOPgryWBOxDrMQAZrUIkC9n/xmTzMxGdCSrKiAugVEwqO2pwbrlyaKBf8GG0OU
         /xKl6PKFLWx3b3m2F4/yPdLiTPVshrTskcJ/VhAMyT5lqriPFjzzRt6XxkWewOccZtxF
         IcFIoEjHDsziycnjgt+toNAKdGmBqlebCVLHAHs6iL9b9fskCJajLVcJiNK1CKXFGVXo
         2n9jTU5YU201Crh3WN5tbjVGnomp/v+IgEvHKcF6XgzKZn4zO+/2cBcGg7i7NXGY/mBR
         URCOmaGeff0NqIyFuKx/fRasU4kKBfPvP8KrociJFFheH4MbhfmDSNz1m19CzVpuavck
         i2CQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769465235; x=1770070035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7bls5ssmT6tHeU7M859yZkUA/qvyFK58QdUrH38uDA=;
        b=etCWox/2PJ7hcqI2hlU7c0rbHbeS61t351jo9PgNReU0uQ8He6Ya2/Iwd3SDLo4bni
         txhUKL9THAdcEcXUy6Ub+v+afFYwREIPCGgnB69BmY0IXRKM5mPQslxce1Kw9DoR0i3T
         l4WZQ+JxK95p5mKWSqaKOvJpvzUZUB9aDk0e+oX/tQ7nChAyrAR3fDf+cIAWpru6eQTN
         kZLh6mdhvzdLQBEcHUmNbxadNfd13/mU8QOOkWNsOpEo5VHZ5Q8ev6BIB3OZehsJDNXa
         HlQ2xThehKxKXYmTG4PdCQxu94Nosx/G71xdbIn5rzEV1zlCgtujU3458tpOqrrrWr+1
         2uVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769465235; x=1770070035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R7bls5ssmT6tHeU7M859yZkUA/qvyFK58QdUrH38uDA=;
        b=SU1+AOU4nXuKdRaO4OjGBsIK0rcSK77J014PuGz69IAS7GnvyK9BT4jUxbnmlz3I2k
         rpUQieOIz9tlmuth9WweZbuS9T+g7sx3WdzPsZRm2sDnLpxegSXQeZ7KMAlqQJ42Wj5b
         VdGjp5Krf97XQCdmYS6J8CMF/NkR4DDFowyMVJE3nOUraboKzrdlGtA+JjVF2PbGWvSB
         NbnoB2nv+bBESCAB0fIoxwSWvpWyvQ/sr6BOUtxFQysE2SxjtI8YcEi4moO4EmU2HG1W
         Ms1IZn1D1M9pM9yXnjZDQO79/dsq8nm6tfJyM4O7ERYeW62CjRIgG9YgVXkQa1dCxNC2
         OXig==
X-Forwarded-Encrypted: i=1; AJvYcCUY73F3FWYoXDHre8gg3eDJrMSp4785IC2aP8SXnJ0q2TuVG4q70nV2/ni0AeTErljUeU/jCoY+YvmmMUT/n2ON@vger.kernel.org
X-Gm-Message-State: AOJu0YwNT+D4NMYUu969MTWW6ra+iaGq1EJoOMtD6U6HB1JUMm9Dco1I
	+rcXV7p/hCkjk3DC6ONpfK+GG5sbwty9fgt2u0BVSlNsDy1Fq25bgqT2CSCMjvDE8yMaM1LbeLo
	qkTRJOoakzmaiOb45low+JFXZF9cxqWe1kxXz8qmQ
X-Gm-Gg: AZuq6aLZC1XmcQPBbRAi20KBs1hh7U4Fvevz8pButBduJFF6Mr+5jcdjzMmgbKjAzbi
	+vKZ3LjgyvUmQzmduFXlzvh/R+XTR9090eohEmF1/62YNm4PHFO5J3F7SC9jBNEtasHd+jaEl81
	a/xlTkORrZlqDuXtGtf5cBeh8xqfHrBVSqXElw13O0i47nx1560MS+sMYcvCyM/0Kp2eNMsLp7C
	q0j9ypuUoLHraCJjJ6kW+koimZ2dB7f0RM1dEdH4oC14b2NalHO6Wg2d6hPvHfZhiRxXwN+2ZiV
	3bKl2yacODpEqppqvdgZS3ihVQ==
X-Received: by 2002:a17:902:d509:b0:297:f2a0:e564 with SMTP id
 d9443c01a7336-2a844e763fdmr3393975ad.11.1769465234630; Mon, 26 Jan 2026
 14:07:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124001611.1332019-1-irogers@google.com> <aXfUFBfCQ4m_DFrx@x1>
 <aXfUNewGdbqqQL18@x1> <aXfeNfYgDVXhkrKM@x1>
In-Reply-To: <aXfeNfYgDVXhkrKM@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 26 Jan 2026 14:07:03 -0800
X-Gm-Features: AZwV_QhuXePxX70q08ydKUR375Zck1CdKMYGcq2_TDDhDmDRsUx1WZ6N-YLl9CE
Message-ID: <CAP-5=fXhPjQV-TVAYOJh7Dq72iN_H8vHsTmrtgcEtX6G2cj_6w@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] perf more ELF machine usage
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Shimin Guo <shimin.guo@skydio.com>, Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 1:35=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Jan 26, 2026 at 05:53:09PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Jan 26, 2026 at 05:52:39PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > On Fri, Jan 23, 2026 at 04:16:08PM -0800, Ian Rogers wrote:
> > > > Switch 3 more cases where the perf_env arch was being used to
> > > > determine the architecture type and switch to using the ELF
> > > > machine. This includes the addition of minimal instruction parsing =
in
> > > > perf script for architectures other than x86, or x86 when
> > > > cross-platform.
> > > >
> > > > Note: this series will conflict with the e_flags series:
> > > > https://lore.kernel.org/lkml/20260123222209.1181249-1-irogers@googl=
e.com/
> > > > that adds an additional out argument to thread__e_machine. In all t=
he
> > > > cases here that argument should be NULL. So:
> > > >   thread__e_machine(thread, machine)
> > > > becomes:
> > > >   thread__e_machine(thread, machine, /*e_flags=3D*/NULL)
> > >
> > > This one isn't applying.
> >
> > =E2=AC=A2 [acme@toolbx perf-tools-next]$        git am ./20260123_iroge=
rs_perf_more_elf_machine_usage.mbx
> > Applying: perf script: Fix script_fetch_insn for more than just x86
> > Applying: perf callchain: Switch callchain_param_setup from an arch to =
an e_machine
>
> So, please try to refresh it with what is in tmp.perf-tools-next now.
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ git log --oneline -10
> 0a6fb6604746c92b (HEAD -> perf-tools-next, x1/perf-tools-next, x1/HEAD, p=
erf-tools-next/tmp.perf-tools-next, five/perf-tools-next, five/HEAD, acme/t=
mp.perf-tools-next) perf session: Print all machines in session dump
> 2becdd163ab37c9d perf unwind-libdw: Wire up e_flags for CSKY
> 0403930f7b1534e3 perf perf_regs: Accurately compute register names for CS=
KY
> 4e66527f8859a661 perf thread: Add optional e_flags output argument to thr=
ead__e_machine
> 7d0ebeb6c0f735d4 perf dso: Factor out e_machine reading for use in thread
> 76b2cf07a6d2a836 perf vendor events amd: Fix Zen 5 MAB allocation events
> 008603bda19b2968 perf test: Fix test perf evlist for z/VM s390x
> dda5f926a1006c73 perf annotate: Fix BUILD_NONDISTRO=3D1 missing args->ms =
conversions to pointer
> 9966b382d06733f7 tools headers: Don't check arm64's unistd.h
> 129bb23a6f7d0226 Revert "perf tools: Fix arm64 build by generating unistd=
_64.h"
> =E2=AC=A2 [acme@toolbx perf-tools-next]$

Thanks, sent now:
https://lore.kernel.org/lkml/20260126220550.2573257-1-irogers@google.com/

Ian

> - Arnaldo
