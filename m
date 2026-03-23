Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D64D3C1418
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Mar 2026 17:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285612; cv=pass; b=mLeQF3Tz3FjSr/F37s/QWDrfhDjhfJsCgK4Uf3RI9jOIdc/kcOKFObDtduwpVHx6cYG6Y6kvE6/ic4n2yGsHC2JE5oduOe/uNFmzgVaspqn+liXEvueS9J3k79WpUhNT8xws47Bqa7e1i48oQrnoA1oOYNvhFWyIR3k0+LLJHRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285612; c=relaxed/simple;
	bh=NuBSBhH3Va28hN31MqNdzxpUmJ/nB4ArOAX9PoCUmuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQCns8mdOwlnTboXOkJ4HP6DoIjhB/Nh0Ca95Bgyjtewk2p4ciUPXn04lYuH6fypie+QirdL/1kpXLNAWaI77BFdAt6pbGjBzh5TGLda9AbqjZnWM5DyLaKsAlxBXSb3VqfUK9Lbbr7+p2dM9/ixfQXx2zDt0fibF6AfcGKuixA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cvTQz5mX; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cvTQz5mX"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b052562254so8185ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Mar 2026 10:06:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774285610; cv=none;
        d=google.com; s=arc-20240605;
        b=CG3/f7M/Bq1T0bavhdQpW+SOsmJncCqstIqlB04fO7E6zmOm8diTk73Vv3v2SPPHmu
         WuMeuhNfjnNGQMwbLacauon1uVtq1m6mSXYZRN9dG7NUPa/GRNF/diuVoRdcvH2MJVUl
         UtCj2Fbc9rI6vW1sTNSmeMLz6Gz9bwVCAOdsTTahCBcp06JlKv+IULlFuYN+cg3S+VM9
         vymkdg+OCamVVfR3cOHd5JVVOIna/d0Sxwly7KzADA/TBi62PQWqAb/gIEVcOegnagno
         ehAQVUauZSGax4oKn5YNXWJZfepkohDWj7gOIZ5EvFVEmg8UcEyUs7jLNB2gcefPkjvC
         LSbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d1XUbNJ+R9tnk1cQesCqmRj4BmbisT43vLprNoIROy0=;
        fh=DU20RzlhJUtm/qAb49RLMJBeka0TEA3x15mQTOsU6WU=;
        b=f+1qyPlcT7sij4zPE+8zVf8ONfvaFKpxKonjIhrlK5+pGm5KotM3Kv/3RjKSbPqHDH
         np0yjB1ncwCr5vkfty5CGAx2E35/IOgagpjWH8FM+7rYCF5/4tfkaQtmxwhpeXj79xOt
         sSl0tTC3IGJe5J90iJKr/k8f+gGaPkdLg63wkR2X7pp1TEsKMeEa7auscTcKXLyw2Ucs
         ZqDWMKEIWHJ/zxieZz01Wvw0j+DuLuy1iwHvulPOxVq/aNRD42LOy474Pvgjx3+iCvVY
         gPcS0RmJG7OWT7RHJSv31+NL6L+bON+kalsRWiRFZIhj5ZS7o2t9O+76oGA7mhQcHcHZ
         JM6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774285610; x=1774890410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1XUbNJ+R9tnk1cQesCqmRj4BmbisT43vLprNoIROy0=;
        b=cvTQz5mX1wZU/Zkn+Snux6Xio2Jy+uSwaH3DteIKTh/AvXXM2NgTsyZphaPzfzFk9f
         PU3NyOx4cIrD+zyXCyWKQ04JLeml5vJYxPwfv56+1w/cMtg2jcG/3YWEgbnUVBtIHk+9
         TztjUCPrWKxmHK1/ZlEBDlBnCoMH3NM8Xr/SCa+wRFJRmLXqOXO6FQZuSCGZK990vpAG
         1R2WXNjKIKA9oK+W3xAiPUd2qhuOVjkYxu8PUdrRHdgUx8pTU8BoP5iNAJDigFn41mQS
         UMyBlr+khCtzKrzcFjVWd+ugLG01hBY+Uq9ta/x31bxW4r3uPnbhF4qzkaS/hy9pFUIC
         AwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774285610; x=1774890410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d1XUbNJ+R9tnk1cQesCqmRj4BmbisT43vLprNoIROy0=;
        b=Vlf1FBR/qri8KcAcBBZ98KLF2U1nScP6JoC5JxlxRkM8TIEXOJTITpVVI67eBJqclg
         UF7DOxV/ZTeUyG+BpKItIzviwkUCQ6fWgiWGaxvgK/a0aOCuxOLfiGtDenTm8vXTNXda
         Wc5M4/dx1nGtHJf2JVrGyKPy4Uqj6Gcaf8Ici9Fz50+MHxtueAogPybmPsjKT828xVNu
         Qyee7Su0ndzIwbomgd/0KGVQYO766QHLZTwMt2DrmXYjPSqWCIcZZ90RTmYk+18Uo4IM
         2oJ5mtLbbTpqeo7uXhugr+gd5ZzJ5a3aQ3UJ93Q5wEt/HB9oGnqu+Q8xDzvMgAjzCdwP
         aCuw==
X-Forwarded-Encrypted: i=1; AJvYcCW5n2afWt0j1W5enJ9qZ7udad8trViZ7Y/Q8A3teUSsYzNpybSK8QnPoLfpBmoBwNheNvpPWfDjOGYxQ/4kjuHI@vger.kernel.org
X-Gm-Message-State: AOJu0YyIb3g9KZwvk6mZXiAMgrTv2rsvTh7dhs8D3mt7xIkNzzaa717u
	Tm5PNP+KVZSRqP/NPw0zKhejhUTLwUlvLSX4XvmCv6wSb2VssW2wyfLfRTBiza1a4/OA6VnLc/P
	OMX7E2bp+TSHq2xGa73dRiEZ2tpvBQ68zT+5UnOI6
X-Gm-Gg: ATEYQzyIdQdZHEKe20rC2Aq7wTi6Sb3+hVDNifK7SFa2lpqqLucIjLthIECCvMdzoDC
	AOUcA9a77oAHGCvW9+/T1lJIyljohOh2WAidcbKPxXhEpSYfanAVyNpys81wJayjQcyKpv0Nu0T
	C6kCGS8ja9CgbQV3n9H2fq8cOkYApyjSViHpxUCSfeeqQ13nBJwuVTfrZON2g86VaObi2FEuyoX
	bpv91qIC5dSgYGAhGSx0RtHzIs4LjOVUsvccixXK/VAWwnf79CBpRRnjUDOGAlgnUyeQ0XcvCsj
	uk1D4vYkjSPtyiJeUDLucC/I4r92Dw2dQQMLq/CA8fw0E4CZ
X-Received: by 2002:a17:902:fc4b:b0:2ae:4e8e:954e with SMTP id
 d9443c01a7336-2b08c423bcdmr5056585ad.5.1774285609899; Mon, 23 Mar 2026
 10:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-perf_stat-v1-1-e433b0c918af@debian.org>
 <CAP-5=fW2iUbaZRX789SaJNGXk1VhGg0igLukb6SAosKiA-f1tA@mail.gmail.com>
 <20260205173918.GB3529712@e132581.arm.com> <20260205175250.GC3529712@e132581.arm.com>
 <CAP-5=fUY8dYzwKu-g3-HER4ji9ZeGmPQo9DeORW0w9ocW1qnMw@mail.gmail.com>
 <abFBoVrlGl9cIg1h@gmail.com> <20260311115011.GJ4153946@e132581.arm.com>
In-Reply-To: <20260311115011.GJ4153946@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 23 Mar 2026 10:06:37 -0700
X-Gm-Features: AaiRm50ZpI2g4n_morMSHxHQspm5QmzmXTH60IcU1S55Kk-3ziFr0_Y99WQ0UW0
Message-ID: <CAP-5=fWRgDo7UnJAD4C--d=mVPRhOEWZVyU7nVM1YEp3jncAgg@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Fix crash on arm64
To: Leo Yan <leo.yan@arm.com>
Cc: Breno Leitao <leitao@debian.org>, acme@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Denis Yaroshevskiy <dyaroshev@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 4:50=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Hi Breno,
>
> On Wed, Mar 11, 2026 at 03:21:00AM -0700, Breno Leitao wrote:
> > On Thu, Feb 05, 2026 at 10:22:27AM -0800, Ian Rogers wrote:
> > > I think it is a different issue, they have metrics while you don't.
> > > Your report does highlight we're missing a NO_JEVENTS=3D1 build-test,
> > > but the build is working for me. I'll send out two patches for these
> > > issues.
> >
> > Hi Ian, Leo, Acme
> >
> > I wanted to follow up on this. Are there any next steps I should take?
>
> Sorry for not tracking this issue.
>
> I can reproduce the issue on my Orion6 with setting a _dummy_ CPUID:
>
>  $ export PERF_CPUID=3D0x00000000410fd490
>  $ perf stat -C 5 -vvv
>  ...
>  Aborted
>  perf: util/evsel.c:2156: get_group_fd: Assertion `!(!leader->core.fd)' f=
ailed
>
> Because we are working on different hardwares, I am a bit suspect I
> reproduced the issue with difference sequence as yours.  Anyway, I do
> see that an event can be opened prior to its leader event, see the log
> below.
>
> Thus, your patch seems make sense to me as we need to ensure the leader
> event to be opened first.  Ian, how about you think?

Because so many things depend on the event ordering, the patch makes
me very nervous, particularly how it will change architectural
requirement handling. Ordering the Intel slots and metric events is a
challenge. There is also how handling uncore events, which are
deliberately parsed out-of-order, will change. I've got a feeling the
test coverage for this isn't adequate, and finding the bugs requires
running on particular machines. It will also require examining the
default perf stat output to ensure this isn't broken; hopefully the
code is somewhat robust.

Ideally, the impact of the change on all these issues would be in the
commit message, but it's more realistic to cover each issue with
testing. I'll try to ask an AI buddy to help with this. Could you
rebase and send a v2? I'm curious to see what sashiko will throw up.

Thanks,
Ian

> I have a side question (maybe this is for James :): why other arch (or
> platforms) don't have reproduce the issue?  I am wandering if any error
> or special stuffs in Arm CPU's json files.
>
> Thanks,
> Leo
>
>
> ---8<---
>
> Opening: BR_MIS_PRED
> ------------------------------------------------------------
> perf_event_attr:
>   type                             11 (armv8_pmuv3_1)
>   size                             144
>   config                           0x10 (br_mis_pred)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|=
ID|GROUP
>   disabled                         1
>   inherit                          1
> ------------------------------------------------------------
> evsel=3DBR_MIS_PRED (supported=3D1) leader=3DBR_MIS_PRED
> sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -2
> Warning:
> BR_MIS_PRED event is not supported by the kernel.
> The BR_MIS_PRED event is not supported.
> Opening: OP_SPEC
> ------------------------------------------------------------
> perf_event_attr:
>   type                             11 (armv8_pmuv3_1)
>   size                             144
>   config                           0x3b (op_spec)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|=
ID|GROUP
>   inherit                          1
> ------------------------------------------------------------
> evsel=3DOP_SPEC (supported=3D1) leader=3DBR_MIS_PRED
> leader->core.fd=3D0xaaab19edd950
> broken group leader for OP_SPEC
> Warning:
> skipping event OP_SPEC that kernel failed to open.
> The sys_perf_event_open() syscall failed for event (OP_SPEC): Success
> "dmesg | grep -i perf" may provide additional information.
>
> Opening: STALL_SLOT
> ------------------------------------------------------------
> perf_event_attr:
>   type                             11 (armv8_pmuv3_1)
>   size                             144
>   config                           0x3f (stall_slot)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|=
ID|GROUP
>   inherit                          1
> ------------------------------------------------------------
> evsel=3DSTALL_SLOT (supported=3D1) leader=3DBR_MIS_PRED
> leader->core.fd=3D0xaaab19edd950
> broken group leader for STALL_SLOT
> Warning:
> skipping event STALL_SLOT that kernel failed to open.
> The sys_perf_event_open() syscall failed for event (STALL_SLOT): Success
> "dmesg | grep -i perf" may provide additional information.
>
> Opening: CPU_CYCLES
> ------------------------------------------------------------
> perf_event_attr:
>   type                             11 (armv8_pmuv3_1)
>   size                             144
>   config                           0x11 (cpu_cycles)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|=
ID|GROUP
>   inherit                          1
> ------------------------------------------------------------
> evsel=3DCPU_CYCLES (supported=3D1) leader=3DBR_MIS_PRED
> leader->core.fd=3D0xaaab19edd950
> broken group leader for CPU_CYCLES
> Warning:
> skipping event CPU_CYCLES that kernel failed to open.
> The sys_perf_event_open() syscall failed for event (CPU_CYCLES): Success
> "dmesg | grep -i perf" may provide additional information.
>
> Opening: OP_RETIRED
> ------------------------------------------------------------
> perf_event_attr:
>   type                             11 (armv8_pmuv3_1)
>   size                             144
>   config                           0x3a (op_retired)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|=
ID|GROUP
>   inherit                          1
> ------------------------------------------------------------
> evsel=3DOP_RETIRED (supported=3D1) leader=3DBR_MIS_PRED
> leader->core.fd=3D0xaaab19edd950
> broken group leader for OP_RETIRED
> Warning:
> skipping event OP_RETIRED that kernel failed to open.
> The sys_perf_event_open() syscall failed for event (OP_RETIRED): Success
> "dmesg | grep -i perf" may provide additional information.
>
> Opening: BR_MIS_PRED
> ------------------------------------------------------------
> perf_event_attr:
>   type                             11 (armv8_pmuv3_1)
>   size                             144
>   config                           0x10 (br_mis_pred)
>   sample_type                      IDENTIFIER
>   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|=
ID|GROUP
>   inherit                          1
> ------------------------------------------------------------
> evsel=3DBR_MIS_PRED (supported=3D1) leader=3DSTALL_SLOT_BACKEND
> leader->core.fd=3D(nil)
> perf: util/evsel.c:2156: get_group_fd: Assertion `!(!leader->core.fd)' fa=
iled.
