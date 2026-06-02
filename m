Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613D33403F8;
	Tue,  2 Jun 2026 07:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385058; cv=none; b=dwL7N9RO0eu1j3EtI2AZBlPPn2DzlL5cpaIWcLO7tBQ2oV24/13D/bz2GesRP6rgO9of08cdfgivgdlPjd46TEFuJbFgZFlXN9uM98yq9hDBcJ4PKAbAgGLUtNWufLAdlVLeVptSwHRx5C8hQDbjjpKyjt6TLqs7P/tao6vp+B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385058; c=relaxed/simple;
	bh=A9ROvAc9OIM8BZ0wlpQUy69G5fyRhWBkgwMVc8pzOmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ff4SkZTL6/1be2PGIZxNZEsNuSGJuqfLylkI1SWmybDq+Yo+Bn5U+fQP+eOXzBnzdYoDtcWZjZsWvpwLtfnFbmDYg7JNYg+rZJVOfHfj2IbBMNmgTgB75cQ1WE2Tan2hlwQq29RGfwbXSzNgfZt5vxLXGmFC7FdoYvyEEuQVLU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1OEghbd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1OEghbd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780385056; x=1811921056;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A9ROvAc9OIM8BZ0wlpQUy69G5fyRhWBkgwMVc8pzOmw=;
  b=k1OEghbdrdhvxj2V14JvkQEAvvP4NDsxKF1/RbiiVIfzN3oiQUQnHeOE
   N90KV2oACD9Na8Pw/nNB6BS85beOUxB4Z8SGgzpOftun+Lm/kmSnKJ0de
   s9vyfIMhesPDBDvrDKHnBn2V59c9oWCwE49MZtxKe49W6/FRqeVmuB38D
   ci9Ywj+R8HLOfj1gwsNvrxF1/iygLNDgxln7xv93Phc4egPnzl7Whoq40
   h9C8oNITnAzRbfW0dSYEtrUSKBphSxv4ZmGJ3PZ/eBzeGdF9G4F3U/HsQ
   cAKcnrBJZ8j8vh4KPvRIxG3RH14o2G16S8Mm5YBcaESnZOmNgWib9S/Oq
   A==;
X-CSE-ConnectionGUID: MBbfimuFTQan6m1Up62Z0Q==
X-CSE-MsgGUID: 6veBaOHRSyegQiMonmMJ4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="98581795"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="98581795"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 00:24:15 -0700
X-CSE-ConnectionGUID: eM1kcx//TiOmCU22uB37fA==
X-CSE-MsgGUID: rnEh7ATLRQeXNBzJJhvVQA==
X-ExtLoop1: 1
Received: from unknown (HELO [10.238.1.64]) ([10.238.1.64])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 00:24:12 -0700
Message-ID: <ddf43295-e637-4a65-97e2-0926624776bd@linux.intel.com>
Date: Tue, 2 Jun 2026 15:24:10 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/8] perf/x86/intel/uncore: Fix PCI PMU cleanup on
 setup failure
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260601170114.173359-1-zide.chen@intel.com>
 <20260601170114.173359-2-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260601170114.173359-2-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/2/2026 1:01 AM, Zide Chen wrote:
> When uncore_pci_pmu_register() fails, pmu->boxes[die] is set to NULL
> before returning.  In the uncore_pci_remove() path, this causes
> uncore_pci_pmu_unregister() to be skipped entirely, leaking
> pmu->activeboxes.  In the uncore_bus_notify() path,
> uncore_pci_pmu_unregister() may still be called and must exit early
> when pmu->boxes[die] is NULL to avoid a NULL pointer dereference, and
> to ensure activeboxes is only decremented for a previously active box.
>
> Additionally, since pci_get_drvdata() returns NULL on registration
> failure, uncore_pci_remove() can no longer treat NULL drvdata as an
> indicator of an auxiliary PCI device.  Remove the associated
> WARN_ON_ONCE().
>
> Link: https://sashiko.dev/#/patchset/20260512233048.9577-1-zide.chen@intel.com?part=1
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V2: new patch.
> ---
>  arch/x86/events/intel/uncore.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 7857959c6e82..b69b6a21d46b 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1183,6 +1183,7 @@ static int uncore_pci_pmu_register(struct pci_dev *pdev,
>  	/* First active box registers the pmu */
>  	ret = uncore_pmu_register(pmu);
>  	if (ret) {
> +		atomic_dec(&pmu->activeboxes);
>  		pmu->boxes[die] = NULL;
>  		uncore_box_exit(box);
>  		kfree(box);
> @@ -1248,6 +1249,9 @@ static void uncore_pci_pmu_unregister(struct intel_uncore_pmu *pmu, int die)
>  {
>  	struct intel_uncore_box *box = pmu->boxes[die];
>  
> +	if (!box)
> +		return;
> +
>  	pmu->boxes[die] = NULL;
>  	if (atomic_dec_return(&pmu->activeboxes) == 0)
>  		uncore_pmu_unregister(pmu);
> @@ -1272,7 +1276,6 @@ static void uncore_pci_remove(struct pci_dev *pdev)
>  				break;
>  			}
>  		}
> -		WARN_ON_ONCE(i >= UNCORE_EXTRA_PCI_DEV_MAX);
>  		return;
>  	}
>  

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


