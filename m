Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F353019AA;
	Fri, 21 Nov 2025 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763755378; cv=none; b=pAQFdw63pqfBc21IThAiKhyzmaaoWd7P5wDHeA4z7DWGBJ7UKWZhZroL5xwbmQRblHK6zgyBqDYVlStmZ+UJVlh179cq3GbCPNYBvBuir8c3rprf1cujyB0inAnSVF+f+yfgSNAGEQQ0CKhChZkbT7LcPsWhveKzTAqGUeF6RQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763755378; c=relaxed/simple;
	bh=9VbdDE2Gv+mv6l9/nxsXC285N+KUj6lAxX8eWoqaGYs=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=adidv7+Yc8pF9NJGcacOzRqScTryrWTDF0yhEB0UbLpEfdJ+iCZwbdW5LJSNXnzcPzbao1LXovlnIiUP6Nw5klzo4o3IVY8ItLUqBYjs50CXeEWXCqWHG3icI1Bv6AZ4Ecka7FCGnUIF48bwhGshgEqo112M8CyzQEVcDg4Olvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMWVaF62; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMWVaF62"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5778C4CEF1;
	Fri, 21 Nov 2025 20:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763755377;
	bh=9VbdDE2Gv+mv6l9/nxsXC285N+KUj6lAxX8eWoqaGYs=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=qMWVaF6250p4eB54vomBAS5iWX5rtpfGpZsneaoDhxxs6z1s5xCMi0Eo09Ozt9+Qd
	 BIPLKi0SgmGImYoisTrzIKfokd5N1x7k4wPuG3kT/ujDh0aPABu2+8H3HtF3OsK6o3
	 UJMHkruRiwUiWwjVIyLTh9vv26WAFoIW2wu8UxbmIsouktiMVbudT1/Fsck3QEebDH
	 NX3t9Lu9UtZnVdbXlnU97TCWMSwo7IwrlxIKe3mDWm72sBA2fcsFS0iL3QQ6L7E0St
	 9V02nsxXzZ3a8vbEp3eHUQeYFG+Zs3D9Yh7HYxV1dNhp5I6wnUYQxWvUe3wOekFIhl
	 YWH2v/DrhewvA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, 
 Thomas Richter <tmricht@linux.ibm.com>, Ian Rogers <irogers@google.com>
In-Reply-To: <20251119193047.2238095-1-irogers@google.com>
References: <20251119193047.2238095-1-irogers@google.com>
Subject: Re: [PATCH v1] perf test all metrics: Fully ignore Default metric
 failures
Message-Id: <176375537661.3973666.331008551300328286.b4-ty@kernel.org>
Date: Fri, 21 Nov 2025 12:02:56 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 19 Nov 2025 11:30:47 -0800, Ian Rogers wrote:
> Determine if a metric is default from `perf list --raw-dump $m` eg:
> ```
> $ perf list --raw-dump l1_prefetch_miss_rate
> Default4 l1_prefetch_miss_rate
> ```
> If a metric has "not supported" or "no supported events" then ignore
> these failures for default metrics. Tidy up the skip/fail messages in
> the output to make them easier to spot/read.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


