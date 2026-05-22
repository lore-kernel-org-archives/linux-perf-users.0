Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911DF1D88B4;
	Fri, 22 May 2026 01:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779412237; cv=none; b=hG79sSHu0KO+O+Rov3w/feUgCMXrEtuJCDGZ+1Atl3nHB8MkOplF+oJztr4Jdk1wMY6n/xqYRhUtqH6kFZnkEArVfAsz3KIF5Asn7Q+9HJO6k2kqa6Uz3UhZgF/2vsg8gBMml7YoTLP+DeDe9do97kFSXGgXb/UA8LW+yWdP4b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779412237; c=relaxed/simple;
	bh=cbSBHl/T6+bSr0C1rlORd/dnnakNHQ3FVQitkYka0Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rovXSRhadXRFvZEXJzz2/E1Ry6xMhX5e2ICMJiaLUl2FqmLM4/3RDPQGOz6+5oDyB2KlF21NNM6e+4rvOeY0YiXsubLA4CiQVQL2/t/w1okF4R/JNpRRfgKi3h5lqvrLI0sXOZB7ADJBCuR3w+WLeVkPhefGNeIu+ytdkLMGzQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vkr8GAHT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vkr8GAHT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779412235; x=1810948235;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cbSBHl/T6+bSr0C1rlORd/dnnakNHQ3FVQitkYka0Mw=;
  b=Vkr8GAHTCPOSvhffP8ywHjxyHv/5KqAKap0k96LaUbxcAFS3pCfwaJL/
   TjNSJa8dmIXV66mTHBBqebmlAeI2NMnRaUnHCKs0StYerUB9Zabt+GStd
   TEgn/BZtF18HdGhpisgo3maHqSWWrYwKZEo3MJm1/EJgct4aoq4/0Y2NK
   Q3ZZeoq8lwONQouBFhd3id4ASxzppqiqW8oS98/q1Qf0VAK+Kkxg0kX83
   DJZHDMg/x6HVJr3/DGBZGfefvvCkaVaQXgwVbQj2kY1bqksCNdc0Bko0M
   fJEYplLwPsnm6+u6zHGdCjUccAHvSGCcVC4Wb05jMItB9maGLZPIoNanp
   A==;
X-CSE-ConnectionGUID: bFEUUjNCQ0qnplVZqgWx2A==
X-CSE-MsgGUID: 2Vaw64VpQIaEDfErRC2K9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80461427"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="80461427"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 18:10:34 -0700
X-CSE-ConnectionGUID: bB1LxpRUR9K/qV/4pvPQSA==
X-CSE-MsgGUID: N4Q6u8vXQOaBzaA0G/+GiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="278833194"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 18:10:31 -0700
Message-ID: <ff569303-c30b-43b7-a3d2-2eb949893f30@linux.intel.com>
Date: Fri, 22 May 2026 09:10:28 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3] perf tests: Add auto counter reload (ACR) sampling
 test
To: "Falcon, Thomas" <thomas.falcon@intel.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "acme@kernel.org" <acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "namhyung@kernel.org" <namhyung@kernel.org>, "Rogers, Ian"
 <irogers@google.com>
Cc: "Chen, Zide" <zide.chen@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "Mi, Dapeng1" <dapeng1.mi@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
References: <20260421045511.2401316-1-dapeng1.mi@linux.intel.com>
 <29ad63162ca81262778d4f732c9bf0bcba23a838.camel@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <29ad63162ca81262778d4f732c9bf0bcba23a838.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/22/2026 2:01 AM, Falcon, Thomas wrote:
> On Tue, 2026-04-21 at 12:55 +0800, Dapeng Mi wrote:
>> Add auto counter reload sampling test to verify that the intended
>> event
>> records can be captured and the self-reloaded events won't generate
>> any
>> records.
>>
>> Additionally, enhance ratio_to_prev test to verify ACR sampling as
>> well
>> if ACR is supported.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>
>> V3: Move ratio-to-prev ACR sampling test into ratio_to_prev test.
>> V2:
>> https://lore.kernel.org/all/20260420025501.2133495-1-dapeng1.mi@linux.intel.com/
>> v1:
>> https://lore.kernel.org/all/20260413010920.546501-1-dapeng1.mi@linux.intel.com/
>>
>>  tools/perf/tests/shell/record.sh | 92
>> +++++++++++++++++++++++++++++++-
>>  1 file changed, 91 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/tests/shell/record.sh
>> b/tools/perf/tests/shell/record.sh
>> index 7cb81cf3444a..091d8b0a998b 100755
>> --- a/tools/perf/tests/shell/record.sh
>> +++ b/tools/perf/tests/shell/record.sh
>> @@ -402,7 +402,52 @@ test_callgraph() {
>>    echo "Callgraph test [Success]"
>>  }
>>  
>> +test_acr_sampling() {
>> + 
>> events="{instructions/period=40000,acr_mask=0x2/u,cycles/period=20000
>> ,acr_mask=0x3/u}"
>> + 
>> pebs_events="{instructions/period=40000,acr_mask=0x2/pu,cycles/period
>> =20000,acr_mask=0x3/u}"
>> +  echo "Auto counter reload (ACR) sampling test"
>> +  if ! perf record -o "${perfdata}" -e "${events}" ${testprog} 2>
>> /dev/null
>> +  then
>> +    echo "Auto counter reload sampling [Skipped not supported]"
>> +    return
>> +  fi
>> +  if ! perf script -i "${perfdata}" -F event | grep -q
>> "instructions"
>> +  then
>> +    echo "Auto counter reload sampling [Failed missing instructions
>> event]"
>> +    err=1
>> +    return
>> +  fi
>> +  if perf script -i "${perfdata}" -F event | grep -q "cycles"
>> +  then
>> +    echo "Auto counter reload sampling [Failed cycles event
>> shouldn't be sampled]"
>> +    err=1
>> +    return
>> +  fi
>> +  if ! perf record -o "${perfdata}" -e "${pebs_events}" ${testprog}
>> 2> /dev/null
>> +  then
>> +    echo "Auto counter reload PEBS sampling [Skipped not supported]"
>> +    echo "Auto counter reload sampling [Success]"
> Should this "Success" message be here?

Yes, If we didn't add the "Success" message here, then no "Success" message
is printed if PEBS is not supported. Thanks.


>
> Thanks,
> Tom
>
>> +    return
>> +  fi
>> +  if ! perf script -i "${perfdata}" -F event | grep -q
>> "instructions"
>> +  then
>> +    echo "Auto counter reload PEBS sampling [Failed missing
>> instructions event]"
>> +    err=1
>> +    return
>> +  fi
>> +  if perf script -i "${perfdata}" -F event | grep -q "cycles"
>> +  then
>> +    echo "Auto counter reload PEBS sampling [Failed cycles event
>> shouldn't be sampled]"
>> +    err=1
>> +    return
>> +  fi
>> +  echo "Auto counter reload sampling [Success]"
>> +}
>> +
>>  test_ratio_to_prev() {
>> +  ratio_events="{instructions:u,cycles/period=20000,ratio-to-
>> prev=0.5/u}"
>> + 
>> p_core_ratio_events="{cpu_core/instructions/u,cpu_core/cycles,period=
>> 20000,ratio-to-prev=0.5/u}"
>> + 
>> e_core_ratio_events="{cpu_atom/instructions/u,cpu_atom/cycles,period=
>> 20000,ratio-to-prev=0.5/u}"
>>    echo "ratio-to-prev test"
>>    if ! perf record -o /dev/null -e "{instructions,
>> cycles/period=100000,ratio-to-prev=0.5/}" \
>>       true 2> /dev/null
>> @@ -438,7 +483,51 @@ test_ratio_to_prev() {
>>      err=1
>>      return
>>    fi
>> -  echo "Basic ratio-to-prev record test [Success]"
>> +
>> +  ratio_err=0
>> +  do_ratio_to_prev_test() {
>> +    local events=$1
>> +    local cpu=$2
>> +    if ! perf record -o "${perfdata}" -e "${events}" ${testprog} 2>
>> /dev/null
>> +    then
>> +      echo "Auto counter reload ${cpu} ratio-to-prev sampling
>> [Failed sampling]"
>> +      ratio_err=1
>> +      return
>> +    fi
>> +    if ! perf script -i "${perfdata}" -F event | grep -q
>> "instructions"
>> +    then
>> +      echo "Auto counter reload ${cpu} ratio-to-prev sampling
>> [Failed missing instructions event]"
>> +      ratio_err=1
>> +      return
>> +    fi
>> +    if perf script -i "${perfdata}" -F event | grep -q "cycles"
>> +    then
>> +      echo "Auto counter reload ${cpu} ratio-to-prev sampling
>> [Failed cycles event shouldn't be sampled]"
>> +      ratio_err=1
>> +      return
>> +    fi
>> +  }
>> +
>> +  # ratio-to-prev sampling would fallback to normal sampling if ACR
>> sampling
>> +  # is not supported, so acr_mask must be checked before testing
>> ratio-to-prev sampling.
>> +  if [ -e /sys/bus/event_source/devices/cpu/format/acr_mask ]
>> +  then
>> +    do_ratio_to_prev_test "${ratio_events}" ""
>> +  fi
>> +  if [ -e /sys/bus/event_source/devices/cpu_core/format/acr_mask ]
>> +  then
>> +    do_ratio_to_prev_test "${p_core_ratio_events}" "P-core"
>> +  fi
>> +  if [ -e /sys/bus/event_source/devices/cpu_atom/format/acr_mask ]
>> +  then
>> +    do_ratio_to_prev_test "${e_core_ratio_events}" "E-core"
>> +  fi
>> +  if test "$ratio_err" -eq 0
>> +  then
>> +    echo "Basic ratio-to-prev record test [Success]"
>> +  else
>> +    err="${ratio_err}"
>> +  fi
>>  }
>>  
>>  # raise the limit of file descriptors to minimum
>> @@ -457,6 +546,7 @@ test_leader_sampling
>>  test_topdown_leader_sampling
>>  test_precise_max
>>  test_callgraph
>> +test_acr_sampling
>>  test_ratio_to_prev
>>  
>>  # restore the default value
