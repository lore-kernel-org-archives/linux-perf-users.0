Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39E2155335;
	Tue,  2 Jul 2024 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719943672; cv=none; b=PPWkYaSrM0579BSz+mgzYarQOuJVIF0MXeekTNA4tLRsIqXM3Ew7FeX6OOHhJjTKKmyMrN9FoWBasmvzf4gmcshr0VD+djRyEf8d0ukoy2MFG/gKQaRUSaMFBy62fR1HcnHLKRhsXRvOLwJQIDepqPmDmlhiE/QtZ0nRxhxDpYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719943672; c=relaxed/simple;
	bh=RVsklypjd71jNiDAi5DwmES1aRVvQ6U8SRsG59Nfhy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gbya3DoyocqHqAZtwoGwYQ1HoQfO6IOPPuZa6ze5c1AUOG9aMn0ooNmBwku1k7n81Qqh14HQZ60gCQpZFo78EJpwmpDK9YCQl2aTGhqgS+yDxBiKddHDqK9QuAHbCL3oVLVEQGlfmzaVHhLa8aQrWfmhyMrCxg6ayFYm8VaHiMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kshCFbJ+; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kshCFbJ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719943671; x=1751479671;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RVsklypjd71jNiDAi5DwmES1aRVvQ6U8SRsG59Nfhy4=;
  b=kshCFbJ+t+jOr5TUFBLj5cPMGmTuItKEcyUyjNczz2CqX6Lr6Wiig/TQ
   wfFcuxmlDyXMamlm/7zZw6YQDc9OhdBizRR3Te7/EWcWDK0mLdxNU7iR3
   eabXbN8ggwsRF7xER0UxiUEGoGWsM2XnBesXXqLEUKgGs3jcjrdSzg406
   Rm4R0jgk8YyEcV/QvW7uya7r+uc5X0LB6H9Ve2X2Ly0VtRrbHms804pB6
   NIo8a8f+gPhuCDjqAAdT3tSZVGhj+CNpvDVEqYlPBqz6GfPsamgOEqcA8
   lCGfPCX9vt2CS6pFehQKGyVh+aZIT4xDf1Wrdu60MRm2xdxc4DFYWR+Mq
   Q==;
X-CSE-ConnectionGUID: t+fhFCM9Tp2MqVSPAyjcVA==
X-CSE-MsgGUID: ejXXYeYdRpmFfRJLgUvfqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16978281"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="16978281"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 11:07:51 -0700
X-CSE-ConnectionGUID: 5tRMS+cARwOqxWGGbZ+DdA==
X-CSE-MsgGUID: MCejlVv4SWyxqGQ/0/UZiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="46729005"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 11:07:51 -0700
Received: from [10.212.94.246] (kliang2-mobl1.ccr.corp.intel.com [10.212.94.246])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 25F2C201A797;
	Tue,  2 Jul 2024 11:07:49 -0700 (PDT)
Message-ID: <f56397c3-91ee-44c1-8695-11bece4c4231@linux.intel.com>
Date: Tue, 2 Jul 2024 14:07:47 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] perf tests: Add leader sampling test in record tests
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yanfei Xu <yanfei.xu@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
References: <20240702224037.343958-1-dapeng1.mi@linux.intel.com>
 <20240702224037.343958-5-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240702224037.343958-5-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-07-02 6:40 p.m., Dapeng Mi wrote:
> Add leader sampling test to validate event counts are captured into
> record and the count value is consistent.
> 
> Suggested-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/perf/tests/shell/record.sh | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 3d1a7759a7b2..8e3e66780fed 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -17,6 +17,7 @@ skip_test_missing_symbol ${testsym}
>  
>  err=0
>  perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +script_output=$(mktemp /tmp/__perf_test.perf.data.XXXXX.script)
>  testprog="perf test -w thloop"
>  cpu_pmu_dir="/sys/bus/event_source/devices/cpu*"
>  br_cntr_file="/caps/branch_counter_nr"
> @@ -190,11 +191,38 @@ test_branch_counter() {
>    echo "Basic branch counter test [Success]"
>  }
>  
> +test_leader_sampling() {
> +  echo "Basic leader sampling test"
> +  if ! perf record -o "${perfdata}" -e "{branches,branches}:Su" perf test -w brstack 2> /dev/null

I think we still need a case to verify the topdown fix you did in the
patch set.
Since the topdown is platform specific, you may want to skip it on the
platform which doesn't support perf metrics. For example, check if the
slots event exists in the event folder.

Thanks,
Kan
> +  then
> +    echo "Leader sampling [Failed record]"
> +    err=1
> +    return
> +  fi
> +  index=0
> +  perf script -i "${perfdata}" > $script_output
> +  while IFS= read -r line
> +  do
> +    # Check if the two branches counts are equal in each record
> +    branches=$(echo $line | awk '{for(i=1;i<=NF;i++) if($i=="branches:") print $(i-1)}')
> +    if [ $(($index%2)) -ne 0 ] && [ ${branches}x != ${prev_branches}x ]
> +    then
> +      echo "Leader sampling [Failed inconsistent branches count]"
> +      err=1
> +      return
> +    fi
> +    index=$(($index+1))
> +    prev_branches=$branches
> +  done < $script_output
> +  echo "Basic leader sampling test [Success]"
> +}
> +
>  test_per_thread
>  test_register_capture
>  test_system_wide
>  test_workload
>  test_branch_counter
> +test_leader_sampling
>  
>  cleanup
>  exit $err
