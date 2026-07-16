Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD60340EB9B;
	Thu, 16 Jul 2026 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221126; cv=none; b=uXAR4Y0DE+ZsUhwZoGqmbChHFpSf4En+/kIWl1FFIWkWIFrWRRptU//8KTour/79+CCHz3R/YYS5LiGVssLnmX0fp4RYgsItCjThGIurcHmOdGSlURfYcA/uM+pCtZB/59HgksjB/6iX+ou1g2DHvM95d6Ac18q5qGiOOBM9DZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221126; c=relaxed/simple;
	bh=xpw67Vk9WIUatl63bXmEcuHsm4HSRQBXItKxt8fUIv4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MpSOOyY7DdQsjhXeIz8fcA6U5vS271YZLtCEKyzTgqQx96skHR33H7B3T17p2BKAsEzEXaEZqj00JtVXGfgI0cVYlUgB/01f1zA5Lqy3HU1MIMsBfxOQXOZONt8+2RaPyikf0kziFXKQ0V5AryhkiXuGEG4+b+dzX+7XuNzruUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVYSubnE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVYSubnE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CED1F00A3D;
	Thu, 16 Jul 2026 16:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784221119;
	bh=d4ogOAzsWzfEEe7xHJWDI2sfc5NWPOEIN0EPx99scB4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=KVYSubnEj2eqjdJXZCjtdiGhtnEwtx2n5JrzEf9ditGyLV/jwbDawiu8hvCf/W6s8
	 sOp4wm2VGKZU7AGAk/cymY35bjEnDxbf9dP1HoV6lNO+HRHERZS0v6DYCn4nld8HP4
	 wYuAKKs9A+CoQ4lWw6jjSF7p/r72ov8yN91PZwj7IE02LpS1LZb+LiIiU9JKYvpZvt
	 B8e/pvEePI/Hma8jAokyCOEh2OhN9FUsS84Lcv45a4nSEvLfIHkW7Clb9rOiIWLXZ/
	 oKIXbQ3sU4qJ2Eu5jKeTY79h5XHNjTsJs6uL94mTXEIA9h9A0QIJt2adVR4Vd0wRPw
	 XA9ofTTDbCJzQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 linux-perf-users@vger.kernel.org
In-Reply-To: <20260708200407.1240640-1-namhyung@kernel.org>
References: <20260708200407.1240640-1-namhyung@kernel.org>
Subject: Re: [PATCH] perf stat: Do not open cgroups for BPF counters
Message-Id: <178422111923.3439510.3829638894895339504.b4-ty@kernel.org>
Date: Thu, 16 Jul 2026 09:58:39 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 08 Jul 2026 13:04:07 -0700, Namhyung Kim wrote:
> The --bpf-counters and --for-each-cgroup options use a set of shared
> events among the given cgroups rather than adding events for each cgroup
> respectively.  It only uses cgroup-ID to compare and calculate the
> result.  So no need to open and keep FDs for cgroups in BPF mode.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


