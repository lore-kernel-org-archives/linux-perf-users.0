Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BF63DAAA7;
	Tue,  4 Aug 2026 23:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785885940; cv=none; b=EQaiJHsC4rv+2tLip0AObJdl3mYjvM5D00ujxyojVRym+QWdwkySrA7A6aV0GOcb2NjiVNwLhcCjPN5ljmDRaG3+13pUeVEyGhEWjgbMwds0hEyC2413ZMm13MTAQain3CyaXPRWeTWnsUd8wK362FpyRh/NAdthp71yZYFxzEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785885940; c=relaxed/simple;
	bh=KR0N+ffIJeKukvlkCual0w0q+VyUBNnBzz5GJocGm4w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hLlvA+jLN/0w7EndFvEs7YjVjVM6dcnvmKTVN23mmBXX4CN6uts5tvEPsKYICHb0AmUuqF7fgUxjwlapDwnLzz24Wmx18nmF0HDl4/AwVWWNzTgfuIXLbg4vkZVMD7M08VNcHiv+PCyLIaVyNFIeTpv0omn2nuhsoI3vNZp9+pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBueRxty; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBueRxty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A319F1F000E9;
	Tue,  4 Aug 2026 23:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785885938;
	bh=F6bnoC0uo9IGH0cOMPy+k1Qy1T/eK3SlwaiW/6NceV8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=gBueRxtyL1mYzDbdrW1e1N7tJhLUFwak5BnADb3TTiKTMI8GgbFrsgcLbu9h1r5XV
	 C/JzFyfCPosyAq5jIus7ub1cVMkTq4YRt7Oab3wFFCTp2FEL3KtMUa35qCLyMJGCqQ
	 kfUb0AU531BxfUHzqqbIVgwwy7JuKJbEukRQbDZOTg+jOHJkZGHB3uNRwlKe0JMGWK
	 BgBUCf9F1wWcsLr5un2yHLDN+CqJ+dJcmkCtbnPl18D+cp7jWUCueGLlTPMGxOVmuv
	 PHWv7TIUX3DOlXqodhjRXiHEm6E1ZNYWVIuH/iKDBkcouOzjVwyKZWWDPkObtBeEgn
	 lJMokykGIaYTw==
Date: Tue, 4 Aug 2026 17:25:33 -0600 (MDT)
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
Subject: Re: [PATCH v8 01/22] RISC-V: perf: fix resource cleanup on driver
 probe failure
In-Reply-To: <20260701-counter_delegation-v8-1-7909f863a645@meta.com>
Message-ID: <bec23082-4f4c-0dc6-e6d7-3d64c8e22df2@kernel.org>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com> <20260701-counter_delegation-v8-1-7909f863a645@meta.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 1 Jul 2026, Atish Patra wrote:

> From: Atish Patra <atishp@meta.com>
> 
> Sashiko pointed out various UAF and memory leak issues around
> pmu_sbi_device_probe() error paths.
> 
> If the probe fails, here are list of cleanups needed.
> a. Already registered pmu must be freed
> b. per cpu IRQ must be released
> c. pmu_ctr_list data structure must be freed
> d. cpu hotplug state must be cleaned up only if added.
> 
> Fix the resource cleanup by reorganizing the code around probe failure.
> 
> Reported-by: Sashiko AI <sashiko-bot@kernel.org>
> Signed-off-by: Atish Patra <atishp@meta.com>

Thanks, queued for v7.3.


- Paul
