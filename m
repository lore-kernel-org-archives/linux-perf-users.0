Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23437376;
	Fri,  2 May 2025 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746211118; cv=none; b=fw4Rya7MOlAgjyzV9QoryAs5Zs94sVeMfK7yh6d/V4b4T4CHT7P6iF+R97u56JjdHsfxm2YtFEw6CUHdcg5uQI20OvGOcz7WigJXmzJzh4xsNAgYsZmJidZr1XPt41cHu8P2HfQTf005tQFhqP4EyNOXkca6EACjrojKJCwz/oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746211118; c=relaxed/simple;
	bh=mxt/A8uSc/V7U/TI22nd6Tm/RVYbg+4ChVanawz9r48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzjV0vOtOAbn/I8q1ttPhKHrPAjD4iRe5XFcz89KgmDzJb39PcBIWy34kVTEeOG8a0erB13vSPaoVkKnVNxVqPfoG+vXcJj771wWi4x0MfUaKDXJ8ePN3pZ9niX4uyS3fDavveUkYapR0zzoLFEVe7agTWZk4W5JSUySgnHBwgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXYiuFGB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXYiuFGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D21C4CEE4;
	Fri,  2 May 2025 18:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746211117;
	bh=mxt/A8uSc/V7U/TI22nd6Tm/RVYbg+4ChVanawz9r48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXYiuFGBNcb/jYIKb1wr2jq5n3BQ8PVcsJg+q6OVnkW3B+1EQQX+YZkOgY2SUE+Qe
	 5FDaeGQpD59ySTzdsXVWFab7BasoTthAx16qVMLTU4vOOTYLp9z/Y+7DDIjFGdNXl0
	 Jvlvr6W9hSZitCX8DCGooC4G67dfOACrCnGWfKATSYwXT967Gvq0OIHteuJ3Xsukyy
	 cPatRt4+sFbcDLn4KLfh5GhmIwyhhYBFQO7lgGYZAz5OvqpQ2k3RYF1mQHWk7klHJG
	 qjwQSux+5ERrHjwcJ5PR0OicdVzh/pwUPs2fLgja9ZzEy6hlnh+NdH7F8Cz/Mdg9GG
	 WN5c34H8Sjj5A==
Date: Fri, 2 May 2025 11:38:35 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>, Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH 11/11] perf mem: Add 'dtlb' output field
Message-ID: <aBURK58syHRV9Eqx@google.com>
References: <20250430205548.789750-1-namhyung@kernel.org>
 <20250430205548.789750-12-namhyung@kernel.org>
 <aBTzK_vZ0kBh9CLV@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aBTzK_vZ0kBh9CLV@x1>

On Fri, May 02, 2025 at 01:30:35PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Apr 30, 2025 at 01:55:48PM -0700, Namhyung Kim wrote:
> > This is a breakdown of perf_mem_data_src.mem_dtlb values.  It assumes
> > PMU drivers would set PERF_MEM_TLB_HIT bit with an appropriate level.
> > And having PERF_MEM_TLB_MISS means that it failed to find one in any
> > levels of TLB.  For now, it doesn't use PERF_MEM_TLB_{WK,OS} bits.
> > 
> > Also it seems Intel machines don't distinguish L1 or L2 precisely.  So I
> > added ANY_HIT (printed as "L?-Hit") to handle the case.
> > 
> >   $ perf mem report -F overhead,dtlb,dso --stdio
> >   ...
> >   #           --- D-TLB ----
> >   # Overhead   L?-Hit   Miss  Shared Object
> >   # ........  ..............  .................
> >   #
> >       67.03%    99.5%   0.5%  [unknown]
> >       31.23%    99.2%   0.8%  [kernel.kallsyms]
> >        1.08%    97.8%   2.2%  [i915]
> >        0.36%   100.0%   0.0%  [JIT] tid 6853
> >        0.12%   100.0%   0.0%  [drm]
> >        0.05%   100.0%   0.0%  [drm_kms_helper]
> >        0.05%   100.0%   0.0%  [ext4]
> >        0.02%   100.0%   0.0%  [aesni_intel]
> >        0.02%   100.0%   0.0%  [crc32c_intel]
> >        0.02%   100.0%   0.0%  [dm_crypt]
> >        ...
> 
> root@number:~# perf report --header | grep cpudesc
> # cpudesc : AMD Ryzen 9 9950X3D 16-Core Processor
> root@number:~# perf mem report -F overhead,dtlb,dso --stdio | head -20
> # To display the perf.data header info, please use --header/--header-only options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 2K of event 'cycles:P'
> # Total weight : 2637
> # Sort order   : local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked,blocked,local_ins_lat,local_p_stage_cyc
> #
> #           ---------- D-TLB -----------                                   
> # Overhead   L1-Hit L2-Hit   Miss  Other  Shared Object                    
> # ........  ............................  .................................
> #
>     77.47%    18.4%   0.1%   0.6%  80.9%  [kernel.kallsyms]                
>      5.61%    36.5%   0.7%   1.4%  61.5%  libxul.so                        
>      2.77%    39.7%   0.0%  12.3%  47.9%  libc.so.6                        
>      2.01%    34.0%   1.9%   1.9%  62.3%  libglib-2.0.so.0.8400.1          
>      1.93%    31.4%   2.0%   2.0%  64.7%  [amdgpu]                         
>      1.63%    48.8%   0.0%   0.0%  51.2%  [JIT] tid 60168                  
>      1.14%     3.3%   0.0%   0.0%  96.7%  [vdso]                           
> root@number:~#

I guess it's because those samples don't have mem_info as they are not
memory instructions.

Can you please re-run the perf record with filters like below?

  $ perf record -aW --sample-mem-info -e cycles:P --filter 'mem_op == load || mem_op == store' sleep 1

Thanks,
Namhyung

