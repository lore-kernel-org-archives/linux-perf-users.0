Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB6E4C9D;
	Wed, 26 Nov 2025 05:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764134753; cv=none; b=E9vFG/yjbkbb9WorZo773hdHdSKSlWlc55zPc8bYmJxN5e49KJotTLET2vq0PNNX8ACpTiJDUkRFtNh4y438VRhXu4z8EUT00mwc0Lo8LmgvYL8hw6zksX5wq8TpNQ6AjmF263J5be+OqTE0dIVH1dd1gMUgX84odcw819VBvg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764134753; c=relaxed/simple;
	bh=QvKs05qgSxAdcaLq4QTYrOeZbDmKNvtW1gI9bc3zi9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LrRxN1Q7rziKNNVt4ODVqFag5Gw6f6HF+FX/bf+L0OEDAG9uYV4YnCxTUwRQH1YSs97KXNJ7aPcQB/nZf0jCU4vYcwVUmstTZ5x7AOcj5b3OxXXnjMY85qBWbQC49zVlHBvq2eCTZNvEJCBuc+8OYrwc0Eu++XGqbl2EZmRUUao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ftxrv/R8; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ftxrv/R8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764134752; x=1795670752;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QvKs05qgSxAdcaLq4QTYrOeZbDmKNvtW1gI9bc3zi9A=;
  b=Ftxrv/R832PRItP1rd+/rzpqCOz1Ug5nSIyENf/8G3SSjm8nJXDGn8K9
   AXAgTv1KUdkAl7DPCS7t+I9Zh69wOEIu7IHjEykzKeh+eoiRDhOaYDj+W
   oUmujp8D3B9Ud8CxsRoSGjcTDVEDNQDTkx3djpYEh3j32hLLWpxD1rT12
   oradJfxjHh6UxmxkFu8alxsiZ2F4DXUdCK8y2JfWLRPfULo2FvjE/OZLZ
   UmSWKlh4WEfdgjiUibOxneMEDR6Fe9CWlxKRAmb3Fqvsk6F4lVHd6sRWK
   A9gJDJGjGZj+G/skexW55J2fhIjZqnoZcFwmYJ+8y6QHxFVYm8Evja2zJ
   A==;
X-CSE-ConnectionGUID: RCLDl5cWTrCe5onRpHYceg==
X-CSE-MsgGUID: 9H6j0z+1Qhyi76bz9XYo8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="66109868"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="66109868"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 21:25:51 -0800
X-CSE-ConnectionGUID: emkL6qnXSrWp+RWKazh5hA==
X-CSE-MsgGUID: 53XHgUlhQQevJJqDVze6tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; 
   d="scan'208";a="197318733"
Received: from unknown (HELO [10.238.3.127]) ([10.238.3.127])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 21:25:49 -0800
Message-ID: <d47f257a-a71f-4063-8918-8f4d8a9b814d@linux.intel.com>
Date: Wed, 26 Nov 2025 13:25:46 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/44] perf: Fix branch stack callchain limit
To: david.laight.linux@gmail.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
 <20251119224140.8616-4-david.laight.linux@gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251119224140.8616-4-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/20/2025 6:40 AM, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
>
> The code that bounds the brs->nr to event->attr.sample_max_stack
> incorrectly masks brs->nr with 65535 before the limit check.
> Replace the min_t(u16, ...) with a plain min(...).
>
> I guess there may be another limit on brs->nr (which is u64).
>
> Fixes: c53e14f1ea4a8 ("perf: Extend per event callchain limit to branch stack")
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>  include/linux/perf_event.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index fd1d91017b99..f91c875ea311 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1430,7 +1430,7 @@ static inline void perf_sample_save_brstack(struct perf_sample_data *data,
>  	if (branch_sample_hw_index(event))
>  		size += sizeof(u64);
>  
> -	brs->nr = min_t(u16, event->attr.sample_max_stack, brs->nr);
> +	brs->nr = min(event->attr.sample_max_stack, brs->nr);
>  
>  	size += brs->nr * sizeof(struct perf_branch_entry);
>  

LGTM. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


