Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2FA18E1D;
	Tue, 18 Jun 2024 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718694695; cv=none; b=pWvUgqvSJst3QcHNTfl3eA38L2NahA9IeUHV4m1u9Xyx/DzIT0JWjDNYuPAt4q39Jj9qN6PMfee0PrtyFeYa2oyCA+PQunC9np9q5JI8wL0exebG4hy9bWzYi28rES89dZqwTUeX9aKzLy2SCteLLHql78CfgUWxETHdSelSsGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718694695; c=relaxed/simple;
	bh=lgHzLDcHSlQnwaAoPxMtUeOJT0ovSIbIZaZ/EL3pzAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mskS+rqi5hrfR5mjJqZ9pHZv6jZLgIp1xWAx7hu49RILnCtLjTfn9r6Gji/TPf8skUpUXXu4b8i5UtpLpOvUPF60t23fe6KNMp3YCHQGDrKqrtP8adiE8WaVVjZlEwhcLVohrit0jymoUqxcDehc2N/2JbJflwWwMvoBqg2i+8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AUAOhj5w; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AUAOhj5w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718694694; x=1750230694;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lgHzLDcHSlQnwaAoPxMtUeOJT0ovSIbIZaZ/EL3pzAQ=;
  b=AUAOhj5wT1N0q7xiBkjlvlk1BvNd9MuXpgwTjb3nl3zu9YpSUJaodhO1
   NCEE99gfOO97Ltg1uqo6ipDseSTI9WomeatXGDW3S9JYpc4ATL46oQC4M
   zfJGKKt9lv+CeymdR/WXDcB/mi7XpMXXeCQDdFmIHcKutu+nVM6ldaU+5
   DpsQSwTyamnmLehdllQIZ6FACEodzBWl4Kuhdp1d0VaCyw2mgDPrbBKmI
   4r79ANPr8QlGRglaIJMgqNy8mOyTOo4TFg1ux9z2HTHwLixEdYJxlcE5W
   GjO7iSbohYsBrsR420Pdrvawyty/AH5ISdado8DoabqrGJ5VZPNvl6OmQ
   Q==;
X-CSE-ConnectionGUID: ACVU3gWqRjiR6Av45B8WkA==
X-CSE-MsgGUID: cMo7YYDjQTmkM8AcVUKHSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15383946"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15383946"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 00:11:34 -0700
X-CSE-ConnectionGUID: m7SlF0XsT4KOAL4r672Ryg==
X-CSE-MsgGUID: 7rN+29qISE2/Fou/uTtzTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="42135733"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 00:11:29 -0700
Message-ID: <223d1e96-223f-4bda-8133-806a3aa61730@intel.com>
Date: Tue, 18 Jun 2024 10:11:25 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/3] tools/perf: Use is_perf_pid_map_name helper
 function to check dso's of pattern /tmp/perf-%d.map
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
 jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com, maddy@linux.ibm.com,
 kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
References: <20240617130332.13427-1-atrajeev@linux.vnet.ibm.com>
 <20240617130332.13427-2-atrajeev@linux.vnet.ibm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240617130332.13427-2-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/06/24 16:03, Athira Rajeev wrote:
> commit 80d496be89ed ("perf report: Add support for profiling JIT
> generated code") added support for profiling JIT generated code.
> This patch handles dso's of form "/tmp/perf-$PID.map".
> 
> Some of the references doesn't check exactly for same pattern.
> some uses "if (!strncmp(dso_name, "/tmp/perf-", 10))". Fix
> this by using helper function is_perf_pid_map_name which looks
> for proper pattern of form: "/tmp/perf-$PID.map" for these checks.
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/util/dsos.c    | 2 +-
>  tools/perf/util/srcline.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> index ab3d0c01dd63..23cd02aa701d 100644
> --- a/tools/perf/util/dsos.c
> +++ b/tools/perf/util/dsos.c
> @@ -275,7 +275,7 @@ static void dso__set_basename(struct dso *dso)
>  	char *base, *lname;
>  	int tid;
>  
> -	if (sscanf(dso__long_name(dso), "/tmp/perf-%d.map", &tid) == 1) {
> +	if (is_perf_pid_map_name(dso__long_name(dso))) {

Perhaps add another helper for this case:

bool perf_pid_map_tid(const char *dso_name, int *tid)
{
	return sscanf(dso_name, "/tmp/perf-%d.map", &tid) == 1;
}

bool is_perf_pid_map_name(const char *dso_name)
{
	int tid;

	return perf_pid_map_tid(dso_name, &tid);
}

And then:

	if (perf_pid_map_tid(dso__long_name(dso), &tid)) {



>  		if (asprintf(&base, "[JIT] tid %d", tid) < 0)
>  			return;
>  	} else {
> diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
> index 9d670d8c1c08..51eb78993fe2 100644
> --- a/tools/perf/util/srcline.c
> +++ b/tools/perf/util/srcline.c
> @@ -39,7 +39,7 @@ static const char *srcline_dso_name(struct dso *dso)
>  	if (dso_name[0] == '[')
>  		return NULL;
>  
> -	if (!strncmp(dso_name, "/tmp/perf-", 10))
> +	if (is_perf_pid_map_name(dso_name))
>  		return NULL;
>  
>  	return dso_name;

