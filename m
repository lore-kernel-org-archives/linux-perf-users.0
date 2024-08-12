Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478DF130AC8;
	Mon, 12 Aug 2024 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475911; cv=none; b=oxpKEwr0/QGLPwhNsu6wAKVuX6+S6kb8n660KzD5UnUOB2jsbWA6pxBYsvqQ5tuLdmwajIr05R/7DA7dc0id36bILhGxnWccK+zotku7C310MVgG6FZ5ravar/w6FE/7FSIKv4TqgPHdpNXuM+8MODaUybuw/DChatxM5AFFf+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475911; c=relaxed/simple;
	bh=L+S8wUs38FK7FjSSmrWhkS4nFZyIzpYU7kJGEaQBflc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQv6D1Khfx9QC1F9RYFN63bz/yfA1qExz/eYrzUkf5AD/djWchURbLWi6PTANMp/Jokg+I5Etzpudh3so3VdUfjWE4snEoYJ/3IoPR1wQKUIzD5YmPJbLgUj5Lh96EvmSSLyVBtvqKc1k16G0bp92hNcKDDndfp8/XHs9aBzCKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fOzbFKbM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fOzbFKbM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723475909; x=1755011909;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L+S8wUs38FK7FjSSmrWhkS4nFZyIzpYU7kJGEaQBflc=;
  b=fOzbFKbMHaTlUJF5gSjCNQ1pklLBgf0Qdy1b3Il1btCW4kvNoRS0QVdx
   AiXDTTql9IOiN2pHw0yImmO+/wnRw5IfBfGJb1TxrPhu2P0s+xiIEYjyg
   D5btGjHEUO+GjBq3lWkvZtjSjDRZvLU24ax0IXfmvBc9EZlvtQgUoq4Cx
   My8+D+TdORWe6RLmZSVgwp+ElF0BZl/H8BW9tOElFJF4aDMS1NIPkpKV3
   9Dm7gLu+ypmBtlqOcXEm+F+I2aH4I9wMembMmhulC089SuuPpANs7SbKf
   D0e14mWtRtFMtinpJS0Cm2+Rexns5rnTdJYZZX8NI8x8LUQREtghwpUeg
   A==;
X-CSE-ConnectionGUID: jGAgvNFsRIuB/ZdlrMy7BA==
X-CSE-MsgGUID: VzwfiviWTr+BFj7BPC5uWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="46994629"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="46994629"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 08:18:28 -0700
X-CSE-ConnectionGUID: uxy9Spg9Q0a5wAVnlz6HQw==
X-CSE-MsgGUID: XW8upg89SLyrXMFUngqBCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="59004473"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 08:18:28 -0700
Received: from [10.212.112.28] (kliang2-mobl1.ccr.corp.intel.com [10.212.112.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id E46D520CFED0;
	Mon, 12 Aug 2024 08:18:26 -0700 (PDT)
Message-ID: <ab4e2929-a9f7-445d-9eb0-547556799a57@linux.intel.com>
Date: Mon, 12 Aug 2024 11:18:25 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 2/5] perf x86/topdown: Correct leader selection with
 sample_read enabled
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
References: <20240712170339.185824-1-dapeng1.mi@linux.intel.com>
 <20240712170339.185824-3-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240712170339.185824-3-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-07-12 1:03 p.m., Dapeng Mi wrote:
> Addresses an issue where, in the absence of a topdown metrics event
> within a sampling group, the slots event was incorrectly bypassed as
> the sampling leader when sample_read was enabled.
> 
> perf record -e '{slots,branches}:S' -c 10000 -vv sleep 1
> 
> In this case, the slots event should be sampled as leader but the
> branches event is sampled in fact like the verbose output shows.
> 
> perf_event_attr:
>   type                             4 (cpu)
>   size                             168
>   config                           0x400 (slots)
>   sample_type                      IP|TID|TIME|READ|CPU|IDENTIFIER
>   read_format                      ID|GROUP|LOST
>   disabled                         1
>   sample_id_all                    1
>   exclude_guest                    1
> ------------------------------------------------------------
> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
> ------------------------------------------------------------
> perf_event_attr:
>   type                             0 (PERF_TYPE_HARDWARE)
>   size                             168
>   config                           0x4 (PERF_COUNT_HW_BRANCH_INSTRUCTIONS)
>   { sample_period, sample_freq }   10000
>   sample_type                      IP|TID|TIME|READ|CPU|IDENTIFIER
>   read_format                      ID|GROUP|LOST
>   sample_id_all                    1
>   exclude_guest                    1
> 
> The sample period of slots event instead of branches event is reset to
> 0.
> 
> This fix ensures the slots event remains the leader under these
> conditions.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/topdown.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
> index 49f25d67ed77..857e00cf579f 100644
> --- a/tools/perf/arch/x86/util/topdown.c
> +++ b/tools/perf/arch/x86/util/topdown.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "api/fs/fs.h"
>  #include "util/evsel.h"
> +#include "util/evlist.h"
>  #include "util/pmu.h"
>  #include "util/pmus.h"
>  #include "util/topdown.h"
> @@ -87,11 +88,22 @@ bool arch_is_topdown_metrics(const struct evsel *evsel)
>   */
>  bool arch_topdown_sample_read(struct evsel *leader)
>  {
> +	struct evsel *evsel;
> +
>  	if (!evsel__sys_has_perf_metrics(leader))
>  		return false;
>  
> -	if (arch_is_topdown_slots(leader))
> -		return true;
> +	if (!arch_is_topdown_slots(leader))
> +		return false;
> +
> +	/*
> +	 * If slots event as leader event but no topdown metric events
> +	 * in group, slots event should still sample as leader.
> +	 */
> +	evlist__for_each_entry(leader->evlist, evsel) {
		evsel = leader->leader;
		evlist__for_each_entry_continue(leader->evlist, evsel)
			if (evsel->leader != leader->leader)
				return false;

Maybe we should limit the check in a group, rather than the entire
evlist. Something as above (not tested)?

Thanks,
Kan
> +		if (evsel != leader && arch_is_topdown_metrics(evsel))
> +			return true;
> +	}
>  
>  	return false;
>  }
