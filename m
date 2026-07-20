Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846BB3B7747
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 07:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784532140; cv=none; b=Bl3krR/FSr/6bPwmZGNISNjCzIUntRCd2EpDw+A0IpvXXhRnBDWTycfVX5JKlrlTN+BcWJWIQMf8p1UFOKDNvnfuPJEffl+Z4O9+Bn6wNA42rF37yUteWhNnCMmnGDObjH2AokfLhY+6D0hquPb56/p8wOopvwLjJKGB9IcpRKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784532140; c=relaxed/simple;
	bh=qBhu2iKzjNZfNhl5iANbL2aUfkBruPYxRqMle5qLLTc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=SUREOHkBnaMVsuJiSWAHDA6lBmXiw8CHxJP3a9LBFW+Use8n84E2GIWQ3lalEx4dcmMTgWA406JHkjKRV7Q+XxaInjZKSWynwIUT8yGc1ypwmEP4C7u4mH8T3HkdK8HstC8y7+En/HxobjgNPn4Q4HVfT61oZirD2Byl6iGlbOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZ7Ua9zI; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ7Ua9zI"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38175907a56so2524997a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 00:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784532135; x=1785136935; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7rDy2YQnZjC9nWpz521LfOBEMpKeq+JKB5BWp/OjrPo=;
        b=CZ7Ua9zISHWjqNHbddze5qMCs8cIsQZ7tpiefEABYWxBPVGSQc4yJVUXWBKqLeKeE8
         ZdmP3RURoE5Afm8LtqsXC9whAPZB7JdFOanPbIWd8WT4ijBY7th7FKTplCDmt1joKFuX
         vqgot+h62FRbICY0o/ZY6893ykht1RBNLVC8wP++mLbxalznIfUhBC/dxoCaMOl6FGTC
         Ad9TtyaqFUfGTxLsFTpbxTThq1qX5CwoiNtog84LdhjA/J0KyDDeqFCi8vH5q5yYBCp5
         AFsJz734YT7nXPUaUZy2WXdVzVYCxfwAB516iDrFeUp3cclwKJk8bo8+prtA+g4W9d2o
         k0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784532135; x=1785136935;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7rDy2YQnZjC9nWpz521LfOBEMpKeq+JKB5BWp/OjrPo=;
        b=lkKmXLImvpj7w4CXe3BAI9d4Wjjct66fmgr5KMhQVvUERmUzMvNlsOwJfHnKZuAhbU
         tW81HEOdQKfxo56dNE8GHfUFAd7sYBNLNqfzDMGkQI7o//Zi22g5eH+14qykNOq5EFXO
         ZSsv37GLvp2DQ7QBFndMRHRk8UMet56rZXUYdDQ40/m91jutMllFs4E3mDkDXD/dy/FM
         PKHwRV96vownpGVsMivojYx7D0h9rNPVjTW3LGc+W34ynXiesBQCub1mLaCLfEgPgFtQ
         cZ8EC7f/kt8BwsBU6RBTOeBaSxPJchE99TkugMQPSpuyF2h8qj8qkT1GUQFCqQD1xS2T
         CnyQ==
X-Forwarded-Encrypted: i=1; AHgh+RonQYVtiM8HAu3BHCWfB6/KR2iHuL5QtpRldIbqY18iXic3haJFvVNxQ9N4IDaNdx2kBdVm0hVWcdMIiIqqAkVT@vger.kernel.org
X-Gm-Message-State: AOJu0YweI2y2dh14T7c3WYQqV1CTgSnA0JyEPorFoCkUDXzBN910mmXX
	3LQH3fUUoR1w4EnDUmPdDthAsELMPt2sgC5bSkpVhNf2XtnPhnvXsuJY
X-Gm-Gg: AfdE7cntH+g4Eh14IcIaEcl3J5j+dCrqN39D9cayOmIrdmMPg/RJQngHPksM4Hlg40H
	BSbqBIkfWC6Jx0XUQmnCQUYY9WMVCr0L7+YMGg/erh4evpCZx5/ld/kN5HCvk3NLYc4/78SPqgW
	R1oGFbjfxfGujYAIei0+9OXnHEWt40RFKWNfmo+jrz5rmtNS0wGjWL9je8pYqZVRQ5zyYI89g7g
	YteCCIUMGEofK8loRuThHPTzgIBIPVI3gpmwer9ZIOM5/9rKKbqR6asWlq79BN3ZvA+4KFoITwN
	Bmt6HBb8liIk5gWfGwSumx3en0b9uk5nfSw+Zqh5QhWdwoSwjdpUSjTx2N95ntz6ftimTkcyM24
	r2lBNR1lgwKTk0puWQbecc4lfxRJWjO1MWdQElD0jBCsr2kFcITOvvop/WWIerfQbznNbt7G+Na
	pSm01dCZ+yaYTrkvE6BQKh7jEswfjYK8qrI4g2fDc=
X-Received: by 2002:a17:90a:c887:b0:381:10a3:8b10 with SMTP id 98e67ed59e1d1-38e3d26a744mr19412579a91.14.1784532134670;
        Mon, 20 Jul 2026 00:22:14 -0700 (PDT)
Received: from [10.0.0.29] ([2601:647:4000:5070::51d7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4afcc067sm5153318a91.1.2026.07.20.00.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 00:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v8 06/22] RISC-V: Add Smcntrpmf extension parsing
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
In-Reply-To: <20260701-counter_delegation-v8-6-7909f863a645@meta.com>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
 <20260701-counter_delegation-v8-6-7909f863a645@meta.com>
Date: Mon, 20 Jul 2026 00:21:59 -0700
Message-Id: <178453211935.543975.2748934407130948318.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784532124; l=570;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=qBhu2iKzjNZfNhl5iANbL2aUfkBruPYxRqMle5qLLTc=;
 b=uKypJmhCBRm/kvczWTSaeADe6ZnWZKogPAT9RNWB2cU/VzqTs+HjCiYkmIUntLvKjnWbFfrXo
 mWWz+WSV1MiBTMwThyOj4KDk1SApmC68RTUbDpPAJQUlRKKfVIsL4JI
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

On Wed, 01 Jul 2026 01:46:54 -0700, Atish Patra <atish.patra@linux.dev> wrote:
> Smcntrpmf extension allows M-mode to enable privilege mode filtering
> for cycle/instret counters. However, the cyclecfg/instretcfg CSRs are
> available in Ssccfg only if Smcntrpmf is present.
> 
> That's why, kernel needs to detect presence of Smcntrpmf extension and
> enable privilege mode filtering for cycle/instret counters.
> 
> [...]

Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

-- 
- Charlie

