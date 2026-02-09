Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21743254A9
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 23:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770678400; cv=pass; b=bCdmaCkYB4m+8fux13o+b4CTvpQFrsVIca0iMi0++JYNOCxoj9woBfgHvJRrPaueENrVKS8EjMtqGWxtXWf6+a6jIx07/EMNTucF0jWi49fZAGchuDM8GecVrKeDcH1xf8CBqeuT/wFfDvu8I7l7HwzxzFkvgGsKfuu064OFCog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770678400; c=relaxed/simple;
	bh=7o9rX6slym+tXrk1tTM+owIAN037ktWBQHlMD2w4iiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MN5B75MD9abow1AYpczKL8dYkB3D6Oz6PNe9ivj6n1Mk7Aeo+iq+R+a+Qphw6U5EJoMfUyhgYTDzaLu8hfBMQ7IfmyKTCgI5JH0Wz4ru0HT5wxWhF+lwYwnjk7Ii1jDv9XRHPjoqCUkyJpRP5KAVFSzIoNQpQMW28ShaHnyoqxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wOPYFp9a; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wOPYFp9a"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a76b39587aso16555ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 15:06:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770678399; cv=none;
        d=google.com; s=arc-20240605;
        b=XzgnytBoFhdsJalzfnXQYFWVhNwjzbmVofXU2CXyc1x6auyonLYyfj/JpZ/gInaVj6
         QuiKYH8jZa5pJEE6DAsWd+sy5HFMgO5wGAZ5AykPLn/YAigLgR3R6JZnS07ee8XvG9+j
         mp9hdyZs1nHI1AdC8J4Xq0e7P8unq6gmFOAB5trjU0eeBYeIVDLCmIBsyOBuvTamJ1x9
         br8YRUmjrGuuDwLFflmgs+1ZN7y2VaZj6MafntOtxdaDOmiBQq0KyOHse4vFWylkUe4N
         ZjnuEszz6H1HUG1WBASZlWoJCDq2IufMOMzk0udlzuBZ3zuIdKyWQx5Noabp6reElHhH
         hrDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7o9rX6slym+tXrk1tTM+owIAN037ktWBQHlMD2w4iiQ=;
        fh=5Pw6O6lDxwkK9lYGoYOBmjz1tLKMN+P0S6Lk7pDFkLw=;
        b=jxewelpBKfgGC8+UIjWZm27/RBL0FyRlgLJKnyUb48pX7G8CK2q07kcnP5bypgVFVw
         DaAVo1UNsY3SDfjIzYtXFKIy+/+5EpgRGaXJIcZ1AuyBkrSzaZQWoO/tZLSIFk15JmOK
         q0ljJpfHOhX7QqSBFqcLCjNTNN6VXLYfVJ0qkMNti0Q9JThOvYv7DFgSwIklxAF8ziAD
         JQY5cnTiIIKlUa+jgmmeP9ukDuR4ZhQtnlOxLkZxcbbMs2fZqfY8evQN+AiM43EeXSF5
         RTtZxHWm+0j0Xkm2nO7oLoLbS0RriLCWiCKYHUvG+9tVpMDSZ6I+TP8WQ97Pui9Lx5nu
         2Z5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770678399; x=1771283199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7o9rX6slym+tXrk1tTM+owIAN037ktWBQHlMD2w4iiQ=;
        b=wOPYFp9a5KQmH/pbcR+ufOYGSReLKQRkyb4j/jS6fAtWSnuHVQJKpWauxUfo69MHOD
         cV7RdDpMWaLUqRuT9l4EjY2bfLAZW8uzERwxNL4tzD1Fc/QYmyu18qgQEt3yZCGoUYMC
         xakfJ8VNDQaGlU+QPnB05vJtEyQNWNVhCUcKdPVsP66V/pmsdZAbG1pwc4syapw7qQa1
         eUUIb0mNPy7PGYm3QufbNfhT8HvNRgqel+HpfS4HRgeDCwEBijJRP4Q4PnHPzuZdcFKZ
         1lFqL+RMkNSnJfXbM/9kJmIvcOR9evF8Vk6N5ZZds73dGNivM8swQ1f7JyU610CtCvvh
         bHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770678399; x=1771283199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7o9rX6slym+tXrk1tTM+owIAN037ktWBQHlMD2w4iiQ=;
        b=K1cT7+92gkvgDEsQ9p3l5/8sv1YeYeEL3VDDoIjV5PpFxN02mxQ9lT60jnw7D0j9e7
         +bs5bTsfEsEFwwkCGbX09KpXHJt0flOR/kkaGP0Wfh00fmQwHpXvUyvetTP+jukbg7vC
         Mn3vn+M/81UbM/z8RlYUxlcRTDOwd9J2qHPP33OcqCRBD9hb3S9x5istofpwXcQVq1PT
         yr6CA/4rOBv55IHG22UM2GvSykhZUsqpeIh51xxxCduVtZf76Kbv5PXeZHzIplcaOUla
         Dnd2C3Ns0T7jhsO8Kf/bBd4jabyS+/nFhseN4KFtXyixp2/SukQFaAVV4NWQcAVAGt8t
         c5gg==
X-Forwarded-Encrypted: i=1; AJvYcCUvfrauZdamZlLYiPuUt0Uqp0z8WKgGL++zgdd4PcGaHQQ2OUShSQnHvXVkb4Jm3q5hOFyb4a0/ERSXPmlLzcQ7@vger.kernel.org
X-Gm-Message-State: AOJu0YytDyVA3q7EUz84IJqoDAW+oGZ4vMYaWAwWpJP6VhefhjZWgg+T
	VdYnDy8D+ICIBEfoNk+WReta3NNTylV0x2Bx7xFvSpZEq91irR7ULFm06uyFFGHaaDaiGs42Vg3
	PAwGT0xWQDmputD7dmikhArwv76/O8sRlPCAEx+ZC
X-Gm-Gg: AZuq6aJ2BHQrrqknA/ImSjCncNnGZXO3XnMVHpRXiQCdTV1ylAO2XKk7X7op6qNOX3j
	dVCqXk7ITb1c07sT/n09R/JuO/jtSnvGx2ZK+296SSGhOZ8zdJRiS1yrWoRh3FimwjRmcLm/6u1
	ZYwLl2zAyD1jqxx1l5lyZJLPFI8xu2uBdGWzzQqY1FgUQbxLDqcYMy3p63QIB630Twi5mIsYdWc
	Ag7Ks2yTAXOh+buaO3l9qwvVkfIRGlXy7/4u2Leo5Ej/J+kg9HxDYz0PN74T43dr4HvYQ8/nyop
	CO63u7OeS8SX9+q8VwPmoZYsgmTNxz/WmO7AEIqhCrmhKmw=
X-Received: by 2002:a17:903:32cf:b0:2a7:d266:d84a with SMTP id
 d9443c01a7336-2ab10104509mr432285ad.17.1770678398575; Mon, 09 Feb 2026
 15:06:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fXPsOuqr+4DZmscoWGr1VHHJci4jRGxbOtJyy_Mp9Oa9w@mail.gmail.com>
 <20260207004956.610458-1-irogers@google.com> <20260209092200.GK3529712@e132581.arm.com>
In-Reply-To: <20260209092200.GK3529712@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Feb 2026 15:06:27 -0800
X-Gm-Features: AZwV_Qg0Ipv5ifj4EfOFj9r5t2wlolzDSxLMeFloxiHT8rpiaDgPNIXGLTP9o_c
Message-ID: <CAP-5=fV7yYP2x-4MgWFbXOH1_kHjQmYm8TCD=a3cshUDZR00LQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf metricgroup: Fix metricgroup__has_metric_or_groups
To: Leo Yan <leo.yan@arm.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 1:22=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On Fri, Feb 06, 2026 at 04:49:56PM -0800, Ian Rogers wrote:
> > Use metricgroup__for_each_metric rather than
> > pmu_metrics_table__for_each_metric that combines the default metric
> > table with, a potentially empty, CPUID table.
> >
> > Fixes: cee275edcdb1 ("perf metricgroup: Don't early exit if no CPUID ta=
ble exists")
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Tested-by: Leo Yan <leo.yan@arm.com>

Thanks! Sorry again for the earlier confusion on this.

Ian
