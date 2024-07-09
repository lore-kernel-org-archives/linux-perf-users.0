Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0AA63A;
	Tue,  9 Jul 2024 05:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720503347; cv=none; b=teVmiOAJAwkUjAOnsPfbS9QwFdSUpvxfeWTTfUvKc2a313iFA/3bLAUCuO9/5vKXaMo+8VdRMxHf+8aWqyUD4Jq9ew+3WZEWkpNSBZW44awDzCeJRTsEOM42JEWlZH1sAfwxGRsAgqegehj+xHzuWylJENqfIxQZbRgG6faDQ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720503347; c=relaxed/simple;
	bh=q5yBRvkwXHYxk8Z1t1bBGwl3WROs3itRozEJnRkItMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AcYZR3SM0v66zmAqccRPQLX2K/IH/QtYzIXH7UpF1FO8L3lqLLNtoBtNuXqBC42LpBfftDyq4uOWFT96cxnoy1d9F/wr/7bP7oT+GR/OcUSF+nfVCuWVw4nGwIWaVwluZlEnrR0H2qzzom6g6hJAwgFDjhQlKtGH09qWRVrCTK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c9getVFx; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c9getVFx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720503346; x=1752039346;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q5yBRvkwXHYxk8Z1t1bBGwl3WROs3itRozEJnRkItMM=;
  b=c9getVFxyfaIXgr1QLoyiUe0dNXy5MDDagDFLh+YRHZWPaLQF4yOoShP
   Rv6SHuIomqTC4DooSj3GNmE+/g7quzenSxIolJIqf8sLuNynRs9iafX0U
   aIgJd4QnS0LYc04x/EawqFQi/4zuCwoA0YavxK0AuBntVEd701MnSJH/v
   B1tq3wCgYFtuXLg4zeuRonKBwyrwCuWWtpqTWdrb8pbh8xRScqcpph146
   7T+8dh4ZlqKdOo7mO2J1Ns6mbfOuHwqrB2cX0XKzQMkneZ5YbuUiF5qpq
   MoH0mAjQHzvacAj4zzrvCEKpvJfwzZmF/p8z9qRzDcaVwmDz6pf2CHhoq
   Q==;
X-CSE-ConnectionGUID: oFrGAgOFSvapZ2FLDSGOig==
X-CSE-MsgGUID: UZ2ndyANQC6wEpLD0/bzLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="29128648"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="29128648"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 22:27:57 -0700
X-CSE-ConnectionGUID: eHjFZtt7QSCn4GC8NDYZLw==
X-CSE-MsgGUID: 9cF7aMRpR8CzeDjWlxZuPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="47831369"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.225.1]) ([10.124.225.1])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 22:27:54 -0700
Message-ID: <0df5a4c7-65c3-45ea-b245-3ab872db8d96@linux.intel.com>
Date: Tue, 9 Jul 2024 13:27:51 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 5/5] perf tests: Add topdown events counting and
 sampling tests
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
References: <20240708144204.839486-1-dapeng1.mi@linux.intel.com>
 <20240708144204.839486-6-dapeng1.mi@linux.intel.com>
 <c9e09449-f8ff-471f-adf3-1a5e8f97a102@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <c9e09449-f8ff-471f-adf3-1a5e8f97a102@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/8/2024 9:40 PM, Liang, Kan wrote:
>
> On 2024-07-08 10:42 a.m., Dapeng Mi wrote:
>> Add counting and leader sampling tests to verify topdown events including
>> raw format can be reordered correctly.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  tools/perf/tests/shell/record.sh | 6 ++++++
>>  tools/perf/tests/shell/stat.sh   | 6 ++++++
>>  2 files changed, 12 insertions(+)
>>
>> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
>> index 8e3e66780fed..164f0cf9648e 100755
>> --- a/tools/perf/tests/shell/record.sh
>> +++ b/tools/perf/tests/shell/record.sh
>> @@ -214,6 +214,12 @@ test_leader_sampling() {
>>      index=$(($index+1))
>>      prev_branches=$branches
>>    done < $script_output
> The topdown is a model specific feature and only be available for the
> big core.
>
> We need to check if topdown is supported before doing the test.
>
> The same check in the test_topdown_groups() may be used here as well.
>
>   if ! perf stat -e '{slots,topdown-retiring}' true > /dev/null 2>&1
>   then
>     echo "Topdown sampling read test [Skipped event parsing failed]"
>     return
>   fi

Sure. Thanks.

>
> Thanks,
> Kan
>
>> +  if ! perf record -o "${perfdata}" -e "{instructions,slots,topdown-retiring}:S" true 2> /dev/null
>> +  then
>> +    echo "Leader sampling [Failed topdown events not reordered correctly]"
>> +    err=1
>> +    return
>> +  fi
>>    echo "Basic leader sampling test [Success]"
>>  }
>>  
>> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
>> index 3f1e67795490..092a7a2abcf8 100755
>> --- a/tools/perf/tests/shell/stat.sh
>> +++ b/tools/perf/tests/shell/stat.sh
>> @@ -79,6 +79,12 @@ test_topdown_groups() {
>>      err=1
>>      return
>>    fi
>> +  if perf stat -e '{instructions,r400,r8000}' true 2>&1 | grep -E -q "<not supported>"
>> +  then
>> +    echo "Topdown event group test [Failed raw format slots not reordered first]"
>> +    err=1
>> +    return
>> +  fi
>>    echo "Topdown event group test [Success]"
>>  }
>>  
