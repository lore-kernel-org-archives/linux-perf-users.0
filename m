Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C773C1DFF8;
	Sun, 22 Dec 2024 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734895079; cv=none; b=gU0B37qwxUdWjGk7rR+ERTx9Hkb7RsW/usyEAFdd+Z3SB15ULomw15idQq/Pa3a75uo6dxWcmKjJymWWUO9etTGN7+xV6g4oQlAq1QXUlTURt1gv4VYJZTZiw31EILL3Iv6nrX/Byyr9KA0zHhV6sFzWIiOl729Mh4Zg8ue+548=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734895079; c=relaxed/simple;
	bh=xNU5QCuxvNReJZrFbHkWEXiCYk4v0QPz+EofjBBY8Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lDnCrJcLDvmn7qFb8aWCteuC3ntWwZc/dtR41Ac1GvAxTEDTiFTkNfJWS4c/0CAey7n+VsPdh75l8YkIvIUvlaJwQUZYz+dOIahWZaV/m7gdsRohsNQ3R5ntIlCHa4zg/LXYFkIgnrqcoCvJQXxIIy5jkBrGrTZTfC+Okyb6Qmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nYlBY4ab; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nYlBY4ab"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734895078; x=1766431078;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xNU5QCuxvNReJZrFbHkWEXiCYk4v0QPz+EofjBBY8Wc=;
  b=nYlBY4ab99Ly/ohlkDxnt22y3OIAiDqjak0TxE86bLfJmz17lfVf87Zo
   iwap20QlJom7tUqkEekjJZ0RhW1X1cSCEAB4NjkL2Kh3QoeOxI0sQMU7W
   lPO7uuVPyte4sg5/syYTG5YVyrpNIADPUdq6lHPyneY+y7i9b6JWtGMCl
   nBMAjjKMVWkifUmKBOU9J7jav95rAiFoHuqxOfPF/bO4Q5GrEShfUFYJc
   Tv2cLsueDYKaHqcL0BhN4nB1Jf1RWHNBTmnwTWYfxfgSymCMyI1i7NpYk
   6dWnSwxDCZ/SuxFXiF9Nl2LXByan7l/Y7INFdDG81jvgn/WxmMS2NnqGL
   w==;
X-CSE-ConnectionGUID: HoorPsM9QHKKqXwL+5tSPw==
X-CSE-MsgGUID: fKjIDhR1RqGQmauyiFt8KA==
X-IronPort-AV: E=McAfee;i="6700,10204,11294"; a="35527997"
X-IronPort-AV: E=Sophos;i="6.12,256,1728975600"; 
   d="scan'208";a="35527997"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2024 11:17:57 -0800
X-CSE-ConnectionGUID: aQ/yL6ktS3iWvrAr9MrmVA==
X-CSE-MsgGUID: K1LCxYgJQZ6BY+ltntnetg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,256,1728975600"; 
   d="scan'208";a="99228303"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.163])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2024 11:17:54 -0800
Message-ID: <68747890-ae9f-476a-97a9-f3cf3424e379@intel.com>
Date: Sun, 22 Dec 2024 21:17:47 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V16 7/7] perf intel-pt: Add a test for pause / resume
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@arm.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20241216070244.14450-1-adrian.hunter@intel.com>
 <20241216070244.14450-8-adrian.hunter@intel.com>
 <CAP-5=fUwjYH8uvmsgSN=1exN1FEEBEPQHFYwgq4cJEeOApFNQg@mail.gmail.com>
 <7e438859-26c3-4ad6-850b-21b9ab6078c3@intel.com>
 <CAP-5=fX8hWF-PaAE2VKHW3fk1W19xd0hyBVsP3653J9xw-U7VQ@mail.gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fX8hWF-PaAE2VKHW3fk1W19xd0hyBVsP3653J9xw-U7VQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/12/24 18:54, Ian Rogers wrote:
> On Sat, Dec 21, 2024 at 11:30 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 21/12/24 19:10, Ian Rogers wrote:
>>> On Sun, Dec 15, 2024 at 11:03 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>
>>>> Add a simple sub-test to the "Miscellaneous Intel PT testing" test to
>>>> check pause / resume.
>>>>
>>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>>> Acked-by: Ian Rogers <irogers@google.com>
>>>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>>>> ---
>>>>  tools/perf/tests/shell/test_intel_pt.sh | 28 +++++++++++++++++++++++++
>>>>  1 file changed, 28 insertions(+)
>>>>
>>>> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
>>>> index e6f0070975f6..f3a9a040bacc 100755
>>>> --- a/tools/perf/tests/shell/test_intel_pt.sh
>>>> +++ b/tools/perf/tests/shell/test_intel_pt.sh
>>>> @@ -644,6 +644,33 @@ test_pipe()
>>>>         return 0
>>>>  }
>>>>
>>>> +test_pause_resume()
>>>> +{
>>>> +       echo "--- Test with pause / resume ---"
>>>> +       if ! perf_record_no_decode -o "${perfdatafile}" -e intel_pt/aux-action=start-paused/u uname ; then
>>>> +               echo "SKIP: pause / resume is not supported"
>>>> +               return 2
>>>> +       fi
>>>> +       if ! perf_record_no_bpf -o "${perfdatafile}" \
>>>> +                       -e intel_pt/aux-action=start-paused/u \
>>>> +                       -e instructions/period=50000,aux-action=resume,name=Resume/u \
>>>> +                       -e instructions/period=100000,aux-action=pause,name=Pause/u uname  ; then
>>>> +               echo "perf record with pause / resume failed"
>>>> +               return 1
>>>> +       fi
>>>> +       if ! perf script -i "${perfdatafile}" --itrace=b -Fperiod,event | \
>>>> +                       awk 'BEGIN {paused=1;branches=0}
>>>> +                            /Resume/ {paused=0}
>>>> +                            /branches/ {if (paused) exit 1;branches=1}
>>>> +                            /Pause/ {paused=1}
>>>> +                            END {if (!branches) exit 1}' ; then
>>>> +               echo "perf record with pause / resume failed"
>>>> +               return 1
>>>> +       fi
>>>> +       echo OK
>>>
>>> Hi,
>>>
>>> this new test is now constantly making "Miscellaneous Intel PT testing" fail:
>>>
>>> ```
>>> ...
>>> --- Test with pause / resume ---
>>> Error:
>>> Failure to open event 'intel_pt/aux-action=start-paused/u' on PMU
>>> 'intel_pt' which will be removed.
>>> The 'aux_action' feature is not supported, update the kernel.
>>> Linux
>>> [ perf record: Woken up 1 times to write data ]
>>> [ perf record: Captured and wrote 0.003 MB
>>> /tmp/perf-test-intel-pt-sh.Hs8jcq0ADc/test-perf.data ]
>>> Error:
>>> Failure to open event 'intel_pt/aux-action=start-paused/u' on PMU
>>> 'intel_pt' which will be removed.
>>> The 'aux_action' feature is not supported, update the kernel.
>>> Error:
>>> Failure to open event 'Resume' on PMU 'cpu' which will be removed.
>>> The 'aux_action' feature is not supported, update the kernel.
>>> Error:
>>> Failure to open event 'Pause' on PMU 'cpu' which will be removed.
>>> The 'aux_action' feature is not supported, update the kernel.
>>> Linux
>>> [ perf record: Woken up 1 times to write data ]
>>> [ perf record: Captured and wrote 0.005 MB
>>> /tmp/perf-test-intel-pt-sh.Hs8jcq0ADc/test-perf.data ]
>>> perf record with pause / resume failed
>>> --- Cleaning up ---
>>> ...
>>> ```
>>>
>>> Should the fail be turned into a skip for missing kernel support?
>>
>> Seems to skip for me with perf-tools-next:
>>
>> --- Test with pause / resume ---
>> Error:
>> The 'aux_action' feature is not supported, update the kernel.
>> SKIP: pause / resume is not supported
>>
>> perf version 6.13.rc2.g39c2547579aa
> 
> My mistake, I thought I tested a clean client but I was testing with:
> https://lore.kernel.org/lkml/20241221192654.94344-1-irogers@google.com/
> The issue there is that intel-pt is opening multiple dummy events in this test:

> 
> That is a dummy event is added in 2 places:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/arch/x86/util/intel-pt.c?h=perf-tools-next#n800
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/arch/x86/util/intel-pt.c?h=perf-tools-next#n865
> 
> I'll need to update my patch set for things outside of record adding
> dummy events, but I'm curious if the intel-pt code could share a
> single dummy evsel?

I doubt it.  There are cases where capturing auxiliary events
like text_poke or context_switch want to be system-wide while
the workload task events (comm, task, mmap2) are not.

