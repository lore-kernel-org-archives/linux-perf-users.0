Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB48D27BF93
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 02:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783476362; cv=none; b=CxvGJ0Cuk9zW5567mPW0itUsUFHwTNw23LTQnDI90fx3gvO6juuuz3t/o754B96TzjzZhqtwlKQZRmlOeFb/KtKOHFG31Z1SlNe/tA/+KntUZHSig25a1PZjN+6NLrAADqhMA7VO9WhiHz5efoMLeQndqvahhpG7EA1XEOG8/Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783476362; c=relaxed/simple;
	bh=mMPry6uRTy2lPY2gsm7mpDr69MtIalJaD3Aq9rikVlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DS7b1w7IBHoKyBQyTakLalWy7RQtYsdZUOFAwWT4w0hNYb0ZE1xbXOz1o6WeCYJabVApYlVVRxPexHXS5Of9fPiYGOTt5fUj7SlxGpHIGz2I3k/QfMka+bdxL8H9lbKVbEDw3WCmsbyuDVx2MxMW5E/dZqjMS6G71SkuyQzSbGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VyEAPmf4; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VyEAPmf4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783476361; x=1815012361;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mMPry6uRTy2lPY2gsm7mpDr69MtIalJaD3Aq9rikVlk=;
  b=VyEAPmf4XeoY/bXcL2WNVWYga5BKmceRj3z1U6eNfxGUY+EBYzUolpN6
   qqA6cfdVcv5HvZOAyTfMxw2dimQQEsFw4Ok3w/eDAxkNrvh8zcCuBOLt5
   2BkngQUM5y8ZP3yla7ajYfADv1xxhht+/os9krqjzyUxtZ1TUEFt4uc9b
   XYSD6SuSwK1BM8tUOlg7FCV+FdJk0HxDQyDWhBvqI09y1RW8CZin8Iww9
   HOpaV4+Yr8WKgNcvN2xhTusDKnmkW06eZ1OdkSbOMpwGtHqAhsPQM/uly
   1l7MZKY/ZSJmUrwDvt3oZUJkL0akTdOm7BsAd4l0Wdb6BGakQMQlXnfVe
   A==;
X-CSE-ConnectionGUID: AG01rrXbR7+zQMYexA9a5Q==
X-CSE-MsgGUID: AEkBd1EwSqiK8nevkBwCjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84191169"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84191169"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:06:00 -0700
X-CSE-ConnectionGUID: QIQ7CzJ6TJ6r3X+FGar3xw==
X-CSE-MsgGUID: bj3BMOEiSliGi9vkmO9Ezg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277361279"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:05:59 -0700
Message-ID: <83893ff1-cc40-45dd-a14f-4ce6f66bcc4b@linux.intel.com>
Date: Wed, 8 Jul 2026 10:05:57 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 03/10] tools headers: Sync x86 headers with kernel
 sources
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260706023444.3067660-1-dapeng1.mi@linux.intel.com>
 <20260706023444.3067660-4-dapeng1.mi@linux.intel.com>
 <20260706025423.D60241F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260706025423.D60241F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/6/2026 10:54 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Modifying a tools header without a corresponding kernel header update causes a synchronization divergence and triggers build warnings.
> --
>
> commit f29e894bc895095793a45b66351922174d49d6a4
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> tools headers: Sync x86 headers with kernel sources
>
> This commit attempts to synchronize the x86 msr-index.h header in the
> tools directory with the kernel sources by adding ARCH_PEBS_VECR_xxx
> macros.
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
> [Severity: Low]
> Will this trigger a Kernel ABI header differences warning during the perf build?
>
> If the corresponding kernel-side macros are not already present in the
> arch/x86/include/asm/msr-index.h header of the tree this patch is applied
> against, check-headers.sh will flag a synchronization divergence. 
>
> Are these macros being merged in a separate patch series that needs to be
> applied first, or did the kernel counterpart miss getting included in this
> series?

The kernel header update is in a separate patchset which the cover letter
has mentioned.


>
>> +#define ARCH_PEBS_VECR_EGPRS		BIT_ULL(51)
>> +#define ARCH_PEBS_VECR_OPMASK		BIT_ULL(53)
> [ ... ]
>
