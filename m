Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0273587A9;
	Tue, 11 Nov 2025 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861062; cv=none; b=MJvlKyzKb3DhsH4jq9aEPeXkIOpWeemeKXDIvor+suHF7z5A5zhkbhEL7IR7WACfP41p2mUtDCAvyIKtnyZC5mSHDVjpTecnNkTI0k20sBkxpnz5SfavUlQ743EgoKR87HsVuUK8QqLfVHSLrQ6buG9we1NJo8TZRoxZ4j7uhEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861062; c=relaxed/simple;
	bh=mnzdprwkhx4iXcuA/dmEYLmWn8J7Co/1UDJk6Go6CrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qh3ryO+xjE/9zU/YU2KxIhQ1HO+6JuKOfzOi4Q2kqtSCnFuKzQ0hWb11lJNr+h92YprJlienDe0ROvq9c7JLDALXOdPXK0XXInwRBSsimEACbvj+E07+DV5aAzEMe+UjFI+S0wunLWf4QRywRbvoKt2hYNcXRkz/Tb83ZNxWat0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ACQdESAw; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ACQdESAw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mnzdprwkhx4iXcuA/dmEYLmWn8J7Co/1UDJk6Go6CrQ=; b=ACQdESAwD0IiqcAwROJp0CEzwe
	e4yBxBgXXsrdk/I4WYEus+Er/p74hipl695loH5CK3RqWoeCKSsME/nuuJJzwmqaX1Q9QdLfejc7Z
	RNo5cFCur76TRL+rPL3urQRBxfG6Gi/v5yXdyJcdhytdhthgbX6OU8GgCNByX7GEkD2wNm6yn5b//
	lqbuW2kGBV/A/jmY9o7Yq/nGPqQ4c9L7iLLN9ppXHxd6elCSeLIJH+6TPHPGFdBCVfAmzfMgrJ3eZ
	V2jaiK3dCLP+Wp6jpfIeDuzTEP6BP7HISz6koD5xCUv59yDdgSH/o5sDqy07etLcbYNzPXlogD8Ow
	dPYzMubA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIlp8-0000000D3z1-1pku;
	Tue, 11 Nov 2025 10:42:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D58F0303031; Tue, 11 Nov 2025 12:37:32 +0100 (CET)
Date: Tue, 11 Nov 2025 12:37:32 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v9 10/12] perf/x86/intel: Update dyn_constranit base on
 PEBS event precise level
Message-ID: <20251111113732.GM278048@noisy.programming.kicks-ass.net>
References: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
 <20251029102136.61364-11-dapeng1.mi@linux.intel.com>
 <20251106145217.GA4067720@noisy.programming.kicks-ass.net>
 <09210c12-cc61-4af5-bd13-830fd9650f9b@linux.intel.com>
 <20251107130552.GB4067720@noisy.programming.kicks-ass.net>
 <a0416429-23d4-4f4f-af73-bcd87b4e773c@linux.intel.com>
 <20251110090311.GW3245006@noisy.programming.kicks-ass.net>
 <97eb5ae9-6c99-497e-a1b9-80bf365bf2d5@linux.intel.com>
 <380fd742-a7ed-4d6f-9944-b963869a5cb3@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <380fd742-a7ed-4d6f-9944-b963869a5cb3@linux.intel.com>

On Tue, Nov 11, 2025 at 01:41:05PM +0800, Mi, Dapeng wrote:

> I tested the queue/perf/core code with a slight code refine on SPR/CWF/PTL.
> In summary, all things look good. The constraints validation passes on all
> these 3 platforms, no overlapped constraints are reported. Besides, perf
> counting/sampling (both legacy PEBS and arch-PEBS) works well, no issue is
> found.

Excellent, I pushed out to tip/perf/core.

> I did a slight change for the intel_pmu_check_dyn_constr() helper. It
> should be good enough to only validate the GP counters for the PEBS counter
> and PDIST constraint check. Beside the code style is refined
> opportunistically. Thanks.

If you could send that as a proper patch -- the thing was horribly
whitespace mangled.
