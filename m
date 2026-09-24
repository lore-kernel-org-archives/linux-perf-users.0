Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2342741F349;
	Thu, 24 Sep 2026 06:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790232933; cv=none; b=kkbT3bSvcjxS94m0UZfvu+/uT6yBQvq9Mv+l1xwSBjTmpKLimSSK1jbZoTshM9v6liZw4Iv6cALL010q9P69sbg3wea/qMNvPWd9/WS84I/vk2CKay1nv8NjEgGB1s4ut+fxyslhO1qF4kFawKCXRJZY8cXI4YIp/9D/QcAb1hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790232933; c=relaxed/simple;
	bh=aW4ZXLYH5VkCMh/0cVbaLLsFggMLlaaA+tVcr3NThhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAh8PaeZtZuTyH7ATExSgkBPxLy49OgOfgyecKuVkmtZWfNhowTICFS5bGB1p2nUmY39L4Ots5JQkWHWaN3gda5g07kaksxgXdrGaJq/pZzo0VOvsMY7b83v/bnSUd6KffxbA/Ub9EsZr7tZtpC9WiTw3uFAWrXCnamfA8mjgqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NypqBh4Z; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NypqBh4Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790232912; x=1821768912;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aW4ZXLYH5VkCMh/0cVbaLLsFggMLlaaA+tVcr3NThhY=;
  b=NypqBh4ZiaqXasV9mStXExbQqYB28wbRlPcH+KwxMQZXHNa2INYGVnr2
   gSbHnKXqtrkQSpWda32P8dKwzuuwlYMttcv+IJbxQLCJK2w4xx85M3/9l
   rMukkXTT9OQkVg3elILCQvucc8mbv0drOnohxYwN52F6IeIrZOg9Ibs8J
   TH99tB6vkdIYXk2AU8292BEeSZsHBANFLYUiJgRtatQmnmipVyAZ0dXSi
   7Cyv6oxfFJzPQv5iQFJAmr5FmfukcWXanH1E8tC4OK0HL2HKkAIO18kX0
   1W/aUZc6HPdtR7UjPRQxaJPwHmFPrXe10nq4tm4edW21ge9Z9/iZYT34q
   g==;
X-CSE-ConnectionGUID: HdxTXnnJTxSg0/4kDZgX+g==
X-CSE-MsgGUID: rw6w8408RImoZvH57FTpEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="1504179"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="1504179"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:55:07 -0700
X-CSE-ConnectionGUID: n0UuDwUXS0+WTrarfjjSUw==
X-CSE-MsgGUID: KlHxiguHRsS9Ew6uahsV7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="301883162"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 23:55:04 -0700
Message-ID: <db502582-a090-4e8e-b720-7874af1138f0@linux.intel.com>
Date: Thu, 24 Sep 2026 14:55:01 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf test: Fix record tests on Intel Broadwell
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org
References: <20260923215255.3329181-1-namhyung@kernel.org>
 <20260923215255.3329181-2-namhyung@kernel.org>
 <CAP-5=fV1_4xC7mjmCpBarBNVd9e=ZYHAojtpK5ECuAF5u+s-Zg@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fV1_4xC7mjmCpBarBNVd9e=ZYHAojtpK5ECuAF5u+s-Zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/24/2026 11:45 AM, Ian Rogers wrote:
> On Wed, Sep 23, 2026 at 2:53 PM Namhyung Kim <namhyung@kernel.org> wrote:
>> I noticed it failed for leader sampling tests on Broadwell.  It's
>> because the period of groups members are a little bit different.  Maybe
>> there's an hardware issue but anyway it's close enough to treat them as
>> same.  I printed the value like below.
>>
>>   $ perf test record
>>   ...
>>   prev: 462507, curr: 462506
>>   prev: 494783, curr: 494782
>>   prev: 454350, curr: 454349
>>   prev: 502782, curr: 502781
>>   prev: 566693, curr: 566692
>>   prev: 606558, curr: 606557
>>   prev: 559770, curr: 559769
>>   prev: 595737, curr: 595736
>>   prev: 643386, curr: 643385
>>   prev: 663672, curr: 663671
>>   prev: 620622, curr: 620621
>>   prev: 650419, curr: 650418
>>   Leader sampling [Failed inconsistent cycles count]

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

It looks a hardware overcount issue.  I don't see this issue on recent
platforms, like SPR+, so I suppose the issue got fixed. 

BTW, recently I found the SAMPLE_READ may report invalid counts in some
PEBS based corner sampling cases, like ACR events + SAMPLE_READ, or
multiple PEBS events simultaneously run SAMPLE_READ, I'm working on a patch
series to fix the issues.

Thanks.


>> Let's update the logic to compare values to allow 1% of errors.
>>
>> Also I think it should compare only if sees the non-leader samples so
>> split the check of (($index % 2)).
>>
>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> +Dapeng Mi
>
> Tested-by: Ian Rogers <irogers@google.com>
>
> Thanks,
> Ian
>
>> ---
>>  tools/perf/tests/shell/record.sh | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
>> index cf8ba3d3411b0bcc..04df35b30b0c15fd 100755
>> --- a/tools/perf/tests/shell/record.sh
>> +++ b/tools/perf/tests/shell/record.sh
>> @@ -550,11 +550,14 @@ test_leader_sampling() {
>>    while IFS= read -r line
>>    do
>>      cycles=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="cycles:") print $(i-1)}')
>> -    if [ $(($index%2)) -ne 0 ] && [ ${cycles}x != ${prev_cycles}x ]
>> +    if [ $(($index%2)) -ne 0 ]
>>      then
>> -      invalid_counts=$(($invalid_counts+1))
>> -    else
>> -      valid_counts=$(($valid_counts+1))
>> +      if (( $(bc <<< "scale=4; r = ${cycles} / ${prev_cycles}; r >= 0.99 && r <= 1.01") ))
>> +      then
>> +        valid_counts=$(($valid_counts+1))
>> +      else
>> +        invalid_counts=$(($invalid_counts+1))
>> +      fi
>>      fi
>>      index=$(($index+1))
>>      prev_cycles=$cycles
>> --
>> 2.56.0.rc1.310.g51773c2048-goog
>>
