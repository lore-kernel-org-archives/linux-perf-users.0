Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BC22D3A7B;
	Thu, 28 May 2026 06:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779948120; cv=none; b=soHvi/vbfIa8UN33koUJhHKR0yg5aj3PV7fmcW7GNSOTA5b2EmyuH8Iix1VO+D/ehrLBVCFVmGF/fmtFXjL8UEeig86hdjmSIBl1kU1OX7okeseGRaZKwv8JZMTOFsydKYjkIGhBswS9rVEGvFl4O+6RVeLTM4kCZ1UGEpcDbhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779948120; c=relaxed/simple;
	bh=Dfs0rkc7BwIjh3zfY7LNfYMDDok5JbpuW/2bfyz7tVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRq8hhWw+eGfUi/ivNcxNw32J7gOR87fuI6EniSDGYDfvreSagUWngmIHM8m3l45UzRPxtpbvyi4Cf+MuhDqBehXmGTcJJo4sVGI/6WF72ZNUnuJsGGEvneBqQtlSLFiUKs6ghLdFEwWF3kCJy/wpQtoQOrfUyawk9fs5HEljkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkX6Cs/2; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkX6Cs/2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779948118; x=1811484118;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Dfs0rkc7BwIjh3zfY7LNfYMDDok5JbpuW/2bfyz7tVQ=;
  b=lkX6Cs/27FCiUjzDKD/QZ2JITCwvWhqhLWv6vqR+0ifmwE+5wPpj6YzD
   GJo9teS3OhXUnEjzZTJPFjjyeaiWP5kArXlh3k7Sernh0ThtxX0O6Rx/7
   wj4UqtbxpwqZPexwT/jYOTCcWKpTd3W1EDh2VWlIrmvKCShoFetrw7QxL
   Jepyt3igR1PabkSH8AhZZHonIyaUlmTt1ctJL4d1b2vUOXq4OA7O/6ubc
   gjb71iKKJu+2D+JrBBrFvxKFuIXpoVxmJrKWrYbRvlAFs2uFWrVoGMVPH
   mnCJKJ7axEoMS7NpqOdYyd3QR8j0w78Tn0YHqb8OF0x31QFJlM721Muso
   A==;
X-CSE-ConnectionGUID: JDFp0p/qSVOh+8Psy3B4hQ==
X-CSE-MsgGUID: 29RwTn/jTsKyqZB5hC7MAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80777205"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80777205"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 23:01:57 -0700
X-CSE-ConnectionGUID: JzFWjWsGQd2JETA1armMug==
X-CSE-MsgGUID: wyJmAyLTTfWa/o8xp0KCew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="272789224"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 23:01:54 -0700
Message-ID: <2f354a07-20e6-46ff-8959-47a107c4d664@linux.intel.com>
Date: Thu, 28 May 2026 14:01:51 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/7] perf/x86/intel/uncore: Fix discovery unit lookup
 for multi-die systems
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260527151154.130505-1-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260527151154.130505-1-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 5/27/2026 11:11 PM, Zide Chen wrote:
> In uncore_find_add_unit(), PMON units with the same unit ID may be
> added to the uncore discovery RB-tree for different dies. These units
> are distinguished by node->die.
>
> However, intel_generic_uncore_box_ctl() uses a fixed die ID of -1 when
> looking up the discovery unit, which may retrieve the wrong node on
> multi-die systems.
>
> Use box->dieid instead so the correct discovery unit is selected.
>
> No functional issue has been observed so far because currently supported
> platforms happen to use the same unit control register for such units.
>
> Remove WARN_ON_ONCE() because with the above change a NULL unit can be
> expected, e.g. when a CPU die is offline during uncore enumeration and
> the unit is not added to the RB-tree. In this case,
> intel_uncore_find_discovery_unit() returns NULL once the die becomes
> online, and it is expected that the PMU box is not functional for that
> die.
>
> Fixes: b1d9ea2e1ca4 ("perf/x86/uncore: Apply the unit control RB tree to MSR uncore units")
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v2:
> - Remove WARN_ON_ONCE().
> ---
>  arch/x86/events/intel/uncore_discovery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
> index 583cbd06b9b8..60e1200c4691 100644
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c
> @@ -481,8 +481,8 @@ static u64 intel_generic_uncore_box_ctl(struct intel_uncore_box *box)
>  	struct intel_uncore_discovery_unit *unit;
>  
>  	unit = intel_uncore_find_discovery_unit(box->pmu->type->boxes,
> -						-1, box->pmu->pmu_idx);
> -	if (WARN_ON_ONCE(!unit))
> +						box->dieid, box->pmu->pmu_idx);
> +	if (!unit)
>  		return 0;
>  
>  	return unit->addr;
