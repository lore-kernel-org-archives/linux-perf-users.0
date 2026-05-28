Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BFF2FD1B1;
	Thu, 28 May 2026 06:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779950074; cv=none; b=B1w1cdmBILei9o5AsUyMT0rB+GK/01OFH1AxZpzkrlTdSTtXLJOyQIX9wjIbxj4LhK7CvaJR+uFHOqOQ8rUj6AgJz/+quQExsM7RSMPggoMMe6CfWLzpVCgL+gnB0J1Rs0keXLwjc/LSSS9EUmDx08HHhpj3qHvYOtkegVfeZsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779950074; c=relaxed/simple;
	bh=8VipYLA4X5TG4DGREGYl6oczIgMJh/79bXPLfKHSkW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCaG4F7110+aCXUYXGfrIgne7QhrLAan7zT/nnWAB/2HQupxmL3Ug12iH5wDEkj53OAk4vXe4SnN02xXcILpilOuWrigvyQny0xyeDShNc49zsGJ2Lpeo4ZH4sEB3xEJYIUIPRYXJMsAiJyEM8bKKkqcJ6G6Jwv/i7NGCRdWlk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fk8UKHpw; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fk8UKHpw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779950071; x=1811486071;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8VipYLA4X5TG4DGREGYl6oczIgMJh/79bXPLfKHSkW4=;
  b=Fk8UKHpwSoc8DcE3uI2v5/3w7wRlXvNUX/+BMzmpwNHKdoZpCElFx5/r
   aSJuUVhtKsPVnHznTLohAy00AOqBH7m5eZjSG024OJbYygHRRipBOoWWu
   VziD5z5kZzJY5k0vOOzph8g1pyKtRYkFZhxvufBYSybfuqInSZQERk5td
   dPSRGeYucSJoSG+UwGL6h+mVoeWQnC77syQ1QcdXUoEzQM7UMjzpPk02r
   cbVlfMyUKlxuciLtNbAyAi4CFd1TqZAzriQXBRgS7hfsC1cl7K2wf/O1l
   FoLBYL1yqVUx+YXR22BLFeF6gBTjliT29jmx/lXxM002SaZRcytd49dRK
   w==;
X-CSE-ConnectionGUID: BE9xqPfYQZiPy5nHfyZstQ==
X-CSE-MsgGUID: 3yYzATvlRICUqx9pHNQ1nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80691198"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80691198"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 23:34:31 -0700
X-CSE-ConnectionGUID: DEca0005Ru2Q831UoImS/g==
X-CSE-MsgGUID: EJyAqGCjSBWtIMKTxtDVog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="241429453"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 23:34:27 -0700
Message-ID: <0e76b825-d6a6-4343-8bee-f2690c2537f0@linux.intel.com>
Date: Thu, 28 May 2026 14:34:25 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/7] perf/x86/intel/uncore: Fix PCI device refcount
 leak in UPI discovery
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260527151154.130505-1-zide.chen@intel.com>
 <20260527151154.130505-3-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260527151154.130505-3-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 5/27/2026 11:11 PM, Zide Chen wrote:
> pci_get_domain_bus_and_slot() increments the reference count of the
> returned PCI device and therefore requires a matching pci_dev_put().
>
> In skx_upi_topology_cb() and discover_upi_topology(), the lookup is
> performed inside a loop, but pci_dev_put() is only called once after
> the loop. As a result, references from all previous iterations are
> leaked.
>
> Move pci_dev_put(dev) into the if (dev) block immediately after
> upi_fill_topology() returns.
>
> Opportunistically, fix uninitialized variable in skx_upi_topology_cb().
>
> Fixes: 4cfce57fa42d ("perf/x86/intel/uncore: Enable UPI topology discovery for Skylake Server")
> Fixes: f680b6e6062e ("perf/x86/intel/uncore: Enable UPI topology discovery for Icelake Server")
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/uncore_snbep.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index 215d33e260ed..c9ce206fcbb6 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -4261,7 +4261,7 @@ static int upi_fill_topology(struct pci_dev *dev, struct intel_uncore_topology *
>  static int skx_upi_topology_cb(struct intel_uncore_type *type, int segment,
>  				int die, u64 cpu_bus_msr)
>  {
> -	int idx, ret;
> +	int idx, ret = 0;
>  	struct intel_uncore_topology *upi;
>  	unsigned int devfn;
>  	struct pci_dev *dev = NULL;
> @@ -4274,12 +4274,12 @@ static int skx_upi_topology_cb(struct intel_uncore_type *type, int segment,
>  		dev = pci_get_domain_bus_and_slot(segment, bus, devfn);
>  		if (dev) {
>  			ret = upi_fill_topology(dev, upi, idx);
> +			pci_dev_put(dev);
>  			if (ret)
>  				break;
>  		}
>  	}
>  
> -	pci_dev_put(dev);
>  	return ret;
>  }
>  
> @@ -5499,6 +5499,7 @@ static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, i
>  							  devfn);
>  			if (dev) {
>  				ret = upi_fill_topology(dev, upi, idx);
> +				pci_dev_put(dev);
>  				if (ret)
>  					goto err;
>  			}
> @@ -5506,7 +5507,6 @@ static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, i
>  	}
>  err:
>  	pci_dev_put(ubox);
> -	pci_dev_put(dev);
>  	return ret;
>  }
>  
