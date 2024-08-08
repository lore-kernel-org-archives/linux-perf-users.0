Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E062A1D8;
	Thu,  8 Aug 2024 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132878; cv=none; b=FP0XLC4k6d2p/K8cb+50iq+AiB+lfOAdRREJAkbD5h3bfVjh8lZfK68xlf1CYLa5KH7EpiTeoGwBr5eA1+UMC74FYPz4V4ex5+fA7tGTJnT6FSNdRXySFIJOPcXobWQOs1GoK1Ku2vxK364qaSBoaTDGeXJn2I32jM+q8A8VZLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132878; c=relaxed/simple;
	bh=xvwvB/psykvCm34h1+muAYrTqyjD3HNGOWoSokZS6nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HmUSN44PfheBXAVq3JIZK5Aq+JuVM510mGWhixm/vUa+QmBSoDfIFMOpvD/KV6mBJXqhQ/EWebHGAbGiDzVTFhmnmLOnpBSIhcOh6Gc8K1l0lyVrZ2fth1cD033zSEY2WKwU6QCnlTAI4LtBlVLu2uC4yw2xjEiITZgwRQcW+KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bLnEyCgO; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bLnEyCgO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723132877; x=1754668877;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xvwvB/psykvCm34h1+muAYrTqyjD3HNGOWoSokZS6nQ=;
  b=bLnEyCgOz4y56w2yiWcV1QUOzCPgoxi63FNyzWzmxulsj/gN+HlVCdgG
   IvStkOkJYPRKPsLu5u+Zd3S8ZBpE/Z8g4jDDLkBdg0o7sTP6tokc/81e+
   lxZOiF6F55PzipEKnZhxWowQV0WyuI5chhSY5j+xKQc1SLv2YFmmJfAkm
   dXk8j6PKBPK+YUUEajgFvHlnBxvHd4MEN/7BBuiu/wTZSv5VEFlJ54jEy
   z8NvW+xIEQI7lcbPZjCVV7r4+G6FM8+XGQ/LzvtXKTcr2f6WN7H4NJS//
   wIJtqJBkLEFj2vavn/0ujSggQEQlVnOgO+JYMJw2j/ux6OocQtDrwpFFP
   Q==;
X-CSE-ConnectionGUID: 1m/TrcamS+Wgm+vYdKOveg==
X-CSE-MsgGUID: ocgLCIIPTN6Wo7nLm3sq1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21419149"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="21419149"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 09:01:16 -0700
X-CSE-ConnectionGUID: jZHqVLAwTHGZ7isCRVm2/Q==
X-CSE-MsgGUID: zTyT7zjrSTqnLFlFiSHn1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="57149088"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 09:01:13 -0700
Received: from [10.212.64.50] (kliang2-mobl1.ccr.corp.intel.com [10.212.64.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id D06CE20CFED4;
	Thu,  8 Aug 2024 09:01:10 -0700 (PDT)
Message-ID: <5af60713-48a4-4031-b6dc-3680f3a95f8d@linux.intel.com>
Date: Thu, 8 Aug 2024 12:01:09 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] perf test: Add set of perf record LBR tests
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Anne Macedo <retpolanne@posteo.net>, Changbin Du <changbin.du@huawei.com>,
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20240808054644.1286065-1-irogers@google.com>
 <20240808054644.1286065-2-irogers@google.com> <ZrTXftup0H46R8WK@x1>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZrTXftup0H46R8WK@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-08-08 10:34 a.m., Arnaldo Carvalho de Melo wrote:
> On Wed, Aug 07, 2024 at 10:46:44PM -0700, Ian Rogers wrote:
>> Adds coverage for LBR operations and LBR callgraph.
>>
>> Signed-off-by: Ian Rogers <irogers@google.com>
>> ---
>>  tools/perf/tests/shell/record_lbr.sh | 161 +++++++++++++++++++++++++++
>>  1 file changed, 161 insertions(+)
>>  create mode 100755 tools/perf/tests/shell/record_lbr.sh
>>
>> diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
>> new file mode 100755
>> index 000000000000..baf168d0ddbb
>> --- /dev/null
>> +++ b/tools/perf/tests/shell/record_lbr.sh
>> @@ -0,0 +1,161 @@
>> +#!/bin/bash
>> +# perf record LBR tests
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +set -e
>> +
>> +if [ ! -f /sys/devices/cpu/caps/branches ]
>> +then
>> +  echo "Skip: only x86 CPUs support LBR"
>> +  exit 2
>> +fi
> 
> root@x1:~# ls -la /sys/devices/cpu*/caps/branches 
> -r--r--r--. 1 root root 4096 Jun  4 16:07 /sys/devices/cpu_atom/caps/branches
> -r--r--r--. 1 root root 4096 Aug  8 11:21 /sys/devices/cpu_core/caps/branches
> root@x1:~#
> 
> I'm getting:
> 
> root@x1:~# perf test -vvvv LBR
>  97: perf record LBR tests:
> --- start ---
> test child forked, pid 2033388
> Skip: only x86 CPUs support LBR
> ---- end(-2) ----
>  97: perf record LBR tests                                           : Skip
> root@x1:~#
> 
> So I added the following follow-up patch, ack?


Thanks Arnaldo. We need the test works on hybrid as well.

For both original patch and this patch,

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> 
> - Arnaldo
> 
> From f6ea332dd25cc62b9493b2d40040c2fb35253d9e Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Thu, 8 Aug 2024 11:26:13 -0300
> Subject: [PATCH 1/1] perf test shell lbr: Support hybrid x86 systems too
> 
> Running on a:
> 
>   root@x1:~# grep 'model name' -m1 /proc/cpuinfo
>   model name	: 13th Gen Intel(R) Core(TM) i7-1365U
>   root@x1:~#
> 
> It skips all the tests with:
> 
>   root@x1:~# perf test -vvvv LBR
>    97: perf record LBR tests:
>   --- start ---
>   test child forked, pid 2033388
>   Skip: only x86 CPUs support LBR
>   ---- end(-2) ----
>    97: perf record LBR tests                                           : Skip
>   root@x1:~#
> 
> Because the test checks for the /sys/devices/cpu/caps/branches file,
> that isn't present as we have instead:
> 
>   root@x1:~# ls -la /sys/devices/cpu*/caps/branches
>   -r--r--r--. 1 root root 4096 Aug  8 11:22 /sys/devices/cpu_atom/caps/branches
>   -r--r--r--. 1 root root 4096 Aug  8 11:21 /sys/devices/cpu_core/caps/branches
>   root@x1:~#
> 
> If we check as well for one of those,
> /sys/devices/cpu_core/caps/branches, then we don't skip the tests and
> all are run on these x86 Intel Hybrid systems as well, passing all of
> them:
> 
>   root@x1:~# perf test -vvvv LBR
>    97: perf record LBR tests:
>   --- start ---
>   test child forked, pid 2034956
>   LBR callgraph
>   [ perf record: Woken up 5 times to write data ]
>   [ perf record: Captured and wrote 1.812 MB /tmp/__perf_test.perf.data.B2HvQ (8114 samples) ]
>   LBR callgraph [Success]
>   LBR any branch test
>   [ perf record: Woken up 25 times to write data ]
>   [ perf record: Captured and wrote 6.382 MB /tmp/__perf_test.perf.data.B2HvQ (8071 samples) ]
>   LBR any branch test: 8071 samples
>   LBR any branch test [Success]
>   LBR any call test
>   [ perf record: Woken up 23 times to write data ]
>   [ perf record: Captured and wrote 6.208 MB /tmp/__perf_test.perf.data.B2HvQ (8092 samples) ]
>   LBR any call test: 8092 samples
>   LBR any call test [Success]
>   LBR any ret test
>   [ perf record: Woken up 24 times to write data ]
>   [ perf record: Captured and wrote 6.396 MB /tmp/__perf_test.perf.data.B2HvQ (8093 samples) ]
>   LBR any ret test: 8093 samples
>   LBR any ret test [Success]
>   LBR any indirect call test
>   [ perf record: Woken up 25 times to write data ]
>   [ perf record: Captured and wrote 6.344 MB /tmp/__perf_test.perf.data.B2HvQ (8067 samples) ]
>   LBR any indirect call test: 8067 samples
>   LBR any indirect call test [Success]
>   LBR any indirect jump test
>   [ perf record: Woken up 12 times to write data ]
>   [ perf record: Captured and wrote 3.073 MB /tmp/__perf_test.perf.data.B2HvQ (8061 samples) ]
>   LBR any indirect jump test: 8061 samples
>   LBR any indirect jump test [Success]
>   LBR direct calls test
>   [ perf record: Woken up 25 times to write data ]
>   [ perf record: Captured and wrote 6.380 MB /tmp/__perf_test.perf.data.B2HvQ (8076 samples) ]
>   LBR direct calls test: 8076 samples
>   LBR direct calls test [Success]
>   LBR any indirect user call test
>   [ perf record: Woken up 5 times to write data ]
>   [ perf record: Captured and wrote 1.597 MB /tmp/__perf_test.perf.data.B2HvQ (8079 samples) ]
>   LBR any indirect user call test: 8079 samples
>   LBR any indirect user call test [Success]
>   LBR system wide any branch test
>   [ perf record: Woken up 26 times to write data ]
>   [ perf record: Captured and wrote 9.088 MB /tmp/__perf_test.perf.data.B2HvQ (9209 samples) ]
>   LBR system wide any branch test: 9209 samples
>   LBR system wide any branch test [Success]
>   LBR system wide any call test
>   [ perf record: Woken up 25 times to write data ]
>   [ perf record: Captured and wrote 8.945 MB /tmp/__perf_test.perf.data.B2HvQ (9333 samples) ]
>   LBR system wide any call test: 9333 samples
>   LBR system wide any call test [Success]
>   LBR parallel any branch test
>   LBR parallel any call test
>   LBR parallel any ret test
>   LBR parallel any indirect call test
>   LBR parallel any indirect jump test
>   LBR parallel direct calls test
>   LBR parallel system wide any branch test
>   LBR parallel any indirect user call test
>   LBR parallel system wide any call test
>   [ perf record: Woken up 9 times to write data ]
>   [ perf record: Woken up 51 times to write data ]
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Woken up 5 times to write data ]
>   [ perf record: Woken up 559 times to write data ]
>   [ perf record: Woken up 14 times to write data ]
>   [ perf record: Woken up 17 times to write data ]
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Woken up 11 times to write data ]
>   [ perf record: Captured and wrote 0.150 MB /tmp/__perf_test.perf.data.lANpR (1909 samples) ]
>   [ perf record: Captured and wrote 2.371 MB /tmp/__perf_test.perf.data.Olum8 (3033 samples) ]
>   [ perf record: Captured and wrote 1.230 MB /tmp/__perf_test.perf.data.njfJ8 (1742 samples) ]
>   [ perf record: Captured and wrote 5.554 MB /tmp/__perf_test.perf.data.4ZTrj (29662 samples) ]
>   [ perf record: Captured and wrote 19.906 MB /tmp/__perf_test.perf.data.dlGQt (29576 samples) ]
>   [ perf record: Captured and wrote 0.289 MB /tmp/__perf_test.perf.data.CAT7y (4311 samples) ]
>   [ perf record: Captured and wrote 3.129 MB /tmp/__perf_test.perf.data.diuKG (3971 samples) ]
>   LBR parallel any indirect user call test: 1909 samples
>   [ perf record: Captured and wrote 4.858 MB /tmp/__perf_test.perf.data.sVjtN (6130 samples) ]
>   LBR parallel any indirect user call test [Success]
>   [ perf record: Captured and wrote 3.669 MB /tmp/__perf_test.perf.data.AJtNI (4827 samples) ]
>   LBR parallel any indirect jump test: 4311 samples
>   LBR parallel any indirect jump test [Success]
>   LBR parallel direct calls test: 3033 samples
>   LBR parallel direct calls test [Success]
>   LBR parallel any indirect call test: 1742 samples
>   LBR parallel any indirect call test [Success]
>   LBR parallel any call test: 4827 samples
>   LBR parallel any call test [Success]
>   LBR parallel any branch test: 6130 samples
>   LBR parallel any branch test [Success]
>   LBR parallel system wide any branch test: 29662 samples
>   LBR parallel any ret test: 3971 samples
>   LBR parallel any ret test [Success]
>   LBR parallel system wide any branch test [Success]
>   LBR parallel system wide any call test: 29576 samples
>   LBR parallel system wide any call test [Success]
>   ---- end(0) ----
>    97: perf record LBR tests                                           : Ok
>   root@x1:~#
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>,
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Anne Macedo <retpolanne@posteo.net>,
> Cc: Changbin Du <changbin.du@huawei.com>,
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>,
> Cc: Jiri Olsa <jolsa@kernel.org>,
> Cc: Kan Liang <kan.liang@linux.intel.com>,
> Cc: Mark Rutland <mark.rutland@arm.com>,
> Cc: Namhyung Kim <namhyung@kernel.org>,
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/tests/shell/record_lbr.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
> index baf168d0ddbbf447..ead87b731898d70b 100755
> --- a/tools/perf/tests/shell/record_lbr.sh
> +++ b/tools/perf/tests/shell/record_lbr.sh
> @@ -4,7 +4,7 @@
>  
>  set -e
>  
> -if [ ! -f /sys/devices/cpu/caps/branches ]
> +if [ ! -f /sys/devices/cpu/caps/branches -a ! -f /sys/devices/cpu_core/caps/branches ]
>  then
>    echo "Skip: only x86 CPUs support LBR"
>    exit 2
