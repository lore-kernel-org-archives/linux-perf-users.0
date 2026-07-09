Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA53AF9E8
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 00:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555568; cv=pass; b=MDwKNjyhNCljeLVbN67iOc8EpEunkDGHvj+pnIdCxMZbrPQISglnU5LnHdcO6XH2fgpVghjE0RXJIrFq+zZIHHQyKHVCzyh1APILlN+XAfRY5tvLKDOSC+SgIHlyFFS8PPu5V/YnLNvH261P+o0UCnNpAijXa4R9OvNEX5dPsqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555568; c=relaxed/simple;
	bh=yJaHiIAKdt59/nUs88AHXAG1seHCynr9U+jmRjUBOEg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xr8I7gO+FBZwTiL8OSr00MP+2+VWZooOFx912C0lL86rIGo2mBSyp540K2GSgFj8qb3BhxqLjFM0s/A8e5kA9Mu+WIO4IgR5FbHTESxTpmY0WZu3Evb69KzgQiwJ7rjJN+fIHul5UObb8eal5IhQe27HjmpuYpdAmm6PauxsI6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=km73nMuQ; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="km73nMuQ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cae1a3a744so9851575ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jul 2026 17:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783555565; cv=none;
        d=google.com; s=arc-20260327;
        b=RQLW47kuE7PrjepzVhPZZ+5iZ6VsOvOAEgeQxq7qAZk612mv1kI2HXVNfpzV9efl8/
         l8WvEPCVDOSRuX42SnAKEF1A4NkVHOjbkK4zVX6V9RvMe8jFcSaxQKFrg6szjCNKzOLp
         5M7XkaedKblnbOcxAldrBX3bwfLacogcFBDZ/GoZxmnzpXrIeAlxsMNBB0jc16a16YCH
         5wVI8SFvay03dVyKVH13suZgTiHxhsYbQVA8dq8rdtYSx+6YekjAiPhGxQK8MViEyesb
         5pxFhVoCF8KYNMT3ZjgyEDIUAl5K+2RNLAJ/9eCuGFXRa2V7dMUcE2T6ddG0VJkEqRO4
         S51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=yJaHiIAKdt59/nUs88AHXAG1seHCynr9U+jmRjUBOEg=;
        fh=xw+KJPjm/ebhDBzllnP8QL1aKhhtBrn8WeVEtCiIods=;
        b=RGiXlmcOOwHOpRnpakkHU9kLtB2xDtG/DLm9OtKU9qOS5A9TKZIO31EaaSBCvYkoqc
         XQwQnT+H0molBhsOE8wv0PYsHLiy4C+T7ZRD+xv1Jiwh26veEK+AUTlhH/9O5353UvJ1
         42vCC3/NhkP834LspW+R3udePnrNftjmR8MasOKvXp7VaL7MuPoG3F42JfdE0a9jBl04
         voCr6ZYDK7AMtKph1CiGrPPVFCRCn+4WnANtJdlUT8tMJkAA4GFZ0DdFmSXGyFgWg98/
         GQ5xx+qbaPibjhVEBnl/sevJeX/rWyqcvm83U6+OrMoqvHVXtQDqy+/xWoJzyO2lDt1z
         yvAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783555565; x=1784160365; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yJaHiIAKdt59/nUs88AHXAG1seHCynr9U+jmRjUBOEg=;
        b=km73nMuQirX6WkgaiDewtefUUpLqHsLA9lhojmRVu/O5GWXI+qspHLrIcP28hPedd1
         IdrQ4w2WUGkGZnfsvZbX4i/0vv+f8zy6UYrbx+r+6VAltUS4BsKAcMEEAqGPcoKiR6RJ
         oJPaYYcMOCkbcbYn6DUg2jPj6RwRgKn8b5KjbPN0LTaLwabP3wAFOO6JrbWd8+/V2xJm
         8qmB+NxqEb/SagF5FxCEtMVuCK+ov8IPbs0gvdfNk2TGZa0FvtOnzr4ElVQGCDXTFRjv
         zpPIU07tYAE6O/XcExlihB295hDnRUteCnX4/vklcg+GnLTnFl9WQaUB6cAitmsgQsSS
         bmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783555565; x=1784160365;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yJaHiIAKdt59/nUs88AHXAG1seHCynr9U+jmRjUBOEg=;
        b=AmJD2nNK5Yx5qqKt9H7wNg2u/SPUkc2yO29TjgOj3OrsUWyc7M1cVW80FXhWhKDv+G
         3XJ2laHb9g1eKT6l0Y3boV3dLKb84Hh8RIJ/qXjcodXxCjsuXcSW8M2fcGAyvtFVDl5E
         Wg5HjZETQnRZKDR7JC5n4BBgc/moZAPY/lHL2ThCR82KBFY5akmJqL3TaGmZbErJaHKN
         lYctgEKyQYtw56cD6BXGkLslpAb2fh9GrYnZdYb/5HfR8hWVl9tGmWIs+0OiNYflgP6N
         Z63FnI4joM1jiGbW3vyl3S2hJ5zbsEi5D0F4+i0To9gETcAxaOT8S2O+Nk2/1bq6ygUo
         U/BA==
X-Forwarded-Encrypted: i=1; AHgh+RpvdAcaZgdEDk7b4+PI/CI0tCPhG8NqREK9MoS0aaWzMrUQdTgqx+wEtkjkRFTDdnnmyYVUWsWXg8Sz0Di5v6Pb@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvm+ON1WeV/YpvOBOGsP8UvPWpo/t5uTdwT4xh+ws8ESZFJa/6
	AlFS/qvEXM5a00l3dXNc7tZZDBHP0J9jlD9dsyBMa/Q7y53l3Md2u+ySi28IoFxzBA/pxP73pwR
	GWsQGvP8UIeiCW/PBitmeB/T8ZaOTWvupyoKjhyp7
X-Gm-Gg: AfdE7cny/y5sjHbwhzaxJtP2168ja0hlgIysa2fjGjSMi2hR0Jw+UCkdUazaWUEmaTx
	qVR7c+QCcbBoNwmWbYS80GC4YFZdAD+MbxAzr0DVoABP7L31n4BepIvow5MlT/wslZZo1CyfMWq
	eDWNbtHZSJytyqezUe4oUQoWtehdkJA6vZj5hLWf4CVQYOoMQ3Io9pVxDjJTkG+hrs6NR7odln9
	JdsA5XD/8ypxuCb7LWfyYnnao3BmtJOQHV5oBjavvCAMZK3CFCc5IkpPEhyt2ymRyx2x8uv86Y9
	4GgspfhRGwRA5tahY4ARaeOoP+1U6BqJigG1pG5qg+DNyGCEbWXTtlpSVbl4q6TZKAdxMw==
X-Received: by 2002:a05:6a21:7482:b0:3b4:669c:ee32 with SMTP id
 adf61e73a8af0-3c0bcbc1353mr5760887637.37.1783555564841; Wed, 08 Jul 2026
 17:06:04 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 17:06:04 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 17:06:03 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <eedf589778aaab33e6df2ad6556dcde536e13460.1782735110.git.ljs@kernel.org>
References: <cover.1782735110.git.ljs@kernel.org> <eedf589778aaab33e6df2ad6556dcde536e13460.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 8 Jul 2026 17:06:03 -0700
X-Gm-Features: AVVi8Ceg-PSWltTScKU18ZF0mdbBsNHDv0s-VKhIaqzjwQ-q80D6zfZMKk_VWII
Message-ID: <CAEvNRgE-JJAzC0jp+bY8+e1+gYSH+MjT6JqX_DfCcpaxOM-Dtw@mail.gmail.com>
Subject: Re: [PATCH 15/30] mm: introduce and use linear_page_delta()
To: Lorenzo Stoakes <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>, 
	Simon Schuster <schuster.simon@siemens-energy.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>, 
	Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Christian Koenig <christian.koenig@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R . Howlett" <liam@infradead.org>, Matthew Wilcox <willy@infradead.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, 
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-mm@kvack.org, iommu@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

Lorenzo Stoakes <ljs@kernel.org> writes:

> It's often useful to obtain the number of pages a given address lies at
> within a VMA.
>
> Add linear_page_delta() to determine this and update linear_page_index() to
> make use of it.
>
> Add comments to describe both linear_page_delta() and linear_page_index().
>
> No functional change intended.
>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>
> [...snip...]
>
