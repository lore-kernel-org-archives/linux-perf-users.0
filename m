Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D256414A4FB;
	Mon, 11 Nov 2024 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731346156; cv=none; b=LV8/W2PAeSf69phBgycXUtD15Q4uQVIOKhiR3SIBizMzxRRHS2u2/a9+siLKYgQUjNB77OySMG8RmgKpNAvT+srchG0ySaia5viRnWR+N/OOzSta1o03LtLCuMBwcVGyBJU5g5x7c5gdjXVrygukQSwU35yvzdU4jbtFAfo2T+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731346156; c=relaxed/simple;
	bh=2ORGgfRrFCZo3gKmRviGAldc/6tnzHmOpaLBRqobq8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTTnwy79cgOR+qGVY4buOiMrofF8mkQCzmUwRgyEi4ufErD+iCFSLLIOc89xJErQXTKLBLgczVete7S2Fjk31YIXnzlPfk18pry8bN7H5KHDk5GXIZVAoC6LYtMUJRmR0WvN0i1FK7WEyz0pKgTX2KdVqS7gkCHyZVRrLDmgsG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0fnGxzU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0fnGxzU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1540C4CECF;
	Mon, 11 Nov 2024 17:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731346156;
	bh=2ORGgfRrFCZo3gKmRviGAldc/6tnzHmOpaLBRqobq8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A0fnGxzU0rXfX2ZGSf4D7Q1eQg5Vpg26nE87/egpqdV4bQbuVemAZ3nDzTOroPgzB
	 pinkLpO8V91GwXW53kCfjLOsSoLG4l7YyOG0FP4g44py0Za9LVKYWcFn7NPm8fIPta
	 K8k/vHVNGqruf9X7ycsegPPyh29erKsm34d3OHI7EOV/IwafBf79h4p+cR8Y6F9Qrb
	 z8Ik0qyk8XWZ4pyJ7d7BZkKuVe6VsjS4qZPJiYtUFpw3JLT9byZy3qude0eFNxx8oC
	 tLlNkAaXKKDIlclec0DLipy+nCljponprdjETilwC+It+aiAzBirsgDciYMtkwiMi1
	 Fqsk+M36sGYcw==
Date: Mon, 11 Nov 2024 14:29:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrew Kreimer <algonell@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix typos Muliplier -> Multiplier
Message-ID: <ZzI-6MJ4b7mZRkg3@x1>
References: <20241108134728.25515-1-algonell@gmail.com>
 <c1592c50-e903-4ee5-a560-530792fcbae7@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1592c50-e903-4ee5-a560-530792fcbae7@intel.com>

On Mon, Nov 11, 2024 at 08:17:29AM +0200, Adrian Hunter wrote:
> On 8/11/24 15:47, Andrew Kreimer wrote:
> > There are some typos in fprintf messages.
> > Fix them via codespell.
 
> > Signed-off-by: Andrew Kreimer <algonell@gmail.com>
 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied to perf-tools-next,

- Arnaldo
