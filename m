Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B310332EC8;
	Wed, 15 Apr 2026 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776244782; cv=none; b=OeQKzA2vtrqFf6WSODBGbdwfrhBxtTrv4LOGmGuTd9F8aMxtRO5XvV6iN9MqwzPPWnNQl7se2kZjEfs6hMUfD4W7wrMmtNJzmBOGX6v7WISY9QDKuW0Y459M8RTxlE0k5KfM12XKuE/aHcq90M/lK0JO1U4Ej1bYphBkAagxoaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776244782; c=relaxed/simple;
	bh=2uF+NTIvOOItUWYsaEG3S5o5GAhO/fz/2Yqutzqwp4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6Ig+VwTNs0uetaHC3UBLW+uvXjja5a5kREgp1jogRqN6UrxopHHqUWwxMjoNu8BAqdvxodPEn1m0ha+Tob+0BZLbZ9ST8G+AgxnSh6+6587qrpNLk/AXrgwlx5LtlKkrAFt6iL9epKV7j0HM1YQ6o1AEcjlkVFgQBxwHDi7pGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJJd1fVo; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJJd1fVo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776244780; x=1807780780;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2uF+NTIvOOItUWYsaEG3S5o5GAhO/fz/2Yqutzqwp4Y=;
  b=WJJd1fVoJrn8/nbeaKyTQFsTAij0XJdFWTcB2nj+s5Ywmnk8YiKQbp9q
   twFRDoSbi48BCkP/0mXDLWMhftQcyfJE7sD0PPs8EfZBRpSFQKcigwCcu
   FA7M0pRWxBNJDGZJMVZ+jM8/I4/7/MrWLyVTkA6riSV0moXhR+mwS2igJ
   XGWSyRJ1k0bxtE12tNpZPoBqqgTJlwNFHvi9dGEfF+NmTNXarji64Io8Q
   KbK2mVfkAOW13ayB80rrB8jJrua6hEyGSicX62KPUi3EaU1/9yZLSFiNJ
   KRfqx+OaHTf/2Nm4oFd5aS3YFMz1huYj01vuX6I9jNwTRv/7xsMPIzOMz
   Q==;
X-CSE-ConnectionGUID: d/Fr4bCpTM2WFCWkCSs+5A==
X-CSE-MsgGUID: gIYWMtiNSzSoQRBIS4zkEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="64760357"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="64760357"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 02:19:40 -0700
X-CSE-ConnectionGUID: zLQUqKVST36GY7SkqzXwtg==
X-CSE-MsgGUID: S+k0uHmJRJOfIZtJNwzObQ==
X-ExtLoop1: 1
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 02:19:37 -0700
Message-ID: <0ce093d8-3647-4879-9d65-acd52d4c0ab0@linux.intel.com>
Date: Wed, 15 Apr 2026 17:19:34 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tests: Add auto counter reload (ACR) sampling test
To: Ian Rogers <irogers@google.com>, Falcon Thomas <thomas.falcon@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zide Chen <zide.chen@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260413010920.546501-1-dapeng1.mi@linux.intel.com>
 <CAP-5=fW0Z0zXDjqR_tpJbT-0nbyXQO-Zcc+4Fpk=XejYX8uF4g@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fW0Z0zXDjqR_tpJbT-0nbyXQO-Zcc+4Fpk=XejYX8uF4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/13/2026 9:30 AM, Ian Rogers wrote:
> On Sun, Apr 12, 2026 at 6:14 PM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>> Add auto counter reload sampling test to verify that the intended event
>> records can be captured and the self-reloaded events won't generate any
>> records.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  tools/perf/tests/shell/record.sh | 42 ++++++++++++++++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>
>> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
>> index 7cb81cf3444a..1068843282f5 100755
>> --- a/tools/perf/tests/shell/record.sh
>> +++ b/tools/perf/tests/shell/record.sh
>> @@ -402,6 +402,47 @@ test_callgraph() {
>>    echo "Callgraph test [Success]"
>>  }
>>
>> +test_acr_sampling() {
>> +  events="{instructions/period=20000,acr_mask=0x2/u,cycles/period=40000,acr_mask=0x3/u}"
>> +  pebs_events="{instructions/period=20000,acr_mask=0x2/pu,cycles/period=40000,acr_mask=0x3/u}"
>> +  echo "Auto counter reload sampling test"
>> +  if ! perf record -o "${perfdata}" -e "${events}" ${testprog} 2> /dev/null
>> +  then
>> +    echo "Auto counter reload sampling [Skipped not supported]"
>> +    return
>> +  fi
>> +  if ! perf script -i "${perfdata}" | grep -q "period=20000,acr_mask=0x2"
>> +  then
>> +    echo "Auto counter reload sampling [Failed missing instructions event]"
>> +    err=1
>> +    return
>> +  fi
>> +  if perf script -i "${perfdata}" | grep -q "period=40000,acr_mask=0x3"
>> +  then
>> +    echo "Auto counter reload sampling [Failed cycles event shouldn't be sampled]"
>> +    err=1
>> +    return
>> +  fi
>> +  if ! perf record -o "${perfdata}" -e "${pebs_events}" ${testprog} 2> /dev/null
>> +  then
>> +    echo "Auto counter reload PEBS sampling [Skipped not supported]"
>> +    return
>> +  fi
>> +  if ! perf script -i "${perfdata}" | grep -q "period=20000,acr_mask=0x2"
>> +  then
>> +    echo "Auto counter reload PEBS sampling [Failed missing instructions event]"
>> +    err=1
>> +    return
>> +  fi
>> +  if perf script -i "${perfdata}" | grep -q "period=40000,acr_mask=0x3"
>> +  then
>> +    echo "Auto counter reload PEBS sampling [Failed cycles event shouldn't be sampled]"
>> +    err=1
>> +    return
>> +  fi
>> +  echo "Auto counter reload sampling [Success]"
> Thanks Dapeng! Could we also test ratio-to-prev as well as just the
> plain acr_mask?

Ian, it could be hard to validate ratio-to-prev option in this test. On
platforms which don't support ACR, perf would automatically fallback the
ACR sampling to normal sampling, this would lead to false positives on
checking the existence of records from cycles event. I didn't find a good
way to figure out this fallback.

Since we already have independent test case to validate the ratio_to_prev
parsing. It may be unnecessary to add ratio-to-prev validation in this ACR
test.


>
> Thanks,
> Ian
>
>> +}
>> +
>>  test_ratio_to_prev() {
>>    echo "ratio-to-prev test"
>>    if ! perf record -o /dev/null -e "{instructions, cycles/period=100000,ratio-to-prev=0.5/}" \
>> @@ -457,6 +498,7 @@ test_leader_sampling
>>  test_topdown_leader_sampling
>>  test_precise_max
>>  test_callgraph
>> +test_acr_sampling
>>  test_ratio_to_prev
>>
>>  # restore the default value
>>
>> base-commit: 4e03d6494f9504f8af46ba68a2a8b6877c196789
>> --
>> 2.34.1
>>
