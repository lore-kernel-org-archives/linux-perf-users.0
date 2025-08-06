Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C051E49F;
	Wed,  6 Aug 2025 00:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754440318; cv=none; b=XhWrWMqJM65Gx5tf3gF6lYQ58x9b5MW9SdeqLmEXwG83kej9ZuU8HouUfRkA4Mjwr8WD07/f/8Yp+x7QfiYq86n4/RY7qj+HiAnZ8uzJxbmF3nbSlyBquYqTyD31zWG2DSK77l8d5tZYP29l3BpcCZJfCLDlrwhfhZiyT1J6ufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754440318; c=relaxed/simple;
	bh=4zmQW9P3pk7Gnm2G3ECHQv/n2CS39Br075AHVDBqKPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGxiOfdxux+9p+9K7s68ecJJMc7rxIvuP5wvvlwY8qLkMkVFwXgClHdrVOTi+MpPe8nHijSAsDATuEAForDSfon97zaAq//ul+Vxabpn9U2Ph8Zjf6OYN5fLf1jZZtV1c2+9rpd86n1+imVjnufOZrtNwcyOsij/DBOmgxnaYSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2z0onBo; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2z0onBo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754440317; x=1785976317;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4zmQW9P3pk7Gnm2G3ECHQv/n2CS39Br075AHVDBqKPU=;
  b=V2z0onBozTa4y65aP9fs6CiHmS95aIHaJLo35RL8DsgjFBkttrL9J9bj
   r/aQniMwgNBoW9DBXgbE43lT25od3anjq0Gn5Ez8drLN/Q12/5ppRE4pz
   dhEAqSTerv4EpjBxT2UZgWPyaMXiM/rNmzWBXuYCu+ycU/mKhaBMsRQov
   Fr+XUiabKXpj8ipOepueLhY7txZY+inPNLOLjskprlraOoto7LDqfB13+
   d31MOHUb8dwDWFcx0WdLuOwWrvDtG6k14/160t54rGupP2y8w+F5eBItU
   U+a2mP4Sq+oLl7pSQl4z6m8hWm9Iprb/czcDgxGVSlyfP+wdMuBK23eA3
   A==;
X-CSE-ConnectionGUID: IqY3+tiAQOaXn2vn08pq4w==
X-CSE-MsgGUID: /y+FLtIESL2mdEaJIOE1bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11513"; a="59366365"
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="59366365"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 17:31:56 -0700
X-CSE-ConnectionGUID: Phc5g1kVSdi2CFHRSBlJ0A==
X-CSE-MsgGUID: pL+ThEXdTTSscRrNvjJcow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,268,1747724400"; 
   d="scan'208";a="168889109"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.106]) ([10.124.240.106])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2025 17:31:53 -0700
Message-ID: <58f01b41-5acb-47d1-a68e-d496d45bb298@linux.intel.com>
Date: Wed, 6 Aug 2025 08:31:51 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] perf tools kvm: Use "cycles" to sample guest for "kvm
 top" on Intel
To: Aditya Bodkhe <adityab1@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kevin Tian <kevin.tian@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250805004633.135904-1-dapeng1.mi@linux.intel.com>
 <20250805004633.135904-6-dapeng1.mi@linux.intel.com>
 <c1076dbd-de63-4a9e-a097-de0f64c74a95@linux.intel.com>
 <5b4882dc-c90d-409b-8355-45d8b96df93f@linux.ibm.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <5b4882dc-c90d-409b-8355-45d8b96df93f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/5/2025 7:32 PM, Aditya Bodkhe wrote:
> On 05/08/25 6:27 am, Mi, Dapeng wrote:
>> On 8/5/2025 8:46 AM, Dapeng Mi wrote:
>>> As same reason with previous patch, use "cyles" instead of "cycles:P"
>>> event by default to sample guest for "perf kvm top" command on Intel
>>> platforms.
>>>
>>> Reported-by: Kevin Tian <kevin.tian@intel.com>
>>> Fixes: 634d36f82517 ("perf record: Just use "cycles:P" as the default event")
>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>> ---
>>>   tools/perf/builtin-kvm.c | 30 +++++++++++++++++++++++++++++-
>>>   1 file changed, 29 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
>>> index 7e48d2437710..d72b40f3df12 100644
>>> --- a/tools/perf/builtin-kvm.c
>>> +++ b/tools/perf/builtin-kvm.c
>>> @@ -2075,6 +2075,34 @@ __cmd_buildid_list(const char *file_name, int argc, const char **argv)
>>>   	return ret;
>>>   }
>>>   
>>> +static int __cmd_top(int argc, const char **argv)
>>> +{
>>> +	int i = 0, ret;
>>> +	const char **rec_argv;
>>> +
>>> +	/*
>>> +	 * kvm_add_default_arch_event() may add 2 extra options, so
>>> +	 * allocate 2 more pointers in adavance.
>>> +	 */
>>> +	rec_argv = calloc(argc + 2 + 1, sizeof(char *));
>>> +	if (!rec_argv)
>>> +		return -ENOMEM;
>>> +
>>> +	for (i = 0; i < argc; i++)
>>> +		rec_argv[i] = argv[i];
>>> +
>>> +	BUG_ON(i != argc);
>>> +
>>> +	ret = kvm_add_default_arch_event(&i, rec_argv);
>>> +	if (ret)
>>> +		return -EINVAL;
>>> +
>>> +	ret = cmd_top(i, rec_argv);
>>> +	free(rec_argv);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>>   int cmd_kvm(int argc, const char **argv)
>>>   {
>>>   	const char *file_name = NULL;
>>> @@ -2135,7 +2163,7 @@ int cmd_kvm(int argc, const char **argv)
>>>   	else if (strlen(argv[0]) > 2 && strstarts("diff", argv[0]))
>>>   		return cmd_diff(argc, argv);
>>>   	else if (!strcmp(argv[0], "top"))
>>> -		return cmd_top(argc, argv);
>>> +		return __cmd_top(argc, argv);
>>>   	else if (strlen(argv[0]) > 2 && strstarts("buildid-list", argv[0]))
>>>   		return __cmd_buildid_list(file_name, argc, argv);
>>>   #if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
>> This patch would impact powerpc platform as well. Base on the comments
>> before kvm_add_default_arch_event() in
>> tools/perf/arch/powerpc/util/kvm-stat.c, I suppose powerpc also needs this
>> change, otherwise "perf kvm top" command can't sample guest records. But I
>> have no any powerpc on my hand, so it's not tested on powerpc platform. Any
>> test on powerpc is appreciated. Thanks.
> I have powerpc systems . I will test can share the results .

Thanks.


>>
