Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E4B4C81;
	Mon,  9 Sep 2024 06:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725862210; cv=none; b=bA6Weiwb80F3iH6aqZ47krkmDvEVl4tbCglyuUZ0bUffuu8VRBkMspUjH9NIIAlzsRLODkiXupP4ZmY9s0hMEP8tElSYIVIwBnlIHdMEu3XKcwy33r/xapBLU7g/GjkWZOc97cyDE+zd/h6J6+BirkUz9x80QmGsxQ8HfdYRfKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725862210; c=relaxed/simple;
	bh=4CeXFkwlgo/Oz2/mA5YBeVcYrbW/xA3o0xFA/Ua5hcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJDkcRWoVjNqjgE7Agd55Mcjw9gNZXe6W+NdOUFj17eI98HnACpEdwIIhSgU8D108Kb6q1slRA3BCo0Z3RIxRYqVlFRJTuQevXffb8YOCdqVdYSUmKRgqHnwGDj8FLAt7rnWlDEu7c5GWoeVGimmmRmNko5f2VSmXXa+8Mldee8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dredVz+2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dredVz+2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725862208; x=1757398208;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4CeXFkwlgo/Oz2/mA5YBeVcYrbW/xA3o0xFA/Ua5hcw=;
  b=dredVz+22jVcDLgEEs9RDN7eXNEVG3lrcbpEqqEIlh90V/2+wYYszWSN
   DsFJh9v3ZvrHQHDkTseq9n/iXsr3yT0eQZxek4KREAOvV9AeNXRAfyo4+
   6M7q/6mM59qKFNFygwRI6j9itTZi2XzIPdyteXIFF7/5mLLWaqMvThcf9
   1vjkTBSyINETbvS4z9uKAxa/MvSlENekYpkYUvdqK3NYLIIup5JeYJNs3
   T39VSaki3n3u484VCdjoUIQKOZOddmMg94DhQX9GL+o/fVmvj7DA54IsX
   17nuU8faOcHUJYG9MFFYdfcjtXHvuwdyeZki4Pdrp3ZM81zegrQV5CAmA
   A==;
X-CSE-ConnectionGUID: Oe1dNjq/TMeOvcrJVpodzQ==
X-CSE-MsgGUID: z4R57huBTLiW04sNljiCGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24646118"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="24646118"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 23:10:07 -0700
X-CSE-ConnectionGUID: VXqNOvuPSZiahFtzDAEzlA==
X-CSE-MsgGUID: gdT2xLi2RR+Gee8xcF8NKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="89824566"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.229.37]) ([10.124.229.37])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 23:10:05 -0700
Message-ID: <9d17f287-d06e-498f-97b1-0fe413b6e653@linux.intel.com>
Date: Mon, 9 Sep 2024 14:10:02 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 0/6] Bug fixes on topdown events reordering
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
References: <20240816122938.32228-1-dapeng1.mi@linux.intel.com>
 <df279b32-54f0-4aeb-894a-c06ef91b34f0@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <df279b32-54f0-4aeb-894a-c06ef91b34f0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/17/2024 8:39 PM, Liang, Kan wrote:
>
> On 2024-08-16 8:29 a.m., Dapeng Mi wrote:
>> Changes:
>> v3 -> v4:
>>   * limit metrics event searching inside group for group leader
>>     sampling (Kan)
>>   * add comments to illustrate supported and unsupported topdown events
>>     regrouping formats (Kan)
>>   * add more test cases to verify supported topdown regrouping
>>     formats (Kan)
>>
>> History:
>>   v3: https://lore.kernel.org/all/20240712170339.185824-1-dapeng1.mi@linux.intel.com/
>>   v2: https://lore.kernel.org/all/20240708144204.839486-1-dapeng1.mi@linux.intel.com/
>>   v1: https://lore.kernel.org/all/20240702224037.343958-1-dapeng1.mi@linux.intel.com/
>>
>> Dapeng Mi (6):
>>   perf x86/topdown: Complete topdown slots/metrics events check
>>   perf x86/topdown: Correct leader selection with sample_read enabled
>>   perf x86/topdown: Don't move topdown metric events in group
>>   perf tests: Add leader sampling test in record tests
>>   perf tests: Add topdown events counting and sampling tests
>>   perf tests: Add more topdown events regroup tests
>
> Thanks Dapeng.
>
> The series look good to me.
>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks Kan for reviewing. Any other comments?


>
> Thanks,
> Kan
>>  tools/perf/arch/x86/util/evlist.c  | 68 ++++++++++++++++++++++++++++--
>>  tools/perf/arch/x86/util/evsel.c   |  3 +-
>>  tools/perf/arch/x86/util/topdown.c | 64 +++++++++++++++++++++++++++-
>>  tools/perf/arch/x86/util/topdown.h |  2 +
>>  tools/perf/tests/shell/record.sh   | 45 ++++++++++++++++++++
>>  tools/perf/tests/shell/stat.sh     | 28 +++++++++++-
>>  6 files changed, 201 insertions(+), 9 deletions(-)
>>
>>
>> base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
