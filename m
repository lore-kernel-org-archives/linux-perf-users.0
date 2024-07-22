Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CF5168498;
	Mon, 22 Jul 2024 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721645665; cv=none; b=Wxq3/YezzLvIeU0LVtmI+/2w4Cy/mll42BebiPndoACNQf37zxQkJZ+fMQ7O+wM528GvPU5WJ4KPhts4sAudA9dS2pPJ9Pl0bSeztVdvvcQsCuECiOO10ooDciYiingWhBXQcU/dbynJxC2RSplGc6ItgFbe6brnp+MiPb8Bv8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721645665; c=relaxed/simple;
	bh=+z0DAuZdonTJ1I9rraYJwXYIRtI1h+d8Boqp8wsoi14=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EV6sm/USuCIqdWlUfnuoovi6UEk/LtDTBQOwHWIWfz/w5p+fLYDfp7hvwAO83Iq7FqKtkhI0qTwhNRNSrZd6+xLs30Sm5SRDiyBXhhNp0y9OF7TwPmVXWyhZtFsLLHEVa2G0yQcyZP8tq0F0zCTRv6LedqSXWK8WXh95vinqY1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9sOWlW1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9sOWlW1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721645661; x=1753181661;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=+z0DAuZdonTJ1I9rraYJwXYIRtI1h+d8Boqp8wsoi14=;
  b=X9sOWlW1WQ8yC5lvpm9LNpVwQFWaldzYedfQiBXQDQkJn8V2xlAJmvlv
   soWNC/MJHnhZ2wn0MP+4+5LTEumbi6QVZOLBytXSdH9cJXLW0MwXL4KSA
   CafL7V9Pk2sh2e0HEmsvIKtnTroySxioSupiiwem7+R3XXuZFxUNnuWGq
   WcgotT4jWz2xnFXGULnI6WPncHBTcvcJaYqOwimJXB+1x/VgAFLSEnAOn
   PFDrRx6Ho5vpJKKClvbHrmtdpddTCsCJw/MuxrIFztF6dBp5VpKCCI1KU
   s2hgT9JZH/3oKkKqFIeBUXH7jDf9VBFgOcOOXNAEELKf+kzoDeHPnWdjh
   A==;
X-CSE-ConnectionGUID: 5Oan993vSnSz1M1J1KWdtA==
X-CSE-MsgGUID: ygEWWcevRkCoaY5wLjOAAA==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="18912959"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="18912959"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 03:54:20 -0700
X-CSE-ConnectionGUID: PYLuuNYdQo+yl3mJ3JSc6g==
X-CSE-MsgGUID: fbdVZ75lSHGtuNC+1T6SQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; 
   d="scan'208";a="56699163"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 03:54:16 -0700
Message-ID: <a9d07994-cf6e-4059-8180-c0b9cd51e528@intel.com>
Date: Mon, 22 Jul 2024 13:54:11 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/6] perf auxtrace s390: Set the 'auxtrace' flag for
 AUX events
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240721202113.380750-1-leo.yan@arm.com>
 <20240721202113.380750-4-leo.yan@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240721202113.380750-4-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/07/24 23:21, Leo Yan wrote:
> Set the 'auxtrace' flag for AUX events on s390.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/arch/s390/util/auxtrace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/arch/s390/util/auxtrace.c b/tools/perf/arch/s390/util/auxtrace.c
> index 5068baa3e092..d7e72413b262 100644
> --- a/tools/perf/arch/s390/util/auxtrace.c
> +++ b/tools/perf/arch/s390/util/auxtrace.c
> @@ -99,6 +99,7 @@ struct auxtrace_record *auxtrace_record__init(struct evlist *evlist,
>  		if (pos->core.attr.config == PERF_EVENT_CPUM_SF_DIAG) {
>  			diagnose = 1;
>  			pos->needs_auxtrace_mmap = true;
> +			pos->pmu->auxtrace = true;

This is probably too late. See:

https://lore.kernel.org/all/20240715160712.127117-7-adrian.hunter@intel.com/

>  			break;
>  		}
>  	}

