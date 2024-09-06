Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B2613AA38;
	Fri,  6 Sep 2024 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631810; cv=none; b=bvlueq1lJs3/Ev8dQwNNqSSHbI3O77z3mwszhIZ37lbiqfA8vOn3jUa9aJdsUsB+h/4Q00Vcu9pTpKkzKuERyM7m4sQCZr+agK11q9g6q6i09oMCWURyVVIhdZz7SC4UJajRm0yhgNsnAh94XLDxDF+F7HNeq7E5730ecb6OKFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631810; c=relaxed/simple;
	bh=HthmmZsKrtGTFG03IlSd/3qrcYzQTIhjVMcqYPZARUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dlgh1QVKoFKH4eEZ9rCtZUMKpwNKqo+wLdXWmM478Ddr04oBUkYxOf00VpZIxwEkDZcdhzsJMmhT8uZLiZH3+lEnb4BEv/1k8vRjGo9//SNjrcLCwmNVJbNZm01qLBBJv/gBBH5fcpu9NMUUtWL0wVBk3LKmZ/sMh9bYwde05qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m7kYwU24; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7kYwU24"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725631808; x=1757167808;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HthmmZsKrtGTFG03IlSd/3qrcYzQTIhjVMcqYPZARUo=;
  b=m7kYwU24IMzJLM7nLkwWf9AkvW6C2Hw+7NhSnZnM7EmA3jeqRiLP/kTw
   kYsfF4eFKh0gQIzKDF5ufrE/9QZ9rhHbi8/7taCBDIFQKEVHLzvo3vurd
   bEXfrnR1SL6ojX/s298Mxq365WvTFcu8F20m5Q/3YEaoEMqjVRgKDfEaC
   2tlMTnCxld8J616i66mhfsP99a498yeyZ0kLdCNfsaRhBis9v75GrP32N
   KxLluKCNdjWvWOfOIJB3x8sCa5GDrKF++RY5XD9ukE9BbDj/DkwTyHWFj
   9Qc5iJbAbzvPB0pijTD4ILB9QBOyJSNI/unrJSQnMqVHjVGrdss9M1ySv
   w==;
X-CSE-ConnectionGUID: UC8hLzT1T42Uo6A2dUVdNA==
X-CSE-MsgGUID: XJMk14hISdymJ5rbX8/Fdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="41899447"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="41899447"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 07:10:06 -0700
X-CSE-ConnectionGUID: pZ1WeYalS66CX4IRUl+lGg==
X-CSE-MsgGUID: Cyw9hdPOQl+cc/ZkXcnbWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="96750957"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 07:10:05 -0700
Received: from [10.212.119.23] (kliang2-mobl1.ccr.corp.intel.com [10.212.119.23])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 0AE3F20B5782;
	Fri,  6 Sep 2024 07:10:02 -0700 (PDT)
Message-ID: <bdc0312b-6243-4dbd-acf9-9c1499db3e03@linux.intel.com>
Date: Fri, 6 Sep 2024 10:10:01 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] perf tools: Don't set attr.exclude_guest by default
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>,
 James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Atish Patra <atishp@atishpatra.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, Mingwei Zhang <mizhang@google.com>,
 James Clark <james.clark@linaro.org>
References: <20240905202426.2690105-1-namhyung@kernel.org>
 <20240905202426.2690105-3-namhyung@kernel.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240905202426.2690105-3-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-05 4:24 p.m., Namhyung Kim wrote:
> The exclude_guest in the event attribute is to limit profiling in the
> host environment.  But I'm not sure why we want to set it by default
> cause we don't care about it in most cases and I feel like it just
> makes new PMU implementation complicated.
> 
> Of course it's useful for perf kvm command so I added the
> exclude_GH_default variable to preserve the old behavior for perf kvm
> and other commands like perf record and stat won't set the exclude bit.
> This is helpful for AMD IBS case since having exclude_guest bit will
> clear new feature bit due to the missing feature check logic.
> 
>   $ sysctl kernel.perf_event_paranoid
>   kernel.perf_event_paranoid = 0
> 
>   $ perf record -W -e ibs_op// -vv true 2>&1 | grep switching
>   switching off PERF_FORMAT_LOST support
>   switching off weight struct support
>   switching off bpf_event
>   switching off ksymbol
>   switching off cloexec flag
>   switching off mmap2
>   switching off exclude_guest, exclude_host
> 
> Intestingly, I found it sets the exclude_bit if "u" modifier is used.
> I don't know why but it's neither intuitive nor consistent.  Let's
> remove the bit there too.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-kvm.c                   |  1 +
>  tools/perf/tests/attr/test-record-dummy-C0 |  2 +-
>  tools/perf/tests/parse-events.c            | 18 +++++++++---------
>  tools/perf/util/parse-events.c             |  2 +-
>  tools/perf/util/util.c                     | 10 ++++++++--
>  tools/perf/util/util.h                     |  3 +++
>  6 files changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 55ea17c5ff02acf7..5e32d4e78fdf2424 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -2147,6 +2147,7 @@ int cmd_kvm(int argc, const char **argv)
>  						"buildid-list", "stat", NULL };
>  	const char *kvm_usage[] = { NULL, NULL };
>  
> +	exclude_HG_default = true;

exclude_GH_default?

Thanks,
Kan

>  	perf_host  = 0;
>  	perf_guest = 1;
>  
> diff --git a/tools/perf/tests/attr/test-record-dummy-C0 b/tools/perf/tests/attr/test-record-dummy-C0
> index 576ec48b3aafaa6a..8ce6f0a5df5b7013 100644
> --- a/tools/perf/tests/attr/test-record-dummy-C0
> +++ b/tools/perf/tests/attr/test-record-dummy-C0
> @@ -37,7 +37,7 @@ precise_ip=0
>  mmap_data=0
>  sample_id_all=1
>  exclude_host=0
> -exclude_guest=1
> +exclude_guest=0
>  exclude_callchain_kernel=0
>  exclude_callchain_user=0
>  mmap2=1
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 639e65a9bf61801a..9077d581c0d05e62 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -933,7 +933,7 @@ static int test__group2(struct evlist *evlist)
>  			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>  			TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
>  			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> -			TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +			TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>  			TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>  			TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  			TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> @@ -948,7 +948,7 @@ static int test__group2(struct evlist *evlist)
>  			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>  			TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
>  			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> -			TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +			TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>  			TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>  			TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  			if (evsel__has_leader(evsel, leader))
> @@ -1073,7 +1073,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
>  		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>  		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
>  		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>  		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>  		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> @@ -1223,7 +1223,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
>  		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>  		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
>  		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>  		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>  		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> @@ -1438,7 +1438,7 @@ static int test__leader_sample1(struct evlist *evlist)
>  		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>  		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
>  		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>  		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>  		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> @@ -1454,7 +1454,7 @@ static int test__leader_sample1(struct evlist *evlist)
>  		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>  		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
>  		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>  		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>  		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> @@ -1469,7 +1469,7 @@ static int test__leader_sample1(struct evlist *evlist)
>  		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>  		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
>  		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
> -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>  		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>  		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> @@ -1498,7 +1498,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
>  		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>  		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
>  		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>  		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>  		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> @@ -1514,7 +1514,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
>  		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>  		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
>  		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> -		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> +		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>  		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>  		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index f5eb1af8302c7bac..8d9e2d4b73822d98 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1761,7 +1761,7 @@ static int parse_events__modifier_list(struct parse_events_state *parse_state,
>  		if (mod.user) {
>  			if (!exclude)
>  				exclude = eu = ek = eh = 1;
> -			if (!exclude_GH && !perf_guest)
> +			if (!exclude_GH && !perf_guest && exclude_HG_default)
>  				eG = 1;
>  			eu = 0;
>  		}
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 9d55a13787ce3c05..7e3159faaa1991df 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -78,17 +78,23 @@ bool sysctl__nmi_watchdog_enabled(void)
>  
>  bool test_attr__enabled;
>  
> +bool exclude_HG_default;
> +
>  bool perf_host  = true;
>  bool perf_guest = false;
>  
>  void event_attr_init(struct perf_event_attr *attr)
>  {
> +	/* to capture ABI version */
> +	attr->size = sizeof(*attr);
> +
> +	if (!exclude_HG_default)
> +		return;
> +
>  	if (!perf_host)
>  		attr->exclude_host  = 1;
>  	if (!perf_guest)
>  		attr->exclude_guest = 1;
> -	/* to capture ABI version */
> -	attr->size = sizeof(*attr);
>  }
>  
>  int mkdir_p(char *path, mode_t mode)
> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index 9966c21aaf048479..d33ae883a54f2f2f 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -21,6 +21,9 @@ extern const char perf_more_info_string[];
>  
>  extern const char *input_name;
>  
> +/* This will control if perf_{host,guest} will set attr.exclude_{host,guest}. */
> +extern bool exclude_HG_default;
> +
>  extern bool perf_host;
>  extern bool perf_guest;
>  
