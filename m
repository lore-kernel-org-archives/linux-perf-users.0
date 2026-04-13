Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D910233985;
	Mon, 13 Apr 2026 01:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776044116; cv=none; b=PiAkLLoO9D4XrbVFVVesZfJJPNewQmgYLncLQgkb2KDVPoQreNyd20cZQJI/ixl6zomsCPuG21wFsh5iyjm0zPwvA3uDO+DpVrYkkhDQ++Q5OFNDqn15Omu51UtFHn4/ZyqsCJj6QmNkMii7pqLXhp5l+sCg+Nw4fXD/UWHECrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776044116; c=relaxed/simple;
	bh=H8ojr1/Z59yFFLI+pJSXLyDvEYNiURFhMaDCjyDCKF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1wi1N8npmkP02KJhQpAmRC7uSnbVHu/XPOj3HSdLngShcVJ2d42QMwg+LWPVDMwUS2wrX3viMK9skk2DTqgXZIfFrTE0qGTZ0DrStwGXsH3o5AikaddogiLpsdcNBKzyduP9PjIvW+et6tYRjQamP2gWiARVQYpKRAvcwM1rrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUikYCLP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUikYCLP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776044115; x=1807580115;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H8ojr1/Z59yFFLI+pJSXLyDvEYNiURFhMaDCjyDCKF8=;
  b=lUikYCLP6K2EgM9j3d8Oa/hTBBdrI6pQJjoy+m2QWl0vZeHt6qruQ5qL
   hHnCZ5nAPPVu/DjTqxgVpnydUigx3eRb6Z0nqdvq6gKQajrBqlhfB+uCF
   ojlDTDYHXoaWy1q7T7mX+QMs4ZCQGilRG4NKrFIz/U8Cg8eC+l02tcaAw
   LGjQUatb9SiuPsRXhU4LytrayLtr8P3mZIMNHRjynyUuNTnIwwvDCU+8e
   j+iOzvMROGWX3PiSPyn1/4ynygzms1DCt6Y74G0gizNf6fHV/3TUAYLHi
   eN9h4uA3prpY7KNEJ2G4p62veDRH6JethkJEc3/HnNpbRivTKY+/t1b4p
   A==;
X-CSE-ConnectionGUID: 7vL70uogRfCY/KGppRw45g==
X-CSE-MsgGUID: S7JnZjnrSuSe+mRiS5frLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="76850514"
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="76850514"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 18:35:15 -0700
X-CSE-ConnectionGUID: adN1j3u/TsWwsH5U0O1vtQ==
X-CSE-MsgGUID: NouznvFiScu0gI+8Dw0LrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,176,1770624000"; 
   d="scan'208";a="228623733"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 18:35:11 -0700
Message-ID: <487eb56b-85a8-4c3b-a150-0de43fbb06d7@linux.intel.com>
Date: Mon, 13 Apr 2026 09:35:08 +0800
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

Good idea. Sure.


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
