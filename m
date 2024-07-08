Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750F613342F;
	Mon,  8 Jul 2024 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446035; cv=none; b=LoGyi3Cu8rbrMHLS/gI2b3jb5IeM916CIOQS6nfxDb4X+2JlNnxJHWmLROfBGtazaQy2FAmCFHxBiLcuwj4irziTljfeIlJwpcuZyv9XuR1T3XawMaFewKIXDTiV4jKywsfNvesN9VKfEb/ZxM36laA65qKVG5M64xuwBM+nnRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446035; c=relaxed/simple;
	bh=Q58WLqpwRip9snNyWhcnfaZp+rmhkdt088D+TwFUeeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhq5RY22siqe9i8CYgzYQOeo3eOCXbeTRbuWxVocPF2sHEhGCzGIxTeM/QjL1boKV+A4D1N7Y0T5YZXaKtrl2RBY6TZPJbKArdGunmtYOmxPd585oYpJCuTH6PtVZK/4bDpxP5FZs0iOhqa+DnDqpBox19KMqQqrBTO4fc1IUm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cNjbWbks; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cNjbWbks"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720446034; x=1751982034;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q58WLqpwRip9snNyWhcnfaZp+rmhkdt088D+TwFUeeY=;
  b=cNjbWbks857opQ1NLz2pOKTim77qjFYQ0SVv9j7IRgm7S4MeZNg0St8P
   dHV9zZ/Dm69O0j+uSI8C9DwzxT9GziaGaUwnu8oOwZWIhvU8J2vDqPk0r
   VO+DOXoxDxShSooDv6q4FRf2FOBGk0a2YvUIJirzA9ySC/4/HFTvbEmc8
   bEKs0Y58hZLk4tsrNysKGdafnupOTUnhGMo2fY9Y0hEV/rRRO4jADGC0H
   XRlcEz0CDa/wAt5aA7UhRIL7ljnSFijCenSX/dCUI5AWSlwH0/eoqBfgC
   NxDt4WDop6i8nVW6MQh+huZBoe6nButI8aDLWRkMsX58s9YRv9oOewpy5
   A==;
X-CSE-ConnectionGUID: Azg1lzR7S7q1XA7tDUV+Ew==
X-CSE-MsgGUID: LnMBNdWMTLS33wNpkzjQeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="29045620"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="29045620"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 06:40:33 -0700
X-CSE-ConnectionGUID: VyIRTVMfStKwTCct2dX/Kw==
X-CSE-MsgGUID: R4ARqb5EQuStFjpVcemZvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="52321202"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 06:40:32 -0700
Received: from [10.212.126.29] (kliang2-mobl1.ccr.corp.intel.com [10.212.126.29])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 4C01520738C7;
	Mon,  8 Jul 2024 06:40:30 -0700 (PDT)
Message-ID: <c9e09449-f8ff-471f-adf3-1a5e8f97a102@linux.intel.com>
Date: Mon, 8 Jul 2024 09:40:28 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 5/5] perf tests: Add topdown events counting and
 sampling tests
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
References: <20240708144204.839486-1-dapeng1.mi@linux.intel.com>
 <20240708144204.839486-6-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240708144204.839486-6-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-07-08 10:42 a.m., Dapeng Mi wrote:
> Add counting and leader sampling tests to verify topdown events including
> raw format can be reordered correctly.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/perf/tests/shell/record.sh | 6 ++++++
>  tools/perf/tests/shell/stat.sh   | 6 ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 8e3e66780fed..164f0cf9648e 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -214,6 +214,12 @@ test_leader_sampling() {
>      index=$(($index+1))
>      prev_branches=$branches
>    done < $script_output

The topdown is a model specific feature and only be available for the
big core.

We need to check if topdown is supported before doing the test.

The same check in the test_topdown_groups() may be used here as well.

  if ! perf stat -e '{slots,topdown-retiring}' true > /dev/null 2>&1
  then
    echo "Topdown sampling read test [Skipped event parsing failed]"
    return
  fi

Thanks,
Kan

> +  if ! perf record -o "${perfdata}" -e "{instructions,slots,topdown-retiring}:S" true 2> /dev/null
> +  then
> +    echo "Leader sampling [Failed topdown events not reordered correctly]"
> +    err=1
> +    return
> +  fi
>    echo "Basic leader sampling test [Success]"
>  }
>  
> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
> index 3f1e67795490..092a7a2abcf8 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -79,6 +79,12 @@ test_topdown_groups() {
>      err=1
>      return
>    fi
> +  if perf stat -e '{instructions,r400,r8000}' true 2>&1 | grep -E -q "<not supported>"
> +  then
> +    echo "Topdown event group test [Failed raw format slots not reordered first]"
> +    err=1
> +    return
> +  fi
>    echo "Topdown event group test [Success]"
>  }
>  
