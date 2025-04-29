Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014D22512D8
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2025 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946144; cv=none; b=Er3bXDp6kyIjG2LncQw8KynpuK2373klu3iC1XRWShPs00a7yx2qrj5U7GHRooRvbSyJrkqmYG6hmIE1AtRrxGntp2ySm61fhV3ieULqOQy053bwE5QdSqHQ451xtgC11Y862uyGTrNJArb2q3u3jwf5CvXYzOB/Rm+9ul5E1SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946144; c=relaxed/simple;
	bh=Qz4OGEmbuVrrrJNZqV3Ij3zwJSPUvCrZnG//EyAPLT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwPoCMBRLcs9pAw1cgRIifP5QzT8dpvQiF+67yPoVKbGVWQ/8USORM5OqRIILGd3DwtLW5xmmO7zbwKA+b+Wvw+bAaLy6LAkN70pExFbCslH7QkbmjieqKYONs5Tf+quTihGwtPwKGmtxjSd0E+YpiZST/BtFbLH9niMxtzUDgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2vO0mrBT; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2vO0mrBT"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6f2b04a6169so68894086d6.1
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Apr 2025 10:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745946142; x=1746550942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qHWKZeK4ritAUfK+7VjAlw31q6vqsBixsKT44Ec01E=;
        b=2vO0mrBTrglDrl6fWf8IgldkMC3zNXQrn4xio7vB1jFGMF508H8JzdVoepZVNHL1Lb
         U9A6gihekaeEHCWRXkqwTCW0r7RIuLKAqHReBDVPw23Kvg8Y0elqxQeu6DtachIxMjDa
         /pPJr29I6RBzi2wQlSwS+3Qx8xp193PP93xymlwjvab8kFHEqyigRGE7q/hW6iQa4+hg
         ueFG8xWV/R74Y+JVgTabwtoROEbijeqSNEUKnfm06ng4dD6sdjOCpuZhYyYZQeieiKlO
         SPsIOgq6c1UgFHuCKb+Ijp9++nr3brO5lGhzTP9RiXMNG7FBXDs262uRewsxNUOSSi33
         V08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745946142; x=1746550942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qHWKZeK4ritAUfK+7VjAlw31q6vqsBixsKT44Ec01E=;
        b=tcRMEnCy8zo6aoeDbCTAx4xEGPg+Wt+oWQMvF4vgSlgwcCGzF2aPlxHLvBQFzC32Ji
         wC7omnpz8SvSSRVFriLrzox2tSJ7XDT/jNOhWkdzQ+tgaWEuMJqpdHW559+DSt0ifLHG
         p8gsraP/M674P0CrfMX823W/Od890NZgi1O7j0tkQEMCUE91Ek0X6gXRpBOiAsM74TeW
         iCZ1y57JF4tYYnmNcorPNhPip1m7HvkiKvM7LaHViiGmLFsuEB7VSLY/n9wXqBbjadNn
         0R2YXHE5KBYQ98HZc49dr+btUtTOaOgzfwStCmkhr7DXTQqlx/kzCtuGSpM/jNCxhVN2
         YeiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeJ4FK4DegnXIIukQ+eG1WRA1K3CYMYSmxTfTXknb8xyzaZOPnij/v3BI7yHF1j6ZbCbnzTe11P9WB2oe9e5Ju@vger.kernel.org
X-Gm-Message-State: AOJu0YxbGyRwwDgFubtoVQXmwbpc3WNB2CoBT2GxczUONycnyG6gfDWW
	c3c2Nl9DwDACTt/soi+oBaIEObjP/9j22kDG6o+NxKhg/exP97jfDp4IMFFnqWrVjhFvoYPDh5s
	purY8Rmdx5FrGIM96PgyWPTMzYK1Otc3C6qs=
X-Gm-Gg: ASbGnctivC4aJM+Gv+AF07XXdSrJe8NhstIV1RFNvYWpUNSP7/XhYwIArTLVUwDu4y6
	3LBvbraHwQIi/fHdF9yZUPVvAZN0CFPTlZXHz2wEVg1DUxVGpIurlxMh1sQTkIyRkQRZrOkcQGi
	DhzMB1sf07ieakeGk3dLk1Zj5oWRZOK4A7dHjEiiwgFv5GLfaX1JI=
X-Google-Smtp-Source: AGHT+IGJ2FFd6Eiwu9oIiINLmRXDdz0Z5mu/0T6rc0ayxYrgV8A3GYGLzgZnX06XlBBhgN6OaBE8Qx+Gn+Z+i3mrGnw=
X-Received: by 2002:a05:6214:2247:b0:6d4:238e:35b0 with SMTP id
 6a1803df08f44-6f4fce9dc4dmr2026256d6.17.1745946141318; Tue, 29 Apr 2025
 10:02:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421215818.3800081-1-yabinc@google.com> <20250421215818.3800081-2-yabinc@google.com>
 <48640298-effa-42d4-9137-a18a51637f03@linaro.org> <aAeQcgmL-iqGbG_g@gmail.com>
 <20250422141026.GH28953@e132581.arm.com> <CALJ9ZPNLgEBxOmDim-vztUknEETwdL-Z2gJ8K9s44TiPgKZgHg@mail.gmail.com>
 <f03715ac-a4ac-415d-8daa-1914384319fb@linaro.org>
In-Reply-To: <f03715ac-a4ac-415d-8daa-1914384319fb@linaro.org>
From: Yabin Cui <yabinc@google.com>
Date: Tue, 29 Apr 2025 10:02:09 -0700
X-Gm-Features: ATxdqUESro1ma6kgnDZ_JUnNPtdCVCZAaJx-9arTO5zJv1h0N-wUAHCe0Ud_CwE
Message-ID: <CALJ9ZPMiJ4oZerKWb4TL8swh8K3tfj70LTL+WibTRN-vB8rqvw@mail.gmail.com>
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

On Mon, Apr 28, 2025 at 1:56=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 23/04/2025 8:52 pm, Yabin Cui wrote:
> > On Tue, Apr 22, 2025 at 7:10=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote=
:
> >>
> >> On Tue, Apr 22, 2025 at 02:49:54PM +0200, Ingo Molnar wrote:
> >>
> >> [...]
> >>
> >>>> Hi Yabin,
> >>>>
> >>>> I was wondering if this is just the opposite of
> >>>> PERF_PMU_CAP_AUX_NO_SG, and that order 0 should be used by default
> >>>> for all devices to solve the issue you describe. Because we already
> >>>> have PERF_PMU_CAP_AUX_NO_SG for devices that need contiguous pages.
> >>>> Then I found commit 5768402fd9c6 ("perf/ring_buffer: Use high order
> >>>> allocations for AUX buffers optimistically") that explains that the
> >>>> current allocation strategy is an optimization.
> >>>>
> >>>> Your change seems to decide that for certain devices we want to
> >>>> optimize for fragmentation rather than performance. If these are
> >>>> rarely used features specifically when looking at performance should
> >>>> we not continue to optimize for performance? Or at least make it use=
r
> >>>> configurable?
> >>>
> >>> So there seems to be 3 categories:
> >>>
> >>>   - 1) Must have physically contiguous AUX buffers, it's a hardware A=
BI.
> >>>        (PERF_PMU_CAP_AUX_NO_SG for Intel BTS and PT.)
> >>>
> >>>   - 2) Would be nice to have continguous AUX buffers, for a bit more
> >>>        performance.
> >>>
> >>>   - 3) Doesn't really care.
> >>>
> >>> So we do have #1, and it appears Yabin's usecase is #3?
> >
> > Yes, in my usecase, I care much more about MM-friendly than a little po=
tential
> > performance when using PMU. It's not a rarely used feature. On Android,=
 we
> > collect ETM data periodically on internal user devices for AutoFDO opti=
mization
> > (for both userspace libraries and the kernel). Allocating a large
> > chunk of contiguous
> > AUX pages (4M for each CPU) periodically is almost unbearable. The kern=
el may
> > need to kill many processes to fulfill the request. It affects user
> > experience even
> > after using PMU.
> >
> > I am totally fine to reuse PERF_PMU_CAP_AUX_NO_SG. If PMUs don't want t=
o
> > sacrifice performance for MM-friendly, why support scatter gather mode?=
 If there
> > are strong performance reasons to allocate contiguous AUX pages in
> > scatter gather
> > mode, I hope max_order is configurable in userspace.
> >
> > Currently, max_order is affected by aux_watermark. But aux_watermark
> > also affects
> > how frequently the PMU overflows AUX buffer and notifies userspace.
> > It's not ideal
> > to set aux_watermark to 1 page size. So if we want to make max_order us=
er
> > configurable, maybe we can add a one bit field in perf_event_attr?
> >
> >>
> >> In Yabin's case, the AUX buffer work as a bounce buffer.  The hardware
> >> trace data is copied by a driver from low level's contiguous buffer to
> >> the AUX buffer.
> >>
> >> In this case we cannot benefit much from continguous AUX buffers.
> >>
> >> Thanks,
> >> Leo
>
> Hi Yabin,
>
> So after doing some testing it looks like there is 0 difference in
> overhead for max_order=3D0 vs ensuring the buffer is one contiguous
> allocation for Arm SPE, and TRBE would be exactly the same. This makes
> sense because we're vmapping pages individually anyway regardless of the
> base allocation.
>
> Seems like the performance optimization of the optimistically large
> mappings is only for devices that require extra buffer management stuff
> other than normal virtual memory. Can we add a new capability
> PERF_PMU_CAP_AUX_PREFER_LARGE and apply it to Intel PT and BTS? Then the
> old (before the optimistic large allocs change) max_order=3D0 behavior
> becomes the default again, and PREFER_LARGE is just for those two
> devices. Other and new devices would get the more memory friendly
> allocations by default, as it's unlikely they'll benefit from anything
> different.
>
Good suggestion! I will upload a v2 patch for that.
>
> Thanks
> James
>
