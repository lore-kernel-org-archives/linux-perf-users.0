Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14D24BCADA
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927910; cv=pass; b=qDVPPBDoWYEqXZEwMOd1K+ENKgZ3v7ndmwqT7MKsZ13YaSynv/7NYNTeKWJbaDXBSOYTRFxBUzqTtDTIPPgGcA2DCcRtsNV+SWHqci5G3qAOAET/ViCdWmKdlbQ6+yI8XcZwOQ4keUe/DVj9bn9OgZafsQe7gNlq2npwVB2e+gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927910; c=relaxed/simple;
	bh=XSP6FcLY29IUdyu3UKpzzmkVLlCxGVD+UwFi/2oFQMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ks5EY00FbCqln3R1WAIz5/DMv/0F7PIPIxeMAM0npSVgusyVOAhXMAkga5wB9uivOnQWiHe0400fxevQXO0wCzX2X6epXlXHi6V8pLnQhI2+Bi5tHOaYPjPUOwE8d7ZC1TLF2hmy+xQygsfNfIV9pqHpm7yEtBLMrhRDWy0C1X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lgni5iWt; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lgni5iWt"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c9b2ac97cdso70465ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Jul 2026 10:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782927905; cv=none;
        d=google.com; s=arc-20260327;
        b=bfNvYKIwETQSomMpnCum0gFr7WuFi5XxESv2hv5e3S/cTKa9AjED0+0eKzMwPeqUOn
         GtRjgRk6HWpzJK3LsaMoTpWPbtsUFbWKhCg2iLa1ZZk2qJo42MjxboMYeTyuTjW7nVpM
         WODHieYhSUOdKWd0tXUeVUhWcym3qtxxqYnvGAR5fcURA75yX2EHepKb9q13eJlRKQlO
         aIXvOisgTACTVL2S9ZI1YnpoAyNK+V4VUoOHOgK7iAiHKO06B4cZt+Uo1PjQAw5Nj/rI
         S/BWi5U/zAomKGSbsbvXogqfyvXLYk8HIjxHZm6pU0QYOcauJvKtslCNooEIjAPbnkel
         g/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4WnvY/8pdLerNOMgVcd3eg+mIsfzQdgJqCy+yb7eu3E=;
        fh=rHFXYtl4X9YTFsxB6roxT4o1NPiOt0G/dBCT6hF/cQ8=;
        b=Ine6J0oX9DedSnxYfD6hIWy8pLxoPnuwZK2LRS5X3knVAIU0EN6K057HNx3UeNHpWX
         tYkqoZ/d7rDGNSwjYVgQlz91tFZ+4f2kcUIwMY1riSpJ+uLwISf9oW+LC6OFlQrP8OJW
         Dwovk1xjI2N/d7bcVFhsT+n3yEzK4kvYxgMQhCPGjeZwUAw7r6yHS7TFzTN1UyJ81Hw+
         cF9XOjZa2Jf8EWp/hhTrfMQOE4t5WXdlk8DLLhFCbxrgPQ6nk9TtNsfeAalZhnRBcHWa
         zSvwLvk+Xq/VRTRTCLgofxwiO7ZBs8/7Qr/7ZSFao2G6VtP8Ib1QIBzUsznWN7shvkM+
         hfdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782927905; x=1783532705; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4WnvY/8pdLerNOMgVcd3eg+mIsfzQdgJqCy+yb7eu3E=;
        b=Lgni5iWt5ZvujNfSnkxQojZdE+KNNTHWNV5tnhGRZ7UpDl4Gq8rB20H7EkURpX5Ow8
         O/QroqTz5P9kk9q1FauQy2xPJSOrI4r7SFUegqfGSGQ4VFGOj9mYCPdK4lMfawsx9E7V
         CbBp3ZyCBy6XVbQ/WsmqlN/ZomlGYzhuuZEM5ctFmOoukVd6k6m2lluCg8O/p+NeF7/m
         QS/ULRWK6XxC7s+wFHV4pmZHmcwSj53fx4AAH6aW2Np76oBTkz8qiYaKqNSPB1nwZYYC
         0SEWwimb7QvyONlBhHsLoJf0+dkGNh8BcyftqLBC+kd7XF018maMwvh0BDsWWstJUJkX
         SQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782927905; x=1783532705;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4WnvY/8pdLerNOMgVcd3eg+mIsfzQdgJqCy+yb7eu3E=;
        b=ZTUxFUUPJx64wCa/qJ7k3T3X8lK/lzHIhESHlpBpLfUUt3GA7uTzvLLqMFVt6Lbizh
         1eF6UfG1FcoEm94kMwYFDedSKQpNXv1+DyKgtcH4Taj8iGBvFeiax+iqTkZZOPtF03Ao
         EHpKcFV7cPgbGV8MV3jpjxBKhs61cotSKWgmPwRoFMZMT8iz4rT+0bvSIWOf+5I+F7WI
         Giog9ROjXA85ciFJVQSu+IQGog+fNLRhWp8pB4nLgeD+m7FyiYSa1hq1zWZmYGcLaaY6
         cwIg85wnXYAdHthz+sjDg8WHE30uB7GZDlsEqhQOFBrcaVKgs771LRqhpnwNJUkyrZgh
         TKLw==
X-Forwarded-Encrypted: i=1; AHgh+RpMEWt8PzT0esVSXUxxKGzpZGAZ6XibVNPzglkKPz0Xa8u57Pi2+Th4TMac+eqvzYeQ8XF3WmRFVOoPWk8kvKnH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9PjTO7NSGLbUzahWuCnFIqQCOY/2E6qQ5/Ic36Wirph0ADism
	PZgPTTZDIaWWNRUabdu0RhAGoJ8IyLlzqHojmrnmSwMkckBq2kqX2pdiYmL6v8kYz+JzoDKK4IY
	d2RPRBmA1Da/kDyFYHndmYxa/hPcQhO3pIJwO37tA
X-Gm-Gg: AfdE7ckxAGLCBJoP8FkrbuSrSNo2r1kbDXb5sg9ppTIh6dR79qJAysfHdAsLwfwBIa4
	gugvJJ7BE5jMUxcq73X5B7CVcpAtAVZFb+7RVFBo6MofnXqqdf6ttRhCJy/TXvri7iiM07GHGKC
	MDeQYO5KPNoVUAUBrPgZzU/aEiaNBPJeHCRdJh2SlDsoo47lLPRDCILVcFGUUBoTOnxi5hcEOcr
	rwDke+4eQJhYs5KdHYv/q3ZGGL2cY1wUVmDWIJOtgSuDQIfIgMQvT6k2uVnIt2t8PJR0u6Muw==
X-Received: by 2002:a17:903:41d0:b0:2bd:6dad:7ccd with SMTP id
 d9443c01a7336-2ca77f00e4bmr2394415ad.25.1782927903977; Wed, 01 Jul 2026
 10:45:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com> <20260701-counter_delegation-v8-20-7909f863a645@meta.com>
In-Reply-To: <20260701-counter_delegation-v8-20-7909f863a645@meta.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Jul 2026 10:44:52 -0700
X-Gm-Features: AVVi8CcF30QiINVIR-rPJZ0l--luoek-SQcSIaomJxOhJ6SUjI8adFi78wHcNvk
Message-ID: <CAP-5=fVBe7Rsf4tkaRiMVPcAD1rHr7PxT-8XpR208C4jaANmmQ@mail.gmail.com>
Subject: Re: [PATCH v8 20/22] tools/perf: Add RISC-V CounterIDMask event field
To: Atish Patra <atish.patra@linux.dev>
Cc: Jiri Olsa <jolsa@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 1:48=E2=80=AFAM Atish Patra <atish.patra@linux.dev> =
wrote:
>
> From: Atish Patra <atishp@rivosinc.com>
>
> Counter delegation lets supervisor mode choose the hpmcounter for an even=
t,
> but the hardware may only allow a given event on a subset of counters. Ad=
d
> a RISC-V specific "CounterIDMask" json event field, handled like the othe=
r
> arch-specific entries in event_fields[], that carries the allowed-counter
> bitmask through to the driver's existing counterid_mask (config2:0-31)
> format.
>
> The value is the bitmask directly so no counter-list to bitmask
> conversion is needed, and because the field is RISC-V specific it is a
> no-op for every other architecture's events (unlike the shared "Counter"
> field).
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/pmu-events/jevents.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 0cf9d26315b3..516fb73886ed 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -396,6 +396,7 @@ class JsonEvent:
>          ('EnAllSlices', 'enallslices=3D'),
>          ('SliceId', 'sliceid=3D'),
>          ('ThreadMask', 'threadmask=3D'),
> +        ('CounterIDMask', 'counterid_mask=3D'),
>      ]
>      for key, value in event_fields:
>        if key in jd and not is_zero(jd[key]):
>
> --
> 2.53.0-Meta
>
