Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB4C1E0B99;
	Tue,  8 Oct 2024 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400970; cv=none; b=lb1GWXV0S0CySPqvtvLveb9D+zsoFA5eTjpKBz8PZTGLbe0rNkAPcbJBEOr3/I/mC0cZvJD1Dxphsoob9Rdm/UrAJwU5zHKsVmzusfAYe6ZrCtv2h2GAkdkn9hnwFX9vLJe0bhxIPEoPsgGHkc2X6HP1CUAbHsSSDELLAh8VSD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400970; c=relaxed/simple;
	bh=sj/QpjLT22BMMSoGQ9E1G1amxY8zWPdm8RiKAdqhXqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YVJlLkDnFIMb26KNRAn+jST/PC0RM8wCXXpAi+qNyUzWRVSdurezuWUvH2619urY1kW2lrlIHI7At3x/a8iWULyLxMUMwqxm2SshQNpizjRkPsQaGtzm3vDchiNJhCVWlIC7fmJVbjBXOZfmYpy3MzcCPxappfcpHjBt47zdXw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MbM9Y+up; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MbM9Y+up"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728400969; x=1759936969;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sj/QpjLT22BMMSoGQ9E1G1amxY8zWPdm8RiKAdqhXqs=;
  b=MbM9Y+up7xBuE7kFdTakvbQG51/CdNeZ0iYYyZfHIsHbWCdeuZaniAE4
   yh6936DiDhecDWwQcFUeeCRuUk/xQ9T3OwO4MlxrRqLpmOiKoRu9w87C5
   vzwQ6raGUNHWwWBVeiqg8nYMEa0o88XY1wXR/NjnLejpEVlzTxQCKyCL8
   jbOjs0Hr7itkFvOC3E1UExJFbnoA1/edS9UEpZWxSxlvkUCFgYx1VGaAj
   UXMdgyOnWzX2QhtFC9DMKQJChjDjg0SbrShBEkmil2vEXg+IxDObqkq0S
   9z4xjFDw6kfh+227WqaquqFXu3T1eTjU+hEFZa+4GJqSrIieZ8RP26mA2
   g==;
X-CSE-ConnectionGUID: ITLP0AUTQEGo0pA1+GXFkg==
X-CSE-MsgGUID: Khq3bSe8SpOlO+eKRefqOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="31502335"
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="31502335"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 08:22:44 -0700
X-CSE-ConnectionGUID: 4tH/6GISQamZDsoLllWpFg==
X-CSE-MsgGUID: R33U4JiFQUSRoGYPvWkTag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,187,1725346800"; 
   d="scan'208";a="75876316"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.245.96.163])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 08:22:40 -0700
Message-ID: <6bde6bde-f83f-427a-9107-8f867703c9b5@intel.com>
Date: Tue, 8 Oct 2024 18:22:33 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test x86: Fix typo in intel-pt-test
To: Thomas Falcon <thomas.falcon@intel.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241007194758.78659-1-thomas.falcon@intel.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20241007194758.78659-1-thomas.falcon@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/24 22:47, Thomas Falcon wrote:
> Change function name "is_hydrid" to "is_hybrid".
> 
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/arch/x86/tests/intel-pt-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/tests/intel-pt-test.c b/tools/perf/arch/x86/tests/intel-pt-test.c
> index 09d61fa736e3..b217ed67cd4e 100644
> --- a/tools/perf/arch/x86/tests/intel-pt-test.c
> +++ b/tools/perf/arch/x86/tests/intel-pt-test.c
> @@ -375,7 +375,7 @@ static int get_pt_caps(int cpu, struct pt_caps *caps)
>  	return 0;
>  }
>  
> -static bool is_hydrid(void)
> +static bool is_hybrid(void)
>  {
>  	unsigned int eax, ebx, ecx, edx = 0;
>  	bool result;
> @@ -441,7 +441,7 @@ int test__intel_pt_hybrid_compat(struct test_suite *test, int subtest)
>  	int ret = TEST_OK;
>  	int cpu;
>  
> -	if (!is_hydrid()) {
> +	if (!is_hybrid()) {
>  		test->test_cases[subtest].skip_reason = "not hybrid";
>  		return TEST_SKIP;
>  	}

