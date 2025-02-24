Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00A020C47C
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Feb 2025 23:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740441431; cv=none; b=dJNwNRnFaduzMoZLxbDdF2/iupRWcBGbqPoUmrfNPItW5MnEOFbmX8l4aj+wnzal4R73VM7Dtvass7VCzpNLk56y/63AhGFS/QQ/P6+ObSl4zAqxM5TLNC/A/k5xlSpG7Daa+E6c4m87hdtUHC9PGFG0xZM9HXDqtOPve2XwjuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740441431; c=relaxed/simple;
	bh=aw13VvD94sbikFhykj+GstmOsLfjM5bNCVdQksmMjOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItetB7sF07JlFUXEJPTSqvx6OovPqbWkeKFAWLvxeSqA5+8qkAY14SOIlxVpslQov2nz+NPN2GohF9onGfUS9IqnTP022M60A07iwIIbsDwIPs01jUs/bcSbyHdF1NgzlQ3qHhbUBw2B+adJMnBG/UhACdHCkKMC29eC/JiVptA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVpejxiZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVpejxiZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB22C4CED6;
	Mon, 24 Feb 2025 23:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740441430;
	bh=aw13VvD94sbikFhykj+GstmOsLfjM5bNCVdQksmMjOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NVpejxiZlZxsBFG8KglmXHrb7CAF06Zv4GgvygvJri8sRQFp+qJMWRBjqoXDLYM3e
	 Z66U5N1Oh8/E2xC/mA/L/eb+jJP2h3fao7E4uyx3dy4fhqJ2d6kNfnLshdEPdYw4nC
	 qwVBKGcRbY0o2XosABeQx2LIpNt0XlZ4aXE5u7Tj1LxURW6wjCGg9g5k1nnJYRcDuj
	 XeIGtli5vXelJ7n6mpWFjNlmF4pXngBmMfz4UIkb7dVLoejMIIbO6Uv6UrQZLoynF/
	 pwLqRuY6lsPGy9nhbCHXxwkQkpUwauEd+CzmmQl/CBWHVuJKuPdSXoWH/7LsMatZu0
	 7NcQRW4bjaBHQ==
Date: Mon, 24 Feb 2025 15:57:07 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>,
	Ian Rogers <irogers@google.com>
Subject: Re: perf record question regarding grouped events
Message-ID: <Z70HU3obg1ZHeutj@google.com>
References: <e2c7e654-5608-4206-ab3a-2a63b54cbc35@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2c7e654-5608-4206-ab3a-2a63b54cbc35@linux.ibm.com>

Hello,

On Wed, Feb 19, 2025 at 11:57:46AM +0100, Thomas Richter wrote:
> Hi all,
> 
> I have a question on the intended usage of the grouped events as
> in test case 114 perf record tests subtest 'Basic leader sampling' test
> where this command is executed:
> 
>  # perf record -vv -e '{cycles,cycles}:uS' -- ...
> 
> In the debug output the following 2 event are installed:
> 
>  ------------------------------------------------------------
>  perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
>   read_format                      ID|GROUP|LOST
>   disabled                         1
>   exclude_kernel                   1
>   exclude_hv                       1
>   freq                             1
>   sample_id_all                    1
>  ------------------------------------------------------------
>  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>  ------------------------------------------------------------
>  perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             136
>   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
>   sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
>   read_format                      ID|GROUP|LOST
>   exclude_kernel                   1
>   exclude_hv                       1
>   sample_id_all                    1
>  ------------------------------------------------------------
>  sys_perf_event_open: pid -1  cpu 0  group_fd 5  flags 0x8 = 6
> 
> What puzzles me is that the first event with file descriptor 5
> is installed for sampling. The second event with file descriptor 6
> is installed for counting because event attribute members
> attr::freq and attr::sample_freq are zero.
> 
> So of the 2 cycles events installed, the group leader is sampling
> and the other event is counting.
> 
> Is this understanding correct?
> The test then checks if the number of samples matches the count
> from the counting event?

Yep, the syntax '{event1,event2}:S' is for group leader sampling which
reduces the overhead of PMU interrupts.  The idea is that those events
are scheduled together so sampling is enabled only for the leader
(usually the first) event and it reads counts from the member events
using PERF_SAMPLE_READ.

So they should have the same counts if it uses the same events in a
group.

Thanks,
Namhyung

 
> Thanks a lot for your help.
> 
> -- 
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
> --
> IBM Deutschland Research & Development GmbH
> 
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
> 
> Geschäftsführung: David Faller
> 
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
> 
