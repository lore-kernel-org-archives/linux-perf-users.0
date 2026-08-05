Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AC71DC198;
	Wed,  5 Aug 2026 00:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890694; cv=none; b=Nliyh0zBwYVDo2MCubys5mt+qojhX2UGwbTnteuLO2K+FEo5hfjNDS0h5RUlz5iNOxcId9/kuM7aMBS7Y7nUrZxH/WBVtobGnwR5Jjf3jd6YzhtQgl1ExA/f9omhymjulCqYJjGO2+jOgJBjy0idBVm5JE+fqR2FkC372fwFquI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890694; c=relaxed/simple;
	bh=jbalygw2COge4bxzR/L1HLNWcXZgTw0NnUlVr4Nm1T4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=meI5bflPeyz7QurxcqYqLYXpi84TUDW6k15cy9G12Oi8sb9OW9Ckroer/YQM4RwQ1R/9R7elncqkn3R8fe6aFBzQeXdNhpVIEC4Ic967urIBkU6mN2vJ0EUzU8LcPTvJuOADYMbLmvo8z1sPWBgBLIXIpEPV7CsMcYhjtjPdjpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jU9CCpmh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jU9CCpmh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8BD1F000E9;
	Wed,  5 Aug 2026 00:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785890693;
	bh=2Y/GClhk5EHpUKcceQDAHdolG3lD11V+IrqaCA9JD5k=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=jU9CCpmhzzEP1GFHQ6gK4+x//Tb+0spelDugOnnD+bjbCQCRdG4IPzg87xS3QU+ob
	 sFHmrFBGDF2+L5ojKPsrjf4GcMJMqaKRKAbxLAqu6z+aMaBrGTwzwvvHn9zCb9l4gV
	 6Qd/081cBFxAewpTrs6vtM5eSlEkbZ156WbjMT4Z7bHP/7Kw/otNzRBB+MEM1laYjm
	 c/G2U+wUJ/YS+EZ5pUvVE1YQtZndPGBvxUmTHSOxKkgX/T7GecH8iRdRpycocW02Sy
	 BdLa+3tQeH2kcgPWuJyO5Lz4ByoS9hu2YjkDYzS3GvHhXOn/GhfiJbRQKvuqoYrrPo
	 8LC54yQzLVdVQ==
Date: Tue, 4 Aug 2026 18:44:50 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Atish Patra <atish.patra@linux.dev>
cc: Jiri Olsa <jolsa@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
    Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, Ian Rogers <irogers@google.com>, 
    Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
    linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v8 07/22] dt-bindings: riscv: add Smcntrpmf ISA extension
 description
In-Reply-To: <20260701-counter_delegation-v8-7-7909f863a645@meta.com>
Message-ID: <a2f138eb-480a-bd74-0a10-7c699d5f6e1c@kernel.org>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com> <20260701-counter_delegation-v8-7-7909f863a645@meta.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 1 Jul 2026, Atish Patra wrote:

> From: Atish Patra <atishp@rivosinc.com>
> 
> Add the description for Smcntrpmf ISA extension
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Thanks, queued for v7.3.


- Paul
