Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3109224D7
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 07:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709190133; cv=none; b=qkIV/uVZIQXTRcEWLZP1HcMteBDJDd3DNK8iDBJQvQOqUORqPTY4rW0AXNxnxia+Fz4yjVzvHfkMNH0XbioRGV4txSRoYHzv9aHRQM5rnnlEc44k9tULvT0ifd2bn7edQSBMlbHw601s3zfurfByIInKjFdt/YcndU12QUefA0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709190133; c=relaxed/simple;
	bh=wAVrFempWlg01MMi4r/5oignXr3XFhvoi0WWNMt/nyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TyJTbms8431G9Tz117ypHxeTClMCvQU6ryFv71dv11S4zoNsXOxc30tBMzcEzX2OYh8BvCFeGKHPIisLC1+1edIZFP8DWdPT1EYR27uAprP06jon6bwbbppwScYOXwSwld4NN7bsyvTDbJQzBYhZbkB9rWXzG8rfuY0dmnn9k94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QybLjQGK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QybLjQGK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709190132; x=1740726132;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wAVrFempWlg01MMi4r/5oignXr3XFhvoi0WWNMt/nyI=;
  b=QybLjQGKyl5mbILt3Fp6bpQ8CqUbLrjEARiyVP7A6dgX/ewGswdkrE/w
   MQ9xPyrsmbWp+vHVlzaH4vgFT2tWqaEIkH0pNIYmray8UBto7+Bc5Vx5Q
   QjP1M54zTjYCAApNMjS52d/y52ABhb40Z0XiQHJZbtrFEsexC5/V+3CHd
   MFNg/KUCmJ8oI90r3O6+/4mOA1otBsvqHPHjqlxeG5XQ2AOVZ55w7oWoW
   YhvSVs99LVKRZIA7rnd1i+NBdrN+/aWDFPlYLUb2389L84XJ5U+Lxsw4B
   SDXR/4CKbuDdSCpDXcNhaJMuRUEvvv2PNhMCs+UBHBwb436uA++lwueI+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3563340"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3563340"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 23:02:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="12411729"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.103])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 23:02:09 -0800
Message-ID: <9cc8cb50-fb42-4eea-bd23-e03e9a0f9205@intel.com>
Date: Thu, 29 Feb 2024 09:02:05 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf, capstone: Support 32bit code under 64bit OS
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, changbin.du@huawei.com
References: <20240227234806.82694-1-ak@linux.intel.com>
 <7ca41f7f-28b2-4f3c-8c04-1dba110d3135@intel.com> <Zd_CHC8NOW5Ig7SE@tassilo>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <Zd_CHC8NOW5Ig7SE@tassilo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/02/24 01:30, Andi Kleen wrote:
>>> +	bool is64bit = machine__is(machine, "x86_64");
>>> +	struct dso *dso;
>>> +
>>> +	addr_location__init(&al);
>>> +	if (thread__find_map(thread, sample->cpumode, sample->ip, &al) &&
>>> +		(dso = map__dso(al.map)) != NULL &&
>>> +		(dso->data.status != DSO_DATA_STATUS_ERROR)) {
>>> +		map__load(al.map);
>>> +		is64bit = dso->is_64_bit;
>>> +	}
>>> +	addr_location__exit(&al);
>>
>> Maybe 'al' could be passed down through perf_sample__fprintf_insn()
>>
> 
> These are different addresses -- one is for the IP and the other is for
> the immediate. It seems cleaner to support separate ones.

They are both sample->ip

