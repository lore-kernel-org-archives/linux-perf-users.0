Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794477580;
	b=44dGXDc5J6jBmIJkqTHuC3QfYe7kR7FglRqLRXVL136tMZCFdgVujIvNOXT0cDnv0j1P
	 htFGVaKxbPxrw1NGNTOJT3gLvsLQKUMf9l6XoUdoXnUDL3rhdfRf5oROdNGtV3SjsRdZt
	 G+pHmNAW97+JAmUhJZn1Ia6GiKhehBtFeNr7QUfPntsTehmw3yiXP47t3Ikjq6Xu6H/Y2
	 6K/55jMcB99ILAz25cfOPtwhRoE38OIschnSakP0QS0T8TYln7AWUrqh2WWAGepgCdsim
	 s8NVmwTwjkXu2IcLyu2L888bYVmIEd1iWh4E6vaw9QKDo6Hp1yd04yzTO0wuDXpD5Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477580;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=2E/Pd+eRpGBVsTZHlPb0fwZaxBzjHwZ9HH30lAHAHJQ=;
	b=jInO8dAxNW+7EoyovU4h7qEfU/s1aegwmCxAqyQjgoex28r1lKtgLHuX849LzZNi8ie3
	 qiLoGB2CSQy1WhwcUGbpdQZzO1jhRqrznQs7Vx9/I33vY6EuLfJcItnzmebBw1OkenDDQ
	 oCNPeus2CmR17qcz/Z8CXlo5j3FRSLNPbwlZRJLBqtX73VD5lHWy9I0uh7ofcVSoWMGDP
	 CI1SuiE0NMEcZIW/XT/OHAQ5624VeBD7rp6wcPPDw/E8IIzHCQlKGJvIqrwbPE5uVyiLI
	 OO7R3pGsuZsnCvscHihP+lZABWJt8EFYwOYgkWN07YWsga5FvnCoq1/o70ZS+MBZFBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XGGiy1bp;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C273F606A31C;
	Thu, 12 Nov 2026 09:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C273F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XGGiy1bp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794477579; x=1826013579;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qDule4CxqfFN+2waxds8SOiRRp9p+9tYIgVSLDGdBfo=;
  b=XGGiy1bp26JXi74cBmiQNum0JK5EbTJCO/FvsAIQC3xysw16wqFTNClk
   FMi0a0DTbCHVFoLZPXPSKhRYaHL3voRQQv//736Q28Sm/74F1q4qwNeQa
   NoZ47FHHjG6ad6wQnrVC/ltWuOlzYF2Pnxv5axvrspqC/JZgKrb1UnIfv
   EujeQDTFeU78wBYHsWU4ffyuwR0OYxfsyVCcvd9USrV0vqjV6MjvzibpU
   PKETtRFoB2yRDWrBwvrc/zaXJKV0cnpCPcFZwS0tKrnGm/xC4fOxh7Dpe
   9sNkXbzDeoUPuHtROVxjoQESmRoRNaHD9Pi71V3a0uW0W8S0cY8932zGx
   w==;
X-CSE-ConnectionGUID: D2a60SZGSgys/4InDmVj9w==
X-CSE-MsgGUID: xYM5J97VQNybr/Yf+r+9vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3157926"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3157926"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 01:59:39 -0800
X-CSE-ConnectionGUID: kd8jmuNnQ16CVZxt1cNRrg==
X-CSE-MsgGUID: bjpelCUYTvOrAS89RdBqiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8445167"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 01:59:34 -0800
Message-ID: <9464097b-a8e0-47d8-aa63-d56af1d30c84@linux.intel.com>
Date: Thu, 12 Nov 2026 17:59:30 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v6 14/20] perf/x86/amd: Refresh LBR stack in PMI only when
 LBR users are active
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Sandipan Das <sandipan.das@amd.com>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-15-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20261106043257.842864-15-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/6/2026 12:32 PM, Dapeng Mi wrote:
> Refreshing the LBR stack in the PMI handler is unnecessary when no LBR
> users are active. This adds avoidable overhead and hurts performance.
>
> Limit the LBR stack refresh to the PMI path only when LBR users are
> present.
>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Cc: "Sandipan Das <sandipan.das@amd.com>"
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/amd/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 160102a46b18..f0425e369837 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -988,7 +988,8 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
>  
>  	/* Read branch records */
>  	if (x86_pmu.lbr_nr) {
> -		amd_pmu_lbr_read();
> +		if (cpuc->lbr_users > 0)
> +			amd_pmu_lbr_read();
>  		status &= ~GLOBAL_STATUS_LBRS_FROZEN;
>  	}
>  

This patch is actually unnecessary since amd_pmu_lbr_read() internally
checks cpuc->lbr_users and would early return if cpuc->lbr_users is 0. 

Would drop this patch in next version. Thanks.


