Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2238E271A7B;
	Wed, 12 Nov 2025 01:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762911544; cv=none; b=Y6frkJ5Ts3fe+5DgT9j/hiZ1q1LzzlJdSU+1vAUh+0zzTlLgBQdqDrOvNXSwaYq8pEBbYHZ/g6lrdS/34lanymhfu25HbfnxrizfW6CQ4D62rLptQuJh0YFYipNvuqEZ746ZekxFDl8tmw4iE60z9okV4Y4XHG5mB7l6UV6o0J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762911544; c=relaxed/simple;
	bh=dC5aByELFmakgvk0wqr11T7toMH8Eh9BJChORDfYCKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmZrmp5GhMK4NxtxS+OPBaAsdrdmpjJUgcX0bSz2nvZpNDQqFwGdyAYfLVNhrp3fJeEVcJOAON60d9bm2fS5c9s90WhKGA3M+Vq+//APRwXdUyl08RZJmZSvBE+Mks29pJQHYw2xt5RZ9TF1JSVVBLx5ca+J+hl+rnQqDoTjHZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BSoUN6En; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BSoUN6En"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762911542; x=1794447542;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dC5aByELFmakgvk0wqr11T7toMH8Eh9BJChORDfYCKM=;
  b=BSoUN6EnAeY+eqoJ1ONkr2LOzR7m83ZIiNggAFJoakYfS78skFFHac8z
   UFlqBSZ3pPblq/3LhwXSekKF9tQklsBQNqUXlm3YKI3arKSJ1T55Kyw3c
   cA632UEe2Ek08DiomYg7a8LUUeEJx4BddaZ9FeefrdP0CUNmqQQL3ucdk
   n10VZwVa3FiFbjFBa68vlMZw0reb0VqJ8aPj3/QblLT8ubzG2oJ8XQKHB
   awyRdhFZm+cdpUBTr9gkRVLBP4EpiQZPDoFTnfEo03Xf31I3Bz6Z/doa3
   YWv0MAreKPykar7a+O0psjG17GeKttZufRCIyw8WlM+EzWgtpgDH5xQa9
   A==;
X-CSE-ConnectionGUID: u4r0Hiq5Qfi1Z3IhV3nkwA==
X-CSE-MsgGUID: fsSUfhVtSsqwCgFd5A+c1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="75652808"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="75652808"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 17:39:02 -0800
X-CSE-ConnectionGUID: DkEeFC4/RZiI0XjFcN+m2A==
X-CSE-MsgGUID: 0+wKW6W9RGico2I0c3OxGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="189345608"
Received: from jbunyan-mobl1.amr.corp.intel.com (HELO [10.125.164.106]) ([10.125.164.106])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 17:39:01 -0800
Message-ID: <48f84128-bd74-4d82-8095-4b21e386bd81@intel.com>
Date: Tue, 11 Nov 2025 17:39:00 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Add a perf event fallback test
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 thomas.falcon@intel.com, dapeng1.mi@linux.intel.com, xudong.hao@intel.com
References: <20251111224246.73673-1-zide.chen@intel.com>
 <aRPdmoNdUWIlWhJU@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <aRPdmoNdUWIlWhJU@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/11/2025 5:06 PM, Namhyung Kim wrote:
> On Tue, Nov 11, 2025 at 02:42:46PM -0800, Zide Chen wrote:
>> This adds test cases to verify the precise ip fallback logic:
>>
>> - If the system supports precise ip, for an event given with the maximum
>>   precision level, it should be able to decrease precise_ip to find a
>>   supported level.
>> - The same fallback behavior should also work in more complex scenarios,
>>   such as event groups or when PEBS is involved
>>
>> Additional fallback tests, such as those covering missing feature cases,
>> can be added in the future.
>>
>> Suggested-by: Ian Rogers <irogers@google.com>
>> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>  .../tests/shell/test_event_open_fallback.sh   | 86 +++++++++++++++++++
>>  1 file changed, 86 insertions(+)
>>  create mode 100755 tools/perf/tests/shell/test_event_open_fallback.sh
>>
>> diff --git a/tools/perf/tests/shell/test_event_open_fallback.sh b/tools/perf/tests/shell/test_event_open_fallback.sh
>> new file mode 100755
>> index 000000000000..72c1ac32c785
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/test_event_open_fallback.sh
>> @@ -0,0 +1,86 @@
>> +#!/bin/bash
>> +# Perf event open fallback test
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +skip_cnt=0
>> +ok_cnt=0
>> +err_cnt=0
>> +
>> +cleanup()
>> +{
>> +	rm -f perf.data
>> +	rm -f perf.data.old
>> +	trap - EXIT TERM INT
>> +}
>> +
>> +trap_cleanup()
>> +{
>> +	cleanup
>> +	exit 1
>> +}
>> +
>> +trap trap_cleanup EXIT TERM INT
>> +
>> +perf_record()
>> +{
>> +	perf record "$@" -- true 1>/dev/null 2>&1
>> +}
>> +
>> +test_decrease_precise_ip()
>> +{
>> +	echo "Decrease precise ip test"
>> +
>> +	perf list pmu | grep -q 'cycles' || return 2
>> +
>> +	if ! perf_record -e cycles; then
>> +		return 2
>> +	fi
>> +
>> +	# It should reduce precision level down to 0 if needed.
>> +	if ! perf_record -e cycles:ppp; then
> 
> I think you need 'P' instead of 'ppp' for automatic precision.

Yes, it's better with "-e cycles:P" to explicitly set evsel.precise_max
to 1.

> Thanks,
> Namhyung
> 
> 
>> +		return 1
>> +	fi
>> +	return 0
>> +}
>> +
>> +test_decrease_precise_ip_complicated()
>> +{
>> +	echo "Decrease precise ip test (complicated case)"
>> +
>> +	perf list pmu | grep -q 'mem-loads-aux' || return 2
>> +
>> +	if ! perf_record -e '{cpu/mem-loads-aux/S,cpu/mem-loads/PS}'; then
>> +		return 1
>> +	fi
>> +	return 0
>> +}
>> +
>> +count_result()
>> +{
>> +	if [ "$1" -eq 2 ] ; then
>> +		skip_cnt=$((skip_cnt + 1))
>> +		return
>> +	fi
>> +	if [ "$1" -eq 0 ] ; then
>> +		ok_cnt=$((ok_cnt + 1))
>> +		return
>> +	fi
>> +	err_cnt=$((err_cnt + 1))
>> +}
>> +
>> +ret=0
>> +test_decrease_precise_ip		|| ret=$? ; count_result $ret ; ret=0
>> +test_decrease_precise_ip_complicated	|| ret=$? ; count_result $ret ; ret=0
>> +
>> +cleanup
>> +
>> +if [ ${err_cnt} -gt 0 ] ; then
>> +	exit 1
>> +fi
>> +
>> +if [ ${ok_cnt} -gt 0 ] ; then
>> +	exit 0
>> +fi
>> +
>> +# Skip
>> +exit 2
>> -- 
>> 2.51.1
>>

