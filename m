Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F520DDA9;
	Tue,  5 Aug 2025 00:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754355428; cv=none; b=YCEDaEPmy2jZZxckTx2U9bEMdwjv71cPpQwD6XzvIb+q6ztov9s0j1mmhwF+j5IfvbK36iRcKoT0iVT9T3SWpV5znGcF0psbBcTDrmtxPF4KTa8YzLyt7ft1XvD7eswgG/ex5V7d0jMTpbWsMIDpc0E3fRw36jDk4yO6u6WRTtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754355428; c=relaxed/simple;
	bh=jR4n5Z37SsjlgH+HYd0zJrzEfEotbwkHeyp0LpaYVK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iCVk0fefQCxDhTpsPViErjGgC8+SSYgxgmkZ0Hi78tjn32FpLhQHhEhd40ghv7XlveC0VGJvBb1F1z3VJhWvcumGw0q3BUytNqAXlwY/Ccotx+leFj2nou73iAS0oRRHAOtR7N/14gqBuKc/VBBiESomVx4A1GVwHTBiP/s1MbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jC1bDgBf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jC1bDgBf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754355427; x=1785891427;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jR4n5Z37SsjlgH+HYd0zJrzEfEotbwkHeyp0LpaYVK8=;
  b=jC1bDgBfM5RW5gfDWA1wXuQn52zFTpE9zke2T4uSrvPY4U9ipVTpFTjH
   G9iQDoJIOoBZDzcdbiTwm75Hm7aGGcyKdcQqjrfKrrCWE7+pryHBkz09o
   3nAL4sgsJcVfN4SilPN1h8wes/ymAmMIBDboUorbUlbH+50S6MY7Gfgw5
   MOUgK53PVn63jDeMLn5GX2VBNP0Zk+6FIDqqOOfjk6v7Pf0q+pt0ohk1j
   y0s0EeHLh9qXoCHHOD6KjshBUsTqkBluFNZSKGLV/QHQo7QSpfi5fuLtY
   5IlZqoRLXdTqnx7IwYge+Kn39+6+qLTiPiO1tJsKgNqF14rKa1ZQabHEq
   A==;
X-CSE-ConnectionGUID: OS9EpY4zQDWHH7+wHayyNQ==
X-CSE-MsgGUID: K5WBpgx5TXeru5KwYg4JCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="68004570"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="68004570"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 17:57:07 -0700
X-CSE-ConnectionGUID: vMLQD+YDSFSOQ8N/406zjw==
X-CSE-MsgGUID: jaRNXvBoSaqs/NOHxJdOJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="169606943"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.106]) ([10.124.240.106])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 17:57:04 -0700
Message-ID: <c1076dbd-de63-4a9e-a097-de0f64c74a95@linux.intel.com>
Date: Tue, 5 Aug 2025 08:57:01 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] perf tools kvm: Use "cycles" to sample guest for "kvm
 top" on Intel
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kevin Tian <kevin.tian@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250805004633.135904-1-dapeng1.mi@linux.intel.com>
 <20250805004633.135904-6-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250805004633.135904-6-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/2025 8:46 AM, Dapeng Mi wrote:
> As same reason with previous patch, use "cyles" instead of "cycles:P"
> event by default to sample guest for "perf kvm top" command on Intel
> platforms.
>
> Reported-by: Kevin Tian <kevin.tian@intel.com>
> Fixes: 634d36f82517 ("perf record: Just use "cycles:P" as the default event")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/perf/builtin-kvm.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 7e48d2437710..d72b40f3df12 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -2075,6 +2075,34 @@ __cmd_buildid_list(const char *file_name, int argc, const char **argv)
>  	return ret;
>  }
>  
> +static int __cmd_top(int argc, const char **argv)
> +{
> +	int i = 0, ret;
> +	const char **rec_argv;
> +
> +	/*
> +	 * kvm_add_default_arch_event() may add 2 extra options, so
> +	 * allocate 2 more pointers in adavance.
> +	 */
> +	rec_argv = calloc(argc + 2 + 1, sizeof(char *));
> +	if (!rec_argv)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < argc; i++)
> +		rec_argv[i] = argv[i];
> +
> +	BUG_ON(i != argc);
> +
> +	ret = kvm_add_default_arch_event(&i, rec_argv);
> +	if (ret)
> +		return -EINVAL;
> +
> +	ret = cmd_top(i, rec_argv);
> +	free(rec_argv);
> +
> +	return ret;
> +}
> +
>  int cmd_kvm(int argc, const char **argv)
>  {
>  	const char *file_name = NULL;
> @@ -2135,7 +2163,7 @@ int cmd_kvm(int argc, const char **argv)
>  	else if (strlen(argv[0]) > 2 && strstarts("diff", argv[0]))
>  		return cmd_diff(argc, argv);
>  	else if (!strcmp(argv[0], "top"))
> -		return cmd_top(argc, argv);
> +		return __cmd_top(argc, argv);
>  	else if (strlen(argv[0]) > 2 && strstarts("buildid-list", argv[0]))
>  		return __cmd_buildid_list(file_name, argc, argv);
>  #if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)

This patch would impact powerpc platform as well. Base on the comments
before kvm_add_default_arch_event() in
tools/perf/arch/powerpc/util/kvm-stat.c, I suppose powerpc also needs this
change, otherwise "perf kvm top" command can't sample guest records. But I
have no any powerpc on my hand, so it's not tested on powerpc platform. Any
test on powerpc is appreciated. Thanks.


