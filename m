Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F224611E;
	Wed, 23 Oct 2024 18:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729706495; cv=none; b=JAj2H0laORxuaC4t3g1JNMSbuIAGVqAlQtUuuPjQo7/BRMVgP72gHSSg0N7otJJU0H9aMJntOAmjVETab6gK+uYrDq2pQA/1yIoDcwjpddrV2igeI0FaZvmawwSbzP3tNG4vhgvJERCbXpDHKQ7CUpHtrJae676+XYG/NzXG6iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729706495; c=relaxed/simple;
	bh=K6hu94uMlnMahjpTUGzUwEPK6QP+a6Re7F3l/BAs3qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyHj3l/N5j3gdMLSM/q1dOTPBDLuJHr5XVJNVuNRYsgJOZCu7mqftztQaV8lLq9vgW8cRjLd/aJzgKw1z1dSxDmTCMbpih4Vhju8VpVsGpu7e46AIX+Xnjn4a/Q2yrVA/Dt6dX7d22YugMrWVy/xrb1czvC1F+PHg+jgV8vxO8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duIGalvs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duIGalvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5B5C4CEC6;
	Wed, 23 Oct 2024 18:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729706494;
	bh=K6hu94uMlnMahjpTUGzUwEPK6QP+a6Re7F3l/BAs3qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=duIGalvspfw1JLsGiSuRFIgsi5LqNAN9FHMs2U3ckv/6OHsnCNTslrjFfMvqiaib/
	 e/NwlY8vEHL8WW2bXWNGWzG0nnA0WsIduQ4IrfsLBt6+7nsPZk4v2CGdjgVODMiMbE
	 f6eKkU/W3BS4/DGnaRSTDPNlkE3xey0DtctRmGWERgIjd20ahsoTZ3JAFlF5lC7JAT
	 1MpQ3ZaMg33gqlTCaoodz8p6xhc/eyU0NiTKT7pGH6HhBhFAj65KcQXMhOaa1pRsBi
	 1EFA9xUcrJYfCmYOL9tBlpGK6dCOnSihQZYXzA5e28KR1Stz3ZOBPSNzs8idN4dbmu
	 C0CAsNdAvjf7Q==
Date: Wed, 23 Oct 2024 11:01:32 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCHSET 0/9] perf tools: Do not set attr.exclude_guest by
 default (v5)
Message-ID: <Zxk5_OaAWdiVZhvr@google.com>
References: <20241016062359.264929-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241016062359.264929-1-namhyung@kernel.org>

On Tue, Oct 15, 2024 at 11:23:50PM -0700, Namhyung Kim wrote:
> Hello,
> 
> I found perf tools set exclude_guest bit inconsistently.  It used to
> set the bit but now the default event for perf record doesn't.  So I'm
> wondering why we want the bit in the first place.
> 
> Actually it's not good for PMUs don't support any exclusion like AMD
> IBS because it disables new features after the exclude_guest due to
> the missing feature detection logic.
>
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

