Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C671FF1A0;
	Tue, 27 May 2025 10:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748340777; cv=none; b=bTvVI8KrSkl7/NBEog4/VF7/JVFwxZOGF+uIPAMfgRu3uv570StZLAJPyc+FRuacWiCbrzA4Yo8wm2T7tjLPeIliFQceN7SVvVdZGvmO3z4hPhqFg/5ULiIAxk1kneovfv4xzK3hnwbWrLGvQkOEJvU7Lu8Cp/h9PmNEM3qzzIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748340777; c=relaxed/simple;
	bh=ApCfWdY+JdAxG4XoYj79NdIh5DdFSANb3DdVg0jYXVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8Hbxy7pHxVQlSSkk4FkI8ymUtHkoKX8YrYmJvE5JTEkhrg3WMmouTdV4gHxdU6vfgL1gHOXhy15VaJzIZkTw4IfdrS/qt/h6JL6m01ltYxQMAn0uDGA5OyTV6WsYZaCfKZHGoA8dERxwO5ahqMFzDeMMzgagsBxC3F8mjCQr/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5F0D14BF;
	Tue, 27 May 2025 03:12:38 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 732773F5A1;
	Tue, 27 May 2025 03:12:54 -0700 (PDT)
Date: Tue, 27 May 2025 11:12:46 +0100
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/3] perf mem: Describe overhead calculation in brief
Message-ID: <20250527101246.GG2566836@e132581.arm.com>
References: <20250523222157.1259998-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523222157.1259998-1-namhyung@kernel.org>

On Fri, May 23, 2025 at 03:21:55PM -0700, Namhyung Kim wrote:
> From: Ravi Bangoria <ravi.bangoria@amd.com>
> 
> Unlike perf-report which uses sample period for overhead calculation,
> perf-mem overhead is calculated using sample weight. Describe perf-mem
> overhead calculation method in it's man page.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

For whole series:

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
>  tools/perf/Documentation/perf-mem.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
> index a9e3c71a220557d4..965e73d377724607 100644
> --- a/tools/perf/Documentation/perf-mem.txt
> +++ b/tools/perf/Documentation/perf-mem.txt
> @@ -137,6 +137,25 @@ REPORT OPTIONS
>  In addition, for report all perf report options are valid, and for record
>  all perf record options.
>  
> +OVERHEAD CALCULATION
> +--------------------
> +Unlike linkperf:perf-report[1], which calculates overhead from the actual
> +sample period, perf-mem overhead is calculated using sample weight. E.g.
> +there are two samples in perf.data file, both with the same sample period,
> +but one sample with weight 180 and the other with weight 20:
> +
> +  $ perf script -F period,data_src,weight,ip,sym
> +  100000    629080842 |OP LOAD|LVL L3 hit|...     20       7e69b93ca524 strcmp
> +  100000   1a29081042 |OP LOAD|LVL RAM hit|...   180   ffffffff82429168 memcpy
> +
> +  $ perf report -F overhead,symbol
> +  50%   [.] strcmp
> +  50%   [k] memcpy
> +
> +  $ perf mem report -F overhead,symbol
> +  90%   [k] memcpy
> +  10%   [.] strcmp
> +
>  SEE ALSO
>  --------
>  linkperf:perf-record[1], linkperf:perf-report[1], linkperf:perf-arm-spe[1]
> -- 
> 2.49.0.1151.ga128411c76-goog
> 
