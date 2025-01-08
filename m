Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502FA202C4A;
	Wed,  8 Jan 2025 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736368904; cv=none; b=o0IOZCgEgsh7kXo5+KHMsaSqimPfwtSUH+ew51dvIM/iOjfzEDmVP+cKy6rTvb58dDTm6gIAZoUiR+wb8VntVdQs5kyjbsFBAPRnIbPaL3X34ItVJanbpArN3ZDH+WgSiHmxRNb17/I5vSOVn4ZvtAPO4CdBNNFFzGlTf6jHYLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736368904; c=relaxed/simple;
	bh=XEpnnui6NvwA25n973GQ5ti8H5Mxr9NWbS95eJPfEXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lD5CzfuWpFRgJmvczWE8XjemGXZ4KFU7QDp/X/89gfSfsysWOk7vy8eXdHZMjkJIT+1zyyvzyRwY9xjfca4RfniciCDoZVHlCabBMafJXlIrZ4+Xwt92S8ujIkyKeOX/Ny98bmD5kGYsQ6YBJBM+ty6VoU5Jz/55PgV0IUkH81w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IP3lOvVM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IP3lOvVM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545F9C4CEDF;
	Wed,  8 Jan 2025 20:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736368903;
	bh=XEpnnui6NvwA25n973GQ5ti8H5Mxr9NWbS95eJPfEXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IP3lOvVMb7wkGGYucZV8jX8mAM+1WagpujdVUhSZdhATeb2t5L0aVaoKHAeJAtQZ7
	 MzNgY2wOedy7OpIN1FGGA3WkRz1clOQMiD+OfdFEQPoBVqIBZaoWqoAgE4kFTUSFtE
	 2FooDkleUtVs+7Gku8A92+03UmNB99TiNO/hc3kEmP7+ST+GQxzsUM07YfINH5cTYR
	 nysele/BIkB5nKGEikcITYQWjgu0KrI/Oh7E3A8BJrfdz98UoIHR16YoKGpqc+gr/O
	 XtLmiy9pBd3JVKQsIFjD/hxszn1xtUT+ut/ErUcg5XKeJE2YsNldwgR1f9Lk848/fa
	 uPUNVSvTBIFzg==
Date: Wed, 8 Jan 2025 17:41:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test cpumap: Avoid use-after-free following merge
Message-ID: <Z37jBKAdWNmWMPi6@x1>
References: <20250108051511.1720369-1-irogers@google.com>
 <ac163e57-1bf8-4662-920c-9dbfecb26c06@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac163e57-1bf8-4662-920c-9dbfecb26c06@linaro.org>

On Wed, Jan 08, 2025 at 03:07:53PM +0000, James Clark wrote:
> 
> 
> On 08/01/2025 5:15 am, Ian Rogers wrote:
> > Previously cpu maps in the test weren't modified by calls to the cpu
> > map API, however, perf_cpu_map__merge was modified so the left hand
> > argument was updated. In the test this meant the maps copy of the
> > "two" map was put/deleted in the merge meaning when accessed via maps,
> > the pointer was stale and to the put/deleted memory. To fix this add
> > an extra layer of indirection to the maps array, so the updated value
> > of two is accessed.
> > 
> > Fixes: a9d2217556f7 ("libperf cpumap: Refactor perf_cpu_map__merge()")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks, applied to perf-tools-next,

- Arnaldo
