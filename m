Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D87F27F74E;
	Thu, 24 Apr 2025 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745514935; cv=none; b=gk2Jjp8zK2dfzVstzrqw8QtEvj3zrSRAbche1CH76RscpBDGjBjtuE55KcDoQLqxPNc9odHApazUnPC5m+tRhztdOKiqKH4c2YwVQscjUOhluW5aMmGpgo6/ByKjyDjlLog5TYCM9zvuKrk8VMdyy8R5QksKsPJmG2ZatKjSRUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745514935; c=relaxed/simple;
	bh=XaoR7PClb0SuEDbs0teCreX7gq8PsVNzABOfOHAFhNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIe/fjLroSBP4z3oLqf0VqtQqcVE8suqVvS2s8YckhBWYDRX3UGI777BVUlEfOhnYD8Sv11dISHDEHz4eXoZQHOyubJjdDddCQIvLDnrtQ0h7G4VMQ6X3V5LGFBN1PiA/MhTiBNKB28NyYmFeiVbeHHnoEtTNxQbDA6bE8ObyB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TaX3q5pb; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TaX3q5pb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745514934; x=1777050934;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XaoR7PClb0SuEDbs0teCreX7gq8PsVNzABOfOHAFhNs=;
  b=TaX3q5pb/zuVRGfCNhz5ZKvL5+WECx4uKW8uEuP3dLp88pkCOC07KUuZ
   OuR+oQc5pJ1fE0l/JsXOPZO4cdNTY7+sgP2zJuKLV64TJT3k0+iX5d2Z7
   WC4/4dnE5KkGQN+lwe9lsvLv2kqiv4bb5sbEezvEgRPL/RkSzVb2gRuK/
   p9y63Gsae0XjQ139JsKluuSNdsP3hKVdXQccI58a+XMCBNz0BQvh4v1Sf
   IkcVy5l2AsFf6sO8v7q5VGxuu1gq1DgUL4hFhZViZusVRarlk36HP5hJ3
   kZyXVI6RcZ4lSrUlond3Enie+X6F2I0YY0H+CnSY79WCfZ0B4c5r//5LI
   A==;
X-CSE-ConnectionGUID: hopMEa8TScO4/zP+OMfJGg==
X-CSE-MsgGUID: Bjc3qlKUQQqAmw5c3bo1Zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="57810274"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="57810274"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 10:15:33 -0700
X-CSE-ConnectionGUID: WQR/hTFvRxemh0qfAXnt/w==
X-CSE-MsgGUID: lvvIUe7rQdycR7bSCk9UoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="133202180"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 10:15:32 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 2FAC720B5736;
	Thu, 24 Apr 2025 10:15:29 -0700 (PDT)
Message-ID: <1d1cb14f-5729-4200-af20-d66b4feebe94@linux.intel.com>
Date: Thu, 24 Apr 2025 13:15:27 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86: Fix open counting event error
To: Ravi Bangoria <ravi.bangoria@amd.com>,
 Luo Gengkun <luogengkun@huaweicloud.com>,
 "peterz@infradead.org" <peterz@infradead.org>
Cc: "mingo@redhat.com" <mingo@redhat.com>, "acme@kernel.org"
 <acme@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "irogers@google.com" <irogers@google.com>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250423064724.3716211-1-luogengkun@huaweicloud.com>
 <f8c349c8-b074-4b27-b799-e484631b9b3e@amd.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <f8c349c8-b074-4b27-b799-e484631b9b3e@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-04-24 2:52 a.m., Ravi Bangoria wrote:
> On 23-Apr-25 12:17 PM, Luo Gengkun wrote:
>> Perf doesn't work at perf stat for hardware events:
>>
>>  $perf stat -- sleep 1
>>  Performance counter stats for 'sleep 1':
>>              16.44 msec task-clock                       #    0.016 CPUs utilized
>>                  2      context-switches                 #  121.691 /sec
>>                  0      cpu-migrations                   #    0.000 /sec
>>                 54      page-faults                      #    3.286 K/sec
>>    <not supported>	cycles
>>    <not supported>	instructions
>>    <not supported>	branches
>>    <not supported>	branch-misses
> 
> Wondering if it is worth to add this in perf test. Something like
> below?
> 
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -16,6 +16,24 @@ test_default_stat() {
>    echo "Basic stat command test [Success]"
>  }
>  
> +test_stat_count() {
> +  echo "stat count test"
> +
> +  if ! perf list | grep -q "cpu-cycles OR cycles"
> +  then
> +    echo "stat count test [Skipped cpu-cycles event missing]"
> +    return
> +  fi
> +
> +  if perf stat -e cycles true 2>&1 | grep -E -q "<not supported>"
> +  then
> +    echo "stat count test [Failed]"
> +    err=1
> +    return
> +  fi
> +  echo "stat count test [Success]"
> +}
> +
>  test_stat_record_report() {
>    echo "stat record and report test"
>    if ! perf stat record -o - true | perf stat report -i - 2>&1 | \
> @@ -201,6 +219,7 @@ test_hybrid() {
>  }
>  
>  test_default_stat
> +test_stat_count

I think the perf stat default should always be supported, not just cycles.
Maybe we should add the check in test_default_stat?

Thanks,
Kan>  test_stat_record_report
>  test_stat_record_script
>  test_stat_repeat_weak_groups
> ---
> 
> Thanks,
> Ravi
> 

