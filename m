Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3BF3D967A
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998564; cv=none; b=rflOcITxRnqHDUX7cl/3tyAhGhSgg8mImxBrOZvc1xCURttQGVnB8+pJLskIrPJMNyhMRWE3769NEm9+MXAboUQLoxxjnOOvcY215NJU1Bhg3MI56v6xb7d3YEamx+O++376nuxz9M/sbaJm4vRb4rPQTeGBBRYecKNP7Pvuna4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998564; c=relaxed/simple;
	bh=phdtJNTQWC96uIuARoZ4xWUGydl4LKMX/SYCP1rw5k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjIdxlIs7Om800fqD/QpAQmqW38X0l+ChTeeQ6ptYrRVa7Ebu5OLIvdHYtJrgLJ78S1TaZ2Jt4iYc2OMJBlJlGN3nLlpX71He0fULRj4cdgP72cfkCuLrL0i1olLoAPjvGCf+yKNg5m3UAEn4mPXsi5fDCVYz2sFedILw6SDGkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ai4tk0XM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ai4tk0XM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780998562; x=1812534562;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=phdtJNTQWC96uIuARoZ4xWUGydl4LKMX/SYCP1rw5k0=;
  b=ai4tk0XMcp+dCpl7/o3fiE0wIbEdnOkgQ5CBGV3ffltfJ1YXge387efu
   ObzpSBTv9GXyKQ70w4EToZd2B/SOPSEbsnilkawyeZYBEhZSNlMABPaVW
   3OrDBG6Xh9mgGtgWUkvXI6bFC7w0U55XhOvFNUvZb31CnReB360udt7fp
   d8xZi8oehsjyBQNgE80NBxo/fQsDZwWuNRQjylCBW7Nq+btMt7ImW/L+P
   O//inuhHRxmp1we4MWrFd8Ej7xQ3u6uJ++opp53WvXJh8BN6i6XJjqsuu
   /cLuBbGRi0ATQ41d9XVfX420GSXxMPiSAmkBBceYTlT9pVBIAyHOeJBy7
   g==;
X-CSE-ConnectionGUID: nDJ9mveYQXO06Qf+4+Kx/A==
X-CSE-MsgGUID: b61vWEzeSDCeTgdWA1wMpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="104418279"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="104418279"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 02:49:22 -0700
X-CSE-ConnectionGUID: AHIwObfnTYuaO3KqmMtc6Q==
X-CSE-MsgGUID: pl+CDBHNQGejFiTAKA8ZtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="245913352"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 02:49:21 -0700
Message-ID: <4834851e-0a08-4120-8ebe-b0efc19e6788@linux.intel.com>
Date: Tue, 9 Jun 2026 17:49:18 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 9/9] perf/core: Check kernel access when kernel
 callchains are requested
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260609050222.2458129-10-dapeng1.mi@linux.intel.com>
 <20260609052411.1CCD61F00893@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260609052411.1CCD61F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/9/2026 1:24 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] The patch breaks `perf record -g` for unprivileged users with existing `perf` binaries.
> --
>
> commit ac223ffdf5e79c1aa96a91deecdff94004bbe30f
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/core: Check kernel access when kernel callchains are requested
>
> This commit updates perf_event_open to verify kernel access permissions
> when kernel callchains are requested, even if exclude_kernel is set.
> This is intended to prevent unprivileged capture of kernel callchains.
>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
> [ ... ]
>> @@ -13904,7 +13904,9 @@ SYSCALL_DEFINE5(perf_event_open,
>>  	if (err)
>>  		return err;
>>  
>> -	if (!attr.exclude_kernel) {
>> +	if (!attr.exclude_kernel ||
>> +	    ((attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
>> +	     !attr.exclude_callchain_kernel)) {
>>  		err = perf_allow_kernel();
> [Severity: Critical]
> Does this change break perf record -g for unprivileged users using
> existing perf binaries?
>
> When an unprivileged user runs perf record -g, the initial syscall
> request fails with -EACCES. The perf tool's existing fallback logic
> retries by setting exclude_kernel = 1, but it leaves
> exclude_callchain_kernel = 0.
>
> Because this new check enforces the privilege requirement for callchains
> even when exclude_kernel is set, the retried syscall will fail a second
> time with -EACCES.
>
> Looking at the perf tool's fallback handler:
>
> tools/perf/util/evsel.c:evsel__fallback() {
>     ...
> 	} else if (err == EACCES && !evsel->core.attr.exclude_kernel &&
> 		   (paranoid = perf_event_paranoid()) > 1) {
>     ...
> }
>
> Since exclude_kernel was set to 1 during the first fallback, the tool
> cannot handle the second -EACCES failure. Will this cause the tool to
> abort entirely with a permission denied error rather than falling back
> to user-only callchains?

Yes, this is the expected behavior, we need the similar fallback for
exclude_callchain_kernel attribute. The perf tools patch would be posted
separately.

Thanks.


>
