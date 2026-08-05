Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AB11DC198;
	Wed,  5 Aug 2026 00:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785890675; cv=none; b=mexvy75F10Tz3pn68PII284/GYKs4q5LH+3L+cVnwwIYcxNV3ak9yn6gVVaLhpL0rlFB5kiDwF7ZrqhwsW7RhyGdoBRfY+ziJQk7q+EnE9HWWWEwzjUf/ibXAA+zx+GSAIjEC5FWl3rruapcRmGHt62NMS7PoER5iZP2BwRvPU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785890675; c=relaxed/simple;
	bh=Usd4JS3ZD23dseS6IIn6ZYpYj2dLMDHgbbFKWECqyB8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EhGCU6XO2IbX0nv9K4XXsSBaTF0esDNPifDPWRw6pRF6VQIpiVgI77OS/gIHpQp0r4utnxYhNSK76GpHIeDagMpRoQO2C4qKUtp5yRUM8v9LzJReRJU+n5sQvftYFohIDzouUXXFUh7uGWahKsldw5foX7c7K+FGFA8dlac6tyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6BCuT7o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6BCuT7o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667CB1F000E9;
	Wed,  5 Aug 2026 00:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785890674;
	bh=wFCTgjq/Or5ODBbk63bIcNg5rXXpjU6nYEFW2W/vpgM=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=I6BCuT7oNHKdpzh8SNOspbcleBbAqGTe1saidqIrXWaZdnn1avMTLm1xQACJ3gxlE
	 53zyVvDbW4Ts5xLDPQJXAANNAAkKVMRcgwYF4rij4+sFW0oHVCWgucuK8KFoi+ZcCX
	 Vx09j/Av84C04PfSnF1f4/4YlLtn4ooGL4ZFb02MTQ1enhzlbZ2GIPJkU7exwvOJ1C
	 hHGfEA/tUV3MS4Bc3XBqKzfwiBrjdGr5RlT0SvLwe2EsI0R1EaPP8m2jWEw8mbJXRU
	 T3cGf/OZvQRK6uK01NUECxV3CqoDG1I8Q7ltnBoLVDPUggjAyGbf7Eua7nqP6u02aq
	 hoZZOhobHuyHQ==
Date: Tue, 4 Aug 2026 18:44:31 -0600 (MDT)
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
Subject: Re: [PATCH v8 06/22] RISC-V: Add Smcntrpmf extension parsing
In-Reply-To: <20260701-counter_delegation-v8-6-7909f863a645@meta.com>
Message-ID: <ef66e907-5049-57d1-d22b-0052085f8de3@kernel.org>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com> <20260701-counter_delegation-v8-6-7909f863a645@meta.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-408665861-1785890674=:1383527"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-408665861-1785890674=:1383527
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Wed, 1 Jul 2026, Atish Patra wrote:

> From: Atish Patra <atishp@rivosinc.com>
> 
> Smcntrpmf extension allows M-mode to enable privilege mode filtering
> for cycle/instret counters. However, the cyclecfg/instretcfg CSRs are
> available in Ssccfg only if Smcntrpmf is present.
> 
> That's why, kernel needs to detect presence of Smcntrpmf extension and
> enable privilege mode filtering for cycle/instret counters.
> 
> Reviewed-by: Clément Léger <cleger@rivosinc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Thanks, queued for v7.3.


- Paul
--8323329-408665861-1785890674=:1383527--
