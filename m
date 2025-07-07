Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78FB2E3716;
	Mon,  7 Jul 2025 20:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751918980; cv=none; b=oaWN2B7e5Zdar2NRkCBEig9mpc37MR2gxpXZX0mLZHY9d5hgfi2A6vDV/LntzVLD9MuzE6mDkwpEwO6pylnMSbxCnMjCiTjP5Nzj9jHIBWxvn4bKz6lk5ayxNk8BLBPG94CSz5l3bcxu503QonMihFpx2Ky+uuqBacdTl8XbfAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751918980; c=relaxed/simple;
	bh=da+fGjeR8PuNyC5ERi/ihyLzHkvqhkeA1HDz+MUPOV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WsWAfrSdMdyIye5VujdvuI9PlJ2+X+sa8jxGG9ObqpbdLPDWlGEbMfFFyWENHxi9nESA3lMHBF8a5e2p2wtOssYALXBPgDfWqRm4dVJwiFXzncp9k0QbkmOukj4LiK5BD38vOKz33ZaLMwKdQzY8kjg1hNJMy0PXErsosrFzzRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OwCwspAp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OwCwspAp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751918978; x=1783454978;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=da+fGjeR8PuNyC5ERi/ihyLzHkvqhkeA1HDz+MUPOV4=;
  b=OwCwspApgpeFCxfFMGehq8gxIL/6afHfWnd5x7BoOJawZgay4haQSgVR
   TYlo8/b3rw3YsAg6HgAo3QJE+O+mLayLBP474+L2P6utY2lyxGTlY6cQP
   LT5QsYKayV0EMlVGW45zqP1rz/fKFqfczmEhzPst8mRtccQZQarbP3hHs
   6bmAQizoyeodlw9721tEvgSPwNx2Op3itCk0uIC0eyXUPXUsw5/ih2PXk
   DiOCRD2tDD2zJKPTPJlDA0L6Fci9NifLD2ngb3Ntdrl1cYeL1eLUp61Tg
   94RYK/nbRBj9kEYRFicSEKW52IcKUAAYyWidoqSXgU4yreseUc6bgdOy2
   Q==;
X-CSE-ConnectionGUID: /y2D1lDNSTWciAqFpRLKlw==
X-CSE-MsgGUID: ZSkJ1ZffQda9HNyjmJP0Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="65499917"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="65499917"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 13:09:38 -0700
X-CSE-ConnectionGUID: HIdD+pXVScyyrtfwtSwLkw==
X-CSE-MsgGUID: tZZNnU+FRvm/rNFBd16Arg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="159847509"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 13:09:38 -0700
Received: from [10.246.167.181] (kliang2-mobl1.ccr.corp.intel.com [10.246.167.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 3D2FA20B571C;
	Mon,  7 Jul 2025 13:09:37 -0700 (PDT)
Message-ID: <6e0c8d1e-a4ed-4b65-a3f0-8801db53e5f1@linux.intel.com>
Date: Mon, 7 Jul 2025 13:09:36 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/4] perf: Support Panther Lake uncore
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, irogers@google.com,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20250703165614.606446-1-kan.liang@linux.intel.com>
 <b77f58ac-17ac-4397-b1de-d6a8ac9793c3@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <b77f58ac-17ac-4397-b1de-d6a8ac9793c3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-07-03 6:24 p.m., Mi, Dapeng wrote:
> 
> On 7/4/2025 12:56 AM, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Changes since V2:
>> - Rebase on the later tip.git
>>   rdmsrl_safe_on_cpu -> rdmsrq_safe_on_cpu
>>
>> Starting from the Panther Lake, the uncore discovery table mechanism is
>> also introduced into the client platforms. The difference is that the
>> portal of the global discovery table is retrieved from an MSR, rather
>> than MMIO space.
>>
>> The first two patches provide a generic support for the extension of the
>> uncore discovery table mechanism.
>> The rest patches enable the uncore PMU on Panther Lake.
>>
>> Kan Liang (4):
>>   perf/x86/intel/uncore: Support MSR portal for discovery tables
>>   perf/x86/intel/uncore: Support customized MMIO map size
>>   perf/x86/intel/uncore: Add Panther Lake support
>>   perf/x86/intel/uncore: Add iMC freerunning for Panther Lake
>>
>>  arch/x86/events/intel/uncore.c           |  7 ++
>>  arch/x86/events/intel/uncore.h           |  2 +
>>  arch/x86/events/intel/uncore_discovery.c | 89 ++++++++++++++++++------
>>  arch/x86/events/intel/uncore_discovery.h |  7 ++
>>  arch/x86/events/intel/uncore_snb.c       | 79 +++++++++++++++++++++
>>  arch/x86/events/intel/uncore_snbep.c     |  4 +-
>>  6 files changed, 166 insertions(+), 22 deletions(-)
> 
> The whole series looks good to me. Thanks.
> 

Thanks. I will add a reviewed-by tag from you in V4.

Thanks,
Kan

