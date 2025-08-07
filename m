Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E44B79EA;
	Thu,  7 Aug 2025 02:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754535179; cv=none; b=a9sQQl0I/jTqQmX3EvYIX0asbKMzxHR55sLqrKs5N5JhW/qlcQKDgSf0MAnoMX/1ttJPewT7hC0oUYoTYjfggqz2FmOMk1f/B6gYI4xhxk1Q6LJkmByr5BdLTBg75qbZ4+chpj3NgDhDvAR6Ie7hKGosVg04yUrujzlgOch2YE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754535179; c=relaxed/simple;
	bh=gZFjTgFHl9PFR5O3tHwMjE+oPoDViFOHMqlALpxisQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQcLgttcLf49ZUqk7Bdf0cnUxAGbNF5xfD0pnRbNfJSGE4AM4ybq04tgTChuW613ibpoW2Cc8NnN9PHL73XOyuVfDneVvF/MFQyNLT1Jxu5tUwLGTFN6LOAaFwIXPCCjZ9Dl+WokVQak2k+ISGYoN6WX8c+f1wF9Z+eMUVBVdwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ytp5BJaP; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ytp5BJaP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754535177; x=1786071177;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gZFjTgFHl9PFR5O3tHwMjE+oPoDViFOHMqlALpxisQo=;
  b=Ytp5BJaPhiajTnjRapsFC7PcE4YVuf+FbvtYRYO1jz4/3ttylFBldtU0
   w8QLREesgFDROp+J/+8hL9Q3UW1KmgZMToMjX+9yZel0eobd52gj8nZpV
   ut/o98j67D3SR5EREONc88kpOrRjLrJ6u1XNRdBPMeK1rthwSYNWAmPCL
   Sqif+2/rma1nsNecerVu1vQlX0CITbhK/5K8Kuss6o1L0UmI8piJiK4Zr
   7s+euFli+rklS8CGxNX7SEc1Y1PAubhrxWNqLYfSMotd9TC3Sh2GRP+ml
   8fQhEufnwNalPeNORHd73tuwxVqnJp6IU6KHrGh3CBIOUXbw/iBkvS4JE
   A==;
X-CSE-ConnectionGUID: U5VTtx7jQK+hjLolI6eX0A==
X-CSE-MsgGUID: Ht0SIp2HQO+oT7lvUlQYyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56938188"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="56938188"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 19:52:57 -0700
X-CSE-ConnectionGUID: pRIuQ6PURmKbTDTKoQaSmA==
X-CSE-MsgGUID: beJ3D0LATxKzFjwJwCridQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165301737"
Received: from leiliu4-mobl1.ccr.corp.intel.com (HELO [10.124.240.106]) ([10.124.240.106])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 19:52:54 -0700
Message-ID: <ee3bd940-d033-4dae-bc4a-dea9dd664fef@linux.intel.com>
Date: Thu, 7 Aug 2025 10:52:51 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] perf tools kvm: Fix the potential out of range memory
 access issue
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250805004633.135904-1-dapeng1.mi@linux.intel.com>
 <20250805004633.135904-3-dapeng1.mi@linux.intel.com>
 <aJPrD_9J0SLiLFh9@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aJPrD_9J0SLiLFh9@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/7/2025 7:53 AM, Namhyung Kim wrote:
> On Tue, Aug 05, 2025 at 08:46:30AM +0800, Dapeng Mi wrote:
>> kvm_add_default_arch_event() helper may add 2 extra options but it
>> directly modifies the original argv[] array. This may cause out of range
>> memory access. Fix this issue.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  tools/perf/builtin-kvm.c | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
>> index f78a67a199ff..7e48d2437710 100644
>> --- a/tools/perf/builtin-kvm.c
>> +++ b/tools/perf/builtin-kvm.c
>> @@ -2002,12 +2002,12 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
>>  	int rec_argc, i = 0, j, ret;
>>  	const char **rec_argv;
>>  
>> -	ret = kvm_add_default_arch_event(&argc, argv);
>> -	if (ret)
>> -		return -EINVAL;
>> -
>>  	rec_argc = argc + 2;
> While at it, can we add a comment for this too?  I believe it's for "-o"
> and filename.

Sure.


>
> Thanks,
> Namhyung
>
>
>> -	rec_argv = calloc(rec_argc + 1, sizeof(char *));
>> +	/*
>> +	 * kvm_add_default_arch_event() may add 2 extra options, so
>> +	 * allocate 2 more pointers in adavance.
>> +	 */
>> +	rec_argv = calloc(rec_argc + 2 + 1, sizeof(char *));
>>  	if (!rec_argv)
>>  		return -ENOMEM;
>>  
>> @@ -2019,6 +2019,10 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
>>  
>>  	BUG_ON(i != rec_argc);
>>  
>> +	ret = kvm_add_default_arch_event(&i, rec_argv);
>> +	if (ret)
>> +		return -EINVAL;
>> +
>>  	ret = cmd_record(i, rec_argv);
>>  	free(rec_argv);
>>  	return ret;
>> -- 
>> 2.34.1
>>
