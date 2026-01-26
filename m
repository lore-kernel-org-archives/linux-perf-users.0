Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C740834D4E4
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448065; cv=pass; b=qV6TmH2J83WX4x6IZtJ3i68fIsnet83MTQau8IAXjj+4dM7eeS8xOpPeEWPHryNEFpPOKT0Id9mCSjChCtK3DO3EtsEz6H2548kNNnL6qM9x7dGiQ9fTs80h2HzK1FJlc/O0Cq6pI6rm/ui2S+5e6/H3EyqtLtUPX/RGaT9dmKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448065; c=relaxed/simple;
	bh=YTrAJV93417SJ1k64zXhl0ztZbQ5SmW8B1gkjSgEdrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=br7FPysmQjvGsVYUNQun2ImuoIhCHV14JRnPayIV2XL8XCY1VacHafYf6crrERsMEIl49A/8ra2VmD9Y+olQ4QH5cotgb2zvmapo3pV0Nv3NO/2DTBPg05d2uy9rzuoV3kRJRbHekDMSiD9Pr3HJ6EZ/u/tv+yFez1XiVVQxxPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VZ/V/1to; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VZ/V/1to"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a35ae38bdfso162535ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 09:20:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769448045; cv=none;
        d=google.com; s=arc-20240605;
        b=IRcsjP7IoDSYcis5CDXX1fpR3gy9S+/iOR/8T3w6CMXdJLv4xkwyd3WAs2zfJyZqRa
         wDrs51W6OPtSUpqLvtYbwc7XEwGXr2hK8WjqsdHZ5suLaSEU7IVZitwMLnQCGS44q5j/
         oGj8nG2tKdUjFfdTtDsiCycRq/bLZoQk4jQrAczD3oWeOmOzhO5gyCXPc0Wy5pZklea5
         Iv9nl9Vi99NH9AWiYS5N32jkiTtE39oaX5nbSD9KTZNdjJEb+9/avHjdPmbHep0jvEQ5
         EhzHhn28ej6qmp5OLJqexIV5UtZGY/AXz44RAGzG9gOpgMUGcduHdn8AfAl54vdv3aog
         NV9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YTrAJV93417SJ1k64zXhl0ztZbQ5SmW8B1gkjSgEdrQ=;
        fh=LQYcEEq1si1RktcIILge+u1Y+PvPRPIcjFISM/iBy/Q=;
        b=ECduqQNO9ott6HRCxqYkGxgxxTvW81HbgI+PhCcif8BGfmdUYpo9ppDsp/ii6ZFRQU
         e/xR5sC+gN7TFJ9fjGTBlM16VXEp092TSXCk1eV4v8awFF1MHZoTlLlnEgZzRpAdxszv
         lra5Q3Lkf11NJDBPoo97fyKKGlh+7JZCSgMC7RAlqZQqBIfmgLRZ6eFC9jZOBXgHiYAw
         vflihP3HK+htozx6yaYqkWqtHPT5gRT+bNmxJ7MnWTsoBd84SUxZh9cTJY/Z0hbq+ZB+
         oSMT6ouFT6Lo98JGS/j7zlNO/GujLDzQaewIKuVclJdEmQSH7dp6einQCqHAgg7ur/r+
         iiaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769448045; x=1770052845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTrAJV93417SJ1k64zXhl0ztZbQ5SmW8B1gkjSgEdrQ=;
        b=VZ/V/1tooBZbxRS4UZskFFGEyaKuhARFOtvxpMrEEBb+nZ29UoOdO/6z9BDQhXXkV5
         ylvpc6TOlBaE8XmVpLDJCsjqjFamoCn44mHBgf6+QOMW9rt9w0KvXCgSsZmJzYsHqgVU
         jRz/c5BwPfCCHno6u1NfKEFSSOeeM3HMxnEbBvEPrVDXyE6F2BfvFAlvh1L6JTHEjhEw
         utiPkM1exdAirkgy5DP96W16o4aCtyEotFtchOffCSGyyez06PJmS6DHAkxXecc45gSj
         GXvsGPAPqXB87xNxEJyL3vygkyLNzWD843Yw16zeSQX02h0smMyTyvViribof8OanRQf
         ZR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769448045; x=1770052845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YTrAJV93417SJ1k64zXhl0ztZbQ5SmW8B1gkjSgEdrQ=;
        b=cuQdx4DmqWkJGzwHHLst6/vyx2F0sBgUL+rDJNad2vHjLy9flfTlmWxeV116iXNsgA
         L7P5S2h0jzdIrqeq9nPdrhLug71IOIcrtp44Lo0Cezwg0BWMtbNeZPb1sjvmyaryyDmD
         XPtMNtH9ytUAA7VwLgjS2365rE7xrQG50L94kIs2deKPCyBYDhMbFIfHDLgq1m9LIsdN
         QuCB9GaoPH/WUvqMMZBqE5UHuNe3ThAlmfo57h5oP5pWjmWW0tVzPgM0GqFzEi1iwTxI
         3Whv4NMwQNklrlkLhl5Z4ddRuLsSXKFMwSMVrLXzy5hvyY9xWq7gYwe4q71gVpWuZC9t
         /Jhg==
X-Forwarded-Encrypted: i=1; AJvYcCUZQ5yOIMDQab3ngh47zU1UIdNIWYqIZZMo8uMjtnsTkPUbh8RjyaDYPelMHlVG0v3qTfz5cHMB+LFh/KVUwUdo@vger.kernel.org
X-Gm-Message-State: AOJu0YxX2vnlCBmM/2wT+xhsmyaXuJBqX/0swW3rIIqvLYne4Ol3vd1j
	/smXkM90Au6Acj2vGMGQYMNTSXsRor+Y1hhOXEa0vNnUZcPIoMHwhlJ5Y92UrOSv/7XYmG070XW
	E6Wwi+XtiwxHhoOHtSDMiY0f8oJ7lJEUze6xE5SSW
X-Gm-Gg: AZuq6aLZQDGugvo51OVKB9qFfQfWJ1RreRLwEG4WiKbMzsQ8lRMAGPVLHr5paNXNXqu
	1QoSDTNNxEfGuDxVqPqQPZV3lQTleJ3D57otTBqwdXv/g+CjAlLqBix3dhv2GqBLfHRdo2dtkGA
	wVExRVzla7Mv2m+AOSJpHXeBwMbyCnfzxyVVDlq+rXWEVIP8q+gp2rDbtf5Yzhs5W/BtoRXJ3qH
	2gYldhBduB2HzB4wDlCn6/ojP/1ubu/5CjKh/dqaz07PYBDkP9k/LF6zIzQVmSwOWhFDkiRT0av
	C+JiaPX5sWpZbIch7tjXZyn+5/yMnVknWpWu
X-Received: by 2002:a17:902:ef09:b0:2a0:89b0:71d7 with SMTP id
 d9443c01a7336-2a844e77f45mr2224565ad.13.1769448044951; Mon, 26 Jan 2026
 09:20:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126071822.447368-1-irogers@google.com> <363a4dd6-25c1-4bb4-8b53-64e00baa1a9a@linux.intel.com>
In-Reply-To: <363a4dd6-25c1-4bb4-8b53-64e00baa1a9a@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 26 Jan 2026 09:20:33 -0800
X-Gm-Features: AZwV_QiYFZrSRICCEHDlo9iaERVIgmWlIz5vZDkYKD-ocOUvTWQSdsXVMYftoaQ
Message-ID: <CAP-5=fV30XHi78SBHc=mJUK-7t9uiJb_YPHWZSG2g0Rm745pbw@mail.gmail.com>
Subject: Re: [RFC PATCH v1] perf sample: Add evsel to sample and avoid passing
 as a pair
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Andrew Jones <ajones@ventanamicro.com>, 
	Quan Zhou <zhouquan@iscas.ac.cn>, Anup Patel <anup@brainfault.org>, 
	Tianyou Li <tianyou.li@intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Derek Foreman <derek.foreman@collabora.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, tanze <tanze@kylinos.cn>, 
	Hrishikesh Suresh <hrishikesh123s@gmail.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	Chun-Tse Shao <ctshao@google.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Blake Jones <blakejones@google.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 1:04=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 1/26/2026 3:18 PM, Ian Rogers wrote:
> > The perf_sample and evsel are typically passed as a pair. This creates
> > 2 arguments for the price of 1. It is also inconvenient if you wish to
> > rewrite a sample, as the evsel will need updating in all cases,
> > something similar to this currently happens for off-cpu output. Avoid
> > passing the evsel by adding it into the sample. So that two evsels
> > aren't being passed around, fix up functions taking a sample and an
> > evsel argument to only take a sample, the evsel now being able to be
> > read from the sample.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > This is a fairly large and invasive change but doing something some
> > what mundane. Sending out as an RFC for early feedback.
>
> Nice cleanup. Better split this huge patch into several patches in the
> formal patch-set. Thanks.

Having several patches means having intermediate states where there
are 2 evsels (a parameter and one in the sample). Getting things
building with lots of intermediate states is one thing, having things
work and not break tests is another. I'll see what can be done, but it
was somewhat deliberate not to have intermediate broken states with
the albeit large patch.

Thanks,
Ian
