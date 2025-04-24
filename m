Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7D728F52B
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Apr 2025 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745519586; cv=none; b=Bnk5Y1OMqN70Tg3LC5NxhGUBmFoyxOQHSy/RwIqZS3CQH3iVZoUqtRbmUCIcgjpeDWtkM8LkYOiy1twkeS816ZXxbBZhQqICLCKLZ3YvWtmdoSx8EK+5GREhCyB6uiXNXThvT5A0eEJl6IDR0RAiMu3w5xXFJsRT0LQcnhXJSmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745519586; c=relaxed/simple;
	bh=yTqO1U4NNGcPPghDlKDlpq2q5FXSu6lS8+cwxigBGUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgV3fZFz/I0Av0pDsZe/ha1pA1tPUjvMCsS12wOhEa5JDyKr4CzVSm7zizTrSfX/c2vPzuwAkiRj+CGKEt6CCDkIm8eIpCsApDcGZnlDbuGU/8exko/VgzJXBWv2tgWCgjtnBQu+j+gorjFG2NWGTyB8iVzIjv6evdogK/ixjWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xIP7Qpvg; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xIP7Qpvg"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6ecfc7ed0c1so13774406d6.3
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Apr 2025 11:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745519583; x=1746124383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZLDFPYYERChhwGiLV1V4ti0sf1HZ45rpQN9Kgve63o=;
        b=xIP7Qpvgb8Dd0lshlQX4/LwxbIylyv66vVHa3WKR5R1ph3wzS4ZeAGJjPkyfFYUzwn
         pVRFHPZzOFvx+KgaDb2ZJrUkXVbeEvJUxQwL1WCCdc7pVDZExnIWz2PD+O7HPKVTbAaM
         5Nr+TANF0eueBNC2IBIR2dZqfXrybfIhAONltCJF81B4ypkGlOFD3FVWI/J94SpnjTNI
         Bl9H2ABcv0IDCg+9F2isBnbo4akYlScEEuAr+KV2wKRPlX2p4Il9sWjdgn9hhSTi4Z51
         xTB7kg2StYG6CMlM4dfAoT1uvhEvEbXnmW7C7+su5XWqPFBMT1CL1sC4zLHoMvQs9yGD
         i55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745519583; x=1746124383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZLDFPYYERChhwGiLV1V4ti0sf1HZ45rpQN9Kgve63o=;
        b=dVfH5ekfSDpbuiCnE59T0xYWbPri6tRNcoHs+IjrIo5tIQ56dxpy/WAbJnqVKAIcc2
         CK7VDmBYb7xAleXFfeZIszpC3C0STK3szQeT5f2ZHN5gsScb8tgNGjmS2vl2hIRm5xVk
         Crz38WHYS48lU6d4ZKZWejRp4sqJHlnLeACaQ3Knv5a5qQ91dG2mqRKEQ7yytvk4OEpv
         TwN4LQgcWf3olPlSlLJZUQY5bYENmKmmuEfKjwm9xU1J3j06xCprjtvmx1vbySqelCIi
         sAEKODdX+LiDSA3gJF4Dvv4T/gh+8ppZ41fXhYggETdl7S08YYpLB9WmKENjQhWTl+AA
         CfKg==
X-Forwarded-Encrypted: i=1; AJvYcCVvTOsSJOKEB65GAUfEnuuxXne3MHN1Mp3SML94FHfejDP3DztAto5gy2Kf27loYVfDJNzp7/HON+1Z7H+lJOp+@vger.kernel.org
X-Gm-Message-State: AOJu0YxKl7+50JFMajfMJf3Zcb563A3wUzpTfRjC8SE8bi6z691+u2hk
	1NRrVWs+wY0fR32X7O0kd/04zjmkwyUXo0aeCqk2LfcntfW/WBNkuKjgdBqcPFkHFn+hIH65tJa
	os/42N4Dnk7z7gzh5F233QVwljjipeugENcw=
X-Gm-Gg: ASbGnct1F/sPNxqUCC2ooY5C1cQfESN7VBEh7SlNXHdCbTqYB2WSPPkVfmoGSXypKp0
	wNsDUQUm3SIzNMx6vgNtWOY9srcPm/f7n/PUIlgUo0TJ2mFDiukH12WZg8Z+kABojQ7St6HukJv
	8bN84zGfEzPbZUQLC7nURgEvpTGrFN6MF7aI7Mqygz1+eGGyKkH7ALzGw=
X-Google-Smtp-Source: AGHT+IEQy8HLY9L1xq1buozzz2mjfrB7q7OHv76jqVScfSv3yY42ZW1q86tGFEOQmX5exFFK+eIU1yfKiVx6TSLc6Rw=
X-Received: by 2002:ad4:5ba2:0:b0:6f2:a886:7c6d with SMTP id
 6a1803df08f44-6f4bfbc963bmr60071466d6.3.1745519583247; Thu, 24 Apr 2025
 11:33:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421215818.3800081-1-yabinc@google.com> <20250421215818.3800081-3-yabinc@google.com>
 <20250422142102.GI28953@e132581.arm.com> <CALJ9ZPNKZU7nVLyodN5i7GeRxWL6KzkXnqEJMv2sJkk2SwYi9Q@mail.gmail.com>
 <b002574d-e993-4b06-87f7-54bd01dfa500@arm.com>
In-Reply-To: <b002574d-e993-4b06-87f7-54bd01dfa500@arm.com>
From: Yabin Cui <yabinc@google.com>
Date: Thu, 24 Apr 2025 11:32:51 -0700
X-Gm-Features: ATxdqUFZ5Rgkz0Uy3iPfdZn7rATtAi2L_ZiNJkBFnMe_eiVY_i8WBoCCOZy6iHc
Message-ID: <CALJ9ZPOBUc1wkQXVgjU-4w6r8c27uv4YxzKkfgEQdqtNJbVt9Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] coresight: etm-perf: Add AUX_NON_CONTIGUOUS_PAGES to
 cs_etm PMU
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Leo Yan <leo.yan@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 4:29=E2=80=AFAM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 4/24/25 01:31, Yabin Cui wrote:
> > On Tue, Apr 22, 2025 at 7:21=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote=
:
> >>
> >> On Mon, Apr 21, 2025 at 02:58:18PM -0700, Yabin Cui wrote:
> >>> The cs_etm PMU, regardless of the underlying trace sink (ETF, ETR or
> >>> TRBE), doesn't require contiguous pages for its AUX buffer.
> >>
> >> Though contiguous pages are not mandatory for TRBE, I would set the
> >> PERF_PMU_CAP_AUX_NO_SG flag for it.  This can potentially benefit
> >> performance.
> >
> > As explained in the patch 1/2, my use case periodically collects ETM da=
ta
> > from the field (using both TRBE and ETR), and needs to reduce memory
> > fragmentation. If the performance impact is big, we can make it user
> > configurable. Otherwise, shall we default it to non-contiguous pages?
>
> But is not that already happening ? cs_etm does not set the PMU cap
> PERF_PMU_CAP_AUX_NO_SG that means it can allocate non-contig memory
> chunk. Where am I missing ?

Although cs_etm doesn't set AUX_NO_SG flag, the perf component still prefer=
s
to allocate contiguous AUX pages for it. The new flag is to ask perf
component to
not allocate contiguous AUX pages.

>
> >
> >>
> >> For non per CPU sinks, it is fine to allocate non-contiguous pages.
> >>
> >> Thanks,
> >> Leo
> >>
> >>> This patch adds the PERF_PMU_CAP_AUX_NON_CONTIGUOUS_PAGES capability
> >>> to the cs_etm PMU. This allows the kernel to allocate non-contiguous
> >>> pages for the AUX buffer, reducing memory fragmentation when using
> >>> cs_etm.
> >>>
> >>> Signed-off-by: Yabin Cui <yabinc@google.com>
> >>> ---
> >>>  drivers/hwtracing/coresight/coresight-etm-perf.c | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drive=
rs/hwtracing/coresight/coresight-etm-perf.c
> >>> index f4cccd68e625..c98646eca7f8 100644
> >>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> >>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> >>> @@ -899,7 +899,8 @@ int __init etm_perf_init(void)
> >>>       int ret;
> >>>
> >>>       etm_pmu.capabilities            =3D (PERF_PMU_CAP_EXCLUSIVE |
> >>> -                                        PERF_PMU_CAP_ITRACE);
> >>> +                                        PERF_PMU_CAP_ITRACE |
> >>> +                                        PERF_PMU_CAP_AUX_NON_CONTIGU=
OUS_PAGES);
> >>>
> >>>       etm_pmu.attr_groups             =3D etm_pmu_attr_groups;
> >>>       etm_pmu.task_ctx_nr             =3D perf_sw_context;
> >>> --
> >>> 2.49.0.805.g082f7c87e0-goog
> >>>
> >>>
> >
