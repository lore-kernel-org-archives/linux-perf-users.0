Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41F4145A18;
	Wed, 28 Aug 2024 05:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724822197; cv=none; b=kymSyKALle0pcbTM8A3uAQD4rurncvtYPQZxxCcY5GkSfXBCyBHwnw8f4yNAYh72hPQFC2JRzIn+LvEdxNxggwigakEFT8MmlsMIB87Jovw1vQZVDEXJZcS2x0pelx7thD7oj0FTUX8cyvYTAsbsQNwevGZG8unRAQpbwiisOpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724822197; c=relaxed/simple;
	bh=uQ4zHhOASLf5+tQUdvE7W1/GxJn6R2hEG5FvZy+cLF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpdnEGHpNZK0mVhkU31bsWngZ5insLUUfcjjKqkgeQykSaDfNh5Yk564gytj+7evMyvGQZJGHiQ3oBbHX+wOv8yD4p5WSIjh4E6A321051if9crIs+7UYByQMwXbZotCElIWuphLyGntv1yjv0JWBgLsuC3ROMDPP8zeeawlOrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=depymiI0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="depymiI0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724822196; x=1756358196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uQ4zHhOASLf5+tQUdvE7W1/GxJn6R2hEG5FvZy+cLF4=;
  b=depymiI0bFuW+jd2AZTjbYrrfx+th8xzIoDMwfb34EqbXUgtCXuaWtaU
   mv+peKEQRexmyefa48Tsn92aPY6nk4kJIBzXm/AHnVDOYETeCykV+ErKL
   KsUDvNu8001OQhU7/e6tkZ8DS+qqF1TfwvA22WkDPStulIeToLtwS87/R
   0+zG0oML+Lo6kmnfzMgnR+niU01kG1IHwp7hYsF9C4WST3T+CwbOymmQW
   dK5IMQiaMfwKLfY+IKcZ1JFCvcqmvvEuEJhqFRHFlVqAex2w4uYE5h5lC
   BIhcgxNQdXnXWsuup4NpDvFoRiNaxpUj3YDSu261LU36ZtkQ4OL/ZeBdA
   Q==;
X-CSE-ConnectionGUID: Op5vOUlsRHCj/aPC7s/6Xg==
X-CSE-MsgGUID: 2BNIXkzNTaOtd8xVwXLjVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="40805355"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="40805355"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 22:16:35 -0700
X-CSE-ConnectionGUID: iyONb+z2Qq+g9wVeNiYrog==
X-CSE-MsgGUID: hZyHfb87S9++pIFxUtKPxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="67917350"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 22:16:35 -0700
Date: Tue, 27 Aug 2024 22:16:31 -0700
From: Andi Kleen <ak@linux.intel.com>
To: James Clark <james.clark@linaro.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Ze Gao <zegao2021@gmail.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] Event parsing fixes
Message-ID: <Zs6yrwmn-rJWWaCr@tassilo>
References: <20240822132506.1468090-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822132506.1468090-1-james.clark@linaro.org>

> There is one small difference where it now shows "stalled-cycles-..."
> as <not supported> events, when before it just didn't show them at all when
> they weren't supported:
> 
>   $ perf stat -- true
> 
>   Performance counter stats for 'true':
> 
>               0.66 msec task-clock                       #    0.384 CPUs utilized             
>                  0      context-switches                 #    0.000 /sec                      
>                  0      cpu-migrations                   #    0.000 /sec                      
>                 52      page-faults                      #   78.999 K/sec                     
>      <not counted>      cpu_atom/instructions/                                                  (0.00%)
>            978,399      cpu_core/instructions/           #    1.02  insn per cycle            
>      <not counted>      cpu_atom/cycles/                                                        (0.00%)
>            959,722      cpu_core/cycles/                 #    1.458 GHz                       
>    <not supported>      cpu_atom/stalled-cycles-frontend/                                      
>    <not supported>      cpu_core/stalled-cycles-frontend/                                      
> 
> I don't think that's a big deal though and could probably be fixed up
> later if we really want to.

I would prefer if that was fixed up. That's quite ugly for the default
view on x86/Intel.

-Andi
