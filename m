Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D5B27466A;
	Thu, 21 May 2026 00:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779324758; cv=none; b=QUS3l9DFk8Lr9ZdXhHPei3v7Oesa9NAvNDbK5EQ2QkAg3B4sDuvNMCrkDXdLGuRvUuivO6bOCrkWplP+e3+WbxLf6gE715Yd+jm+l8xjGkx0N0EDpdp8xoUMUQ2aAeVxPxjW4bTGp5fc6FCURLF+2TChhbvfSYa6Stjq/9dWpko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779324758; c=relaxed/simple;
	bh=GiJ8jl8bnSFrq+qC1f+IjQr32PkJgS+cHDCZpkTbuwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVqKG3bIc+NezahDxA3A7OTEPsx4EnxsBYxhvx7aDIXS5Td5XLdtlSRSXEBIyTFyZ2YJXz3xJcbNMa8WNyR02NadCoDdNzxTOY3EDqr6MGjwCYGmTx5wtp3xsGAi4v2PysFEsL+Ujlx6jdsj9H6Y3gnDpDrEnM0Upyrx910Dwe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hzkuklG3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzkuklG3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779324756; x=1810860756;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GiJ8jl8bnSFrq+qC1f+IjQr32PkJgS+cHDCZpkTbuwQ=;
  b=hzkuklG3jOKKHb55p6VIZyXa5PPZQKGvIkesb7envsY6akLlWVAZ8N2k
   8gX9n8ajZQyvynqrq1Fnu8VtxAku/Z219AGHiFG4g9TfcFhXCMFQ/iRwe
   rXLnyaE/0Wynp33YL9Oxf1D/d3xvQAy4OKiGe/sOVtJTyVq7YJZYyITAt
   x35dEOKmpy29+8nOB39H0luLX2EqfydDul9qCXBSZ4fTDkdqZrokdgWwW
   RLmcKCEotr+5hF4hUZKxSPvf0JjM3qdRrHLWXRdIrgoeIimZnoKmn8MVg
   wWT2dfJoj2aT6aCaAF/JuDVfBiPDBqTZ0z16rHnzOroEe2w854y9qIQKU
   w==;
X-CSE-ConnectionGUID: qVcDAUpoR++21k7raUZPgA==
X-CSE-MsgGUID: VKLi8OnPQ32ddD0sp3fhOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="97807114"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="97807114"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 17:52:35 -0700
X-CSE-ConnectionGUID: 4Gl38xxOS8uk1KwPYWWQFw==
X-CSE-MsgGUID: 9EWWqPKaQjGdT2bQjU9Nng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="240230452"
Received: from unknown (HELO [10.238.3.164]) ([10.238.3.164])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 17:52:32 -0700
Message-ID: <cc0a4682-20ca-4796-82b2-f7eb8eba3a7f@linux.intel.com>
Date: Thu, 21 May 2026 08:52:29 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3] perf tests: Add auto counter reload (ACR) sampling
 test
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260421045511.2401316-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260421045511.2401316-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Kindly ping. :)

Thanks.


On 4/21/2026 12:55 PM, Dapeng Mi wrote:
> Add auto counter reload sampling test to verify that the intended event
> records can be captured and the self-reloaded events won't generate any
> records.
>
> Additionally, enhance ratio_to_prev test to verify ACR sampling as well
> if ACR is supported.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>
> V3: Move ratio-to-prev ACR sampling test into ratio_to_prev test.
> V2: https://lore.kernel.org/all/20260420025501.2133495-1-dapeng1.mi@linux.intel.com/
> v1: https://lore.kernel.org/all/20260413010920.546501-1-dapeng1.mi@linux.intel.com/
>
>  tools/perf/tests/shell/record.sh | 92 +++++++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 7cb81cf3444a..091d8b0a998b 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -402,7 +402,52 @@ test_callgraph() {
>    echo "Callgraph test [Success]"
>  }
>  
> +test_acr_sampling() {
> +  events="{instructions/period=40000,acr_mask=0x2/u,cycles/period=20000,acr_mask=0x3/u}"
> +  pebs_events="{instructions/period=40000,acr_mask=0x2/pu,cycles/period=20000,acr_mask=0x3/u}"
> +  echo "Auto counter reload (ACR) sampling test"
> +  if ! perf record -o "${perfdata}" -e "${events}" ${testprog} 2> /dev/null
> +  then
> +    echo "Auto counter reload sampling [Skipped not supported]"
> +    return
> +  fi
> +  if ! perf script -i "${perfdata}" -F event | grep -q "instructions"
> +  then
> +    echo "Auto counter reload sampling [Failed missing instructions event]"
> +    err=1
> +    return
> +  fi
> +  if perf script -i "${perfdata}" -F event | grep -q "cycles"
> +  then
> +    echo "Auto counter reload sampling [Failed cycles event shouldn't be sampled]"
> +    err=1
> +    return
> +  fi
> +  if ! perf record -o "${perfdata}" -e "${pebs_events}" ${testprog} 2> /dev/null
> +  then
> +    echo "Auto counter reload PEBS sampling [Skipped not supported]"
> +    echo "Auto counter reload sampling [Success]"
> +    return
> +  fi
> +  if ! perf script -i "${perfdata}" -F event | grep -q "instructions"
> +  then
> +    echo "Auto counter reload PEBS sampling [Failed missing instructions event]"
> +    err=1
> +    return
> +  fi
> +  if perf script -i "${perfdata}" -F event | grep -q "cycles"
> +  then
> +    echo "Auto counter reload PEBS sampling [Failed cycles event shouldn't be sampled]"
> +    err=1
> +    return
> +  fi
> +  echo "Auto counter reload sampling [Success]"
> +}
> +
>  test_ratio_to_prev() {
> +  ratio_events="{instructions:u,cycles/period=20000,ratio-to-prev=0.5/u}"
> +  p_core_ratio_events="{cpu_core/instructions/u,cpu_core/cycles,period=20000,ratio-to-prev=0.5/u}"
> +  e_core_ratio_events="{cpu_atom/instructions/u,cpu_atom/cycles,period=20000,ratio-to-prev=0.5/u}"
>    echo "ratio-to-prev test"
>    if ! perf record -o /dev/null -e "{instructions, cycles/period=100000,ratio-to-prev=0.5/}" \
>       true 2> /dev/null
> @@ -438,7 +483,51 @@ test_ratio_to_prev() {
>      err=1
>      return
>    fi
> -  echo "Basic ratio-to-prev record test [Success]"
> +
> +  ratio_err=0
> +  do_ratio_to_prev_test() {
> +    local events=$1
> +    local cpu=$2
> +    if ! perf record -o "${perfdata}" -e "${events}" ${testprog} 2> /dev/null
> +    then
> +      echo "Auto counter reload ${cpu} ratio-to-prev sampling [Failed sampling]"
> +      ratio_err=1
> +      return
> +    fi
> +    if ! perf script -i "${perfdata}" -F event | grep -q "instructions"
> +    then
> +      echo "Auto counter reload ${cpu} ratio-to-prev sampling [Failed missing instructions event]"
> +      ratio_err=1
> +      return
> +    fi
> +    if perf script -i "${perfdata}" -F event | grep -q "cycles"
> +    then
> +      echo "Auto counter reload ${cpu} ratio-to-prev sampling [Failed cycles event shouldn't be sampled]"
> +      ratio_err=1
> +      return
> +    fi
> +  }
> +
> +  # ratio-to-prev sampling would fallback to normal sampling if ACR sampling
> +  # is not supported, so acr_mask must be checked before testing ratio-to-prev sampling.
> +  if [ -e /sys/bus/event_source/devices/cpu/format/acr_mask ]
> +  then
> +    do_ratio_to_prev_test "${ratio_events}" ""
> +  fi
> +  if [ -e /sys/bus/event_source/devices/cpu_core/format/acr_mask ]
> +  then
> +    do_ratio_to_prev_test "${p_core_ratio_events}" "P-core"
> +  fi
> +  if [ -e /sys/bus/event_source/devices/cpu_atom/format/acr_mask ]
> +  then
> +    do_ratio_to_prev_test "${e_core_ratio_events}" "E-core"
> +  fi
> +  if test "$ratio_err" -eq 0
> +  then
> +    echo "Basic ratio-to-prev record test [Success]"
> +  else
> +    err="${ratio_err}"
> +  fi
>  }
>  
>  # raise the limit of file descriptors to minimum
> @@ -457,6 +546,7 @@ test_leader_sampling
>  test_topdown_leader_sampling
>  test_precise_max
>  test_callgraph
> +test_acr_sampling
>  test_ratio_to_prev
>  
>  # restore the default value
