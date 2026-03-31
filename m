Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDEB30F531;
	Tue, 31 Mar 2026 01:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774919621; cv=none; b=P4TvWPPMh12KkcWHjTFY5LY0v0vNQurAMx0U3cRYV8J9hEob11ffBjo4HnBXCEoBWVDTMIuVzVBHy7jeYeuR4fglfqZz/hAaNkCq3AKL3zydCWSVydbBH3R7gLCpsyIqJ++H6i4/gFiAZJ0EKXJgnKH9FdWG3OKgNCpSWpz0IjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774919621; c=relaxed/simple;
	bh=wgu3eT039O+5W2aKeq7XICcCBzW7hi+V2/2ceynNFRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIry0pLm5Ce8eDaAz9TfIoW+ErwOtwwZgtY680K1qJYWdnwdtBS/eIiQTerkciG7+zO7m8oTTEtkzY3OZLQqN8JzNFjlZ/2FHTnZVpGnUJgaD9MYCqla/xJmV/NC22H/XRZ8QGW7pEmvzgPZOd+2efHOMga4lLoaty8zH+bTY98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K4g9IEHf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K4g9IEHf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774919619; x=1806455619;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wgu3eT039O+5W2aKeq7XICcCBzW7hi+V2/2ceynNFRg=;
  b=K4g9IEHfJ0fE9z9l/9gLs6cCVEVC7+GWGI5zdWK81fYtQ3Lm9cJcH+Uu
   EpoCG/4tXCctKAegXkVm6kUtiOoiSUC8E0okQRLb1ZgNOMLZ1FIA0h+TA
   /mRHHe3EcfkU75ti1k4gCsamr5Pwq7ypWdODNcfISBolKm6mdfRZhdlxM
   qf3sw/W/+5gjEIKJjEme66U5Y0WB7RbyOqS2Dtlsv3dDeTkx1/ItTxr0n
   DUngjdGTSsqQ3j4EdVzDEU+Cs25wvrWSOeu1QY65YssdxvKvpPAufVIzR
   CidvdIuYzgJcINBGx02WoEsPf7m2rRR6SiWmnOn6NyQLIB5k6wM+CNXSR
   A==;
X-CSE-ConnectionGUID: 8g34p9QxS9KdsDxZnwSCRg==
X-CSE-MsgGUID: fANaXQVzQXa9BTsxjva1jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="87317022"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="87317022"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 18:13:38 -0700
X-CSE-ConnectionGUID: TlUckW8lQzOCcLpenFytUw==
X-CSE-MsgGUID: 0uqZqT1USWyi32yLi0pG5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="249439682"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 18:13:35 -0700
Message-ID: <c53a7b98-14e0-41ff-89d8-5cb6f7d96434@linux.intel.com>
Date: Tue, 31 Mar 2026 09:13:32 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 3/5] perf/x86/intel/uncore: Do not treat -1 die_id as
 error during UBOX scan
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, Chun-Tse Shao <ctshao@google.com>,
 Markus Elfring <Markus.Elfring@web.de>
References: <20260330212444.117325-1-zide.chen@intel.com>
 <20260330212444.117325-4-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260330212444.117325-4-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/31/2026 5:24 AM, Zide Chen wrote:
> In snbep_pci2phy_map_init(), in the nr_node_ids > 8 path,
> uncore_device_to_die() may return -1 when all CPUs associated
> with the UBOX device are offline.
>
> Remove the WARN_ON_ONCE(die_id == -1) check for two reasons:
>
> - The current code breaks out of the loop. This is incorrect because
>   pci_get_device() does not guarantee iteration in domain or bus order,
>   so additional UBOX devices may be skipped during the scan.
>
> - Returning -EINVAL is incorrect, since marking offline buses with
>   die_id == -1 is expected and should not be treated as an error.
>
> Fixes: 9a7832ce3d92 ("perf/x86/intel/uncore: With > 8 nodes, get pci bus die id from NUMA info")
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V2:
> - Fix the commit message to note that spr_update_device_location() is
>   used by EMR, not GNR.
> - Rewrite the commit message for clarity.
> - Add a Tested-by tag.
>
> V5:
> - Removed unused die_id (Dapeng).
>
> V6:
> - Move the spr_update_device_location() change to a separate patch.
> - Update the comit message and title to reflect the reduced scope of
>   this patch.
> - Remove Tested-by since the code has changed.
> ---
>  arch/x86/events/intel/uncore_snbep.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index 9b51883fd6fd..8ee06d4659bb 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -1413,7 +1413,7 @@ static int topology_gidnid_map(int nodeid, u32 gidnid)
>  static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool reverse)
>  {
>  	struct pci_dev *ubox_dev = NULL;
> -	int i, bus, nodeid, segment, die_id;
> +	int i, bus, nodeid, segment;
>  	struct pci2phy_map *map;
>  	int err = 0;
>  	u32 config = 0;
> @@ -1458,14 +1458,9 @@ static int snbep_pci2phy_map_init(int devid, int nodeid_loc, int idmap_loc, bool
>  				break;
>  			}
>  
> -			map->pbus_to_dieid[bus] = die_id = uncore_device_to_die(ubox_dev);
> +			map->pbus_to_dieid[bus] = uncore_device_to_die(ubox_dev);
>  
>  			raw_spin_unlock(&pci2phy_map_lock);
> -
> -			if (WARN_ON_ONCE(die_id == -1)) {
> -				err = -EINVAL;
> -				break;
> -			}
>  		}
>  	}
>  

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


