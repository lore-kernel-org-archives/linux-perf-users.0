Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC976192492;
	Wed, 10 Jul 2024 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720617310; cv=none; b=QmxZm28HqYY4FYWvo9gtRCxeRVe6LziJLx1zMpEWDQu10ztfK8s/NW9u4+nq9UjSF+v8zcAoarbM+v3SFxXTAfT99kHK+N+/RXHvOuzGACKOPXDtugmA5sePmwMCPLSXlISVr9MmczamULpqWIYfWGxRqPaAF2+L0D6EPV5QOz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720617310; c=relaxed/simple;
	bh=QqROtBlwIbTLLGVHQb9i+CqPbESJBaurcZ9oTX/Jk/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SutEatKfJn/AbK9ViRbMmtwNDoBp7G51VAy9P3zy+i9I3CV0TkYI82Jme7NkhYQEM1kiuO+TES2Z/C9mlyYZGYginsDSNYYQOAztLmSsuCbz+Pm82Lo0IQMbmpbYCieF54tKvZLY1Q3RxOQtxxEmx26oWheXFpeI6Vy8KdYdN6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mi0MmQFE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mi0MmQFE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720617309; x=1752153309;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QqROtBlwIbTLLGVHQb9i+CqPbESJBaurcZ9oTX/Jk/g=;
  b=mi0MmQFEhXE0BxsrYOAzEm49nF9XF94rR9mwtvJrYV3o+xkB/lp5ibUu
   4QRbUd3Rb+lFpT6GgFeWeIKM59RXW9Wi7qNia+hVdJVx9UozUsuBfwCAN
   jP88xAVTMurCzpvZ1PAXfv+0fiGowKkiTYO2Vs/KH+bwbXM2DUBN9M61r
   s9Qe7s8K0Ctn2g/hdOKMAm3hmetw+ReX5UHbGAnRGXw6ErCJ7Bb5aRUsr
   lbZLgsUfCVD42NjXUxPugUsQIzg9+X6baZBf6Duw1lrWULrVGozs5ovS9
   F6INT/F6+1UanC/CTuhCDVwnI593EcrEB06Iser0SvnZSjA8f30q3CgMo
   A==;
X-CSE-ConnectionGUID: TNGWco4QTxq5+ubrKs3PCQ==
X-CSE-MsgGUID: HvC3B+IUT7iKKcDd3Udp+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="20840264"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="20840264"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 06:15:08 -0700
X-CSE-ConnectionGUID: bCHm0/F/Q4WgbKzFPP11sg==
X-CSE-MsgGUID: 9lkXQ7MjRMmArgSvJof8OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="53012361"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 06:15:08 -0700
Received: from [10.212.47.151] (kliang2-mobl1.ccr.corp.intel.com [10.212.47.151])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id B49EF20738FE;
	Wed, 10 Jul 2024 06:15:06 -0700 (PDT)
Message-ID: <a0ac56fc-eedc-492b-884c-d68e0460f178@linux.intel.com>
Date: Wed, 10 Jul 2024 09:15:05 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [perf vendor events] e2641db83f:
 perf-sanity-tests.perf_all_PMU_test.fail
To: kernel test robot <oliver.sang@intel.com>, Ian Rogers <irogers@google.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
 Linux Memory Management List <linux-mm@kvack.org>,
 Namhyung Kim <namhyung@kernel.org>, Weilin Wang <weilin.wang@intel.com>,
 Caleb Biggers <caleb.biggers@intel.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202407101021.2c8baddb-oliver.sang@intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <202407101021.2c8baddb-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-07-10 12:59 a.m., kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "perf-sanity-tests.perf_all_PMU_test.fail" on:
> 
> commit: e2641db83f18782f57a0e107c50d2d1731960fb8 ("perf vendor events: Add/update skylake events/metrics")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master 82d01fe6ee52086035b201cfa1410a3b04384257]
> 
> in testcase: perf-sanity-tests
> version: 
> with following parameters:
> 
> 	perf_compiler: gcc
> 
> 
> 
> compiler: gcc-13
> test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake) with 32G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> we also observed two cases which also failed on parent can pass on this commit.
> FYI.
> 
> 
> caccae3ce7b988b6 e2641db83f18782f57a0e107c50
> ---------------- ---------------------------
>        fail:runs  %reproduction    fail:runs
>            |             |             |
>            :6          100%           6:6     perf-sanity-tests.perf_all_PMU_test.fail
>            :6          100%           6:6     perf-sanity-tests.perf_all_metricgroups_test.pass
>            :6          100%           6:6     perf-sanity-tests.perf_all_metrics_test.pass
> 
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202407101021.2c8baddb-oliver.sang@intel.com
> 
> 
> 
> 2024-07-09 07:09:53 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 105
> 105: perf all metricgroups test                                      : Ok
> 2024-07-09 07:10:11 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 106
> 106: perf all metrics test                                           : Ok
> 2024-07-09 07:10:23 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 107
> 107: perf all libpfm4 events test                                    : Ok
> 2024-07-09 07:10:47 sudo /usr/src/linux-perf-x86_64-rhel-8.3-bpf-e2641db83f18782f57a0e107c50d2d1731960fb8/tools/perf/perf test 108
> 108: perf all PMU test                                               : FAILED!

Can you please try the -vvv option, which should tell the failed event?
perf test -vvv "perf all PMU test"

Thanks,
Kan
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240710/202407101021.2c8baddb-oliver.sang@intel.com
> 
> 
> 
