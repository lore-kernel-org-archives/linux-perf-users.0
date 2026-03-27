Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237AA396B9D;
	Fri, 27 Mar 2026 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774645261; cv=none; b=WD7I9eQqAB2VJlHYwu8WqUIVbVeANrNolalB/l4/y2jCtPj5VhqREmbZSrrqxXI3jdy0a+4SOgecJ9LdqFp5YdCN1k/vW2Yh0snOWwbVuQOaAkw1uPeoxR8QO9s1wcxYqRHIv5uYyLnu/NWW92qtkYkJvp+hWP+DYnPYNkL409Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774645261; c=relaxed/simple;
	bh=qpPtQyUIlk1m1Bo8YLxMpJ1BfwKEMESTy29dJraTx/I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GByoRmpR+hEQkNNsMHzMA8CVxNWR0S2KkeMIGz8Sdp1ojE2JGsVH2XqmBWvzakSEYwIV2NwHRioQhdge+8DWrDAQA6Ki4ZMa4ExiRLmRctWpfpI0UYc7ycRH3IDY2rGhGUIEXWNMxePuPCCaE6HOfw5kHEHSXooC6ErgS07lMkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFcQ+2jW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFcQ+2jW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB5AC2BC86;
	Fri, 27 Mar 2026 21:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774645261;
	bh=qpPtQyUIlk1m1Bo8YLxMpJ1BfwKEMESTy29dJraTx/I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PFcQ+2jWK/0Sb0UuyrnkwILLQgYLvF2azdqAt4hydVZ9V3AG/Qv9klnNz4t8uk3J5
	 Vrs/1cBjCRUKsqZsrZTDYOPujwAcKiWpm/4Fvgo+SslBuVs9BM1SvTns9cJz1xy1aJ
	 lJj6dDcYqgKG0bWAOvPFd+Jbc9nwwp4+GmrtM9e7xlsHSZY/meTOP3tjx88mIIzUxd
	 z3lyMkreAq1LsBIBHo+ErDGwL3CUiS6WxxMLSkJXETemk4bARPueFLt401OcCPnKoC
	 hR4zniMu2FS8QVanvPJc74lrTeN/wMfs14/iVrUibSiYIDA9zPRtqp4JB/KaAFa0nW
	 JcbSGXH5rWTag==
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
 alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
 jolsa@kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
In-Reply-To: <20260319233349.306012-1-irogers@google.com>
References: <20260319221215.207951-1-irogers@google.com>
 <20260319233349.306012-1-irogers@google.com>
Subject: Re: [PATCH v2 1/2] perf lock: Fix option value type in
 parse_max_stack
Message-Id: <177464526065.2796353.16564372338348886538.b4-ty@kernel.org>
Date: Fri, 27 Mar 2026 14:01:00 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 19 Mar 2026 16:33:48 -0700, Ian Rogers wrote:
> The value is a void* and the address of an int, max_stack_depth, is
> set up in the perf lock options. The parse_max_stack function treats
> the int* as a long*, make this more correct by declaring the value to
> be an int*.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


