Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5273B95F8
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784532145; cv=none; b=FyqggEg/8V4DblCdcgNAGkOTWHrrOnq6sR8oHVW+RmXfZ/shq4K46He8fOcQ48x53+mxSUKPaec87YS6u9bzVnuJEkopY2dBBEC7lAd7mnz0+Su9MLVgRLYIVP2p1hC4HWQSOQN9wY1l1XkYaXf1/nZlR2v7mHIjTe3wy6Q9/sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784532145; c=relaxed/simple;
	bh=SBkUBV3inMBinSlE2EXReUKlgUw2jSOCC8j8xgqt8Ys=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Y8Q7ayZX5r9Zim7yWYcz53DZdON18EfSB2Hk7qDGjfpvv5xmUJvWgeyCv5KJQM2oGGQ7QYqcoEdE3/9ZW1ltd3md7yqtcZk4MAXYqClbn15bIKHidTsYmY6bczFB50boPsW2+u6p7boHnvaVcRGqbjL0Z96O9AswfUXYdS2ikUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZrHjZbP; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZrHjZbP"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso6114440a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 00:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784532141; x=1785136941; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dFLZdi7jBgOetxqkL5F8Xn6PniUl5aE+NCedsWROBE0=;
        b=aZrHjZbPdv/VbkHCa5hfhxSGMi4r8XrPLGKwhEFcCI5k1+/oS47EViGwomNBH7mTSm
         XhgL89VJHRIlYStd0+vvLksA3mtuaGO98UZcG1SQz06EDDJDiq1TYwLVKiNGQ7D0zc80
         uY62lJY5XbY6lSur2z3MATWX1V70z++Jgx5z5fSsRPUZS2KCg40hRHo/oEpn5myE2cm3
         5DwD6tLyw/GDE+x3kzY8Q7ZcWcYn80DExOLq/+J58Ax6nt63aY4UyIj0FnxFf53qfYMT
         cq8StcaruMAMTfTifUcHsiGZjNyp7PEaM2aIeBCFXFICWsM6EPWNGmoCqz8A/PpaEL1H
         Q4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784532141; x=1785136941;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dFLZdi7jBgOetxqkL5F8Xn6PniUl5aE+NCedsWROBE0=;
        b=lqQlhBDcNzHTg3+RyJxS5ADfD2V50+PoqXGurCmp0irU24SEwMoCH2aoVB+mMPpj00
         zeMtvk2/awrzDW7YALMa8FVJxDuBgTWiZ8kO2yb5pxJYTAaJmy+hB5J4tQpfCFD4V0gw
         voEESeNLG+IvQV5zygCLkBYSUa+nCtAT8IVbi8I3Al9ZqwjbabuDPTLmHDRQ1Rjsny78
         2KGxs4mghi0jFqR0IWmyEhyPZJbkgTBR1bHkCwBJlfsKfnAZHdhUfRkZfZUVP4Ii2inD
         uoO+svt94ib2k6rLiF1QvW5cVzqFKySwOnxzPR0TxHg6THODdJeZabQ6VAo+fuf9pJmc
         PPDQ==
X-Forwarded-Encrypted: i=1; AHgh+RoDznguR+Njss6l0TeoYiS7NVjv7fHsvlbZ0aalWsUsO+WiWE9gDrGDYEjEfKHHREXjIFNlUIoURYq+qg30n9UH@vger.kernel.org
X-Gm-Message-State: AOJu0YysT0zKM792Q8e6HQ/3wTZsHLoOkwnaTwG9Nfgn7FuBxQWo9dnb
	Xr9YMqLT3Y31gZmYgQaKBUzO8FOBpr6LD4CicG0NFo9NJwD5kXJqQRKa
X-Gm-Gg: AR+sD12bW+go/daw8EwlN/+HC14Tb/WmRvOtKG/IyK/Dsi/PbCrcsBaqwfum5JrQVTX
	QalBoTB5+ZMF6tBrtfJzQGSNnfVITNZ5KLA5QV/P4teDKORJvPgzjYTyFKGmyQfUDx5ambBhu+V
	w0JNYNOQSBobfUBaN8ThANYHYkBCzGGtHtbbIA+8KkADRC4tx10BuA5EDXkZpdnpNrzvU2UaN4X
	WuF8lPSGob6P7yNrF3Fbf983X+y9/nHZ2smiqqoDGb0OPZQGbIVOP3Dzo15cYJQzP2sfCQ0FJ6y
	CWhjkEvSHhLdkw3vmWOQeUMjsd+r38yYTUVOnJGTNj2TXj/Og+Em4MQ81KcbftGc3YqG5qHqhGf
	lLafryeVui9LSHS3VOX33XtjaUHPaaK8JhZ6VOzcM+Tiq73aKkwktvk6wzCpK5PHcsv8K+6sUk2
	ZE8mVB5BReSBXvFplUPBEy/KE0kS4U
X-Received: by 2002:a17:90b:224e:b0:38e:7f52:c8c1 with SMTP id 98e67ed59e1d1-38e7f52c9e2mr3426881a91.28.1784532140841;
        Mon, 20 Jul 2026 00:22:20 -0700 (PDT)
Received: from [10.0.0.29] ([2601:647:4000:5070::51d7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4afcc067sm5153318a91.1.2026.07.20.00.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 00:22:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v8 12/22] RISC-V: perf: Modify the counter discovery
 mechanism
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
In-Reply-To: <20260701-counter_delegation-v8-12-7909f863a645@meta.com>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
 <20260701-counter_delegation-v8-12-7909f863a645@meta.com>
Date: Mon, 20 Jul 2026 00:21:59 -0700
Message-Id: <178453211938.543975.7016109597042850635.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784532124; l=1181;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=SBkUBV3inMBinSlE2EXReUKlgUw2jSOCC8j8xgqt8Ys=;
 b=kTziE623vXoAa+JDEunw6f10OBNK2smh4OC+4caPgYt5rsl1d/L9P/MzNiS/0bUGjTtCy0tKZ
 nYPopmmArSXADJnnKy4KEiAAwcwHjgpz6bWgMPJYTo3ZdyCSTOe1n8J
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

On Wed, 01 Jul 2026 01:47:00 -0700, Atish Patra <atish.patra@linux.dev> wrote:
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 74d934238821..c20f1e33c65d 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -1599,13 +1658,23 @@ static int __init rvpmu_devinit(void)
> [ ... skip 15 lines ... ]
> +	 * in S-mode via Supervisor Counter delegation.
> +	 */
> +	if (riscv_isa_extension_available(NULL, SSCCFG) &&
> +	    riscv_isa_extension_available(NULL, SMCDELEG) &&
> +	    riscv_isa_extension_available(NULL, SSCSRIND))
> +		static_branch_enable(&riscv_pmu_cdeleg_available);

This needs to not only check that smcdeleg is supported in linux, but
also that it is supported in the SBI implementation correct? Trying to
boot this on OpenSBI before 6bb6b61c27eb ("lib: sbi: Add support for smcsrind and
smcdeleg") will fail on an illegal instruction in
rvpmu_deleg_find_ctrs() while trying to access the scountinhibit csr in
the patch "RISC-V: perf: Implement supervisor counter delegation
support". The proper mstateen bits need to be set for this to work
without crashing.

-- 
- Charlie

