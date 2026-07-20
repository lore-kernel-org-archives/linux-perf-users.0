Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195873B776C
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784532141; cv=none; b=b4mKNQh1JMzJc0rIi/wKPSV8rcfSZIJLkRWx3z16bs2J5iNgkCvx8928YZLJbSkdpT9aVKQYlIN0OPSUCS05d+MF3DdzZkyX29FpugCjXAIknuGhW9Sy8/faUulpBr+F39hz2rpyf5+0T+GSCsA/kwekOJ7b+kF1ey4reAQkR9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784532141; c=relaxed/simple;
	bh=SzuQlKgKf+dbOdbZYvKV9a605QJD2/wh9qiTBlKZleE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ReDc99Lyai5+2dkzlkVlrSt4aEsbeTduV0iEJKzC6wTGUKBsXe5lTAygPqTFiqDbxwOZZQFmcM680DGXynSMoKBGYiRXnaSUCb4Gwne0EYWH0YatjcC5cmEk7h8O08S/mlxjoV83pHr8sOQfPx8K8yJ+q/4ssET+/Frg0av1Cms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCXGHH6s; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCXGHH6s"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-384c94c9414so5370375a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 00:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784532137; x=1785136937; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6h8UJegFSpbzqcCoxFyjFcJzeX3Wy4pDkK5e8kjwbRc=;
        b=ZCXGHH6sm2zbxuqpc+s4l0VOm1yWzbaTSw/YYbbYvJNZSRicX6HwM7rzvvpdaHnKbZ
         AHu00I2wYOv7ALaMZroT3P5Px2LzVQ/cpiJk057GlBc+wr26wBufEmhZy4EiE6iOsn7P
         s8Pj29BCwnkJFvMmG2sBWK1F8pJw9WMnl/u3MdA5N7rrrK5kb/SOaXnvTS1LtdWxsDx1
         hrGw1xTSjFo2VMMiwmGbuh0eKrGYP61kaYGlHhvmu4UT+O976gCtcHC6GA8qve1zeQxY
         sQMJM+9Qc9UpbrDif8LZB5QonBlS3uTSN/kPSPZyvxftcAeLT0RNTy8CrDTn8pIVRyX1
         frHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784532137; x=1785136937;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6h8UJegFSpbzqcCoxFyjFcJzeX3Wy4pDkK5e8kjwbRc=;
        b=W76YSyn+RanPCq3MowVJzzXak+UDFQrYDz9Wo1Jmd0GkKjKcx2vVD6PGJtPRBNYWG1
         bawjP1nryFPwDVSbRwB+RxB4rpzv+EknPX710Q4sm2c5YMlFRhxOz2tJZC73AyEypW8X
         SNYcDwH0uUs+ZnaHA3YUDfIgZeWAnGWMHmtaeVOD5HCSa0r2kyG8gmuzznKJDUKtVenr
         jwrsYEcglG5N6jmjVLkNwwfMdBxnkhewVWdsrlOYVo9uZtCVWRwa8DBjNquW9i5k+Cdx
         wievWlOvmDVRPF+Zthdo/rC0XKzU56ObsTgj1QOYMGcXwvNa/KRSIqoOuLXmzZtX10zq
         MMbA==
X-Forwarded-Encrypted: i=1; AHgh+Rp/+IMSNzmIzIrqwS6ph+YNzXYoq5E9jPH3dnTdl0X+Q3m4TZEFLWpD/5FAYV7QHiIUAGWUooa3NY7rL1S/RDlX@vger.kernel.org
X-Gm-Message-State: AOJu0YxqUBB7ZwuwWk53k29pPx5vWpcQ6OElUNlA/XARnsZnwu2MnetS
	v37MIFALLUlZRAlL7hzO06jAukC4d+Q+Ha4QhYDo8RXvH5rxkCZ81b3O
X-Gm-Gg: AfdE7cn3nkItaL9x9qlZbh1b9BVrhel1zCu6X/IaotQ7Fcb+a6DFxW2SLTnsRUFIKFC
	lHTV3iIlgiaNVVbQ42okb83vOAtU9LCjeOjaooqetIgZWneKSCr6StLp9E2ARCLl+ZEzykPnXhQ
	Lq/tmUk0UfhF0eEAjEp6xu8WOlDAMsRd8ougWnANtJuVWE7pqrBCJkfZzKRqGnlwL4e0/qWBfmc
	PLsmwDYAzuevok7gImyyA1egbthld5J77f608u7OkLx3WA3btWjGFSgdVpv9vx6nGNMNjl/JgNh
	QB6hHFJY0NhTri4RV6pIPDWFRNDsyWWHe9kJZhxNzLowHvc5uwf9LxiRZrnwRvVFPaEGUv6AzXk
	tCZ69G5g/3NiDYqqT+8wRq9ZC87xZwdbsCLmh9ttbX+hKa6I2bxXAIm5s+ZmdVIWWSsDxPK8f19
	u2TLqs647BhgVEXDRCjDe7hJ1rBEiV
X-Received: by 2002:a17:90b:5605:b0:385:d033:d9f1 with SMTP id 98e67ed59e1d1-38e4b5058c3mr14013135a91.28.1784532136729;
        Mon, 20 Jul 2026 00:22:16 -0700 (PDT)
Received: from [10.0.0.29] ([2601:647:4000:5070::51d7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4afcc067sm5153318a91.1.2026.07.20.00.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 00:22:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v8 08/22] RISC-V: Add Sscfg extension CSR definition
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
In-Reply-To: <20260701-counter_delegation-v8-8-7909f863a645@meta.com>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
 <20260701-counter_delegation-v8-8-7909f863a645@meta.com>
Date: Mon, 20 Jul 2026 00:21:59 -0700
Message-Id: <178453211936.543975.6345698898378707454.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784532124; l=635;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=SzuQlKgKf+dbOdbZYvKV9a605QJD2/wh9qiTBlKZleE=;
 b=ugqoqQ9cmaF8JmbcwtjHFRt8KirwYYADAEAYU1QR3dSM8OO/c3BahtvSrl6cdO7FCzsfCm3Vf
 9NMihisQ3erB93I8FusSXEt1xutLF2NmPmGrBqXQG+Qpo45AYM3E74H
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

On Wed, 01 Jul 2026 01:46:56 -0700, Atish Patra <atish.patra@linux.dev> wrote:
> This adds the scountinhibit CSR definition and S-mode accessible hpmevent
> bits defined by smcdeleg/ssccfg. scountinhibit allows S-mode to start/stop
> counters directly from S-mode without invoking SBI calls to M-mode. It is
> also used to figure out the counters delegated to S-mode by the M-mode as
> well.
> 
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>

Does this need to be signed off by you?

Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

-- 
- Charlie

