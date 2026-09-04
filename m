Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A492131E49
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 00:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481346; cv=none; b=C3AEGS8gfCZBW4Z8/fWF6E6y14MVii/diL6WtYg5iAE6VI5hFPv130N+oRkb0tssRiSetomE68Y0AwYXWSYcCcqz/JsgLoefeu4/fZPLcGqYxn4yYkBKKXGIQo7KIo6McbTp384wmR8vpUWo+EMWE90xDUmxb+ZCnjL8mAtW/nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481346; c=relaxed/simple;
	bh=canjJ1hDItg2dUA//rbTmSu8Z2w4/pmyKheyAxPz1hQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbdSFSeK8aJwPeEaji0NcZPvhLr7+amjuTyl0ur7GprlBpBGRRlZJAtQQTVsIUMwm+AdiXPHxkggfOIWC29fDS0VxkEf4KvNv4JGBZddS2A5VJhikhrd4KddoSRKsz8L47Bj4t3XnF8hbqIwvjtrQYgRgldngnE9qhlUZGdcuko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EPWOCI6Z; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EPWOCI6Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788481344; x=1820017344;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=canjJ1hDItg2dUA//rbTmSu8Z2w4/pmyKheyAxPz1hQ=;
  b=EPWOCI6Z8X+F0KQTuLYzrbGeqjTMAiAwqq0CnZNK/2WeGbUJ0h8FO8ZC
   ZigOFWJf7m8pMdZlYbq+3RoICgq1zyJBiOnh4MVrUF2Jm7kRrUg6s9lQd
   YnVRhLB9B37y4w0rWpLz4yB8iwQeSmW7SRQtZ6mdrwZxyBssl8FYXI6T0
   bUkq+8RLA8mZdqNwPEjzJIN2RL2VAcOrF+gqQRZwrOtWAXJAPJSogZRl1
   ssbcxs6vfCxViPqQiSCIIGlonMrwZskOjlN9g1J0oLlJg7k72XySSt5iz
   L31VNG/GT5y30go75YyF44JShIwHiMC7rSdaf+hHfogaVUY94zYWt5kfj
   A==;
X-CSE-ConnectionGUID: ghqCLgSHRt+0Tmd7f9njSQ==
X-CSE-MsgGUID: PDtgkNPjSm+AZNuojDPJyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92851261"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92851261"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 17:22:23 -0700
X-CSE-ConnectionGUID: V49YCHLRSgCpMKYpTKZmPw==
X-CSE-MsgGUID: HMKh1ARtRN2K/mMBNCUZvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="269870819"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 17:22:23 -0700
Message-ID: <f0e05b97-1cce-427b-a56c-57a031cfe1ac@linux.intel.com>
Date: Fri, 4 Sep 2026 08:22:20 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DISCUSSION] Three problems behind broken "perf --call-graph
 dwarf" on AMD: IP and stack dump mismatch, libdw fails on lld's layout, and
 the unwinder fallback never runs
To: Ravi Bangoria <ravi.bangoria@amd.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Gennady Kupava <gennady.kupava@gmail.com>,
 linux-perf-users@vger.kernel.org
References: <CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com>
 <apCyQ93c48Dy4H-S@google.com> <apG-RzV0zyjoC-FY@google.com>
 <27d79477-c469-413b-95bd-c6c1f8a40f55@amd.com> <apbs8gywyAfFVzqm@google.com>
 <c38b254f-21e5-4a02-8934-7a4da61e4571@linux.intel.com>
 <7b4cba95-dacc-4cf1-953f-c59e06e693d0@amd.com>
 <a5d3798c-7d62-43d0-88c6-eec26bd4f63d@linux.intel.com>
 <0e5e1fd0-0a46-4c1c-a391-5c245d903834@amd.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <0e5e1fd0-0a46-4c1c-a391-5c245d903834@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/4/2026 12:02 AM, Ravi Bangoria wrote:
>> Suppose we need to follow below 2 rules to ensure the correct call-chain
>> unwinding and register snapshot consistency.
>>
>> 1. All registers including IP should come from either PEBS or PMI, must not
>> be mixed. This ensures to get an consistent registers snapshot.
>>
>> 2. Either SAMPLE_CALLCHAIN or SAMPLE_STACK_USER is required, the PMI
>> registers snapshot must be used. This proves the correct DWARF unwinding.
>>
>> How's your idea?
> Looks good. Mind sending the patch?

Yep, let me cook the patches. Thanks.


>
> Thanks,
> Ravi
