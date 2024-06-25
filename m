Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E271494A0;
	Tue, 25 Jun 2024 11:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316657; cv=none; b=QpTTDV5RckuV29+nwNwqONEbtevwwykTQm+5AE9sDCwn9pldTGQh8kEsijRkcxltT/n/1/0cMw24v5VdDdkPI+MRpM0YSN0dUJLNM66KNmI4tmSGPY5kXlh34pMY276JLnvL6PzTZ+bJJ7sNDwwNQuiWRE120G01xaVIDfM8uI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316657; c=relaxed/simple;
	bh=jKW9BLNUQnfwbfWacy1aVQxluFCOuOGEj2zQf5otgCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NKsflMYhkJCxcg3NEtOef+igJlavl1I5mjRRYwXd25th/4/rMhIxBj3Cpmw7dD3bzJkPj7At5ZkQ1Kw42QN08FOmc+LQgh4EHPR9G4uK3dJouHWX4vJLVXaXN2+K5BNmLOk8VGCPZFYNKQx/9t7QAHOS3leUUjQ3RDPwWaNqWKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lze7NkFa; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lze7NkFa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719316656; x=1750852656;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jKW9BLNUQnfwbfWacy1aVQxluFCOuOGEj2zQf5otgCA=;
  b=Lze7NkFa4CIiyvDmt/4VkH1zMTFekaUiho4q4f5AnVonOvAL66fLAZPy
   ub89jhsplqGw9MKAu0fnaycsbIUbudLeFODVU5+wqDpZkAU483MO3bbJs
   YiamD0ZqAjaBnwz30InlBgZFbQXTFACThJ4DpRcfOqdzqz+8U64PZNZuW
   lNo3W+SHY2/gZGu/DVIEmWhYCoAhngmQ+jrqLj+DTynbLqH9sw9MuLiaS
   d+m15W/VX5NOr7kJT4kd+FB4iE3RcNUnG1QzjwiCfZcClvrZMbhYdUB7a
   zTTltwP8kCcKOoz/fzO/LAtyZgEXcEN+OOdQsAB1YhpKmQDX+BoeGc+Wm
   Q==;
X-CSE-ConnectionGUID: Mdn3M+4ESoSs8tYfflWphA==
X-CSE-MsgGUID: nmrEFHPBQrywSxUbo0wUMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="26918355"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="26918355"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 04:57:33 -0700
X-CSE-ConnectionGUID: HdcFkiyvTsKeE4i+TV3s4w==
X-CSE-MsgGUID: 0zxKiv0RThWkccTTHa1pCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="44335321"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.48.191])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 04:57:30 -0700
Message-ID: <722cb4bc-89d4-4e03-a80d-ffe05be52c05@intel.com>
Date: Tue, 25 Jun 2024 14:57:25 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/3] tools/perf: Fix the string match for
 "/tmp/perf-$PID.map" files in dso__load
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
 jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com, maddy@linux.ibm.com,
 kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
References: <20240623064850.83720-1-atrajeev@linux.vnet.ibm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240623064850.83720-1-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/06/24 09:48, Athira Rajeev wrote:
> Perf test for perf probe of function from different CU fails
> as below:
> 
> 	./perf test -vv "test perf probe of function from different CU"
> 	116: test perf probe of function from different CU:
> 	--- start ---
> 	test child forked, pid 2679
> 	Failed to find symbol foo in /tmp/perf-uprobe-different-cu-sh.Msa7iy89bx/testfile
> 	  Error: Failed to add events.
> 	--- Cleaning up ---
> 	"foo" does not hit any event.
> 	  Error: Failed to delete events.
> 	---- end(-1) ----
> 	116: test perf probe of function from different CU                   : FAILED!
> 
> The test does below to probe function "foo" :
> 
> 	# gcc -g -Og -flto -c /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-foo.c
> 	-o /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-foo.o
> 	# gcc -g -Og -c /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-main.c
> 	-o /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-main.o
> 	# gcc -g -Og -o /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile
> 	/tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-foo.o
> 	/tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-main.o
> 
> 	# ./perf probe -x /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile foo
> 	Failed to find symbol foo in /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile
> 	   Error: Failed to add events.
> 
> Perf probe fails to find symbol foo in the executable placed in
> /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7
> 
> Simple reproduce:
> 
>  # mktemp -d /tmp/perf-checkXXXXXXXXXX
>    /tmp/perf-checkcWpuLRQI8j
> 
>  # gcc -g -o test test.c
>  # cp test /tmp/perf-checkcWpuLRQI8j/
>  # nm /tmp/perf-checkcWpuLRQI8j/test | grep foo
>    00000000100006bc T foo
> 
>  # ./perf probe -x /tmp/perf-checkcWpuLRQI8j/test foo
>    Failed to find symbol foo in /tmp/perf-checkcWpuLRQI8j/test
>       Error: Failed to add events.
> 
> But it works with any files like /tmp/perf/test. Only for
> patterns with "/tmp/perf-", this fails.
> 
> Further debugging, commit 80d496be89ed ("perf report: Add support
> for profiling JIT generated code") added support for profiling JIT
> generated code. This patch handles dso's of form
> "/tmp/perf-$PID.map" .
> 
> The check used "if (strncmp(self->name, "/tmp/perf-", 10) == 0)"
> to match "/tmp/perf-$PID.map". With this commit, any dso in
> /tmp/perf- folder will be considered separately for processing
> (not only JIT created map files ). Fix this by changing the
> string pattern to check for "/tmp/perf-%d.map". Add a helper
> function is_perf_pid_map_name to do this check. In "struct dso",
> dso->long_name holds the long name of the dso file. Since the
> /tmp/perf-$PID.map check uses the complete name, use dso___long_name for
> the string name.
> 
> With the fix,
> 	# ./perf test "test perf probe of function from different CU"
> 	117: test perf probe of function from different CU                   : Ok
> 
> Signed-off-by: Athira Rajeev<atrajeev@linux.vnet.ibm.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Changelog:
> v3 -> v4:
> Added commit message with usage of dso__long_name
> 
> v2 -> v3:
> Addressed review comment from Adrian and James.
> Added perf_pid_map_tid to save the tid and modified
> is_perf_pid_map_name to use this internally.
> 
> v1 -> v2:
> Addressed review comments from Adrian.
> Added helper function is_perf_pid_map_name to check
> dso name of form "/tmp/perf-%d.map". Used sscanf
> instead of regex comparison.
> 
>  tools/perf/util/dso.c    | 12 ++++++++++++
>  tools/perf/util/dso.h    |  4 ++++
>  tools/perf/util/symbol.c |  3 ++-
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index dde706b71da7..2340c4f6d0c2 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1652,3 +1652,15 @@ int dso__strerror_load(struct dso *dso, char *buf, size_t buflen)
>  	scnprintf(buf, buflen, "%s", dso_load__error_str[idx]);
>  	return 0;
>  }
> +
> +bool perf_pid_map_tid(const char *dso_name, int *tid)
> +{
> +	return sscanf(dso_name, "/tmp/perf-%d.map", tid) == 1;
> +}
> +
> +bool is_perf_pid_map_name(const char *dso_name)
> +{
> +	int tid;
> +
> +	return perf_pid_map_tid(dso_name, &tid);
> +}
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index df2c98402af3..d72f3b8c37f6 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -809,4 +809,8 @@ void reset_fd_limit(void);
>  u64 dso__find_global_type(struct dso *dso, u64 addr);
>  u64 dso__findnew_global_type(struct dso *dso, u64 addr, u64 offset);
>  
> +/* Check if dso name is of format "/tmp/perf-%d.map" */
> +bool perf_pid_map_tid(const char *dso_name, int *tid);
> +bool is_perf_pid_map_name(const char *dso_name);
> +
>  #endif /* __PERF_DSO */
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 9e5940b5bc59..aee0a4cfb383 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1799,7 +1799,8 @@ int dso__load(struct dso *dso, struct map *map)
>  	const char *map_path = dso__long_name(dso);
>  
>  	mutex_lock(dso__lock(dso));
> -	perfmap = strncmp(dso__name(dso), "/tmp/perf-", 10) == 0;
> +	perfmap = is_perf_pid_map_name(map_path);
> +
>  	if (perfmap) {
>  		if (dso__nsinfo(dso) &&
>  		    (dso__find_perf_map(newmapname, sizeof(newmapname),

