Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D23315FD13;
	Sat, 21 Dec 2024 19:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734809428; cv=none; b=TuLnsKpO9htGOKwIcICVSwS8RQxhcO8IzyXIK5tLoa8gPHTwj7CMMz0b03X1pjmJG8YSYE4pF6cdhnGJTaHIZtsRjKc9o42dgbrN/koTxyVUuO8EUbeO+5dbhHTXcJC5GclkvZej4IiFEXcZn3a0Vn9sQAkSwq6YmJ0cShDfPVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734809428; c=relaxed/simple;
	bh=IOfbxsrC8aD2n09TFPfd0ao5uwCRwpJy0hOUB0J2tXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYJyIqiH1Zozxfvwz3OdTRkqh7XEbA0XnoquIAQR82nXzVE1XyvyWGfJmTjGacTxskd4NaklQ5BaS7sauFE+5Ck8UeMlJ2Y0IMRPE+c21KI581i60+p8hka96AU7EV82fSus//mr/GUP7dMzXEOMG9rx6C376PPypal1oiqHxLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iq6RCIxE; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iq6RCIxE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734809426; x=1766345426;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IOfbxsrC8aD2n09TFPfd0ao5uwCRwpJy0hOUB0J2tXw=;
  b=Iq6RCIxE6B4vnbRANo76mndk9i2c8oK7Ri3KXXcjZZXtD7xoEDAII0tZ
   DJuY0BPqulliqNpoFwOb9zadebRi0Ad4hoK0mq0X3nnm4DrM+rAq1usfb
   oVcRanDzoiB+QYHX5pIYq5jyb7lfx0YLEKBNJGQhKf8Bot4mtMmQldS0C
   fPom3+vxQxS2bghc6rjgAxRW4Vvxh52q5m9RiJrvKM8718AFo9NNhmsxN
   jLdMr1aTRFNPoJYr30MFtxE0IQy0TKhk+ITyHphgzJqSyFyxGmsf0nkhW
   6UEKuL5igAYJLicF/tF+DQjp/BB6rXrrDDJESNZ/wpLjmnpnE7q0t5zYE
   A==;
X-CSE-ConnectionGUID: OJ5wFal2SCCznkJf+laZ3g==
X-CSE-MsgGUID: ut90fpKsQf2JUqky+SIFLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11293"; a="35452963"
X-IronPort-AV: E=Sophos;i="6.12,254,1728975600"; 
   d="scan'208";a="35452963"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2024 11:30:26 -0800
X-CSE-ConnectionGUID: vq7bSgWASAu1jnzJzA6ruQ==
X-CSE-MsgGUID: XjXn7MD8Tq2l7S14V2qWYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122107447"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.178.169])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2024 11:30:22 -0800
Message-ID: <7e438859-26c3-4ad6-850b-21b9ab6078c3@intel.com>
Date: Sat, 21 Dec 2024 21:30:14 +0200
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
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fUwjYH8uvmsgSN=1exN1FEEBEPQHFYwgq4cJEeOApFNQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/12/24 19:10, Ian Rogers wrote:
> On Sun, Dec 15, 2024 at 11:03 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> Add a simple sub-test to the "Miscellaneous Intel PT testing" test to
>> check pause / resume.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> Acked-by: Ian Rogers <irogers@google.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> ---
>>  tools/perf/tests/shell/test_intel_pt.sh | 28 +++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
>> index e6f0070975f6..f3a9a040bacc 100755
>> --- a/tools/perf/tests/shell/test_intel_pt.sh
>> +++ b/tools/perf/tests/shell/test_intel_pt.sh
>> @@ -644,6 +644,33 @@ test_pipe()
>>         return 0
>>  }
>>
>> +test_pause_resume()
>> +{
>> +       echo "--- Test with pause / resume ---"
>> +       if ! perf_record_no_decode -o "${perfdatafile}" -e intel_pt/aux-action=start-paused/u uname ; then
>> +               echo "SKIP: pause / resume is not supported"
>> +               return 2
>> +       fi
>> +       if ! perf_record_no_bpf -o "${perfdatafile}" \
>> +                       -e intel_pt/aux-action=start-paused/u \
>> +                       -e instructions/period=50000,aux-action=resume,name=Resume/u \
>> +                       -e instructions/period=100000,aux-action=pause,name=Pause/u uname  ; then
>> +               echo "perf record with pause / resume failed"
>> +               return 1
>> +       fi
>> +       if ! perf script -i "${perfdatafile}" --itrace=b -Fperiod,event | \
>> +                       awk 'BEGIN {paused=1;branches=0}
>> +                            /Resume/ {paused=0}
>> +                            /branches/ {if (paused) exit 1;branches=1}
>> +                            /Pause/ {paused=1}
>> +                            END {if (!branches) exit 1}' ; then
>> +               echo "perf record with pause / resume failed"
>> +               return 1
>> +       fi
>> +       echo OK
> 
> Hi,
> 
> this new test is now constantly making "Miscellaneous Intel PT testing" fail:
> 
> ```
> ...
> --- Test with pause / resume ---
> Error:
> Failure to open event 'intel_pt/aux-action=start-paused/u' on PMU
> 'intel_pt' which will be removed.
> The 'aux_action' feature is not supported, update the kernel.
> Linux
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.003 MB
> /tmp/perf-test-intel-pt-sh.Hs8jcq0ADc/test-perf.data ]
> Error:
> Failure to open event 'intel_pt/aux-action=start-paused/u' on PMU
> 'intel_pt' which will be removed.
> The 'aux_action' feature is not supported, update the kernel.
> Error:
> Failure to open event 'Resume' on PMU 'cpu' which will be removed.
> The 'aux_action' feature is not supported, update the kernel.
> Error:
> Failure to open event 'Pause' on PMU 'cpu' which will be removed.
> The 'aux_action' feature is not supported, update the kernel.
> Linux
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.005 MB
> /tmp/perf-test-intel-pt-sh.Hs8jcq0ADc/test-perf.data ]
> perf record with pause / resume failed
> --- Cleaning up ---
> ...
> ```
> 
> Should the fail be turned into a skip for missing kernel support?

Seems to skip for me with perf-tools-next:

--- Test with pause / resume ---
Error:
The 'aux_action' feature is not supported, update the kernel.
SKIP: pause / resume is not supported

perf version 6.13.rc2.g39c2547579aa


> 
> Thanks,
> Ian
> 
>> +       return 0
>> +}
>> +
>>  count_result()
>>  {
>>         if [ "$1" -eq 2 ] ; then
>> @@ -672,6 +699,7 @@ test_power_event                    || ret=$? ; count_result $ret ; ret=0
>>  test_no_tnt                            || ret=$? ; count_result $ret ; ret=0
>>  test_event_trace                       || ret=$? ; count_result $ret ; ret=0
>>  test_pipe                              || ret=$? ; count_result $ret ; ret=0
>> +test_pause_resume                      || ret=$? ; count_result $ret ; ret=0
>>
>>  cleanup
>>
>> --
>> 2.43.0
>>

