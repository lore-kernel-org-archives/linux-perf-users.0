Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9050941C63;
	Tue,  6 Jan 2026 22:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767740062; cv=none; b=QPUzXo98xe9c7AiOwBqt+q4BTne+sz5D8wHLA+50Zzn37aHeHnLZHXu6CyCqAah+da+pYOqCkS+xtdmksNpyOFtdyrKKIYLoSZij8yOh7e6E86q3xzEwl1XgiHUKcHkN6WEH7tHfdy/4PVi8+ryZZWaf9/DxLh6/0cpuO7xyjsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767740062; c=relaxed/simple;
	bh=fJEzsY4Zbq6o2KYR8vGWlpx1X63WAqJRoMDzAovytXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIddOHByWGC/o/PSlg1GviRr9C01aaKON5/bmb9pRhFosQ5GGXjuCLZhj2aFxk2aUsdCWRwXo9PdplB+sYEIjrkg5MV3CTznQ7uNkRtWwzNU2+PZuv3PRWjSvEmFD03c6H+er6Ytl+S+GEBuNtDwmyLs2NU+d2yvKOlAsjY1bLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YO37Ak2v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO37Ak2v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD443C116C6;
	Tue,  6 Jan 2026 22:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767740062;
	bh=fJEzsY4Zbq6o2KYR8vGWlpx1X63WAqJRoMDzAovytXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YO37Ak2vtXK5FfEUvOZrE5gjOovtYL0lmaiyg2CxCoHBxCvzD63ohnE5sSkikJtwS
	 O3herEcFIfbsh8tSJmPovtL34EKUky4u6aHL0Tfs5zgqv/2Q5Xd5XntxNP8I0FXbOq
	 WwxfscCqtDHvCTI1zzRlWRVbZ18ofLtEbBfPeFwrnkzqUCJFc3apcc5SSEzrhHlBnn
	 6CbybPXkP5BG2Ws4NPyvt3DSOk1NVqJ/jQCkAuvTdLasF9o4o2SQIItWoT3HBI9eDV
	 GEyR8VVjZ5duYGL3/ahVmYCYmsZh47hYs+xhPNsFYO/+9u1vXr95oidM+c9PqZQXkz
	 79wz5Xx7T2hBg==
Date: Tue, 6 Jan 2026 14:54:20 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Faisal Bukhari <faisalbukhari523@gmail.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, thomas.falcon@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf parse-events: Fix evsel allocation failure
Message-ID: <aV2SnF7yV8QUoeeF@google.com>
References: <20250922180834.1744399-1-faisalbukhari523@gmail.com>
 <aV2E7e2Cim8v8Bjm@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aV2E7e2Cim8v8Bjm@x1>

On Tue, Jan 06, 2026 at 06:55:57PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Sep 22, 2025 at 11:38:34PM +0530, Faisal Bukhari wrote:
> > If evsel__new_idx() returns NULL, the function currently jumps 
> > to label 'out_err'.
> > Here, references to `cpus` and `pmu_cpus` are dropped.
> > Also, resources held by evsel->name and evsel->metric_id are freed.
> > But if evsel__new_idx() returns NULL, 
> > it can lead to NULL pointer dereference.
> 
> You forgot to add:
> 
> Fixes: cd63c22168257a0b ("perf parse-events: Minor __add_event refactoring")
> 
> Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Namhyung, I think this should go into v6.19-rc,

Sure, will add.

Thanks,
Namhyung

