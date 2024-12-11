Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FC81C1F22;
	Wed, 11 Dec 2024 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733948006; cv=none; b=lLj6vc1EruHLYIEBOm54mqDdN5t0qKbqSSClM5Cr3oC2a56g3x/B7YECUMqr+OXVZXTO2xzCaa2WMhYOau7RE4VpoWn9+ULVa9S1B9A9Ii0do/h/8RA1uszvr+o7z2UB3r2C6fYtCnQz8UXYcscRbZxsA8CV/xMu99kln9rHbhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733948006; c=relaxed/simple;
	bh=M9tqm7M5xEyPoI7Qe0ddPQqkL4vNL21Znf8hpSrrsdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vii8tZmiLXHD8zid1Z6qe5mmtzYmjpgHsTRdQoZby41R/amytwq5Kc6VzzroIJ6dkGbyj6RVpZH8F8LH2ZXKRQlK4eAt7V9ECEf/HuXDXxOLl6Uy10VPK++SHlVZ3zodFj7UCD6Chg3YNV6giY45bWSa/tKNopnTCS/M/kAaR9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gyaqa5Lr; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gyaqa5Lr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733948005; x=1765484005;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M9tqm7M5xEyPoI7Qe0ddPQqkL4vNL21Znf8hpSrrsdA=;
  b=gyaqa5Lri3b+1H8s7lhnAqaLHEUmjMskpznDvqVwNd3tE3n1LfbXoIzJ
   0mYWAk0dOPkZDLNcgvXAIsI9+1nVaZDAwQ21Ct/FRu8/lYmhE98YBKTko
   zedNPIoSN9CkrMMpH3bck+eEDLFyQLW12/5hX7geHYY/Q4nVDlm93z6xg
   6LfHx5SPnNDHqrMpt3BlqY3zK4DOHMGEituR2J6dqemEGg5QUlCuHrd/4
   GGoo+byaWZ+SRDQxWYzaH/elt6bh2q/LKPPByxk9JkFkzZXayc6TOydE4
   swqPb7ZUKKclF1p4RWQjM5xDqWEsiNnyfHSOrj0otQHHAHEYltBE/FSx6
   w==;
X-CSE-ConnectionGUID: +GzIcWTOSfOfse+h4GYYMA==
X-CSE-MsgGUID: EiJWfFBzQOaE2KwzXVIRuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="38277590"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="38277590"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 12:13:24 -0800
X-CSE-ConnectionGUID: 97+ZFRxeRauLSlBjrwTO9g==
X-CSE-MsgGUID: CmWylxYvQqaRRt6XlwcnFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="100775144"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 12:13:24 -0800
Received: from [10.246.136.4] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 06CAF20B5703;
	Wed, 11 Dec 2024 12:13:21 -0800 (PST)
Message-ID: <62e4deb4-77ee-4937-8959-69de462f4d8e@linux.intel.com>
Date: Wed, 11 Dec 2024 15:13:21 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 'perf mem record' on a Intel hybrid system broken
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 James Clark <james.clark@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Atish Patra <atishp@atishpatra.org>, Mingwei Zhang <mizhang@google.com>,
 Kajol Jain <kjain@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Palmer Dabbelt <palmer@rivosinc.com>, Adrian Hunter
 <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org
References: <Z1CVTJ5jzIyNiB1R@x1> <Z1CsX3n5U_q5ehRp@google.com>
 <63eac289-07cb-4c3b-b34d-ea5bd009441a@linux.intel.com>
 <Z1nee9PakNKG_mL3@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Z1nee9PakNKG_mL3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-12-11 1:48 p.m., Namhyung Kim wrote:
> On Wed, Dec 11, 2024 at 12:55:03PM -0500, Liang, Kan wrote:
>> On 2024-12-04 2:24 p.m., Namhyung Kim wrote:
>>> I think I got a related report from the kernel test robot but it was a
>>> Sapphire Rapids machine.  I don't have a Intel hybrid machine in hand.
>>> I'll try to take a look at it on Sapphire Rapids.
>>
>> The default precise_ip level for perf mem is always 3.
>>
>> For the latest intel platforms, it implies PDist, which is only
>> available on GP 0.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/core.c#n4412
>>
>> However, the mem-load PEBS event is available on all GP counters but GP
>> 0. :(
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/events/intel/ds.c#n1176
>>
>> So the precise_ip-- is required.
>>
>> The failure of scheduling returns -EINVAL.
>>
>> But Namhyung's patch assumes that the kernel return -EOPNOTSUPP when PMU
>> doesn't support the given precise level.
>> (Sorry, I didn't notice the case early.)
>>
>> Is it possible to reduce the precise_ip for the -EINVAL as well?
> 
> Sure, please see https://lore.kernel.org/r/Z1DV0lN8qHSysX7f@google.com
>

Thanks for the fix. It looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

