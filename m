Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794984503;
	b=RZ42tVfZfuz86hQ1hbMy50Qs/3XvFyNFi7P2q/Gv3OnZQWc+iEm0gVJlaO2cYYPt+nfP
	 v4nFpi0MAY3rJ5qw+MlzeERuJS9HvnOtXgAZHJeLtQKCFPqqqBJyCpdczRg49vVcG9N1z
	 4Z17xWRFdLufmb55/eRQxvanIYaT6RxMm6LP6BPCilJE/pc9SfdomcoUm+ySWEdLEB7dh
	 qAztm17OC2Ej+Xe+ZHwPz9evRe82Bh741MgA3BNT1Ng46GbpM7ubmf785cvp+a9MMY/qa
	 ++l5Gy0GE0vDO7PaI85pV/umL9HdBq2qJH3Me5sNoMgEDIaEEKnwA0EhCm5aVxm09hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794984503;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=vgwgCvpswtJRWR2a83jgVRcIOlLkVvQPyoIjj5/btfw=;
	b=mDn/ocMlAYUzFN55QLTMSvSsNzApAmvL47M/K41SmmkJqCBSNu1LmUPd1harkllpkGZ8
	 gABCaVXdXxRFCIynOddMLkDAQaEhPieVZRucRyZSAa7ssz6gnytOb68Zd3soCEUaPWRNo
	 RRc465Y9rh71WapqRqNI3MKj5Ju0iHZXu/ILrPocJfakSocefU11CxDGTxYpVzu/NPoRW
	 3uwDxNRujrIuvYhioONluW85Tqw32Yz8cxJgJOf3DXW09zNOix0Tnzl2ZOsgd3hui7fSP
	 MrGxvN0mDYxHY259pX4LMqEqQj4u5MPcaai5PDZFDf3IhbjpB0ucqf6fBSnFGk3tovQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="mB/5QKel";
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B458606A32A;
	Wed, 18 Nov 2026 06:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B458606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mB/5QKel
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794984503; x=1826520503;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mZA3G0uEhW7Xobr9BK0nooFcChQvCLwKszT8JnEeXW8=;
  b=mB/5QKelnfmZjXHyxEEAy0DHU+2/FIMmWVhirZPfWFDSBb6XMcvQ16fR
   99ai+0HTl8yozuNFboBKEV7YB/CyNcgulp/J0mrvST7b0WAFd1iYQ1t7M
   zfKMiwimne2COGrngJlxlt0DKX96znR2STD3MQKe0nWdxBWBwBrHRx2Wc
   a40+1Wjqqe7yUgCB0HYPHJ/hRhV+lCq7yf45cIJ7mQjsWWGNj7TjSQqyy
   WIMnKdpzvrPZWQIsDk7je9bsT2ykUwg6fSkVrB+JCKVI3vEt5+v0xG/7S
   d07WepQo9NdXjZoiCFLy78icCeQyzfib9+nlJfhC3dkpvRi7pNfprKWqX
   Q==;
X-CSE-ConnectionGUID: t7QL/xr4SOakb6j+f8OPyw==
X-CSE-MsgGUID: OA8+tGh0QVCwZzLKH9YJHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3772828"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3772828"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 22:48:22 -0800
X-CSE-ConnectionGUID: ZA24Y1gqSOytFHBaUOYmKw==
X-CSE-MsgGUID: WSI4gld1RRO9UN6hj7Rmmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10434622"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 22:48:14 -0800
Message-ID: <acbc31bb-d752-4394-a0bc-5cf24ffc7300@linux.intel.com>
Date: Wed, 18 Nov 2026 14:48:11 +0800
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
Subject: Re: [Patch v7 20/24] perf/x86/intel: Clear raw LBR counters in the
 LBR stack
To: bot+bpf-ci@kernel.org, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
 ak@linux.intel.com, eranian@google.com, andrii@kernel.org, song@kernel.org,
 ravi.bangoria@amd.com, ananth.narayan@amd.com
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org, dapeng1.mi@intel.com, zide.chen@intel.com,
 thomas.falcon@intel.com, xudong.hao@intel.com, sashiko-bot@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, mason@kernel.org,
 ihor.solodrai@linux.dev
References: <20261118031453.1353625-21-dapeng1.mi@linux.intel.com>
 <cc3a05a38e308aa20c6b9886b4cd3e5f403287627b44f30ce07cb7607329ea13@mail.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <cc3a05a38e308aa20c6b9886b4cd3e5f403287627b44f30ce07cb7607329ea13@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/18/2026 11:54 AM, bot+bpf-ci@kernel.org wrote:
>> perf/x86/intel: Clear raw LBR counters in the LBR stack
> TL;DR: Clearing raw LBR counters in the shared stack may zero them before a
> later branch-counter event in the same PMI reads them, giving all-zero counter
> samples until a later commit fixes it.
>
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
> [ ... ]
>
>> @@ -1001,6 +1013,7 @@ void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
>>  		return;
>>  	}
>>
>> +	intel_pmu_lbr_clear_raw_counters(cpu_lbr_stack(cpuc));
>>  	perf_sample_save_brstack(data, event, cpu_lbr_stack(cpuc), NULL);
>>  }
> Can this clear the counters before a later event in the same PMI has
> consumed them?
>
> handle_pmi_common() reads the LBR stack only once per PMI and reuses it for
> every overflowing branch event:
>
>     if (has_branch_stack(event)) {
>         if (!cpuc->lbr_stack_live) {
>             intel_pmu_lbr_read(cpu_lbr_stack(cpuc), cpuc->lbr_counters);
>             cpuc->lbr_stack_live = true;
>         }
>         intel_pmu_lbr_save_brstack(&data, cpuc, event);
>     }
>
> Suppose event A is an ordinary LBR event on counter 0 and event B is the
> sampling event of a branch counters group on counter 1, and both overflow in
> the same PMI.  A is handled first, and intel_pmu_lbr_save_brstack() calls
> intel_pmu_lbr_clear_raw_counters(), which zeroes entries[i].reserved in the
> shared cpu_lbr_stack().
>
> When B is handled, lbr_stack_live is still true so the stack is not re-read,
> and intel_pmu_lbr_counters_reorder() reads reserved == 0 for every entry.
> B's sample then reports all-zero branch counters.
>
> Before this patch the non-counters path left reserved alone, so B got the
> correct counters in this ordering.
>
> The later commit 57fc5222dbd3 ("perf/x86/intel: Refresh LBR stack for LBR
> counter events in PMI handler") addresses this case by re-reading the LBR
> stack before a branch counters group event once an earlier LBR event has
> cleared it.  Until that commit, a bisect landing on this patch would see
> wrong branch counter samples in this scenario.

Per my understanding, we'd better keep current patch order. Without this
patch, the LBR stack needs to be refreshed only when there are two and more
LBR counter events, so the patch 57fc5222dbd3 needs to refresh LBR stack
only for the cases that there are 2 and more LBR counter events, and we
have to add a new patch to relax the condition, the LBR stack should be
refreshed as long as there are 1 LBR counter event and other LBR events. 

It introduce unnecessary complexity. Thanks.


>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44231525404
