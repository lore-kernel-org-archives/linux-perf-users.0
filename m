Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AA71E2858;
	Sun, 19 Oct 2025 02:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760842567; cv=none; b=pG9ZczXkvkwZc8zd238KYpcWGjjp1cDEQYsiRNScHk5JTkbSwc9zC07MvbrtrACkoftB+J8K5Y0YboCg5GnhRyqk+1pa2MX+tB9MHdNSmKy8czUgo98fP1aF28NEUTgfop/mmAzRnFUo5+2Wtxp6sdlApYvyQDnj48J/JgFd6XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760842567; c=relaxed/simple;
	bh=ay42bV262rs5q+lQqZEqOICDEow6lIlHBZK9FmNFG0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwORshCFj8VS19w2iIlWx9LYGJnbOPRLEmnt8BUZAVBpIyAYU1w+Ay9ivK8b2GjvEhp5xDNZB794jk8tCVdX3MAv8ZvQxAbA3dMF9mj+dyTqDIZG2QvtgQ7YC7OdetDmTC+B0v1AD/xgLHCYzXy1c/ZLFULKgvydkGZ/mDWYYis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARI5C4Uh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARI5C4Uh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A60C4CEF8;
	Sun, 19 Oct 2025 02:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760842565;
	bh=ay42bV262rs5q+lQqZEqOICDEow6lIlHBZK9FmNFG0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ARI5C4UhGMciK7IPR70DYN0PY4CBPNOw/X20qj7OpeKMPeXASMbej4T1y3wXBl0Tn
	 s/hCF4tKyBMKInDvVKqPpAnqknZDpe7tpBStlrO2BXPFDbhdk+pvMr4j8eHYP+osOJ
	 gA6/ivpI4yhg6IO8jXshqB/TdXhjNPbqKufYPJYSfJiMQoGpO/IIyfkWy/7IPe0h1a
	 6/2BZs9YhkvonhluIva3rAl7apqFeu2QJU/C1RsYIxzSeGPYH86JQ9BrE68KaUBaPE
	 80J9XwtJwvAa1xZEDmJB3LI2reB2K3zFKPMtOx/HzsGrwN6f4Y+ypaW/KECNEfz/wf
	 6Tti4f49r9uMg==
Date: Sun, 19 Oct 2025 11:56:00 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Gautam Menghani <gautam@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] perf ilist: Don't display deprecated events
Message-ID: <aPRTQLcOBtHiTGms@google.com>
References: <20251016222228.2926870-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251016222228.2926870-1-irogers@google.com>

Hi Ian,

On Thu, Oct 16, 2025 at 03:22:26PM -0700, Ian Rogers wrote:
> Unsupported legacy events are flagged as deprecated. Don't display
> these events in ilist as they won't open and there are over 1,000
> legacy cache events.

Off-topic, any chance to integrate this into a perf command?
It'd be convenient if we can call this like `perf list --interactive`
or some other way.

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/python/ilist.py | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
> index 9d6465c60df3..69005a88872e 100755
> --- a/tools/perf/python/ilist.py
> +++ b/tools/perf/python/ilist.py
> @@ -439,6 +439,8 @@ class IListApp(App):
>                  pmu_node = pmus.add(pmu_name)
>                  try:
>                      for event in sorted(pmu.events(), key=lambda x: x["name"]):
> +                        if "deprecated" in event:
> +                            continue
>                          if "name" in event:
>                              e = event["name"].lower()
>                              if "alias" in event:
> -- 
> 2.51.0.858.gf9c4a03a3a-goog
> 
