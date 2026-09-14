Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435683290B7
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 03:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789355168; cv=none; b=ReqQo1NT/EJEFPbHIN6xvRuB3rCtwfl2V9wqWqEJFt2Hh3UZcYqsh4o6/WW/XslCwpkr3ZFTy0dkqEEiBUXLufciUda/vHGj0AuPTTDHn36vjb4e+oQbnVZV+bMIpbotYZbJIQprC5E5LayDU9llhI9cNRo4OdPxawx/xlsUjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789355168; c=relaxed/simple;
	bh=VJl9s4zMe/cDL7B/TY5WCWy9+ZEjYeRL/P5hT4jUEdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nkb42CMOXr5gMUpSgt/4qZWYWHyTxKg0xdPbbaaUxsDa72ejFfKvt/wax/aPGpGGa1J8/lP7Y/ZHh6dI22wPfVVSF0iVD3phOaosDxYiYnY/Smn9Ht+7CynwyfqPFvD32HzVlf5Sx7LCZEQbh36YPojYZhopHFDj3/S27lJbYgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FoWmf7Pt; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FoWmf7Pt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789355166; x=1820891166;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VJl9s4zMe/cDL7B/TY5WCWy9+ZEjYeRL/P5hT4jUEdc=;
  b=FoWmf7PtCEv8LL3SQgasLx4bpclia30K3YTjNj3u5bOlEqmWzAQ0LgTd
   wxqdk8IoBYA5+vAmExiqFooE4bEuf/mn1+Af2/pez6NH+jElTb9z6kU0g
   Obwu/Cy39/BliTCii8ep3YjPzyPlUMe+JHErrwC43ntbggk1LNjwwgP92
   ykmAnQBIszyuGVFVaSA08z0990WJ3JpVgKjSyhFq2AsLuUp2i00gb/QW4
   BPxudpms2EL5LCtyGIhF2UhV0+8KLqwvvKdXG1HcjOIfZcLWzKrY5qaxO
   cI/dae48rMU09IhCMb3nlQyTlNPGgaw6e07lHOWMEt3TvXXJmF1Ilzb1z
   w==;
X-CSE-ConnectionGUID: t2QygZZtQQyOcPU222jlsA==
X-CSE-MsgGUID: p/ViMsS4QBS8yIVb1qLFUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="100370960"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="100370960"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 20:06:06 -0700
X-CSE-ConnectionGUID: sN4weCe3S4uMjX6D/P9HGw==
X-CSE-MsgGUID: PXn7PZAeS6Sg9vSigSjAAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="271100240"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 20:06:04 -0700
Message-ID: <c339d0c9-dc0b-45ee-8a11-39d6ff533a3a@linux.intel.com>
Date: Mon, 14 Sep 2026 11:06:01 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v11 03/10] tools headers: Sync x86 headers with kernel
 sources
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
 <20260914014049.2061519-4-dapeng1.mi@linux.intel.com>
 <20260914015501.53F4E1F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260914015501.53F4E1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/14/2026 9:55 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The patch adds new `ARCH_PEBS_VECR_xxx` macros exclusively to the tools header without a corresponding update to the core kernel header, breaking header synchronization and indicating a missing prerequisite kernel patch.
> --
>
> commit 545cb1e6346c71f64b6106d48dfa9367ed61de8d
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> tools headers: Sync x86 headers with kernel sources
>
> This commit adds ARCH_PEBS_VECR_xxx macros into the tools version of the
> x86 msr-index.h header. The commit message indicates this is a sync from
> the kernel sources.
>
>> diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
>> index 18c4be75e9271..9c26d4075c5f4 100644
>> --- a/tools/arch/x86/include/asm/msr-index.h
>> +++ b/tools/arch/x86/include/asm/msr-index.h
>> @@ -350,6 +350,13 @@
>>  #define ARCH_PEBS_LBR_SHIFT		40
>>  #define ARCH_PEBS_LBR			(0x3ull << ARCH_PEBS_LBR_SHIFT)
>>  #define ARCH_PEBS_VECR_XMM		BIT_ULL(49)
>> +#define ARCH_PEBS_VECR_YMMH		BIT_ULL(50)
> [Severity: Medium]
> The commit message mentions syncing newly introduced ARCH_PEBS_VECR_xxx macros
> from the kernel, but is there a missing prerequisite patch?
>
> These macros do not appear to exist in the core kernel's
> arch/x86/include/asm/msr-index.h at this commit.
>
> Will adding them exclusively to the tools header without a corresponding
> kernel update break header synchronization and trigger warnings from
> tools/perf/check-headers.sh when running make -C tools/perf?

The core kernel change is in another independent patch series and already
merged. 

Thanks.


>
>> +#define ARCH_PEBS_VECR_EGPRS		BIT_ULL(51)
>> +#define ARCH_PEBS_VECR_OPMASK		BIT_ULL(53)
>> +#define ARCH_PEBS_VECR_ZMMH		BIT_ULL(54)
>> +#define ARCH_PEBS_VECR_H16ZMM		BIT_ULL(55)
>> +#define ARCH_PEBS_VECR_EXT_SHIFT	49
>> +#define ARCH_PEBS_VECR_EXT		(0x7full << ARCH_PEBS_VECR_EXT_SHIFT)
>>  #define ARCH_PEBS_GPR			BIT_ULL(61)
>>  #define ARCH_PEBS_AUX			BIT_ULL(62)
>>  #define ARCH_PEBS_EN			BIT_ULL(63)
