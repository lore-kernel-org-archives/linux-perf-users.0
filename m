Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B881BD4F7;
	Tue,  2 Jul 2024 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936325; cv=none; b=j3Dt0PJPMUAGLHALlKHR+cD2Cu3pUCnPFARP+V8+M3eHq6xWHimiwqFA9I/OidJPtVVsc1xJMGfRMWqSL6O5utRMGHEEoCLIpmH9MXJM6U2+RxBAkOtDlK3seZF7mjgj10Z9Z8KCbZLnlAnsbgECLTHNhnaq/b/bVAgsDG0M0EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936325; c=relaxed/simple;
	bh=3xrxAwXmOpIV32GmleYZYkrSYEq5t6QQCU4QH90JDn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t20C/viC4sWLcQ8UFLNm+fi3M22S/w1OSbM1x+iD4OMwT+D7NQxsdcnzKj1SFTXyW3yNwuN0dSyCLoP01EaUtM06KcCZYQTqdETB1YpGzKysYJwfg1/QK4zRLIZdeGuxz28ih2XgOrZ0gOZ7zyNyeDGrKgpabJQ2qhyM0ob83XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BUIujZyX; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUIujZyX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719936324; x=1751472324;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3xrxAwXmOpIV32GmleYZYkrSYEq5t6QQCU4QH90JDn0=;
  b=BUIujZyXIHW+pwyZA/ZMSFDJl983XCBWqFvCDpGaLllyMj62L2/w9F3U
   aMo3wSH6+oFoX+ppDFl5snxNTWTHqE7wAOihK8MBkglFG4pO4YOT5476P
   RAnngr8fRgL+g5wA7KQ4gJ7Kdf1itul8s7eT374lGATGKtvFa4hOGm2nc
   zAdkWdA7A1+NDDcC2wdAASMQzOSZAZvgKXt1DoMQoqBtTDbgY93s4kZNv
   zwlC335UEcbqhjnDSadZ+gYv9K81gym72v0N1hxqlHSeZT2OBhiOG7RJ1
   injddSnaWdIjHp9kbtewpER5/0VAav8MPjCYzgvJWlTF+mfPh2QXvgZdg
   A==;
X-CSE-ConnectionGUID: LFFvezv2SsWjUnYEB+308Q==
X-CSE-MsgGUID: OjiY26wYRmqJ3LHmc3euQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27721856"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="27721856"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 09:05:23 -0700
X-CSE-ConnectionGUID: f4B0kDMIT9Wiw71KqXYSIA==
X-CSE-MsgGUID: tnRnGK9VQh2WMryStXXuVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50400684"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 09:05:22 -0700
Received: from [10.212.94.246] (kliang2-mobl1.ccr.corp.intel.com [10.212.94.246])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 90C70201A797;
	Tue,  2 Jul 2024 09:05:20 -0700 (PDT)
Message-ID: <d9c26690-5147-4a4a-815b-fb5d46d043c6@linux.intel.com>
Date: Tue, 2 Jul 2024 12:05:18 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] perf topdown: Correct leader selection with
 sample_read enabled
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yanfei Xu <yanfei.xu@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
References: <20240702224037.343958-1-dapeng1.mi@linux.intel.com>
 <20240702224037.343958-2-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240702224037.343958-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-07-02 6:40 p.m., Dapeng Mi wrote:
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
> index 3f9a267d4501..5d7b78eb7516 100644
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
> @@ -41,11 +42,22 @@ bool topdown_sys_has_perf_metrics(void)
>   */
>  bool arch_topdown_sample_read(struct evsel *leader)
>  {
> +	struct evsel *event;
> +
>  	if (!evsel__sys_has_perf_metrics(leader))
>  		return false;
>  
> -	if (leader->core.attr.config == TOPDOWN_SLOTS)
> -		return true;
> +	if (leader->core.attr.config != TOPDOWN_SLOTS)
> +		return false;
> +
> +	/*
> +	 * If slots event as leader event but no topdown metric events in group,
> +	 * slots event should still sample as leader.
> +	 */
> +	evlist__for_each_entry(leader->evlist, event) {
> +		if (event != leader && strcasestr(event->name, "topdown"))

User may uses the RAW format. It may not be good enough to just check
the event name.

I recall you have a complete support for this in the previous patch. Why
drop it?

Thanks,
Kan

> +			return true;
> +	}
>  
>  	return false;
>  }
