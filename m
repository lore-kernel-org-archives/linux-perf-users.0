Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68426328B75
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068350; cv=none; b=PLjAjafwYdakv3zMpzG+Hf5uHJi9WRLxXhOPVp1PDd+3B1PVZF/8UOXVaB8haEnCn2Hp3sHY0Oom0BU5VldGPC4iBqMvsOkUF78QEEpn94C4aDBxMWR7CO2Bvpdg7CL/UGXm9Eqc/3tftWgaukxhiFdON4RbY2PTRDGqJruAlN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068350; c=relaxed/simple;
	bh=HyNU6uS/DbqGMGn1JagN/67xhjrwaq81mLqgDMkXQP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B3rrbuxLt9JiuYXnMRvoktshGlG0POE4E9qZMiiE5+pOoc2ujs/Fvb0lQ6Mn+snv+9puKeQEhPIL4UcpTzNqAg1xkilsjs0B5C3OP+kNpj5+DIalTGxg178DFxSv2/HYSAODskukgXqtLNH2FkpzXngbAPolgFtz+rBGIDwyls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=le6uPVll; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="le6uPVll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1743F1F000C4;
	Thu, 15 Oct 2026 12:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792068349;
	bh=W12XDrvw7f+AKX3qBwyOQ7szCXeUEBebRu6XXPPodDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=le6uPVllewTN5EAXowJ8xOcxIlFmLfrEKnM516I8nrvzPao8bCK2e37+CtcQOsl4/
	 k8bW9nNY5M7YnHMBZVzcPr2bZi4YwV3FhwZKQ3s2CYPrIPvv3ZiRzL/M6I8vuzyQHL
	 FIz/KBhwqKcgiAPbu6ZlJwmOUvz+3eZOdEeHCZFZzs/Lyr7PQGsstQAaqq1cisNXqT
	 6iitL6D7/H12m1qFZLcTxKyhHt1hNm2QJPT+MQBze2+1X/sDC6EqADMmKpr7vLbZUb
	 kCcrp1HnFk/IooaG9cfXJ+Wtg+b4we+SfjCDbVAYYt/zJ+XiXx5j82UUR7h5G040yh
	 E9Fp29B444Icg==
Date: Thu, 15 Oct 2026 13:45:44 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: mark.rutland@arm.com, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] perf/arm_cspmu: Add Arm system PMU
Message-ID: <atDK-H_Qrufjc2WW@willie-the-truck>
References: <222d98feab5ca2836fdef69fee9113f6f860167d.1791209460.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <222d98feab5ca2836fdef69fee9113f6f860167d.1791209460.git.robin.murphy@arm.com>

Hi Robin,

On Mon, Oct 05, 2026 at 03:11:00PM +0100, Robin Murphy wrote:
> Arm's latest Compute Subsystems and SoCs are using a common PMU block
> in various places which can mostly just be driven as a generic 64-bit
> CoreSight PMU, but does have an IMP-DEF register for additional
> filtering. The details of event and filter encodings depend on the
> particular PMU instance, so are left to the higher level Arm Telemetry
> Solution tooling.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v3: Fix 32-bit COMPILE_TEST to match arm_cspmu.c
> 
>  drivers/perf/arm_cspmu/Kconfig      |  7 +++
>  drivers/perf/arm_cspmu/Makefile     |  1 +
>  drivers/perf/arm_cspmu/arm_cspmu.c  |  7 +++
>  drivers/perf/arm_cspmu/arm_cspmu.h  |  1 +
>  drivers/perf/arm_cspmu/arm_syspmu.c | 67 +++++++++++++++++++++++++++++
>  5 files changed, 83 insertions(+)
>  create mode 100644 drivers/perf/arm_cspmu/arm_syspmu.c

Sorry, but with LPC last week and us now being at -rc7, this finalised
just a little too late for 7.4. I'll pick it up next cycle (but please
resend at -rc1 so I don't forget!).

Cheers,

Will
