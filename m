Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B24B25486E
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2025 21:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745962516; cv=none; b=hixw2IQk6YUX5nUetIQJBYLoVn4KkbdVgKoxYrWvnlN0XhKo72Audxjs2LLCHxaf+1Whl/knlYQKc0b+uvzZ4dIBtv/b1V3Rx8Fs/Sj/Zeyk+ODBmcDL/QARXLK41C5zwj8r6bIE7BvBYHiEhCehvqDz56jSiJQOWr90/vufxpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745962516; c=relaxed/simple;
	bh=Th8FT/kGvlr9TA9yY+YuPhwVkQ7i6L0YkGhRHWZuh6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQSawvbr1JO84szhXsDLsTJzPUc73x+1mfrW3pdbutGB7rIUZdq4rzycDfhNaFO3N01CamN2RPYYsV1cuFfi9gK0vs5wkOXaSUEjpcOnCMHBhmo50x3aDmTDAmbBbVcFZvEOQRNHcED8EIhP2oHnqj5xrdNFQQ+V5d9ivbWEbNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sOj3kzS9; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sOj3kzS9"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8f43c1fa0so89924796d6.3
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2025 14:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745962513; x=1746567313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1nuu73zjClx2psq7xdas0e4BatM4ucgjTEBi/N9T8k=;
        b=sOj3kzS9RL73f1zsPCO7syubfneUDCEc5y5Obo6vA00Ty8Qf4F8obSfgRqJkSP+WPf
         fd+hEiyKZrc10gYMwhY1MhlrndLuct4nPamWkMC7utMt1DpbzytM1FJj9+1webwAm0D/
         IsUbf7X5QLS3cKjjlqUXuZuU3nDvl2piRehgSDAkm1u6unLWDzvl3xACJIKC8Whcqhwv
         dXlBlLgWQeQqc+YbRerKxnVA8G75tp/k2i1y5wPD9Cylo7benWJKINZDZWybqNmmrOYj
         MKMtBoM6WhY5dyMLlJKCaolSuPkhk1WCksSWyGxcZ52ntj14xK9yRNBkm8uQyHy7MakE
         vr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745962513; x=1746567313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1nuu73zjClx2psq7xdas0e4BatM4ucgjTEBi/N9T8k=;
        b=scyveVjRRfEmHbU46cLRvAjtmbgO9+1CZFFgaFPrYKt1QIvJCnc/J4huVmb8C5tVGC
         asWwNafRJ7czGme8GqmNqYTcFtaDBL9SKVrgsI61FBVoYpm6FSVYVyXd80Idc9IZgjn2
         sCK2/d/O/U4jnnSATINlhxE6UeU88hEvuLmqyn0EG3icb40eKWMh406d6I0HhAC2i+kF
         Pja54QOP0e9bYZ30xKpzAxDOFM49nnETl6cYrrRu+4lIdLtOILjKOAmoR4sM9mD7rsH2
         XaiylPEj5SQ+CyWT4szUTAPpu/jMN8U8WcjkLh9Wl4WGplG6BWx+M5jvuwcvV6GGiOmL
         Fv5A==
X-Forwarded-Encrypted: i=1; AJvYcCX9L09ikplz2O1jEfIHABgoEzSfZLjVbC91lZwCRKga11uNmfy6Pi1ajlWjSSX9iPfcfCPKCEiHcT+7fDYk4+pJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyplQy2vdn3SZdxwh5xHWO4BGRKU+c/90s+rkq9ALC80GKNgvnl
	UynA0VAhjwaG4wbXHLxu2Nis4b9zxph3MG3Vm47tqwTe1KWafUMoxs2EtlpDIxA33KbABBq98ag
	m+U5Ltn/sk2Mf56l/IVL0H0/AhL24S/dX70IQ4efund3UCtFpLjxZ0Q==
X-Gm-Gg: ASbGncsq0b9T9qarwUlZrRKytu9Fzj1SMHE6dBi5/pINCPwkTcu1B2TGDh2rDPUFdmu
	HDNucwKs1BJaTQNI1gb0JP2EfmwhNkj8utmAnz4id1nYm3r9i/nNfWsuPi6BOkay3Sdjax7eXDJ
	bBtSM8RL6ey+3AKuKGApJVrFPQhk0pp8SuyGY62sZ4Gz1/k1Yaf34=
X-Google-Smtp-Source: AGHT+IHdGBlsyLmHS0F3JdjDWgppCwC6kObHYfd9Irsj3QIg9RtclmbdpOnv6QueauuKbKvJEGgnE7theqdRIDiBF68=
X-Received: by 2002:a05:6214:2525:b0:6f2:d25e:8cfc with SMTP id
 6a1803df08f44-6f4fe03cfccmr6404496d6.9.1745962512631; Tue, 29 Apr 2025
 14:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421215818.3800081-1-yabinc@google.com> <20250421215818.3800081-2-yabinc@google.com>
 <48640298-effa-42d4-9137-a18a51637f03@linaro.org> <aAeQcgmL-iqGbG_g@gmail.com>
 <20250422141026.GH28953@e132581.arm.com> <CALJ9ZPNLgEBxOmDim-vztUknEETwdL-Z2gJ8K9s44TiPgKZgHg@mail.gmail.com>
 <f03715ac-a4ac-415d-8daa-1914384319fb@linaro.org> <CALJ9ZPMiJ4oZerKWb4TL8swh8K3tfj70LTL+WibTRN-vB8rqvw@mail.gmail.com>
In-Reply-To: <CALJ9ZPMiJ4oZerKWb4TL8swh8K3tfj70LTL+WibTRN-vB8rqvw@mail.gmail.com>
From: Yabin Cui <yabinc@google.com>
Date: Tue, 29 Apr 2025 14:35:00 -0700
X-Gm-Features: ATxdqUH8QFOp7_4_6WS0YFJZ66Ou2QkaCWdN15e__QKEKbCxBuIPL53duQQlwB8
Message-ID: <CALJ9ZPNPDtSy2rSeZ04bzXp+OFDTDJ5_he5e9raBbd022Hr5ig@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf: Allow non-contiguous AUX buffer pages via PMU capability
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>, Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@kernel.org>, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Mike Leach <mike.leach@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 10:02=E2=80=AFAM Yabin Cui <yabinc@google.com> wrot=
e:
>
> On Mon, Apr 28, 2025 at 1:56=E2=80=AFAM James Clark <james.clark@linaro.o=
rg> wrote:
> >
> >
> >
> > On 23/04/2025 8:52 pm, Yabin Cui wrote:
> > > On Tue, Apr 22, 2025 at 7:10=E2=80=AFAM Leo Yan <leo.yan@arm.com> wro=
te:
> > >>
> > >> On Tue, Apr 22, 2025 at 02:49:54PM +0200, Ingo Molnar wrote:
> > >>
> > >> [...]
> > >>
> > >>>> Hi Yabin,
> > >>>>
> > >>>> I was wondering if this is just the opposite of
> > >>>> PERF_PMU_CAP_AUX_NO_SG, and that order 0 should be used by default
> > >>>> for all devices to solve the issue you describe. Because we alread=
y
> > >>>> have PERF_PMU_CAP_AUX_NO_SG for devices that need contiguous pages=
.
> > >>>> Then I found commit 5768402fd9c6 ("perf/ring_buffer: Use high orde=
r
> > >>>> allocations for AUX buffers optimistically") that explains that th=
e
> > >>>> current allocation strategy is an optimization.
> > >>>>
> > >>>> Your change seems to decide that for certain devices we want to
> > >>>> optimize for fragmentation rather than performance. If these are
> > >>>> rarely used features specifically when looking at performance shou=
ld
> > >>>> we not continue to optimize for performance? Or at least make it u=
ser
> > >>>> configurable?
> > >>>
> > >>> So there seems to be 3 categories:
> > >>>
> > >>>   - 1) Must have physically contiguous AUX buffers, it's a hardware=
 ABI.
> > >>>        (PERF_PMU_CAP_AUX_NO_SG for Intel BTS and PT.)
> > >>>
> > >>>   - 2) Would be nice to have continguous AUX buffers, for a bit mor=
e
> > >>>        performance.
> > >>>
> > >>>   - 3) Doesn't really care.
> > >>>
> > >>> So we do have #1, and it appears Yabin's usecase is #3?
> > >
> > > Yes, in my usecase, I care much more about MM-friendly than a little =
potential
> > > performance when using PMU. It's not a rarely used feature. On Androi=
d, we
> > > collect ETM data periodically on internal user devices for AutoFDO op=
timization
> > > (for both userspace libraries and the kernel). Allocating a large
> > > chunk of contiguous
> > > AUX pages (4M for each CPU) periodically is almost unbearable. The ke=
rnel may
> > > need to kill many processes to fulfill the request. It affects user
> > > experience even
> > > after using PMU.
> > >
> > > I am totally fine to reuse PERF_PMU_CAP_AUX_NO_SG. If PMUs don't want=
 to
> > > sacrifice performance for MM-friendly, why support scatter gather mod=
e? If there
> > > are strong performance reasons to allocate contiguous AUX pages in
> > > scatter gather
> > > mode, I hope max_order is configurable in userspace.
> > >
> > > Currently, max_order is affected by aux_watermark. But aux_watermark
> > > also affects
> > > how frequently the PMU overflows AUX buffer and notifies userspace.
> > > It's not ideal
> > > to set aux_watermark to 1 page size. So if we want to make max_order =
user
> > > configurable, maybe we can add a one bit field in perf_event_attr?
> > >
> > >>
> > >> In Yabin's case, the AUX buffer work as a bounce buffer.  The hardwa=
re
> > >> trace data is copied by a driver from low level's contiguous buffer =
to
> > >> the AUX buffer.
> > >>
> > >> In this case we cannot benefit much from continguous AUX buffers.
> > >>
> > >> Thanks,
> > >> Leo
> >
> > Hi Yabin,
> >
> > So after doing some testing it looks like there is 0 difference in
> > overhead for max_order=3D0 vs ensuring the buffer is one contiguous
> > allocation for Arm SPE, and TRBE would be exactly the same. This makes
> > sense because we're vmapping pages individually anyway regardless of th=
e
> > base allocation.
> >
> > Seems like the performance optimization of the optimistically large
> > mappings is only for devices that require extra buffer management stuff
> > other than normal virtual memory. Can we add a new capability
> > PERF_PMU_CAP_AUX_PREFER_LARGE and apply it to Intel PT and BTS? Then th=
e
> > old (before the optimistic large allocs change) max_order=3D0 behavior
> > becomes the default again, and PREFER_LARGE is just for those two
> > devices. Other and new devices would get the more memory friendly
> > allocations by default, as it's unlikely they'll benefit from anything
> > different.
> >
> Good suggestion! I will upload a v2 patch for that.

Hi everyone,
I have sent the v2 patch for review, with the title
"[PATCH v2] perf: Allocate non-contiguous AUX pages by default".
Please help review it. Thanks!

> >
> > Thanks
> > James
> >
