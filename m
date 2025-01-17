Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6E51547E0;
	Fri, 17 Jan 2025 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737127262; cv=none; b=PCF0UE3JR48d19Dag6f+yaBzDU3WeDn8nqcR4IxayvMUk5bR2eLzzP3rcR7C1HOqGF1PbbsWqkhQW4lMFrZaRSOUJ2ZNHNaCDqifeeg0xJl3e8seE7oFOS0/IDAxyMFovovaGwqvR/r38QQmrRllQkgL/dIoxns2vK+N5lUPq+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737127262; c=relaxed/simple;
	bh=3yTV0rPB2aKy5URiZ8E5viCtctsqFhmTHoF2sOB45D4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBneyTv+er5IHu78a6qyB3RhCfh1CJR142NR/9uWMiQ23gnfjU3BBBUIMjh6kadNqL10WkHoSpg3uekSXO35W9CdGSDxrrlF5CFZSBdS8AZq4sGiBF58cXjztfHsgJF9M9JnP2hVVolhwM3eYUQQZPV1e0VtxMEbV95bPwgM7NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nl+pc7WR; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nl+pc7WR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737127261; x=1768663261;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3yTV0rPB2aKy5URiZ8E5viCtctsqFhmTHoF2sOB45D4=;
  b=Nl+pc7WRL9pzzo+Bbufasc469AemM4uwtVxtbKQ8+zXnsNTxwloyGLnv
   19tmnW7us48LT9Jdwi7yRs6cDxi7tkggzMVJ+Q4OdGcQMuzmY8iScu9US
   nqcsNTfDBkPZL8U4Bf2PUHsrUxxeW9Xf42ltrBXmOfnSUAm4Z1wJyLiR8
   2+QKeEKF/Frbd+7KffuORI7s/ha2xFy14613FA4DIGJhpkuaE1w+Tucm1
   5WwALGVqP3zb2uKyG4K9O4wOJ4Ol9I74GF7jwlwPNuAbNuOc2mX0jPXTK
   EmTiB/Kp0EXNDyUwaFG+4a1qKVVaoshsEYRJCM8WMVndPJO8W/B3LXCd0
   A==;
X-CSE-ConnectionGUID: RjeRz+dhTcKLwmrK3aWAAA==
X-CSE-MsgGUID: tfnpQtaLQbyeXRxoB3Paog==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="25156242"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="25156242"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 07:21:01 -0800
X-CSE-ConnectionGUID: sgfUzrt1RiCmlwmu2MUcgQ==
X-CSE-MsgGUID: SSzHRBJASfqliLuqkbUy1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109893934"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 07:21:00 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id DA52520B5713;
	Fri, 17 Jan 2025 07:20:57 -0800 (PST)
Message-ID: <3affdb02-19ab-45e6-98ae-d8e90dd8a121@linux.intel.com>
Date: Fri, 17 Jan 2025 10:20:56 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [UNTESTED][PATCH] perf/x86: Fix limit_period() for 'freq mode
 events'
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, eranian@google.com, irogers@google.com, bp@alien8.de,
 x86@kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, santosh.shukla@amd.com,
 ananth.narayan@amd.com, sandipan.das@amd.com
References: <20250115154949.3147-1-ravi.bangoria@amd.com>
 <62c13793-f4b4-4e2e-b6bc-0de2427ea93e@linux.intel.com>
 <5f2c62d4-1bfa-458d-847e-095979a4bf54@amd.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <5f2c62d4-1bfa-458d-847e-095979a4bf54@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-01-15 11:21 p.m., Ravi Bangoria wrote:
> LGTM. And you can remove the if (event->attr.freq) check from
> intel_pmu_has_bts_period().
> 
> Mind sending a proper patch series?

Here is the series. Please take a look.

https://lore.kernel.org/lkml/20250117151913.3043942-1-kan.liang@linux.intel.com/

Thanks,
Kan

