Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFE079945;
	Wed,  7 Aug 2024 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043968; cv=none; b=Rwl7xV3wfsrrIqmzJPpiEdEt2kuMmjIK3VTacOqDuPv7KFSHglEEXntsq5gE7HWxKCys/ARIf/jiUmhP58aq8Hy5XJzWn9+m/YwlOUCPYjaueya736VXnwcUkiGTKQKvnb92RQ4KBP8NEBVvnxNTpRDZDbvJ9L2bAFNO7zafCBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043968; c=relaxed/simple;
	bh=H9uirerAjlrbXHWwHjRISmeI1bhKgb+jLbNxkCJr9cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+dzJPGJWOuWr8RdhQJa8IvCXbMm5XQKhWIEL/EpnQXsmXtXTnLMR6p0Jaz8gELrAxrRkKNkbGDCkxg+l/L+ay9xLkf/dZyfl0oebkovs6GdQfUsRlyFAI31kxPmMu3xvbMO/J0bkj6YM7p5JU7oMYmviqcpQaDpktgYF9I5M0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ECB15rtQ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ECB15rtQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723043967; x=1754579967;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H9uirerAjlrbXHWwHjRISmeI1bhKgb+jLbNxkCJr9cY=;
  b=ECB15rtQrHr/Pj8P0eAAXq7iWHGoLY6aN0oKzOwK8VWzpCkMfR4mbgpL
   m/Ps5MHrQXg8HHFPJ3AKAkkABdZQhvplblcVpnShZjHlsTOn/3GM02KZT
   AOQu8Xj/6S+zbGhaKBjh+o6JXRmlHXGdBIbhwD0N0Ixz7be0d/hnP/viz
   8yuyuHNa6Y1DbTjcO7pqtoUsCkIX01wzcrD1tutn0uD2UDdgjB/Gx9QrS
   Y3SFrmx9iwlj3ulDM4ZyT2mAsUiY+nxhOf6G/rEhswk9l/ad1BgyBJod+
   QfVGm3nJM2c77t7cewRrgUewb/IX0b+PjeP6RAfhzlSoMBZZBdYCrF98G
   Q==;
X-CSE-ConnectionGUID: rd4RENwsSQqheq7TVyd/Xw==
X-CSE-MsgGUID: /AMX3bhlScawU5ibN3riyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21092142"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="21092142"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 08:19:26 -0700
X-CSE-ConnectionGUID: mHINKmwnRsOskRxFjzYdDA==
X-CSE-MsgGUID: JmY74sp/S0KbvBBhovh8Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="61537980"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 08:19:25 -0700
Received: from [10.212.63.105] (kliang2-mobl1.ccr.corp.intel.com [10.212.63.105])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 972C620CFED6;
	Wed,  7 Aug 2024 08:19:23 -0700 (PDT)
Message-ID: <2a32a538-b86c-40ec-8b85-17f793c0bfac@linux.intel.com>
Date: Wed, 7 Aug 2024 11:19:22 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] perf: Per PMU context reschedule and misc
To: Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240807112924.448091402@infradead.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240807112924.448091402@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-08-07 7:29 a.m., Peter Zijlstra wrote:
> Hi,
> 
> This is 'fallout' from Namhyung posting his per-pmu ctx_resched() patches. It
> started with me trying to clean up and get rid of corner cases, and then got
> involved when Kan noted the time keeping issue.
> 
> Anyway, please review / test.
> 

Except for the tiny nit, the patch series looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
