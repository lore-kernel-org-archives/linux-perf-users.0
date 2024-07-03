Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BF8522F;
	Wed,  3 Jul 2024 02:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719975192; cv=none; b=WIAZ3o429NinLf9lpguZhCx+NSvNActRXrensNjuELjGvBAsMUDZYBdZmOeUPlGYQnU6JqmbGWHaPTQ8UsHIYVeNTm5zlg1CBnZf61GRksW5CFS3YlLk1mHX316qfiJQL5FO0lggXr3RYdxEoU76SqPrUX4vP5nEbARwgtDK1Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719975192; c=relaxed/simple;
	bh=qVcDEdhJBIogUebzLEzHbeQwUQz9VYZzujoxCaVQvA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WZLl9VsiVHReGve9rIij5UItQJKFkDjvqRkvabDJ5odfSzew2KA3wA9zY5hNysOlPedDd9+/LYCHg/gMEDz7H/FY4b6sRSdEud+TUpReTj+PHtMa4Lm/bcejPWcn/IwQaJ1xR+9Tg60Oy2k82cq73ctFi7fSNdBLUwIFWwJ25WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LmJsxwtJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LmJsxwtJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719975191; x=1751511191;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qVcDEdhJBIogUebzLEzHbeQwUQz9VYZzujoxCaVQvA8=;
  b=LmJsxwtJ/NMNGiTtkqQP13YEMtbmq1xS/zYF9qhmhxeQ1W8S/eOFWbEO
   pCYt3AXJu1F1bhfUKrAhr7IFp0Iv+MbG7itfcwHNNzCu/XmnYeah2J9Zc
   p26CugN+91aNaWmLgs08xxmM1k0chbVN+tV1t49ib3LZrPnV5IGev81Ln
   lzKASVNCRguFlt4N5CvBnX7tH5/F5zW8DnzMQh7nOxcow81UAQdj1ARvq
   UpIpAjiwCQzvMHvYRbTe7QyPxCvdRK9DPr2ALZ9bxMhy+87xVibjO3V+f
   rKSkGi1fhUjlqjEGwngHG34atcebOrv7ZjhcNgFMXvUKtEp0RMYawacMd
   A==;
X-CSE-ConnectionGUID: R2YwavzWR+6GedQiUq95ng==
X-CSE-MsgGUID: BZmRTSMLRC+JHX3418g43g==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17393071"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="17393071"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 19:53:10 -0700
X-CSE-ConnectionGUID: 74QCS69oR8C8uIS6dAh1Cg==
X-CSE-MsgGUID: hXY17Y0bR/e/rZq27uRTPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="69280334"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.225.1]) ([10.124.225.1])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 19:53:06 -0700
Message-ID: <8c737c22-3d64-4fdb-b199-7d6375475f45@linux.intel.com>
Date: Wed, 3 Jul 2024 10:53:03 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] perf tests: Add leader sampling test in record tests
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yanfei Xu <yanfei.xu@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
References: <20240702224037.343958-1-dapeng1.mi@linux.intel.com>
 <20240702224037.343958-5-dapeng1.mi@linux.intel.com>
 <f56397c3-91ee-44c1-8695-11bece4c4231@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <f56397c3-91ee-44c1-8695-11bece4c4231@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/3/2024 2:07 AM, Liang, Kan wrote:
>
> On 2024-07-02 6:40 p.m., Dapeng Mi wrote:
>> Add leader sampling test to validate event counts are captured into
>> record and the count value is consistent.
>>
>> Suggested-by: Kan Liang <kan.liang@linux.intel.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  tools/perf/tests/shell/record.sh | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
>> index 3d1a7759a7b2..8e3e66780fed 100755
>> --- a/tools/perf/tests/shell/record.sh
>> +++ b/tools/perf/tests/shell/record.sh
>> @@ -17,6 +17,7 @@ skip_test_missing_symbol ${testsym}
>>  
>>  err=0
>>  perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>> +script_output=$(mktemp /tmp/__perf_test.perf.data.XXXXX.script)
>>  testprog="perf test -w thloop"
>>  cpu_pmu_dir="/sys/bus/event_source/devices/cpu*"
>>  br_cntr_file="/caps/branch_counter_nr"
>> @@ -190,11 +191,38 @@ test_branch_counter() {
>>    echo "Basic branch counter test [Success]"
>>  }
>>  
>> +test_leader_sampling() {
>> +  echo "Basic leader sampling test"
>> +  if ! perf record -o "${perfdata}" -e "{branches,branches}:Su" perf test -w brstack 2> /dev/null
> I think we still need a case to verify the topdown fix you did in the
> patch set.
> Since the topdown is platform specific, you may want to skip it on the
> platform which doesn't support perf metrics. For example, check if the
> slots event exists in the event folder.

Yeah, I would look how to design a test case to verify the topdown case.


>
> Thanks,
> Kan
>> +  then
>> +    echo "Leader sampling [Failed record]"
>> +    err=1
>> +    return
>> +  fi
>> +  index=0
>> +  perf script -i "${perfdata}" > $script_output
>> +  while IFS= read -r line
>> +  do
>> +    # Check if the two branches counts are equal in each record
>> +    branches=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="branches:") print $(i-1)}')
>> +    if [ $(($index%2)) -ne 0 ] && [ ${branches}x != ${prev_branches}x ]
>> +    then
>> +      echo "Leader sampling [Failed inconsistent branches count]"
>> +      err=1
>> +      return
>> +    fi
>> +    index=$(($index+1))
>> +    prev_branches=$branches
>> +  done < $script_output
>> +  echo "Basic leader sampling test [Success]"
>> +}
>> +
>>  test_per_thread
>>  test_register_capture
>>  test_system_wide
>>  test_workload
>>  test_branch_counter
>> +test_leader_sampling
>>  
>>  cleanup
>>  exit $err
