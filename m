Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D021A9F91
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784532130; cv=none; b=UR/PFju6X3/yTNNHCXfPLOypVviArIpSZAgGBNk7IE/6rWaiJB08YMBAIC1q7vLK004Y5Q8H+84UAujeEjNli88pm/zURVBv0RNtyEr3EUEe+gBbKcf7AWkyz7gqCSDOGeet5W1Ko+VvyPHqWYYA9ttn4MgQ7xVFrlrzQmQCmj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784532130; c=relaxed/simple;
	bh=ysgPHA/+x7CEppuRQZHdHoo9X3ZDd6yInqnds9Ij0bo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=axmI7lrqMvOsCy/9eDEGoteksKpGzEmlPuXHgK+00qhiYi2a6y8w/MAwoRHk6/cnRcM0LHtHaa5QREyp4P9K3en0AyVV8vol7cMFFPZ1QXU36soobzJLRoJr0ZJF6sVeI6ypefVvJqKkCX7Lt0Q5PCil6o1LtjKNnfPj2AOYXu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pU3WQB2G; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pU3WQB2G"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e071ed6aeso5946099a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 00:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784532126; x=1785136926; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0fm7uYEG5s4l2Qi1Q3lmMTkR8sLj78MMwG9bX9Qa+qk=;
        b=pU3WQB2GnNDFPIoEEYt9aYC1IKZ7ZKFiFDmvwgsS6104FDvqEb/IbmFOPlQGzGreMa
         HNOvDPauQktfJOLigoxFOBhF3FSXNpWDTHt2YRiXblgAugWUpGqR6kQMOxXzZnY1CsjY
         4Hw6Hn62zdVmni3dk5T5apP/UB29HelA0PP79fdQGXUcOYb9jQhvPCDocb6zdokF/MHS
         R8CU2PphrFxwUoZwst9tR41L2295bOdu3A6vkwcsNa2NnZPWGblIzfHY2ON+vkriPorb
         pA0pL8YmbAKLRsf8Pny9jnSXZSkdYMaAD8hn5aRKRmklq9wpBsw46DGcbaRwPYpc427F
         9hdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784532126; x=1785136926;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0fm7uYEG5s4l2Qi1Q3lmMTkR8sLj78MMwG9bX9Qa+qk=;
        b=hF3L8BRRrgmIIeXNx/L4wCGMU9TbhU1QA3gqFGYMiC9HSqIzMWyC+gK51IxBS+bCot
         pLtIP/77rRwuETKsuJ2ARwqhv9n7dDCCwxU7dJhdQSCEtlkGCAoCPKT7KJllTnA9Wrjg
         RbUIcqyDJy55dkr4gvIaP4NpXDJG8NxMXZ60fLk4gv+1zXSDh7o20qNmAIFdd+H8HvJn
         KQ9+wofSd7XOY7S9aaG409aed+fZYBJVxB4L5yLqGkoF2EtL0VUbo8dSGCuePufTBoAj
         VWGpM8cLK9i5KgUNrAO2ICfKyvneDCg0/kMo33QZhzgbLTn+vDKFcd3d/KtnNKiCrwUx
         vT3Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrni6J27UmOvRWl7uLgOl+Ti62nAM3Yha2RfcfMYMiCI6ZVmD5YvfKbwkVln4xgjOJukogdx7rmDID4BEvRw3xd@vger.kernel.org
X-Gm-Message-State: AOJu0YxWln/KW+eo83fv7zg8MPk91JwWas8tRlbmRBA7zqbY3Pb5neas
	PTcpIspjy5OZY4BWYEYiryAgwH+pE+99ypCIc0l+nkrJDuRiE/IJED6c
X-Gm-Gg: AfdE7cmnXT1R13foamgDzKIfw30s7VUfyLShAb2Gf7ly4nGZoY/iNwePN7J+0x1hNuk
	uqjoOuHm+EsYaeeefHJf+ptH72pxWp2K55VK8q/r05Ia9J8ps/XIQNOLXSuG9uTbjkustirucUw
	gbnxvO3nNxBywWn2LBf7ZU52OF9h2a1TxZHKWDZ5onursMwPHleRoT0sDHlhNt6LFfSN/y1iPhk
	1J+Nhgv0qmvILulMTOyXR3X+c/l84KyJw3Pv3lVOAR2lzOqWjBBAZu3Zt3B1QELAveDMK1aMS57
	XiQ3jg0CKivKMQhT56kZ7P6YiFzXkoeQZ8tdec+k0slB3Yey7yJRgZ3ncM/118Y36ZKXeTOfOr+
	ogf6cXn3xqGnYFG2SWrNuA2fPw6qzCnb5Y1SbGqFRZjNdxkd/fELx0NJ2aDkI4si0FkRYa/71ND
	sLt5szXZfazgrgBTIs6gdehgKhe4Rc
X-Received: by 2002:a17:90b:184d:b0:38d:858c:834d with SMTP id 98e67ed59e1d1-38e4b47726fmr13853861a91.17.1784532126260;
        Mon, 20 Jul 2026 00:22:06 -0700 (PDT)
Received: from [10.0.0.29] ([2601:647:4000:5070::51d7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4afcc067sm5153318a91.1.2026.07.20.00.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 00:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v8 01/22] RISC-V: perf: fix resource cleanup on driver
 probe failure
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: Atish Patra <atish.patra@linux.dev>
Cc: Jiri Olsa <jolsa@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Ian Rogers <irogers@google.com>, 
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>
In-Reply-To: <20260701-counter_delegation-v8-1-7909f863a645@meta.com>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
 <20260701-counter_delegation-v8-1-7909f863a645@meta.com>
Date: Mon, 20 Jul 2026 00:21:59 -0700
Message-Id: <178453211932.543975.10206534637071583934.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784532124; l=522;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=ysgPHA/+x7CEppuRQZHdHoo9X3ZDd6yInqnds9Ij0bo=;
 b=qvIZNCLm5+fXN3DnRuew6aKjZnISyDx8ToUDRMjQnEAf9oEg+M6noqRVyXRmMKpzp0n+0SKqQ
 v5ga/susCSiBn1ylxb3JFmtsT1uI3nl6wtJUgUv4oCsU6GIAT34AFQ0
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

On Wed, 01 Jul 2026 01:46:49 -0700, Atish Patra <atish.patra@linux.dev> wrote:
> Sashiko pointed out various UAF and memory leak issues around
> pmu_sbi_device_probe() error paths.
> 
> If the probe fails, here are list of cleanups needed.
> a. Already registered pmu must be freed
> b. per cpu IRQ must be released
> c. pmu_ctr_list data structure must be freed
> d. cpu hotplug state must be cleaned up only if added.
> 
> [...]

Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

-- 
- Charlie

