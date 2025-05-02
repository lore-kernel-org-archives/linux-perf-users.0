Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F061C84D9;
	Fri,  2 May 2025 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746203439; cv=none; b=YBIe9yWBpJrvVeU7g3AjMrbloCxqIPNXL+xCW0F9bfq0n3PcuKubhUNx7vwUQecop/3L8Xv6oOfnZw7HI57qbgf3oS3Nk9WHAH41QaePljegwipJgGjRNDG/lx8IMhZtWBHziOM6lFO2V+QxdWsbHSiMxlLabSjhjey7qmMoh+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746203439; c=relaxed/simple;
	bh=b4KW8DRpdIOoOpm5z8Xulzrc1y/zPePgYFJq0Ljb+aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVfFjQry4n5BiW2SqUHLUlriaQeydxe/DExDSEiZ6FUDTl4SeN9L+CKhxSz/UqYjFePxJkAJb/IufySjr1q/LuhJ8dhAwZcMfK72EfaekVMssOxcDngO2S/+buz6RNubENUxxXgQ2UNoMuGJHLbFgCmMlaxc04FkJ7OGrpuUUrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dar82fKs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dar82fKs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29794C4CEE4;
	Fri,  2 May 2025 16:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746203438;
	bh=b4KW8DRpdIOoOpm5z8Xulzrc1y/zPePgYFJq0Ljb+aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dar82fKsqelaAi2SRJbl+RrxrWQY4cFskX2JFj/2pDnLsOcutwSgRVhAl/Et6QfDF
	 HswgQZUzJJGxzWHTcZ5rbd/d3JFKalkewooEb3JuDiRAXu6xCD8D8RX3drXklx3uP+
	 oTysWsjGS5D6z/8GZFX26ck9fVMzQBPJaJJ2h0QikfMnY8WnLLWPnZPSuDBznjnxEx
	 KrjyZPJ4JB+/z7EzdcRFd5TQQuGwhc1lhMjT66A1F0OIJeLPqopMi0/HruMRhkIF4o
	 qLir6Z9AuXa4hIa7d9EATLEjGsFt1jgPes1eyra62TcfPs6+wU/Qzh5a/ZzoeE34GF
	 hdqBCmSdZN3wA==
Date: Fri, 2 May 2025 13:30:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>, Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH 11/11] perf mem: Add 'dtlb' output field
Message-ID: <aBTzK_vZ0kBh9CLV@x1>
References: <20250430205548.789750-1-namhyung@kernel.org>
 <20250430205548.789750-12-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430205548.789750-12-namhyung@kernel.org>

On Wed, Apr 30, 2025 at 01:55:48PM -0700, Namhyung Kim wrote:
> This is a breakdown of perf_mem_data_src.mem_dtlb values.  It assumes
> PMU drivers would set PERF_MEM_TLB_HIT bit with an appropriate level.
> And having PERF_MEM_TLB_MISS means that it failed to find one in any
> levels of TLB.  For now, it doesn't use PERF_MEM_TLB_{WK,OS} bits.
> 
> Also it seems Intel machines don't distinguish L1 or L2 precisely.  So I
> added ANY_HIT (printed as "L?-Hit") to handle the case.
> 
>   $ perf mem report -F overhead,dtlb,dso --stdio
>   ...
>   #           --- D-TLB ----
>   # Overhead   L?-Hit   Miss  Shared Object
>   # ........  ..............  .................
>   #
>       67.03%    99.5%   0.5%  [unknown]
>       31.23%    99.2%   0.8%  [kernel.kallsyms]
>        1.08%    97.8%   2.2%  [i915]
>        0.36%   100.0%   0.0%  [JIT] tid 6853
>        0.12%   100.0%   0.0%  [drm]
>        0.05%   100.0%   0.0%  [drm_kms_helper]
>        0.05%   100.0%   0.0%  [ext4]
>        0.02%   100.0%   0.0%  [aesni_intel]
>        0.02%   100.0%   0.0%  [crc32c_intel]
>        0.02%   100.0%   0.0%  [dm_crypt]
>        ...

root@number:~# perf report --header | grep cpudesc
# cpudesc : AMD Ryzen 9 9950X3D 16-Core Processor
root@number:~# perf mem report -F overhead,dtlb,dso --stdio | head -20
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 2K of event 'cycles:P'
# Total weight : 2637
# Sort order   : local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked,blocked,local_ins_lat,local_p_stage_cyc
#
#           ---------- D-TLB -----------                                   
# Overhead   L1-Hit L2-Hit   Miss  Other  Shared Object                    
# ........  ............................  .................................
#
    77.47%    18.4%   0.1%   0.6%  80.9%  [kernel.kallsyms]                
     5.61%    36.5%   0.7%   1.4%  61.5%  libxul.so                        
     2.77%    39.7%   0.0%  12.3%  47.9%  libc.so.6                        
     2.01%    34.0%   1.9%   1.9%  62.3%  libglib-2.0.so.0.8400.1          
     1.93%    31.4%   2.0%   2.0%  64.7%  [amdgpu]                         
     1.63%    48.8%   0.0%   0.0%  51.2%  [JIT] tid 60168                  
     1.14%     3.3%   0.0%   0.0%  96.7%  [vdso]                           
root@number:~#
