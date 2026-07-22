Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3CC35CB9C
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 01:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784682468; cv=none; b=YVJOZ0CGKbb2XjjHQUhWhDnW+Ob/PX0rcfJh61Pz9kVc9OYD1JYDyw4nSRIzkRapmVgRAceZgf4uRHVa7UlvHZDFJRfnQocH4WCurErHWZE4OhD2iqeZxyN/mfUxW+mBQSlgnkGU4qo82KdaQWwhdJYYX4RJKXDesepTXoZilnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784682468; c=relaxed/simple;
	bh=taqA9iz/42s+3gLyeGXBKvKWXDf31Xkuvf8LsINCkjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sl/J0Tbk4psJcgSNWh/SoQOllROl/Ff7hJRiQp8b1U/wE7PjHTqBqV84wKGNf9gFQnmm36xK+xwnNYKa5HGyPI7AmFiLD6XCWTKO/JrJbrGeUTFVhPsGfzy2kelt986KP+VntQBoM26J/FMVBtYtL1Cq48nu9f8EaoV9yEax/UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ceUwtd8h; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ceUwtd8h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784682466; x=1816218466;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=taqA9iz/42s+3gLyeGXBKvKWXDf31Xkuvf8LsINCkjk=;
  b=ceUwtd8hcf4dLX3p9O8q0aSrvByLVYUeN9fg5cREHm8beqnd+8qN3Xl0
   EFmAcwlIoDWg1inYhoJg1VoDXrNFiGMyhqoOMhSzDgFx7on5nPQeM6q9n
   +GDIsUUqghqS9NDnrsJdnW4UbIWeFysSVqqbgKma6cAf+XIeYqUoA0GG1
   03+6E5v+ZyIktJAcCDyPX+fKQm7aVoNp+Rbchs2vNUVpITGJ+xdK9aqM5
   lIrKmsS/SYO5CU4zno5EczJqq4r0LZrZDwljqOZX+aNnTKT1GknnlFxgV
   eIk40Py7S7YZ5nksnOsEQU+7svYXl3X/D8Llq4Epn/HjO0zogbCqvwgs2
   g==;
X-CSE-ConnectionGUID: +aa/rkART+qdFkVfjiu3Xg==
X-CSE-MsgGUID: nMenzHD9QgOIiE+tfd4W/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="110848380"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="110848380"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 18:07:46 -0700
X-CSE-ConnectionGUID: VTfHVIErTxGD/0UjzpNi/A==
X-CSE-MsgGUID: YQJqPnbLRCe0qAqJbtLgSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="261493762"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 18:07:45 -0700
Message-ID: <722229c5-675a-4523-8437-08afa6047499@linux.intel.com>
Date: Wed, 22 Jul 2026 09:07:42 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v10 03/10] tools headers: Sync x86 headers with kernel
 sources
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260721072707.3787848-1-dapeng1.mi@linux.intel.com>
 <20260721072707.3787848-4-dapeng1.mi@linux.intel.com>
 <20260721073947.713061F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260721073947.713061F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/21/2026 3:39 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Header synchronization mismatch: tools/arch/x86/include/asm/msr-index.h introduces macros not present in the core kernel header.
> --
>
> --- Patch [3]: [Patch v10 03/10] tools headers: Sync x86 headers with kernel sources ---
> commit a80378c4387abdba00fb87b0094f51fec90aa452
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> tools headers: Sync x86 headers with kernel sources
>
> This commit adds ARCH_PEBS_VECR_xxx macros to the tools version of the x86
> msr-index.h header to sync with the main kernel sources.
>
>> diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
>> index eff29645719bc..8cbc4c4997065 100644
>> --- a/tools/arch/x86/include/asm/msr-index.h
>> +++ b/tools/arch/x86/include/asm/msr-index.h
>> @@ -350,6 +350,13 @@
>>  #define ARCH_PEBS_LBR_SHIFT		40
>>  #define ARCH_PEBS_LBR			(0x3ull << ARCH_PEBS_LBR_SHIFT)
>>  #define ARCH_PEBS_VECR_XMM		BIT_ULL(49)
>> +#define ARCH_PEBS_VECR_YMMH		BIT_ULL(50)
>> +#define ARCH_PEBS_VECR_EGPRS		BIT_ULL(51)
>> +#define ARCH_PEBS_VECR_OPMASK		BIT_ULL(53)
>> +#define ARCH_PEBS_VECR_ZMMH		BIT_ULL(54)
>> +#define ARCH_PEBS_VECR_H16ZMM		BIT_ULL(55)
>> +#define ARCH_PEBS_VECR_EXT_SHIFT	49
>> +#define ARCH_PEBS_VECR_EXT		(0x7full << ARCH_PEBS_VECR_EXT_SHIFT)
> [Severity: Medium]
> The commit message states "Sync newly introduced ARCH_PEBS_VECR_xxx macros
> from kernel". Are these macros actually present in the main kernel tree?
>
> Looking at the core kernel version of arch/x86/include/asm/msr-index.h, these
> definitions do not appear to exist.
>
> If they are missing from the main kernel header, won't this cause a
> divergence between the tools header and the core kernel header, resulting
> in warnings from tools/perf/check-headers.sh during the perf build?

The kerne header change is in a separate patch. Thanks.

https://lore.kernel.org/all/20260721062506.3745816-21-dapeng1.mi@linux.intel.com/


>
>>  #define ARCH_PEBS_GPR			BIT_ULL(61)
>>  #define ARCH_PEBS_AUX			BIT_ULL(62)
>>  #define ARCH_PEBS_EN			BIT_ULL(63)
