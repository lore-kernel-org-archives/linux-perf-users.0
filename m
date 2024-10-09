Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E431DA5F;
	Wed,  9 Oct 2024 06:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728455609; cv=none; b=itjKU8hQZESCoSQueZ+g65z70kGftpMVVjzZX6h34bgWiXTx4YOBkFO2ZpEweThxRWKi4v6LBUkby7mxDzme/X/BWDcAh0hz63xNTz02g/ebLh1OOb3H7weQU5zjWcO0aMas52AyYahr3nzj1SgovctIxrci9lkYo1XQ7fL4Usk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728455609; c=relaxed/simple;
	bh=I28cySXFP+ymOyu5Znas9HvYpOipnbO4aBsOVlLE+r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sE2hia8ZSl41GNXNxNDSvDHUqhwQQQbBWGJxH2YRiG3YYE/4b1YSarTGuxzWChp7t+OLrHp2tC+0A5lx65HoysoM+ag0/3bktFukd5PAJfxD8ypJAhk2AQwL+G08s/gmqxxQF3r2NTQXO35i1OLQcxPpAanmp2boeqHzSIc0aSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ub4qCA9j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ub4qCA9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0115CC4CEC5;
	Wed,  9 Oct 2024 06:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728455608;
	bh=I28cySXFP+ymOyu5Znas9HvYpOipnbO4aBsOVlLE+r4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ub4qCA9jYUr+9UdWCWsByUQpsPpW8Hx9MYtuPx6UmDR1wJBXULhGk995p7AgjkgoN
	 kSni/XtWmB1hmcriPqKSKvyaNUutRGtZvXZ6MrwZv4o2HPnWDI47xlQi1g74ZelelS
	 ez8i3Xe3NjSXnaQFr/Ii83jV/OCFRzLO2L2512pKypzYzjXtMzXl5riXiHGrHxt+jy
	 yEMweEDLyOwrLtoysooxlSaisUDnahFe0yhBbfJDcA7bUxA7wsHNiF42PS4eWRWkh5
	 NgQGDaq2y5je8kTlkQQ0IfXr5TB2zlrd5dDAmBs3Ax4Tgwejc1qTNbv7NEnOghnCS1
	 a32YiOBEOE8Sw==
Date: Tue, 8 Oct 2024 23:33:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	eranian@google.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	santosh.shukla@amd.com, ananth.narayan@amd.com,
	sandipan.das@amd.com
Subject: Re: [PATCH 0/8] perf/amd/ibs: Fix sample period computations
Message-ID: <ZwYjtkf6E_Pf5opB@google.com>
References: <20241007034810.754-1-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007034810.754-1-ravi.bangoria@amd.com>

On Mon, Oct 07, 2024 at 03:48:02AM +0000, Ravi Bangoria wrote:
> IBS Fetch and IBS Op pmus have constraints on supported sample period
> values. The IBS hw behavior could be undefined if they are not followed.
> Currently, IBS driver does not honor them correctly and thus a malicious
> event could cause issues to the system. Fortunately, the IBS hw is very
> resilient so far and IBS pmus are restricted to root only, so the attack
> vector is minimal. In any case, these are genuine bugs and must be fixed.
> 
> Patches are prepared on v6.11.
> 
> Ravi Bangoria (8):
>   perf/amd/ibs: Remove IBS_{FETCH|OP}_CONFIG_MASK macros
>   perf/amd/ibs: Remove pointless sample period check
>   perf/amd/ibs: Fix ->config to sample period calculation for OP pmu
>   perf/amd/ibs: Fix perf_ibs_op.cnt_mask for CurCnt
>   perf/amd/ibs: Don't allow freq mode event creation through ->config
>     interface
>   perf/amd/ibs: Add pmu specific minimum period
>   perf/amd/ibs: Add ->check_period() callback
>   perf/core: Introduce pmu->adjust_period() callback

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  arch/x86/events/amd/ibs.c         | 97 +++++++++++++++++++++++--------
>  arch/x86/include/asm/perf_event.h |  1 +
>  include/linux/perf_event.h        |  5 ++
>  kernel/events/core.c              | 12 +++-
>  4 files changed, 88 insertions(+), 27 deletions(-)
> 
> -- 
> 2.46.2
> 
